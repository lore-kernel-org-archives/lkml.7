Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E217C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ADE215A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfK1Ggf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:36:35 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:43189
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfK1Ggf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:36:35 -0500
Received: from BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31)
 by SN6PR02MB4495.namprd02.prod.outlook.com (2603:10b6:805:af::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 28 Nov
 2019 06:36:32 +0000
Received: from CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0126.outlook.office365.com
 (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19 via Frontend
 Transport; Thu, 28 Nov 2019 06:36:32 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT046.mail.protection.outlook.com (10.152.74.232) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:36:31 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPj-0007XN-7h; Wed, 27 Nov 2019 22:36:31 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPe-0005AB-42; Wed, 27 Nov 2019 22:36:26 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6aORJ004512;
        Wed, 27 Nov 2019 22:36:25 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPc-00059i-Cb; Wed, 27 Nov 2019 22:36:24 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 00/10] clk: clk-wizard: clock-wizard: Driver updates
Date:   Thu, 28 Nov 2019 12:06:07 +0530
Message-Id: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.009-7.0-31-1
X-imss-scan-details: No--6.009-7.0-31-1;No--6.009-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193965918846251;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(189003)(199004)(26005)(47776003)(8936002)(450100002)(5660300002)(8676002)(86362001)(426003)(73392003)(15650500001)(4326008)(6306002)(336012)(70206006)(76482006)(70586007)(7696005)(51416003)(498600001)(966005)(36756003)(14444005)(316002)(2906002)(50466002)(305945005)(48376002)(9786002)(16586007)(6666004)(356004)(107886003)(9686003)(82202003)(81166006)(81156014)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4495;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0335d6-f772-4c3f-cbfd-08d773cd4e7c
X-MS-TrafficTypeDiagnostic: SN6PR02MB4495:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR02MB44951AA6CBFA7C31CF9805AE87470@SN6PR02MB4495.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3rZvDiJSem4brCmA1jMKAh7EZ04sMkknwG2qQN23m3LoclJFEU6lPatJlQbdK3FGJtdtgMqtweuurtC9YrVjDhKbZM7GZIi7H4T3Tq8M+HIvXMuJWimaRJHt2Ia3Xrz77o7PeCMb057UPr/+kcK9+32ZXiwwBknFT2GySAj5Re+86sBuYEpfQc2vYEsi0V0TWrN7XYiN48mwR9Qw7tH6NEUcVNAJ4M2iYZIvQM7iZjiUGOvIj8vxJ/8EBm3WcR/UCT47lCYkiBqzZFo2NevTXnW649Her7mh9ylPr/7MdG0S4Dr1JEsUCOqDm3w72V/JK4qioOz68rpiQYcyxswCtH+LRPqhBj2O69/TCiN0suJaCRbLo0DeiaEZ3vJkEAV10i/smSJURV3qXbtBsCwUBv+54Sm/Zrc5cyoNFUq6slt7ZpqyrRReeJOuCGr7ZUdRb2L//nvMguh+PVAHjPrjff4UOV/cEN2YRXlJHIoKJY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:36:31.7134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0335d6-f772-4c3f-cbfd-08d773cd4e7c
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In the thread [1] Greg suggested that we move the driver
to the clk from the staging.
Add patches to address the concerns regarding the fractional and
set rate support in the TODO.

The patch set does the following
- Trivial fixes for kernel doc.
- Move the driver to the clk folder
- Add capability to set rate.
- Add fractional support.
- Add support for configurable outputs.
- Make the output names unique so that multiple instances
do not crib.

Changes in the v3:
Added the cover-letter.
Add patches for rate setting and fractional support
Add patches for warning.
Remove the driver from staging as suggested

[1] https://spinics.net/lists/linux-driver-devel/msg117326.html

Shubhrajyoti Datta (10):
  dt-bindings: add documentation of xilinx clocking wizard
  clk: clock-wizard: Move the clockwizard to clk
  clk: clock-wizard: Fix kernel-doc warning
  clk: clock-wizard: Add support for dynamic reconfiguration
  clk: clock-wizard: Add support for fractional support
  clk: clock-wizard: Remove the hardcoding of the clock outputs
  clk: clock-wizard: Update the fixed factor divisors
  clk: clock-wizard: Make the output names unique
  staging: clocking-wizard: Delete the driver from the staging
  clk: clock-wizard: Fix the compilation failure

 .../bindings/clock/xlnx,clocking-wizard.txt        |  32 +
 drivers/clk/Kconfig                                |   6 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-xlnx-clock-wizard.c                | 710 +++++++++++++++++++++
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/clocking-wizard/Kconfig            |  10 -
 drivers/staging/clocking-wizard/Makefile           |   2 -
 drivers/staging/clocking-wizard/TODO               |  12 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        | 335 ----------
 drivers/staging/clocking-wizard/dt-binding.txt     |  30 -
 11 files changed, 749 insertions(+), 392 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.txt
 create mode 100644 drivers/clk/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/Kconfig
 delete mode 100644 drivers/staging/clocking-wizard/Makefile
 delete mode 100644 drivers/staging/clocking-wizard/TODO
 delete mode 100644 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c
 delete mode 100644 drivers/staging/clocking-wizard/dt-binding.txt

-- 
2.1.1

