Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B963C21850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KUlQvi09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfJ0QXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:23:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35198 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfJ0QXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:23:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so7384609wrb.2;
        Sun, 27 Oct 2019 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHh2wTvDV7QQYeDnQO2gSOBLNsofT3XUbH0CNdaqVwQ=;
        b=KUlQvi090P07yc00xZbpnA38RqozC6gRBuSVoaFEKscMs68UnSExgUqVsSQHQc2uYJ
         IpZUIUqNdvpapTouYOP74UN7kLw7dO+gsAi6bYSKXS+5kqC2zcaBnJvhwbxoZYOHt2ZA
         8eXPaUzfYQ04gsezKrtuPaIQUXlbdtaVdLpytujuklJliVD+dP5lMqkSXQOf9jPOBVVt
         fgUSME/UKfvLRTzgwKghLba7fF1q42UIGYZkiwYapnTwcjyP0TbBC79Ia9thpIjHOmQ8
         qWEbEjOn6yrEmW7vaz0FsjRfQ99Z2ki3dCOllrn029X21iSTG1Vxp+8lmsBagasc8MAT
         I7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VHh2wTvDV7QQYeDnQO2gSOBLNsofT3XUbH0CNdaqVwQ=;
        b=CetkBQ6eHKOPIyxaKd5JOLDADS4+1iAzje5ckVRDQU0I+lifUrqnS+e3F6Q7ejn4D+
         /Ntnd/FJmbz4CU67oEvFBva7KzxXrmbnYHanEKYFblTolNSLTuvt6g8JosLXq0lT8IVc
         VoI5rL32iwL0tBprPhF65QqzKfcytFrDS9Jan/ujGydp+HkTp9i5iMUTJbU5tdURJ2hJ
         kKPODDUHM6QuELRbAHdURg3BTIMCz1bEcajx1X6ckQx9iQ5O68yZdGkhOI2xeMw5N0Y2
         aap/fUpoo6U2b8NLkyS1mtDy8+mgL+Dj+nb2dxSScJKrzTMbw5zMw1O1VB6aO7NuPNwT
         cOlQ==
X-Gm-Message-State: APjAAAVwSRKZGXZDNyWPuaw+cqXvIe7iuKTCYx6uoBZ3h1LM9Spmt51S
        9ZOeIIVhFXp1ZRU1tFX2hwONnXYfyQnrZQ==
X-Google-Smtp-Source: APXvYqyCYGYmCvPNcNbH87Xqtct4wBPQgN4aJcAyg1RyMkX/chRC6UMEk/wYRQMsMbtgwGug5mVA0w==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr11522180wrn.307.1572193419899;
        Sun, 27 Oct 2019 09:23:39 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 1sm8243299wrr.16.2019.10.27.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:23:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/5] add the DDR clock controller on Meson8 and Meson8b
Date:   Sun, 27 Oct 2019 17:23:23 +0100
Message-Id: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson8 and Meson8b SoCs embed a DDR clock controller in their MMCBUS
registers. This series:
- adds support for this DDR clock controller (patches 0 and 1)
- wires up the DDR PLL as input for two audio clocks (patches 2 and 3)
- adds the DDR clock controller to meson8.dtsi and meson8b.dtsi

Special thanks go out to Alexandre Mergnat for switching the Amlogic
clock drivers over to parent_hws and parent_data. That made this series
a lot easier for me!

This series depends on v2 my other series from [0]:
"provide the XTAL clock via OF on Meson8/8b/8m2"

Changes since v1 at [1]:
- fixed the license of the .yaml binding and added Rob's Reviewed-by
- drop unused syscon.h include (spotted by Jerome - thanks)
- drop fast_io from regmap_config and add max_register as suggested
  by Jerome
- dropped original patch #4 "clk: meson: meson8b: add the ddr_pll
  input for the audio clocks" because I could not test that yet (that
  patch was a forward-port from Amlogic's 3.10 BSP kernel)


[0] https://patchwork.kernel.org/cover/11214189/
[1] https://patchwork.kernel.org/cover/11155553/


Martin Blumenstingl (5):
  dt-bindings: clock: add the Amlogic Meson8 DDR clock controller
    binding
  clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller
  clk: meson: meson8b: use of_clk_hw_register to register the clocks
  ARM: dts: meson8: add the DDR clock controller
  ARM: dts: meson8b: add the DDR clock controller

 .../clock/amlogic,meson8-ddr-clkc.yaml        |  50 ++++++
 arch/arm/boot/dts/meson8.dtsi                 |  13 +-
 arch/arm/boot/dts/meson8b.dtsi                |  13 +-
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/meson8-ddr.c                | 152 ++++++++++++++++++
 drivers/clk/meson/meson8b.c                   |   2 +-
 include/dt-bindings/clock/meson8-ddr-clkc.h   |   4 +
 7 files changed, 230 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
 create mode 100644 drivers/clk/meson/meson8-ddr.c
 create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h

-- 
2.23.0

