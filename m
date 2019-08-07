Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C90C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160DA2229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbfHGQnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:43:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33984 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbfHGQnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:43:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4B07C2007C0;
        Wed,  7 Aug 2019 18:43:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 382D32002E8;
        Wed,  7 Aug 2019 18:43:13 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 63AC6205E5;
        Wed,  7 Aug 2019 18:43:12 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     daniel.baluta@nxp.com, shawnguo@kernel.org
Cc:     aisheng.dong@nxp.com, anson.huang@nxp.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, m.felsch@pengutronix.de,
        mark.rutland@arm.com, paul.olaru@nxp.com, peng.fan@nxp.com,
        robh+dt@kernel.org, shengjiu.wang@nxp.com,
        sound-open-firmware@alsa-project.org,
        pierre-louis.bossart@linux.intel.com, l.stach@pengutronix.de
Subject: [PATCH v3 0/5] Add DSP node for i.MX8QXP board to be used by DSP SOF driver
Date:   Wed,  7 Aug 2019 19:42:53 +0300
Message-Id: <20190807164258.8306-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX 8QXP boards feature an Hifi4 DSP from Tensilica.

This patch series aims on adding the DT node describing the DSP,
but it also contains the Linux SOF DSP driver code that will use the DT node
for easier review.

Note that we switched to the new yaml format for bindings documentation.

The DSP will run SOF Firmware [1]. Patches 1,2,3 are adding support
for Linux DSP driver are already sent for review to SOF folks [2]

Ideally, patches 4/5 and 5/5 will go upstream through Shawn's tree
while 1-3/5 will go upstream via Pierre's tree -> ASoC tree.

Mind that SOF DSP support depends on IMX DSP communication protocol
up for review here: https://lkml.org/lkml/2019/8/1/260

Shawn, can you pick this up first?

Symbol dependencies are hopefully set correct so even if one of
the patches is not in a tree the compilation will not fail because
the symbols depending on that patches will not be selected.

[1] https://github.com/thesofproject/sof
[2] https://github.com/thesofproject/linux/pull/1048/commits

Daniel Baluta (5):
  ASoC: SOF: Add OF DSP device support
  ASoC: SOF: imx: Add i.MX8 HW support
  ASoC: SOF: topology: Add dummy support for i.MX8 DAIs
  arm64: dts: imx8qxp: Add DSP DT node
  dt-bindings: dsp: fsl: Add DSP core binding support

 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  88 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   4 +
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  32 ++
 include/sound/sof/dai.h                       |   2 +
 include/uapi/sound/sof/tokens.h               |   8 +
 sound/soc/sof/Kconfig                         |  11 +
 sound/soc/sof/Makefile                        |   4 +
 sound/soc/sof/imx/Kconfig                     |  22 +
 sound/soc/sof/imx/Makefile                    |   4 +
 sound/soc/sof/imx/imx8.c                      | 394 ++++++++++++++++++
 sound/soc/sof/sof-of-dev.c                    | 143 +++++++
 sound/soc/sof/topology.c                      |  30 ++
 12 files changed, 742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
 create mode 100644 sound/soc/sof/imx/Kconfig
 create mode 100644 sound/soc/sof/imx/Makefile
 create mode 100644 sound/soc/sof/imx/imx8.c
 create mode 100644 sound/soc/sof/sof-of-dev.c

-- 
2.17.1

