Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C106C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72C020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MVjyiQuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEHHzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:55:15 -0400
Received: from mail-eopbgr730049.outbound.protection.outlook.com ([40.107.73.49]:49093
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbfEHHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9nc3Xy31hwVe4AI/h5chHxQiqugTZEdFugpK1DCtDs=;
 b=MVjyiQuDE5JDWU/+HvMAncD28rP9YdlzD3AGpcZ+re+G1b5siQoolM2nhaIJlXY1d3otuiRpRs6J6KrpQxipgwV9vn8BgktGG7BEx6dWcGonbZh+GDLhQm8LIiqlXjZX72oRxcVzp5yvUIV0hBye2bRcFmQMjOt/iGRsSzzzUdI=
Received: from SN4PR0201CA0025.namprd02.prod.outlook.com
 (2603:10b6:803:2e::11) by BY2PR02MB153.namprd02.prod.outlook.com
 (2a01:111:e400:2c20::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1856.12; Wed, 8
 May 2019 07:55:10 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by SN4PR0201CA0025.outlook.office365.com
 (2603:10b6:803:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11 via Frontend
 Transport; Wed, 8 May 2019 07:55:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 07:55:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46964 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPw-0003yr-NH; Wed, 08 May 2019 00:55:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPr-0005yM-Is; Wed, 08 May 2019 00:55:03 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x487srWS027159;
        Wed, 8 May 2019 00:54:53 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOHPh-0005sB-BU; Wed, 08 May 2019 00:54:53 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 8773260509; Wed,  8 May 2019 13:24:52 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Claus H. Stovgaard" <cst@phaseone.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 1/3] doc: dt: bindings: usb: dwc3: Update entries for disabling U1 and U2
Date:   Wed, 8 May 2019 13:24:49 +0530
Message-ID: <1557302091-7455-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(199004)(189003)(48376002)(36756003)(42186006)(106002)(186003)(26005)(70586007)(76176011)(70206006)(15650500001)(336012)(5660300002)(14444005)(6666004)(356004)(4326008)(107886003)(6266002)(51416003)(63266004)(103686004)(316002)(52956003)(36386004)(7416002)(2906002)(54906003)(16586007)(110136005)(90966002)(50466002)(47776003)(478600001)(11346002)(426003)(446003)(486006)(2616005)(476003)(126002)(8676002)(81156014)(81166006)(8936002)(50226002)(305945005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB153;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad0fc06-b7f2-4dba-6a44-08d6d38a7e56
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BY2PR02MB153;
X-MS-TrafficTypeDiagnostic: BY2PR02MB153:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB15369E01E28ECD5C8C516D6A7320@BY2PR02MB153.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AQ1rljIesNpOvCYDtUXNRfNBe0sgABj03GUW2R6pElXkmbEowD2mbHLdmzsjWkyOhCwjHa456lhLp23ttJXVF+5Mc2nHk+iFXW2GQfznjQPV1CTQYhiaPU+HjzyiyjxocQSoRVGSMzIBLIqg6tvVFdg+stS244y5lCmcbGR6QpNVZEugH+HB6ZQ8qYCDOC2AexmyFeunGs2mYebwPQhIDByXv+OiGMmTc/5B/1g2CSuV4lqGW4MEBYCYLkqMbf8o+Kx+/wFvQl1r5AjYIIXsgQla4qeLBTSyElJkfrAXvMW4SM53PpJDylj5QSTwQFQMHDe0STCJedWi+k88eFAYRWlvO4zn8Zd4ibPXs4L37a//6thly2h8EH2LVBPrW7anTS1kjIx7Cwrag8RCYtNrMdxPAjmanUcrgT8GsNb7nyo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 07:55:09.2479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad0fc06-b7f2-4dba-6a44-08d6d38a7e56
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation with the information related
to the quirks that needs to be added for disabling the link entering
into the U1 and U2 states

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2
	1. As suggested by Thinh Nguyen changed the "snps,dis_u1_entry_quirk"
	   to "snps,dis-u1-entry-quirk"
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 8e5265e..66780a4 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -64,6 +64,8 @@ Optional properties:
  - snps,dis_u2_susphy_quirk: when set core will disable USB2 suspend phy.
  - snps,dis_enblslpm_quirk: when set clears the enblslpm in GUSB2PHYCFG,
 			disabling the suspend signal to the PHY.
+ - snps,dis-u1-entry-quirk: set if link entering into U1 needs to be disabled.
+ - snps,dis-u2-entry-quirk: set if link entering into U2 needs to be disabled.
  - snps,dis_rxdet_inp3_quirk: when set core will disable receiver detection
 			in PHY P3 power state.
  - snps,dis-u2-freeclk-exists-quirk: when set, clear the u2_freeclk_exists
-- 
2.1.1

