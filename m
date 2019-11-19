Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069A82230C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcezhV36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfKSPqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:46:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38094 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfKSPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:46:22 -0500
Received: by mail-qt1-f194.google.com with SMTP id p20so25106037qtq.5;
        Tue, 19 Nov 2019 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dLhB0QXgSc0cp21JCDWF+GDSRy9TlUf1i5+q01RXfbc=;
        b=NcezhV36Awiz0JR+l6h/RvajlzRJjQj17xvJdv7KaJxKf6Zx0gRFHJiQEPir2cwzIu
         G4j0sfSFtSTNmGeYbGdtQeWzGIWvqhk0WvBpwVKdqSsD1+5ZPUY9ZiTFYl98phAZuQiv
         q1KcWOJBgna9lBy0yTQiTEfbYU/XQevPYB7hArUk5fpsWN+o80UbU3HQ4RMjqNFHGEOZ
         9+YpkUfEDhxwwr/4kqntC1l73MkAUL/HGq0aFY/QxNpA94CYg26NC24xzgfSUSn91hN6
         p92wE5/Rpq17DLb1hNb/IEHhd61S04Eju9wPHrOod6XJRdKf2JKhlUkq2l7AKSz4qXaQ
         gdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dLhB0QXgSc0cp21JCDWF+GDSRy9TlUf1i5+q01RXfbc=;
        b=JPI4LwfYTxBjfCrbXcfvgYboNVNxZPsi+J6zATQqYsAb6/XH1o3Ja2xAysNzTTLMqG
         XTuxT9NbDowYGEhZbChr+dhXj6Gd2khP4nzYjLlgq2k7C9sdC+6x+Kg6X+rNZ2euPWq8
         lW+Md5i4+zVIn0zGi/OB87PiZPrRoctwTT71QEV28ToXNV0WUl/UKDxO2RfTm1GPo+zb
         oQxWDYKUzOzzK0wB6FyrdPanOF8cLmK0M+UpfIiERhYmB0IVbbOr46iGE+UxNXPKDIBe
         gUHDys6dSURWxIMEBLCgfSc+pam1JOcHjSCZg6LV8AxLM7aWc435M8c5QF/89My8IfVm
         Irtg==
X-Gm-Message-State: APjAAAXMLeQK9NEm0rbIRsgIwM9x5t4bDb50OukOyCghpLMuVmLUacGb
        70w9xZqdmfi4nrcHOox7/tQ=
X-Google-Smtp-Source: APXvYqxLqGKfMv/XfGupYzdWeRxuGK4t7M+RzBv1uue0VAnYw0+Gnma849ZjdownvStAR+hHkXnXKQ==
X-Received: by 2002:ac8:3168:: with SMTP id h37mr33057100qtb.311.1574178380603;
        Tue, 19 Nov 2019 07:46:20 -0800 (PST)
Received: from localhost.localdomain ([72.53.229.209])
        by smtp.gmail.com with ESMTPSA id 50sm12949919qtv.88.2019.11.19.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:46:20 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v2 2/4] regulator: tps6105x: add optional devicetree support
Date:   Tue, 19 Nov 2019 10:46:09 -0500
Message-Id: <20191119154611.29625-3-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119154611.29625-1-TheSven73@gmail.com>
References: <20191119154611.29625-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell the regulator framework to retrieve regulator init
data from the 'regulator' subnode, or from the parent mfd
device's platform data.

Example:

i2c0 {
	tps61052@33 {
		compatible = "ti,tps61052";
		reg = <0x33>;

		regulator {
			regulator-min-microvolt = <5000000>;
			regulator-max-microvolt = <5000000>;
			regulator-always-on;
		};
	};
};

Tree: next-20191118
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/regulator/tps6105x-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index 06059a94f7c6..f8939af0bd2c 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -37,6 +37,7 @@ static struct regulator_ops tps6105x_regulator_ops = {
 
 static const struct regulator_desc tps6105x_regulator_desc = {
 	.name		= "tps6105x-boost",
+	.of_match	= of_match_ptr("regulator"),
 	.ops		= &tps6105x_regulator_ops,
 	.type		= REGULATOR_VOLTAGE,
 	.id		= 0,
@@ -71,6 +72,7 @@ static int tps6105x_regulator_probe(struct platform_device *pdev)
 	config.dev = &tps6105x->client->dev;
 	config.init_data = pdata->regulator_data;
 	config.driver_data = tps6105x;
+	config.of_node = pdev->dev.parent->of_node;
 	config.regmap = tps6105x->regmap;
 
 	/* Register regulator with framework */
-- 
2.17.1

