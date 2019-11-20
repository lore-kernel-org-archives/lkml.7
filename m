Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B97C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EEF22520
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbfKTNVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56693 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbfKTNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPum-00073T-7O; Wed, 20 Nov 2019 14:21:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D30531C1998;
        Wed, 20 Nov 2019 14:20:59 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:20:59 -0000
From:   "tip-bot2 for Lina Iyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl/sdm845: Add PDC wakeup interrupt map for GPIOs
Cc:     Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-10-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-10-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425605969.12247.13808010297317474629.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     585d1183ffeea5cbe2cd24863bbc90196d827257
Gitweb:        https://git.kernel.org/tip/585d1183ffeea5cbe2cd24863bbc90196d827257
Author:        Lina Iyer <ilina@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:52 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:23:48 

pinctrl/sdm845: Add PDC wakeup interrupt map for GPIOs

Add interrupt parents for wakeup capable GPIOs for Qualcomm SDM845 SoC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-10-git-send-email-ilina@codeaurora.org
---
 drivers/pinctrl/qcom/pinctrl-sdm845.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
index ce49597..2834d2c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/acpi.h>
@@ -1282,6 +1282,24 @@ static const int sdm845_acpi_reserved_gpios[] = {
 	0, 1, 2, 3, 81, 82, 83, 84, -1
 };
 
+static const struct msm_gpio_wakeirq_map sdm845_pdc_map[] = {
+	{ 1, 30 }, { 3, 31 }, { 5, 32 }, { 10, 33 }, { 11, 34 },
+	{ 20, 35 }, { 22, 36 }, { 24, 37 }, { 26, 38 }, { 30, 39 },
+	{ 31, 117 }, { 32, 41 }, { 34, 42 }, { 36, 43 }, { 37, 44 },
+	{ 38, 45 }, { 39, 46 }, { 40, 47 }, { 41, 115 }, { 43, 49 },
+	{ 44, 50 }, { 46, 51 }, { 48, 52 }, { 49, 118 }, { 52, 54 },
+	{ 53, 55 }, { 54, 56 }, { 56, 57 }, { 57, 58 }, { 58, 59 },
+	{ 59, 60 }, { 60, 61 }, { 61, 62 }, { 62, 63 }, { 63, 64 },
+	{ 64, 65 }, { 66, 66 }, { 68, 67 }, { 71, 68 }, { 73, 69 },
+	{ 77, 70 }, { 78, 71 }, { 79, 72 }, { 80, 73 }, { 84, 74 },
+	{ 85, 75 }, { 86, 76 }, { 88, 77 }, { 89, 116 }, { 91, 79 },
+	{ 92, 80 }, { 95, 81 }, { 96, 82 }, { 97, 83 }, { 101, 84 },
+	{ 103, 85 }, { 104, 86 }, { 115, 90 }, { 116, 91 }, { 117, 92 },
+	{ 118, 93 }, { 119, 94 }, { 120, 95 }, { 121, 96 }, { 122, 97 },
+	{ 123, 98 }, { 124, 99 }, { 125, 100 }, { 127, 102 }, { 128, 103 },
+	{ 129, 104 }, { 130, 105 }, { 132, 106 }, { 133, 107 }, { 145, 108 },
+};
+
 static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
 	.pins = sdm845_pins,
 	.npins = ARRAY_SIZE(sdm845_pins),
@@ -1290,6 +1308,9 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
 	.groups = sdm845_groups,
 	.ngroups = ARRAY_SIZE(sdm845_groups),
 	.ngpios = 151,
+	.wakeirq_map = sdm845_pdc_map,
+	.nwakeirq_map = ARRAY_SIZE(sdm845_pdc_map),
+
 };
 
 static const struct msm_pinctrl_soc_data sdm845_acpi_pinctrl = {
