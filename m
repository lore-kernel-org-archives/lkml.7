Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09190C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF044217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OpMnzvyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEJHHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:07:47 -0400
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:9248
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbfEJHHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rauQJM9kqXNhglzSmNVcSwEsvcIWnY21O68dZaSUciY=;
 b=OpMnzvyVzv24L/XpHBNnFUbCoY1dR1BzHxaqJ3+efJn+OD05Mhc5Ac3zYc9FtI5lh47zFoIkKUNarJPEUMakDq9z7LeH0IzBg78LWCkuGXvrLDCkdmU88mkjdz1HeaUFwgeL8a3hok3+rBCj7Qke4ZO/vK1QLXjLFTQMUiawzmM=
Received: from MN2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:fc::26)
 by BLUPR02MB146.namprd02.prod.outlook.com (2a01:111:e400:849::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1878.20; Fri, 10
 May 2019 07:07:40 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MN2PR02CA0013.outlook.office365.com
 (2603:10b6:208:fc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.21 via Frontend
 Transport; Fri, 10 May 2019 07:07:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Fri, 10 May 2019 07:07:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd5-0001I9-MK; Fri, 10 May 2019 00:07:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd0-0004bk-Hz; Fri, 10 May 2019 00:07:34 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4A77ULm007912;
        Fri, 10 May 2019 00:07:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOzcv-0004aO-Py; Fri, 10 May 2019 00:07:30 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id F3A226050A; Fri, 10 May 2019 12:37:28 +0530 (IST)
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
Subject: [PATCH v3 1/3] doc: dt: bindings: usb: dwc3: Update entries for disabling U1 and U2
Date:   Fri, 10 May 2019 12:37:26 +0530
Message-ID: <1557472048-10536-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(396003)(2980300002)(199004)(189003)(103686004)(126002)(2616005)(486006)(476003)(426003)(11346002)(446003)(4326008)(336012)(15650500001)(76176011)(51416003)(90966002)(356004)(305945005)(7416002)(26005)(186003)(478600001)(14444005)(106002)(316002)(81166006)(16586007)(42186006)(8936002)(8676002)(81156014)(36386004)(50226002)(110136005)(54906003)(47776003)(6266002)(107886003)(52956003)(5660300002)(36756003)(2906002)(70206006)(70586007)(63266004)(50466002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB146;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7365683-67af-4f68-9f4c-08d6d51630ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR02MB146;
X-MS-TrafficTypeDiagnostic: BLUPR02MB146:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB146CC36124BE7FA7F63610EA70C0@BLUPR02MB146.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0033AAD26D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: hU49p5oGih9Ou5KohxjMD2zAhQKrHIsoZshU2xcIMXNrKzUiNIM4YzdGpl9BoKyX+r5sSa8h6MV4jvFkw4i8HTW8BuQEBCBWtHsH+CcK/0LE2sS06OtoMsbAc2pWuIdrgwvl2AiBbMwBs0foXH1VHNPN2cnDqBUt8ROn7MP7BmIJlhTloObNZhz7YcrpVbDGzdkHuZWCdLxn0DQEmrwZqrrFkTA+1BqJk850hSCluHIZmWNS2dNcozXedM2is3jn2iZ30QTdYSDTww0fm1PV1G4EdCWCav8GMJc0QqCnXmlJbAYejZCR7VWd9AuG1zq/ABN5RIzVqbVw+TbdtcsA4DdZghrMAeubVNZ3H8ZMpWXEwyxXPv+lhfDwxpNrr9EddA9of+mWnUjSS+PMABK33opwDC2isAAMw6ZjElXnhxg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2019 07:07:40.2364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7365683-67af-4f68-9f4c-08d6d51630ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the documentation with the information related
to the quirks that needs to be added for disabling the link entering
into the U1 and U2 states

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v3:
	-None

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

