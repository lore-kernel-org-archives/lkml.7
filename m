Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB6C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1A221707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eNJuvDVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfE0Eea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:34:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41026 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfE0Eea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:34:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so3969772pfq.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 21:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVbr8yPZVgrbjdDwY4oDGzG2x6LajTHk+u9YRL60Obc=;
        b=eNJuvDVNY0xCYnOoRFQPfq1KCk5IYm3S+jBuGBUvHHg8kTyIIJl38TFvpNXP/SkaOB
         TTeuYIMA7uK8ZTOOGX/phsARK9XUCj1WTYlfDQleA4JDu96H9l407xOgGgtYPOtQne/p
         AHd+zhN4N1HMICiYBF54QEtO92ry5XbAKy7JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVbr8yPZVgrbjdDwY4oDGzG2x6LajTHk+u9YRL60Obc=;
        b=ByyIbpvISR54EbU9ClNjJwPFAeo5KgXZSjGsIJuYehnFarDV2NuxykF6JGmND2cn6J
         CZp+NkiBvlPpViJp9NSXRNMuEeKPdyFzU5bO2pgixMXdQ1vhSSXucnmQzpgUN0/uqpxX
         r4fVgTv78zIR6GsGEHy5OxJpIc2hNzcvtkYPTc7lL4D52Z1ClAj46eCIiZgwx5h+flL5
         FNlnqBgkZ4Hvl6qafJAyn/YZtGU5AV4tmgz79uqVeEg+wfu6bO/GkkPAvE4E2OvPpQuV
         tpmsp/751u7cPVMY+FZwqDwV3ZiUM7iVvwfYJBeGxdXJvyKDakacOYG/oPRlxYO9eEWY
         Z6rw==
X-Gm-Message-State: APjAAAVsfTQUJEeIaeBujDHaZYFMLhIR0KxPjObGa+Ukcg82PXKF5MmF
        cNoU1VzErhDva02fO1/jXziytw==
X-Google-Smtp-Source: APXvYqw1TUPqLXbXV7nXMmmJo/a19DnZPKiDk3xHcy+XoSwyNQrhr4A/Z7BVajQoeX3y3yvo0B52dQ==
X-Received: by 2002:a63:4d0f:: with SMTP id a15mr22151895pgb.59.1558931669720;
        Sun, 26 May 2019 21:34:29 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id g9sm8236061pgs.78.2019.05.26.21.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 21:34:29 -0700 (PDT)
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
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v5 2/3] fdt: add support for rng-seed
Date:   Mon, 27 May 2019 12:33:35 +0800
Message-Id: <20190527043336.112854-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527043336.112854-1-hsinyi@chromium.org>
References: <20190527043336.112854-1-hsinyi@chromium.org>
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
change log v4->v5:
* use fdt_nop_property() since property might not be wiped entirely if
following entries are smaller than property length. 
---
 Documentation/devicetree/bindings/chosen.txt | 14 ++++++++++++++
 drivers/of/fdt.c                             | 10 ++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
index 45e79172a646..678e81bc4383 100644
--- a/Documentation/devicetree/bindings/chosen.txt
+++ b/Documentation/devicetree/bindings/chosen.txt
@@ -28,6 +28,20 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
 the Linux EFI stub (which will populate the property itself, using
 EFI_RNG_PROTOCOL).
 
+rng-seed
+-----------
+
+This property serves as an entropy to add device randomness. It is parsed
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
index de893c9616a1..9d63330582bb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
+#include <linux/random.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1079,6 +1080,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 {
 	int l;
 	const char *p;
+	const void *rng_seed;
 
 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
 
@@ -1113,6 +1115,14 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (rng_seed && l > 0) {
+		add_device_randomness(rng_seed, l);
+
+		/* try to clear seed so it won't be found. */
+		fdt_nop_property(initial_boot_params, node, "rng-seed");
+	}
+
 	/* break now */
 	return 1;
 }
-- 
2.20.1

