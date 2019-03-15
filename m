Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B99FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838A20854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfCONj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:39:59 -0400
Received: from mail.utcluj.ro ([193.226.5.35]:45518 "EHLO mail.utcluj.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfCONj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:39:58 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 09:39:56 EDT
Received: from helios.el.el.obs.utcluj.ro (helios.el.obs.utcluj.ro [193.226.6.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gabil)
        by mail.utcluj.ro (Postfix) with ESMTPSA id 1104FA61;
        Fri, 15 Mar 2019 15:31:45 +0200 (EET)
From:   Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
Cc:     Gabriel Lazar <gabriel.lazar@com.utcluj.ro>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307 2-in-1
Date:   Fri, 15 Mar 2019 15:31:14 +0200
Message-Id: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.

Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
---
 drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 2d56ff7c8230..3319f0cbb558 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
 	.properties	= jumper_ezpad_mini3_props,
 };
 
+static const struct property_entry myria_my8307_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data myria_my8307_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= myria_my8307_props,
+};
+
 static const struct property_entry onda_obook_20_plus_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
@@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
 		},
 	},
+	{
+		/* Myria MY8307 */
+		.driver_data = (void *)&myria_my8307_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
+		},
+	},
 	{
 		/* Onda oBook 20 Plus */
 		.driver_data = (void *)&onda_obook_20_plus_data,
-- 
2.21.0

