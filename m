Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCEF214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfCLJcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:32:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58833 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfCLJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:32:16 -0400
Received: from 79.184.254.189.ipv4.supernova.orange.pl (79.184.254.189) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id e29ca2db912c608e; Tue, 12 Mar 2019 10:32:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ACPI: sysfs: Prevent get_status() from returning acpi_status
Date:   Tue, 12 Mar 2019 10:30:29 +0100
Message-ID: <53542709.3ZnE1UDn36@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The return value of get_status() is passed to user space on errors,
so it should not return acpi_status values then.  Make it return
error values that are meaningful for user space instead.

This also makes a Clang warning regarding the initialization of a
local variable in get_status() go away.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Resend with a proper changelog and tags from Nathan.

---
 drivers/acpi/sysfs.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -648,26 +648,29 @@ static void acpi_global_event_handler(u3
 	}
 }
 
-static int get_status(u32 index, acpi_event_status *status,
+static int get_status(u32 index, acpi_event_status *ret,
 		      acpi_handle *handle)
 {
-	int result;
+	acpi_status status;
 
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
 		return -EINVAL;
 
 	if (index < num_gpes) {
-		result = acpi_get_gpe_device(index, handle);
-		if (result) {
+		status = acpi_get_gpe_device(index, handle);
+		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 					"Invalid GPE 0x%x", index));
-			return result;
+			return -ENXIO;
 		}
-		result = acpi_get_gpe_status(*handle, index, status);
-	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
-		result = acpi_get_event_status(index - num_gpes, status);
+		status = acpi_get_gpe_status(*handle, index, ret);
+	} else {
+		status = acpi_get_event_status(index - num_gpes, ret);
+	}
+	if (ACPI_FAILURE(status))
+		return -EIO;
 
-	return result;
+	return 0;
 }
 
 static ssize_t counter_show(struct kobject *kobj,

