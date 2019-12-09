Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E4C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED166214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="L/h6M840"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLIL0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:26:30 -0500
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:36064
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726297AbfLIL03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:26:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KylRiIV7tE5JBKbkxk7tgGbB327tpEQOIj8bSDwgeVBbC0SmVldk5pXmuM4VpDfn+bD5gMMCNNPqQMij7fGaDIB8VXa7I8h7pBfWY7NkinJ1dR3jaKM/3bbkxE/Il6kdLGpSml2VSwuf38+juB4kwEbfBn5VYKbp+gUGkBdXFPag26Aqxvm9F1MN5M8tWyPu+0RQadfqTOwmy0WQYRc0b5a4Vl8dxFSiklhiMpfvWHsDEJT+7CKrS7E59OYTLd1dZdic6THzsKKulaaZ4T3N7cuwRoRkAyY7xRmyCBrrYBRP64HBt81BvujRZ6A5RIG1OK2ruLIcBr29rF5mcCq76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZnzEye4mDUndjZtkD5HwLujVqlcczl4F5lMO8haL74=;
 b=TCporg3uK9f+o7UQY7EeqKRazEOrgynbdzwBIB5QiL5RxWoUGG4u95iU8Bs0xQ+j8s8KDUs5DAAfc6yl7SDHN5gegX2Sxn3pyKvjCvIXT01uWmPvW1Y0sYv2hwjSjPrv5uujU4T6FlivmpBDKbVnpNiCEx8a8/q3VhZsTtYN1CuLVlbZGIFtKi0MlKoa7a3o5XxEG4W9UXxCq/sfgOAochnsidvtEPpiUhg+22yg/roYdzdzXC4s4MfeNAU5XCnGKbpa57r1gddOdV2yg7Z/QVay5CfJvRIvqQTfGpxJlASxBJfMAx7pozJHlYuSJOm44siLfC302be1oJOYWB2Mbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZnzEye4mDUndjZtkD5HwLujVqlcczl4F5lMO8haL74=;
 b=L/h6M840lM2Vo4X1J2P1tHyd6Ui4BE991y2h7joXbUtfVklOvmrAVUO/BP0Sk2IOvKZrbZCA/Sz6B56McU2WxQqYt/E82Z4VypTEH+5O9ErTKuoKoY4Wxkk1rYWsI0VlObjyIqPXhaKtq+JETkyW8SO7UtHWglRBxsDVGmRilJQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3894.namprd13.prod.outlook.com (20.180.12.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.4; Mon, 9 Dec 2019 11:25:47 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2538.012; Mon, 9 Dec 2019
 11:25:47 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, bmeng.cn@gmail.com,
        allison@lohutok.net, alexios.zavras@intel.com, atish.patra@wdc.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 2/2] riscv: cacheinfo: Add support to determine no. of L2 cache way enabled
