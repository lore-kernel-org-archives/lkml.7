Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893502081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SdfthIC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCIOHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:07:48 -0500
Received: from mail-eopbgr820055.outbound.protection.outlook.com ([40.107.82.55]:13216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfCIOHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/3XnQZ0UFUbxBi79NtOYnbuqdvtZJTx/2SrCCJ5t7U=;
 b=SdfthIC/UWtKH1UHYiaAOreLAHmB97clGZv+v8sYKGBSvbkHrZgFibKx9ZlYjXeIiecXPtG2aZdydhOTv7o7noiVM2PScDzJiDhEM8QZ/Ai32V4ts2e8mgqLdlimYm7Ge0mt4XCzQLiq+vx0O8gHRS/cYPQmadSiVZX8WMkmknk=
Received: from MWHPR02CA0005.namprd02.prod.outlook.com (2603:10b6:300:4b::15)
 by CY4PR02MB2375.namprd02.prod.outlook.com (2603:10b6:903:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.16; Sat, 9 Mar
 2019 14:07:44 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR02CA0005.outlook.office365.com
 (2603:10b6:300:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1686.18 via Frontend
 Transport; Sat, 9 Mar 2019 14:07:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Sat, 9 Mar 2019 14:07:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h2cdb-0006NZ-2A; Sat, 09 Mar 2019 06:07:43 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h2cdV-000884-Uk; Sat, 09 Mar 2019 06:07:37 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x29E7UP4030464;
        Sat, 9 Mar 2019 06:07:30 -0800
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1h2cdO-00087c-1i; Sat, 09 Mar 2019 06:07:30 -0800
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH] net: can: Increase tx queue length
Date:   Sat, 9 Mar 2019 19:37:26 +0530
Message-ID: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(14444005)(336012)(426003)(126002)(2616005)(476003)(4744005)(305945005)(8936002)(36386004)(50226002)(106466001)(50466002)(356004)(6666004)(186003)(63266004)(5660300002)(486006)(47776003)(2201001)(2906002)(4326008)(48376002)(478600001)(26005)(51416003)(77096007)(7696005)(36756003)(9786002)(8676002)(81156014)(81166006)(106002)(316002)(54906003)(16586007)(110136005)(107886003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2375;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d6f7d6-1635-45ea-666a-08d6a49899a1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2375;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2375:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2375;20:hJf8uwv6XXHMHLZfns2zC3rtOeJLreQA01eh4BkKagULQ6tUyW0uCuYiD6gOpEGynh24Zhclp2X004Sk2q2HuZgulTpBZM+w5FE7p9Wvk6sru+t3bEl2ZFN606msI68Q7VcYzEPLM4nAMWb/MhF4uozjabfIkb+WtvURlz8Nsl5qMmZwrCdhXeO99JRSDUVBMuzby4VhQHw/COTvvJpnONix5N/ocAtTN296OdnrKcOJpNt8Fs0m80thpbvvr9E76FR7wDiLTzDcrLq7Lvim80l8WZ3XjTvRNz34BvPuLXb1UtgYmhlzF+6YciStgelaVOBjtWiqUVgoKP9ypqBa91D2BSnvVmSNFalHSYH9a6NitKKtonBMDkopBOxEyFCCxeirLVxB30QuqtkGMPfwBeOLmj5fedGsaDFrhSLKkrsNT5WihpWszGXM1Hq+TfeTSaRWIF0R1armO0WVkXlnhOFwhQ4w2IdzUmXKJ4a/63pMOJtGP9+JBEUjboJXf7T7
X-Microsoft-Antispam-PRVS: <CY4PR02MB2375D5904D56B86556DCED52DC4E0@CY4PR02MB2375.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0971922F40
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2375;23:POfsHPMZtwW4fEgGVJH6IihlD06qgiYhQXzqTgpPs?=
 =?us-ascii?Q?8ZYuaNIeqGoai4Nkdw1l1dzE5TrkdFAdKWRNZoh8oz8eexKOZBLYB2QvnokK?=
 =?us-ascii?Q?SYLsFC38Qg6y13FwHGa9/Ze0+ml6SfuZZlxN7987witfzGv3+DdxJoaetV4F?=
 =?us-ascii?Q?n4QxnEswCpnK26SwGvSbcd372NP38rOANv/rs3T5cR4CufWLxIfeLnvhneAA?=
 =?us-ascii?Q?NKpXKI9lFumDouUVsxzE05c3tCEAL1+aoBBUDClPsW9yS6oAfSvz0OAz9wag?=
 =?us-ascii?Q?CW9kaS8NrJSiMhc5C4PNlbpQOFl2eMRvWd3hieAtw/eMwJyRLyQUEAVCvaO2?=
 =?us-ascii?Q?QXAYl1Mko2g2VQTOPfp4YMY/wyeSAyhqhfN4p6W7ifl3aDIqj6BrK6tIwI8W?=
 =?us-ascii?Q?Z3nHLaFDAAxattlag1otTfhdrFfk4i7lUbMM+0k/qVxpKt+cQtMCBKxHDokf?=
 =?us-ascii?Q?U9BS5CAO4SwMdXVirl8PHHYxbe3wtBSOEY2H4l1gdp3oE6JrftniEfGQYTSj?=
 =?us-ascii?Q?FEXgBfxiDDWERYsoP+ngdm1LdltknsaaNphlMXNK2sFUNYLt+4/0ncCsdzeG?=
 =?us-ascii?Q?SbCpt46f9FXkMv8OoyN9LHXWy+kxOQyJyHpDw4iwQ7gQOER833Vk7HzvJwo/?=
 =?us-ascii?Q?kUe5PSrnGHuglNRWDCRcUQm8sAoagSJUMWhrCF8JA/Rcf2ONC598IdayVP7A?=
 =?us-ascii?Q?gHenQYm/0JVu+82llZfNGtUJR/F0tkJvBHo5pq8wmc7cutmqa4P4TgUH7L3P?=
 =?us-ascii?Q?VF7xCfVuZLHFtC4IVLdvGfvHnUJ0PhUHWA9OiNL7eNGuKTkJU1o2E8KPq3Bb?=
 =?us-ascii?Q?THZRzkS2WUsOBI4GVXPx5KjSiegmGIibiMzWd9dMXN0FFS5xfFmP77I1PVZe?=
 =?us-ascii?Q?/ditfEqu2cNTF28rH9fvWuWZKB6JOste1eK/ee6GSwXTK844I1xnnD9/huNI?=
 =?us-ascii?Q?9oQULCh8EwChj+6oeu/h1o2/POxXM+q9yJgh5cmmGyBxJ5ExoO+AhDkqSsmR?=
 =?us-ascii?Q?hyjjolcUw+VaUEwO2gVQXXLfVQBVVjp1tLOxOcXe+WDcrIrwsnr5bbJFoTyJ?=
 =?us-ascii?Q?8ok8ph0ke+2XXErd8ZsFbcgxC5Qd3M/ttJ4SWgB8GpRtem1bg=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: iEheoXLiOXLlcbul5F8zdhe9Cbiy2F/BRLILokr7MkWK5rlmnGkUd7QD63JHiLsp8jD8cNB6sMZVdRcKcnnbx9lTkjkZtfeeZjFFqo4qlLFu/Z3w8FMS+7O7mQH/xtN0ezHZEQGXNVvHoORdIF1XxBJgozhyzBqz4vIxYodYdX0jrQHRqdcBQyonHYWaZAn1CPlTgZkH1/6JVfi23JiO3H8N6k23B7douH2V1+h2YWN0yUt5L67foWRRa7VUJrRAlM4vrNduHJqKHEUvEclsrNwZkyfzNFK8ZwUD/Hg4hsl7c8MdW0QzOvTSYh5DSENO97j7YJxWhfKfb1ttSeDaEvthnnFLeF3tvNNlrd0DO9nBKog5pV3tvFfPQgkbtin+GDGkGaUIisQjRqXAV/gj2aBkd2UgqiU+EXGTcvP5q+s=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2019 14:07:43.5096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d6f7d6-1635-45ea-666a-08d6a49899a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While stress testing the CAN interface on xilinx axi can
in loopback mode getting message "write: no buffer space available"
Increasing device tx queue length resolved the above mentioned issue.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
--> Network devices default tx_queue_len is 1000 but for socket
can device it is 10 any reason for it?? 
 
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c05e4d5..32bd5be 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -642,7 +642,7 @@ static void can_setup(struct net_device *dev)
 	dev->mtu = CAN_MTU;
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
-	dev->tx_queue_len = 10;
+	dev->tx_queue_len = 500;
 
 	/* New-style flags. */
 	dev->flags = IFF_NOARP;
-- 
2.7.4

