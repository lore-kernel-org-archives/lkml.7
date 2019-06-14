Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD77C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4132080A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFNIPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:15:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49740 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfFNIPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:15:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 57B331A05D1;
        Fri, 14 Jun 2019 10:15:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D8CFD1A05D0;
        Fri, 14 Jun 2019 10:15:11 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A6E2740310;
        Fri, 14 Jun 2019 16:15:03 +0800 (SGT)
From:   daniel.baluta@nxp.com
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, shengjiu.wang@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, daniel.baluta@nxp.com,
        daniel.baluta@gmail.com, anson.huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, o.rempel@pengutronix.de
Subject: [PATCH 0/2] Add support for DSP IPC protocol driver
Date:   Fri, 14 Jun 2019 16:16:48 +0800
Message-Id: <20190614081650.11880-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Hifi4 DSP can be found on some i.MX8 platforms (e.g i.MX8QXP, i.MX8QM).
This patch series introduces the layer that allows Host CPU to
communicate with DSP.

This layer provides a doorbell and clients can used that to notify DSP
that a message is placed somewhere in the shared memory.

The protocol used is request - reply. Usually, Host/DSP write a message
in a shared memory area and notify the other side. The other side will
also write a reply in a designated shared memory area and then ring
the doorbell to let the counterpart that a message is ready.

Daniel Baluta (2):
  firmware: imx: Add DSP IPC protocol driver
  dt-bindings: arm: fsl: Add DSP IPC binding support

 .../bindings/arm/freescale/fsl,dsp.yaml       |  43 +++++
 drivers/firmware/imx/Kconfig                  |  11 ++
 drivers/firmware/imx/Makefile                 |   1 +
 drivers/firmware/imx/imx-dsp.c                | 167 ++++++++++++++++++
 include/linux/firmware/imx/dsp.h              |  61 +++++++
 5 files changed, 283 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
 create mode 100644 drivers/firmware/imx/imx-dsp.c
 create mode 100644 include/linux/firmware/imx/dsp.h

-- 
2.17.1

