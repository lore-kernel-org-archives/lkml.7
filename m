Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C41AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046C92184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCUsHJx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfCTGib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:38:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42486 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfCTGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:38:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so1019206pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 23:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=AF5hfBuiGsRcBiZ0vVXmEUTffuz50KgXcl2b8eIbr7w=;
        b=FCUsHJx1eBZpUUT6STWDj+JbjRhgpATZl1w+NGMKoeSRiw4geadmiD+W8x8zr1jHO7
         xTBfegsc5gVAdA56p0pIcwbuWosfu1eioltjS8l4eMNgdOt9X/m71piu+vrW5rMwjg6s
         TiNKI72P1O0tQjdtqhHQ8pDFF6pqZCyYMpVC/Dgpi7ufmy9C/Y+UTnp/AFfekuuGN6xi
         33gRQ89wEdMjzSwPKynQEowr2zxelyoqbLX1fcHLxTt4lfEwEMNwa9YyOdgGUfXWPg0e
         cYhkCfdKWcEM+cJg35PFetGf/QS6sJbu0c1iGfcDNIYEsV2km/v0xrh1hYKHDVGOyyIp
         t9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=AF5hfBuiGsRcBiZ0vVXmEUTffuz50KgXcl2b8eIbr7w=;
        b=No+pgRBxl5Ce2lXTDI1eJI0Ry0jcFjDZCXjQYW0R2zhBxjPhkG+YzftFTyE7XDb2SC
         FqTT4ayRCrt08HYJH9timuCSKM+XolzF2gC0kK3j58E3f9264g20fBcKLab0dcNs+eY2
         afS8AGc7GHQFGstsRnetyi1AlJ8s4WmofCMHp40yI0MwnVS+oPg5VxIbWvjhV4y3XkFq
         jJhC6ocO9rVGLd4cnBe3sIKjZxZqMvVAf7046VC5Ibp2MNx8BlyyqtWU87ODvQzw2qjb
         YDwLCshyFVc0KTnFIvF7lpvH4nRf4H3ZtF0pDj8Z2bNvFKmTc/iTPa1ght5gGukzsE+X
         2YYw==
X-Gm-Message-State: APjAAAXtYm8JsxzalMYKX0pJES9fDv39mo27MNvAsFUvL3OiOSLWYokK
        fKSJhCAIEXQB7JvqUcwWD5w=
X-Google-Smtp-Source: APXvYqzUQNa49xRlgEPPoe1oyIw2XEH6d4Tqm2tgL/srpdSqXkWrPwVznfQ4b/i5YVdHmqBtuQoeAQ==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr6149664plr.97.1553063910721;
        Tue, 19 Mar 2019 23:38:30 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n15sm2787376pgc.92.2019.03.19.23.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 23:38:29 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     devel@driverdev.osuosl.org (open list:ANDROID ION DRIVER),
        dri-devel@lists.freedesktop.org (open list:ANDROID ION DRIVER),
        linaro-mm-sig@lists.linaro.org (moderated list:ANDROID ION DRIVER),
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver : staging : ion: optimization for decreasing memory fragmentaion
Date:   Wed, 20 Mar 2019 14:38:23 +0800
Message-Id: <1553063903-26768-1-git-send-email-huangzhaoyang@gmail.com>
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
 drivers/staging/android/ion/ion_heap.c        | 16 +++++++++++++++-
 drivers/staging/android/ion/ion_system_heap.c |  2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 31db510..0c8d696 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -16,6 +16,8 @@
 #include <linux/vmalloc.h>
 #include "ion.h"
 
+static unsigned long ion_heap_batch;
+
 void *ion_heap_map_kernel(struct ion_heap *heap,
 			  struct ion_buffer *buffer)
 {
@@ -303,7 +305,19 @@ int ion_heap_init_shrinker(struct ion_heap *heap)
 	heap->shrinker.count_objects = ion_heap_shrink_count;
 	heap->shrinker.scan_objects = ion_heap_shrink_scan;
 	heap->shrinker.seeks = DEFAULT_SEEKS;
-	heap->shrinker.batch = 0;
+	heap->shrinker.batch = ion_heap_batch;
 
 	return register_shrinker(&heap->shrinker);
 }
+
+/*
+ * configuring ion_heap_batch as 3 times of the pool's peak value can help
+ * improving allocation speed
+ */
+static int __init ion_system_heap_batch_init(char *arg)
+{
+	ion_heap_batch = memparse(arg, NULL);
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

