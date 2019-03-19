Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C859C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305092147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KgYUZc2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfCSMFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:05:18 -0400
Received: from mail-eopbgr790081.outbound.protection.outlook.com ([40.107.79.81]:51712
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbfCSMEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLKVnHWoFZIcsSvDaVZPEP9tWu5/5uIWanKXDWS2WzY=;
 b=KgYUZc2NWjbx59t8hqjSxz8GUGh5RlIKxZB7+t2Bd8lHdHwLDqjkLmpk8DJf6/M57qBYibuD9A4urLm0osWoMf4u0PdPlmjTJqrqyMr1ScDKUN13DTTHEpuqkQigJfpzmPBad5VzgdsTqgK3p8DpNmAinHcE7l9lWkqchq1DUfc=
Received: from SN6PR02CA0035.namprd02.prod.outlook.com (2603:10b6:805:a2::48)
 by CY4PR02MB2200.namprd02.prod.outlook.com (2603:10b6:903:13::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.15; Tue, 19 Mar
 2019 12:04:44 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN6PR02CA0035.outlook.office365.com
 (2603:10b6:805:a2::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:43 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:40 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:40 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DU0-0003Ch-Lk; Tue, 19 Mar 2019 12:04:40 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 12/12] MAINTAINERS: add maintainer for SD-FEC support
Date:   Tue, 19 Mar 2019 12:04:24 +0000
Message-ID: <1552997064-432700-13-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(316002)(44832011)(47776003)(476003)(126002)(7636002)(71366001)(8746002)(486006)(26826003)(305945005)(478600001)(50226002)(6666004)(60926002)(356004)(9786002)(5660300002)(28376004)(8936002)(2201001)(14444005)(5024004)(2906002)(36906005)(4326008)(110136005)(93146003)(54906003)(106002)(107886003)(48376002)(50466002)(26005)(106466001)(956004)(336012)(446003)(8676002)(246002)(11346002)(2616005)(186003)(426003)(36756003)(76176011)(7696005)(51416003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2200;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a5bfcfa-a9c1-45ec-8a8b-08d6ac631336
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2200;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2200:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB22004322FE16C8FA874C1C2ECB400@CY4PR02MB2200.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HX3vac6GmqSLJ5f1tpPcPnwLt96g+9mowWL+WivS8fI/MRXaKDJhBxXI4QL3JfsqFOTsp8VQF2I4JlbvNLt9sHKN2q0OtiYhS/sg/VcrJVeDUHhZAoVhbUQiUArcXNgOpqFm88bIVD7Z9p9L3qMJeV+sQntwNS2zPPLDJIgD09ymwEReKwomH73hFIT/KnJTxvc+9rLlsEFgkcJ+XbzzBAm8j0DffoDBNzPkHpDEz4CINnjne5p6LbxWZAQiBy8Iq2+PVAGEOAQwsEaj0aAHPrCnWaCR7FTVpBgTiFAg4YtuX2ek2MhyqE+PBh1QJCfebn+UoQ9hB/1UcCLccRnxUhqCu3jwtTxnNtuJa6P2HmNbawN+HFiKYU07JgxYVEylozMLI5BelFr/qN/y9kNciXUj0BqdeK0yn62j9yv85zU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:43.9862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5bfcfa-a9c1-45ec-8a8b-08d6ac631336
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entry for Xilinx SD-FEC driver support.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf7..ba7a0be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17093,6 +17093,18 @@ S:     Supported
 F:     Documentation/filesystems/xfs.txt
 F:     fs/xfs/

+XILINX SD-FEC IP CORES
+M:     Derek Kiernan <derek.kiernan@xilinx.com>
+M:     Dragan Cvetic <dragan.cvetic@xilinx.com>
+S:     Maintained
+F:     Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:     Documentation/misc-devices/xilinx_sdfec.rst
+F:     Documentation/misc-devices/index.rst
+F:     drivers/misc/xilinx_sdfec.c
+F:     drivers/misc/Kconfig
+F:     drivers/misc/Makefile
+F:     include/uapi/misc/xilinx_sdfec.h
+
 XILINX AXI ETHERNET DRIVER
 M:     Anirudha Sarangi <anirudh@xilinx.com>
 M:     John Linn <John.Linn@xilinx.com>
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
