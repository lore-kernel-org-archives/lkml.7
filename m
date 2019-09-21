Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ABC4740A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC68420C01
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JoExe4w0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394283AbfIUPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:18:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40395 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389472AbfIUPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:18:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id l3so9591623wru.7;
        Sat, 21 Sep 2019 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OzBxZ0+t9wPFf+C2nN8hPMeCG+6RrzJB994YNsSPow=;
        b=JoExe4w00+RQX07OVlrkNWAZ+jqPrWWMn48DHOqgsVcWwFyn0HG3+LxNK4j4btrwPb
         RwcxKjLaRQyOsW5QhswDb6Bua+1o4gIWqvofch6Tp+fsdMQF4kjKlZXeBj3u8YOcmcZQ
         k0YRb5NKvPR8ybhIJHwFv12zoFj8fy2YhJ0FhE+9MtZtlx+cyIGitCSJmCoq78jpIad/
         hCfaP2kjMobcXwN0ahzom+Lj95/Qi9JhGblOIpeDpOEhCkMEQl96Pv2AhXIONST7t+J9
         nlpvKVRjN+CHd6JY+Kaba4pnncYqmYASPyfMAnR5Uk11K73r4mKWqeqD2otLsbzGsq9B
         i73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OzBxZ0+t9wPFf+C2nN8hPMeCG+6RrzJB994YNsSPow=;
        b=WFfckQNlKKgjfKwEmL9QXzL6rVwo38YAZDgw3s5MzQQaraie8U90m9kCnRbMvxzrhd
         jYAjjCLNLsRhx5NV5IfUrOlACRIwcRaCGa3aLGcCb0L8b2FeCAgcUu5K/CnH9ZYYXm3Y
         sf3jHYelDTVNc/rXg693hNzUSXwX/eofgeb8CdGarK+f9PF41Jp3opMGccewT/X1k7MR
         JxYU+CT8DhdzwQyjiOMJEsxxJRbEKBQTKqmbRf3fbzGSf7T0IrNPXGDSU9GC0bQ1Zxns
         lVy0AQnhzI+jnS6J3OuJ+wu7ZQgBKHOqehrls+P+RvaXPak88DRryfty0EBfxl2sf4Ya
         RvLg==
X-Gm-Message-State: APjAAAWvwsadKUfWpylpM2r9c7ORaBdOy4ERSEBtE45B4qJYHNWv+Tw9
        Y4Nb+DkY9PZ5CANIDKzWRGc=
X-Google-Smtp-Source: APXvYqx5rx1KF5E+8Mnl8pYNnX5dBt83NmBM6M4uxpyja5jdFKCCDRdrsXVrRIOaK1Jc/1Qk47lG9w==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr15997165wrw.237.1569079127155;
        Sat, 21 Sep 2019 08:18:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id c6sm6003120wrb.60.2019.09.21.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:18:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/6] add the DDR clock controller on Meson8 and Meson8b
Date:   Sat, 21 Sep 2019 17:18:29 +0200
Message-Id: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
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

This series depends on my other series from [0]:
"provide the XTAL clock via OF on Meson8/8b/8m2"


[0] https://patchwork.kernel.org/cover/11155515/


Martin Blumenstingl (6):
  dt-bindings: clock: add the Amlogic Meson8 DDR clock controller
    binding
  clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller
  clk: meson: meson8b: use of_clk_hw_register to register the clocks
  clk: meson: meson8b: add the ddr_pll input for the audio clocks
  ARM: dts: meson8: add the DDR clock controller
  ARM: dts: meson8b: add the DDR clock controller

 .../clock/amlogic,meson8-ddr-clkc.yaml        |  50 ++++++
 arch/arm/boot/dts/meson8.dtsi                 |  13 +-
 arch/arm/boot/dts/meson8b.dtsi                |  13 +-
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/meson8-ddr.c                | 153 ++++++++++++++++++
 drivers/clk/meson/meson8b.c                   |  36 ++---
 include/dt-bindings/clock/meson8-ddr-clkc.h   |   4 +
 7 files changed, 245 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
 create mode 100644 drivers/clk/meson/meson8-ddr.c
 create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h

-- 
2.23.0

