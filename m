Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AF420850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 02:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfDMCN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 22:13:28 -0400
Received: from mail1.windriver.com ([147.11.146.13]:63004 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDMCN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 22:13:28 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x3D2CqGG003922
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 12 Apr 2019 19:12:52 -0700 (PDT)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Fri, 12 Apr 2019
 19:12:51 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] printk: tie printk_once / printk_deferred_once into .data.once for reset
Date:   Fri, 12 Apr 2019 22:11:31 -0400
Message-ID: <1555121491-31213-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit b1fca27d384e ("kernel debug: support resetting WARN*_ONCE")
we got the opportunity to reset state on the one shot messages,
without having to reboot.

However printk_once (printk_deferred_once) live in a different file
and didn't get the same kind of update/conversion, so they remain
unconditionally one shot, until the system is rebooted.

For example, we currently have:

  sched/rt.c: printk_deferred_once("sched: RT throttling activated\n");

..which could reasonably be tripped as someone is testing and tuning
a new system/workload and their task placements.  For consistency, and
to avoid reboots in the same vein as the original commit, we make these
two instances of _once the same as the WARN*_ONCE instances are.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/clearing-warn-once.txt | 2 +-
 include/linux/printk.h               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/clearing-warn-once.txt b/Documentation/clearing-warn-once.txt
index 5b1f5d547be1..c68598b31428 100644
--- a/Documentation/clearing-warn-once.txt
+++ b/Documentation/clearing-warn-once.txt
@@ -1,5 +1,5 @@
 
-WARN_ONCE / WARN_ON_ONCE only print a warning once.
+WARN_ONCE / WARN_ON_ONCE / printk_once only emit a message once.
 
 echo 1 > /sys/kernel/debug/clear_warn_once
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index d7c77ed1a4cb..84ea4d094af3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -347,7 +347,7 @@ extern int kptr_restrict;
 #ifdef CONFIG_PRINTK
 #define printk_once(fmt, ...)					\
 ({								\
-	static bool __print_once __read_mostly;			\
+	static bool __section(.data.once) __print_once;		\
 	bool __ret_print_once = !__print_once;			\
 								\
 	if (!__print_once) {					\
@@ -358,7 +358,7 @@ extern int kptr_restrict;
 })
 #define printk_deferred_once(fmt, ...)				\
 ({								\
-	static bool __print_once __read_mostly;			\
+	static bool __section(.data.once) __print_once;		\
 	bool __ret_print_once = !__print_once;			\
 								\
 	if (!__print_once) {					\
-- 
2.7.4

