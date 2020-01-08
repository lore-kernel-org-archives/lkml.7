Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC4C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ACD20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b31dMLyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgAHUxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:53:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46311 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAHUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so4852284wrl.13;
        Wed, 08 Jan 2020 12:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3med5z+Qa5fYXWFNKFb9s4Ru5QMDkS0db/NoqxQ+tPM=;
        b=b31dMLylORZPzTu3NbrFjCRxoutU2z1dGlKDedPHqnMbpFgeXoykIv0TukUhrvVmDl
         y+/6r4XwoWs9verWnMvsURKHCr249vQKjs7XMEzcTFIa2mVv9c8XtgJ94T37VF+3s3gw
         xLh4Ap+BdJc13VD1bu13fxAYEnbpRaRVY1HTgyUOVbwPEZzYQShJOqQhgvMhBwiD+cIU
         n6+lksUiXt65N6wLPCCUPNqlpKp/B6h9LHmLgR+/Na0NU80FsLG2t58CfHAaNwIDjivP
         27oK+8OyyLMIOcHpFMCU9pHblBaXg0VVkS4/b29yGucKMwBc2GxWqd0k3S6FBHYbmkiT
         cuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3med5z+Qa5fYXWFNKFb9s4Ru5QMDkS0db/NoqxQ+tPM=;
        b=s9GV9WipnBBZARe83gHqhbLUnYP21jILWPoq045U8ok9fxX9aGmm5mfe3GozHqKJaW
         UgY0p7GIgmdfvh0h2AvkcpJZiv4wK9mMpF2TnT1m02DUPopjn7Z+SPy9aLEj6mGfpDjt
         RnQIdiHiSx/DdYwdPxW3zYav4fTm7M3CJMphUvgWZGxt0y5Cgn28NqvNAk3sA7WvG4cz
         lHc+iUzzvT+BEcLjD311BuDOndWLH0uZyCMuJKr0hyRrn6I4hEC0oTFrwMLMJ+bTNKsU
         pNZ1KRk+7/8xTIIOlcv1NxSvWt4wLJyxf12l7x2U59mw+kkk2IMzLrJZ7tsAROm/xLlZ
         rswg==
X-Gm-Message-State: APjAAAWxJGO2iUllCjw1sarC6pXvFOqD9soyzGKzosjRwYUaCJQAUPVu
        DZ3l0xKkNJ8pReVDGjmpL48=
X-Google-Smtp-Source: APXvYqz2vS9D0SjtKCJWnsLfha7RGe/V+cVD2jGWhMEYs7bYpm1daCxMBDF4+hA4fivk3kgxZxmc0Q==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr6734075wrp.1.1578516826138;
        Wed, 08 Jan 2020 12:53:46 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:45 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 00/10] Enable RK3066 NANDC for MK808
Date:   Wed,  8 Jan 2020 21:53:28 +0100
Message-Id: <20200108205338.11369-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DISCLAIMER: Use at your own risk.
Status: For testing only!

Version: V1

Title: Enable RK3066 NANDC for MK808.

The majority of Rockchip devices use a closed source FTL driver
to reduce wear leveling. This patch serie proposes
an experimental raw NAND controller driver for basic tasks
in order to get the bindings and the nodes accepted for in the dts files.

What does it do:

On module load this driver will reserve its resources.
After initialization the MTD framework will then try to detect
the type and number of NAND chips. When all conditions are met,
it registers it self as MTD device.
This driver is then ready to receive user commands
such as to read and write NAND pages.

Test examples:

# dd if-/dev/mtd0 of=dd.bin bs=8192 count=4

# nanddump -a -l 32768 -f nanddump.bin /dev/mtd0

Not tested:

NANDC version 9.
NAND raw write.
RK3066 still has no support for Uboot.
Any write command would interfere with data structures made by the boot loader.

Etc.

Problems:

No bad block support. Most devices use a FTL bad block map with tags
that must be located on specific page locations which is outside
the scope of the raw MTD framework.

No partition support. A FTL driver will store at random locations and
a linear user specific layout does not fit within
the generic character of this basic driver.

Etc.

Chris Zhong (1):
  ARM: dts: rockchip: add nandc node for rk3066a/rk3188

Dingqiang Lin (2):
  arm64: dts: rockchip: add nandc node for px30
  arm64: dts: rockchip: add nandc node for rk3308

Jianqun Xu (1):
  ARM: dts: rockchip: add nandc nodes for rk3288

Johan Jonker (2):
  dt-bindings: mtd: add rockchip nand controller bindings
  ARM: dts: rockchip: rk3066a-mk808: enable nandc node

Jon Lin (1):
  ARM: dts: rockchip: add nandc node for rv1108

Wenping Zhang (1):
  ARM: dts: rockchip: add nandc node for rk322x

Yifeng Zhao (1):
  mtd: nand: raw: add rockchip nand controller driver

Zhaoyifeng (1):
  arm64: dts: rockchip: add nandc node for rk3368

 .../devicetree/bindings/mtd/rockchip,nandc.yaml    |   78 ++
 arch/arm/boot/dts/rk3066a-mk808.dts                |    9 +
 arch/arm/boot/dts/rk322x.dtsi                      |   11 +
 arch/arm/boot/dts/rk3288.dtsi                      |   24 +
 arch/arm/boot/dts/rk3xxx.dtsi                      |   11 +
 arch/arm/boot/dts/rv1108.dtsi                      |   11 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |   15 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |   11 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |   12 +
 drivers/mtd/nand/raw/Kconfig                       |    8 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/rockchip_nandc.c              | 1224 ++++++++++++++++++++
 12 files changed, 1415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nandc.yaml
 create mode 100644 drivers/mtd/nand/raw/rockchip_nandc.c

--
2.11.0

