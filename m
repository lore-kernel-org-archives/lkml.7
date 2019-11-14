Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4334C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA815206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNMXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:23:37 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:28211 "EHLO
        SHSQR01.unisoc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbfKNMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:23:36 -0500
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id xAEBnlXD019566;
        Thu, 14 Nov 2019 19:49:47 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAEBmChD018090
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 14 Nov 2019 19:48:12 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from localhost (10.0.74.112) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 14 Nov 2019 19:48:15
 +0800
From:   Orson Zhai <orson.zhai@unisoc.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <steven.tang@unisoc.com>, Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 2/2] mfd: syscon: Add syscon-names and phandle args support
Date:   Thu, 14 Nov 2019 19:45:25 +0800
Message-ID: <20191114114525.12675-3-orson.zhai@unisoc.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191114114525.12675-1-orson.zhai@unisoc.com>
References: <20191114114525.12675-1-orson.zhai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAEBmChD018090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There are a lot of global registers used across multiple similar SoCs
from Unisoc. It is not easy to manage all of them very well by current
syscon device tree interfaces.

Add helper functions to get regmap and syscon args by syscon-names all
together.

This patch does not affect original syscon code and usage. It may help
other SoC vendors if they have the same trouble as well.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/mfd/syscon.c       | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h | 22 +++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 660723276481..7ed1b2e4dba4 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -225,6 +225,71 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
 
+struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
+					const char *name)
+{
+	struct device_node *syscon_np;
+	struct of_phandle_args args;
+	struct regmap *regmap;
+	int index = 0;
+	int rc;
+
+	if (name)
+		index = of_property_match_string(np, "syscon-names", name);
+
+	if (index < 0)
+		return ERR_PTR(-EINVAL);
+
+	rc = of_parse_phandle_with_args(np, "syscons", "#syscon-cells", index,
+			&args);
+	if (rc)
+		return ERR_PTR(rc);
+
+	syscon_np = args.np;
+
+	if (!syscon_np)
+		return ERR_PTR(-ENODEV);
+
+	regmap = syscon_node_to_regmap(syscon_np);
+
+	of_node_put(syscon_np);
+
+	return regmap;
+}
+EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_name);
+
+int syscon_get_args_by_name(struct device_node *np,
+			const char *name,
+			int arg_count,
+			unsigned int *out_args)
+{
+	struct of_phandle_args args;
+	int index = 0;
+	int rc;
+
+	if (name)
+		index = of_property_match_string(np, "syscon-names", name);
+
+	if (index < 0)
+		return -EINVAL;
+
+	rc = of_parse_phandle_with_args(np, "syscons", "#syscon-cells", index,
+					&args);
+	if (rc)
+		return rc;
+
+	if (arg_count > args.args_count)
+		arg_count = args.args_count;
+
+	for (index = 0; index < arg_count; index++)
+		out_args[index] = args.args[index];
+
+	of_node_put(args.np);
+
+	return arg_count;
+}
+EXPORT_SYMBOL_GPL(syscon_get_args_by_name);
+
 static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 112dc66262cc..5584173cd5d4 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -23,6 +23,13 @@ extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
+extern struct regmap *syscon_regmap_lookup_by_name(
+					struct device_node *np,
+					const char *name);
+extern int syscon_get_args_by_name(struct device_node *np,
+				const char *name,
+				int arg_count,
+				unsigned int *out_args);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -45,6 +52,21 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+
+static inline struct regmap *syscon_regmap_lookup_by_name(
+					struct device_node *np,
+					const char *name)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static int syscon_get_args_by_name(struct device_node *np,
+				const char *name,
+				int arg_count,
+				unsigned int *out_args)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.18.0


