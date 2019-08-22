Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A46C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4683233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jyOzhTFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfHVHQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:16:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbfHVHQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:16:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so3308883pfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1M0h1fse5fWcD6TExQsXpSrhJTc/UmTdvcIiT+sTi4=;
        b=jyOzhTFhEpT0F8vv04j2INavdeUrerCYnwz08j2DyPbn/ksQ1D/zzsYav4RTqZ3jvh
         met3GnRNZPdjm/iarcVQbwLySgdKIjkUnfqolpTzUJziFzR3D7wTvFDDsydcFGYVPwws
         I6sGoA3MwMa88O6C9ba2arRlSpOy3xm2L2HbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1M0h1fse5fWcD6TExQsXpSrhJTc/UmTdvcIiT+sTi4=;
        b=MoCAalKK95TXAJCKynNMuzHdGbJLFy1G2UnNOF4Z7iNeH1tTBrxIqoEcQLhHQuy5DO
         4il+ExIufa78ngazoS6GxhGiRtKJHM4wHjlwJspFoZsP2yQcI+dh2snZpAEvD3slupP4
         aeqPeclb4D/SBcARr27spYnHj7oINeJU10xJONGSYOJ0xB5pTrB43VV0Fmy3xD5iWN8R
         Ec7iC1v0PnvCWA3U3f+HMIOBOB0fayOJVi34eRgzwk5f9VSNJ3zMAebfIVxaCsqDa2Gt
         Flj7uGRagCPvkMkF+dUK1yW2OYz8Qpf6pLJ6n3x1Tkf2myMGqQ7TsofWUoHX88Z+QXpP
         dCKg==
X-Gm-Message-State: APjAAAV2MQH5CnBnK3EM8DW6ZQHdip9TNDLQuaK0MPghwffh6BTVo/3e
        bxtoRVuicH1rO27Kbvb8a0xfIQ==
X-Google-Smtp-Source: APXvYqywLFIAaNaYsXu1OfGGVmmvmZGXRzd+bHimaWcDa4BRxGcbhjI6qIAuKVbwffys+v10Uq3gKA==
X-Received: by 2002:a63:ed55:: with SMTP id m21mr32583711pgk.343.1566458205158;
        Thu, 22 Aug 2019 00:16:45 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id w26sm30233450pfq.100.2019.08.22.00.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 00:16:44 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/3] fdt: add support for rng-seed
Date:   Thu, 22 Aug 2019 15:15:22 +0800
Message-Id: <20190822071522.143986-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822071522.143986-1-hsinyi@chromium.org>
References: <20190822071522.143986-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing a chosen node, rng-seed, which is an entropy that can be
passed to kernel called very early to increase initial device
randomness. Bootloader should provide this entropy and the value is
read from /chosen/rng-seed in DT.

Obtain of_fdt_crc32 for CRC check after early_init_dt_scan_nodes(),
since early_init_dt_scan_chosen() would modify fdt to erase rng-seed.

Add a new interface add_bootloader_randomness() for rng-seed use case.
Depends on whether the seed is trustworthy, rng seed would be passed to
add_hwgenerator_randomness(). Otherwise it would be passed to
add_device_randomness(). Decision is controlled by kernel config
RANDOM_TRUST_BOOTLOADER.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Change from v8:
* Add a new interface add_bootloader_randomness
* Add a new kernel config
---
 drivers/char/Kconfig   | 10 ++++++++++
 drivers/char/random.c  | 15 +++++++++++++++
 drivers/of/fdt.c       | 14 ++++++++++++--
 include/linux/random.h |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 96156c729a31..5974a5906fd0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -551,3 +551,13 @@ config RANDOM_TRUST_CPU
 	has not installed a hidden back door to compromise the CPU's
 	random number generation facilities. This can also be configured
 	at boot with "random.trust_cpu=on/off".
+
+config RANDOM_TRUST_BOOTLOADER
+	bool "Trust the bootloader to initialize Linux's CRNG"
+	default n
+	help
+	Bootloader could provide rng-seed set in /chosen/rng-seed in DT to help
+	increase initial device randomness. Assume the entropy provided is
+	trustworthy, it would be regarded as true hardware RNGs and update the
+	entropy estimate. Otherwise it would be regarded as device input that
+	could help mix the entropy pool, but won't be added to actual entropy.
\ No newline at end of file
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..29d3ff3de1e1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2445,3 +2445,18 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	credit_entropy_bits(poolp, entropy);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+
+/* Handle random seed passed by bootloader.
+ * If the seed is trustworthy, it would be regarded as hardware RNGs. Otherwise
+ * it would be regarded as device data.
+ * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
+ */
+void add_bootloader_randomness(const void *buf, unsigned int size)
+{
+#ifdef CONFIG_RANDOM_TRUST_BOOTLOADER
+	add_hwgenerator_randomness(buf, size, size * 8);
+#else
+	add_device_randomness(buf, size);
+#endif
+}
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
\ No newline at end of file
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9cdf14b9aaab..7d97ab6d0e31 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1044,6 +1045,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1078,6 +1080,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (rng_seed && l > 0) {
+		add_bootloader_randomness(rng_seed, l);
+
+		/* try to clear seed so it won't be found. */
+		fdt_nop_property(initial_boot_params, node, "rng-seed");
+	}
+
 	/* break now */
 	return 1;
 }
@@ -1166,8 +1176,6 @@ bool __init early_init_dt_verify(void *params)
 
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;
-	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
-				fdt_totalsize(initial_boot_params));
 	return true;
 }
 
@@ -1197,6 +1205,8 @@ bool __init early_init_dt_scan(void *params)
 		return false;
 
 	early_init_dt_scan_nodes();
+	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
+				fdt_totalsize(initial_boot_params));
 	return true;
 }
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 1f7dced2bba6..f189c927fdea 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -19,6 +19,7 @@ struct random_ready_callback {
 };
 
 extern void add_device_randomness(const void *, unsigned int);
+extern void add_bootloader_randomness(const void *, unsigned int);
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 static inline void add_latent_entropy(void)
-- 
2.20.1

