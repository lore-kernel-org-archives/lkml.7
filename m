Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DBBC76190
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33EB2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfG1TYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:24:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48028 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfG1TYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:24:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26F60201282;
        Sun, 28 Jul 2019 21:24:46 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 15AE6201275;
        Sun, 28 Jul 2019 21:24:46 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B56E2060A;
        Sun, 28 Jul 2019 21:24:45 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, nicoleotsuka@gmail.com, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/7] Add support for new SAI IP version
Date:   Sun, 28 Jul 2019 22:24:22 +0300
Message-Id: <20190728192429.1514-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far SAI IPs integrated with imx6 only supported one data line.
Starting with imx7 and imx8 SAI integration support up to 8 data
lines.

New SAI IP version introduces two new registers (Version and Parmeter
registers) which are placed at the beginning of register address space.
For this reason we need to fix the register's address.

Changes since v1:
	- removed patches from Lucas as they were already accepted
	- addressed comments from Lucas and Nicolin regarding
	device tree property naming
	- removed comment saying that "datalines" must be always
	consecutively enabled (this is not true, checked with IP owner)
	- added new patch to document newly introduced compatbile
	  strings
	- removed patch introducing combined mode as I will still need
	some time to figure out how to properly allow users to set it.

Nicolin,

Unfortunately I couldn't find any clean solution on handling registers
address shifts. As mentioned in patch 5/7 Tx/Rx data registers and
Tx/Rx FIFO registers keep their addresses while others are shifted
by 8 bytes.

Even if I could create two regmaps as suggested I will still need
to update each call of regmap_functions.

Daniel Baluta (7):
  ASoC: fsl_sai: Add registers definition for multiple datalines
  ASoC: fsl_sai: Update Tx/Rx channel enable mask
  ASoC: fsl_sai: Add support to enable multiple data lines
  ASoC: dt-bindings: Document dl-mask property
  ASoC: fsl_sai: Add support for SAI new version
  ASoC: fsl_sai: Add support for imx7ulp/imx8mq
  ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ

 .../devicetree/bindings/sound/fsl-sai.txt     |  10 +-
 sound/soc/fsl/fsl_sai.c                       | 331 ++++++++++++------
 sound/soc/fsl/fsl_sai.h                       |  82 +++--
 3 files changed, 293 insertions(+), 130 deletions(-)

-- 
2.17.1

