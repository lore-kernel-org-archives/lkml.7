Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC0C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F57524037
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfE2SKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:10:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfE2SKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:10:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TI3I3N140717
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:10:16 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ssy16r9ne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:10:16 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 29 May 2019 19:10:15 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 May 2019 19:10:11 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4TIAAov37224760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:10:10 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7408B112066;
        Wed, 29 May 2019 18:10:10 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78866112063;
        Wed, 29 May 2019 18:10:09 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 May 2019 18:10:09 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 0/8] drivers/soc: Add Aspeed XDMA Engine Driver
Date:   Wed, 29 May 2019 13:10:00 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19052918-0064-0000-0000-000003E68FE9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011180; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210373; UDB=6.00635908; IPR=6.00991405;
 MB=3.00027105; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-29 18:10:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052918-0065-0000-0000-00003DA90AC9
Message-Id: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

This series adds a driver to control the XDMA engine in order to easily
perform DMA operations to and from the host processor.

Changes since v2:
 - Switch to one pci device config sysfs file
 - Add documentation for pci device config sysfs file
 - Add module parameter for pci device config
 - Switch to genalloc instead of custom allocator
 - Fix alignment of user structure
 - Cleaned up debugfs functions

I previously sent this series v1 to drivers/misc, but I'm now fairly certain
it belongs in drivers/soc, especially since the other Aspeed drivers have been
moved to soc.

Changes since v1:
 - Correct the XDMA command pitch
 - Don't use packed for the aspeed_xdma_op structure
 - Correct the SCU PCI config change

Eddie James (8):
  dt-bindings: soc: Add Aspeed XDMA engine binding documentation
  drivers/soc: Add Aspeed XDMA Engine Driver
  drivers/soc: xdma: Add user interface
  Documentation: ABI: Add aspeed-xdma sysfs documentation
  drivers/soc: xdma: Add PCI device configuration sysfs
  drivers/soc: xdma: Add debugfs entries
  ARM: dts: aspeed: Add XDMA Engine
  ARM: dts: aspeed: witherspoon: Enable XDMA Engine

 .../ABI/testing/sysfs-devices-platform-aspeed-xdma |  11 +
 .../devicetree/bindings/soc/aspeed/xdma.txt        |  23 +
 MAINTAINERS                                        |  10 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   4 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   8 +
 drivers/soc/aspeed/Kconfig                         |   8 +
 drivers/soc/aspeed/Makefile                        |   1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 912 +++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |  26 +
 9 files changed, 1003 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

