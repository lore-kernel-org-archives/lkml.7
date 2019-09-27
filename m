Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41486C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D8721920
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qWsSxV5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfI0Tkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:40:45 -0400
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:50208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfI0Tko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDjWVARtcQSqMXA1o37of+cXoNpALREwA4u+OhPdFHl7g5E32S2wFzVS9mbjJysQq6PzblBAmDm0Go+nKuL62OgNui3VszN9LI81EQXpV4xsD2AxyxbUbUFRyFW8Tf9zn8OkbqAd3yXSuZ4IjjTNgpb66xMJFEjP6lweBBv0HtmMF/T+KjPpa1TFkSr7o2Ggh7OUaEUCR5dtkfDHXzi9mljGQhuKf2XFBejIOc/bsWMZ05nCCMBBGTlrmJKmIDj5aNmjMDsYbG6wCy1C7Fz0hvbV894XASa1aL1JTHSlusIZqQYJwQ2iDVcOkA5pOl161sapOMeSO176tK6SA1hTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtFp2Lg4n+5iP5vvY0eUoF0Xjw5rmocbiF6KRjgCDbQ=;
 b=QGpyCtw3j6GvF2qSGjBOJG++aiiEwlAHRaYtPrsvKW6xm+kEJ6y0m/ouO9A5EWxEYu3jNp3pyz9HfRew4ZUfKGFtuWxAUlvUFjpEqAmMHtK1VyDqBGdGanBdqIxi0N3JGNi6esgwbUdlT1yEePcBNovwJYhbULgkBwNevRj+M67/nOtZqyegYi7DEbjsV/jvxByiR/K4uPnBv7dTW9pfX9TLHCXUjTmJh5fOz2VQeceYf3EhCpyro2sZTcpsJz48GjyS9MWfjGpE/9JPdGCzy4EouZ4lr8YlfPUIO3MQY0GIOgs7t01rXc1I45X/n2Cw/sxi2JXB+wYHFE8qpEt05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtFp2Lg4n+5iP5vvY0eUoF0Xjw5rmocbiF6KRjgCDbQ=;
 b=qWsSxV5E60RyFbtf1mMvt+pIhmktBaDu9RYY4JlUoANpN8/mICtGhb8R6LWFNbzPKm1uw4xR5TzdiNK+cnWp9tQfy1b1U4Q9xkgwWX1o4juzRX7rUVXINhKi4PT19WcCQcbWD04Oy8bya29hQEp0QozO07Agbc8YXXywjdzNRy4=
Received: from BL0PR02CA0103.namprd02.prod.outlook.com (2603:10b6:208:51::44)
 by SN6PR02MB5344.namprd02.prod.outlook.com (2603:10b6:805:71::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16; Fri, 27 Sep
 2019 19:40:29 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BL0PR02CA0103.outlook.office365.com
 (2603:10b6:208:51::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.21 via Frontend
 Transport; Fri, 27 Sep 2019 19:40:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Fri, 27 Sep 2019 19:40:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1iDw6O-0000L1-95; Fri, 27 Sep 2019 12:40:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1iDw6J-0003aE-4t; Fri, 27 Sep 2019 12:40:23 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1iDw6B-0003I3-Vh; Fri, 27 Sep 2019 12:40:16 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: firmware: Add bindings for Versal firmware
Date:   Fri, 27 Sep 2019 12:40:05 -0700
Message-Id: <1569613206-20189-2-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569613206-20189-1-git-send-email-jolly.shah@xilinx.com>
References: <1569613206-20189-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(6666004)(11346002)(36386004)(446003)(16586007)(50226002)(426003)(478600001)(336012)(81156014)(81166006)(2616005)(8676002)(44832011)(7696005)(5660300002)(126002)(36756003)(50466002)(305945005)(476003)(4326008)(70206006)(51416003)(356004)(9786002)(107886003)(48376002)(76176011)(486006)(8936002)(70586007)(47776003)(7416002)(26005)(106002)(14444005)(186003)(6636002)(2906002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5344;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3222c221-ef70-4599-01a6-08d743828d35
X-MS-TrafficTypeDiagnostic: SN6PR02MB5344:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5344F134834CFFF540E2B180B8810@SN6PR02MB5344.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0173C6D4D5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+Tuhhe3XgFf1POvi1lNL8qWQeTNujvDiH09eBhp9C6cHR+7VCoQwvYBHYbhf0Qpd8SCl1TxDkb5Hu7tEWR1vjpLCsabU0DKaQamiIXE3kosrbKvMAQ03+KTglCXEm2ep1b46whpAFWxhwM4aI3+Ny7DPN0B4UiHHfFADEbS684PM34Yq/hhMyeiv+2v4ym5FNLs0bx//mEAeyYOF7m4orCDVTTb/UTG9sSrIWg3GU3vwtjQqxGi0AFJdBubGMEI2h/r2LUa8DNNJNwejSfcsI73N+8kNjsLjNgYp38Zx877YgR4xQT5+Xqwq0DXsw50WNMIcWn+DUo6h8G1wFApURIA/2J7DU0m3xWhJA7M9HtRUkHnVVM59XrSy8spTivn7wUrUJ3HoenVV4cVxxVncNwAz5vCxEGbpJvzMts9FUM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 19:40:28.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3222c221-ef70-4599-01a6-08d743828d35
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP firmware driver can be used for versal also.
Add versal compatible string to zynqmp firmware driver
doc.

Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index a4fe136..18c3aea 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -11,7 +11,9 @@ power management service, FPGA service and other platform management
 services.
 
 Required properties:
- - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - compatible:	Must contain any of below:
+		"xlnx,zynqmp-firmware" for Zynq Ultrascale+ MPSoC
+		"xlnx,versal-firmware" for Versal
  - method:	The method of calling the PM-API firmware layer.
 		Permitted values are:
 		  - "smc" : SMC #0, following the SMCCC
@@ -21,6 +23,8 @@ Required properties:
 Example
 -------
 
+Zynq Ultrascale+ MPSoC
+----------------------
 firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
@@ -28,3 +32,13 @@ firmware {
 		...
 	};
 };
+
+Versal
+------
+firmware {
+	versal_firmware: versal-firmware {
+		compatible = "xlnx,versal-firmware";
+		method = "smc";
+		...
+	};
+};
-- 
2.7.4

