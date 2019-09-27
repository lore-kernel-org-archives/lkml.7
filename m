Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173F6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78C721655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfI0U7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 16:59:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbfI0U7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 16:59:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RKlfCD084311;
        Fri, 27 Sep 2019 16:58:54 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9srx88th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 16:58:53 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RKjEXj016489;
        Fri, 27 Sep 2019 20:58:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2v5bg7u7qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 20:58:52 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RKwp8X60621256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 20:58:51 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9985F6E058;
        Fri, 27 Sep 2019 20:58:51 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED77E6E053;
        Fri, 27 Sep 2019 20:58:50 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 20:58:50 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, mark.rutland@arm.com,
        robh+dt@kernel.org, maz@kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/4] irqchip: Add Aspeed SCU Interrupt Controller
Date:   Fri, 27 Sep 2019 15:58:45 -0500
Message-Id: <1569617929-29055-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=677 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Aspeed SOCs provide some interrupts through the System Control
Unit registers. Add an interrupt controller that provides these
interrupts to the system. Add the interrupt controller to the AST25XX
and AST26XX devicetrees.

Changes since v1:
 - add a spinlock to protect read-modify-write operation for irq masking
 - use readl/writel relaxed versions
 - add a comment explaining the irq status/enable register
 - provide affinity callback that returns -EINVAL

Eddie James (4):
  dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
  irqchip: Add Aspeed SCU interrupt controller
  ARM: dts: aspeed: ast2500: Add SCU interrupt controller
  ARM: dts: aspeed: ast2600: Add SCU interrupt controllers

 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt |  26 +++
 MAINTAINERS                                        |   8 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  11 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  18 ++
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                | 233 +++++++++++++++++++++
 .../interrupt-controller/aspeed-scu-ic.h           |  23 ++
 7 files changed, 319 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h

-- 
1.8.3.1

