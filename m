Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F9C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C8F2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="BS2aYFcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfLILZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:25:38 -0500
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:9184
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfLILZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:25:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eviTiRoRzmCBFVHqYKMtQJMsu7Kiz6pbV1i0QSM3cnNCZ2lmyl1czSoa52f3n3U8OZJTBy+ehDdTJofmnFK3NHq63wsUxEmgoIMMUYJ1ruV9KQvIN5oPimiP65dTgiSVAAPUK/7V3fscq9XE8sI86Bla+McGQKDqL6ZbJ+slot1rq8lkJOMh1YanwtCnUPTaMVbV8TfclUP9a/joXAw9SuMUD77YgV8VhUgC0gzXWbDm0VML3VvKFfV8tZjg4X489vSRc045rHttLUPdWQ3re8Fsm0v45dWQetKGCrqPqr2riTMzTds7tNWvj+gffUL+NG8mw2MxZjgm98ppMztnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSLeYpcm3zb/bI0q7qENHRdu6QFbYDztrn2uPDBXkCo=;
 b=ejVYTK3p82HhQynxazbT9X/8yR6jrLxG0uJI5+LBEheyms7zb5gPrF3VnBPpQ0gBuTlCA7I/ddjwIQffytaoBpUQE6FcQMLbhqgjbPhRFEJa3D7Hu/LD0k1e2dzP6+ZR5qK31NXWj1MC/0INlZFY9l2uODVoPJOo8cCLiGFZW4NtGpaDc2Fi5NYfjZjV6lBCHzKtHBz11PHrNh/3iLijmx6dOyFWMeooxWCe7Bg0lR28EPXrHD0r0YhmcdS2J+RgM79DvOpV/unUCt5ct4TcVY4d0s2BIXj1NI30ESOR9PtRcwDWz6kDWNxL45w+ioWfdoj4S7HQv9xxXAz/3ju0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSLeYpcm3zb/bI0q7qENHRdu6QFbYDztrn2uPDBXkCo=;
 b=BS2aYFcHw9YwA9TDV9YQbc/RJNbtLGDTktrVaatX/9v2fQGsKV6QE2D7U6W/OMeB/MAV+5aNhCwlL7Mwfew4KmepBbDrrvgco1FsJux29ppAocA1YUEiMjT54xa+nsxVWH4Nh7p0f6P/WExEfVZrlzvsMN3q8txjfs07SEGUjYc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3894.namprd13.prod.outlook.com (20.180.12.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.4; Mon, 9 Dec 2019 11:25:34 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2538.012; Mon, 9 Dec 2019
 11:25:34 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, bmeng.cn@gmail.com,
        allison@lohutok.net, alexios.zavras@intel.com, atish.patra@wdc.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] L2 ccache DT and cacheinfo support to read no. of L2 cache ways enabled
Date:   Mon,  9 Dec 2019 16:55:04 +0530
Message-Id: <1575890706-36162-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::16)
 To CH2PR13MB3368.namprd13.prod.outlook.com (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 9 Dec 2019 11:25:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22561b52-52aa-4a99-ba30-08d77c9a81cf
X-MS-TrafficTypeDiagnostic: CH2PR13MB3894:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB38944DEC6C83058C0CBEE1758C580@CH2PR13MB3894.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(6636002)(81166006)(6506007)(81156014)(6666004)(1006002)(6486002)(7416002)(44832011)(305945005)(316002)(478600001)(2906002)(26005)(2616005)(956004)(16526019)(186003)(52116002)(8676002)(4326008)(8936002)(86362001)(66946007)(107886003)(6512007)(5660300002)(4744005)(36756003)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3894;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3S9P/D1Rz8CfwM91IaGcRNQRtq+5SbbbKRNGI1FRmIq9tezADJif3eGw/sKSntWQyn1paOcGjaNRRhy35BTzKGi9QBIYliiliBgLwyjx6ZLMnWBcRPipIEXMwKe3HueJHixYyuk5CT0a0cgAJ9yUsAM4a9uOsQz2y483yLjYXQhlVLGO+He7XKElfVU8L9i7wDyuYX6NKZWk2I3CHYNhg0x/hAMDdFS2s6u3kbyEIMRkNVwTzpoDsXI3anYzjJawouAyFOD/2LhFryE0FDrP2HdMfHlk1VQmwwtqWCEfMFpt8QYtKaa1oo9dxEp9ySgvTvn7bPvhfcPqbaoZay6zpFggDuyJWWy0+kusZymo5DPM99wBno9vB6zW5ybfT5DawgavRPZyyLYT2T2wcGf6VT10xF9bci9g6u/EX9dWFH5dnhodY3nxkqkfmkIS3kFx
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22561b52-52aa-4a99-ba30-08d77c9a81cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 11:25:34.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 366v63BRIpKX5WT6Woa0CGZNSMs+nC7TzGHcueUMBYTsbz7dNXDO3xTSekIuSwhUM8y4IZGXYpMUWMXl7PovIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset includes the patch to implement a private attribute named
"number_of_ways_enabled" in the cacheinfo framework. Reading this
attribute returns the number of L2 cache ways enabled at runtime,
The patchset also include the patch to add DT node for SiFive L2 cache
controller.

This patchset is based on Linux v5.4 and tested on HiFive Unleashed
board. The cacheinfo patch depends on Christoph Hellwig's patch:
"riscv: move sifive_l2_cache.c to drivers/soc"

Yash Shah (2):
  riscv: dts: Add DT support for SiFive L2 cache controller
  riscv: cacheinfo: Add support to determine no. of L2 cache way enabled

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 26 +++++++++++++++++++++++++
 arch/riscv/include/asm/sifive_l2_cache.h   |  2 ++
 arch/riscv/kernel/cacheinfo.c              | 31 ++++++++++++++++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c       |  5 +++++
 4 files changed, 64 insertions(+)

-- 
2.7.4

