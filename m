Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09828C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D419620874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uJ7pHyVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406276AbfFKRaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:30:39 -0400
Received: from mail-eopbgr820083.outbound.protection.outlook.com ([40.107.82.83]:19652
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406144AbfFKR36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zkiwgEPnpEEjtQsZc3vHqTSIS+MSIOz+hPajR8Pm94=;
 b=uJ7pHyVJKyNI/vsGQfXlANYPdc7cszn81p7SPoKTMQpPtL84oaa505jmPLQgxYOCzfy+S9IJZz6zuva/1MNjg3AnY4g8ultXjeLRSqB00vkfN5buforNa3zHpAcmhRgRAg7aeU2wzTMm3ioJ8xCTBASDESifXjeAYi1XqlaDMX8=
Received: from BN6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:405:60::37)
 by CH2PR02MB6229.namprd02.prod.outlook.com (2603:10b6:610:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Tue, 11 Jun
 2019 17:29:55 +0000
Received: from BL2NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR02CA0096.outlook.office365.com
 (2603:10b6:405:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.13 via Frontend
 Transport; Tue, 11 Jun 2019 17:29:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT035.mail.protection.outlook.com (10.152.77.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Tue, 11 Jun 2019 17:29:55 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Jun 2019 18:29:48 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Jun 2019 18:29:48 +0100
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
Received: from [149.199.110.15] (port=50346 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hakai-0002MF-TI; Tue, 11 Jun 2019 18:29:48 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V7 11/11] MAINTAINERS: add maintainer for SD-FEC
Date:   Tue, 11 Jun 2019 18:29:45 +0100
Message-ID: <1560274185-264438-12-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(2616005)(110136005)(4744005)(956004)(476003)(50226002)(486006)(44832011)(71366001)(11346002)(426003)(16586007)(446003)(2201001)(9786002)(60926002)(7636002)(316002)(246002)(5660300002)(336012)(8936002)(2906002)(186003)(107886003)(26826003)(48376002)(8676002)(4326008)(50466002)(305945005)(126002)(36906005)(54906003)(478600001)(28376004)(70206006)(70586007)(76130400001)(51416003)(26005)(7696005)(47776003)(356004)(36756003)(6666004)(76176011)(106002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6229;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9dd5e9-a6b5-47ed-c3f2-08d6ee926b95
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CH2PR02MB6229;
X-MS-TrafficTypeDiagnostic: CH2PR02MB6229:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CH2PR02MB62298738F43DC59593CE74C4CBED0@CH2PR02MB6229.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gq5GnCDHc1hU1jez2wcuIKWgeHoshn3+NCp7zV5YIM0fp28zOsBaU+ETnfWTCJwKzV9kUxnB33LR5tAs5x6m2WoYdgex4qzMrGgVZFoKQnJHU0FPYlxV/eeAGw1o9bym49STy6pCeEwYKSG41NUWal2e4xCAD+cxcEXEB/zQ4FRsSqTfJxrnSVjK+krk8yztpXX5XdLGfphzKxo+ozVfUkH2x94KjZgQ2ZwppG+zyUYZEBNPJPcleLxMAjlGsF9ejOTupl+ce8EI31uFSc+Qavv6Cn1SuzeVle7YQbKR8N8GRXicj0Iu1v4REVn+dzUckU1TqzekLKNODKGfBOURv/vreryQZI07Q+Wanu0MMd2+8kfwrGsskKIJaXUkZ93zIBmfiscYaqsi44y0swD5YGt3ILhogFIxW1OB/3TS73I=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 17:29:55.5505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9dd5e9-a6b5-47ed-c3f2-08d6ee926b95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support

Add maintainer entry for Xilinx SD-FEC driver support.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfe48cb..9fde3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17345,6 +17345,15 @@ S:	Supported
 F:	Documentation/filesystems/xfs.txt
 F:	fs/xfs/
 
+XILINX SD-FEC IP CORES
+M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
+M:	Derek Kiernan <derek.kiernan@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+F:	Documentation/misc-devices/xilinx_sdfec.rst
+F:	drivers/misc/xilinx_sdfec.c
+F:	include/uapi/misc/xilinx_sdfec.h
+
 XILINX AXI ETHERNET DRIVER
 M:	Anirudha Sarangi <anirudh@xilinx.com>
 M:	John Linn <John.Linn@xilinx.com>
-- 
2.7.4

