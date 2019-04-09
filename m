Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B53C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD82208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMmaZesD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfDIOnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:43:08 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52071 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfDIOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:43:02 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so5305288itk.1;
        Tue, 09 Apr 2019 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQEtq5bL3CQj8UaXXdh0HijqXSkyGw7cYWzHm1YH5nY=;
        b=MMmaZesDDYehSATfJ9Mxv22G2Kic0wkAPbmQ1J8Xzcm2qdoxN4Vr1c34t5nddemegq
         q92swbMTO/tkb9BRaOBITDV0p0WyJcZDX5nKYaPELOdRiWeNmGAu9fF4zG8RKe9HA3Aa
         o+qADGV0bALgDjKQij2rU7wgf5yONdP00bQVaQ5UsuJnXg7GXZ3pg8VRaHloOCzA2SSV
         BzKgYwJ109QPe1bGvu3oTSAJzmg4JWKP/W+RWvTD+ikbeNGXf1x8r/pvwipGHLLoOfOj
         6I3n98025D5IIVJ6/nJUw0ND88xJg9k+VDSCv7GA0a9+bW8NZRQ7A7PKmbye0XgcoC2p
         VeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQEtq5bL3CQj8UaXXdh0HijqXSkyGw7cYWzHm1YH5nY=;
        b=Qzy5FnljGoD2KAuOdvhcIpH1YKD13CqeT+Icp5i/+C1OwUWcpYoO/N7O7LhLptSh1R
         s8D9kRBdeCxajK4RSAZlQ76U80L3W43aOX2eEc3khZ5AZN4Dvy8nmkrgCUL6yrTGiKzR
         p2gsb1marIgn+FW1iM0ZQbW2Z2nH/AgtMljl8ybOh2J2LSvzao23SKWOrcGFSY7uaA5z
         b99pPiG/XtZ1OO1h53cvYP/H1KGRnAdO7lEXZVpiT1fq2Awq3qRCrDxrkhDLqfuqcmqz
         UYqGPiacgDeYxvbpIwURpbxvjO8VOFBmXxFFhBuluJpEn+aI9TxgFyE34AJmz1VdHXCn
         boeA==
X-Gm-Message-State: APjAAAWLjA4TTtV/XVq3B4k9L6KaA1hA8Qt6B9Mudls8BEm5UTiDfmrW
        dVBKKCONWvjoX6wkapLG3i0=
X-Google-Smtp-Source: APXvYqycKmmny+cyT+BI/BGmWUDd/Q4MUNPqlwFOo2tfMH5Y7htfd9DOv/UAyiMhRCQWmYg7DUaePA==
X-Received: by 2002:a24:fc06:: with SMTP id b6mr21751044ith.130.1554820981719;
        Tue, 09 Apr 2019 07:43:01 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j10sm6562000itj.32.2019.04.09.07.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:43:01 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v10 4/7] dt-bindings: anybus-controller: document devicetree binding
Date:   Tue,  9 Apr 2019 10:42:47 -0400
Message-Id: <20190409144250.7237-5-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409144250.7237-1-TheSven73@gmail.com>
References: <20190409144250.7237-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds devicetree binding documentation for the
Arcx anybus controller.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../fieldbus/arcx,anybus-controller.txt       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt

diff --git a/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
new file mode 100644
index 000000000000..b1f9474f36d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt
@@ -0,0 +1,71 @@
+* Arcx Anybus-S controller
+
+This chip communicates with the SoC over a parallel bus. It is
+expected that its Device Tree node is specified as the child of a node
+corresponding to the parallel bus used for communication.
+
+Required properties:
+--------------------
+
+  - compatible : The following chip-specific string:
+        "arcx,anybus-controller"
+
+  - reg : three areas:
+	index 0: bus memory area where the cpld registers are located.
+	index 1: bus memory area of the first  host's dual-port ram.
+	index 2: bus memory area of the second host's dual-port ram.
+
+  - reset-gpios : the GPIO pin connected to the reset line of the controller.
+
+  - interrupts : two interrupts:
+		index 0: interrupt connected to the first  host
+		index 1: interrupt connected to the second host
+	Generic interrupt client node bindings are described in
+	interrupt-controller/interrupts.txt
+
+Optional: use of subnodes
+-------------------------
+
+The card connected to a host may need additional properties. These can be
+specified in subnodes to the controller node.
+
+The subnodes are identified by the standard 'reg' property. Which information
+exactly can be specified depends on the bindings for the function driver
+for the subnode.
+
+Required controller node properties when using subnodes:
+- #address-cells: should be one.
+- #size-cells: should be zero.
+
+Required subnode properties:
+- reg: Must contain the host index of the card this subnode describes:
+		<0>	for the first  host on the controller
+		<1>	for the second host on the controller
+	Note that only a single card can be plugged into a host, so the host
+	index uniquely describes the card location.
+
+Example of usage:
+-----------------
+
+This example places the bridge on top of the i.MX WEIM parallel bus, see:
+Documentation/devicetree/bindings/bus/imx-weim.txt
+
+&weim {
+	controller@0,0 {
+		compatible = "arcx,anybus-controller";
+		reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
+		reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>, <5 IRQ_TYPE_LEVEL_LOW>;
+		/* fsl,weim-cs-timing is a i.MX WEIM bus specific property */
+		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
+				0x00000000 0xa0000240 0x00000000>;
+		/* optional subnode for a card plugged into the first host */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		card@0 {
+			reg = <0>;
+			/* card specific properties go here */
+		};
+	};
+};
-- 
2.17.1

