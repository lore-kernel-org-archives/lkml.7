Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E5FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8552054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z+E+rMKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437754AbfJQGWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:22:12 -0400
Received: from mail-eopbgr820074.outbound.protection.outlook.com ([40.107.82.74]:16224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389411AbfJQGWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:22:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVbT4h/4TkVLlGBIDj/bhLgHm7FFDJ8avMyLtXIv28o6KEPnKPY0/FxCSn6kAa62FgpKK/gXDzjUSoXTF1grHHYLZUyRM0uOsV6KqXxDzk0QVbs661WA8SFhTbPQA9gLidY68UA3JRAaqGO0WdoWfFjejdOCjtSOtxDx4knCG6lAfgwT5Xll8+xACfeoI1DTQWs9siQlqMysykc7kWq/Ns5k8yrihEAEF/7wGzNyP3bBZO3fSMkA4Y4q7nT9V0MdBChrJb+Ll07NO1QRTFBSonKvILXuWx8K6WTCRwWR3Tbzsx2NcCQq+0jQ2zW1Lu3B+wcrfC3IDpVnVL1fJjolfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8ZAaEVeEpNU628p3tE43eG+T1WHOKMQZYjiHaLpqk0=;
 b=dgEOVJ+wnJ7Cb7c2XukoHk56eIDqG9ILzUH1hsprxkZ8pVt7fFOnficJol+gcVwV43v7Ymim1I9hm1wqxRuOnITvOvfEjaIr6QP83QGmH9if41Uqb8fDt8B+VfzWLs+L/jtcVY6IT6NalIHNsr1BhJbX0b0CLidUGZqeKrQCRr39zU+PuFsUzD+rwZlTVlfxb8t7lVmfMspAhJxxXpFNvgnEDvv7WxkmiX7HvuPK7hGXbbEJjJwmNQiGUU2jGsj7/M4E3L5ESJE2Ggct/W7RizyNZv8rqCEt+oN9pZzkZuT75MK3Wr/IAxmKrOJvboaCsfVgG2gTS/2v+oaPEHKRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8ZAaEVeEpNU628p3tE43eG+T1WHOKMQZYjiHaLpqk0=;
 b=Z+E+rMKgSbC+XY7wC2OZSXbKlK1l/QVaH9rk2Gim/ONoqfXUnXxz0sABgHuBdjqWI6VA5nn0142Yt12jqnEvYgQx+nx9Qm8vcGX6m1XyA+l3mQpNbpFzGXNWy/i35lNeBTEvpgxtJwdagDfmDsLVm3cCSBqP52WdtoVqsYmOai4=
Received: from CY4PR02CA0034.namprd02.prod.outlook.com (2603:10b6:903:117::20)
 by DM6PR02MB6684.namprd02.prod.outlook.com (2603:10b6:5:21b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Thu, 17 Oct
 2019 06:22:05 +0000
Received: from SN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR02CA0034.outlook.office365.com
 (2603:10b6:903:117::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Thu, 17 Oct 2019 06:22:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT059.mail.protection.outlook.com (10.152.72.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Thu, 17 Oct 2019 06:22:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAh-0004ag-MK; Wed, 16 Oct 2019 23:22:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iKzAc-0003f6-JB; Wed, 16 Oct 2019 23:21:58 -0700
Received: from [172.23.64.104] (helo=xhdvnc123.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iKzAZ-0003dc-BM; Wed, 16 Oct 2019 23:21:55 -0700
Received: by xhdvnc123.xilinx.com (Postfix, from userid 16987)
        id 8C3B343A9A; Thu, 17 Oct 2019 11:51:54 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v3 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date:   Thu, 17 Oct 2019 11:51:42 +0530
Message-Id: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(199004)(189003)(42186006)(16586007)(2906002)(48376002)(316002)(44832011)(6666004)(14444005)(305945005)(103686004)(126002)(486006)(2616005)(356004)(478600001)(47776003)(336012)(426003)(476003)(6266002)(26005)(36386004)(4326008)(50466002)(186003)(5660300002)(36756003)(51416003)(50226002)(8936002)(107886003)(81166006)(8676002)(81156014)(70206006)(70586007)(106002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6684;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6394a872-59a9-4f6f-7fba-08d752ca5499
X-MS-TrafficTypeDiagnostic: DM6PR02MB6684:
X-Microsoft-Antispam-PRVS: <DM6PR02MB668457CD0883E18195E5A9DDC16D0@DM6PR02MB6684.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2idbgbNeFLfivoJW9hB5+BheDMq+YlTPh/6Rom8Yqqppbc1YuPRkwqmU+iWAAQFJw3qYX8d/hi+7YrVVpSMGU8sck813QujvKLqJ2KbEeZSxuwi+6CvL90VD5GjcfmKHOhy9yEoj/nw0vtzI7xHK83FIr5nSkzD7HJ98DVJcwSM1vTbyes1qZkDZ1lphklxQ2T0gb2Mwgpa54cbMxpiTIxtjmAcV/X4SwFtKiwG88G+ENQdsQzTTHHBNHs/cJmkcnbD4zqe13+SzufMpScNdkHToK/E27csxcWBzOIw3q8Lqksy0HFlP89FcpCq+7OCZwrB59/ijuJcX4E/ocMv32uvdi03fHTJzcf4cwXh9R2s0tspLQGZKNUVQQkpWOM9QbcafE5RbK0QVPhc3F5nyepKnlzheYx84dgHqOyXmqmw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 06:22:05.1310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6394a872-59a9-4f6f-7fba-08d752ca5499
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following:
 - Reorganize the Clock Handling in Arasan SD driver
 - Adds new sampling clock in Arasan SD driver
 - Adds support to set Clock Delays in SD Arasan Driver
 - Add SDIO Tap Delay handling in ZynqMP firmware driver
 - Add support for ZynqMP Tap Delays setting in Arasan SD driver

Changes in v2:
	- Replaced the deprecated calls to clock framework APIs
	- Added support for dev_clk_get() call to work for SD card clock
	- Separated the clock data struct
	- Fragmented the patch series in smaller patches to make it more
	  readable

Changes in v3:
	- Reverted "Replaced the deprecated calls to clock framework APIs"
	- Removed devm_clk_get() call which was added in v2

Manish Narani (8):
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay nodes
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  40 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 477 +++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h          |  13 +-
 3 files changed, 498 insertions(+), 32 deletions(-)

-- 
2.17.1

