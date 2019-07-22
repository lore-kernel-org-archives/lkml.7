Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBF3C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41C218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfGVMsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:48:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39402 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfGVMsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:48:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E3222002C0;
        Mon, 22 Jul 2019 14:48:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50147200094;
        Mon, 22 Jul 2019 14:48:48 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 97615205DB;
        Mon, 22 Jul 2019 14:48:47 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        l.stach@pengutronix.de, viorel.suman@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 00/10] Add support for new SAI IP version
Date:   Mon, 22 Jul 2019 15:48:23 +0300
Message-Id: <20190722124833.28757-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far SAI IPs integrated with imx6 only supported one data line.
Starting with imx7 and imx8 SAI integration support up to 8 data
lines and multiple ways of combining the fifos for each data line.

New SAI IP version introduces two new registers (Version and Parmeter
registers) which are placed at the beginning of register address space.
For this reason we need to fix the register's address.

Patches 1 and 2 from Lucas enhance per SOC handling of SAI properties.
Patches 3,4,5,6,7,8 allow SAI driver to read active data lines and
fifo combine mode from DT.
Patch 9 fixes new SAI register address space.
Patch 10 enable SAI for imx7ulp and imx8mq.

This patch introduces 
Daniel Baluta (8):
  ASoC: fsl_sai: Add registers definition for multiple datalines
  ASoC: fsl_sai: Update Tx/Rx channel enable mask
  ASoC: fsl_sai: Add support to enable multiple data lines
  ASoC: dt-bindings: Document dl_mask property
  ASoC: fsl_sai: Add support for FIFO combine mode
  ASoC: dt-bindings: Document fcomb_mode property
  ASoC: fsl_sai: Add support for SAI new version
  ASoC: fsl_sai: Add support for imx7ulp/imx8mq

Lucas Stach (2):
  ASoC: fsl_sai: add of_match data
  ASoC: fsl_sai: derive TX FIFO watermark from FIFO depth

 .../devicetree/bindings/sound/fsl-sai.txt     |   9 +
 sound/soc/fsl/fsl_sai.c                       | 393 +++++++++++++-----
 sound/soc/fsl/fsl_sai.h                       |  98 +++--
 3 files changed, 361 insertions(+), 139 deletions(-)

-- 
2.17.1

