Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ABBC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1320859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfE0MaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:30:02 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:49454 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0MaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:30:01 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id HQVz2000N3XaVaC01QVzBV; Mon, 27 May 2019 14:29:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVElL-0001Us-KK; Mon, 27 May 2019 14:29:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVElL-0001kN-HZ; Mon, 27 May 2019 14:29:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] cpumask: Remove error message and backtrace on out-of-memory condition
Date:   Mon, 27 May 2019 14:29:58 +0200
Message-Id: <20190527122958.6667-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to print an error message and backtrace if
kmalloc_node() fails, as the memory allocation core already takes care
of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/cpumask.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 0cb672eb107cef6e..61d85343dd50e61d 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -114,13 +114,6 @@ bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 {
 	*mask = kmalloc_node(cpumask_size(), flags, node);
 
-#ifdef CONFIG_DEBUG_PER_CPU_MAPS
-	if (!*mask) {
-		printk(KERN_ERR "=> alloc_cpumask_var: failed!\n");
-		dump_stack();
-	}
-#endif
-
 	return *mask != NULL;
 }
 EXPORT_SYMBOL(alloc_cpumask_var_node);
-- 
2.17.1

