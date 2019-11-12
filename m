Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74B2C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1A420659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm+j2O9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKLVZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:25:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37472 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:25:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so4535896wmj.2;
        Tue, 12 Nov 2019 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ovnztgvh+YjlTHsYseB2SO/MKj54HI2gxLgPoFzYZS8=;
        b=gm+j2O9JfsEuTxTVR3xlFMKJfSMkYUpr+JT/3GrMHvqkDmJ2s9u2BRRrvyUx8scnNt
         8Rc/gGWRk9W/aYx5qtX1WsitPgpCuod5RxMHKVJ1/UhJR4mAY2eQ9krV4sb2p/T8I/kh
         X9k6Yb/jPMQN5prDeg/TljFZzy/HLS2HZAMf3NXyf/o6nDgJBfjrLQSZEeTGkZ9DRJyI
         eqqjp2I7s959ZzB3Tp06RrzlajyYi1Aw03uL9xyiwjWKA1NwLnu0umsPEueNIXpgaKuC
         qrdoHxp1V0Ro1aEMlOWDPqi6Rg6PynNKKUcAhHCpAZjAvdc2A3o7scswOcCsjctNbL4d
         Eleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ovnztgvh+YjlTHsYseB2SO/MKj54HI2gxLgPoFzYZS8=;
        b=fd5bIUIEOETjJ57N41CvjAevZ0MCp/sUVTpWp8gg8n30wlMEDxSLMt2LdxjBc/LhsP
         MZCB4dVDHjgfch3+vH7Vu/APCoUY8GkHIGXb15PKjHV0plkOJg21y0pke3kTkqu2iwwx
         dOgJedZxDaagJ/S9cDVC54mkuF7e6TbKkIC54JGjvhun0hzQVz3GCpTQeVxEE6nVEqOi
         x5y4NN2Sv5vwk0jwJPszaDpk5zZvJ1wlJOe18q8oft2q7JNsVqMasXspBEo5gtijc1o5
         OIYT8Ne/W+If2EcFlovj7MQ5J7nzGp9wjLN0oOAAuTvBjakM385v3EP5gXYIViU7To/A
         xeVA==
X-Gm-Message-State: APjAAAXo5ED88OHb8/SJ0hMK86EWWmNj7JS9kDsNRQatSPRr9yF8Lok2
        WW7QjkdKDz0sw4WyCgAjwas=
X-Google-Smtp-Source: APXvYqwQC/q+HPqT0NGODc7slJk8kQcmcV51PKGD7WhIrpw2rsf8PHrHOoZEdYlJlWy+dcqZQU4yJw==
X-Received: by 2002:a1c:1f14:: with SMTP id f20mr5371523wmf.147.1573593910336;
        Tue, 12 Nov 2019 13:25:10 -0800 (PST)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id z17sm136988wrh.57.2019.11.12.13.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 13:25:09 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, m.felsch@pengutronix.de,
        narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] dt-bindings: arm: fsl: Add Variscite i.MX6UL compatibles
Date:   Tue, 12 Nov 2019 22:24:39 +0100
Message-Id: <1573593892-25693-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
References: <1573586526-15007-4-git-send-email-oliver.graute@gmail.com>
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles for Variscite i.MX6UL compatibles

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f79683a..d0c7e60 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -182,6 +182,7 @@ properties:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
               - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
               - kontron,imx6ul-n6311-som  # Kontron N6311 SOM
+              - variscite,6ulcustomboard" # i.MX UltraLite Carrier-board
           - const: fsl,imx6ul
 
       - description: Kontron N6310 S Board
-- 
2.7.4

