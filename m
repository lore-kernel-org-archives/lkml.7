Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45425C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D0206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q7r9C3C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfEPK27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:28:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43337 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfEPK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:28:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so1611455pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnHxDH7/gQC7S9Ex4Yrjn2JKssZnvEJdzim34WmQ+q8=;
        b=Q7r9C3C+1xp3K+F79f6HS9pMPjdOXBJlhNlNH1sNo8Gf28sq+UxJPIbw2WS+1yYLw6
         yZqgEDWASIraQfHYA0liC/dDovipJoQ9hzXfSk4dtix+XDB4gYK6M8Y3wfvVbl2uYTjW
         uf+2pUVkJmyMR0yFOwkMZUe0h831zzwbPUIRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnHxDH7/gQC7S9Ex4Yrjn2JKssZnvEJdzim34WmQ+q8=;
        b=FLQfnjak7ZiN5R3y+u8/5CAZZFVEFLrkpZQ+NOtI4n7i3ggrCPHnaYl65i1dKZsabh
         XSfJCLD3Yrxq0K6X6Z/2L5YuPc6RnqZ68IP1eDx0hCLEP+09xdiQaQ1r45mOWEOuulKi
         XG7UT+xwjlXL6Eoi6PcUIqJJtdeEI9K18dLsfgkjn0FlTbSgSfLHHxaF1euJRBSsC1wx
         vJH5WUv4820rkUlEYGPB3us36EWLqrqOeWNeaCYzQgVPpFWgzQWGxeFPgPn1P92Zu8tM
         Xh+35DstGGXK18RG5aKlUdjFuQyTMSIy4p5kkZ3Fz3SnebV0lazwi/pYQl8ZAXsu8Ry3
         HQTg==
X-Gm-Message-State: APjAAAWVDIZqujOiJD55vkkrJ/feJKrAGnMcXBKyRc66yvEKrS/6CtDw
        QmEq4zApKRldyTS2ZjLdp1mfRw==
X-Google-Smtp-Source: APXvYqyyjv4fLjo+oyGYCsVCI5nasI3GONHx4lFzfytCasfenGK3gbTutnpws7AafXrv+jwtMbgFYw==
X-Received: by 2002:a65:5c82:: with SMTP id a2mr50043330pgt.378.1558002537858;
        Thu, 16 May 2019 03:28:57 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id h123sm9338048pfe.80.2019.05.16.03.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 May 2019 03:28:57 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 3/3] fdt: add support for rng-seed
Date:   Thu, 16 May 2019 18:28:17 +0800
Message-Id: <20190516102817.188519-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516102817.188519-1-hsinyi@chromium.org>
References: <20190516102817.188519-1-hsinyi@chromium.org>
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

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
change v2->v3:
1. use arch hook for fdt pgprot change
2. handle CONFIG_KEXEC
---
 Documentation/devicetree/bindings/chosen.txt | 14 +++++
 drivers/of/fdt.c                             | 55 ++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..fef5c82672dc 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
 the Linux EFI stub (which will populate the property itself, using
 EFI_RNG_PROTOCOL).
 
+rng-seed
+-----------
+
+This property served as an entropy to add device randomness. It is parsed
+as a byte array, e.g.
+
+/ {
+	chosen {
+		rng-seed = <0x31 0x95 0x1b 0x3c 0xc9 0xfa 0xb3 ...>;
+	};
+};
+
+This random value should be provided by bootloader.
+
 stdout-path
 -----------
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e84971d1e9ea..e9862657268d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -10,6 +10,7 @@
 
 #include <linux/crc32.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
@@ -24,6 +25,8 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
+#include <linux/reboot.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1087,11 +1090,14 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 	return 0;
 }
 
+int rng_seed_size;
+
 int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data)
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1126,6 +1132,16 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &rng_seed_size);
+	if (rng_seed && rng_seed_size > 0) {
+		add_device_randomness(rng_seed, rng_seed_size);
+
+		/* try to clear seed so it won't be found. */
+		update_fdt_pgprot(PAGE_KERNEL);
+		fdt_delprop(initial_boot_params, node, "rng-seed");
+		update_fdt_pgprot(PAGE_KERNEL_RO);
+	}
+
 	/* break now */
 	return 1;
 }
@@ -1327,4 +1343,43 @@ static int __init of_fdt_raw_init(void)
 late_initcall(of_fdt_raw_init);
 #endif
 
+#ifdef CONFIG_KEXEC
+static int update_fdt_random_seed(struct notifier_block *nb,
+				  unsigned long code, void *unused)
+{
+	int node;
+	void *rng_seed;
+
+	if (!kexec_in_progress || !rng_seed_size)
+		return NOTIFY_DONE;
+
+	node = fdt_path_offset(initial_boot_params, "/chosen");
+	if (node < 0)
+		node = fdt_path_offset(initial_boot_params, "/chosen@0");
+	if (node < 0)
+		return NOTIFY_DONE;
+
+	rng_seed = kmalloc(rng_seed_size, GFP_ATOMIC);
+	get_random_bytes(rng_seed, rng_seed_size);
+
+	update_fdt_pgprot(PAGE_KERNEL);
+	fdt_setprop(initial_boot_params, node, "rng-seed", rng_seed,
+			rng_seed_size);
+
+	kfree(rng_seed);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block fdt_random_seed_nb = {
+	.notifier_call = update_fdt_random_seed,
+};
+
+static int register_update_fdt_random_seed(void)
+{
+	return register_reboot_notifier(&fdt_random_seed_nb);
+}
+late_initcall(register_update_fdt_random_seed);
+#endif
+
 #endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
2.20.1

