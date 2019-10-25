Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC076206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437618AbfJYICd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:02:33 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51757 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437508AbfJYICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:02:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tg8vqiB_1571990545;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0Tg8vqiB_1571990545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 16:02:29 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH] zswap: Add shrink_enabled that can disable swap shrink to increase store performance
Date:   Fri, 25 Oct 2019 16:02:18 +0800
Message-Id: <1571990538-6133-1-git-send-email-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap will try to shrink pool when zswap is full.
This commit add shrink_enabled that can disable swap shrink to increase
store performance.  User can disable swap shrink if care about the store
performance.

For example in a VM with 1 CPU 1G memory 4G swap:
echo lz4 > /sys/module/zswap/parameters/compressor
echo z3fold > /sys/module/zswap/parameters/zpool
echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
echo 1 > /sys/module/zswap/parameters/enabled
usemem -a -n 1 $((4000 * 1024 * 1024))
4718592000 bytes / 114937822 usecs = 40091 KB/s
101700 usecs to free memory
echo 0 > /sys/module/zswap/parameters/shrink_enabled
usemem -a -n 1 $((4000 * 1024 * 1024))
4718592000 bytes / 8837320 usecs = 521425 KB/s
129577 usecs to free memory

The store speed increased when zswap shrink disabled.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/zswap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 46a3223..731e3d1e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -114,6 +114,10 @@ static bool zswap_same_filled_pages_enabled = true;
 module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
 		   bool, 0644);
 
+/* Enable/disable zswap shrink (enabled by default) */
+static bool zswap_shrink_enabled = true;
+module_param_named(shrink_enabled, zswap_shrink_enabled, bool, 0644);
+
 /*********************************
 * data structures
 **********************************/
@@ -947,6 +951,9 @@ static int zswap_shrink(void)
 	struct zswap_pool *pool;
 	int ret;
 
+	if (!zswap_shrink_enabled)
+		return -EPERM;
+
 	pool = zswap_pool_last_get();
 	if (!pool)
 		return -ENOENT;
-- 
2.7.4

