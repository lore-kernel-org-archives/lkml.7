Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA27C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D773F2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fLgMIXm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfLDX3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:29:40 -0500
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:6244
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbfLDX3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlaun8ZwESX+UFIf8DnsL/5tYV2av/PBIZrf2vI/NgL6h3woB5Fyg7c9W6E1iJD/AeTMI//DI0rdcHiECPxVNcDLAzlsdM07zOYt4f7e5QRs47i+z3roD/IqgAo2JLFCW+m4zam7XKBRnS/lWcnGxve3OQ6Yy4+MbH2UMgf5HH5LTbYeBIUxO6qS+vds3BjjD/Bunzx8kHoqVuWV93adO3X/9hbPNJVJA0vCdmiip6BAA3WPx758Pff2AjzoWtykMLVFF9Sk0zfNrtGYM1o59GUj+WbbrQsfzxqM4y6OaNa5K9znTrlANbE0oSFLyDmIVf4o37wNA/H4J6pu8M2osQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhQRQrRHXJzpymcVqd+6FVQMsZ96gqCd1J96oDRdrnQ=;
 b=Ur8Z8++jEo0PrsYPWloOOcQ1Xeyfz76MOqfzjnpJy+JOkQMfUterjHJyfWY8iriTaqiZCgNBThJjWWPNALpBP3I2wmnX9Pm0aKXtuKS1ifcw9UzI1W+A8IZgikM2ApYGM6xraDdtLA1pJAcrqy82f71Wu2M1YC+Lnwgk6F6FYwtHdKLF55GWUvAHChaJKEDnVE1oh9eDk4IogPpkSqUu5M5HrDd6eR5M1sWvvNygmFkO3+WcLHAT157V0EHf5vjwbiGgPGlXxP+oeoAYeX/sVR3sa5AQqPT4ICz6i4s0MjTM2o2AGalGZMxvLolGap4xGwL6nXqFCqUi4rF5b4oZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhQRQrRHXJzpymcVqd+6FVQMsZ96gqCd1J96oDRdrnQ=;
 b=fLgMIXm0eXNBfC5RD0y1eHHAqDEqL5JfqvlN01kN/HJHHvmr+3cS/C5fAzPMR+vQpLnx+xtMqMh1IhEg0GDwOYmASauq3HEoIEiAI0bm/HXsHdrJt1QHaw5aVhQTZrBg0/jMvS4JfcfzUAuoKEJoOCqAMUgkggkyy/g+gwKUJAE=
Received: from CH2PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:4e::33)
 by BY5PR02MB6385.namprd02.prod.outlook.com (2603:10b6:a03:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Wed, 4 Dec
 2019 23:29:36 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CH2PR02CA0023.outlook.office365.com
 (2603:10b6:610:4e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Wed, 4 Dec 2019 23:29:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Wed, 4 Dec 2019 23:29:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5O-0005aC-Qg; Wed, 04 Dec 2019 15:29:34 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5J-00080R-NV; Wed, 04 Dec 2019 15:29:29 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB4NTR2m004747;
        Wed, 4 Dec 2019 15:29:27 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ice5H-000802-DS; Wed, 04 Dec 2019 15:29:27 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 0/5] firmware: xilinx: Add xilinx specific sysfs interface
Date:   Wed,  4 Dec 2019 15:29:14 -0800
Message-Id: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(51416003)(48376002)(50466002)(2616005)(478600001)(81166006)(81156014)(2906002)(50226002)(9786002)(7416002)(36756003)(70206006)(8676002)(44832011)(426003)(70586007)(26005)(8936002)(5660300002)(356004)(4326008)(336012)(14444005)(316002)(36386004)(16586007)(6636002)(7696005)(4744005)(107886003)(6666004)(186003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6385;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be16e3c5-b1a8-4bd8-7e0b-08d77911d2ec
X-MS-TrafficTypeDiagnostic: BY5PR02MB6385:
X-Microsoft-Antispam-PRVS: <BY5PR02MB638588D9884BA0EC385A249FB85D0@BY5PR02MB6385.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0241D5F98C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uPlMiUyZXpDX3fBVcEfPJXBF/zS2YEuRI9eiYyXD7k+0w6BULnN86wJuCjas7ymkxQTH6XVzSNOPAudT41avwccFOuQ0mWuhEcvYFJFVWTOjgsmTIN5WmK4nG2Z1ApRB4EQsf4IqdsioaXj/zyFSzhLMhv/UZFDoLb6XmLYgxFpdmPWwJ8th8nVjkkdcAFeYHXYJ0cdRRHDBFgWDCC6+8+EwxHvTvJN5Zu9YamzuNcBp4HnERFdnvFZH4aZecMvi5HzkVANlfZ4dap32Os7y9zhVoF95lv8lM3JzqhlcxAhFKXuhBLlTKm5IT8+Kx7dppLoqMG07dWTM9mO+IxepLELZiDlww4CCbvHYOS+T9jSK77ZeL2WAqCSJV5TzQBoadlYeCQ1Nbo0NIZ+amsC+WtU9kAyajtXBcLNDDYskno4rL3QArqeq4ZkLrUzdxmI
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 23:29:35.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be16e3c5-b1a8-4bd8-7e0b-08d77911d2ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds xilinx specific sysfs interface for below
purposes:
- Register access
- Set shutdown scope
- Set boot health status bit

Rajan Vaja (5):
  firmware: xilinx: Adds new eemi call for reg access
  firmware: xilinx: Add sysfs interface
  firmware: xilinx: Add system shutdown API interface
  firmware: xilinx: Add sysfs to set shutdown scope
  firmware: xilinx: Add sysfs and IOCTL to set boot health status

 Documentation/ABI/stable/sysfs-firmware-zynqmp | 103 +++++++
 drivers/firmware/xilinx/Makefile               |   2 +-
 drivers/firmware/xilinx/zynqmp-ggs.c           | 289 ++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c               | 392 +++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h           |  37 ++-
 5 files changed, 821 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-firmware-zynqmp
 create mode 100644 drivers/firmware/xilinx/zynqmp-ggs.c

-- 
2.7.4

