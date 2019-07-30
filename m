Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2984C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74124206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfG3KFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:05:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64768 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfG3KFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:05:16 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id cef21d955188d92f; Tue, 30 Jul 2019 12:05:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/8] PM: s2idle: Rearrange lps0_device_attach()
Date:   Tue, 30 Jul 2019 11:57:37 +0200
Message-ID: <1832879.s96VGDVqo9@kreacher>
In-Reply-To: <7528887.mqcfy9PZua@kreacher>
References: <7528887.mqcfy9PZua@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To allow a subsequent change to be simpler, rearrange the code in
lps0_device_attach() to reduce the indentation level and (while
at it) make it avoid calling lpi_device_get_constraints() when
lps0_device_handle is not going to be set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

No changes in v2.

---
 drivers/acpi/sleep.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -916,28 +916,30 @@ static int lps0_device_attach(struct acp
 	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
 	/* Check if the _DSM is present and as expected. */
 	out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
-	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
-		char bitmask = *(char *)out_obj->buffer.pointer;
-
-		lps0_dsm_func_mask = bitmask;
-		lps0_device_handle = adev->handle;
-		/*
-		 * Use suspend-to-idle by default if the default
-		 * suspend mode was not set from the command line.
-		 */
-		if (mem_sleep_default > PM_SUSPEND_MEM)
-			mem_sleep_current = PM_SUSPEND_TO_IDLE;
-
-		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
-				  bitmask);
-	} else {
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
 		acpi_handle_debug(adev->handle,
 				  "_DSM function 0 evaluation failed\n");
+		return 0;
 	}
+
+	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
+
 	ACPI_FREE(out_obj);
 
+	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
+			  lps0_dsm_func_mask);
+
+	lps0_device_handle = adev->handle;
+
 	lpi_device_get_constraints();
 
+	/*
+	 * Use suspend-to-idle by default if the default suspend mode was not
+	 * set from the command line.
+	 */
+	if (mem_sleep_default > PM_SUSPEND_MEM)
+		mem_sleep_current = PM_SUSPEND_TO_IDLE;
+
 	return 0;
 }
 



