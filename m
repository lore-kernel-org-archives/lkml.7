Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A11C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E860922387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Vb/+i3os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfGWCqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:46:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55728 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfGWCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563849964; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=fL5yem8QsUYkhZu+Pm1PTITp0l+jVscmMyZeS34IKsQ=;
        b=Vb/+i3osY1n11LJAcDyhzXABp5jCqHMJnOUEKjZWHUDZvGxGJ2U0beZdgw+/ZVudnMkOqj
        SNYVPb1fNyl6K0KobhTaETLyhYaPad9d45FiPrzttvGZ5gcJXjbR04sYj4ZNk6ULQTtdcP
        Rx9jzBniH4E0gGStjD/mTqxvcwloR5Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     od@zcrc.me, Artur Rojek <contact@artur-rojek.eu>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Subject: [PATCH] power/supply: ingenic-battery: Don't change scale if there's only one
Date:   Mon, 22 Jul 2019 22:45:54 -0400
Message-Id: <20190723024554.9248-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADC in the JZ4740 can work either in high-precision mode with a 2.5V
range, or in low-precision mode with a 7.5V range. The code in place in
this driver will select the proper scale according to the maximum
voltage of the battery.

The JZ4770 however only has one mode, with a 6.6V range. If only one
scale is available, there's no need to change it (and nothing to change
it to), and trying to do so will fail with -EINVAL.

Fixes commit fb24ccfbe1e0 ("power: supply: add Ingenic JZ47xx battery
driver.")

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: stable@vger.kernel.org
---
 drivers/power/supply/ingenic-battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 35816d4b3012..5a53057b4f64 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -80,6 +80,10 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
 	if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
 		return -EINVAL;
 
+	/* Only one (fractional) entry - nothing to change */
+	if (scale_len == 2)
+		return 0;
+
 	max_mV = bat->info.voltage_max_design_uv / 1000;
 
 	for (i = 0; i < scale_len; i += 2) {
-- 
2.21.0.593.g511ec345e18

