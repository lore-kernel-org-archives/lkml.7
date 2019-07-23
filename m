Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CCC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E462084D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="RQkalHNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391625AbfGWSzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:55:49 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44410 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGWSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563908146; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=ypLs3dYooZeIamiMNC0VJyo390E7idy+nbIFjXbR1Ck=;
        b=RQkalHNIF8rO3iFgGqEiJhEVAd716eKClphb6jG9aP7J0Ku7JK9EcA/KUsgnX8ocBZfLYM
        rdJRJ8ZtvZvMuuvICaUc8c46Y8M8ZG00Xl5MdnspARkWNOd5qb90Y9tpWydu1VIg+mzTp/
        XI828YgnE3rY4AQhSlwfNAeGfTT10cs=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] mfd/syscon: Add device_node_to_regmap()
Date:   Tue, 23 Jul 2019 14:55:35 -0400
Message-Id: <20190723185535.20631-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_node_to_regmap() is exactly like syscon_node_to_regmap(), but it
does not check that the node is compatible with "syscon".

The rationale behind this, is that one device node with a standard
compatible string "foo,bar" can be covered by multiple drivers sharing a
regmap, or by a single driver doing all the job without a regmap, but
these are implementation details which shouldn't reflect on the
devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mfd/syscon.c       | 14 ++++++++++----
 include/linux/mfd/syscon.h |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b65e585fc8c6..3dcb56d4688d 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -51,9 +51,6 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
 
-	if (!of_device_is_compatible(np, "syscon"))
-		return ERR_PTR(-EINVAL);
-
 	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
@@ -150,7 +147,7 @@ static struct syscon *of_syscon_register(struct device_node *np)
 	return ERR_PTR(ret);
 }
 
-struct regmap *syscon_node_to_regmap(struct device_node *np)
+struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	struct syscon *entry, *syscon = NULL;
 
@@ -172,6 +169,15 @@ struct regmap *syscon_node_to_regmap(struct device_node *np)
 
 	return syscon->regmap;
 }
+EXPORT_SYMBOL_GPL(device_node_to_regmap);
+
+struct regmap *syscon_node_to_regmap(struct device_node *np)
+{
+	if (!of_device_is_compatible(np, "syscon"))
+		return ERR_PTR(-EINVAL);
+
+	return device_node_to_regmap(np);
+}
 EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
 
 struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index 8cfda0554381..112dc66262cc 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -17,12 +17,18 @@
 struct device_node;
 
 #ifdef CONFIG_MFD_SYSCON
+extern struct regmap *device_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_node_to_regmap(struct device_node *np);
 extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
 extern struct regmap *syscon_regmap_lookup_by_phandle(
 					struct device_node *np,
 					const char *property);
 #else
+static inline struct regmap *device_node_to_regmap(struct device_node *np)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.21.0.593.g511ec345e18

