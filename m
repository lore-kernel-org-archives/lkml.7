Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A22C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263332086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yZVQtlpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbfFKJ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:57:19 -0400
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:46639
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727726AbfFKJ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLcWA04CHD2qmOu+HPhPVYXj9nIzTQB6VVpEU55mCI8=;
 b=yZVQtlpDj4RxYkPEccJ2oc2bnFpgAFQnQbxn9Yg8W3jElte6NKfxk61hkMYwqCT8GyqxbKPip8pH7bl3Rpl5UEuCr4pFMugK2fUTTJ9dbnQRs+GC3gYTvl+n3iR+b4lPLp+TErikIUAOGtnbm/KQpraDHrpJW09KYhQzVb5Ie+c=
Received: from BN6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:405:60::48)
 by MWHPR02MB2685.namprd02.prod.outlook.com (2603:10b6:300:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Tue, 11 Jun
 2019 09:57:15 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR02CA0107.outlook.office365.com
 (2603:10b6:405:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.14 via Frontend
 Transport; Tue, 11 Jun 2019 09:57:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Tue, 11 Jun 2019 09:57:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46260 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hadWk-0006sr-2j; Tue, 11 Jun 2019 02:57:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1hadWe-0002WX-VB; Tue, 11 Jun 2019 02:57:09 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5B9uxjD016569;
        Tue, 11 Jun 2019 02:56:59 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1hadWV-0002Qn-7z; Tue, 11 Jun 2019 02:56:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6AD34121745; Tue, 11 Jun 2019 15:26:58 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, adrian.hunter@intel.com,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        nava.manne@xilinx.com, manish.narani@xilinx.com, olof@lixom.net
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Add ZynqMP SD Clock Tap Delays configuration support
Date:   Tue, 11 Jun 2019 15:26:48 +0530
Message-Id: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(189003)(199004)(305945005)(316002)(16586007)(42186006)(44832011)(36756003)(72206003)(26005)(50466002)(4326008)(106002)(51416003)(48376002)(63266004)(186003)(36386004)(5660300002)(50226002)(70206006)(6666004)(70586007)(356004)(4744005)(2616005)(478600001)(426003)(8676002)(476003)(2906002)(103686004)(81156014)(486006)(336012)(126002)(52956003)(8936002)(47776003)(81166006)(6266002)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2685;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942f9d8f-a48b-4113-a354-08d6ee532e6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR02MB2685;
X-MS-TrafficTypeDiagnostic: MWHPR02MB2685:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2685836B6BB2FF205EE49EA9C1ED0@MWHPR02MB2685.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 006546F32A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yXyfAJoar2Ujdieo3yIc5V27CharP4vE3J06a+uF8aweiR3dMwtQ/XDZEroYTVY/e9ORgHsEsq8842lXbXZM3aY74QlBgyPnUDzAwMdhq3zP0tfiuU3GBVCQ3qmqhg78V9Aad+a1r4gJVFCf6nqppYl/j3TB+2bi93l7QkCz2LoCalb/kRLkgvATAYhig7vv8RBLAQQtTSSMGwGRbO4YDeQK26vfobAB+wS77L6xzMk2tbd3lS+d/QDeyyhuJMR7AI+AXgRjw6RbAeGb1c6JwZm3xhb/wd98p7ARkVU8VepqFi9J9rmmGx2Njis1AcWrK1pOkNHiD6C1vpOIDGQdFrH+hjht14BJ4XNqzjhTMVzS42q8DTCeVxa/tCUSff90aMX+IKYt7nFCzJDMIFLZ5SPhp1C1vF02ZYTmqbsSpuQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2019 09:57:14.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942f9d8f-a48b-4113-a354-08d6ee532e6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support to configure SD tap delays on ZynqMP platforms
using Xilinx firmware driver and clock framework APIs.

Manish Narani (3):
  firmware: xilinx: Add SDIO Tap Delay API
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  32 ++++
 drivers/firmware/xilinx/zynqmp.c                   |  32 ++++
 drivers/mmc/host/sdhci-of-arasan.c                 | 173 ++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               |  17 +-
 4 files changed, 252 insertions(+), 2 deletions(-)

-- 
2.1.1

