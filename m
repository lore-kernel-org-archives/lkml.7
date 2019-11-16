Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB62C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7985B20700
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573918952;
	bh=1AEe6262HdcOwAQh2tB2daek/J3BYWc1JBiEqovCau0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rIsQ1e/DsfQpMsk43orVC0h6sm9127ix8nnVJpLWz08pufGaR4Ad47LytjesqtZOA
	 WaYYh2mZ2ity4e5FOh9fOwHZNACECM7FXlE0Pm1+qAjSsD5uKuOJnZM9v8cWj1RjA8
	 IiFuOpwvD405ewa1OMC1RSb6cv7yaQ9Hr/dlb2s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfKPPmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfKPPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:28 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FF120862;
        Sat, 16 Nov 2019 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918947;
        bh=1AEe6262HdcOwAQh2tB2daek/J3BYWc1JBiEqovCau0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdia8rTMfu193BXbZ2S6Ta4gYRCgTMDZMHgOF8TranHZ6X9ISAnK6TCAkoAumDw0I
         D18ty/t6Fc0LnQ/MPtj09QrB/JVGP/OmXwEduMG3gUr0TCxmUC5o0IWrFhm4mw+tcz
         dJni9hE843HpcGKDH+oL09qjXdYq+aYArgC8T3Ck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 069/237] xfs: fix use-after-free race in xfs_buf_rele
Date:   Sat, 16 Nov 2019 10:38:24 -0500
Message-Id: <20191116154113.7417-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 37fd1678245f7a5898c1b05128bc481fb403c290 ]

When looking at a 4.18 based KASAN use after free report, I noticed
that racing xfs_buf_rele() may race on dropping the last reference
to the buffer and taking the buffer lock. This was the symptom
displayed by the KASAN report, but the actual issue that was
reported had already been fixed in 4.19-rc1 by commit e339dd8d8b04
("xfs: use sync buffer I/O for sync delwri queue submission").

Despite this, I think there is still an issue with xfs_buf_rele()
in this code:

        release = atomic_dec_and_lock(&bp->b_hold, &pag->pag_buf_lock);
        spin_lock(&bp->b_lock);
        if (!release) {
.....

If two threads race on the b_lock after both dropping a reference
and one getting dropping the last reference so release = true, we
end up with:

CPU 0				CPU 1
atomic_dec_and_lock()
				atomic_dec_and_lock()
				spin_lock(&bp->b_lock)
spin_lock(&bp->b_lock)
<spins>
				<release = true bp->b_lru_ref = 0>
				<remove from lists>
				freebuf = true
				spin_unlock(&bp->b_lock)
				xfs_buf_free(bp)
<gets lock, reading and writing freed memory>
<accesses freed memory>
spin_unlock(&bp->b_lock) <reads/writes freed memory>

IOWs, we can't safely take bp->b_lock after dropping the hold
reference because the buffer may go away at any time after we
drop that reference. However, this can be fixed simply by taking the
bp->b_lock before we drop the reference.

It is safe to nest the pag_buf_lock inside bp->b_lock as the
pag_buf_lock is only used to serialise against lookup in
xfs_buf_find() and no other locks are held over or under the
pag_buf_lock there. Make this clear by documenting the buffer lock
orders at the top of the file.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e839907e8492f..f4a89c94c931b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -37,6 +37,32 @@ static kmem_zone_t *xfs_buf_zone;
 #define xb_to_gfp(flags) \
 	((((flags) & XBF_READ_AHEAD) ? __GFP_NORETRY : GFP_NOFS) | __GFP_NOWARN)
 
+/*
+ * Locking orders
+ *
+ * xfs_buf_ioacct_inc:
+ * xfs_buf_ioacct_dec:
+ *	b_sema (caller holds)
+ *	  b_lock
+ *
+ * xfs_buf_stale:
+ *	b_sema (caller holds)
+ *	  b_lock
+ *	    lru_lock
+ *
+ * xfs_buf_rele:
+ *	b_lock
+ *	  pag_buf_lock
+ *	    lru_lock
+ *
+ * xfs_buftarg_wait_rele
+ *	lru_lock
+ *	  b_lock (trylock due to inversion)
+ *
+ * xfs_buftarg_isolate
+ *	lru_lock
+ *	  b_lock (trylock due to inversion)
+ */
 
 static inline int
 xfs_buf_is_vmapped(
@@ -1006,8 +1032,18 @@ xfs_buf_rele(
 
 	ASSERT(atomic_read(&bp->b_hold) > 0);
 
-	release = atomic_dec_and_lock(&bp->b_hold, &pag->pag_buf_lock);
+	/*
+	 * We grab the b_lock here first to serialise racing xfs_buf_rele()
+	 * calls. The pag_buf_lock being taken on the last reference only
+	 * serialises against racing lookups in xfs_buf_find(). IOWs, the second
+	 * to last reference we drop here is not serialised against the last
+	 * reference until we take bp->b_lock. Hence if we don't grab b_lock
+	 * first, the last "release" reference can win the race to the lock and
+	 * free the buffer before the second-to-last reference is processed,
+	 * leading to a use-after-free scenario.
+	 */
 	spin_lock(&bp->b_lock);
+	release = atomic_dec_and_lock(&bp->b_hold, &pag->pag_buf_lock);
 	if (!release) {
 		/*
 		 * Drop the in-flight state if the buffer is already on the LRU
-- 
2.20.1

