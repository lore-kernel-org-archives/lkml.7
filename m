Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85824C32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C992222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="mVkfwB1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgACENy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:13:54 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:6182
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgACENy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:13:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4rM0UJe0zWVD6D8rSkT0+ll1ntsz/aB8ArH6UELIADBMCqjzk8r/ssdcxvipWQtD8oxm3dp8cUfk0S47ZSM5EcWQlCZjLAFZ2U9/yp+IIUoops7jOguIcIeDmXj1S85GCSU4SUjuywanvP/LTzh334O/5/saLDwdW8xxTVrf5UsWClGlkNMEEH+R4ZA4DHhmB3Tf/hdID/IlJN5vKqJY9kgjOB+1BUafMVdqczbeGQ6DQPr/5xXMPs6HL88jVCZmzjq4/tzPzhblGbLT0DKyGfI2i6328ezuJUJQLlafXXdyptTJWfvqchRpWSay5y6JeVL8SnG6dgwTBy7ls4lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F/IYpY+jLyN9kGF82dJe15nO7Oczq1HkQhuLSHrgPE=;
 b=TDcG1bEqBWyX1NVRAFTnZfUkRKygDsMmCgBwkPrb2hioHAIFfHVhUfPbNV+cQnqKYloP0BbXpLl1MiicmfQr0yx/WE4cgGjReAQ9Jqo1WOCAZsCncLkazoA6Fxn3SFfKItJA/xwl0Spq7cMZ7WDShLB1Uducpmvaa4EWk+JKS+MagMjoEhtXRKMfMrgULIFq0DsrSNiFVZm+ALnBweUWJWgn+uEQ209pg0YRqT7JQqfz2p9o4YMiOGhEMZSGBqrsmUwXl57JbkgKb8Okb93jrHMWxI8wMxq5aL9GjLYABzuT5lCt/zAoCEe6alJNYZ/oS/vgMFxSodUdn0MPU+KkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F/IYpY+jLyN9kGF82dJe15nO7Oczq1HkQhuLSHrgPE=;
 b=mVkfwB1N8xTf8GZfXTvD0spTWM4L6Glqhl3rZvLjej22ROD9ij7sLgkUGNwW7nY6np42JfzBXsXJh5cbPAeLOZOMjoQ/ErKbD8NJ1XEMNxq0eBnGpeWkoHpzQl/qb6oYi5+5TNKcGzdo6PlORqVmUKjV0QJa8F8RiLpjU6H003Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3799.namprd13.prod.outlook.com (20.180.12.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Fri, 3 Jan 2020 04:13:52 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:13:52 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, bp@suse.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 1/2] riscv: dts: Add DT support for SiFive L2 cache controller
Date:   Fri,  3 Jan 2020 09:43:20 +0530
Message-Id: <1578024801-39039-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578024801-39039-1-git-send-email-yash.shah@sifive.com>
References: <1578024801-39039-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::29) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 04:13:47 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46775e9b-0b32-487c-e770-08d79003573c
X-MS-TrafficTypeDiagnostic: CH2PR13MB3799:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB3799BC4DBD5BE935FD6FFB708C230@CH2PR13MB3799.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(39840400004)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(6666004)(36756003)(1006002)(66946007)(66476007)(66556008)(107886003)(44832011)(52116002)(7416002)(4326008)(2906002)(6506007)(86362001)(81156014)(81166006)(8936002)(6486002)(2616005)(26005)(8676002)(16526019)(186003)(478600001)(316002)(6512007)(956004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3799;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V06ox30sMVxj+gDYVnYMMb2nXARttKAbiPn+VMUef0zr9dpWr9l4xOmWhSzkBN8qHnKb+CKGLgeZt7X3QLOAYAJ11lwmkxnp78YaKZ+2S+7yU3siMA7hLsHyudt6TPNIguyvsuItosJysbprM0emRQtyDG5E0E2mIU01OXtYOkL+Ho6GicAnRYnBSja2MGBb9HNNieazU2Kmsr6eepHRFI+kbIS29xiOC7RdmtlzMR+XcAMK53jMyM2RADaK0a6DFiM6WSJ4EVDieV2kLdgTYb1TfqdbWX3cP/5PAsbU63vMY51CT8ocwxkL6E99JKwYgRfMOaUtm28uOJxFMcUYTFnov3p7RRBIPE+BKjo0Hu0rTRkFWTKYeEA0VlliHZR/uXnsHlu2xnf1M6/o9BGIxLKOvzMg8nN7LVe2tj0SE5ZtJlcfTEnJXgqSczF1/w17
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46775e9b-0b32-487c-e770-08d79003573c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 04:13:52.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEuhzK12eCBm79D/2FOtbGxCdqoXgiPjCrQP+Dyo7McVBmaO+YAHBLb3rkTLzXf315ZPuUoFMH7VjqCjVPUbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the L2 cache controller DT node in SiFive FU540 soc-specific DT file

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 70a1891..a2e3d54 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -54,6 +54,7 @@
 			reg = <1>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			next-level-cache = <&l2cache>;
 			cpu1_intc: interrupt-controller {
 				#interrupt-cells = <1>;
 				compatible = "riscv,cpu-intc";
@@ -77,6 +78,7 @@
 			reg = <2>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			next-level-cache = <&l2cache>;
 			cpu2_intc: interrupt-controller {
 				#interrupt-cells = <1>;
 				compatible = "riscv,cpu-intc";
@@ -100,6 +102,7 @@
 			reg = <3>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			next-level-cache = <&l2cache>;
 			cpu3_intc: interrupt-controller {
 				#interrupt-cells = <1>;
 				compatible = "riscv,cpu-intc";
@@ -123,6 +126,7 @@
 			reg = <4>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			next-level-cache = <&l2cache>;
 			cpu4_intc: interrupt-controller {
 				#interrupt-cells = <1>;
 				compatible = "riscv,cpu-intc";
@@ -253,6 +257,17 @@
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
+		l2cache: cache-controller@2010000 {
+			compatible = "sifive,fu540-c000-ccache", "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1024>;
+			cache-size = <2097152>;
+			cache-unified;
+			interrupt-parent = <&plic0>;
+			interrupts = <1 2 3>;
+			reg = <0x0 0x2010000 0x0 0x1000>;
+		};
 
 	};
 };
-- 
2.7.4

