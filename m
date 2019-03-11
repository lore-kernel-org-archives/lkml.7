Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBE4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136A0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCKLzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:55:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56817 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfCKLzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:55:46 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 3699321361d7e55d; Mon, 11 Mar 2019 12:55:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM / wakeup: Drop wakeup_source_drop()
Date:   Mon, 11 Mar 2019 12:53:59 +0100
Message-ID: <2820276.PxaWYKrF8K@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit d856f39ac1cc ("PM / wakeup: Rework wakeup source timer
cancellation") wakeup_source_drop() is a trivial wrapper around
__pm_relax() and it has no users except for wakeup_source_destroy()
and wakeup_source_trash() which also has no users, so drop it along
with the latter and make wakeup_source_destroy() call __pm_relax()
directly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit d856f39ac1cc is in the bleeding-edge branch of the linux-pm.git tree.

---
 drivers/base/power/wakeup.c |   18 +-----------------
 include/linux/pm_wakeup.h   |    9 ---------
 2 files changed, 1 insertion(+), 26 deletions(-)

Index: linux-pm/include/linux/pm_wakeup.h
===================================================================
--- linux-pm.orig/include/linux/pm_wakeup.h
+++ linux-pm/include/linux/pm_wakeup.h
@@ -96,7 +96,6 @@ static inline void device_set_wakeup_pat
 /* drivers/base/power/wakeup.c */
 extern void wakeup_source_prepare(struct wakeup_source *ws, const char *name);
 extern struct wakeup_source *wakeup_source_create(const char *name);
-extern void wakeup_source_drop(struct wakeup_source *ws);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
@@ -134,8 +133,6 @@ static inline struct wakeup_source *wake
 	return NULL;
 }
 
-static inline void wakeup_source_drop(struct wakeup_source *ws) {}
-
 static inline void wakeup_source_destroy(struct wakeup_source *ws) {}
 
 static inline void wakeup_source_add(struct wakeup_source *ws) {}
@@ -204,12 +201,6 @@ static inline void wakeup_source_init(st
 	wakeup_source_add(ws);
 }
 
-static inline void wakeup_source_trash(struct wakeup_source *ws)
-{
-	wakeup_source_remove(ws);
-	wakeup_source_drop(ws);
-}
-
 static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
 {
 	return pm_wakeup_ws_event(ws, msec, false);
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -106,22 +106,6 @@ struct wakeup_source *wakeup_source_crea
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
 
-/**
- * wakeup_source_drop - Prepare a struct wakeup_source object for destruction.
- * @ws: Wakeup source to prepare for destruction.
- *
- * Callers must ensure that __pm_stay_awake() or __pm_wakeup_event() will never
- * be run in parallel with this function for the same wakeup source object.
- */
-void wakeup_source_drop(struct wakeup_source *ws)
-{
-	if (!ws)
-		return;
-
-	__pm_relax(ws);
-}
-EXPORT_SYMBOL_GPL(wakeup_source_drop);
-
 /*
  * Record wakeup_source statistics being deleted into a dummy wakeup_source.
  */
@@ -161,7 +145,7 @@ void wakeup_source_destroy(struct wakeup
 	if (!ws)
 		return;
 
-	wakeup_source_drop(ws);
+	__pm_relax(ws);
 	wakeup_source_record(ws);
 	kfree_const(ws->name);
 	kfree(ws);

