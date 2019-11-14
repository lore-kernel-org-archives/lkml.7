Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62399C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A520659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7vJIIec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKNFOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:14:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36960 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfKNFOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:14:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id bb5so2090126plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 21:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zfaZ7B1OIQM+O5UvJ/wV2ZCp71JUGqq5m81NfGqahU8=;
        b=s7vJIIecua6jio8GHP1SNLsWbrutJhjvfgoslAJdyNfzmy2b9kqOYLOYM2io59i57Q
         jHqssXPr1DHovyseaLXmzWBud240mH+UczZjWG9GydYicchKzi4Wla8GgBJHMEh5oRFF
         jQvFs0JkSiGRkjFe88ooLL/JT+Hcmel4OTYtA2+A/YQTZhpxB2FKtIWwxw0Tx8vuDky2
         7NVZHUujA72FiD4PpVq1EJDZEi7D2Vek7s0SsAE0g+DcZjJtNS7cFcPUdPZpqUkJeRoO
         a+gl4l0qGEmtluToROVonxdeXyD5qmLzG9MHlYvsMuFXNqsAfIOUCp7J05JVm7W5ZCVd
         Tu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zfaZ7B1OIQM+O5UvJ/wV2ZCp71JUGqq5m81NfGqahU8=;
        b=SwAu+5myLx+JQW9r5bAqmK7bDsLbf9HEyax+YmXsJxPiJF9oUd+Vqb/MXnDiq7C3NY
         9WUQvqgEHUiOJZjCfSS6vG732Iaza+ibWk0vACNklcBu4u5zG1htZUY3djHuHZsyG/Eq
         6OFfDsszs6RF2OxTyGPgTBG0fM71aqFp5yNdtd8EAbBEQQe++Jp3KXaUiiHRQn3zYMj8
         shOv7ZylFd/SrwhyVzBONoiHJDXzIrEMnI9h5txB0b5zzh1wx1mv4LO+JDI0AomhyXvn
         Y7cZZ+QKmxCg3sLtQsU+rx/Xc8w694DUVI5240L+f1ytnwPyNdKKFunKVw0yLk+UjCd4
         pXqw==
X-Gm-Message-State: APjAAAXzkbr3w6QzlUW/6wpvhYfMAC+E/8T3doUqLsoy7wbgiQ04ApWF
        mamHR2IDfY7BEAkX5KFlvt2fpA==
X-Google-Smtp-Source: APXvYqwvSy/LfRqw2z0v90Wt959y1d3zEAzp3xYzp6pLJgAetEFbCnaPuTr2G6XfYbzFoablMg0SNQ==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr7731002pll.171.1573708484192;
        Wed, 13 Nov 2019 21:14:44 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id ay16sm9718758pjb.2.2019.11.13.21.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 21:14:43 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/3] libfdt: include fdt_addresses.c
Date:   Thu, 14 Nov 2019 14:15:09 +0900
Message-Id: <20191114051510.17037-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114051510.17037-1-takahiro.akashi@linaro.org>
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
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
index c5892807e06f..1587a2de99c6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -220,7 +220,7 @@ KASAN_SANITIZE_stackdepot.o := n
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
2.21.0

