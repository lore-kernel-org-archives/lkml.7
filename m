Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE3CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650FD20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Km6cCa5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbfJWMzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:55:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40655 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390962AbfJWMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:55:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id i15so8545738lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pr5jyZMsP+3kod9VvT5jLLC58+kfpVegavN735X7V0c=;
        b=Km6cCa5DXSvlLJBbXZDQa2bQulIRzp+UWkLxrd1m2RqeRyw746rzQbdFLelv4UHwbI
         gR6YNEWJZoIOx46arMROI3WjGp2QxFBi5Ff2YobXl5QRNETwkvhPGM5Iuon7yjKQL/HI
         3uqIAvQLbLhA0TVRt7iuB/FgNfRhUrpPeVjAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pr5jyZMsP+3kod9VvT5jLLC58+kfpVegavN735X7V0c=;
        b=AUazwqAMosXOobI3OAvMg7dthB5evn/XKG9W6NAzBCRy9XlqSsTTwwhXBmZeB0415s
         +Fwb/ebbiZB+gtwykh3D7vRroBM5FumbeXY49HOgyyJ+A6uo5zDzeBb1bDsp7JuNxdPu
         vXteJPLmw/XjGPTYdopH55/J1nad4VXOC9K6abrEJiRE78BhR11Kxt4MqJLF3QTXoJyz
         qTU7i/bC+HBhYE0dxCSHfcvz7cH0f0jNWppqYbgaqGllhsGJrYp1izYSnajEu6UzF5cL
         kKYLkWreLsg89qxT9syHKLfNq7xJ2wvHn314wG0uhJzPtOcGQ/N7frmj/3siUuFOSd2D
         Fqaw==
X-Gm-Message-State: APjAAAXQtuC6E+rvh0aw4kw2VM3TtklqM+CMqvevPFguQDNY8s+Izwu2
        7a9+KOTh+qwkuu41LVuhyYOvWQ==
X-Google-Smtp-Source: APXvYqxOE1Ycn6M7T18O3XerWNHcmUvLPbQzFSVn50aactdzR8X43nE3FfGKkdKxXX9ODULzKKE+4g==
X-Received: by 2002:a19:5201:: with SMTP id m1mr15152059lfb.56.1571835298454;
        Wed, 23 Oct 2019 05:54:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x17sm8672267lji.62.2019.10.23.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:54:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
Date:   Wed, 23 Oct 2019 14:54:48 +0200
Message-Id: <20191023125448.383-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
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
index 7ee2c6628f64..a328a741b457 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -66,8 +66,6 @@ void __init corenet_gen_setup_arch(void)
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
index 5ca254256c47..120633f99ea6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -238,7 +238,6 @@ static void __init mpc85xx_mds_qe_init(void)
 {
 	struct device_node *np;
 
-	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 	mpc85xx_mds_reset_ucc_phys();
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index d3c540ee558f..7f9a84f85766 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -89,7 +89,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 	fsl_pci_assign_primary();
 
 #ifdef CONFIG_QUICC_ENGINE
-	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 720b0c0f03ba..6c3c0cdaee9a 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -72,7 +72,6 @@ static void __init twr_p1025_setup_arch(void)
 	fsl_pci_assign_primary();
 
 #ifdef CONFIG_QUICC_ENGINE
-	mpc85xx_qe_init();
 	mpc85xx_qe_par_io_init();
 
 #if IS_ENABLED(CONFIG_UCC_GETH) || IS_ENABLED(CONFIG_SERIAL_QE)
-- 
2.23.0

