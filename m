Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC2DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD3E2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg0Upq0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfCNLGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:06:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41469 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfCNLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:06:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so3719247pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=dDpta30jYLNKF7mHLIZXQMhcyv7dkmDy6qiilMUlgNY=;
        b=qg0Upq0jLvULMOwFu0QqrcExCbpgeGAFck4cpAGMfSMae4olbUVvqFGX5H6rszL0GD
         Eazcbr7+WWVwiMyzT4KGFo6wy/qGb0u9hRkoQ8AHdtafW5yAo5C3pBPvPdQM6kvECJrp
         ihbUYEWyUyWywmlbPwPcbWFv134JPlxjhB6sdEW1QRKxESzUuIiPkdoaf1yJEdKjgdo7
         nHqcLC+biYyG7xdFsW2DiApSE8lFh/Lzk3+H8EENXT4Xp3PKSWwAzHv3fTOw9effgiKV
         jEoPbz7kXu0+19S+GVOO0SugxanKeeF4putCQGQLQwZ04L4kHYnaEt+8rut9NQEFNKQ3
         oslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=dDpta30jYLNKF7mHLIZXQMhcyv7dkmDy6qiilMUlgNY=;
        b=tjmwFKA1oFA9+lvMpmPoYgrC+2V2BHTExb/8F9NAEVs0DWet6kzASD75/kBwOL9doQ
         RrZZNnt7qaDHNRMaBUrw4yplicuRntUJIiRavLjwTrKm068f5Wkfxu2YT+vfYj7+hiHh
         jzVJo/iArYcfRLRXWwG2rQA9KDbILSiShHs3geSwkAiHGF3bRdxpu5HqTYzuXqRCA8jR
         CUtVHxp4fstQ04XVroeQnylMfG4soE29eClX+JHeIeoT/c7rLbKn6/87Vt3OoD2wkAA1
         gaIfb9ktAWLVCe8lb8U1hlmh4STEwt979zYGPXkbT6E2WWpwrmJRUNhPP/ch3ef5x5IU
         xYMA==
X-Gm-Message-State: APjAAAUoGoF9hVzxQgF5YIVpVkIAK4RscE+gwzovlnV7o+PnD655KFyq
        spkGsCj/9sqKpu3Bz12l3O8=
X-Google-Smtp-Source: APXvYqy4RS+bxR506y0XuvByBPnIl58NXLP8IhUhzOa/Zpg3bff6IB+yfFHI8pYokkVNxk/1Z81FKw==
X-Received: by 2002:a65:4549:: with SMTP id x9mr45326928pgr.3.1552561607767;
        Thu, 14 Mar 2019 04:06:47 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g12sm14364692pfd.72.2019.03.14.04.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 04:06:47 -0700 (PDT)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     Chintan Pandya <cpandya@codeaurora.org>,
        David Rientjes <rientjes@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver : staging : ion: optimization for decreasing memory fragmentaion
Date:   Thu, 14 Mar 2019 19:06:39 +0800
Message-Id: <1552561599-23662-1-git-send-email-huangzhaoyang@gmail.com>
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
index 31db510..9e9caf2 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -16,6 +16,8 @@
 #include <linux/vmalloc.h>
 #include "ion.h"
 
+unsigned long ion_heap_batch = 0;
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

