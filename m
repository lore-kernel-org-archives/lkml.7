Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C10C33C9A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641D22068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402401;
	bh=6N6utb28xFcbw1WnBmmazrCLf9h//ber+CLlhqfmkag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdxCsY4w5AqFes0Irenac3LRSo8BAI2ecU0QbZUoLLOq3h3WYoxiz/bLGQ0aNJj6Q
	 z4cHwFSvT1okTu9IGM1QvXZBg341pXhQxXc235XZPa4GF9stTIsHYZVaR44rXlT+Vz
	 L0I5olm7odkvNWOUQRMYGA5QHGS3eKbW9agwC0Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfKVF5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfKVF5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3E820854;
        Fri, 22 Nov 2019 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402252;
        bh=6N6utb28xFcbw1WnBmmazrCLf9h//ber+CLlhqfmkag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykaM0gdtxFGS7b+CHkAx1XEn1nERalQ0fcPHIwPYtMroxtzIQJ3JMj3Jbq/c8dXFV
         qmhwtCEjTVmwWBftN0p5YniJVuALq47UtRtZ0U3iEfecVlnx3F9Bxyy+LORphHF2lt
         QzJB+fQoDwQQUHhdDFGJLWrt9vzmR73ks6AW+dW0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 094/127] lib/genalloc.c: use vzalloc_node() to allocate the bitmap
Date:   Fri, 22 Nov 2019 00:55:12 -0500
Message-Id: <20191122055544.3299-93-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Shijie <sjhuang@iluvatar.ai>

[ Upstream commit 6862d2fc81859f88c1f3f660886427893f2b4f3f ]

Some devices may have big memory on chip, such as over 1G.  In some
cases, the nbytes maybe bigger then 4M which is the bounday of the
memory buddy system (4K default).

So use vzalloc_node() to allocate the bitmap.  Also use vfree to free
it.

Link: http://lkml.kernel.org/r/20181225015701.6289-1-sjhuang@iluvatar.ai
Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Skidanov <alexey.skidanov@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/genalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 5deb25c40a5a1..f365d71cdc774 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -187,7 +187,7 @@ int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phy
 	int nbytes = sizeof(struct gen_pool_chunk) +
 				BITS_TO_LONGS(nbits) * sizeof(long);
 
-	chunk = kzalloc_node(nbytes, GFP_KERNEL, nid);
+	chunk = vzalloc_node(nbytes, nid);
 	if (unlikely(chunk == NULL))
 		return -ENOMEM;
 
@@ -251,7 +251,7 @@ void gen_pool_destroy(struct gen_pool *pool)
 		bit = find_next_bit(chunk->bits, end_bit, 0);
 		BUG_ON(bit < end_bit);
 
-		kfree(chunk);
+		vfree(chunk);
 	}
 	kfree_const(pool->name);
 	kfree(pool);
-- 
2.20.1

