Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C5DC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB86C20715
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK1WvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:51:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42200 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfK1WvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:51:01 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 361cf6a5a72f8264; Thu, 28 Nov 2019 23:50:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ACPI: PM: s2idle: Rework ACPI events synchronization
Date:   Thu, 28 Nov 2019 23:50:40 +0100
Message-ID: <6942598.FjHfHmHd9f@kreacher>
In-Reply-To: <2787005.CsmIKtZlk9@kreacher>
References: <2787005.CsmIKtZlk9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Note that the EC GPE processing need not be synchronized in
acpi_s2idle_wake() after invoking acpi_ec_dispatch_gpe(), because
that function checks the GPE status and dispatches its handler if
need be and the SCI action handler is not going to run anyway at
that point.

Moreover, it is better to drain all of the pending ACPI events
before restoring the working-state configuration of GPEs in
acpi_s2idle_restore(), because those events are likely to be related
to system wakeup, in which case they will not be relevant going
forward.

Rework the code to take these observations into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -977,6 +977,16 @@ static int acpi_s2idle_prepare_late(void
 	return 0;
 }
 
+static void acpi_s2idle_sync(void)
+{
+	/*
+	 * The EC driver uses the system workqueue and an additional special
+	 * one, so those need to be flushed too.
+	 */
+	acpi_ec_flush_work();
+	acpi_os_wait_events_complete(); /* synchronize Notify handling */
+}
+
 static void acpi_s2idle_wake(void)
 {
 	/*
@@ -1001,13 +1011,8 @@ static void acpi_s2idle_wake(void)
 		 * should be missed by canceling the wakeup here.
 		 */
 		pm_system_cancel_wakeup();
-		/*
-		 * The EC driver uses the system workqueue and an additional
-		 * special one, so those need to be flushed too.
-		 */
-		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
-		acpi_ec_flush_work();
-		acpi_os_wait_events_complete(); /* synchronize Notify handling */
+
+		acpi_s2idle_sync();
 
 		rearm_wake_irq(acpi_sci_irq);
 	}
@@ -1024,6 +1029,13 @@ static void acpi_s2idle_restore_early(vo
 
 static void acpi_s2idle_restore(void)
 {
+	/*
+	 * Drain pending events before restoring the working-state configuration
+	 * of GPEs.
+	 */
+	acpi_os_wait_events_complete(); /* synchronize GPE processing */
+	acpi_s2idle_sync();
+
 	s2idle_wakeup = false;
 
 	acpi_enable_all_runtime_gpes();



