Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A5BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB6217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmUQ8YW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfKTOoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:44:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36897 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfKTOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:44:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id e187so21441986qkf.4;
        Wed, 20 Nov 2019 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPpJi866i3uNcB2ACYim+cpMzjJaUfLGqtxxSp9RiCI=;
        b=nmUQ8YW7n15KG07sjlo5cFZLcUYw4jq5NeaEoh9HFpHYre1u07gsysoyKExNjRqBbe
         /oTY64IBXvrtxPyJ4qJlgk2BkBkR9Xmw6BELkrXN0bA9lkYxKufbELbr5ZRCIjWWpQ1o
         nyh6NVwu2yd4FEOimUCYfLehcr+/0Il3kp/3mNQm7XVRocCmFdv5/j/sKTt2i+xICvd+
         5DuuyxFZ3TmmL+ufEV7+YYZaaOacaMo6mYNy6DMHU9XnfRhP535Bk8U3tTVtLG5uqVq+
         fT2nNabVQsVmBzQZL6gbKjwf50RVh1NRDBQTyknB3Gl+QR1Fw3GDsWk6pDaKPSihG4yn
         mnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KPpJi866i3uNcB2ACYim+cpMzjJaUfLGqtxxSp9RiCI=;
        b=kabFnbGOQHyEybNTzUGeM0hA7+psvzJg/rl4fghVF8X4KO7YJnqDxmiDPPBQ2BAHZw
         7DNoS2Gt4KEzDVuWKpW8UMgjUntifa2w8Gp+wIZtoMMi/P/82SC7GaMhphdxA4by1Lag
         XH1roVYxAuyC2nk5hluhoyx24zdHviH6KlheiMlNMmSojsjZFaSapkvS0K2Z+KtUVH4/
         ox7xkGWdeY38qhQWF0vHUuoVbqvsqwxrEUbKa+gSvTTSUSv24fJWTTVY/p0f2cGogj5c
         BUBBw01PK6UqRJ4Ls5z9csMfSxY+cE6s+6nZXZLEUI2hclFLzq1gZMtdIr9r5FWb6Eiu
         80HA==
X-Gm-Message-State: APjAAAVZ6zgRXy4lm2PQ2FQJv0BWkRjHqncWpJWR5GGt8AeIBlFRkIu+
        HXHYlJLLXIHt1LHp4Otd108=
X-Google-Smtp-Source: APXvYqw2g5H55XC6Ml6YKAqhnn64wmG1phbNYCvc+vRp7TW6bbsqoolhOMedX4yr84ZcTPA9GPnloQ==
X-Received: by 2002:a37:6517:: with SMTP id z23mr2752665qkb.434.1574261050644;
        Wed, 20 Nov 2019 06:44:10 -0800 (PST)
Received: from localhost.localdomain ([72.53.229.209])
        by smtp.gmail.com with ESMTPSA id 62sm953069qkk.102.2019.11.20.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:44:10 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: mfd: update TI tps6105x chip bindings
Date:   Wed, 20 Nov 2019 09:44:01 -0500
Message-Id: <20191120144401.30452-4-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120144401.30452-1-TheSven73@gmail.com>
References: <20191120144401.30452-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has been extended to optionally get its operational
mode, regulator init data and led label from the devicetree.

Tree: next-20191118
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../devicetree/bindings/mfd/tps6105x.txt      | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps6105x.txt b/Documentation/devicetree/bindings/mfd/tps6105x.txt
index 93602c7a19c8..1fa8fc35e0bc 100644
--- a/Documentation/devicetree/bindings/mfd/tps6105x.txt
+++ b/Documentation/devicetree/bindings/mfd/tps6105x.txt
@@ -7,11 +7,48 @@ Required properties:
 - compatible:		"ti,tps61050" or "ti,tps61052"
 - reg:			Specifies the I2C slave address
 
-Example:
+Optional sub-node:
+
+This subnode selects the chip's operational mode.
+There can be at most one single available subnode.
+
+- regulator: presence of this sub-node puts the chip in regulator mode.
+	see Documentation/devicetree/bindings/regulator/regulator.txt
+
+- led: presence of this sub-node puts the chip in led mode.
+
+Example (GPIO operation only):
+
+i2c0 {
+	tps61052@33 {
+		compatible = "ti,tps61052";
+		reg = <0x33>;
+	};
+};
+
+Example (GPIO + regulator operation):
 
 i2c0 {
 	tps61052@33 {
 		compatible = "ti,tps61052";
 		reg = <0x33>;
+
+		regulator {
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
+};
+
+Example (GPIO + led operation):
+
+i2c0 {
+	tps61052@33 {
+		compatible = "ti,tps61052";
+		reg = <0x33>;
+
+		led {
+		};
 	};
 };
-- 
2.17.1

