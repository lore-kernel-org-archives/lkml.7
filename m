Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A682C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F620830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rwT2JQ+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGGAPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 20:15:54 -0400
Received: from mail-eopbgr690087.outbound.protection.outlook.com ([40.107.69.87]:28273
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbfGGAPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 20:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwbDJkzilP7DmymYO/JI/NbOe5Mi309nAY5nqBncFYA=;
 b=rwT2JQ+rG7fI57bFL28aGbmpt8x09xF8xWtFQlmEW3+bqR4D1pcKMwVMoL/2t6LzKFa7IK9wl6YrZqFFy1mODolS82HT4epp2Pw8ZMIo8GjNcX5QO4Niwr3f6rUD0F3Iz+bsun7r9RLYVYgKAryEsskJ+tSZW+2uJkRavoI5VGU=
Received: from DM6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:5:1c::23) by
 CH2PR02MB6759.namprd02.prod.outlook.com (2603:10b6:610:7c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Sun, 7 Jul 2019 00:15:51 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM6PR02CA0010.outlook.office365.com
 (2603:10b6:5:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Sun, 7 Jul 2019 00:15:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2032.15 via Frontend Transport; Sun, 7 Jul 2019 00:15:51 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
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
        id 1hjuqH-0004ON-6f; Sun, 07 Jul 2019 01:15:45 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V8 7/8] Docs: misc: xilinx_sdfec: Add documentation
Date:   Sun, 7 Jul 2019 01:15:41 +0100
Message-ID: <1562458542-457448-8-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39850400004)(2980300002)(189003)(199004)(7696005)(76176011)(36756003)(51416003)(6666004)(356004)(47776003)(26005)(336012)(186003)(26826003)(478600001)(4326008)(50226002)(4744005)(28376004)(36906005)(107886003)(9786002)(316002)(54906003)(16586007)(106002)(48376002)(110136005)(50466002)(426003)(44832011)(446003)(2906002)(2201001)(60926002)(956004)(70206006)(76130400001)(71366001)(305945005)(126002)(8676002)(5660300002)(11346002)(476003)(2616005)(486006)(70586007)(246002)(7636002)(8936002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6759;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9692e11-4830-4cfa-6290-08d70270451b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CH2PR02MB6759;
X-MS-TrafficTypeDiagnostic: CH2PR02MB6759:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6759990735D2F917353A7CB8CBF70@CH2PR02MB6759.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0091C8F1EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Tb3ouulCY3IVmKNBQxr04AwztK6be5lw9DTmeeH2pD2eI4DIJCqcau/fGKUUrTLIajJb+y/M9sIIgWviCJ61ovbFBgRi/tgFllqo258cSJ0OFjWExBGEbUIUe5RQpqFc4YYPqoMLG1dmbNMub/LMFIjzSISwl41kagEtlP2dDIRED5uOrMuq1FDIX4W4F2mOn36Lh3iJmYulW1wEMBoqoDB8buPAJawMzzvj0/cnVg5EVrd/gqVdzTYYpCfnhHHY5Kt2kvSDw9+J0rD/VeUD8zMZEfvLXd/806RJarnXQ44SHukurfHIPH6GkZehAw17yOYXnDCxwGxDcotJcZZqmI6WDhTwdUsiJ1uOExaw5gZaJs+7mwBJKS15GOELgrd1aS8XnjVmZUfVBFqOmZib4xK8/JlpkXrtue/sb71p1bU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2019 00:15:51.3578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9692e11-4830-4cfa-6290-08d70270451b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD-FEC driver documentation.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 Documentation/misc-devices/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index a57f92d..f11c5da 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -20,3 +20,4 @@ fit into other categories.
    isl29003
    lis3lv02d
    max6875
+   xilinx_sdfec
-- 
2.7.4

