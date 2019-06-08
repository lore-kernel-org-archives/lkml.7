Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CEBC468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E3D2168B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qmma1PwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfFHTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:53:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44174 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfFHTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:53:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so3017765pfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y4R+1O2JCF2sqyz0/RUxgRqX037Zf7Xz8+zI8QsEWlE=;
        b=Qmma1PwAldxzd2MM/p3res/Gcc/x5TAFEAC1p/QPRvFRAQm/2TXCS1FgMsS0p+MADA
         NxYVXKYgitXSUQIrtnBJ2K9hUNnzHvLJoltYx5Xl5v6AmkpPl1sMz834YlszFktEMY29
         4WQHnHhnGf20gu6gqDAAx4xhfxUnG63QqdlQ1jD2N5ClNsVmk2pT36ILXXAQ7FzvUfAB
         yhmSeE+TC275JwCydhX395OMgLyQo783CAxggL+vRclS5ttGwpFwHux0CH8rHTPk92Pb
         6r3ZNdbrGQv3gN1dNfvtlIek6Ei+71GWtjeJamvCirAtGQObgTYN5JP3BrqSXEZQ2Xn+
         qHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y4R+1O2JCF2sqyz0/RUxgRqX037Zf7Xz8+zI8QsEWlE=;
        b=OShUWrX2ii8YNnLABoqhTFAmSdk7EM6UfOSjNVCl7v7dTr5jTTWU37E94LUQmaplF5
         T2dSbRbuXX12uzjcHjNqYiZLC/P8EdBCnbCZJTDeeAlWaLfihmv330v9D3JsyEG20nsJ
         r85tligyLbPZ7xSHZPdUWNZqB8p5OsnRuEve3FJDXaHbR2qupOYh553/FoeQmbhEXGnl
         DEghiQ/XjNPi/fVzV50tzHaUD9VqMK/YNF0VDOfGCDqMFsG/E5dmxhi3VCna5DVlNVNS
         1MX70gfm0luNwlKNq5JXSb4Z596dTMPURumu68YrhuDAWFXkmeLWt1tIuYpldqpacWdT
         7p/w==
X-Gm-Message-State: APjAAAWh3O12Ag/wOKhZBiKKxRh6wgSTgnG4y03r4OVS/63f1POaOB84
        a5FaZ6k/UEFII5IFb6r4JJNw
X-Google-Smtp-Source: APXvYqy5srgqec+REUk7+2CL2ALjfdnslRmdg1t73+gSHiRrm5XVwFsFfj8jbOA5sr6K2oMDGQfKwA==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr8567873pgm.270.1560023616972;
        Sat, 08 Jun 2019 12:53:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7185:fba9:ec1e:ad07:23ac:d3ee])
        by smtp.gmail.com with ESMTPSA id b35sm6034377pjc.15.2019.06.08.12.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:53:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/7] Add SD/MMC driver for Actions Semi S900 SoC
Date:   Sun,  9 Jun 2019 01:23:10 +0530
Message-Id: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds SD/MMC driver for Actions Semi S900 SoC from Owl
family SoCs. There are 4 SD/MMC controller present in this SoC but
only 2 are enabled currently for Bubblegum96 board to access uSD and
onboard eMMC. SDIO support for this driver is not currently implemented.

Note: Currently, driver uses 2 completion mechanisms for maintaining
the coherency between SDC and DMA interrupts and I know that it is not
efficient. Hence, I'd like to hear any suggestions for reimplementing
the logic if anyone has.

With this driver, this patchset also fixes one clk driver issue and enables
the Actions Semi platform in ARM64 defconfig.

Thanks,
Mani

Manivannan Sadhasivam (7):
  clk: actions: Fix factor clk struct member access
  dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
  arm64: dts: actions: Add MMC controller support for S900
  arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
  mmc: Add Actions Semi Owl SoCs SD/MMC driver
  MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
  arm64: configs: Enable Actions Semi platform in defconfig

 .../devicetree/bindings/mmc/owl-mmc.txt       |  37 +
 MAINTAINERS                                   |   2 +
 .../boot/dts/actions/s900-bubblegum-96.dts    |  50 ++
 arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/actions/owl-factor.c              |   7 +-
 drivers/mmc/host/Kconfig                      |   8 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/owl-mmc.c                    | 705 ++++++++++++++++++
 9 files changed, 852 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.txt
 create mode 100644 drivers/mmc/host/owl-mmc.c

-- 
2.17.1

