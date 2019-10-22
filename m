Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D1CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D053214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKMWbGUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfJVEFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:05:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41681 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJVEFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:05:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so9775762pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CD4Ry27tfT/ul2M0hAWg1+r/2u5+J2xa4393NWU742M=;
        b=OKMWbGUWfSu4seLAYx7h6cgAfLj2eeU1bFWbmwtKrl5Zao4lNRCItpJmWUF+KN6irx
         PdBAsDzslSaEMtgGXKmoFuOPatemVYY9dYwBMNwEVTbPgvs49wkw++DxMfrdirdvQJmS
         ZycK56sKUSEC5yCIekkToO++5CBISys/7aGXUAuZXTNCwLypOQ7jAnt85epAMbEHra6f
         jMbyLMtXiNx1hoVJE0JnViIAAR1hyW7VxFGEj1ZVWJi0V/qbZ31MMPtAMvadjOjCwCNQ
         p7+mSMj3Ht+Iz59QDosH0fcHdukkI5WzZLqolIQA/+tSAQVnjFSPIFGPcFNF/pHamloB
         fRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CD4Ry27tfT/ul2M0hAWg1+r/2u5+J2xa4393NWU742M=;
        b=XDp5UvPw4+2M/GvEE+IIL7dtxzilMAuMNhf+Ag5PtqH7gM3r6UQr7U2VeogvFsFwiX
         /lk/RRqD08+MKZC8awDmOmRfpOfb7Oj0zLomw4sAYws3ZmSi3B8CaHWLhXUYl6nB3mby
         HWaS6VFn13RpeVlrQ2rq2/5TUNzu1sSlWUa+ZV6AEHtIIC8vhMCZP2mQsKdj26Bzf/ka
         y47nF25ZGaKzpHrDwDR71bcjEomd6Q3L2ykl+ro3UlpiV6g87FzjMAn2mcs+4Wr44EOq
         jukGuhr+h0pQD3wQ4HBkxJAHemiYUHq6jpobImjecI5nmVgMzENXO8p5LIXGRxPBsJ3Z
         IdtQ==
X-Gm-Message-State: APjAAAVPN0JKMZdbHyns/S+lnMiuTucoeo6tdlDRuz24YJaxBTOqV2S2
        MEo6WFpo6m4SnrVvXfTSxzM=
X-Google-Smtp-Source: APXvYqx2tF/v+wSQuX21by2faNJ8DJKymiZbFtaGwGJQKxl3gr9C175dnBB5hYt6r4ABCvlevmoyKw==
X-Received: by 2002:a62:6842:: with SMTP id d63mr1758351pfc.16.1571717118671;
        Mon, 21 Oct 2019 21:05:18 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id n3sm18778738pff.102.2019.10.21.21.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 21:05:17 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: imx6qdl-zii-rdu2: Fix accelerometer interrupt-names
Date:   Mon, 21 Oct 2019 21:04:59 -0700
Message-Id: <20191022040500.18548-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022040500.18548-1-andrew.smirnov@gmail.com>
References: <20191022040500.18548-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/devicetree/bindings/iio/accel/mma8452.txt,
the correct interrupt-names are "INT1" and "INT2", so fix them
accordingly.

While at it, modify the node to only specify "INT2" since providing
two interrupts is not necessary or useful (the driver will only use
one).

Signed-off-by: Fabio Estevam <festevam@gmail.com>
[andrew.smirnov@gmail.com modified the patch to drop INT1]
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---

Original patch from Fabio can be seen here:

https://lore.kernel.org/linux-arm-kernel/20191010125300.2822-1-festevam@gmail.com/

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 8d46f7b2722b..a8c86e621b49 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -358,8 +358,8 @@
 		compatible = "fsl,mma8451";
 		reg = <0x1c>;
 		interrupt-parent = <&gpio1>;
-		interrupt-names = "int1", "int2";
-		interrupts = <18 IRQ_TYPE_LEVEL_LOW>, <20 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "INT2";
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
 	};
 
 	hpa2: amp@60 {
@@ -849,7 +849,6 @@
 &iomuxc {
 	pinctrl_accel: accelgrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__GPIO1_IO18		0x4001b000
 			MX6QDL_PAD_SD1_CLK__GPIO1_IO20		0x4001b000
 		>;
 	};
-- 
2.21.0

