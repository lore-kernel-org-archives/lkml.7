Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB463C5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844F320830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="l9ju0YHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGGAPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 20:15:51 -0400
Received: from mail-eopbgr810043.outbound.protection.outlook.com ([40.107.81.43]:45120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbfGGAPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 20:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gvQRPQg7Az/O6ZGWOHhhM1XBzmELtS+utvOY8QRI3o=;
 b=l9ju0YHnog2zm0NxfRmgvtSiF5Vn0oZi3TPDdmm9v/RV0vShYV/iMFIjiZyXmCeH77q6pjHXrbVTYzYJgat5NQFZa4sZ6QjTZAxr35/jhI6/GFYXkCetNbQE/4uMZ3jI1EwOLxYU/QqQjKOSFAjrBH3cDSQpsxuqGlfvC4SPWFA=
Received: from MWHPR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:301:74::44) by BL0PR02MB3713.namprd02.prod.outlook.com
 (2603:10b6:207:47::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.19; Sun, 7 Jul
 2019 00:15:48 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by MWHPR0201CA0031.outlook.office365.com
 (2603:10b6:301:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Sun, 7 Jul 2019 00:15:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2032.15 via Frontend Transport; Sun, 7 Jul 2019 00:15:46 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sun, 7 Jul 2019 01:15:45 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sun, 7 Jul 2019 01:15:45 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=58228 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hjuqH-0004ON-7E; Sun, 07 Jul 2019 01:15:45 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V8 8/8] MAINTAINERS: add maintainer for SD-FEC
Date:   Sun, 7 Jul 2019 01:15:42 +0100
Message-ID: <1562458542-457448-9-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39850400004)(136003)(2980300002)(189003)(199004)(316002)(426003)(54906003)(305945005)(16586007)(476003)(110136005)(60926002)(106002)(47776003)(50466002)(126002)(36906005)(36756003)(44832011)(28376004)(71366001)(48376002)(486006)(478600001)(26826003)(107886003)(4326008)(446003)(8936002)(8676002)(2616005)(956004)(11346002)(7636002)(246002)(9786002)(26005)(2906002)(186003)(50226002)(4744005)(2201001)(5660300002)(76176011)(70586007)(51416003)(336012)(70206006)(356004)(7696005)(6666004)(76130400001)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3713;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e66050-d9a4-44bd-dda5-08d702704242
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL0PR02MB3713;
X-MS-TrafficTypeDiagnostic: BL0PR02MB3713:
X-Microsoft-Antispam-PRVS: <BL0PR02MB371384181C8BABF14DE262D4CBF70@BL0PR02MB3713.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0091C8F1EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TSFIagzUE9QRqECP3wtH4qWtK0PqROjQcORauYMnTQHWWhM4ZfYOJc3oSdeWK4caKAhKAhkUqtlDPqMmIjIcG4jLXL3GiTIO+O3mmi2EGgpgrAwlIEbY5WnmZvqXkm2+AzYmq6uMlB0LPyH9L12A0/l0wN46ovA6zdGFoUfx4ukHS1wsxMF9clGLVhkWR19Rk5rbhZhTe3JsjioWC/wsJCdZsnqkNMFX+SjVHGRtwjV1T0ebJEjrk8HNTCnGOR++MS/1EI1SfZMXTKpkW66QgCkoJaWecF8CEm+QVW/RH11VKZHxqx2hUJ+FyCbaAcr32P+ApiIW3LYNT+wWWV8eFFuICiuJHJJtlAQnMa18ypUO+UKgzXZyJNpIORf0ql3BmnSLAqTBNs47N+1VGiKECSSet8P1e2kp2qwskhCM+jo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2019 00:15:46.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e66050-d9a4-44bd-dda5-08d702704242
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3713
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
index 1fc7baf..6a9db56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17402,6 +17402,17 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
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
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.7.4

