Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34498C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F1E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611363;
	bh=C5OwFAdraY+7TfWGCJvCDGEsvQrMSQ9BhZpt1IQhFvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WjJnITtOiyNj0Tc8jkDanj2qpU06ZevPEF+l0iHKJni+efhPeQA4OoiRqD1JB/4Cq
	 qjpHAGwID1HDEhAoOAsu9wewKKWYjldOgkqw1iPkgGH0gc9XJ90CaGYphxrWTHZPw4
	 CaIm64W27YCjDy8ma75ouNQwNXM3RbTdWkCEbPNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404012AbfDRSQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403939AbfDRSMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8733F20652;
        Thu, 18 Apr 2019 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611138;
        bh=C5OwFAdraY+7TfWGCJvCDGEsvQrMSQ9BhZpt1IQhFvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9lZseYrE5KVOP5yvP5ltIDnXIsMPW3W1nRUk6yvhtDPWny7Yx74jdn6dKyD2Tvmo
         R0GCxd+ITe+0weIWOo6pd+AacqKEXHzW/iK/iMIN3YSOBrCJ2w7/C6aJ7zOR1CDRWY
         a7CJaEd3eq/2tIS8y7g8jHU7SPhm4rK8lhUlM/Qc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ortwin=20Gl=C3=BCck?= <odi@odi.ch>,
        Francisco Cribari <cribari@gmail.com>,
        Balazs Varga <balazs4web@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 74/93] Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"
Date:   Thu, 18 Apr 2019 19:57:52 +0200
Message-Id: <20190418160444.631734487@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b6a3e1475b0220378ad32bdf4d8692f058b1fc03 ]

On some Samsung hardware, it is necessary to clear events accumulated by
the EC during sleep. These ECs stop reporting GPEs until they are manually
polled, if too many events are accumulated.
Thus the CLEAR_ON_RESUME quirk is introduced to send EC query commands
unconditionally after resume to clear all the EC query events on those
platforms.

Later, commit 4c237371f290 ("ACPI / EC: Remove old CLEAR_ON_RESUME quirk")
removes the CLEAR_ON_RESUME quirk because we thought the new EC IRQ
polling logic should handle this case.

Now it has been proved that the EC IRQ Polling logic does not fix the
issue actually because we got regression report on these Samsung
platforms after removing the quirk.

Thus revert commit 4c237371f290 ("ACPI / EC: Remove old CLEAR_ON_RESUME
quirk") to introduce back the Samsung quirk in this patch.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=44161
Tested-by: Ortwin Glück <odi@odi.ch>
Tested-by: Francisco Cribari <cribari@gmail.com>
Tested-by: Balazs Varga <balazs4web@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9d66a47d32fb..49e16f009095 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -194,6 +194,7 @@ static struct workqueue_struct *ec_query_wq;
 static int EC_FLAGS_QUERY_HANDSHAKE; /* Needs QR_EC issued when SCI_EVT set */
 static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
 static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction setting */
+static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
 
 /* --------------------------------------------------------------------------
  *                           Logging/Debugging
@@ -499,6 +500,26 @@ static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
 		ec_log_drv("event blocked");
 }
 
+/*
+ * Process _Q events that might have accumulated in the EC.
+ * Run with locked ec mutex.
+ */
+static void acpi_ec_clear(struct acpi_ec *ec)
+{
+	int i, status;
+	u8 value = 0;
+
+	for (i = 0; i < ACPI_EC_CLEAR_MAX; i++) {
+		status = acpi_ec_query(ec, &value);
+		if (status || !value)
+			break;
+	}
+	if (unlikely(i == ACPI_EC_CLEAR_MAX))
+		pr_warn("Warning: Maximum of %d stale EC events cleared\n", i);
+	else
+		pr_info("%d stale EC events cleared\n", i);
+}
+
 static void acpi_ec_enable_event(struct acpi_ec *ec)
 {
 	unsigned long flags;
@@ -507,6 +528,10 @@ static void acpi_ec_enable_event(struct acpi_ec *ec)
 	if (acpi_ec_started(ec))
 		__acpi_ec_enable_event(ec);
 	spin_unlock_irqrestore(&ec->lock, flags);
+
+	/* Drain additional events if hardware requires that */
+	if (EC_FLAGS_CLEAR_ON_RESUME)
+		acpi_ec_clear(ec);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1820,6 +1845,31 @@ static int ec_flag_query_handshake(const struct dmi_system_id *id)
 }
 #endif
 
+/*
+ * On some hardware it is necessary to clear events accumulated by the EC during
+ * sleep. These ECs stop reporting GPEs until they are manually polled, if too
+ * many events are accumulated. (e.g. Samsung Series 5/9 notebooks)
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=44161
+ *
+ * Ideally, the EC should also be instructed NOT to accumulate events during
+ * sleep (which Windows seems to do somehow), but the interface to control this
+ * behaviour is not known at this time.
+ *
+ * Models known to be affected are Samsung 530Uxx/535Uxx/540Uxx/550Pxx/900Xxx,
+ * however it is very likely that other Samsung models are affected.
+ *
+ * On systems which don't accumulate _Q events during sleep, this extra check
+ * should be harmless.
+ */
+static int ec_clear_on_resume(const struct dmi_system_id *id)
+{
+	pr_debug("Detected system needing EC poll on resume.\n");
+	EC_FLAGS_CLEAR_ON_RESUME = 1;
+	ec_event_clearing = ACPI_EC_EVT_TIMING_STATUS;
+	return 0;
+}
+
 /*
  * Some ECDTs contain wrong register addresses.
  * MSI MS-171F
@@ -1869,6 +1919,9 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 	ec_honor_ecdt_gpe, "ASUS X580VD", {
 	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "X580VD"),}, NULL},
+	{
+	ec_clear_on_resume, "Samsung hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
 	{},
 };
 
-- 
2.19.1



