Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB100C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB2218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Xrbvs5sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfCUOAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:00:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37319 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfCUOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:00:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id q206so4265422pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGGHspTL1AIJtuP770nUWGJPVBGGHW+ZSIayJnPakGk=;
        b=Xrbvs5sOFt541ehl5sjgoVnsee+LKE/rChnIbNU4vxoQgm88hDUSxQ0c2GYSztL62C
         QsXLcctYp8kohCy6h0jD9/mjSvrjS4X42zj5oz00EVBNjtEhsgr7/yw95udigGlTMgt3
         C5x8Ne6pyjJAq2ztvbxgseN8j/jc9TXX5PYiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGGHspTL1AIJtuP770nUWGJPVBGGHW+ZSIayJnPakGk=;
        b=byOJ0lmluWIaBvwG5dw6WF6YeHtEQfz7B+q7RNrA4xCVEEtOkQF43UUb2DbIbyTsVn
         yjldbHfa6TlYq22dfTjS6oFTRgUiMI9u+8dk0meuXVGdgPYs7d2QoHwTaAntOnRvdjQL
         UWLwfghIXWptaiyXM0ArY8GoPbmcHS/zvj/Ec16LYA/UqNsyD1sxKkq8+p6RGPNmjVLS
         mgyimIF4VsCgZ05vO2xqTQGTU0vR0I4uxWgFWKQF/85kKYl/8lXs6gzArNN+l6NbX4Xv
         XZvhXqHj7JB4aw0Z6eol+rfWgIDSsMlN1TxWjzO1WeYufUAZ0iSSAUviI06r8Z4x0OJL
         mP9A==
X-Gm-Message-State: APjAAAUYQsfN9yEPcA1hqsS/gpPwRpjeuMQCaqzrwqb/7Ra39Y8udFm7
        89564UfWv0cLPYtw4/UNwqu6eA==
X-Google-Smtp-Source: APXvYqxBVT1T+cSaycOpg3OqXINzHfC0gYNsgEc8Bm78ofSJQ1xeUC+JCutXxRG9KlhrsAIHFWeBbg==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr3757998plp.80.1553176831542;
        Thu, 21 Mar 2019 07:00:31 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id i126sm7985158pfc.101.2019.03.21.07.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:00:30 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Ryan Pannell <ryan@osukl.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/4] dt-bindings: display: Add Novatek NT35596 panel documentation
Date:   Thu, 21 Mar 2019 19:29:54 +0530
Message-Id: <20190321135955.25661-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321135955.25661-1-jagan@amarulasolutions.com>
References: <20190321135955.25661-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek NT35596 is a single-chip IC solution for small or medium-sized
LTPS TFT LCD panels. NT35596 provides  several system interfaces like
MIPI/SPI/I2C.

Microtech MTF050FHDI-03 is 1080x1920, 4-lane MIPI DSI LCD panel which
has inbuilt NT35596 IC chip.

NT35596 support several regulators on the chip, among those only 4 regulators
like VCI, VDDI/DVDD, AVDD, AVEE are used during power-on sequence.

Out of four regulators MTF050FHDI-03 panel do support 3-regulator based
power-on sequence, so this patch documented these 3 needful regulators
and rest can be add while supporting new panels on the similar chip IC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/novatek,nt35596.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt b/Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
new file mode 100644
index 000000000000..d336cd41e177
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35596.txt
@@ -0,0 +1,32 @@
+Novatek NT35596 based LCD panels
+
+Novatek NT35596 is a single-chip IC solution for small or medium-sized
+LTPS TFT LCD panels. NT35596 provides  several system interfaces like
+MIPI/SPI/I2C.
+
+Microtech MTF050FHDI-03 is 1080x1920, 4-lane MIPI DSI LCD panel which
+has inbuilt NT35596 IC chip.
+
+Required properties:
+- compatible: must be "novatek,nt35596" and one of
+  * "microtech,mtf050fhdi-03"
+- reset-gpios: a GPIO phandle for the reset pin
+
+Required properties for microtech,mtf050fhdi-03:
+- reg: DSI virtual channel used by that screen
+- dvdd-supply: I/O system regulator
+- avdd-supply: analog regulator for MIPI circuit
+- avee-supply: analog regulator for MIPI circuit
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "microtech,mtf050fhdi-03", "novatek,nt35596";
+	reg = <0>;
+	dvdd-supply = <&reg_dldo2>;	/* VCC-MIPI */
+	avdd-supply = <&reg_dc1sw>;	/* AVDD_5V0 */
+	avee-supply = <&reg_dc1sw>;	/* AVEE_5V */
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

