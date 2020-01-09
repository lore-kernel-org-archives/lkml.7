Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E86C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C18D2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KjT35kgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbgAITGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:06:24 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:62816
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732189AbgAITGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:06:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdSuFbx5qONLLdvYDtMGme0+pvexXeF2VWgzii5n1QnwDpRhwiWjkZx9v5SW3pswM1/OfU0i3k0IesJQ+a6ccbmBRbC/PX9GAAC3ssaJPPcs957eMHgnZMqoTYAZgh7tFFMC2Unp60/7Fdc65nivcgtrFR4i17n3u4bFVBSG/ntNqLhzzABKfC2WGV+uPu9b6Wo8EeZF+UfcstdUjNUhCyBrSNqv9cTK2yYz9vq4Uo8ra27PTRoE3lihO+SjkS4LPs0g13/NmDz4lN5zDefseOt47LBM/tR7u0qF7iMxvG6nicNwfY/BgLP/7MCAHT3S9Sqn2HaL9/1ARBlxJPKuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq1/PJf+Q9W6nmUlSbouULjJQxl7pzGd26ujV7jjax8=;
 b=I0Mo42gPzPZgG2Jt+6pQDKcOjv/vUnF6Wnkl7mRZB1gcDJER0IO65Mbn9/0LT04P52EyrN40/qvD91HKL6L7Ppcna8cvyVyKslFrvekskdNoqZIPNTxjHnkIlySwQLlo1qRohpICx7bCBUuCSk0Z9EFP2oEiO0ZTLA97Y0j6xGY4WRGZtCQ8jAqnCKvTg/EQsVy6iuW5/I329ofit959G6hv0C/Gh/imCXBEOK6/ES0QCngBZPnWtbpwQQN2ERbEzv/Ofd3WaN5X3707OmiPRZE7HiyYWL0Pptps8hfMbHLjV4O6fpNELyi1JmAjoxmYX/2aWwHd2+FdFir9svor9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq1/PJf+Q9W6nmUlSbouULjJQxl7pzGd26ujV7jjax8=;
 b=KjT35kgm3uhclO/CrOr04Z1qZbK6z/puSOsC14mcB3g0CL2RBkJydMEpFwrDYxJ7XkWvv2Gpao3oMgadB3/qPC8PGLwbOZZ7Rm9wV3+6IG04FWmELZDqW2NABjo2cmjvJUsFvQgNsgSEfH2WcPzw7J3CE1QKcY8pNIdXDmqUpN8=
Received: from SN4PR0201CA0035.namprd02.prod.outlook.com
 (2603:10b6:803:2e::21) by DM6PR02MB5596.namprd02.prod.outlook.com
 (2603:10b6:5:7b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Thu, 9 Jan
 2020 19:06:20 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN4PR0201CA0035.outlook.office365.com
 (2603:10b6:803:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.13 via Frontend
 Transport; Thu, 9 Jan 2020 19:06:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Thu, 9 Jan 2020 19:06:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipd8O-0008O6-5F; Thu, 09 Jan 2020 11:06:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipd8J-00030t-24; Thu, 09 Jan 2020 11:06:15 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 009J66Xx021951;
        Thu, 9 Jan 2020 11:06:07 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipd8A-0002yD-Sz; Thu, 09 Jan 2020 11:06:06 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver optional
Date:   Thu,  9 Jan 2020 11:06:02 -0800
Message-Id: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(199004)(189003)(26005)(81156014)(70206006)(81166006)(8676002)(36756003)(7696005)(8936002)(336012)(478600001)(2616005)(70586007)(107886003)(426003)(9786002)(4326008)(7416002)(44832011)(6666004)(356004)(2906002)(6636002)(316002)(5660300002)(4744005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5596;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2648c970-fc68-40a3-8fe4-08d795370344
X-MS-TrafficTypeDiagnostic: DM6PR02MB5596:
X-Microsoft-Antispam-PRVS: <DM6PR02MB55967DC0416F24F30EA93A27B8390@DM6PR02MB5596.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oos2KgF7PGM6E0HM11eU+fcg/BHghGytpEEd+j2l4wOI8gwcUwpY0KfiB6nm9Mh4PNGCe8puNA1y/4Du9ya8sr4K74mOxWcsGCsO2hEeA3kzhxvfbP5I5BP6CyVsFeCP784FVIvMrUKezBOGE0jBSYfsiCIzpV+KWZCP5EJqhJLhkbN1EY0p4eMShM53tMrDg3KwPEqvTAXscsStrnd+GiGlPCEpKMeQRNIMp3lG5LaLXW16tB3peFqTMjID24mwDS4NEzLsi9WCxS6VzoKXh4xCtZC05kW7McJZHo0LdVzciIX/VdA2hKTr4dDCy14JEYSrMy6nMo8q0H0Tb6p/sW77AlooUa9ZizpPMtY/aZcWDDV9J2la2FVzParN1CGMoJa6NW8gGQyFaWAbgGDIHSnxMoiqhGNMbcx96Q9b0D2mu0TtnBQ+ktQ2NyUYNzrh
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 19:06:20.5658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2648c970-fc68-40a3-8fe4-08d795370344
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Zynqmp firmware driver requires firmware to be present in system.
Zynqmp firmware driver will crash if firmware is not present in system.
For example single arch QEMU, may not have firmware, with such setup
Linux booting fails.

So make zynqmp_firmware driver as optional to disable it if user don't
have firmware in system.

Tejas Patel (2):
  include: linux: firmware: Correct config dependency of zynqmp_eemi_ops
  arch: arm64: xilinx: Make zynqmp_firmware driver optional

 arch/arm64/Kconfig.platforms         | 1 -
 drivers/firmware/xilinx/Kconfig      | 2 ++
 include/linux/firmware/xlnx-zynqmp.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.4

