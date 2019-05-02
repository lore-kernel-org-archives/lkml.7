Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0C720656
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4xCgCWRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEBKVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:21:02 -0400
Received: from mail-eopbgr760055.outbound.protection.outlook.com ([40.107.76.55]:20903
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfEBKUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHWm5odc+KcTZH3YI654YZlYvxAInG4O9tjEbPeZFu0=;
 b=4xCgCWRd4/pPCxVm0gCy4/cDF6lt9HdhIIHAvGuSDyXD0FlySgwlLc8Rf+MM58c6pTDyAoENk0Q3VsUMTf27yMF375CvMbMNeg7rntOHMd/L77P/vo1ReH29+9NvUfm+MSpYu38fPW2OwhpNz50AuQHdbSifgdZ8T6IpUX3aXJ4=
Received: from MWHPR02CA0056.namprd02.prod.outlook.com (2603:10b6:301:60::45)
 by SN1PR02MB1664.namprd02.prod.outlook.com (2a01:111:e400:5230::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.15; Thu, 2 May
 2019 10:20:40 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR02CA0056.outlook.office365.com
 (2603:10b6:301:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11 via Frontend
 Transport; Thu, 2 May 2019 10:20:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Thu, 2 May 2019 10:20:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hM8pS-0004RY-Ay; Thu, 02 May 2019 03:20:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hM8pN-0001np-7G; Thu, 02 May 2019 03:20:33 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x42AKPPE023310;
        Thu, 2 May 2019 03:20:26 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hM8pF-0001mh-JY; Thu, 02 May 2019 03:20:25 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C4B46604DB; Thu,  2 May 2019 15:50:24 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 1/3] doc: dt: bindings: usb: dwc3: Update entries for disabling U1 and U2
Date:   Thu, 2 May 2019 15:50:21 +0530
Message-ID: <1556792423-4833-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(199004)(189003)(356004)(36386004)(316002)(81166006)(126002)(16586007)(81156014)(5660300002)(50466002)(42186006)(486006)(6666004)(110136005)(106002)(54906003)(70586007)(11346002)(446003)(476003)(2616005)(76176011)(426003)(51416003)(4326008)(103686004)(48376002)(36756003)(50226002)(70206006)(15650500001)(63266004)(478600001)(6266002)(305945005)(26005)(107886003)(186003)(47776003)(2906002)(8676002)(90966002)(52956003)(336012)(14444005)(8936002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1664;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca6bb95-c26a-48ce-0140-08d6cee7d31b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:SN1PR02MB1664;
X-MS-TrafficTypeDiagnostic: SN1PR02MB1664:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB16643D0FA3232BD0F086989EA7340@SN1PR02MB1664.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0025434D2D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: L0ifOevl715FSUgfmpVK2RxLYaIiY2JxpzOrIMt/TExFnELyfOhBEpPSPPcdzt8za94CPjG3qpUq3Bj6jhcLVt97h9QycX1yi6WcZBsMCFMcMrnZw06oAqTny5n3H6OI9fOad9zW4EvkiJ80lVz38CW8stkb5/nB8jKg4aTAvgrtGSUGzE4ZVpAMxOsxM763zrR1PCb9MMq8tl6g3GPLlkBFUPbwIE74mke8oNfnACwat+WKz9LfNUvCbnAp4GkDhIc2RQ4jyG88jWvK+KfeI+m23/SwWNHWa+3dlK/CV0Ic5QdJYVjRzLTWMX1huSvEeSCoYpEVqzPW5LaMUnSI0boTPePGTFADgcMN8+pGzm/Rzc7F2oujCVlcM4Yd/DQ+WHLZrOuUbYHEabsK0FWb2QdYt2fOY/3aNmHPF5cBylM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2019 10:20:39.2312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6bb95-c26a-48ce-0140-08d6cee7d31b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation with the information related
to the quirks that needs to be added for disabling the link entering
into the U1 and U2 states

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 8e5265e..b087248 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -64,6 +64,8 @@ Optional properties:
  - snps,dis_u2_susphy_quirk: when set core will disable USB2 suspend phy.
  - snps,dis_enblslpm_quirk: when set clears the enblslpm in GUSB2PHYCFG,
 			disabling the suspend signal to the PHY.
+ - snps,dis_u1_entry_quirk: set if link entering into U1 needs to be disabled.
+ - snps,dis_u2_entry_quirk: set if link entering into U2 needs to be disabled.
  - snps,dis_rxdet_inp3_quirk: when set core will disable receiver detection
 			in PHY P3 power state.
  - snps,dis-u2-freeclk-exists-quirk: when set, clear the u2_freeclk_exists
-- 
2.1.1

