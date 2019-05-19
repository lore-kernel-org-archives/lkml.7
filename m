Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DD0C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E32205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/7IReFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfESRJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:09:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39379 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfESRJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:09:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so6043629pfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCFKWEfomzC/p8Cp2zu9+tMCVjDMCf+wEVZ+N8bS+5w=;
        b=T/7IReFvKjKaF14U1oGtHscyU/22SyS4d7KmRC5r07CtvxiAbogbfeuIroE/8H2wz0
         nLTWIIZriLKgXnWDXlyBKjqUAsl9SsAMjTTs4IMZaZBFvDrupg39ZL7WTW3wXN2yB8aj
         f8BzAcUBvMPTNeGH08JCB9Xs2xfvt2oFwNK1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCFKWEfomzC/p8Cp2zu9+tMCVjDMCf+wEVZ+N8bS+5w=;
        b=YGe5ErxeOQtI/yZVr9AM0b4SKOcu+TtE2z6NTmQGTQfuLcG0FJeqaSn9r5W/YVFMSs
         lcKWmBqlwBqnSPUr2fX20sKvczHEw2hFw4WsNKy752IyL+hLnPBGAGVAq6f1SaTD6ohL
         KqJbX1kDyReMuu/Q5ZpdujKPniRX/4JyG97KlVlXcqQqVRcp9e4Iv29+ZI3I1+ZAZ5d8
         79h5DoSUrHYXWhfAtJ94iDgznVCiwX6khGxEKNOFtC6piHbMlKFYphLh0E9WL56iOden
         BGB03scES80a3YD1kZbplw/XmM6AK2p32QqSm7zeP0UFIaWol5i1Jzw4MBYaYdcQsLtV
         Khnw==
X-Gm-Message-State: APjAAAV5V1Nld3jRf0G1xsU6GcZPGyrEh25v1B3haoP/cnN6HWb7QR1g
        sT2rvQOWLLoxIP4+oQNcEJoaqw==
X-Google-Smtp-Source: APXvYqy+Gmvo5+tw39P1k0XyadavsTQNx3uwPq73xdTjt//OfTcVKyZMNiRhgh9F9ySQ8HBIePPR/g==
X-Received: by 2002:a63:a08:: with SMTP id 8mr69721219pgk.46.1558281910923;
        Sun, 19 May 2019 09:05:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id b23sm17547007pfi.6.2019.05.19.09.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 09:05:10 -0700 (PDT)
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 2/3] fdt: add support for rng-seed
Date:   Mon, 20 May 2019 00:04:45 +0800
Message-Id: <20190519160446.320-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519160446.320-1-hsinyi@chromium.org>
References: <20190519160446.320-1-hsinyi@chromium.org>
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
change log v2->v4:
* v3 abandoned
* fix doc error
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
index de893c9616a1..7f3d72921b23 100644
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
+		fdt_delprop(initial_boot_params, node, "rng-seed");
+	}
+
 	/* break now */
 	return 1;
 }
-- 
2.20.1

