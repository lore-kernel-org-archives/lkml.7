Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3236C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8160921823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPEzAa9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfKSRxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:53:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44728 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfKSRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:53:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so24952445wrs.11;
        Tue, 19 Nov 2019 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3PWy3cFb/7J+Rxg3fcaYJEk3LUN9QrWLTJanLEpmxI=;
        b=DPEzAa9dDKZijZEPvA5U4LcSnJt1I7drAcJulmSMy1itrJeOnhFVyrCGbKl9tUirwr
         vA3/hbujfVEWODDrFENXzyon245hcR7TyW+KcKVjIsrWiNLHAbDdWkXGG9VvSvgOmkOn
         SWKHz0IC5bsJ/g6JEVjk+3J2C7DLYCz2LLlZm2inFP9G1PMXaOsHDMWMZ55E+U+GDyA/
         WDOioQzYNeUq+tL+dbDvBUhZrjzuE4xrhcZJ82cSZBllE23WL/WgV66UajHwMuek25Ov
         JHQKaHWietSyfJKnCtHe8evfjsh0qUj+QB07rJj+eTipwYci89wXeztOxwVx4wcGaS3e
         DfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3PWy3cFb/7J+Rxg3fcaYJEk3LUN9QrWLTJanLEpmxI=;
        b=dvsWWsyY96HgyqWxWCxNfoW8UU6gFp+QDK88JXG2bzU2bX0RMdTJvTjPveoLWxBEZ+
         v+MxypECDBThgx4jXHMW/jJPuLskV/OiNEFnr7tXFNNAjxIezMQJ5CSMuT46BKU5M61M
         InDZ5fngJeob2Ll8E1WdkeKyfgRzj5+tTxVRrL96BZV7eNebnXkfAuliRIhpbFjFpDRB
         7iZTDAb7SqPv3Q5fVw5k4bCgqLmAx8MR7qODhsrxRKBKcDhoSAqeGIbbaYtIGPKP5UDy
         UpmrLWgamHgHDmmA7IGbcMdEysO+CMZbUtVHC9b4kn2hjue1JshRPmKkFF2vutCeNil6
         0RcA==
X-Gm-Message-State: APjAAAVdir/ruKHG8EUQq/zpyoqbwlyXBfx0WQ0oidrg79HulKdC1c2I
        jWcZgUxGe5UwvMPHFIWgu8o=
X-Google-Smtp-Source: APXvYqyGK+paDQJBj/aZuJGWWDV/yTqzAbBw+4nw4WGno/HQXDU1ZIn17ECgRF9Cku3y0z8J113iwQ==
X-Received: by 2002:adf:ef91:: with SMTP id d17mr12486153wro.145.1574186008686;
        Tue, 19 Nov 2019 09:53:28 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:28 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v7 6/8] pwm: sun4i: Add support for H6 PWM
Date:   Tue, 19 Nov 2019 18:53:17 +0100
Message-Id: <20191119175319.16561-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
References: <20191119175319.16561-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Now that sun4i PWM driver supports deasserting reset line and enabling
bus clock, support for H6 PWM can be added.

Note that while H6 PWM has two channels, only first one is wired to
output pin. Second channel is used as a clock source to companion AC200
chip which is bundled into same package.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a1d8851b18f0..640f6349e36f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -358,6 +358,12 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
 	.npwm = 1,
 };
 
+static const struct sun4i_pwm_data sun50i_h6_pwm_data = {
+	.has_prescaler_bypass = true,
+	.has_direct_mod_clk_output = true,
+	.npwm = 2,
+};
+
 static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-pwm",
@@ -374,6 +380,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
 	}, {
 		.compatible = "allwinner,sun8i-h3-pwm",
 		.data = &sun4i_pwm_single_bypass,
+	}, {
+		.compatible = "allwinner,sun50i-h6-pwm",
+		.data = &sun50i_h6_pwm_data,
 	}, {
 		/* sentinel */
 	},
-- 
2.20.1

