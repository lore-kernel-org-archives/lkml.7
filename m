Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296BCFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B0206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DHGXNL3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfKHNET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:04:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42963 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfKHNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id z12so4389589lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc+8R+PtxSGR+WKCXh82E6vFl/rmsOl6moV7TXDxFX4=;
        b=DHGXNL3FwDnFN1h0TodDE2uyaNOuN9R8G3PKs/v6XWU5PQWHGA1bkRdiYmr8ZHmt7j
         ypFz6rqutfze2tlaMFen1OEki3V4FVAfqY1YzaLd+eDPrm/UufAhhuyH7fKEVpd5p1Ua
         dbn/6Y63qUxYYDUJMfVTTaxWCNBJ6gQwjghJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc+8R+PtxSGR+WKCXh82E6vFl/rmsOl6moV7TXDxFX4=;
        b=eK9syvubitCpPm3woMoixVJKtLqHdY0RsJJI5l0cwP/+8uPPHZK1u6WJDHbBiXn/UU
         gmIf6Xf2uft/1II56ehcHnjwTNmc4cMwflcKDdjzcdLoZxKs7Hc5uY/8PVoHNU8a85Ll
         hPDwniBk/l1lPOU5wXrAPz3TZSEbEK6vWQyxuX71+DVVsbfqrByt6NWnc+k2DpibNDy9
         dqql1nyEweRVB6HydWMFUpWkHDqBWZjdA1IZ7h93vMzA5KajUOzdzetSWpvbX4dpfVhN
         URBcPO765t7yE1H+5fVXLkC1O274mG5ZKcoOfmYBFAZKeiGprNRXDLehFy9MDwuGSUhM
         loFg==
X-Gm-Message-State: APjAAAV6l80yrdpFuvP9ggYxDXEqpHmbObOgWWceNrT1QAT/RgLfGScc
        c9qwRIvYIxp+JSoEfaeiek+hhg==
X-Google-Smtp-Source: APXvYqwbDJNvRFgoz1Gh1V6nLMxZw08ojqlEbbksBCfcH0Aoo0v0AKrmQdBMsXhZdZeoPocQbV8PdA==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr6599461lfd.105.1573218105404;
        Fri, 08 Nov 2019 05:01:45 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:44 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 13/47] powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
Date:   Fri,  8 Nov 2019 14:00:49 +0100
Message-Id: <20191108130123.6839-14-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now exactly the same as mpc83xx_ipic_init_IRQ, so just use
that directly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/km83xx.c      | 2 +-
 arch/powerpc/platforms/83xx/misc.c        | 7 -------
 arch/powerpc/platforms/83xx/mpc832x_mds.c | 2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c | 2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c | 2 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c | 2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h     | 5 -----
 7 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 5c6227f7bc37..3d89569e9e71 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -177,7 +177,7 @@ define_machine(mpc83xx_km) {
 	.name		= "mpc83xx-km-platform",
 	.probe		= mpc83xx_km_probe,
 	.setup_arch	= mpc83xx_km_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 6935a5b9fbd1..1d8306eb2958 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -88,13 +88,6 @@ void __init mpc83xx_ipic_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
-#ifdef CONFIG_QUICC_ENGINE
-void __init mpc83xx_ipic_and_qe_init_IRQ(void)
-{
-	mpc83xx_ipic_init_IRQ();
-}
-#endif /* CONFIG_QUICC_ENGINE */
-
 static const struct of_device_id of_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 1c73af104d19..6fa5402ebf20 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -101,7 +101,7 @@ define_machine(mpc832x_mds) {
 	.name 		= "MPC832x MDS",
 	.probe 		= mpc832x_sys_probe,
 	.setup_arch 	= mpc832x_sys_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq 	= ipic_get_irq,
 	.restart 	= mpc83xx_restart,
 	.time_init 	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 87f68ca06255..622c625d5ce4 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -219,7 +219,7 @@ define_machine(mpc832x_rdb) {
 	.name		= "MPC832x RDB",
 	.probe		= mpc832x_rdb_probe,
 	.setup_arch	= mpc832x_rdb_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 5b484da9533e..219a83ab6c00 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -208,7 +208,7 @@ define_machine(mpc836x_mds) {
 	.name		= "MPC836x MDS",
 	.probe		= mpc836x_mds_probe,
 	.setup_arch	= mpc836x_mds_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index b7119e443920..b4aac2cde849 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -41,7 +41,7 @@ define_machine(mpc836x_rdk) {
 	.name		= "MPC836x RDK",
 	.probe		= mpc836x_rdk_probe,
 	.setup_arch	= mpc836x_rdk_setup_arch,
-	.init_IRQ	= mpc83xx_ipic_and_qe_init_IRQ,
+	.init_IRQ	= mpc83xx_ipic_init_IRQ,
 	.get_irq	= ipic_get_irq,
 	.restart	= mpc83xx_restart,
 	.time_init	= mpc83xx_time_init,
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index d343f6ce2599..f37d04332fc7 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -72,11 +72,6 @@ extern int mpc837x_usb_cfg(void);
 extern int mpc834x_usb_cfg(void);
 extern int mpc831x_usb_cfg(void);
 extern void mpc83xx_ipic_init_IRQ(void);
-#ifdef CONFIG_QUICC_ENGINE
-extern void mpc83xx_ipic_and_qe_init_IRQ(void);
-#else
-#define mpc83xx_ipic_and_qe_init_IRQ mpc83xx_ipic_init_IRQ
-#endif /* CONFIG_QUICC_ENGINE */
 
 #ifdef CONFIG_PCI
 extern void mpc83xx_setup_pci(void);
-- 
2.23.0

