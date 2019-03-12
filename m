Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413563;
	bh=2ddWb6nN4SwCa4+bDUyaiOY3bgfooQU8Th5bk9InRqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OhLhigiupGvDUtYM/aBKfudBMmtvJh4BC2/DJPAa3AMTJKLsMOulVHtMx6Jovvtiu
	 QuOzj1RU/ahdlKmzgYaMdY7wbecPjkRyWoAK4NySghnRBKakADcQz0lpJKfZMIO8eV
	 XQzLL3nkNc43UaVpaTugFs5K3JLisOFPnr9t0824=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfCLR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfCLRNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8035217F5;
        Tue, 12 Mar 2019 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410813;
        bh=2ddWb6nN4SwCa4+bDUyaiOY3bgfooQU8Th5bk9InRqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9kQWUqmQsgSuAXz78/p2goTCcXg2Cc87pseT8DXIsIrrxJ/nJ6e9CJbZ1hLh5RFi
         GTxovtDO00zmeboYk/8aTMNMYtSPfkl8kBR/gxAnsJr+qfbOhbr67mQ1p368EHDQTH
         uAezAE2s97Zugig2v9Z0ydmywRReGZldl/8X0YcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Syms <mark.syms@citrix.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.20 165/171] gfs2: Fix missed wakeups in find_insert_glock
Date:   Tue, 12 Mar 2019 10:09:05 -0700
Message-Id: <20190312170401.640154262@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 605b0487f0bc1ae9963bf52ece0f5c8055186f81 upstream.

Mark Syms has reported seeing tasks that are stuck waiting in
find_insert_glock.  It turns out that struct lm_lockname contains four padding
bytes on 64-bit architectures that function glock_waitqueue doesn't skip when
hashing the glock name.  As a result, we can end up waking up the wrong
waitqueue, and the waiting tasks may be stuck forever.

Fix that by using ht_parms.key_len instead of sizeof(struct lm_lockname) for
the key length.

Reported-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/glock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -107,7 +107,7 @@ static int glock_wake_function(wait_queu
 
 static wait_queue_head_t *glock_waitqueue(struct lm_lockname *name)
 {
-	u32 hash = jhash2((u32 *)name, sizeof(*name) / 4, 0);
+	u32 hash = jhash2((u32 *)name, ht_parms.key_len / 4, 0);
 
 	return glock_wait_table + hash_32(hash, GLOCK_WAIT_TABLE_BITS);
 }


