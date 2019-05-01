Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE5C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A8C21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 03:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAprODtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEADfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 23:35:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36896 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEADe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 23:34:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id z8so7683059pln.4;
        Tue, 30 Apr 2019 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWhWi6zxpbo1yZk2uSAHczLKMOESlgxtRP7rRzMEXJg=;
        b=vAprODtB0AN+BU/2w/XsboiSmXWRyXRP7+BwFLb+B8CTTgPqHxQOVgMj7BQOwWgidz
         V0eOFHfJNiyWOZENQdLLlhDtJk8nNvA6jFhN0/QI0WCp1ox4N66xLgXLFe68yU46OfuX
         yxPnbfC2vf4D3acj2KwnzgvfPXsLsq+/jf9uV+IP+EzmawsGjoihcBh5ayXnpuXEDZJO
         UCzTG4v7BQPUjFKRayLytkQ7kQ+4W/CuwxytTmsCAfx2LITrboQJek5H/td+bHDVwGTg
         7XoVPjKTWRDQsBL+6dJaIwleEaQZjOyW8rhpCEn8Y/JkEVuAsYnY0169TfuS/LGPybs3
         nYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWhWi6zxpbo1yZk2uSAHczLKMOESlgxtRP7rRzMEXJg=;
        b=bD5S3tPJh5h+2BjxBmJ+ccxsxXCQ8+5twMxZrfoLi01DInsjLic3ZvkOTsu7T7CNdN
         3ZsxqVa9E0J9Mdbcl/OYc6JUXneABJa1ZZw9t6h4AmwHBv4g7RlWE18pN7dff1vWMfwN
         xvn5G6m4RXkZXdFDxJCGc2NQCh7FjGjle/7n07tORBpW+VxIRbA1q6Eeb/AEPQO4cQh6
         rZglgiBeLyGNrPXYpjHQyHPqNs4JI92s4ELSLFgRHRfgn/v96xlDZ6yO837XhAFuUZr1
         jsdl9Z+Q009OBwGLmvyXB8NLcKtHg3i0ZYN8Jyg+sCezLEszX0ex/2nru3o/u7/+cupa
         vAJw==
X-Gm-Message-State: APjAAAWW+To9FA7ldOLaeel4id9r5TopGzZRHtyqk9ZI8Wpu+H7OLZdB
        W5LQ+Da8G1k58QDJw+KBicv8b97VUOs=
X-Google-Smtp-Source: APXvYqy32mrx4JLlwisbyibOVGn4RDoEdZuWA0OmHcFS8XyMRkrTgDcZdMILFRsR9jU1sTWwFSyeDw==
X-Received: by 2002:a17:902:1621:: with SMTP id g30mr74206769plg.168.1556681697513;
        Tue, 30 Apr 2019 20:34:57 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id r11sm47421067pga.87.2019.04.30.20.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 20:34:56 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] dt-bindings: power: supply: Add bindings for Microchip UCS1002
Date:   Tue, 30 Apr 2019 20:34:34 -0700
Message-Id: <20190501033434.18548-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501033434.18548-1-andrew.smirnov@gmail.com>
References: <20190501033434.18548-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Microchip UCS1002 Programmable USB Port Power
Controller with Charger Emulation.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt

diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
new file mode 100644
index 000000000000..1d284ad816bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
@@ -0,0 +1,27 @@
+Microchip UCS1002 USB Port Power Controller
+
+Required properties:
+- compatible		: Should be "microchip,ucs1002";
+- reg			: I2C slave address
+
+Optional properties:
+- interrupts		: A list of interrupts lines present (could be either
+			  corresponding to A_DET# pin, ALERT# pin, or both)
+- interrupt-names	: A list of interrupt names. Should contain (if
+			  present):
+			  - "a_det" for line connected to A_DET# pin
+			  - "alert" for line connected to ALERT# pin
+			  Both are expected to be IRQ_TYPE_EDGE_BOTH
+Example:
+
+&i2c3 {
+	charger@32 {
+		compatible = "microchip,ucs1002";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ucs1002_pins>;
+		reg = <0x32>;
+		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
+				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
+		interrupt-names = "a_det", "alert";
+	};
+};
-- 
2.20.1

