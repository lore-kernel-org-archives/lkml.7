Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B97C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456E824670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUh88S/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFSpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:45:46 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46209 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:45:46 -0500
Received: by mail-pl1-f172.google.com with SMTP id k20so3057117pll.13;
        Fri, 06 Dec 2019 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fi0v276DytflAY2h044Dlr4Bh1mkN9HRCT9MVIFntkY=;
        b=kUh88S/sioS4h6odf8ciymAoRA+iF6r6am/1niCdnSLdPozYU9dH9/TqVtEM0FdTqJ
         DvARn1aA34ayQ9UgeiGdEylxIUc+/5D7F2McVzdOShdS6npIMJf73uC1lZABX0pr9ve1
         em8TXNYcm/OxQkkFoL9030k/+5snXhw1KXnB2Ys5jiDv2BGTLwNtZ1DKQ7EBGPPuWvz6
         a2IVyzKZnPoryhDfFVikzF01PPJiDI4yV2DXl0/pe2zEqnPK29qUY+kQkLjPfXeRtMQt
         re7GZ7QNKP3dHIooQsBlP0V8NxxJEchC4kj2a6TnD+5uPLpOMnQ0a+Bm2M6HtEhFwXDx
         3tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fi0v276DytflAY2h044Dlr4Bh1mkN9HRCT9MVIFntkY=;
        b=lFLdqRlyrKXV4MYO3A1jpFWUTxWdaFIyvbKj+SRizOR2LhT+bJJtFx78drqBzOOUhl
         7vcHT0WIWhd4smyTl/FaMPpLNWTae2+hqe/iAWhbDmM3vaRf9VKyjzWhAG9NaYPT6UTC
         frbt7HMXQWRDLAd7do00CViNaUXWyyFw5Rzi6ciafhKZC5jWHUjZFaAEXWSroT8xfr5o
         aj/FYNXAa1E3DI6Av6K0dxPhuwSrSz37tj0Q7wG5RhBwxr7mhAiZBCRuEb8nh8Yf7UI3
         wxZ3CSyagr1iL8uDC4LDl67/cidjb8k21dcoOD+RRQq5oEVs7VtkohY5datVeTmMA+Fk
         3r7Q==
X-Gm-Message-State: APjAAAUzNThomtqt7GLqdZvBssP0uoNDXEb+xRiW9XGTEXRYiremT/lZ
        mjJEY5CuwoyNnXJqwpaHWYU=
X-Google-Smtp-Source: APXvYqzFULyrWU1raYozRu6SwmVgDm85vacQym1/ejWbOJHlKBERhL2ywaXfNAK4/2L+wy8DtxUqpA==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr17241511pjn.60.1575657945401;
        Fri, 06 Dec 2019 10:45:45 -0800 (PST)
Received: from localhost.localdomain ([103.51.73.190])
        by smtp.gmail.com with ESMTPSA id p4sm16777039pfb.157.2019.12.06.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 10:45:44 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 0/8] RK3399 clean shutdown issue
Date:   Fri,  6 Dec 2019 18:45:28 +0000
Message-Id: <20191206184536.2507-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the RK3399 SBC boards do not perform clean
shutdown and clean reboot.

These patches try to help resolve the issue with proper
shutdown by turning off the PMIC.

For reference 
RK805 PMCI data sheet:
[0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
RK808 PMIC data sheet:
[1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
RK817 PMIC data sheet:
[2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf 
RK818 PMIC data sheet:
[3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf

Reboot issue:
My guess is that we need to some proper sequence of
setting to PMCI to perform clean.

If you have any input please share them.

Tested on SBC
Rock960 Model A
Odroid N1
Rock64

-Anand Moon

Anand Moon (8):
  mfd: rk808: Refactor shutdown functions
  mfd: rk808: use syscore for RK805 PMIC shutdown
  mfd: rk808: use syscore for RK808 PMIC shutdown
  mfd: rk808: use syscore for RK818 PMIC shutdown
  mfd: rk808: cleanup unused function pointer
  mfd: rk808: use common syscore for all PMCI for clean shutdown
  arm64: rockchip: drop unused field from rk8xx i2c node
  arm: rockchip: drop unused field from rk8xx i2c node

 arch/arm/boot/dts/rk3036-kylin.dts            |   1 -
 arch/arm/boot/dts/rk3188-px3-evb.dts          |   1 -
 arch/arm/boot/dts/rk3288-evb-rk808.dts        |   1 -
 arch/arm/boot/dts/rk3288-phycore-som.dtsi     |   1 -
 arch/arm/boot/dts/rk3288-popmetal.dts         |   1 -
 arch/arm/boot/dts/rk3288-tinker.dtsi          |   1 -
 arch/arm/boot/dts/rk3288-veyron.dtsi          |   1 -
 arch/arm/boot/dts/rk3288-vyasa.dts            |   1 -
 arch/arm/boot/dts/rv1108-elgin-r1.dts         |   1 -
 arch/arm/boot/dts/rv1108-evb.dts              |   1 -
 arch/arm64/boot/dts/rockchip/px30-evb.dts     |   1 -
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts    |   1 -
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts   |   1 -
 .../arm64/boot/dts/rockchip/rk3328-roc-cc.dts |   1 -
 .../arm64/boot/dts/rockchip/rk3328-rock64.dts |   1 -
 .../boot/dts/rockchip/rk3368-geekbox.dts      |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi |   1 -
 .../boot/dts/rockchip/rk3368-px5-evb.dts      |   1 -
 .../boot/dts/rockchip/rk3399-firefly.dts      |   1 -
 .../boot/dts/rockchip/rk3399-hugsun-x99.dts   |   1 -
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |   1 -
 .../boot/dts/rockchip/rk3399-leez-p710.dts    |   1 -
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |   1 -
 .../boot/dts/rockchip/rk3399-orangepi.dts     |   1 -
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi |   1 -
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |   1 -
 .../boot/dts/rockchip/rk3399-rock-pi-4.dts    |   1 -
 .../boot/dts/rockchip/rk3399-rock960.dtsi     |   1 -
 .../boot/dts/rockchip/rk3399-rockpro64.dts    |   1 -
 .../boot/dts/rockchip/rk3399-sapphire.dtsi    |   1 -
 drivers/mfd/rk808.c                           | 144 +++++-------------
 include/linux/mfd/rk808.h                     |   2 -
 32 files changed, 42 insertions(+), 134 deletions(-)

-- 
2.24.0

