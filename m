Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E18C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88560206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="by4m/lPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKTGsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:48:02 -0500
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:34816
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfKTGry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQeftY/cY5rcnWQCnb8ONlthSlor4e0yityvb+gUF8TUV8UesNZxzhbGaviKbI+UrBvPgeYeoyE5UVpgoslY4p+YWqpIg/h3OIGdpYOkOg3d3Oo2EG7ov3lpTUpXHE/6U1gujxO/CSZ5Ig32EaM3JCwSjb6pdMg0vq4t34cthMzHp5iFvCFWOCUGCcbV+Ihu0Clmb+9eIRA/EQGVx/Ea0EvlKzcCVUZVdzbRwMFU+t9ijkAdCxtQ468wu+ZuPsum4VVrqOS9Uim8twR5XLeO8MeXxsFgFORQ13OKfeSjxuIvMeAV/h6BT561H2tO0GlgkInbSwDpi2MCa2e0VmtNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK2Og5rGVawjCNyET2Ne6BuZnLTiF1HsXwJIvMpWDdY=;
 b=mUuZeswTbqucYmsOQtbMLMOeqfUvAPLxhs4co3u9tpedKPMnmAzGweTyNN/rBJNXJpc3lTBRqXmu2K609kbAOeODxaZMrt51Z1Km8KZKotpU6aNIyCvfd/qxXrGPLWIOV/0MmisLQzIuJYIzJsg6zRGOSWHVnQXEakCJtd1iZVcUyaB+4/yIC2jr4tFc0DJrhtdIHB7gc6IVvnIaxTs6Ca/uoMLpIjf4+Xc0nh4DYcIchvI4403O7Jr2PqOOJXUzSz8Q8FiUcMZ1hHduoam9lDs7zb5ZU3mgPiJ18w42PNGBZHdp3ULnfHum7KglH0wsGa96vpFCGcNqOZT0plWw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK2Og5rGVawjCNyET2Ne6BuZnLTiF1HsXwJIvMpWDdY=;
 b=by4m/lPtsAq88t5/8i5oAyJJkfKuyHu/qxO4aktQw1VX07/pWK+rgXiPbfHTuDeBsl+hPw5XxhrtjKlY9HcJqArkouRLM4BMsVAbFAki3TKfkQvT26Os3PGr1K0jKtTtTMJMqBucbrpPTv08q/zEVw4ZHSujB5vNIbuepOwEEqw=
Received: from BL0PR02CA0143.namprd02.prod.outlook.com (2603:10b6:208:35::48)
 by MN2PR02MB6687.namprd02.prod.outlook.com (2603:10b6:208:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Wed, 20 Nov
 2019 06:47:48 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BL0PR02CA0143.outlook.office365.com
 (2603:10b6:208:35::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 20 Nov 2019 06:47:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 20 Nov 2019 06:47:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmF-000616-F8; Tue, 19 Nov 2019 22:47:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iXJmA-00049o-BK; Tue, 19 Nov 2019 22:47:42 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAK6la1t001801;
        Tue, 19 Nov 2019 22:47:37 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iXJm4-00048z-KB; Tue, 19 Nov 2019 22:47:36 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D1B9A12127B; Wed, 20 Nov 2019 12:17:35 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v6 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date:   Wed, 20 Nov 2019 12:17:21 +0530
Message-Id: <1574232449-13570-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(106002)(14444005)(186003)(44832011)(26005)(336012)(47776003)(36386004)(4326008)(6666004)(356004)(36756003)(126002)(107886003)(486006)(2616005)(6266002)(51416003)(48376002)(81156014)(81166006)(476003)(8676002)(426003)(5660300002)(478600001)(8936002)(50226002)(305945005)(2906002)(316002)(16586007)(42186006)(70206006)(70586007)(50466002)(103686004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6687;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b23c3b4-a715-4da2-dae9-08d76d858e51
X-MS-TrafficTypeDiagnostic: MN2PR02MB6687:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6687DD9AB34A9ABCA3F466C3C14F0@MN2PR02MB6687.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q4r4i8EQ6JMs1lmmu7Jqz6E1G2TVBuF90GxuANexQDXB7nBK44COqV+4MWQKxHmS2o+cF09Vyg9AMV5yQIYZ3sDdisvLAyrmi0RqdnuBMHK4/Dj3ttH2hz23KKfCUmnmKKuddX2RFSji/Nldd9hvnyjLMUEIkRig0paeJSnbHbyzqb6a5EeRi38hrWT1o0gqe+lZWgNEuBPHeoYdrQCoY5sl3R1HjF+4n15XIRy2Vbjh/n9HemLCHsuE20D4hOdcSkRLpnmvUehg6nddf0YQ39mm+52hPi/jWQWDd7gaMLYLbdluaqYs1LtXYqPyjDqSZcegz/0OdpesrER9DaBugAn1BY/NHI1h6lFw5j+5JAF6BT2P8i79L+pB4chnPpCIWM4bDe5sWfbw8R2hrzrDBP6eho2o8Loqn9HZULjeM0sqwcriNwWZRrqiWyY9U3U
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 06:47:48.0270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b23c3b4-a715-4da2-dae9-08d76d858e51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6687
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

Changes in v3:
	- Reverted "Replaced the deprecated calls to clock framework APIs"
	- Removed devm_clk_get() call which was added in v2

Changes in v4:
	- Made the Phase Delay properties Arasan specific

Changes in v5:
	- Made Clock Phase Delay properties common
	- Moved documentation of them to the common mmc documentation.

Changes in v6:
	- Clubbed all Clk Phase Delay properties' into a pattern
	  Property

Manish Narani (8):
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: Add optional generic properties for mmc
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay nodes
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  25 +-
 .../bindings/mmc/mmc-controller.yaml          |  13 +
 drivers/mmc/host/sdhci-of-arasan.c            | 478 +++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h          |  13 +-
 4 files changed, 497 insertions(+), 32 deletions(-)

-- 
2.17.1

