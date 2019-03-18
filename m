Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0322320854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P13IgWzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCRMcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:32:14 -0400
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:19844
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbfCRMcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lZhSRNE1AkjF/mJC7MnIdy+vSymGbLguEXAqm7XIhc=;
 b=P13IgWzFYBfNP+2RN+voVAgoEFb6eppPIzkmfCs+G8XpTfkoe9FnY88bB62zkRwFP1soGY681syAEV8Wj1d5nZDCDp0T1uQ9iQBK72bFmyRktdOT2YLL5Zt82PVAuvlD5u4slHaU4niO7KKlWyzF3C4StTKyNvSkHza23M0XHgw=
Received: from BN6PR02CA0034.namprd02.prod.outlook.com (10.173.146.148) by
 BN7PR02MB4050.namprd02.prod.outlook.com (52.132.223.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 12:32:10 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR02CA0034.outlook.office365.com
 (2603:10b6:404:5f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:32:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:32:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rR3-0008Cg-KF; Mon, 18 Mar 2019 05:32:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rQy-0001QP-BQ; Mon, 18 Mar 2019 05:32:04 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICVxMU001056;
        Mon, 18 Mar 2019 05:31:59 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1h5rQs-0001L5-PL; Mon, 18 Mar 2019 05:31:59 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <richardcochran@gmail.com>, <claudiu.beznea@microchip.com>,
        <rafalo@cadence.com>, <andrei.pistirica@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [RFC PATCH 0/2] Sub ns increment fixes in Macb PTP
Date:   Mon, 18 Mar 2019 18:01:50 +0530
Message-ID: <1552912312-30837-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(189003)(199004)(126002)(336012)(486006)(478600001)(54906003)(4326008)(186003)(2616005)(426003)(2201001)(48376002)(50466002)(47776003)(106002)(5660300002)(110136005)(77096007)(476003)(26005)(36386004)(4744005)(44832011)(16586007)(106466001)(36756003)(316002)(63266004)(107886003)(51416003)(7696005)(8676002)(2906002)(356004)(6666004)(305945005)(8936002)(81166006)(81156014)(9786002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4050;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f994076a-3266-4e88-cc6b-08d6ab9dbdea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN7PR02MB4050;
X-MS-TrafficTypeDiagnostic: BN7PR02MB4050:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB40500523F885029FBFD0BEA2C9470@BN7PR02MB4050.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: R6iIvkdzubi3YNJAEobRVTEVGBKXELRALARMT0X/sx3PGGk4I1tmAPT6T0ynSqfbTwFkVJfLxVgjTccYiGJrTUq2NSoUqnWu6VdR7Od+gUb61eGmW+KI4XYl7ymmREF2OzhWBwYdHXWq0cQTDL44ZSr2ekb9MV/y3bUXllgWK1JXi+4Kq5wesC3/PLv33yYQCJ2tjglPzwH00wVMbsb3JqL60PkgUQbvyLAmWVhTsLC8HXGwMpOeuJZ7hrQHyayh2UHlFbl+fd9fxbBEJbbP40SS7clH/DM24PXNzpHfjZc3+qaeji+Mfq60N5PVwJ5h0YC8dAqdeyXSF6gUHXHt2mDPslb0N4Lbo8Pzyz9mOMi2MzFO0TIkZMRmKFMQUIFBw5jfNkMC+8+04t8lZgQDj34lezKuC/NMZrZCXvQqkeg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:32:10.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f994076a-3266-4e88-cc6b-08d6ab9dbdea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subns increment register fields are not captured correctly in the
driver. Fix the same and also increase the subns incr resolution.

Sub ns resolution was increased to 24 bits in r1p06f2 version. To my
knowledge, this PTP driver, with its current BD time stamp
implementation, is only useful to that version or above. So, I have
increased the resolution unconditionally. Please let me know if there
is any IP versions incompatible with this - there is no register to
obtain this information from.

Harini Katakam (2):
  net: macb: Add separate definition for PPM fraction
  net: macb: Fix SUBNS increment and increase resolution

 drivers/net/ethernet/cadence/macb.h     | 9 ++++++++-
 drivers/net/ethernet/cadence/macb_ptp.c | 7 +++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.7.4

