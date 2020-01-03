Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B06C32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6704B22314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="HyvnAvTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgACENq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:13:46 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:6080
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgACENq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:13:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/7o3GRkxdrPoYCV/lTOXzNXhPFpxr6FdTcJRydNv2fXBCduCzCnPxMcC+IGokARN/mz2FgQiFH/vJwuOQuAo4/DZvL9mEy5YBDjvdxo+mcTiQwZx5ga5bq5a9fY+Mzu+fjsiHsUOax3bDXydIwRvf9e+Biyxifjn/RwVLu3ayprgu/cMIYgawEFK01YwD0WviwuBcFvOYpGJkRJdJ9xnvvB1SrGSrxSKF5jsgM+Xmr3+RL8gyMrCh9REHvuoUGpaIaFEvw4kDOPa4d4Cwvk7q+UvukNdMGE5ysRI6YNdK5V/pSJuW898Q43J5sAq+owz5dg0QtkdEjIa4p/JGpQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnUyZxf21pTXDbhbFq6hPBwVzqAmqnWJkAmySXJP/yA=;
 b=j/0Lif8k55CRMGKaoCfeBwW1hmpsTJwgln36Uq4j7bDq769XSfNtbTWk4nCfIzfwbsKT3A+/KqxaSZ/5jdzHWV7zLzdpB5zaICZb6QyNFahCNm0MCkH33orK75GfpXMueKJLEd5j6R6IkACYhG4Fao2yDupJDwSN1uN9/Gt2OQGpnCn9trvYzoDbGlgZlquG2leuTrnoCXAtOMyfArQ6oF/yjD25C4yGtr/U50XyarOv9OB/F4MDnWY5gpu+cGSTTd/zuYdyB4AAvmy8kCHVuoGmukFB0ZbkgbDlPhDT/asQf295HO/1wEOD8uO7Y5WhucL1ukc8rUKDYGMVsuxYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnUyZxf21pTXDbhbFq6hPBwVzqAmqnWJkAmySXJP/yA=;
 b=HyvnAvTyKTnRAxYq5xUDc1eti5XAuXzJ4uywMTvapjp44jMIwthUgO5pgG0dgXRWIgVWBpP+SuiFUFtCBqAs+ngy17IbEAhRHqyL35tgXiLHbDMW5fTozI63hOH5R1OL5B8RNMbV9W/wl+znyGPJYPrz0+pGuK8sJE3LUz2qTHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3799.namprd13.prod.outlook.com (20.180.12.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Fri, 3 Jan 2020 04:13:43 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:13:42 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, bp@suse.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 0/2] L2 ccache DT and cacheinfo support to read no. of L2 cache ways enabled
Date:   Fri,  3 Jan 2020 09:43:19 +0530
Message-Id: <1578024801-39039-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::29) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 04:13:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74f147d-eb60-4aad-2f82-08d790035175
X-MS-TrafficTypeDiagnostic: CH2PR13MB3799:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB37992115458293098E2A5F578C230@CH2PR13MB3799.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(6666004)(36756003)(1006002)(66946007)(66476007)(66556008)(107886003)(44832011)(4744005)(52116002)(7416002)(4326008)(2906002)(6506007)(86362001)(81156014)(81166006)(8936002)(6486002)(2616005)(26005)(8676002)(16526019)(186003)(478600001)(316002)(6512007)(956004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3799;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x27SO/YN/D1Jys8B7AnTZ44KSVH1C+1Hhx6siSHkgWju+QJ9jWM6IcH+qL5FZLEdEycol1Sgg/7xxXYKAswaMWcHSTVz5xdAwx9bdTPR+EAR9frluU4mYzQCegE+/CRbY258rXoeTh2bSNwYypJtK+RFuZkjtL+KckYZjeM/sSsS3r8m4aPaP4sBYaI3jo3vikZ8hex7cqSRZ/jjKHjWP2R4ISvrtt3wu26idOtCQNpAmX5FYxdLsW5p3T1wEQj49davMCsYJOqWiDWOXyuQHPQoTdYILlKBq3Ra2mws+NgqdKOO3IRdNLnl97U8MVz78mflKK6bLWHb1IkQ6yKY/8ttSCBStnerJHTW77JWkyTIT1jPnViFuq4ChQ4QYN5v/Z+CGWPl1fpZZWkkbQqseuwWN4hLlJAoLlaM4GfQRQVkZmorggxjCXDq8n7fPI6l
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74f147d-eb60-4aad-2f82-08d790035175
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 04:13:42.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BOsII4CpAy71CVXIXhoe76S7ngdxw/SUSC9naQBkU/iQnNTmE4gAQLyvcs3jzbijwiihqw3pwIupyA35CM5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset includes the patch to implement a private attribute named
"number_of_ways_enabled" in the cacheinfo framework. Reading this
attribute returns the number of L2 cache ways enabled at runtime,
The patchset also include the patch to add DT node for SiFive L2 cache
controller.

This patchset is based on Linux v5.5-rc3 and tested on HiFive Unleashed
board.

Changes in v2:
- Rebase the series on v5.5-rc3
- Remove the reserved-memory node from DT

Yash Shah (2):
  riscv: dts: Add DT support for SiFive L2 cache controller
  riscv: cacheinfo: Add support to determine no. of L2 cache way enabled

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 15 +++++++++++++++
 arch/riscv/include/asm/sifive_l2_cache.h   |  2 ++
 arch/riscv/kernel/cacheinfo.c              | 31 ++++++++++++++++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c       |  5 +++++
 4 files changed, 53 insertions(+)

-- 
2.7.4

