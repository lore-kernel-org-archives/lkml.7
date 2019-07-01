Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8556C21479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfGATyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:54:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726652AbfGATyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:54:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61JbAXv005864
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 15:54:07 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfpme5fs5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 15:54:07 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 1 Jul 2019 20:54:06 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 20:54:03 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61Js2hM50200990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 19:54:02 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DEB26E04E;
        Mon,  1 Jul 2019 19:54:02 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8318C6E052;
        Mon,  1 Jul 2019 19:54:01 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 19:54:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        eduval@amazon.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 0/8] drivers/soc: Add Aspeed XDMA Engine Driver
Date:   Mon,  1 Jul 2019 14:53:51 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19070119-0016-0000-0000-000009C96864
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011361; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226037; UDB=6.00645423; IPR=6.01007249;
 MB=3.00027541; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 19:54:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070119-0017-0000-0000-000043DBA21B
Message-Id: <1562010839-1113-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XDMA engine embedded in the AST2500 SOC performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

This series adds a driver to control the XDMA engine in order to easily
perform DMA operations to and from the host processor.

Changes since v3:
 - Added a few comments.
 - Change DMA reservation/allocation/mmap to iomap operations.
 - Change miscdevice to "aspeed-xdma".
 - Change default PCI device to the BMC device, not the VGA.
 - Use length-limited string functions (strncpy, strncasecmp)
 - Added more debugfs registers

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
 MAINTAINERS                                        |   9 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |   4 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   8 +
 drivers/soc/aspeed/Kconfig                         |   8 +
 drivers/soc/aspeed/Makefile                        |   1 +
 drivers/soc/aspeed/aspeed-xdma.c                   | 953 +++++++++++++++++++++
 include/uapi/linux/aspeed-xdma.h                   |  26 +
 9 files changed, 1043 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-aspeed-xdma
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
 create mode 100644 drivers/soc/aspeed/aspeed-xdma.c
 create mode 100644 include/uapi/linux/aspeed-xdma.h

-- 
1.8.3.1

