Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3F3C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C26D20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 05:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Zg4pwFKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfGAFa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 01:30:26 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:59206
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbfGAFaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 01:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZecrJFOP04cY7K7tn1G2DeQyLfHViOOPNHlXhTd2CTU=;
 b=Zg4pwFKS6hI5IBvy4x8dGDCgsGXVRB4mmT1enHSZ//C464QppAZKMF9ej73XddbB+GfOEGffsl5C8QXVLbPpxjZeACPzCB1Aa2Im0tsDnom5O9JxZzwTCmQ2GR5hngCi5c22tfenqssbu3MMg2++dym5SYPJK5rr2ZLGMwsQixE=
Received: from BL0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:207:3d::16)
 by BYAPR02MB5238.namprd02.prod.outlook.com (2603:10b6:a03:68::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Mon, 1 Jul
 2019 05:30:07 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BL0PR02CA0039.outlook.office365.com
 (2603:10b6:207:3d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Mon, 1 Jul 2019 05:30:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 05:30:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhotC-0002rk-6l; Sun, 30 Jun 2019 22:30:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hhot7-0003EO-2d; Sun, 30 Jun 2019 22:30:01 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x615TtBC008170;
        Sun, 30 Jun 2019 22:29:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hhot0-0003CM-VM; Sun, 30 Jun 2019 22:29:55 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 21E6D121714; Mon,  1 Jul 2019 10:59:54 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        manish.narani@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date:   Mon,  1 Jul 2019 10:59:40 +0530
Message-Id: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(4636009)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(189003)(199004)(8676002)(186003)(2906002)(14444005)(336012)(70586007)(356004)(52956003)(70206006)(44832011)(50466002)(36386004)(486006)(48376002)(81156014)(47776003)(305945005)(4326008)(16586007)(81166006)(103686004)(6266002)(26005)(6666004)(2616005)(36756003)(7416002)(63266004)(426003)(476003)(5660300002)(126002)(478600001)(8936002)(72206003)(42186006)(316002)(50226002)(106002)(51416003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5238;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea1ea3a-88c2-4268-516a-08d6fde52d6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR02MB5238;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5238:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5238E142B8F71E6B20C48239C1F90@BYAPR02MB5238.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: dsmdoRBvLPdsk7FUQ5gswwBq1xYkyxa4NI/j17J2qi8Vcj15G5p7HfypVcYzR5jNe8XhKf95gv3bdfktIASMgSggpQXCs1npAZzYVVM/U9g1HSXqgMrGMhuYBzVjVk9LzWt+1/GYygLq+3mHqBGeYs4VeuCkS1eHjs4bb+CJ4eI4sOCZ4wWeVwAumFzF3g6zxafmyOeZCtQ+YzuthAfm1pRob4FPofUqH9ab2U/BTtc6Z+jhKwsZ+ge9oT2hov4OfunEr35xfdBPECMb3GcpUeZ8ubXO58L3k1Fhdp7+LE8CfK4tRnZ8iu7VQVGfPDtoY7Jt0WN+wHRZRN8iS6+qXzCTfFnnh5KpEi7GTHGCN4f4OieF/OQh6hGwe48NW3G7xe5KkiHuz0DxIx8035yYsO5VcoAAAefsJTwDioEve5s=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 05:30:06.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea1ea3a-88c2-4268-516a-08d6fde52d6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following:
 - Reorganize the Clock Handling in Arasan SD driver
 - Adds new sampling clock in Arasan SD driver
 - Adds support to set Clock Delays in SD Arasan Driver
 - Add SDIO Tap Delay handling in ZynqMP firmware driver
 - Add support for ZynqMP Tap Delays setting in Arasan SD driver

Changes in v2:
	- Replaced the deprecated calls to clock framework APIs
	- Added support for dev_clk_get() call to work for SD card clock
	- Separated the clock data struct
	- Fragmented the patch series in smaller patches to make it more
	  readable

This patch series contains a DT patch, which I think should be there to
maintain the order of commits.

Manish Narani (11):
  dt-bindings: mmc: arasan: Update documentation for SD Card Clock
  arm64: dts: rockchip: Add optional clock property indicating sdcard
    clock
  mmc: sdhci-of-arasan: Replace deprecated clk API calls
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay APIs
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  49 ++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 +-
 drivers/firmware/xilinx/zynqmp.c                   |  48 +++
 drivers/mmc/host/sdhci-of-arasan.c                 | 453 ++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               |  15 +-
 5 files changed, 540 insertions(+), 29 deletions(-)

-- 
2.1.1

