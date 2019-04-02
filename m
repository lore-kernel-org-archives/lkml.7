Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF955C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A298F2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWimYmqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbfDBTcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:32:20 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50474 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:32:19 -0400
Received: by mail-it1-f196.google.com with SMTP id q14so7211695itk.0;
        Tue, 02 Apr 2019 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xHwX7N1RZtbO0BzmhJG1pDFtWgUBQ/UisLEym+aQ4Nc=;
        b=rWimYmqHtDgbCxlsnXvUGJpIxkI63OM170yLErYsFvxcd0vSq+zQtc/Par6O9kvNBJ
         zFyHykGVP5PntmHKHrLZy9brHjVRBth/XvNlJnGi3nehxf+Vn7TvtVt2bskBOFyuUO09
         qU5rtiBWvt5sj088KSdfoICC8PJQY40rUoqLrv1ac2IHHyjkYaQCJ+qYxtDtelCdsGhm
         eXbQ8KxmhAccexzQXNs9Fa39Ex6omZrSdeSvtagVxHTMW8gqQeNoLwmc1cb3S65Zaxfc
         RDmLBPNCpFTB4JAsjHexnYKs0XeEhp8jmfe2mRZrrDHKavzMfEMDGdB1h2w4e5ZEm8XN
         zLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xHwX7N1RZtbO0BzmhJG1pDFtWgUBQ/UisLEym+aQ4Nc=;
        b=ach9M5Z+0oeMbUzajDKNAt9iDC6I09WSF3HtV0CQkSXZAS6mn3u2At1vwjTCpdKYsb
         jj2OgWkDLcKVXU+Ax7IB2uZLewPx8mPTijeLu9Qlhhv36BNp0hJklxeCxIfsnznsZjeI
         bEtUftHii/W//Zs4SfWcLbhC2ZRbUQtTFV90IZad5bZjLLlS0r/95ac+906rwUoHrqC0
         QqlDbLGQgY3P2XMaLM3MZGXV88MjqUN4MZ/1q/pspm9khLtynB/BXqKCW3mGQOrXrwSi
         H8iG/9WfOiewJenYQzTLoP0Gji/GQD+o13MDfb5yWiujefnGoneqF3q2l1oJgdWAeODZ
         uV6g==
X-Gm-Message-State: APjAAAXWL5BmFTDwCIKPTpvNAE6UT+wyjINxRMZwkU2/M5a3A9agLp29
        yut8D8ji1LD19QA3YGJwqdE=
X-Google-Smtp-Source: APXvYqyShfHs+0zc4tkF4ve19J8mwhfRPFCnfbhA5gj3uHrWM4YLWiMnVmH5dx7yFoW8Y5RRAaj38g==
X-Received: by 2002:a24:d45:: with SMTP id 66mr2231163itx.9.1554233538962;
        Tue, 02 Apr 2019 12:32:18 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id f204sm7654219itc.26.2019.04.02.12.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:32:17 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6q-logicpd: Reduce inrush current on USBH1
Date:   Tue,  2 Apr 2019 14:32:04 -0500
Message-Id: <20190402193204.4745-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some USB peripherals draw more power, and the sourcing regulator
take a little time to turn on.  This patch fixes an issue where
some devices occasionally do not get detected, because the power
isn't quite ready when communication starts, so we add a bit
of a delay.

Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
i.MX6QD EVM")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
index db6b5b900826..7731db493cb0 100644
--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -88,6 +88,7 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
 		enable-active-high;
 	};
 
-- 
2.17.1

