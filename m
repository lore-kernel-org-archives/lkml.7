Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7EC31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9BB217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfFOC42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:56:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfFOC42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:56:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2AFAFB300C5A02C151B8;
        Sat, 15 Jun 2019 10:56:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Jun 2019 10:56:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH next v2] of/fdt: Fix defined but not used compiler warning
Date:   Sat, 15 Jun 2019 11:03:43 +0800
Message-ID: <20190615030343.96524-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_EARLY_FLATTREE is disabled, there is a compiler
warning,

drivers/of/fdt.c:129:19: warning: ‘of_fdt_match’ defined but not used [-Wunused-function]
 static int __init of_fdt_match(const void *blob, unsigned long node,

Since the only caller of of_fdt_match() is of_flat_dt_match(),
let's move the body of of_fdt_match() into of_flat_dt_match()
and eliminate of_fdt_match().

Meanwhile, move of_fdt_is_compatible() under CONFIG_OF_EARLY_FLATTREE,
as all callers are over there.

Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2:
-Move the body of of_fdt_match() into of_flat_dt_match(), suggested by Frank.

 drivers/of/fdt.c | 99 ++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 54 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3d36b5afd9bd..cd17dc62a719 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -78,38 +78,6 @@ void __init of_fdt_limit_memory(int limit)
 	}
 }
 
-/**
- * of_fdt_is_compatible - Return true if given node from the given blob has
- * compat in its compatible list
- * @blob: A device tree blob
- * @node: node to test
- * @compat: compatible string to compare with compatible list.
- *
- * On match, returns a non-zero value with smaller values returned for more
- * specific compatible values.
- */
-static int of_fdt_is_compatible(const void *blob,
-		      unsigned long node, const char *compat)
-{
-	const char *cp;
-	int cplen;
-	unsigned long l, score = 0;
-
-	cp = fdt_getprop(blob, node, "compatible", &cplen);
-	if (cp == NULL)
-		return 0;
-	while (cplen > 0) {
-		score++;
-		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
-			return score;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-
 static bool of_fdt_device_is_available(const void *blob, unsigned long node)
 {
 	const char *status = fdt_getprop(blob, node, "status", NULL);
@@ -123,27 +91,6 @@ static bool of_fdt_device_is_available(const void *blob, unsigned long node)
 	return false;
 }
 
-/**
- * of_fdt_match - Return true if node matches a list of compatible values
- */
-static int __init of_fdt_match(const void *blob, unsigned long node,
-			       const char *const *compat)
-{
-	unsigned int tmp, score = 0;
-
-	if (!compat)
-		return 0;
-
-	while (*compat) {
-		tmp = of_fdt_is_compatible(blob, node, *compat);
-		if (tmp && (score == 0 || (tmp < score)))
-			score = tmp;
-		compat++;
-	}
-
-	return score;
-}
-
 static void *unflatten_dt_alloc(void **mem, unsigned long size,
 				       unsigned long align)
 {
@@ -764,6 +711,38 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
 	return fdt_getprop(initial_boot_params, node, name, size);
 }
 
+/**
+ * of_fdt_is_compatible - Return true if given node from the given blob has
+ * compat in its compatible list
+ * @blob: A device tree blob
+ * @node: node to test
+ * @compat: compatible string to compare with compatible list.
+ *
+ * On match, returns a non-zero value with smaller values returned for more
+ * specific compatible values.
+ */
+static int of_fdt_is_compatible(const void *blob,
+		      unsigned long node, const char *compat)
+{
+	const char *cp;
+	int cplen;
+	unsigned long l, score = 0;
+
+	cp = fdt_getprop(blob, node, "compatible", &cplen);
+	if (cp == NULL)
+		return 0;
+	while (cplen > 0) {
+		score++;
+		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
+			return score;
+		l = strlen(cp) + 1;
+		cp += l;
+		cplen -= l;
+	}
+
+	return 0;
+}
+
 /**
  * of_flat_dt_is_compatible - Return true if given node has compat in compatible list
  * @node: node to test
@@ -779,7 +758,19 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
  */
 static int __init of_flat_dt_match(unsigned long node, const char *const *compat)
 {
-	return of_fdt_match(initial_boot_params, node, compat);
+	unsigned int tmp, score = 0;
+
+	if (!compat)
+		return 0;
+
+	while (*compat) {
+		tmp = of_fdt_is_compatible(initial_boot_params, node, *compat);
+		if (tmp && (score == 0 || (tmp < score)))
+			score = tmp;
+		compat++;
+	}
+
+	return score;
 }
 
 /**
-- 
2.20.1

