Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB1C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B396320818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUZbp0wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLTWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:22:19 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39814 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLTWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:22:19 -0500
Received: by mail-wm1-f48.google.com with SMTP id t26so4197660wmi.4;
        Tue, 12 Nov 2019 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DK1TigpUcHQJNflpowdTvpChCBocE4D3Y+EycO3ByNQ=;
        b=fUZbp0wJQKnuvlyQ/8lhb56UMwzHp57y0zS0nTSrIC9yFycxpBHvb6ZY9TD5CFupcr
         WMaj4w888FD8AonwI9SKk1tJ+ohGzrelCbSTEOoy9mDdyJ52gaD+3+dsy22taRvxWatM
         QIf+hapJkSTdebS82ZBlDVxcl6inKQGyGsQIYH9nE63Ma23cfT/l50mGxwukp4+8R5a2
         H6QSe1t9dkPfAm1lW8xOEmkxrmXZ8BbJ096KRfNVKn4gkh44ivcbgjGNNAqPuGSA6fSV
         MRXT1F2JgHyzYJjj9/bzJJ4cfnHlGozuUZ9GL9AxmjRdUYfW6l8bVa4t9bSzLLf9CkEn
         vSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DK1TigpUcHQJNflpowdTvpChCBocE4D3Y+EycO3ByNQ=;
        b=IkfNB/m1lKZffFyrzXA1ROUGv2/f6hwXYNLffWw4erCkHcfLccs+006lwaaipD5HC/
         GyRAyx1DC9vAddJH8G1No4tWe+e2IdBbKPymX6aVQIJ+B18XYSX5vAOXsCf7baHD3irp
         srNRczXZalAWl4+CzhCPNfvpZkWsll15sCtJgxCRyRlLedF8/fhpe5Wv2K7PyWXcaafb
         n5URfx7LeVQEeCgifghEnh/7fDMR8Rkku7nIXd+BPKhmv+butmgnj8/PPH95Az9ixoma
         WAl8ZDloPLdBiv5UiWB7I3LE//rJeyPW7bNMHkIm4Uk3fCsQNfoJ0KoeDyE2NqN0w4FJ
         +Ytg==
X-Gm-Message-State: APjAAAUW5yVfRNiu8K4n3ggYNbMVh6Hz/6rsIdRpx/Bykv6g+mdUt3ze
        Bq4L8h8NNfU6Dv8mS05MEmI=
X-Google-Smtp-Source: APXvYqyrtxscRr7w1XVSIDALlk46izl0+i27FRwaiNmrZGNu2z6zghPCCQifyckfWHAP6I51LFCZYg==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr5879571wmc.113.1573586537127;
        Tue, 12 Nov 2019 11:22:17 -0800 (PST)
Received: from localhost (ip1f113d5e.dynamic.kabel-deutschland.de. [31.17.61.94])
        by smtp.gmail.com with ESMTPSA id h15sm18860481wrb.44.2019.11.12.11.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 11:22:16 -0800 (PST)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, m.felsch@pengutronix.de,
        narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv7 0/3] Variscite DART-6UL SoM support
Date:   Tue, 12 Nov 2019 20:22:00 +0100
Message-Id: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Variscite DART-6UL SoM

Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits

Oliver Graute (3):
  ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
  ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard
  dt-bindings: arm64: fsl: Add Variscite i.MX6UL compatibles

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 367 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 221 +++++++++++++
 4 files changed, 590 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts

-- 
2.7.4

