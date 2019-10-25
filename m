Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C5ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC00121D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NHr0eLge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440396AbfJYMl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46402 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504519AbfJYMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id k20so1276689ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALLDdvAQ5LNMRJEx4JjrDqX3dC2+C2shaJm9tn1b0pg=;
        b=NHr0eLged/BjfzFCKmKtRtvK4h6aWm8JsDJKf3c/UVu1L4cPrJIfy66+sHdNqFD8ic
         0v5egLKNWUD6LAci4qOpdYKcK0XjXnsSfe7mnUvrUIrLj0ddHJZwVvt3v0GffuFq+vS3
         oqeqW6AFRA45hI9d9UgNSA9rcejw36HjifhTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALLDdvAQ5LNMRJEx4JjrDqX3dC2+C2shaJm9tn1b0pg=;
        b=OHh1PSrnSKn9IPAPfRe9t0t9YSsyT2RrIjaxEx/Tq7vmuQ06IOZKL6lcpn5jbzgZUM
         yCx9rFGmbu4EeKDm1x00aZjs4e8TX0F1NhA4FFK+Ye023U1GTGuHdzmmYtHYsF1O2KY4
         qkLem80N0c0wAKAeH6bzQNRkQbBNExJe9HyFRfzDA7CnzosPlkKtpNeWnVVRUHL8L0zT
         P8l88KUqATLh1YUgx+Ox0yknrwlt6r4tLgBhqqha8RJ/2h9PrGdFrtNhlUu26yyE5IER
         EHe7zlW+6FijUvLli7DitbyF10K3OIuKKIJZf/HbCvzMAnQTlnsgdzCjGaCdPsgY0+bH
         X30w==
X-Gm-Message-State: APjAAAV7rV/uiqmsEk8ianYw6uuneaPxU2SY/FElVhQMLPuoDZlR8kfC
        E2aNmAN306+CJyRs0Le/Q7wYhDpNw0oHzQ==
X-Google-Smtp-Source: APXvYqx/yohi5dWzGeRk2lnfHRK31K0rZAb0Ih65logPywg3kE1KKzlawAouFgOlE6NWJfkXV2eaCA==
X-Received: by 2002:a2e:29dd:: with SMTP id p90mr2416516ljp.26.1572007283541;
        Fri, 25 Oct 2019 05:41:23 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:23 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 16/23] powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
Date:   Fri, 25 Oct 2019 14:40:51 +0200
Message-Id: <20191025124058.22580-17-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 302c059f2e7b (QE: use subsys_initcall to init qe),
mpc85xx_qe_init() has done nothing apart from possibly emitting a
pr_err(). As part of reducing the amount of QE-related code in
arch/powerpc/ (and eventually support QE on other architectures),
remove this low-hanging fruit.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/85xx/common.c          | 23 -------------------
 arch/powerpc/platforms/85xx/corenet_generic.c |  2 --
 arch/powerpc/platforms/85xx/mpc85xx.h         |  2 --
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  1 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  1 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |  1 -
 6 files changed, 30 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index fe0606439b5a..a554b6d87cf7 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -86,29 +86,6 @@ void __init mpc85xx_cpm2_pic_init(void)
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
-void __init mpc85xx_qe_init(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np) {
-		np = of_find_node_by_name(NULL, "qe");
-		if (!np) {
-			pr_err("%s: Could not find Quicc Engine node\n",
-					__func__);
-			return;
-		}
-	}
-
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
-
-	of_node_put(np);
-
-}
-
 void __init mpc85xx_qe_par_io_init(void)
 {
 	struct device_node *np;
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 8c1bb3941642..27ac38f7e1a9 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -56,8 +56,6 @@ void __init corenet_gen_setup_arch(void)
 	swiotlb_detect_4g();
 
 	pr_info("%s board\n", ppc_md.name);
-
-	mpc85xx_qe_init();
 }
 
 static const struct of_device_id of_device_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index fa23f9b0592c..cb84c5c56c36 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -10,10 +10,8 @@ static inline void __init mpc85xx_cpm2_pic_init(void) {}
 #endif /* CONFIG_CPM2 */
 
 #ifdef CONFIG_QUICC_ENGINE
-extern void mpc85xx_qe_init(void);
 extern void mpc85xx_qe_par_io_init(void);
 #else
-static inline void __init mpc85xx_qe_init(void) {}
 static inline void __init mpc85xx_qe_par_io_init(void) {}
 #endif
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 4bc49e5ec0b6..fb05b4d5bf1e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -237,7 +237,6 @@ static void __init mpc85xx_mds_qe_init(void)
 {
 	struct device_node *np;
 
-	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 	mpc85xx_mds_reset_ucc_phys();
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 14b5a61d49c1..80a80174768c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -72,7 +72,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 	fsl_pci_assign_primary();
 
 #ifdef CONFIG_QUICC_ENGINE
-	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index b099f5607120..9abb1e9f73c4 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -57,7 +57,6 @@ static void __init twr_p1025_setup_arch(void)
 	fsl_pci_assign_primary();
 
 #ifdef CONFIG_QUICC_ENGINE
-	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 
 #if IS_ENABLED(CONFIG_UCC_GETH) || IS_ENABLED(CONFIG_SERIAL_QE)
-- 
2.23.0

