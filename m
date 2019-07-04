Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29111C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6021882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 09:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfGDJKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 05:10:18 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:7798
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727158AbfGDJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:10:15 -0400
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 6C97121590;
        Thu,  4 Jul 2019 09:02:29 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH 2/3] platform/x86/pcengines-apuv2: add legacy leds gpio definitions
Date:   Thu,  4 Jul 2019 11:02:04 +0200
Message-Id: <20190704090205.19400-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190704090205.19400-1-fe@dev.tdt.de>
References: <20190704090205.19400-1-fe@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the apu2_leds definition to make the leds exportable via the
legacy gpio subsystem. Without this change the leds are not visible
under "/sys/class/leds" and could not be configured.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/platform/x86/pcengines-apuv2.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index f6d8ed100cab..d50a50e9d34c 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -75,9 +75,24 @@ static const struct amd_fch_gpio_pdata board_apu2 = {
 /* gpio leds device */
 
 static const struct gpio_led apu2_leds[] = {
-	{ .name = "apu:green:1" },
-	{ .name = "apu:green:2" },
-	{ .name = "apu:green:3" }
+	{
+		.name            = "apu:green:1",
+		.gpio            = 505,
+		.default_trigger = "default-off",
+		.active_low      = 1,
+	},
+	{
+		.name            = "apu:green:2",
+		.gpio            = 506,
+		.default_trigger = "default-off",
+		.active_low      = 1,
+	},
+	{
+		.name            = "apu:green:3",
+		.gpio            = 507,
+		.default_trigger = "default-off",
+		.active_low      = 1,
+	}
 };
 
 static const struct gpio_led_platform_data apu2_leds_pdata = {
-- 
2.11.0

