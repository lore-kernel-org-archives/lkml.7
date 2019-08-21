Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED58C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BD022DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ic8dxupL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfHUC4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:56:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39362 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHUC4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:56:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so436237pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=soIydz/rgNKJaCy/gC57Rz46eI4EuGd1mOjpc4LfKIo=;
        b=Ic8dxupL3xZxcnGS16o8Ydv+lcngJuVUr7X4h3XFGrDV1pVWQjv2ZWczkhLo1g2JrP
         GlY3oeUn8eOeyhZ2N0u1MzVAuWFlj84cLk7vGTqw0zVzhACVNolO1ljl/qi2XsoXCE2u
         +EM2u/HqHhJvBLYWXzy+Pl9IqpLaR7JTQMdQ/Ercq7LZhkIw7vCHI63uncItpKfItXDE
         EzrcKzbQFRtHI6RdqRXJ3Aaag2A9fY4RkGf+Zv+CJFyFOQ0vO5p2X793IC9gQUU2b2pO
         mJ8HgyMSilr678FRNVD8KMa+VZjA9fc+Cxgo7akQ7tuntFIZgz+urRp5ew/LqsihLSMs
         vUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=soIydz/rgNKJaCy/gC57Rz46eI4EuGd1mOjpc4LfKIo=;
        b=h/xmK6GMDRA3plCBjUNVivnAwJLr9VMJeoWslTJVP7fZif4kBE5+1TaWd+LNuEjsUP
         CWbBpSRMSnj4/0kUFnE/ELhSacXJgdfh7CbxdVkj9JgWMw6QIEjmDYoBEzK4s8cTg7RG
         Hj/64nILfyj9dULsi/1FSkdO/Tae1COuw05opdKHSK+F2fhkiLejxYjnrMI3Dgam9bvA
         lAG7noNVOsRuBtEc8FtBAhvjZ7X6vo5UNNxGBkOX1pb/1C6j/o6/YU+6MojOY+ocWWP0
         0MEd7GPt1zepMVhEBDiiueIFn0hQoFhi2ryO8LkBtfHCzSatcDGNqm9u/siLo2A4Ep4S
         QuOg==
X-Gm-Message-State: APjAAAW9Qxvy5mehQhbBiRu8qVNI4isR0OmBqFV5F2/+Hzd5BoH0cMqS
        NDg5KOdEYgoSi6tEQ+4vbHTv
X-Google-Smtp-Source: APXvYqx897GzsEFoofdDkQskosAqgrhiKaFJ1of7zLrcRUF0GdrmFpF19QtTv45xPM4v1D/HT17izw==
X-Received: by 2002:a62:7e11:: with SMTP id z17mr3917397pfc.211.1566356204895;
        Tue, 20 Aug 2019 19:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:56:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/7] Add SD/MMC driver for Actions Semi S900 SoC
Date:   Wed, 21 Aug 2019 08:26:22 +0530
Message-Id: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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

Changes in v3:

* Incorporated a review comment from Andreas on board dts patch
* Modified the MAINTAINERS entry for devicetree YAML binding

Changes in v2:

* Converted the devicetree bindings to YAML
* Misc changes to bubblegum devicetree as per the review from Andreas
* Dropped the read/write wrappers and renamed all functions to use owl-
  prefix as per the review from Ulf
* Renamed clk_val_best to owl_clk_val_best and added Reviewed-by tag
  from Stephen

Manivannan Sadhasivam (7):
  clk: actions: Fix factor clk struct member access
  dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
  arm64: dts: actions: Add MMC controller support for S900
  arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
  mmc: Add Actions Semi Owl SoCs SD/MMC driver
  MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
  arm64: configs: Enable Actions Semi platform in defconfig

 .../devicetree/bindings/mmc/owl-mmc.yaml      |  62 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/actions/s900-bubblegum-96.dts    |  62 ++
 arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/actions/owl-factor.c              |   7 +-
 drivers/mmc/host/Kconfig                      |   8 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/owl-mmc.c                    | 696 ++++++++++++++++++
 9 files changed, 880 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 create mode 100644 drivers/mmc/host/owl-mmc.c

-- 
2.17.1

