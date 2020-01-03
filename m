Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36265C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B221D56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="FsdfYR4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgACEOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:14:02 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:6243
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgACEOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:14:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIhLCk/r9h3KrF+4yLXhDnPwY7pFEoPwfBSXiUPHceta582u2VKljg6M1u4t4bmacQXjnfc+8lep4avuNFHV4Ex76iWkdu6RsplcFNBhvslk6mOOxRrPFhb/r7D1bmWul1Y6KYGErOjmY4X/pO487OETicj15FuBaOrHrGbVWWBc4ej2HmynsRaTiEqlvSn0P6Wirh/6FUl0mAkZqfVSjWg8W5YQczWPBSQYORPM0KYD+7kQyksW781knKUXDiHLw2f4iINbMmc3dgXwSfGCB7JH4wTb0BzDR2uMtLFIoShxW9pjZxz4K3iViNK7za/NbCnVeCK7gKKq53QhGH+78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZnzEye4mDUndjZtkD5HwLujVqlcczl4F5lMO8haL74=;
 b=QRZknZv5Q0kyfOKRdOJHjdl+vlP3otDZ5U2BjVHX35V1Wetf+Su+BYPWp4FRKu9thaUmfxDk2oVZOqokzy+8v2h6PfXAiE1LyCfHzuAOKWQkbk7bK5EvuoYm7ClK8OzmCay1TyGz/2U23tETiGH5BZ0WXPiHSazvLgmJXSQ1Sa1aN5wOi5RMUCIcK2O+ZMkOd0ruK9gOYLDeQba/gg4KpVolofaKugtIrtMCeBN38en5m4Cpe329B11o5Senl5iIqtzfagNvVT6Z5PS7B3pMTsoV16hJQgO7bhcNEZEWi6M6xd/4lYM4GFIm7Hjtoz71tTpB9lhnwpSDQ9kZJISSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZnzEye4mDUndjZtkD5HwLujVqlcczl4F5lMO8haL74=;
 b=FsdfYR4Co+hyTCYfie8YMp4jfDkt2PLKi+B/eDb1VVruEy2NOumOqvVpUZ19UBbM62oawVidUyf5TjEFDJgXiYi48+br0ZaZuK53f7C/x9VAgSz4QQ8GUNqLz51k6JkZ+SRW0t5NjFh7/nduzx/age9avCwdyzLU2lCg1CvUtY4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3799.namprd13.prod.outlook.com (20.180.12.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Fri, 3 Jan 2020 04:13:58 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 04:13:58 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, bmeng.cn@gmail.com, green.wan@sifive.com,
        allison@lohutok.net, alexios.zavras@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, bp@suse.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 2/2] riscv: cacheinfo: Add support to determine no. of L2 cache way enabled
Date:   Fri,  3 Jan 2020 09:43:21 +0530
Message-Id: <1578024801-39039-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578024801-39039-1-git-send-email-yash.shah@sifive.com>
References: <1578024801-39039-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BM1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::29) To CH2PR13MB3368.namprd13.prod.outlook.com
 (2603:10b6:610:2c::26)
MIME-Version: 1.0
Received: from dhananjayk-PowerEdge-R620.open-silicon.com (114.143.65.226) by BM1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 04:13:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [114.143.65.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f3fe2c-9d14-4168-6fc7-08d790035b4b
X-MS-TrafficTypeDiagnostic: CH2PR13MB3799:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR13MB379937E117ED4C2B320ADF2C8C230@CH2PR13MB3799.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(346002)(396003)(366004)(376002)(136003)(189003)(199004)(6666004)(36756003)(1006002)(66946007)(66476007)(66556008)(107886003)(44832011)(52116002)(7416002)(4326008)(2906002)(6506007)(86362001)(81156014)(81166006)(8936002)(6486002)(2616005)(26005)(8676002)(16526019)(186003)(478600001)(316002)(6512007)(956004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3799;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b88KAMvOpL755393EADJczhZy8TAJpSv4vUrKsJa/9HoVe1A7VvA9D+192gwY3tBK69KyE9j8rT6T/l9xFL2UDPncKrdXgnWgWqsJFuIc2EnfyZYQ4Lj1/xqV9IhBCfD8Vno69Hg/YHXATr2K/3f/aYBtpDr29P+LOlfFUUsfye5wTz+6BYkRHyPrhyN37ZZd4252L9fo1n+cc9e0u9wdu3cWUG1Hy4ijFQuDaZL7Z2N9zUIvDAXQGbOzCXs+C/5S5P+b7tD9BmB583u0FhGqaWLBMxAml8Tz97KJ7D1nbJDFQ4aKVoTUYMHbWSZb5DlHsv+l9xhvDlPnY6OzTlGxN6MMh+rzUvGRyl/fXxvQM3rI7G7lDDUSKFDA1VXjyyol2VXOuJRCxBv4q0n7KvqGbT4xgd9UN2KARabyFWG7CfAn3/qmN80TXnFlrGBEiKM
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f3fe2c-9d14-4168-6fc7-08d790035b4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 04:13:58.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtecBjbv1HI++3ZHvdV98HS6ZxvFBMhgis+OP4x2XeE79T+Ww6n8AeuK+b5I/p4ZDGrWhRKWys2/mjmcqPqr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3799
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

