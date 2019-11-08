Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94DC214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbfKHUTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:19:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727041AbfKHUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:18:57 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8KHcr1122411;
        Fri, 8 Nov 2019 15:18:36 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5c2s6qur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 15:18:36 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA8KGNjv029920;
        Fri, 8 Nov 2019 20:18:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2w41uk2g2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 20:18:35 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8KIYW939911926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 20:18:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF14028058;
        Fri,  8 Nov 2019 20:18:34 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C93628059;
        Fri,  8 Nov 2019 20:18:34 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 20:18:33 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au,
        maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 00/12] Aspeed: Add SCU interrupt controller and XDMA engine drivers
Date:   Fri,  8 Nov 2019 14:18:21 -0600
Message-Id: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=376 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series first adds a driver to control the interrupt controller provided by
the System Control Unit (SCU) on the AST2500 and AST2600 SOCs. The interrupts
made available are necessary for the control of the XDMA engine embedded in the
same Aspeed SOCs.
This series then adds a driver to control the XDMA engine. This driver was
previously sent to the list without support for the AST2600, and has been
refactored significantly to enable that support. The XDMA engine performs
automatic DMA operations between the Aspeed SOC (acting as a BMC) and a host
processor.

Eddie James (12):
  dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
  irqchip: Add Aspeed SCU interrupt controller
  ARM: dts: aspeed: ast2500: Add SCU interrupt controller
  ARM: dts: aspeed: ast2600: Add SCU interrupt controllers
  dt-bindings: soc: Add Aspeed XDMA Engine
  drivers/soc: Add Aspeed XDMA Engine Driver
  drivers/soc: xdma: Add user interface
  ARM: dts: aspeed: ast2500: Add XDMA Engine
  ARM: dts: aspeed: ast2600: Add XDMA Engine
  ARM: dts: aspeed: witherspoon: Enable XDMA Engine
  ARM: dts: aspeed: rainier: Enable XDMA engine
  ARM: dts: aspeed: tacoma: Enable XDMA engine

 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt |   26 +
 .../devicetree/bindings/soc/aspeed/xdma.txt        |   24 +
 MAINTAINERS                                        |   16 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |    4 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        |    4 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |    4 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   21 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   29 +
 drivers/irqchip/Makefile                           |    2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |  233 +++++
 drivers/soc/aspeed/Kconfig                         |    8 +
 drivers/soc/aspeed/Makefile                        |    1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 1079 ++++++++++++++++++++
 .../interrupt-controller/aspeed-scu-ic.h           |   23 +
 include/uapi/linux/aspeed-xdma.h                   |   49 +
 15 files changed, 1521 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