Date:   Mon,  9 Dec 2019 16:55:06 +0530
Message-Id: <1575890706-36162-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575890706-36162-1-git-send-email-yash.shah@sifive.com>
References: <1575890706-36162-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::16)
 To CH2PR13MB3368.namprd13.prod.outlook.com (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 9 Dec 2019 11:25:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af14bfad-b06f-4412-fc9a-08d77c9a89cd
X-MS-TrafficTypeDiagnostic: CH2PR13MB3894:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB389476550D77DA3C015758758C580@CH2PR13MB3894.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39850400004)(136003)(189003)(199004)(6636002)(81166006)(6506007)(81156014)(6666004)(1006002)(6486002)(7416002)(44832011)(305945005)(316002)(478600001)(2906002)(26005)(2616005)(956004)(16526019)(186003)(52116002)(8676002)(4326008)(8936002)(86362001)(66946007)(107886003)(6512007)(5660300002)(36756003)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3894;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXZxdTve3fcLLFVlt4G6qqAapD9CzZclPwfYaSCVMA6Gfer4jgpxgcyuBjS645EcG2AkMeXBRwajBXceqWBVbl8Jge+1b0Sm8R/E07Mbcc3GCPlHk194X2qFBh8rssDyWgJJzLVjwUPNPngi6DrMNJxateGWsEvS1ejpT5969UvdASPfk3dyYlEH1OiRXl0z4X4t4CpFg1bku4TMM1Is3tkUl64/oJIHWfTTuu9TkM86OYHsCTw6CX75cGRJh2o3ijWUMDEq9RbGh0siRISgXuNYi7cMqvaXjhDuSgkM/HjFdK1TKgI+DYBYBQSWEHFDI+B5K6h8KesdDmMJR2cygzrh7OiEwbHx8rgfiymzHqYrTvNiD4RLdv9zx/P8UrnplexJt5tRhzS57mRRNL9ULEvholQa4v/0OXOky3v6gM+lW1x3+e8n55ZBzg62wMqF
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af14bfad-b06f-4412-fc9a-08d77c9a89cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 11:25:47.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDpdVQEJBs0L3iN6sADQRrCKkV7ztpdb/rEA0pChLybypMU3+WOo3CDSTSZwGJqj7OliWfdZRwwrtsBpIX26PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to determine the number of L2 cache ways enabled at runtime,
implement a private attribute using cache_get_priv_group() in cacheinfo
framework. Reading this attribute ("number_of_ways_enabled") will return
the number of enabled L2 cache ways at runtime.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 arch/riscv/include/asm/sifive_l2_cache.h |  2 ++
 arch/riscv/kernel/cacheinfo.c            | 31 +++++++++++++++++++++++++++++++
 drivers/soc/sifive/sifive_l2_cache.c     |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/arch/riscv/include/asm/sifive_l2_cache.h b/arch/riscv/include/asm/sifive_l2_cache.h
index 04f6748..217a42f 100644
--- a/arch/riscv/include/asm/sifive_l2_cache.h
+++ b/arch/riscv/include/asm/sifive_l2_cache.h
@@ -10,6 +10,8 @@
 extern int register_sifive_l2_error_notifier(struct notifier_block *nb);
 extern int unregister_sifive_l2_error_notifier(struct notifier_block *nb);
 
+int sifive_l2_largest_wayenabled(void);
+
 #define SIFIVE_L2_ERR_TYPE_CE 0
 #define SIFIVE_L2_ERR_TYPE_UE 1
 
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 4c90c07..29bdb21 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <asm/sifive_l2_cache.h>
 
 static void ci_leaf_init(struct cacheinfo *this_leaf,
 			 struct device_node *node,
@@ -16,6 +17,36 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+#ifdef CONFIG_SIFIVE_L2
+static ssize_t number_of_ways_enabled_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sprintf(buf, "%u\n", sifive_l2_largest_wayenabled());
+}
+
+static DEVICE_ATTR_RO(number_of_ways_enabled);
+
+static struct attribute *priv_attrs[] = {
+	&dev_attr_number_of_ways_enabled.attr,
+	NULL,
+};
+
+static const struct attribute_group priv_attr_group = {
+	.attrs = priv_attrs,
+};
+
+const struct attribute_group *
+cache_get_priv_group(struct cacheinfo *this_leaf)
+{
+	/* We want to use private group for L2 cache only */
+	if (this_leaf->level == 2)
+		return &priv_attr_group;
+	else
+		return NULL;
+}
+#endif /* CONFIG_SIFIVE_L2 */
+
 static int __init_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index a9ffff3..f1a5f2c 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -107,6 +107,11 @@ int unregister_sifive_l2_error_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_sifive_l2_error_notifier);
 
+int sifive_l2_largest_wayenabled(void)
+{
+	return readl(l2_base + SIFIVE_L2_WAYENABLE);
+}
+
 static irqreturn_t l2_int_handler(int irq, void *device)
 {
 	unsigned int add_h, add_l;
-- 
2.7.4

