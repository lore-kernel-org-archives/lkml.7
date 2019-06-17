Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98DBC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C964A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfFQMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:38:50 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:38:50 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2fDl-1hd7l83wTv-004C56; Mon, 17 Jun 2019 14:38:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of/fdt: hide of_ftd_match() if unused
Date:   Mon, 17 Jun 2019 14:38:19 +0200
Message-Id: <20190617123840.911593-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C9EgkRJlRV+uUkgeQXJ+viZ12Os+ic8aUZ0U22arhnLAFNw45Wn
 CoIq1FnerQpG/ubXsFQvljsdA4vy1ibxvexiKshRTvr/so8dEoz3+aGQiS84J9nuJPFCYFZ
 KHf7hTZ3LspgE9JcBWCwJSr90DsFbVLeorbN9nkL1+ofBOc8m0HRUEGGXOM8+UwQRDMyDtl
 +oqEqUemR5J8ePqsUgrrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/do7VlCqaQ=:DAOKGMK8s9JWSU3wDjs0vh
 OLYNBNzpo6PFyNS9aObN7XICzBfuRAScYObG4sGonUJoA7Sg+stP8UTtnZmzsimBRtYh54+56
 QorehnUFCQMsnkXI/yD/p+z4uh6ZtHPx0dYHpvs2uSBH0s2Tpl9pxsnzNPJ2VCKHl5sOu2Ffy
 /7jIxiFazKDGx/7d5hlVg1Ge+JPsMuydb6ptaTCdDEZAvB5zmEg/nwszjCJMQr5Ssit3v7tc9
 qwp+TRWmEoYsPiGB43axYhi633GGllB1LnrD4GYTpA4POz5zthz3r3CB5aBIH9H/ayzpsVqM9
 +WROXbaSla325gse3uItEK+OWheddGj5o62DlZMnDR/b4O+7lmNCyZkaEKAz1M7vf/iV4Ac/h
 FnkyDc1rhNBe4hk9HiXvVoWLF4OnfxruTswom9W8F0MV8f9L4Luoe5Tk/MPDhxaJ2CPDBrGAi
 n2EUwsU/ptD5F8RjvlfcbHtPpAWwufxWv65lDvnv1UOPAIst4CMzwl0Z+t9nZ7nFY0CHZ6AHY
 WHfLPSOaXyQr9Pd1Ij9bisiz+8PX0IeOtazDlGDQ26uvP9dycc8PjuGCbPdEJlbttmmiRW+6y
 EA+LHrG12iU6iyQTTaIn0a7k6UPZmRUg24OTtxcWQvdZffgOUI/M2+4kOGK3HstYb2Kh5VFGx
 wkJAwbg4qHdKUnNx/2kt3p7qUsElqP3JWCS0HcvmCvqS3G3IfIFzteUnHtKZJBAQVsUvLQoYD
 3jfvNcOFf0kqYclTnAyOV8Rzjbc4RUSIMFoO2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of this function is built conditionally:

drivers/of/fdt.c:129:19: error: 'of_fdt_match' defined but not used [-Werror=unused-function]

Move the definition into the same #ifdef block.

Fixes: 9b4d2b635bd0 ("of/fdt: Remove dead code and mark functions with __init")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/of/fdt.c | 106 +++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3d36b5afd9bd..424981786c79 100644
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
@@ -522,6 +469,59 @@ void *initial_boot_params __ro_after_init;
 
 static u32 of_fdt_crc32;
 
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
+/**
+ * of_fdt_match - Return true if node matches a list of compatible values
+ */
+static int __init of_fdt_match(const void *blob, unsigned long node,
+			       const char *const *compat)
+{
+	unsigned int tmp, score = 0;
+
+	if (!compat)
+		return 0;
+
+	while (*compat) {
+		tmp = of_fdt_is_compatible(blob, node, *compat);
+		if (tmp && (score == 0 || (tmp < score)))
+			score = tmp;
+		compat++;
+	}
+
+	return score;
+}
+
 /**
  * res_mem_reserve_reg() - reserve all memory described in 'reg' property
  */
-- 
2.20.0

