Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B752077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDZP5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:57:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDZP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:57:43 -0400
Received: from orion.localdomain ([95.117.100.117]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mn1mb-1gu2CX0u3D-00k8E5 for <linux-kernel@vger.kernel.org>; Fri, 26 Apr
 2019 17:57:42 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: devres: devm_ioremap_resource() make res parameter const
Date:   Fri, 26 Apr 2019 17:57:40 +0200
Message-Id: <1556294260-24074-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:cCC4sROK495NEVbKTvMKV7BA4OZ6LEsSync5KvsRkwIMqs8dZio
 rivHlMgb8of8KIv1DjoQLQ2+lcSkEgKkXA0Qzk920bfJ7VJZ5wCPXgWwPGwea8Sm4wH00kS
 lXNhH1zNSjUi7TVL9aJveFktuJjFQckK0ARdyUZ2SOgpxbnDkoUy+OvJiN8MR0QOoHcSXNm
 Z0Y2sVgY6QUW82WPTjXwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MVU9aLFQFDI=:gR9JkxU2xnTDbj8qGfOhnd
 UPLybJrv1AAbmoUNZhRm+SbXXVC+4umAfPdPJGpF4hfpukihuRvUjsQIE3fEgC0YRHNVJ3Fpl
 kE2aeEecMz4WUFOpu6fNMn8teHgy8whyMULv5AZ1B9+SckxSLrR5nUO1fs1dFoTmPVIHHMnsu
 JDt4vtcn3exZUIQh3nyvUEIrPhhEyhGefXyKT5MdPJ2ZSmR3BZGEaQXJmap/LSaFCMK0a397e
 ZB4nYCcCI9fVtjqlnWMRnVHH4t9YKZ1cOM3ri7CqUYcoUl12mZbVSlqlG/cVMXMrWdE8B6ZNL
 jTpNjuuYnN7zbJAFrkYmwORUgyS3WJkbaKC83gcc2k64osOoMrp+w3WDi7OaVsGWIqfA0BSeh
 2I3HXIjQbDg+CoN40bWBpaPtNhmbkwHZ4van8so/mh3wFmexrTSZBeLwUgVBc+PkiQ6N+tfCw
 nwStjp+53hWrkv8hyBom0OBNwPK4JqH0qkxC9UgboPVMGMAvBDd8kS+wOhk5V/4gpizh/S1tK
 UvTrk5Kp2OKNHvcB/XM8XOtNz3hBHDVd+MHlH2aosdLoFFJzwb07ZCv5+4pPwsv3jwk5Tf1nz
 lwlFuIrBQCFZN1dMM7NPTY+fuJFDkDyseLFtTDky5Z9rrMVnunWTpBAsB8PSaViDnNGMbwSmP
 oxAD/3xcLRzLk1XuO4vdQErhvIwQaku/WnXoL6aTZthM/dYrij+wkxNT26fFSLdE9WywWXoG7
 DE23bry6NvSf553gbsBYoxRq8TRV0p82Y9ISMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() doesn't change the passed struct resource,
so it can be a const pointer.

Now, calls sites w/ fixed resources can declare them static.
(in some cases possibly even __initconst)

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 include/linux/device.h | 3 ++-
 lib/devres.c           | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4e6987e..d1a7d64 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -704,7 +704,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res);
 
 void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
diff --git a/lib/devres.c b/lib/devres.c
index 69bed2f..6a0e9bd 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -131,7 +131,8 @@ void devm_iounmap(struct device *dev, void __iomem *addr)
  *	if (IS_ERR(base))
  *		return PTR_ERR(base);
  */
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res)
 {
 	resource_size_t size;
 	void __iomem *dest_ptr;
-- 
1.9.1

