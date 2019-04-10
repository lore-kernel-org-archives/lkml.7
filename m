Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C172084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvpMFoxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDJFJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:09:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33254 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfDJFJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:09:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so702056pfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 22:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=arJuKT1IB3LhHaw7J/lCue0zeOVqB2nkZiD+gzxGIAw=;
        b=QvpMFoxJijiL2w3S8sgu7RZ1WMFdrKrXag1SLtQYM9H5jVD7wKzruJt2M+2z5VLz0t
         kSah8hhAnopanrCk7QqkKVYpceEZk4xk/Zhx1wh+QJBm5lhwYcDKqUlRyC7BhZO0vAbl
         +Qxj/tWZd1jJSJNXL1kvlR3fE7E3h5Tx1ARa4FFcWvy7eZFsgfMAogw5aq7itbyt+Nlp
         rFsJrnOPj2KsCzeRtehTo+IaUhYKTln/3MC6DJ4P+dZFXxHcmTKt94N9TRqON0gkq4Yg
         2Y9n1i6CSnoa5AoCaKV7U4/siUHQSKuon0sbHsBU32gxN02gxpqQ04YIopoiyzAnJhlG
         3e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=arJuKT1IB3LhHaw7J/lCue0zeOVqB2nkZiD+gzxGIAw=;
        b=gF7Xxzb0rV94uhRHrMgcB8uJnMBcT+ik0aa/hmcqg6Sdnff06tPv/wRPczn/S+SbI/
         1l5toCB2tQlXPPwCsccot1SMr7MrS0wuxo4dA72zZI5lmTobLiVM/iw3g4n7YYrpQ37P
         DXjfZqIU9ycd110OX7ctxKl0S6LgQguip8IufhEIrJ9wT9Fj9QS+Slrib+fxcFrNdlM/
         +NHYcWbbY7L6Bq5lUYCLoY+3ixRRWUxtxwJBX6vJG3YQPzgHbIdHteVzzNVqOZsSFrNk
         aEmN/A7D8PKzK6HxCqdQGQctZ1TVKUVlnpO+arbFga36ql5SBNn4ojXghxiVxLioesmq
         iI4w==
X-Gm-Message-State: APjAAAUvW3+ZDojWWV8QlSv0ErEpkF0oPf/LPIjnfhmjYcM95HPt515+
        uEbz4N0kd/IrGuwYDT6R5zI=
X-Google-Smtp-Source: APXvYqwEuF/8LDb46f6GUnM6X4X+UVFuaVsXtfpsoSlKKyDNMqSoT1TEK+55+JwhJPIrVI55HUZFyA==
X-Received: by 2002:a63:6983:: with SMTP id e125mr37030583pgc.370.1554872958255;
        Tue, 09 Apr 2019 22:09:18 -0700 (PDT)
Received: from localhost.localdomain ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id i3sm50446980pfa.90.2019.04.09.22.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 22:09:17 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sidong Yang <realwakka@gmail.com>, sophie.matter@web.de,
        Valentin.Vidic@CARNet.hr, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: add dependency to PA0,1,2 setting for output power level
Date:   Wed, 10 Apr 2019 05:09:06 +0000
Message-Id: <20190410050906.12607-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting output power level called, the power level should be
checked by power amplifier level register and high power option. There
was todo about it. Add some variables for checking power level range.
The values that used for checking high power or minimum power are from
rf69 datasheets. The maximum power level is always same regardless of
mode.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/rf69.c | 45 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 340ffa7ccf18..4cd16257f0aa 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -349,18 +349,51 @@ int rf69_disable_amplifier(struct spi_device *spi, u8 amplifier_mask)
 
 int rf69_set_output_power_level(struct spi_device *spi, u8 power_level)
 {
-	// TODO: Dependency to PA0,1,2 setting
-	power_level += 18;
+	u8 pa_level, ocp, test_pa1, test_pa2;
+	bool pa0, pa1, pa2, high_power;
+	u8 min_power_level;
+
+	// check register pa_level
+	pa_level = rf69_read_reg(spi, REG_PALEVEL);
+	pa0 = pa_level & MASK_PALEVEL_PA0;
+	pa1 = pa_level & MASK_PALEVEL_PA1;
+	pa2 = pa_level & MASK_PALEVEL_PA2;
+
+	// check high power mode
+	ocp = rf69_read_reg(spi, REG_OCP);
+	test_pa1 = rf69_read_reg(spi, REG_TESTPA1);
+	test_pa2 = rf69_read_reg(spi, REG_TESTPA2);
+	high_power = (ocp == 0x0f) && (test_pa1 == 0x5d) && (test_pa2 == 0x7c);
+
+	if (pa0 && !pa1 && !pa2) {
+		power_level += 18;
+		min_power_level = 0;
+	} else if (!pa0 && pa1 && !pa2) {
+		power_level += 18;
+		min_power_level = 16;
+	} else if (!pa0 && pa1 && pa2) {
+		if (high_power)
+			power_level += 11;
+		else
+			power_level += 14;
+		min_power_level = 16;
+	} else {
+		goto failed;
+	}
 
 	// check input value
-	if (power_level > 0x1f) {
-		dev_dbg(&spi->dev, "set: illegal input param");
-		return -EINVAL;
-	}
+	if (power_level > 0x1f)
+		goto failed;
+
+	if (power_level < min_power_level)
+		goto failed;
 
 	// write value
 	return rf69_read_mod_write(spi, REG_PALEVEL, MASK_PALEVEL_OUTPUT_POWER,
 				   power_level);
+failed:
+	dev_dbg(&spi->dev, "set: illegal input param");
+	return -EINVAL;
 }
 
 int rf69_set_pa_ramp(struct spi_device *spi, enum pa_ramp pa_ramp)
-- 
2.11.0

