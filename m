Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715FBC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5001220665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfHPR4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:56:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:17478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHPR4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:56:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 10:56:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="201607495"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2019 10:56:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2B74F1; Fri, 16 Aug 2019 20:56:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Add Intel Skylake ACPI IDs
Date:   Fri, 16 Aug 2019 20:56:02 +0300
Message-Id: <20190816175602.42133-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the laptops, like ASUS U306UA, may expose LPSS devices via ACPI.

Add their IDs to the list.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 61ffb8b393e4..c8fe334b5fe8 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -18,6 +18,10 @@
 
 #include "intel-lpss.h"
 
+static const struct intel_lpss_platform_info spt_info = {
+	.clk_rate = 120000000,
+};
+
 static struct property_entry spt_i2c_properties[] = {
 	PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
 	{ },
@@ -28,6 +32,19 @@ static const struct intel_lpss_platform_info spt_i2c_info = {
 	.properties = spt_i2c_properties,
 };
 
+static struct property_entry uart_properties[] = {
+	PROPERTY_ENTRY_U32("reg-io-width", 4),
+	PROPERTY_ENTRY_U32("reg-shift", 2),
+	PROPERTY_ENTRY_BOOL("snps,uart-16550-compatible"),
+	{ },
+};
+
+static const struct intel_lpss_platform_info spt_uart_info = {
+	.clk_rate = 120000000,
+	.clk_con_id = "baudclk",
+	.properties = uart_properties,
+};
+
 static const struct intel_lpss_platform_info bxt_info = {
 	.clk_rate = 100000000,
 };
@@ -58,8 +75,17 @@ static const struct intel_lpss_platform_info apl_i2c_info = {
 
 static const struct acpi_device_id intel_lpss_acpi_ids[] = {
 	/* SPT */
+	{ "INT3440", (kernel_ulong_t)&spt_info },
+	{ "INT3441", (kernel_ulong_t)&spt_info },
+	{ "INT3442", (kernel_ulong_t)&spt_i2c_info },
+	{ "INT3443", (kernel_ulong_t)&spt_i2c_info },
+	{ "INT3444", (kernel_ulong_t)&spt_i2c_info },
+	{ "INT3445", (kernel_ulong_t)&spt_i2c_info },
 	{ "INT3446", (kernel_ulong_t)&spt_i2c_info },
 	{ "INT3447", (kernel_ulong_t)&spt_i2c_info },
+	{ "INT3448", (kernel_ulong_t)&spt_uart_info },
+	{ "INT3449", (kernel_ulong_t)&spt_uart_info },
+	{ "INT344A", (kernel_ulong_t)&spt_uart_info },
 	/* BXT */
 	{ "80860AAC", (kernel_ulong_t)&bxt_i2c_info },
 	{ "80860ABC", (kernel_ulong_t)&bxt_info },
-- 
2.23.0.rc1

