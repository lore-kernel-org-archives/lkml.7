Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A96BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51DD2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWLQMu9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404301AbfHWG1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:27:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44405 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbfHWG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:27:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so5752726pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pVReU3L4xNNWo9+KatKn65E5Ld718QqqaoOMK1fJHQ=;
        b=XWLQMu9+3h/iiKrPiQ+ZajD1bYKREAVWGm/oN5kfGiIkOsaUVYdGD9oABeJ9b7IO95
         wRhqWd249jRsuQlRX40CtosYmC+jw3LZvtQL8AMXe8oqmHGDPyr2fP3Cm+1a0czCyU35
         v0Pu4/ZcYMgi0gTjwMpbG7TgTOb7IRXYbkvOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pVReU3L4xNNWo9+KatKn65E5Ld718QqqaoOMK1fJHQ=;
        b=c41gpVO1mgKQQ1ZJJcw6XBswu2tE0G2qiIysfpB83XIDPLSI7i6WHF/HVceP1BkIUf
         FGKkmjh+/RNELGdGQfXleNT8pCSM+HoD2XMZ9Ycbj5ZsLcJb/YwKmISZNG+AomGWMOjG
         ltHzP3iuiaR3rF6uIYbENE9Z67fsIly7tFj5d0tZ1qg0sUMgAvWhmrOC1jzhBTgMfukp
         86ho1aJdPkS0X8DmTYE7B6XluAtz2hP3v7L5UmTYivJAI5ko3KlDMcr1Qe0B623TmS5K
         jYT5gvZcM4QEFl2ElsbRPTcjvQjOnz65g46Y/pQ+r9FYCIl3fbRKKQFL4IxrPE0PIT4g
         8GEA==
X-Gm-Message-State: APjAAAUSz1KCvzCoG1sBDQjGiP8HFzKoA++VVu2OXo1txpn+z6u7f6qS
        gW4SN7t+8JzkCMFeYGKNcw5TvQ==
X-Google-Smtp-Source: APXvYqz0Nb4vLW/Rppgb80/OXeYgQhAO9pkk8UoujB6MiOthueFuVt1sTRT03Pr+UQuClClNGMHy1w==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr3519541pjs.140.1566541654373;
        Thu, 22 Aug 2019 23:27:34 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id q13sm2139671pfl.124.2019.08.22.23.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Aug 2019 23:27:33 -0700 (PDT)
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
Subject: [PATCH v10 2/3] fdt: add support for rng-seed
Date:   Fri, 23 Aug 2019 14:24:51 +0800
Message-Id: <20190823062452.127528-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823062452.127528-1-hsinyi@chromium.org>
References: <20190823062452.127528-1-hsinyi@chromium.org>
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
Change from v9:
* reword kconfig
* use IS_ENABLED for config
---
 drivers/char/Kconfig   |  9 +++++++++
 drivers/char/random.c  | 14 ++++++++++++++
 drivers/of/fdt.c       | 14 ++++++++++++--
 include/linux/random.h |  1 +
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 96156c729a31..df0fc997dc3e 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -551,3 +551,12 @@ config RANDOM_TRUST_CPU
 	has not installed a hidden back door to compromise the CPU's
 	random number generation facilities. This can also be configured
 	at boot with "random.trust_cpu=on/off".
+
+config RANDOM_TRUST_BOOTLOADER
+	bool "Trust the bootloader to initialize Linux's CRNG"
+	help
+	Some bootloaders can provide entropy to increase the kernel's initial
+	device randomness. Say Y here to assume the entropy provided by the
+	booloader is trustworthy so it will be added to the kernel's entropy
+	pool. Otherwise, say N here so it will be regarded as device input that
+	only mixes the entropy pool.
\ No newline at end of file
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..566922df4b7b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2445,3 +2445,17 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
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
+	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
+		add_hwgenerator_randomness(buf, size, size * 8);
+	else
+		add_device_randomness(buf, size);
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

