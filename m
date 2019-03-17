Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC26C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D12B20872
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCQS6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:58:17 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39396 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQS6Q (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Sun, 17 Mar 2019 14:58:16 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Sun, 17 Mar 2019 19:58:15 +0100
Received: from localhost.localdomain (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Sun, 17 Mar 2019 18:58:05 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST
Date:   Sun, 17 Mar 2019 11:54:34 -0700
Message-Id: <20190317185434.1626-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a lot more appropriate than PI_LIST, which in the kernel
one would assume that it has to do with priority-inheritance;
which is not -- furthermore futexes make use of plists so this
can be even more confusing, albeit the debug nature of the config
option.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/plist.h | 4 ++--
 lib/Kconfig.debug     | 2 +-
 lib/plist.c           | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/plist.h b/include/linux/plist.h
index 97883604a3c5..9365df5a823f 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -231,7 +231,7 @@ static inline int plist_node_empty(const struct plist_node *node)
  * @type:	the type of the struct this is embedded in
  * @member:	the name of the list_head within the struct
  */
-#ifdef CONFIG_DEBUG_PI_LIST
+#ifdef CONFIG_DEBUG_PLIST
 # define plist_first_entry(head, type, member)	\
 ({ \
 	WARN_ON(plist_head_empty(head)); \
@@ -248,7 +248,7 @@ static inline int plist_node_empty(const struct plist_node *node)
  * @type:	the type of the struct this is embedded in
  * @member:	the name of the list_head within the struct
  */
-#ifdef CONFIG_DEBUG_PI_LIST
+#ifdef CONFIG_DEBUG_PLIST
 # define plist_last_entry(head, type, member)	\
 ({ \
 	WARN_ON(plist_head_empty(head)); \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..ccb89aeb227c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1350,7 +1350,7 @@ config DEBUG_LIST
 
 	  If unsure, say N.
 
-config DEBUG_PI_LIST
+config DEBUG_PLIST
 	bool "Debug priority linked list manipulation"
 	depends on DEBUG_KERNEL
 	help
diff --git a/lib/plist.c b/lib/plist.c
index 199408f91057..d3bd8827186f 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -26,7 +26,7 @@
 #include <linux/bug.h>
 #include <linux/plist.h>
 
-#ifdef CONFIG_DEBUG_PI_LIST
+#ifdef CONFIG_DEBUG_PLIST
 
 static struct plist_head test_head;
 
@@ -173,7 +173,7 @@ void plist_requeue(struct plist_node *node, struct plist_head *head)
 	plist_check_head(head);
 }
 
-#ifdef CONFIG_DEBUG_PI_LIST
+#ifdef CONFIG_DEBUG_PLIST
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/module.h>
-- 
2.16.4

