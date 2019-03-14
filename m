Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BCCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6192087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roF3VzBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCNLMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:12:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35173 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCNLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:12:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id e17so3751385pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=n4HxxiwAlFlhYdr+5LtCpPNTbZpyj8J+lBCYFMhyfbY=;
        b=roF3VzBjrTyogMB4us1/EsA/Dq4OBYl+TaF+eOCuBLQVH8XeGPaXxaAD1Td7hqPfoK
         LBDL2hte6Ck6pioefoqCurbnoloOrxvPVRA5SFL0tIs+aCiCNuGE1FM74gozRGQZMRul
         53AvQ8XLfcuPCr60Vo+C2OCmxRmbUEIRk/F9cUVM6efhLHPhawZ2GQ5rU+mYOX3QTVI0
         xDKA6swaB6/uIDaVzvOup2HuROIX0TnUs/0n1ZKNpwwDsVzhI2mo6LjLaeeGcTzTZ+Zk
         8+AonY4iohLVAzLN3EvugsBccsD6tN3LwmggZQTuqkqqSf8K/z46Xufj9g6/Ee2pPmvp
         9oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=n4HxxiwAlFlhYdr+5LtCpPNTbZpyj8J+lBCYFMhyfbY=;
        b=V4WkntqCWYD2ySLdJE0Pa05kcViJnqQGRwEVED3ffo4K4zh/Yez8Yi8k7HRth3yTsN
         cT9QB41h9/jpjBvMWHOS0G7J+60w3JkiZwg4U+biSBaKEWCInWeaTADA1o/wQv8dlXbG
         1OT0U7EXTWpyN8JNxcjdPRxvl0CeUfhWA60ppUI7+628Lr/9u+r/tWNuRxbhOjYqGEcd
         clSWtTPZOTtAqMsbJLfQkcgz85VUOk9qr4Om4GVJD43rPNg+wwGBThnJHP1jox/Jq+tx
         NHrKRU6uKWMAJ5Qex4F3LN7JyR9vMMZ5m/LUP0SXcnbQsKAOMZNDRbiqnrO+A4UqCNd+
         22lA==
X-Gm-Message-State: APjAAAUv5i0+bUPXXkk7ao25x3Op1R/Km/ePfhlYTjht9ao7ZAU2Ug5T
        HTX+I/EWCo0MubpzKsrXQv0=
X-Google-Smtp-Source: APXvYqxgGoNRfjnUZsQWx4drOGx00xoiXr7fHElYupWHFek9O3YWWuv8jqhL/GfJUxtX1Kd84mQCrw==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr44137753pgv.158.1552561938862;
        Thu, 14 Mar 2019 04:12:18 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 20sm34946592pfs.182.2019.03.14.04.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 04:12:18 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     devel@driverdev.osuosl.org (open list:ANDROID ION DRIVER),
        dri-devel@lists.freedesktop.org (open list:ANDROID ION DRIVER),
        linaro-mm-sig@lists.linaro.org (moderated list:ANDROID ION DRIVER),
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver : staging : ion: optimization for decreasing memory fragmentaion
Date:   Thu, 14 Mar 2019 19:12:12 +0800
Message-Id: <1552561932-23776-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Two action for this patch:
1. set a batch size for system heap's shrinker, which can have it buffer
reasonable page blocks in pool for future allocation.
2. reverse the order sequence when free page blocks, the purpose is also
to have system heap keep as more big blocks as it can.

By testing on an android system with 2G RAM, the changes with setting
batch = 48MB can help reduce the fragmentation obviously and improve
big block allocation speed for 15%.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/staging/android/ion/ion_heap.c        | 12 +++++++++++-
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 31db510..68aa970 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -16,6 +16,8 @@
 #include <linux/vmalloc.h>
 #include "ion.h"
 
+unsigned long ion_heap_batch;
+
 void *ion_heap_map_kernel(struct ion_heap *heap,
 			  struct ion_buffer *buffer)
 {
@@ -303,7 +305,15 @@ int ion_heap_init_shrinker(struct ion_heap *heap)
 	heap->shrinker.count_objects = ion_heap_shrink_count;
 	heap->shrinker.scan_objects = ion_heap_shrink_scan;
 	heap->shrinker.seeks = DEFAULT_SEEKS;
-	heap->shrinker.batch = 0;
+	heap->shrinker.batch = ion_heap_batch;
 
 	return register_shrinker(&heap->shrinker);
 }
+
+static int __init ion_system_heap_batch_init(char *arg)
+{
+	 ion_heap_batch = memparse(arg, NULL);
+
+	return 0;
+}
+early_param("ion_batch", ion_system_heap_batch_init);
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index 701eb9f..d249f8d 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -182,7 +182,7 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
 	if (!nr_to_scan)
 		only_scan = 1;
 
-	for (i = 0; i < NUM_ORDERS; i++) {
+	for (i = NUM_ORDERS - 1; i >= 0; i--) {
 		pool = sys_heap->pools[i];
 
 		if (only_scan) {
-- 
1.9.1

