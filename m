Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE23C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460C21707
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCG5JA+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEYQi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:38:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33577 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfEYQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:38:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so12841990wrx.0;
        Sat, 25 May 2019 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1PyjslIuFkdLZ1LECH2oSAMmTt5Um4BAQa4nOZIt94=;
        b=ZCG5JA+bIRDyleKl2mXDSKEp9k5JUA0n0iBeFRwDKw1Fs5sbHew+pHrqpO+AVaYcDk
         GbQOzYLEetuN7tzq4YO2itG3MCd0VrWiWvlBNLP94BenthcKgYrio9BbozLM3VDqavWR
         Lo3Fwl8QSY+FZ9HXd2H4JNg7yUGxpNKQ491HSncL5MczBDs8dD7y9dFezntMKpIq+L51
         w1KoNwprxk7lGvNIy+iEbrJSSNU3qpKTgUCgSLso/uqyZVSNyiOJc9LXQcUx3+4ZSUAX
         H0m3RQkTcQ2B2h/17Gf96fzMNShsQRNGONnkY7JcSB0If1UlSrdDXOecxZnumgXMJcEq
         RWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1PyjslIuFkdLZ1LECH2oSAMmTt5Um4BAQa4nOZIt94=;
        b=Bo+QOThZNsb0D2Be3NXIbRR1vNwoj+9KZblWOQQNpb6MTaAThycfuVEr3cynyPLWdu
         +sqh695f0eDMTkP7b5gaUrC2SEG7Jd0Z2iCDdOqmJXENlmPJeh4kokq0BiB6aa6LTtQa
         jW9RA3l9UtCKImuXhqxD5lMHd70qK4iRDd4FDIVcixGMMBNE2zYSRfASGlgwIvEMNLfU
         J9hDsgsBHAJdBgv981uk+tNo1dfomAU8oRcry6LnrvHrpt3oeCPiK33a1th8cKkraMsd
         5eagUAoh6y/YtyljHEdXMRVlL4oIIpq6ufFYkB7nQZ0qybf81hsKshpw0MLgsrAkEgeD
         3ozg==
X-Gm-Message-State: APjAAAXEp+f2tF7QaC214WZivr7R2qhaNgyRgktehoamY0PCt0FVQdrS
        gxkSx2J6a6NJ5OkK2u44zew=
X-Google-Smtp-Source: APXvYqz78k3LlnXP7jY3H0OnrSSVjujSRE2IRywudpy2P67AUT4Fy3Xl69vJWmYaBl5Bg9zioHfo+Q==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr7769108wrw.309.1558802305724;
        Sat, 25 May 2019 09:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id f65sm9306498wmg.45.2019.05.25.09.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 09:38:25 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/7] Allwinner H6 DMA support
Date:   Sat, 25 May 2019 18:38:12 +0200
Message-Id: <20190525163819.21055-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series has been first proposed by Jernej Skrabec[1].
As this series is mandatory for SPDIF/I2S support and because he is
busy on Cedrus stuff. I asked him to make the minor change requested
and repost it.
Authorship remains to him.

I have tested this series with SPDIF driver and added a patch to enable
DMA_SUN6I_CONFIG for arm64.

Original Post:
"
DMA engine engine on H6 almost the same as on older SoCs. The biggest
difference is that it has slightly rearranged bits in registers and
it needs additional clock, probably due to iommu.

These patches were tested with I2S connected to HDMI. I2S needs
additional patches which will be sent later.

Please take a look.

Best regards,
Jernej
"

Thanks,
Clément

Changes since v1:
 - Enable DMA_SUN6I in arm64 defconfig
 - Change mbus_clk to has_mbus_clk
 - Collect Rob H. reviewed-by

Clément Péron (1):
  arm64: defconfig: enable Allwinner DMA drivers

Jernej Skrabec (6):
  dt-bindings: arm64: allwinner: h6: Add binding for DMA controller
  dmaengine: sun6i: Add a quirk for additional mbus clock
  dmaengine: sun6i: Add a quirk for setting DRQ fields
  dmaengine: sun6i: Add a quirk for setting mode fields
  dmaengine: sun6i: Add support for H6 DMA
  arm64: dts: allwinner: h6: Add DMA node

 .../devicetree/bindings/dma/sun6i-dma.txt     |   9 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  12 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/dma/sun6i-dma.c                       | 147 +++++++++++++-----
 4 files changed, 132 insertions(+), 37 deletions(-)

-- 
2.20.1

