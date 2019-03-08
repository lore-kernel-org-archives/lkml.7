Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F78B20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCHK6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:58:48 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHK6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:58:48 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHX7f-1hFjro3T7Z-00DVp3 for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019
 11:58:45 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: devres: devm_ioremap_resource() make res parameter const
Date:   Fri,  8 Mar 2019 11:58:45 +0100
Message-Id: <1552042725-6630-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:usIacfcXO+AJZ9TT/P/mR/xRHR2qdnB5GBwEjrWRhVI3pBGK5md
 N4Z4QM+AN7+OhmuPly7u5vLDYADv6JGVZYXY5CMAEeQOUErXzAIRcwpjGZHfqofekITHCOy
 m0lGfPd8/jvgytcQ7WuCPsV8rZVydqglDUMx2/j3O4vkk0zYE5Vld6jzfONsSkT+MEQQ+BI
 cbKk/8bcanPYSjkfSUJwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ONx18+mqGY=:RJf5K1iraiddrANcQ66p3G
 TZZI43+I4spOV2ovWcO+hIRWjuoSjoJYl6FjS1QMbFLBPyMhSalCgC6GFBQs+uR2Tc0hQZqNZ
 Wi3IgHlCDqwLqP53hD2v1KleRC7nCnTGuIYLrqiBEU6Oj7GbM9dBXZmVy74LH8L5ESxItSpN6
 eg0JXTWJAme9sKFNYrP/EVsS05fz67r6YD+mX5nFPuc+7DjxkJJotnEIeUCn6czz1oGfNfIoa
 8MLPn60ge5U4+a1mALD+W6PLYeXJ2KQuvMCxv4qLICBsRAm4p9wC3rTRmfpq3UQz3f8qzTQo/
 /Xg9wJWcQekO0J9iT+lhcJtrwNDK+K09fYQyNBYQSmFBySB37CbibCpCpGmDnE4mBvs/ZQabi
 qKw5sN4TRU39FkoT0ep41/fZ7qqU3f4BijI9NiFfUVCuCo/EzV+8rjCKIOwMm7F0XFAYRRsIN
 0vXNGvZVIxADKh+kF5Mb1VwvGW9hcUVxgpgcRzQ62N5zG6EHCxk+jSm4y1FA1jx636NECU8ti
 o7D7H14udP87yIz9gWkMIQeiZUEA6MMcs1r8/RG/wp+AU8yUxHUegHaCO2d+utvVwJebQzzKg
 1l3hrr9ZgBneKbIM2sHb9gX9+5z9qhv8nIqgLitfnVZ9eMq0/N8HBxXlY0gFPOb8wEsG688LZ
 CL2MslRbTy/jzdYzxypqn5XSgVDOzMyShEj29WNA/rAK3ksGJAmGqkiWD42JmkuO9a/tOsVv8
 o1gx5n5b8xNWvpkgk75iueb7LHkuMqe0U4kRxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() doesn't change the passed struct resource,
so it can be a const pointer.

Now, calls sites w/ fixed resources can declare them static.
(in some cases possibly even __initconst)

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/device.h | 3 ++-
 lib/devres.c           | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 54b58610..c387901 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -706,7 +706,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
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

