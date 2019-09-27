Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB4FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233222082F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rLeSDyCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfI0Tkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:40:33 -0400
Received: from mail-eopbgr810049.outbound.protection.outlook.com ([40.107.81.49]:11653
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfI0Tkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTG4+C0/qWYzFGHFTaFWCD+jI9KjSKneZ9r8zdNc+HYA8tFwH8pbTbAdRULwwTPIfF2MOlw2+SXpfISkqWjfgydDajvGSh0vEuRbau+kVZsb+IX7EmFCHx4Sqdz00HdSqa2zAyJw4ySt06PkDcxur/H9QP60uc9fa+VlQoNr1jfbzUp99DWgfQ5UyNoI86omjmuQadTFxmfRk5dCOqacFGJFgcmxDK7U11krmTBM8os4Q8dUhJzDtHZRoNlzQMNMT/QaC4M+7onfQZePXfdh+k7ZHPYbai3Mn99qfDNlt1gnh7c/fQUCVWir5cyFL2yASzPSBJmvGqvL4E/Gbo7k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/G6d8tMR0G+kP6p0I4FxtywYsCrR0mj8FWjo9dl3n8=;
 b=M82PWoGNftbN/J6rAaH/0NbCDXKP660Sh0GUrrFEMO/q8v/hNZLbhGKCYR79OuIPfVnhOsNKCkHM8wf2pEiPk7NXoiMgfSsyCP0FMI3fiDTnlE8HkVBJOqx8tJAnNrAbnpMZlItKWftQHJ2jXPiP02aieHj+b4D4HdTZT/ANqmUExPlPFWFSttMkgbpR8DHWKkW2996L4sZUIjZ7bcw5WH29gNbTPjY6c/ISqAIcB04EYnIPMoce2vWya+akX2U/5c+Bu44pvmP0xNCy7cGgzyAY4XrQ0poO5JCYVWybwrf09ukjlcG4b0WSRETCQ7qrR3wS0koyXfqo4ZwI2qcScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/G6d8tMR0G+kP6p0I4FxtywYsCrR0mj8FWjo9dl3n8=;
 b=rLeSDyCpHihyGJIe8JwPQJzI5oaOcJKnrK0WeTatFKGt14xlPprYgUq02iVW5iSOYY53EeDoWegB1ruhKIWAA9ND5tUEflHDD+MCaRByBOxiRzy5YWk0LjlQp0kIiuOBZ7UlTzoHtW33n2uJ59SrPrvi2TmdEv1WjQw1+KIiZAQ=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by BYAPR02MB6437.namprd02.prod.outlook.com (2603:10b6:a03:11d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19; Fri, 27 Sep
 2019 19:40:29 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Fri, 27 Sep 2019 19:40:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Fri, 27 Sep 2019 19:40:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1iDw6O-0000L8-Ki; Fri, 27 Sep 2019 12:40:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1iDw6J-0003aE-Fe; Fri, 27 Sep 2019 12:40:23 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1iDw6B-0003I3-Sw; Fri, 27 Sep 2019 12:40:15 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH 0/2] drivers: firmware: xilinx: Add support for versal soc
Date:   Fri, 27 Sep 2019 12:40:04 -0700
Message-Id: <1569613206-20189-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(47776003)(51416003)(7696005)(44832011)(36756003)(6666004)(107886003)(26005)(9786002)(305945005)(356004)(186003)(476003)(486006)(2906002)(106002)(2616005)(126002)(8936002)(336012)(7416002)(81156014)(81166006)(316002)(36386004)(4326008)(4744005)(70206006)(478600001)(70586007)(16586007)(5660300002)(426003)(48376002)(6636002)(50466002)(50226002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB6437;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3f5e17-2367-4e94-96a4-08d743828d74
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR02MB6437;
X-MS-TrafficTypeDiagnostic: BYAPR02MB6437:
X-Microsoft-Antispam-PRVS: <BYAPR02MB64379C3A41D42F9A88EF2872B8810@BYAPR02MB6437.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0173C6D4D5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: gKjXEYTOGVhJ3EcvBlrY08CjPSB399AJt7GqOAgl8PlU7vRh+DmHBaU5EyFnImprIhclnjP/cSqY/vavAsnQpgJi9ER5zmfxIVh8Ht/Jc7dRQnUmFPF+PEYRp2+Lbq7JYh6OEQyqixyO/a4UcUPf2MDYUZ3T+NXlJQGj+uHHsxq35uIDu1jVLd/TD2xAd2v1b6ouAWMacXJlY8NtHw5a4GGDEqzHWnSc2ba91C68DP//ZlXSWQwdObh5MrcjYksjSGkX7o1jDouJCnqbnCx5Y2DYlOnd3oxz/hxokFD38flrgvt5UFAxA0ypjBk3uhKZCpSU+USRuOdZnM6Sx0crOC7l+hXLwwl7ZYqRetpQnNqggNZmCZP2R2D7HmJZACw5+rMt9sI/Fj9zk01NNM0Iz8bb59kvB/62+ezB3n1UwGc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2019 19:40:29.2510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3f5e17-2367-4e94-96a4-08d743828d74
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Versal is xilinx's next generation soc. This patch adds
driver support required to be compatible with versal device.

Jolly Shah (2):
  dt-bindings: firmware: Add bindings for Versal firmware
  drivers: firmware: xilinx: Add support for versal soc

 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 +++++++++++++++-
 drivers/firmware/xilinx/zynqmp.c                         |  8 ++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.7.4

