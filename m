Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DC20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfCGFUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:20:40 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37160 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfCGFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:20:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TM9p0ws_1551935730;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TM9p0ws_1551935730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Mar 2019 13:15:41 +0800
From:   shile.zhang@linux.alibaba.com
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH] bcache: add cond_resched() in __bch_cache_cmp()
Date:   Thu,  7 Mar 2019 13:15:28 +0800
Message-Id: <1551935728-243664-1-git-send-email-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shile Zhang <shile.zhang@linux.alibaba.com>

Read /sys/fs/bcache/<uuid>/cacheN/priority_stats can take very long
time with huge cache after long run.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 drivers/md/bcache/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 557a8a3..028fea1 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -897,6 +897,7 @@ static void bch_cache_set_internal_release(struct kobject *k)
 
 static int __bch_cache_cmp(const void *l, const void *r)
 {
+	cond_resched();
 	return *((uint16_t *)r) - *((uint16_t *)l);
 }
 
-- 
1.8.3.1

