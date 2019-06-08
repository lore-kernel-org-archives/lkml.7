Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2170C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2466214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K83QhhoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFHTEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:04:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbfFHTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:04:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so5321451wrn.1;
        Sat, 08 Jun 2019 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uN4hjdcek7T4CnTm0X7zhsU8Gz9i5WRbo0q2IpM0eE=;
        b=K83QhhoMl7XG/s5R65AgUYKNczLOaFu5RhzAYBEZt9OrF+5boUd9Ty2rFKyTzucopf
         iRgMlgPae3qmUXUMC3Ek5RrgGBRUWEIkEedcaFywYhr9Mcat8Tu8T1eSN7QYWjyJlXiw
         rZQqvFM9QKSpPqal/OOA8a55JaTVZBxQoXNkp08OZ4KXZl9f1ci6wSztoY3LD39/gBw0
         RP1cIVMf/jZPx8Mo23JPuw999aQgWEjjGCDghte/spyFR0kkkN0UqU0ZL0YD9zMMZI3N
         5cOY7M5FIpFBxo/hfynwjLHZ1quTlYSGMITJdawIv6LDMRzPeqq7Qg7px7lzwDiCjG+O
         oZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uN4hjdcek7T4CnTm0X7zhsU8Gz9i5WRbo0q2IpM0eE=;
        b=PEtYqrgUZpBMtGzqjUVVs0I2P/qaQ7Jwum5emEYwDqV4Zngv5Yf0nZhYljXe9JV7TT
         F+vPyOi3E+WoyC566z7C0s9Qq8D6lC1W5PbdfoQ3fOyKONBWNra1I6dsPh2M42geb6e+
         3nBbVZwczPtTy5fzImQEuMqfZpZaPVSnPYiNhIzx1w28duN+Ks4yKXUUWQPQQ0ef8W5l
         u4QNoiv9X4GtVSP1pwIInMDOjq5RTTnd73Q7HI4XbpNmYA9L54QI7b2tnsT/gJU1Gnyg
         SVmkMHjRVaxsXcN+ZQV7u5QN1hkOWMfKyisEiSdbEvlb6gSpcwG3V/Syb8YKV8V0skmL
         GFYA==
X-Gm-Message-State: APjAAAUNS85Fufe/XwC4gz1Lxf1ieN5DneTNjWj7LeIM/98Bh8YpeVW2
        TbCRSXZF/iPR1m4z/VFRziddOipq
X-Google-Smtp-Source: APXvYqxOMS9p0YK5H2hrquYQ7S5h/mFRESHFO+TjeSaqtatzIc19t054BVKriOz2LhSzH4Mg/Zfq5Q==
X-Received: by 2002:a5d:4a82:: with SMTP id o2mr21766445wrq.154.1560020659418;
        Sat, 08 Jun 2019 12:04:19 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id t6sm5655062wmb.29.2019.06.08.12.04.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 12:04:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] irqchip/meson-gpio: Add support for Meson-G12A SoC
Date:   Sat,  8 Jun 2019 21:04:10 +0200
Message-Id: <20190608190411.14018-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
References: <20190608190411.14018-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:

- 223:100 undefined (no interrupt)
- 99:97   3 pins on bank GPIOE
- 96:77   20 pins on bank GPIOX
- 76:61   16 pins on bank GPIOA
- 60:53   8 pins on bank GPIOC
- 52:37   16 pins on bank BOOT
- 36:28   9 pins on bank GPIOH
- 27:12   16 pins on bank GPIOZ
- 11:0    12 pins in the AO domain

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/irqchip/irq-meson-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b531fd075b8..7599b10ecf09 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -73,6 +73,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
+	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ }
 };
 
-- 
2.21.0

