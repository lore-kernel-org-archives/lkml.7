Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C42C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727F2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X88mHS2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfB1NSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:18:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34636 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbfB1NSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:18:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so17113609lje.1;
        Thu, 28 Feb 2019 05:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAub7ZN7TB3C9m6Jjn4lIV9KKAuyGf3mG5EO+qiXK7g=;
        b=X88mHS2aPJyQxDRk1zfz0iJtFQNRomWUXrlYh1C8GQEXe7dWsioRcl/EtDeNRQSEdl
         3TjYRC1jW79JIxCQbdYvw1+OXJ3npD8fQz6PWLIhdmCsEKB1KBzv94N0KpJOsBC+XewR
         2HoORB92YCR9yBfddICdOlr/R2exPt3Vak3tkn0iTdMxlSwCMf2niKYVOITHGPRLHP4p
         iXG0dAfj+Gr+ns6lHSPoaEIB1B/qI1OjYyPk3WFl36zxt5AimcrAExRy/zr0sJXodjwK
         32YvQyyKa9QXe1rFVweX+r4bPu0kj+WlwefYTWfV1z88yW2D0VRAEjSDwXOWLnyJIed0
         ORsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAub7ZN7TB3C9m6Jjn4lIV9KKAuyGf3mG5EO+qiXK7g=;
        b=bChXpAu0nBJ0alb+iPo5P6CO+k2AUEzdPQMMnujPIticy1GugOXw5AW8l+nzt3/xJ8
         RFQwJBqr43zaCwq1AxmbIjBFtr0/sweQGqVd1smDC7hbZKvrlU1zgJsTFzHEZWESR+SC
         qfu2ne3zoRgB7QUli58LQVIt+gX2RAGWBbF2VzjrvlS+GJ0aTas1siZ0/6tF0LT/a0wb
         Tk31d/2VFlqvRSDsAnMfR9afVXeUOZJ/uxPyG9GLpiEyHSXNYfxrNeN0AafGZGbf1r5d
         JE8u0G7tQ0oYX/jzXoxTIEBSN+iOnqsIFD5QkCqFNekDMx/rKNrUtAQxw+AMqAyTOGOf
         Hj0g==
X-Gm-Message-State: AHQUAuaeeYzcI3ljrwD+FGmWMsUe6DjrbrzgRABpaHFe5Z9xVINnSj0d
        CRn3jLtqV06CrSWPnvlKgMY=
X-Google-Smtp-Source: AHgI3Iay8ez0a1RQCFomOJDUMhoHpogz5BNBDfxXHCGhS2T/imLnSJwyv6jNxG0dMULdd8ONusesjw==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr4612778ljt.107.1551359923994;
        Thu, 28 Feb 2019 05:18:43 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id l26sm4600069lfc.37.2019.02.28.05.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:18:43 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/7] ARM: trusted_foundations: Support L2 cache maintenance
Date:   Thu, 28 Feb 2019 16:17:01 +0300
Message-Id: <20190228131707.2592-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228131707.2592-1-digetx@gmail.com>
References: <20190228131707.2592-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement L2 cache initialization firmware callback that should be
invoked early during boot in order to set up the required outer cache
driver's callbacks and add the callback required for L2X0 maintenance.

Partially based on work done by Michał Mirosław [1].

[1] https://www.spinics.net/lists/arm-kernel/msg594765.html

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 41 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h | 12 +++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 689e6565abfc..4028104cf7b2 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_ENABLE		1
+#define TF_CACHE_DISABLE	2
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -67,9 +74,43 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	u32 l2x0_way_mask = 0xff;
+
+	switch (reg) {
+	case L2X0_CTRL:
+		if (l2x0_saved_regs.aux_ctrl & BIT(16))
+			l2x0_way_mask = 0xffff;
+
+		if (val == L2X0_CTRL_EN)
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_ENABLE,
+				       l2x0_saved_regs.aux_ctrl);
+		else
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_DISABLE,
+				       l2x0_way_mask);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
+
+	return 0;
+}
+#endif /* CONFIG_CACHE_L2X0 */
+
 static const struct firmware_ops trusted_foundations_ops = {
 	.set_cpu_boot_addr = tf_set_cpu_boot_addr,
 	.prepare_idle = tf_prepare_idle,
+#ifdef CONFIG_CACHE_L2X0
+	.l2x0_init = tf_init_cache,
+#endif
 };
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..07183ca43b25 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -32,6 +32,9 @@
 #include <linux/cpu.h>
 #include <linux/smp.h>
 
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
+
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
 	unsigned int version_minor;
@@ -43,6 +46,11 @@ void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
+static inline void tf_dummy_write_sec(unsigned long val, unsigned int reg)
+{
+	if (reg == L2X0_CTRL && val == L2X0_CTRL_EN)
+		pr_err("Trusted Foundations unavailable, ignoring L2C enable-request\n");
+}
 
 static inline void register_trusted_foundations(
 				   struct trusted_foundations_platform_data *pd)
@@ -53,6 +61,10 @@ static inline void register_trusted_foundations(
 	 */
 	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
 	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
+#if IS_ENABLED(CONFIG_CACHE_L2X0)
+	pr_err("L2X0 cache will be disabled.\n");
+	outer_cache.write_sec = tf_dummy_write_sec;
+#endif
 #if IS_ENABLED(CONFIG_SMP)
 	setup_max_cpus = 0;
 #endif
-- 
2.20.1

