Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700F7C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DD620881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JSAu+tSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfD0WFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 18:05:40 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:28257
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfD0WFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 18:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMJRIynxqQf5thN4/TWKI3rE21V6IP0fJI8MvgSh6wo=;
 b=JSAu+tSSjSvrKmh2hDNr3BCYsiBVb4kzd/xkWRAoUfj5LMhV2VwDtxqbxn1yWQ4mHGXdyos3tkQkNDhnF8IElTuVycBjoav00FqkcSByGjr7jCbN6kI+U2hVf0SwWkPaIUr/9tkN9I3tXC0gqPUGJCJYB2R6NxcDXU2gl8JobuQ=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by CY1PR02MB2012.namprd02.prod.outlook.com
 (2a01:111:e400:c5ab::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.12; Sat, 27 Apr
 2019 22:05:27 +0000
Received: from CY1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.12 via Frontend
 Transport; Sat, 27 Apr 2019 22:05:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 CY1NAM02FT061.mail.protection.outlook.com (10.152.75.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1835.13 via Frontend Transport; Sat, 27 Apr 2019 22:05:26 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 27 Apr 2019 23:05:12 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 27 Apr 2019 23:05:12 +0100
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
Received: from [149.199.110.15] (port=52636 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hKVRY-0002Gu-9c; Sat, 27 Apr 2019 23:05:12 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V3 12/12] MAINTAINERS: add maintainer for SD-FEC
Date:   Sat, 27 Apr 2019 23:05:06 +0100
Message-ID: <1556402706-176271-13-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(189003)(199004)(60926002)(47776003)(186003)(16586007)(956004)(4744005)(106002)(246002)(26005)(336012)(2201001)(70206006)(36906005)(356004)(6666004)(316002)(126002)(71366001)(11346002)(4326008)(70586007)(50466002)(2616005)(36756003)(446003)(426003)(5660300002)(476003)(28376004)(76130400001)(48376002)(93146003)(486006)(44832011)(107886003)(26826003)(9786002)(478600001)(110136005)(305945005)(51416003)(54906003)(7696005)(2906002)(76176011)(8676002)(8936002)(50226002)(7636002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2012;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20cd607-37e8-41b5-f30a-08d6cb5c74b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CY1PR02MB2012;
X-MS-TrafficTypeDiagnostic: CY1PR02MB2012:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB201243442047103C90CF09ACCB3F0@CY1PR02MB2012.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0020414413
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DVPzSicVVO6iyumx9Zx1Ii6y+STx3o27ZSspBBi7VM62wJMELm7al32M5fKLlNt7gPjggnGMAD3lI2ixqGzjxST5mnNgyhxa5zLyDzrD4Yj/0RhgHwMJEykggBS9ip+vb5F/P4nryMC95ZkA/w91QTWcih/aBf6bmW4nY+N/bBgPXPysxj+qDnBw93cUOj43rex1hqfqWj+sXQPEfiS1cD+B3gA02wOFLaVTJSTIrJ+3ZJ26yr6OikFi4xxra0ezCbyvVr0b4xhlZrFplOcsIkqL/8v3Juxz59RYWUBdgKdlCLFA1DCoIc0+U9eux9oWRk20KmaOhCqZi+kpDN+ATvh0lmUjQiVdxXrNJzLF+eQvCDzzk2svKJd0t8BhZBl7Q46Vi9wA0dwN/10l9nznuIYZSMktSuHspoyXJunYMcQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2019 22:05:26.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20cd607-37e8-41b5-f30a-08d6cb5c74b9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support

Add maintainer entry for Xilinx SD-FEC driver support.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d72ee..14e9335 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17116,6 +17116,18 @@ S:	Supported
 F:	Documentation/filesystems/xfs.txt
 F:	fs/xfs/
 
+XILINX SD-FEC IP CORES
+M:	Derek Kiernan <derek.kiernan@xilinx.com>
+M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/misc-devices/xilinx_sdfec.rst
+F:	Documentation/misc-devices/index.rst
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

