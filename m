Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ADDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D4621848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfHZPj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37489 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733080AbfHZPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so15806775wrt.4;
        Mon, 26 Aug 2019 08:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rCIaYhy19uhXqC3cBNmvWggUiwiZruQsnEVhDd61mE=;
        b=sD1CuSzQvWhR23G3qCHetdlB2WpWRN3KHeFCCQEtGFnDuEGxQH39AKPzMaIRM5Ma8+
         /fbaZj9gd9FLAc/K73uSH4gUHeKUZ60OxmMK4suZa1etc6GmvZ2IkMZWqzPlhP2DluQo
         8LvUXBPD8qQTF2bNvewi0AaCKbNDoswJJkVV7/xEGIGl7Ya3y2OCguD8aNcKqAohoeeW
         jskBdvv2aaKo93Bhnfb7/4AM+wfXYcifNH+0Pbw+PeQhV23A/PDs1Gm5boGOQxkvJHre
         aZDueiiS3CaWB3f2kW9dCO8pOgOBU9sfdtIMqKqIYr/h7ZJ+ubEdjUhZsj4zEvDw8iHv
         7YWg==
X-Gm-Message-State: APjAAAWMLDRwjbA/JDioRCAeph0L+DMNsFKNBAOUJxbzN6GTJKF8tEt0
        zsQ/YdowJbV+coveiduEecxUtlBDVug=
X-Google-Smtp-Source: APXvYqzz9bVlQdXc7SzziaVbdiGF8boBNGBFFqyPOelinM1tHX9oibhkShJbp6vuG99X/Ilm2U7GiA==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr22393884wrw.159.1566833931686;
        Mon, 26 Aug 2019 08:38:51 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:51 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/12] ARM: dts: imx7d: cl-som-imx7: add SMSC USB3503 usb hub
Date:   Mon, 26 Aug 2019 16:37:57 +0100
Message-Id: <20190826153800.35400-9-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the SoM design, add the SMSC USB3503 that is
used as a PHY in hardware-only mode, connected
to the imx7d's &usbh interface, providing additional
USB ports for USB and mini-PCIe.

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index f80be855b4ec..a16cbb070a12 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -22,6 +22,12 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
+
+	/* SMSC USB3503 connected to &usbh */
+	usb_hub: usb-hub {
+		compatible = "smsc,usb3503";
+		reset-gpios = <&pca9555 6 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &cpu0 {
-- 
2.23.0.rc1

