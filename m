Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0DF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfFQUPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:15:04 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:32941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:15:04 -0400
Received: from orion.localdomain ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiJhQ-1iEl1c20F4-00fSZo; Mon, 17 Jun 2019 22:15:02 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lib: devres: devm_ioremap_resource() make res parameter const
Date:   Mon, 17 Jun 2019 22:15:01 +0200
Message-Id: <1560802501-26956-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:YhnmhRqTRDS4Imrf/9UQ5zF6995Hzn41OF7sKC4+b6bM+zx3bBn
 zZ2cosTlwkUFatCnEl91fBtB82S8oIgXvoymBQVWTH+vb2a0aUrtY0vDyjyTYbchsvURquM
 +Vg+l2FqrGi/nmzpY7+fZHSfDPJhxEkeu1OLaR79bLfoff5Hyel7VQb4XeDfxLPWn2rOEmJ
 cCW6lbpCGARf0kA9RREsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+C4ZPlINKM=:P1uf8g7FqxdU75QuXNxLxa
 +ovI4iBKbFThrwp5tiRD8YEVbFP+jegnrnTsJpuYPea+s2VDxGqdXfm4Oh0aHbIR9L/2MwhSO
 9byh0pTxWkNtO0Od1w1Lgr+5FG5izZJPj2muwwdXujEtqQp1mYqKvPkHSoGS5qKjBxRrGPYzM
 2vcYbOWbMHTuvTi/tw44T8k/p9glITIoZ//rMIFX62KARk1OmYVYulUk9e1R3lrS0PYu4sML3
 4EMSEgoPW9pdH9x78BUpOF8uFxmb0++8Six+LAVdsHnlGBq8kIqpj/ps8yfII//WWIhkMMDpc
 JZQQAo+mzbVvjjqXZT+fOfuepKJWSGkbBdGzW6jOrVVnIyehEnUUpYxXd9CxnLgJrGVDcGjUZ
 sDNA7YMLPuo4I2wr660gDPzWmUpUWHMTxPa7hC++XebNtfInc4B8We4pvQnS6dvq6o66Eq1FU
 pCTiOqpi1T1xtthXL8QnyD933VFSdZxcNqDLToymzUoGEHS1E5B+hFEqNjsNo6qLb4++r6f4Y
 BTQ5UevUj5EeyZM69g1dQGYyiIuDCA4TCkJhRC3tyfcm19rN6hOqnYMxj+piHwyvb7cMsqPQY
 MSesvKMBhrEOtziveG7gzxLTwNlcsN50MzoGDXdB2MG+lO7+eVeuCPFVRaQZdypF8CWQHZnls
 A6e2l6UepIxbCnSjgCXnVAqXI/hJEUhBEv4YiSB+S1Y6Juzwiyq+x6h27k79Cqc5H21TzEZvn
 mVE1j5xx79PQnnBN4cufp0vY4oyM3J/jZi5+vA==
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
index 848fc71..4a295e3 100644
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

