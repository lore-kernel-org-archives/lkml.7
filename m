Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368A4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150A12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLRPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:11:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbfLRPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:10:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIErrDD139345;
        Wed, 18 Dec 2019 10:09:42 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wye06ku88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 10:09:42 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBIF1dZb025436;
        Wed, 18 Dec 2019 15:09:41 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 2wvqc6yxjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:09:41 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIF9dwR51904970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 15:09:40 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD35613604F;
        Wed, 18 Dec 2019 15:09:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02F6B136051;
        Wed, 18 Dec 2019 15:09:38 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 15:09:38 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com
Subject: [PATCH v3 00/12] aspeed: Add SCU interrupt controller and XDMA engine drivers
Date:   Wed, 18 Dec 2019 09:09:26 -0600
Message-Id: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=1
 mlxlogscore=601 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912180124
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

Changes since v2:
 - See individual patches
 - Drop rainier dts patch
 - In summary, remove references to VGA memory as the XDMA driver doesn't care
   where it is. Remove SDRAM controller reference. Move user reset
   functionality to a separate patch and make it an ioctl.

Changes since v1:
 - See individual patches
 - In summary, first the irqchip driver switched to use the parent SCU regmap
   rather than iomapping it's register. Secondly, the XDMA initialization
   switched to use properties from the device tree rather than dynamically
   calculate memory spaces, and system config.

Eddie James (12):
  dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
  irqchip: Add Aspeed SCU interrupt controller
  ARM: dts: aspeed: ast2500: Add SCU interrupt controller
  ARM: dts: aspeed: ast2600: Add SCU interrupt controllers
  dt-bindings: soc: Add Aspeed XDMA Engine
  soc: aspeed: Add XDMA Engine Driver
  soc: aspeed: xdma: Add user interface
  soc: aspeed: xdma: Add reset ioctl
  ARM: dts: aspeed: ast2500: Add XDMA Engine
  ARM: dts: aspeed: ast2600: Add XDMA Engine
  ARM: dts: aspeed: witherspoon: Enable XDMA Engine
  ARM: dts: aspeed: tacoma: Enable XDMA engine

 .../aspeed,ast2xxx-scu-ic.txt                 |   23 +
 .../devicetree/bindings/soc/aspeed/xdma.txt   |   40 +
 MAINTAINERS                                   |   16 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |    5 +
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |    5 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   19 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   27 +
 drivers/irqchip/Makefile                      |    2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c           |  239 ++++
 drivers/soc/aspeed/Kconfig                    |    8 +
 drivers/soc/aspeed/Makefile                   |    1 +
 drivers/soc/aspeed/aspeed-xdma.c              | 1014 +++++++++++++++++
 .../interrupt-controller/aspeed-scu-ic.h      |   23 +
 include/uapi/linux/aspeed-xdma.h              |   42 +
 14 files changed, 1463 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
2.24.0

