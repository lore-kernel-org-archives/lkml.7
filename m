Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928C5C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6556C20692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhExn69W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLIDCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:02:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42292 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfLIDCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:02:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id i5so6353981pgj.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 19:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FqOO3wE0tn2QZf6UyRIRojyX4xpI+NMDGsdK9w/Ap4=;
        b=mhExn69WBmHBESFt1kIaGlKEdtVe/i5Vgkp7eu8YMclVAMDegJkLMfclMCIgtyazfI
         b6bESJ1o1e6qyzDAXET8Nn9VmdMgWHdUzAhh6nUcy+zOUzMfvA6EErA24TTqdUxwGgVL
         ONw9363URg5l+xWM8acqZx8CyPwgxgwTA+wS252KtfXfoDyHZxb/KJk4T18mOkPNWlZA
         XjryhXj+d6UMVWcf1c4vWY4qxD/qSdC13hqxRQ4j0xdJtOvrMiBvQy0kiwOVMxNCEZ7+
         41KAvVcarkRe9lB14/lFzwhV73IBZAcR1OMqcmqm3mud/RyBsmEM92xv9xQmR1eMkLJa
         OcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FqOO3wE0tn2QZf6UyRIRojyX4xpI+NMDGsdK9w/Ap4=;
        b=k2FxHzD/K+P+wfdLiBDTyXekzTy6rsZ6rMKAPbLUali8DIR8j89WNuX8IYTGKIi0EN
         CSrSi/kAQPCQxPQ2eV9akEOnIKDbjdQDsHrza06CquuWKvnPMbAveQ0QQkrNHpqezwB2
         H2Ah8/2K/CvYNeGNbAnLpIoaczhVk1DpKii86M/TnHJgARilL1hiWfSPVd7ZzT3QiV7y
         uvZmRimN0iGzIH+vvv6VLlkE7j2gDNVFCsFxa9N1Gg3gRGj3NciLUCd9eNGvN/Rnjr0Q
         yFnXpBwTW2AbJZgdXsq5Jp9a1D98zDlgcgpxqvWMrC1DjBz6LtPv/c0izNk8iXR6YFZV
         xaoQ==
X-Gm-Message-State: APjAAAUg7EV8YD0FX9zsIpIxkhC9R9dT5+7SQsQaGPRThDi2JxTRPvGz
        97kFLW/38Kk6hUs7xM1C2q0DjA==
X-Google-Smtp-Source: APXvYqxZsY4uqLOpisCtOZNKEdJ3FgiBq1GlA/9MSZaWOtU0pz8n9rOYtSAydnEby2zUtslCi8FiRA==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr16838812pgj.119.1575860539860;
        Sun, 08 Dec 2019 19:02:19 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id y76sm15454209pfc.87.2019.12.08.19.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 19:02:19 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 1/2] libfdt: include fdt_addresses.c
Date:   Mon,  9 Dec 2019 12:03:44 +0900
Message-Id: <20191209030345.5735-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209030345.5735-1-takahiro.akashi@linaro.org>
References: <20191209030345.5735-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of kexec_file_loaded-based kdump for arm64,
fdt_appendprop_addrrange() will be needed.

So include fdt_addresses.c in making libfdt.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
---
 lib/Makefile        | 2 +-
 lib/fdt_addresses.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 lib/fdt_addresses.c

diff --git a/lib/Makefile b/lib/Makefile
index 93217d44237f..c20b1debe9b4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -223,7 +223,7 @@ KASAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
-	       fdt_empty_tree.o
+	       fdt_empty_tree.o fdt_addresses.o
 $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
diff --git a/lib/fdt_addresses.c b/lib/fdt_addresses.c
new file mode 100644
index 000000000000..23610bcf390b
--- /dev/null
+++ b/lib/fdt_addresses.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../scripts/dtc/libfdt/fdt_addresses.c"
-- 
2.24.0

