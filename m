Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6B0208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PAJDB8sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEMAjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 20:39:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfEMAjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 20:39:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so5819299pgi.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 17:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgOJ9QLzOUW01yLV2OfG7YkSkZvw2ViCiy6aBBS6YFQ=;
        b=PAJDB8sdHVi0D44H/07DcJs+vX7Cb6MzLOV7JTtIBdbHIYzaIGW6owURsu25tGJfP9
         Y8tm7gC8gBtob9CnxVZrElnfLEKoMkVic3khHAFKYDIS4xHKxMSValMptyH9vg4JGMsA
         cd04NRnP/ULXmIzpZPHml84TD4lCSO7ftc7/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgOJ9QLzOUW01yLV2OfG7YkSkZvw2ViCiy6aBBS6YFQ=;
        b=Yq3tAaL3zaE0zFSZ5Ld0HwdOBPypBFhXyCo/IiePOc93CUGiz0PHDueGr0bYh9MzhD
         Cs/MWsMf+h19HlOZswp/7Tm+7TLNwa1JsVWQ4fgUtpPy6aFRwwyP1Pe2budmWbzhlXCc
         HK5VU4zrZf9mP1EmGlgWMHGcXbJ0OyuV2WZGk/KAiyElCWConlQLbLIHgrwmBPLN4erZ
         gOfBnaNrh4kENm+CTKBs5Eior5HmIsfngNyTdT6jMSxkLZMS+jZnqNT28ugQu+LuhzJI
         D2oyMYyXz9jIk2JPfzg2MzAYBTdYnG5ZuPcrqHtcUUM40NwdFurDjvEsgObUqPBWVUGa
         +Z+w==
X-Gm-Message-State: APjAAAWMU3qSK+pS270pd7fCBKfzG0EL/7hg91D2kLQ6NzwqddWS/Dhg
        kuSuI9dahDpmFn0YbmiX2LwCaw==
X-Google-Smtp-Source: APXvYqx8VoaPUnB/vcidvsLO44Gv71Rvn/n97EeuUINg+y35uX61qP9+WW9jO9KRmilThstyUVqPNw==
X-Received: by 2002:a62:36c1:: with SMTP id d184mr7952363pfa.49.1557707946437;
        Sun, 12 May 2019 17:39:06 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id a9sm14619577pgw.72.2019.05.12.17.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 May 2019 17:39:05 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        boot-architecture@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH v2 1/2] fdt: add support for rng-seed
Date:   Mon, 13 May 2019 08:38:18 +0800
Message-Id: <20190513003819.356-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
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
change log:
v1->v2:
* call function in early_init_dt_scan_chosen
* will add doc to devicetree-org/dt-schema on github if this is accepted
---
 Documentation/devicetree/bindings/chosen.txt | 14 ++++++++++++++
 drivers/of/fdt.c                             | 11 +++++++++++
 2 files changed, 25 insertions(+)

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
index de893c9616a1..96ea5eba9dd5 100644
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
 
@@ -1113,6 +1115,15 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 
 	pr_debug("Command line is: %s\n", (char*)data);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (!rng_seed || l == 0)
+		return 1;
+
+	/* try to clear seed so it won't be found. */
+        fdt_nop_property(initial_boot_params, node, "rng-seed");
+
+        add_device_randomness(rng_seed, l);
+
 	/* break now */
 	return 1;
 }
-- 
2.20.1

