Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331E20833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482376;
	bh=sadsCLSkfQewsBhR0p+TkkxkWdvvoH2esadazE9u5Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZvV014o4BaXEcUCNvf/j/xxlPqSJfZpACgbsqHQvjXaoH/5BwZuu03GhqBolRA1E
	 WMiEVMSCFyPtWigf6+GYc9EuNDDQEV/raiCRv7vRFGbPIXBE94+V4alIh5/9iBMOw4
	 Cd7osMA++OYFdtJ5O36FZAok12hlHVt93fm+mcf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfLDR7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbfLDR7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:59:30 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE51B20863;
        Wed,  4 Dec 2019 17:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482370;
        bh=sadsCLSkfQewsBhR0p+TkkxkWdvvoH2esadazE9u5Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yXuMa7MTmBO6Qm1K3cCP18nuY3nMEWyAlRN+nelhjcbtt4n9kBdcWqiqVEAkLn504
         UGV85pYadqxiTUud2oCp/CarIuJZZxfyWvAgOdy1Zoke4Q/7bY6Jvpp7eZorGQNPU7
         +sW/1nPPTUC4Xvq+3/BWRXyRmxhUF7qhXCfXo0kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 60/92] lib/genalloc.c: use vzalloc_node() to allocate the bitmap
Date:   Wed,  4 Dec 2019 18:50:00 +0100
Message-Id: <20191204174333.997173869@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index e4303fb2a7b28..38764572ddde8 100644
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



