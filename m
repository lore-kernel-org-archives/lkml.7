Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BACC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8632F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar8xXALL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfDQIpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:45:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45403 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:45:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so11763887pfi.12;
        Wed, 17 Apr 2019 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uoc6kVs+7MwrNtal9G67c9pZEZjLUZQwe2/ZBK5LV/Q=;
        b=ar8xXALLSp8+JBu3+KBZJ/4Ffwq3x4Fk499x6r/pVcTDyxQ3lRt5uOQCWIpu1e5bel
         s8/bigWC0dHTvRRy2soaxdBIr9nvjk2QFxiZlPWoARBUnWPz29LFE2vTRAc3Ezf8A5z0
         JYTsRGBzfBra3Lm1WAOuQN9PQiH2p2RyMEP9+/XTQ3HZ3EmTlvASu7SvFQgHIfpqGqK4
         Pne3jb1oeG7Vc9lrIOsvBh9O7GK/d9x+n3xXBUVEsyeQqYL9hpMi5xCdNFGrSVQfLZVv
         Qg2M2db2tK6Nj/BqQoPN859RbvxZ/yLPyy0gKyDD0Y5SGEFPoWI95Tzec8omPGP8dFrF
         59bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uoc6kVs+7MwrNtal9G67c9pZEZjLUZQwe2/ZBK5LV/Q=;
        b=hf7mWothaeZYSAMvVS3yHmPuzl2ePqft3nfXfW3RZ5OMBczeRTQcypiJsz2Tx/pvIX
         0agiJwVJ0q2Tygy0pFq4Xt62wQSZCDXGrrkICuLwVJdaLnbYs27W1t/a4Q0VbpsSfEyX
         I9WJt+RKFM3oZW9PNSk4D71PLnLC7++axZb06hxzNJ/vKi9+Uhg2/9L5MuMUBlFhXo6Y
         ZkmMgxeApgLBRGIkj1ElZHCEiKmHRZzYUgJblSrKCy1Siyw4FAtuEkszSyrFBYLc2XX1
         JsL22eoGJU7vxpi8Xms1+v0+QL5+BhDzk7xFatPWVRRAbIZez5HKUC89DJA+5z9C6A+v
         z3Qw==
X-Gm-Message-State: APjAAAUzvz7+W7biH+vIaXBUyKyZFJVXmX7iaiCf2/cve8oYUhFEfFtn
        4u1QD722e247GoAfp9YYU9FB2RGmrKk=
X-Google-Smtp-Source: APXvYqzRr74TrrCAmKY0LMgRGLaQGRjR6RkksVq9cwSgURZAGqy2wqYsq166x877uga8JuZu6MQSbw==
X-Received: by 2002:aa7:9ab1:: with SMTP id x17mr82370104pfi.4.1555490729555;
        Wed, 17 Apr 2019 01:45:29 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g64sm124142972pfg.13.2019.04.17.01.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 01:45:28 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Health <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: power: supply: Add bindings for Microchip UCS1002
Date:   Wed, 17 Apr 2019 01:44:57 -0700
Message-Id: <20190417084457.28747-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417084457.28747-1-andrew.smirnov@gmail.com>
References: <20190417084457.28747-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Microchip UCS1002 Programmable USB Port Power
Controller with Charger Emulation.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Health <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 .../power/supply/microchip,ucs1002.txt        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt

diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
new file mode 100644
index 000000000000..bef5be47d73e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
@@ -0,0 +1,26 @@
+Microchip UCS1002 USB Port Power Controller
+
+Required properties:
+- compatible		: Should be "microchip,ucs1002";
+- reg			: I2C slave address
+
+Optional properties:
+- interrupts-extended	: A list of interrupts lines present (could be either
+			  corresponding to A_DET# pin, ALERT# pin, or both)
+- interrupt-names	: A list of interrupt names. Should contain (if
+			  present):
+			  - "a_det" for line connected to A_DET# pin
+			  - "alert" for line connected to ALERT# pin
+Example:
+
+&i2c3 {
+	charger@32 {
+		compatible = "microchip,ucs1002";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ucs1002_pins>;
+		reg = <0x32>;
+		interrupts-extended = <&gpio5 2 IRQ_TYPE_NONE>,
+				      <&gpio3 21 IRQ_TYPE_NONE>;
+		interrupt-names = "a_det", "alert";
+	};
+};
-- 
2.20.1

