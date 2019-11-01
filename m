Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650F1CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4F2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cZUgL9oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfKAMmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41579 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbfKAMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id j14so7134225lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALLDdvAQ5LNMRJEx4JjrDqX3dC2+C2shaJm9tn1b0pg=;
        b=cZUgL9oLBRzp5+jxwjXN1+biGOJrpLlFOmPTYZX74uOpH0xd0fyduvEUL5+x7PUFb7
         XAQzTnJmbFxtNzZ7mPR6CcGzTVzQc0EHBo2Cledh/LBxApiyqcPTsMyrXtb+XHoVTz2X
         k1SRrCAhAqLG9V9kcPsgXqou/0fg0FcHSRtbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALLDdvAQ5LNMRJEx4JjrDqX3dC2+C2shaJm9tn1b0pg=;
        b=j0VUuCVqTuK/BmZzwC9gniC5UlYJq/dtULJT6dJTRWF5dZrVypAR/6/AVQz1BItZgo
         vV/Sm6B9IZZwD3VhNrZP3Oqn8DByd2QsS0bdXK5rPfLl0ui4rJsnBXsJjBaDaUHcHdZK
         AY1ks5Qo67yToEuxNRDByq+oGzJRJL12lKwZIDQfdPVsJ8eVDI8ObRr9SMea3EFTueWK
         0eHuwf75SIxvDLyt25ycWoblazO65Dudi8iDH3yAC5kt8PVc/2cSBiqzYhbr5EtdotJU
         AqTt84ZHIocKYweYjArG0GpRQ26bFhZHvx/6afMYbHze3Ih5cXGbbyjwByuPYPIMv2co
         CIcQ==
X-Gm-Message-State: APjAAAW/FPs2dPEZtjFxRgIslQDfUNH3clpeIWpZeDZ9GCtAliCZAk9X
        ZZjjXtl84uT9D+brxpQgGoDnCg==
X-Google-Smtp-Source: APXvYqzWlqSzcpcLaajzBnoyvATF1c16PpqDSU7nFzwvDhDAUBiFSvdB3760AJrfsz/QMmyoFnpNIg==
X-Received: by 2002:a19:c204:: with SMTP id l4mr7136176lfc.163.1572612153419;
        Fri, 01 Nov 2019 05:42:33 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:32 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 14/36] powerpc/85xx: remove mostly pointless mpc85xx_qe_init()
Date:   Fri,  1 Nov 2019 13:41:48 +0100
Message-Id: <20191101124210.14510-15-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
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

