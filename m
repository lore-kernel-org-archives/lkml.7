Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B85C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173720873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lea11Zxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfEBKUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:20:44 -0400
Received: from mail-eopbgr820081.outbound.protection.outlook.com ([40.107.82.81]:11320
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfEBKUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFnZUbLXFwSxbUQvW94HhY9gy31WDaKnf5Iho83vWX0=;
 b=lea11ZxysTMsKcJhBCEl30qdrRwaz6jSfWMvwx9cx3HLIlUGNxX9597FpI+GYF5h+MOoR1DHDVjx6C4K1P3icbPMhKvNW727VUmiDtvFTb8RYF1rSjwmoiYI4NenrP7KQrveEk6o0OhO4Cq7ZqP/TXGbbFbEIBaubh6tKBtuEwI=
Received: from BL0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:207:3d::17)
 by SN4PR0201MB3406.namprd02.prod.outlook.com (2603:10b6:803:48::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.15; Thu, 2 May
 2019 10:20:39 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0040.outlook.office365.com
 (2603:10b6:207:3d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Thu, 2 May 2019 10:20:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 2 May 2019 10:20:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60485 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hM8pS-0006cp-8s; Thu, 02 May 2019 03:20:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hM8pN-0001np-5h; Thu, 02 May 2019 03:20:33 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x42AKPYC023308;
        Thu, 2 May 2019 03:20:25 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hM8pF-0001me-6L; Thu, 02 May 2019 03:20:25 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 5CB96604BC; Thu,  2 May 2019 15:50:24 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 0/3] usb: gadget: Add support for disabling U1 and U2 entries
Date:   Thu, 2 May 2019 15:50:20 +0530
Message-ID: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(189003)(199004)(478600001)(50466002)(70586007)(48376002)(6666004)(90966002)(356004)(36386004)(51416003)(5660300002)(305945005)(14444005)(47776003)(107886003)(2616005)(4326008)(476003)(126002)(486006)(426003)(336012)(103686004)(16586007)(42186006)(6266002)(81166006)(8936002)(81156014)(8676002)(316002)(50226002)(2906002)(70206006)(36756003)(63266004)(54906003)(52956003)(110136005)(26005)(106002)(186003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3406;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b8e6691-620c-44d2-d3a8-08d6cee7d2f3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:SN4PR0201MB3406;
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3406:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB340699B758E8A07D2604D202A7340@SN4PR0201MB3406.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0025434D2D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: CVMLoOOe4D+JVci1f3I2kdwWC+EdZN2/KFuLq1X2UPUB90OlGhyyU2ZKScg7ykDVuoeXk5tMaCVi6Bw62TLDWoFB1ZL7FUL727mPeT/QBrdJtO07CyjywC6UITcMxQsqjKNi93n+FvbSCI6PDA63ADkFjTwla16dCCUNuIbZZJCpaQAjEwSMoJVwKH+31LpBeBtwTvdw/i0/ZYSxEGgQm3Qn8Q4qZJm8g7chl3J4I+9+aCastXzAdeQCHDsL8UsKd896VZnjsuqPwbZGGajxPQOgB1rjsr2Gude7Uy2kuQ29uOoq0OGh6yo1Iv9atGp7bRgDv7NkMIiYyMAasZ/OwnLy4VC5ZQDyrQwf4WX3tyIs/NZKMmUcjRNtBK0X9kf/R5YyKiUNO3b0i2Nyh6GlLKXM5J8aCWfLc3cR8/DwVio=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2019 10:20:38.7262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8e6691-620c-44d2-d3a8-08d6cee7d2f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gadget applications may have a requirement to disable the U1 and U2
entry based on the usecase. For example, when performing performance
benchmarking on mass storage gadget the U1 and U2 entries can be disabled.
Another example is when periodic transfers like ISOC transfers are used
with bInterval of 1 which doesn't require the link to enter into U1 or U2
state (since ping is issued from host for every uframe interval). In this
case the U1 and U2 entry can be disabled. This can be done by setting
U1DevExitLat and U2DevExitLat values to 0 in the BOS descriptor. Host on
seeing 0 value for U1DevExitLat and U2DevExitLat, it doesn't send SET_SEL
commands to the gadget. Thus entry of U1 and U2 states can be avioded.
This patch updates the same.

Anurag Kumar Vulisha (3):
  doc: dt: bindings: usb: dwc3: Update entries for disabling U1 and U2
  usb: gadget: send usb_gadget as an argument in get_config_params
  usb: dwc3: gadget: Add support for disabling U1 and U2 entries

 Documentation/devicetree/bindings/usb/dwc3.txt |  2 ++
 drivers/usb/dwc3/core.c                        |  4 ++++
 drivers/usb/dwc3/core.h                        |  4 ++++
 drivers/usb/dwc3/gadget.c                      | 19 +++++++++++++++++++
 drivers/usb/dwc3/gadget.h                      |  6 ++++++
 drivers/usb/gadget/composite.c                 |  2 +-
 include/linux/usb/gadget.h                     |  3 ++-
 7 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.1.1

