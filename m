Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDCCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438E22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3rC41n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCRSD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:03:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37815 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfCRSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:03:55 -0400
Received: by mail-it1-f193.google.com with SMTP id z124so22778058itc.2;
        Mon, 18 Mar 2019 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQEtq5bL3CQj8UaXXdh0HijqXSkyGw7cYWzHm1YH5nY=;
        b=l3rC41n5DyyTvn4vSn87S24Sv3BsAeF/vfoptzNiVZNdIkraWi52lTf0KPKBOAMd82
         NMYbmnP66s7hYylYKb2d/0v5HA35Ypmk2kMKVpd4cpiKcdZF9q4EDFACwXSpCIA6PSfH
         8t0e0zmSTFhKod9OLxQT+EnKISfw95YpdcDsrxHqdXPkxoUXcdV0rcoLIT5HPJWuaBSi
         SNPTyc3hC4OlLIOcTFl6NjA7vPRnc/4ac660O/bibMAkYmzpxugVuZftqbFBZXUyNakp
         wtzBo+JqwKxvNsB7WtZmpoqW+0VyD40wKAp9mQIMFFTK5RXhaKktBnG/ejf+rdie1I/o
         iJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQEtq5bL3CQj8UaXXdh0HijqXSkyGw7cYWzHm1YH5nY=;
        b=WnNyLEvBmgtBjscHWZU2kkOs5Xyz5XcSHmXwgKqzC1XtsQvL7AdpNzusHJmEos8Bl6
         DZdwHznSo9UWas1mKNJIXz14QyPl+1yYo1HAiXtpyQtYk3fWqSl/4eSGWyF6pQtUaRow
         hYhJr7hw6CT0TsmbC9thJRdOXTve0/X5CL3+9Cca75VRf4Cj4atKIfvv9+pDpo6U413W
         OSO34RoHJuuk7hpqq3mQZVnyWvFexY7UodTcvxIklje/1HZs2frNyKkgk0RTzZv7jGE8
         06/9bFZwgAEw/vGdtJD5+eE/Gvtx4ya7mQ6o/3iPVtb+PAo1DVRrKw6ixcY2qBVQtvSa
         ztHQ==
X-Gm-Message-State: APjAAAXOVZMchei5y5AOUg1gadrvZQP3tS0StjE4jFAqHJOwza+Wy87J
        TI8FFn28f1lO3Vr98/DPiPM=
X-Google-Smtp-Source: APXvYqyfQ5Bf/nZmU0oH5s485EB0VzvZdqKf0k4X+bzlrF9pAayY+tCir3/4rnUTuP6pwG4rm3AFAA==
X-Received: by 2002:a24:6910:: with SMTP id e16mr108029itc.116.1552932233796;
        Mon, 18 Mar 2019 11:03:53 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 76sm9956itk.40.2019.03.18.11.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:03:52 -0700 (PDT)
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
        linux-netdev@vger.kernel.org
Subject: [PATCH v9 4/6] dt-bindings: anybus-controller: document devicetree binding
Date:   Mon, 18 Mar 2019 14:03:36 -0400
Message-Id: <20190318180338.23964-5-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318180338.23964-1-TheSven73@gmail.com>
References: <20190318180338.23964-1-TheSven73@gmail.com>
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

