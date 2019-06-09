Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A622166E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 00:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="34DmBMOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfFIAEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 20:04:40 -0400
Received: from mail-eopbgr780079.outbound.protection.outlook.com ([40.107.78.79]:1660
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727990AbfFIAEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 20:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9W8ol28YE2CqSuPc/m8fmI/Wka8vmjamOSybBa3E8U=;
 b=34DmBMOKF50h211aHrJBG/3WniN+NlweJmH4YNkTpMbkD5hWhgbx0Xmweg9Pk3nNDKEoLs4nUDfiEVAHdD/GNn/5R0BSZtMJznN5201xIRaexKqixo2grY/OH3qQ9pDq4OFx0nby6WXAiZJ+ayPjb9cm9dP1P3+uKJLRCShz9W4=
Received: from CY4PR02CA0038.namprd02.prod.outlook.com (2603:10b6:903:117::24)
 by CH2PR02MB6231.namprd02.prod.outlook.com (2603:10b6:610:d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15; Sun, 9 Jun
 2019 00:04:31 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CY4PR02CA0038.outlook.office365.com
 (2603:10b6:903:117::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.14 via Frontend
 Transport; Sun, 9 Jun 2019 00:04:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Sun, 9 Jun 2019 00:04:31 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sun, 9 Jun 2019 01:04:24 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sun, 9 Jun 2019 01:04:24 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 mark.rutland@arm.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=48046 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hZlJw-0001PN-E6; Sun, 09 Jun 2019 01:04:24 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V5 11/11] MAINTAINERS: add maintainer for SD-FEC
Date:   Sun, 9 Jun 2019 01:04:16 +0100
Message-ID: <1560038656-380620-12-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(376002)(136003)(2980300002)(199004)(189003)(60926002)(48376002)(426003)(8936002)(106002)(7636002)(28376004)(478600001)(71366001)(246002)(8676002)(70206006)(76130400001)(356004)(6666004)(70586007)(9786002)(2906002)(36906005)(305945005)(50226002)(4326008)(36756003)(336012)(47776003)(476003)(186003)(76176011)(4744005)(316002)(486006)(44832011)(16586007)(110136005)(54906003)(7696005)(26826003)(2201001)(26005)(956004)(51416003)(5660300002)(107886003)(2616005)(446003)(11346002)(50466002)(126002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6231;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c629dc-8a8c-474f-53f6-08d6ec6e0c3b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CH2PR02MB6231;
X-MS-TrafficTypeDiagnostic: CH2PR02MB6231:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CH2PR02MB62311AB688A8DE0B44BC51DACB120@CH2PR02MB6231.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 006339698F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RUXMhg+a6vWNoI8O/xqYxOYZzcXNqNpddQ0K4nsnwqLbHUyJApMmHBVXoM3ZFEzbcmHIMvjmNNciYHhhX0PkWYoEQw0dBz4gZQxUs66fF+f4xLQySIns1BBpe5Tz2fn0KyyC4zSZVzPLKbcnKLQ/QNxm0f5ACrj8Uu6SGCnpLJTEi2YxY9EnmgsD/u6290hieEvG8JgJgqEufjjBbfJlYGTDcMkkMZbD1vJHrtQ7J6PQSS+oKjUfvP4s9kM2aGIpuXNYgKVPIqw4W5/ypdwtbLrMOzShkFVe+SyD3rgfDTZZ4CQGZQ7JWhpVi95PE+y6TLyOFYo7YXNlcwH0Iw6oEJgkNnk7ghrY0nap7RMQNX6KIUfwKbmNt5HoeLt/TghAhv1KmPLzQ4znXxcFQXhE9qnH1L7W8UkjSZvc1gXTztQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2019 00:04:31.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c629dc-8a8c-474f-53f6-08d6ec6e0c3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support

Add maintainer entry for Xilinx SD-FEC driver support.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfe48cb..2b754a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17345,6 +17345,17 @@ S:	Supported
 F:	Documentation/filesystems/xfs.txt
 F:	fs/xfs/
 
+XILINX SD-FEC IP CORES
+M:	Derek Kiernan <derek.kiernan@xilinx.com>
+M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/misc-devices/xilinx_sdfec.rst
+F:	drivers/misc/xilinx_sdfec.c
+F:	drivers/misc/Kconfig
+F:	drivers/misc/Makefile
+F:	include/uapi/misc/xilinx_sdfec.h
+
 XILINX AXI ETHERNET DRIVER
 M:	Anirudha Sarangi <anirudh@xilinx.com>
 M:	John Linn <John.Linn@xilinx.com>
-- 
2.7.4

