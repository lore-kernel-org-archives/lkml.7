Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50CC2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TqWgde8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfC1LPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:15:30 -0400
Received: from mail-eopbgr720085.outbound.protection.outlook.com ([40.107.72.85]:20864
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbfC1LPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8nlTj83bRnjAd7BpsOk8tOB8MT62dw7Chcid2GHIq0=;
 b=TqWgde8Sp2cjQtSetXbkf2ZiEejsxbtr6xp1QeW/wLRYandeuH6TeUwm/FEGt/cApFMAtNYxXKrkeQu+DWSkNnpuPBBCste0zzYM+UORs/GaT4p6PwkxhcAIjRM6mPDjkjHVm7kkz5tWGOaQCobGFpYqgQ+5LVPwNvn2rKRm1RA=
Received: from MWHPR0201CA0058.namprd02.prod.outlook.com
 (2603:10b6:301:73::35) by DM5PR0201MB3398.namprd02.prod.outlook.com
 (2603:10b6:4:76::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.16; Thu, 28 Mar
 2019 11:15:26 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR0201CA0058.outlook.office365.com
 (2603:10b6:301:73::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Thu, 28 Mar 2019 11:15:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Thu, 28 Mar 2019 11:15:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1h9T0G-00022o-E7; Thu, 28 Mar 2019 04:15:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1h9T0B-0000L0-B2; Thu, 28 Mar 2019 04:15:19 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2SBF934009883;
        Thu, 28 Mar 2019 04:15:09 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1h9T00-0000Ba-Na; Thu, 28 Mar 2019 04:15:09 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>
CC:     <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <dwmw2@infradead.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH 0/3] Add support for Zynq QSPI controller driver
Date:   Thu, 28 Mar 2019 16:44:52 +0530
Message-ID: <1553771692-30969-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(7696005)(316002)(5660300002)(81156014)(426003)(4326008)(81166006)(305945005)(8676002)(2906002)(336012)(7416002)(126002)(36386004)(26005)(2616005)(110136005)(476003)(106002)(486006)(54906003)(51416003)(106466001)(356004)(36756003)(16586007)(14444005)(6666004)(9786002)(63266004)(50466002)(107886003)(478600001)(47776003)(8936002)(50226002)(186003)(48376002)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3398;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02b8ae4-24a2-449b-301f-08d6b36ead2d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:DM5PR0201MB3398;
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3398:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3398BE68E99F74FC80280D83AF590@DM5PR0201MB3398.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0990C54589
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: lV5Qi7taTHYCsGDIRk0ccfNbvxnsP6PCn/ioIpBVEsQX4soYszC+M8pLD2uPzhEU5x2ZFSZlA3IqQ3Bwjub37TMveYWczh3sTbd5NBeCB82jy55e9mBde10FceB8ryFtaA91aowSL4IM3iK8bA8Xui8P+4XkOBJpjrK6JoNFlUktqqFmFVvcQTVbYmskR5XINMEx/ZsDUpyhPg4Go7JIl7vTFrhZH06Tg56HlSBY1F3gXNiV2e4NqsI0F1OU4Vd1Nub1QNrc4HzlJK+sEoCKDlP6pE5fLzgGcqjpH99ciO70guaquCCX90Y/KbY8EWRg56teSBwOdwIgbMjALSRzbCNSlaQYKhVkbeTnO8mor/MraeT0U6juf/EIPP9ldPynJjoFrXZhkKEAWPGNGI69oUcy+ur+5YgyKgNL3L+PDbc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2019 11:15:24.8684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02b8ae4-24a2-449b-301f-08d6b36ead2d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx Zynq uses a QSPI controller that implements all the functionality
required to support Quad SPI NOR flash devices.
This driver along with the SPI MEM and MTD layer is used to support
flash devices.

The flash device(s) can be connected in three configurations to this
controller:
1. Single - One flash device with 1 CS, 1 Clock and 4 IO lines.
2. Dual Parallel - Two flash devices connected with common CS and
   separate IO lines (resulting in 8 IO lines).
   In this configuration, the controller
   a) Duplicates commands, address etc. sent on both sets of 4 IO lines.
   b) Stripes data both transmitted and received i.e.
      4 bits of data is sent to the first flash and the other 4 bits
      to the second flash. Similarly read data is also consolidated.
   Due to this, TX and RX data handling in the driver need special
   handling for parallel mode.
3. Dual Stacked - Two flash devices connected with separate CS and
   4 common IO lines. This is largely similar to single, except for
   the slave selection logic.
The above configuration is conveyed to the QSPI driver through a
devicetree property(currently not implemented 2 & 3 mentioned above).

As per Boris suggestion We are currently not targetting for
dual stacked/dual parallel handling. There are changes needed in the
framework to handle this. so this update is only for the Single mode.

This is tested with spi-v5.0 tag

Naga Sureshkumar Relli (3):
  dt-bindings: spi: Add device tree binding documentation for Zynq QSPI
    controller
  spi: spi-mem: call spi_mem_default_supports_op() first
  spi: spi-mem: Add support for Zynq QSPI controller

 .../devicetree/bindings/spi/spi-zynq-qspi.txt      |  25 +
 drivers/spi/Kconfig                                |  10 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mem.c                              |   7 +-
 drivers/spi/spi-zynq-qspi.c                        | 770 +++++++++++++++++++++
 5 files changed, 810 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
 create mode 100644 drivers/spi/spi-zynq-qspi.c

-- 
2.7.4

