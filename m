Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AAEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4933520665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="og2YQmX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfFYEqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 00:46:51 -0400
Received: from mail-eopbgr740051.outbound.protection.outlook.com ([40.107.74.51]:13392
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfFYEqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6D+3ooFLGTQVLRknkth4/HujIit7qoNMsYM6fToroE=;
 b=og2YQmX7ePmTggTdokoBXbTiXGzTRD2Lpu95KqrVPIFcI0iqFrYijGtQaE6Gl9m0t4CCBtZ7bHdKPp6jPy+BzLpxhFuQsOLnNCfBpjQ0SnatXI59w81IEvUVVIFvpv6eA/TRLv2D/4qs/Zq9B63kUajSeml02w7/2Xn6DhMiwTE=
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by MW2PR02MB3786.namprd02.prod.outlook.com (2603:10b6:907:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 04:46:46 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 04:46:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 04:46:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:32852 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hfdLx-0006rv-CJ; Mon, 24 Jun 2019 21:46:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hfdLr-0007mZ-Ew; Mon, 24 Jun 2019 21:46:39 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5P4kawv015624;
        Mon, 24 Jun 2019 21:46:36 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hfdLm-0007lC-P1; Mon, 24 Jun 2019 21:46:35 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     miquel.raynal@bootlin.com, helmut.grohne@intenta.de
Cc:     richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, vigneshr@ti.com, bbrezillon@kernel.org,
        yamada.masahiro@socionext.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v17 1/2] mtd: rawnand: nand_micron: Do not over write driver's read_page()/write_page()
Date:   Mon, 24 Jun 2019 22:46:29 -0600
Message-Id: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(199004)(189003)(486006)(70206006)(70586007)(1076003)(107886003)(5660300002)(48376002)(8936002)(50466002)(8676002)(81166006)(81156014)(106002)(16586007)(316002)(305945005)(36386004)(103116003)(2906002)(2616005)(476003)(126002)(63266004)(426003)(336012)(36756003)(77096007)(478600001)(26005)(186003)(7696005)(51416003)(7416002)(47776003)(50226002)(356004)(6666004)(9786002)(4326008)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3786;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f79b9f0-f131-43fc-4805-08d6f92820b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MW2PR02MB3786;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3786:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB3786D899FD5804BDA969700DAFE30@MW2PR02MB3786.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:200;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OPzJ0r2nteg9BI2IxpmS8N18w/wAE2VKs11AVIrnFAjAa8KIjO/tXm75Lmw//0kCBkA23QXx7AWK2vFpwVIa7lLWjffbigljesZDCC3uo0IrcFdkLH5tovTRXJBEWE1m356Ui9mgeGW03NroQH/le9b3U3m7NJvVL30S5c9oiuPqxcB+FcAFJMin1ohQ/RoYt+PeBA9vbi0djyI9Cis+rxvd2r16d70LpH7E/bSyDm4u8yGLsZeUEfvt6NHcs/HIB2YV8z5LbgfcbfOvDd2Db+PTCQqRGJSQYZDbKaQmwuYuvdoLUpBTJrs8o3D9RuQzUG41rlJ2Fep+J7vDGM1agqDPsyEw9BEr7Y5EyNuibCy/pRIiHNBML3UzuqfzeQ4AYxFE97G8Bf4+oJOWPixFGPUkDwGRoYZTckPgby0XtTw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 04:46:46.0531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f79b9f0-f131-43fc-4805-08d6f92820b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check before assigning chip->ecc.read_page() and chip->ecc.write_page()

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
 drivers/mtd/nand/raw/nand_micron.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index cbd4f09ac178..565f2696c747 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip)
 		chip->ecc.size = 512;
 		chip->ecc.strength = chip->base.eccreq.strength;
 		chip->ecc.algo = NAND_ECC_BCH;
-		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
-		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
+		if (!chip->ecc.read_page)
+			chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
+
+		if (!chip->ecc.write_page)
+			chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
 
 		if (ondie == MICRON_ON_DIE_MANDATORY) {
 			chip->ecc.read_page_raw = nand_read_page_raw_notsupp;
-- 
2.17.1

