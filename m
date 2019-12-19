Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5005C24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLSKY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:24:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39426 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfLSKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:24:27 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 65DA22003FD;
        Thu, 19 Dec 2019 11:24:25 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B5A48200007;
        Thu, 19 Dec 2019 11:24:19 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8547A4028B;
        Thu, 19 Dec 2019 18:24:12 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, maz@kernel.org, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 0/2] irqchip: add NXP INTMUX interrupt controller
Date:   Thu, 19 Dec 2019 18:21:03 +0800
Message-Id: <1576750865-14442-1-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

   Registering domain for each channel is indeed a bit unreasonable, I have
changed the driver to support only one channel (channel 0 by default) as
muti-channels is designed to route interrupt to different cores. The fixed
channel is enough for us.
  Thanks for your kindly review.

ChangeLog:
V1->V2:	*squash patches:
		drivers/irqchip: enable INTMUX interrupt controller driver
 		drivers/irqchip: add NXP INTMUX interrupt multiplexer support
	*remove properity "fsl,intmux_chans", only support channel 0 by
	default.
	*delete two unused macros.
	*align the various field in struct intmux_data.
	*turn to spin lock _irqsave version.
	*delete struct intmux_irqchip_data
	*disable interrupt in probe stage and clear pending status in remove
	stage

Joakim Zhang (2):
  dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
  drivers/irqchip: add NXP INTMUX interrupt multiplexer support

 .../interrupt-controller/fsl,intmux.txt       |  28 ++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-imx-intmux.c              | 240 ++++++++++++++++++
 4 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

-- 
2.17.1

