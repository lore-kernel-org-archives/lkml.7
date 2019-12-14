Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BFBC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA75214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 14:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLNOlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 09:41:07 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:45441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 09:41:07 -0500
Received: from orion.localdomain ([95.114.98.35]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPXxi-1iKbZU2Lw2-00MYOR; Sat, 14 Dec 2019 15:41:02 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org
Subject: [PATCH] drivers: devres: add devres_add_auto_ptr()
Date:   Sat, 14 Dec 2019 15:40:32 +0100
Message-Id: <20191214144032.24062-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:hrdThy5tTSwtzfNzGsrQrsoQfuU6JpoPS9+X4p0/p3FJiAzlCgc
 1u8iA/TkQ6//f4bHhPShkk+HkzscwFSBeEs727oVNifijdH51/ud0R42lng/Esg3Fn5Azq6
 t2ZUpeK4sK2MVtQEuEtFVI+liz/tf7+TCfGQl8ZCLZ6rvfWqR8imZIXJduFKsT0EKfIk9xb
 kLXAqTYn+yVxVpHe/Q7zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:psYwW+SNV6c=:tX3sRAtkfnCKNMiT3QteeH
 GcrMyVhXxD+DG9uOn1BuHqBehrZ3/Rs9i5JkjPQvDnGQUieOzUKTl8R8W5rUJHAncReoYOQHy
 CfzFQukk1EKTzc0gTqBfdvjl8Ej2eCF13DQVcDvXNq8Ge8a6IYJYPFgwOMlTkO6YtgKObfwuu
 WJdVif1Qqw1GgKrOsGcqA891xjDah3teJATvJMGEQzonGn+aCEYm+ytH3iUWTzqCTAopAtQKS
 KChKmQ/NZPoHn7kJtJ8OLLsV5fXsoAli4zR2ZVBLEgyIcsiIs0rM41xFI8yUmYo/YAPgZDL3k
 NW/OvXLdtoKJkJ2TZPaxy1N9z/akWtmyyUuv1kpCUaVCWGsW+yRF0L8+mOHwp7s3/J6yscYTo
 82qyJ2ufA0kgN0BNfGsXZ4wYzuwZPEfKxYWCzAbK6xP5+EFpR5Tf2cpFzEp4n8uskuJ0K8RaW
 kJYLR+OiEm3QNCEPV4dlAihKN2G+WYYVNyqMUQHv0uqLAMptS3XsG/k1274V4hbY6dI6GlhPk
 klbeFToGYGsEvqG8PPPV9AjA/tAjvPo+wA9aqygXNSir6mVdBh7biCxIzJzckD22aPBfL7/cw
 pOJbrwYd/1W2eFG079v5SzZlOpIXbSnmLNA0tcvcDsEUAydonFLDMll/RqVHC5Owfft+t9UTK
 UIiTGAxJiuO+Bbpvt9IGYIL3SHoNlzRkxMvKE4zVnBUKo7QyA/9kiN/C+SG5jbSN8fSQOEQDA
 26n9gKNCneDA9goaARsJ0e5IsGgvxXFFfHh6ymgLcr4t+UdwD82ECX1dJ2tjiIhaGKifobL98
 nBfeHJmsx0GwjhGYi/XXVOAdoDTt43+gYY5VIPhHLjQzNPefbKIIFBwr9zhv+64ajEDc27TJW
 1IRS7o0ibm1ssGrfevqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a helper for allocating and adding a devres in one shot,
in order to minimize boilerplate. In case of failure, it frees
the resource and returns error.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/base/devres.c  | 29 +++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..6631d3748ebe 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -237,6 +237,35 @@ void devres_add(struct device *dev, void *res)
 }
 EXPORT_SYMBOL_GPL(devres_add);
 
+/**
+ * devres_add_auto_ptr - Reigster pointer device resource
+ * @dev: Device to add resource to
+ * @release: release callback function
+ * @ptr: pointer to register
+ *
+ * Allocate a devres entry and register pointer @ptr to @dev. On driver
+ * detach, the associated release function will be invokied and devres
+ * will be freed automatically.
+ *
+ * The devres will be allocated w/ GFP_KERNEL
+ *
+ * In case of failure, the resource will be released automatically !
+ */
+int devres_add_auto_ptr(struct device *dev, dr_release_t release, void *ptr)
+{
+	void **dr;
+	dr = devres_alloc(release, sizeof(ptr), GFP_KERNEL);
+	if (!dr) {
+		pr_err("devm: out of memory!\n");
+		release(dev, ptr);
+		return -ENOMEM;
+	}
+
+	devres_add(dev, dr);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devres_add_auto_ptr);
+
 static struct devres *find_dr(struct device *dev, dr_release_t release,
 			      dr_match_t match, void *match_data)
 {
diff --git a/include/linux/device.h b/include/linux/device.h
index e226030c1df3..b8d8eef89fdf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -905,6 +905,8 @@ extern void devres_for_each_res(struct device *dev, dr_release_t release,
 				void *data);
 extern void devres_free(void *res);
 extern void devres_add(struct device *dev, void *res);
+extern int devres_add_auto_ptr(struct device *dev, dr_release_t release,
+			       void *ptr);
 extern void *devres_find(struct device *dev, dr_release_t release,
 			 dr_match_t match, void *match_data);
 extern void *devres_get(struct device *dev, void *new_res,
-- 
2.11.0

