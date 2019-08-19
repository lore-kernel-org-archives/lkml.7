Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45837C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251B52082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfHSKfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:35:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46415 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSKfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:35:06 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id f977f92d02e2f0ae; Mon, 19 Aug 2019 12:35:03 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: PM: s2idle: Avoid rearming SCI for wakeup unnecessarily
Date:   Mon, 19 Aug 2019 12:35:03 +0200
Message-ID: <4168022.LLJTMZb2K0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] ACPI: PM: s2idle: Avoid rearming SCI for wakeup unnecessarily

It is only necessary to rearm the ACPI SCI for wakeup if
pm_system_cancel_wakeup() has been called, so invoke
rearm_wake_irq() only in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is on top of the pm-s2idle-rework branch in the linux-pm.git tree that
has been present in linux-next for some time.

---
 drivers/acpi/sleep.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1012,9 +1012,9 @@ static void acpi_s2idle_wake(void)
 		acpi_os_wait_events_complete(); /* synchronize EC GPE processing */
 		acpi_ec_flush_work();
 		acpi_os_wait_events_complete(); /* synchronize Notify handling */
-	}
 
-	rearm_wake_irq(acpi_sci_irq);
+		rearm_wake_irq(acpi_sci_irq);
+	}
 }
 
 static void acpi_s2idle_restore_early(void)



