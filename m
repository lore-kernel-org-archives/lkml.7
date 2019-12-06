Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1D0C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671E824673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NavYeQqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLFSqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:46:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33783 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFSqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:46:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so3738143pgk.0;
        Fri, 06 Dec 2019 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9W7WPwjnJHtC/naxP3RfV5CxVXsAP5EpT3Px9490LQY=;
        b=NavYeQqvP2q3kvmYn9yXI7GVvVVwsk9RcyYQZAKX0qJZTpUmu7ccQJx8ZddSpP4rdN
         YbN4EHyYXmDe45mcoHsauFp99puj08zDp/HbL7hnWV6GlGyfUNPEXAFH3SESYIjUD2sx
         rbBcvEfRW54cgJgRMK9gM+kv7OJEYudOZ4UM8xnW+LP9g8x51gMC6cBDcxwAJBOsFjxu
         dVFP9hUKstU4PS/1LMjhG45yxL1G8igQeVf5MluEs+B196KekbXrndPv+YboAn3kVfEa
         HSOsQj1y141VQLNUZB8P/4uu1iV0FyNquhRWmZrej0SSlGTEwj110Rrj9NvyfcUW6Oq7
         OZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9W7WPwjnJHtC/naxP3RfV5CxVXsAP5EpT3Px9490LQY=;
        b=gBfFdJhRrl/XEnJyUaO1Cn7Vk1C9YyTAoX+sZh2IyxZaQxrPCXgqFqxuxLPUO3VYWh
         PGWLfzoWzwvRHHKBMGq2WH094IIdRTlViqUxNs8GepKe6O2nNUEwKqfFsDfDDYLl9mHE
         Dtw9VZ6o0dag+RATXJaiADM/MG+eTQpziBYtqwSoN7hlNCRsGazuD2cILz1AMOBtw2yK
         ku75+wkzh0VbbSGDnRvSj+HYW56xhwODaKDPNtwx/L9FsnyqjDubrBcrTT/RC5QKhP89
         0c+Eo7JXyFUw+sQVlZ0DXxIUYEVBc7rx3il5rKhpXY+xTMdC+zMrtUeX/SPF5p+nYrA4
         0Akw==
X-Gm-Message-State: APjAAAUsbV8GIiJv1cqiJ99zGQW2d7Khd/3jEz7KY4+sR5jNnt7gQTd1
        W/rP6q7Tb39T3Cb/D08MygU=
X-Google-Smtp-Source: APXvYqzz67JrfhxkW/+t3kgMvplm4CMLvf6iCKoVJbY3ACxHKyUocDE0Q5QdpDqkNJjvaZcvGlM2WQ==
X-Received: by 2002:a63:483:: with SMTP id 125mr5032698pge.217.1575657987999;
        Fri, 06 Dec 2019 10:46:27 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:46:27 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 3/8] mfd: rk808: use syscore for RK808 PMIC shutdown
Date:   Fri,  6 Dec 2019 18:45:31 +0000
Message-Id: <20191206184536.2507-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206184536.2507-1-linux.amoon@gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common syscore_shutdown for RK808 PMIC to do
clean I2C shutdown, drop the unused pm_pwroff_fn
function pointers.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/mfd/rk808.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 713d989064ba..0a098fbdf112 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -467,11 +467,6 @@ static void rk808_update_bits(unsigned int reg, unsigned int mask,
 			"can't write to register 0x%x: %x!\n", reg, ret);
 }
 
-static void rk808_device_shutdown(void)
-{
-	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST, DEV_OFF_RST);
-}
-
 static void rk818_device_shutdown(void)
 {
 	rk808_update_bits(RK818_DEVCTRL_REG, DEV_OFF, DEV_OFF);
@@ -490,6 +485,10 @@ static void rk8xx_syscore_shutdown(void)
 					SLP_SD_MSK, SHUTDOWN_FUN);
 			rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);
 			break;
+		case RK808_ID:
+			rk808_update_bits(RK808_DEVCTRL_REG,
+					DEV_OFF_RST, DEV_OFF_RST);
+			break;
 		case RK809_ID:
 		case RK817_ID:
 			rk808_update_bits(RK817_SYS_CFG(3),
@@ -576,7 +575,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
-		rk808->pm_pwroff_fn = rk808_device_shutdown;
 		break;
 	case RK818_ID:
 		rk808->regmap_cfg = &rk818_regmap_config;
-- 
2.24.0

