Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C5EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B897D24676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGyoF6jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLPCK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:10:59 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33877 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPCK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:10:58 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so2282472pjs.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FqOO3wE0tn2QZf6UyRIRojyX4xpI+NMDGsdK9w/Ap4=;
        b=wGyoF6jRoSwSqw+ChtmsGgyLywamuwnCySkdQERJLwj6c5L5qb0fdxqrFu931tlm6N
         8yVFrAfggJMKfdNHQsaLv8RR/v0oqSdDn7G6b4zu0f7F3ZHMCgOEBRNBDYfo1EvnNJ5S
         tbUvpunr92twBkFUM63SSt+pRBt8o1HUUaol7gl/QKAx+uOE6avNdSaIfuNvf9TRBeoE
         tMHoF2u8UktPVgVuCRHiXaV3jEFrAx2XCB8Jo8yDsILDJJu7T+Tt7Ld/7/1ZkOXISopf
         B89pLzreYs2xQKOOj0VmCUR6VPJ8g43mhhEKBO+tHUgicS+W5JXVB8Op5XgmE3iPFIJ9
         l/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FqOO3wE0tn2QZf6UyRIRojyX4xpI+NMDGsdK9w/Ap4=;
        b=ZZ1eT9YvVtFp0H38b+bcAVuifbdsmuMXIdh6ZRmOgZLV/XXIdisa0Pbs75sK1l96cM
         vRfXLpI0+w7pELiPeRfGsfqiumQfZWWwbHBmRVlHvUEiowlmvLgJP29YQrGkrFxcRA28
         xQGJl6EUFp/2r5EW6QZ0opFyRkCuDfiIig5Bf9OkXTdSMwjBSNt7juCZYDc/6pe8d0A4
         +i96GKAB3F9ttzPgLUmV/JTSF6cvEk3qbp3fNh+QUQ3j2DXf5FbvBlnL4ApgPPFsFiSc
         1XFKPUoSc3vZFHGkY3C/MaETSz71+TllibVWOO6F40ALOMP82tBvA3zLUMrgJqv1xD9j
         w4yw==
X-Gm-Message-State: APjAAAWEsFbUkE1hCKGA6zOK1M1QdgVHoj3G5MlHMW72e9X0ny5PTZP2
        6sWyOK5mOdXhIivdIjZflS+5+w==
X-Google-Smtp-Source: APXvYqwqnj6pjtxlkbHv7rjmVjeSeNcfkdhHZLvOyl96O2c83UZCkHGR30ssVZjoytDPl1puOozqUg==
X-Received: by 2002:a17:90a:fa92:: with SMTP id cu18mr15301981pjb.114.1576462257870;
        Sun, 15 Dec 2019 18:10:57 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id p5sm18997185pgs.28.2019.12.15.18.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 18:10:57 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 1/2] libfdt: include fdt_addresses.c
Date:   Mon, 16 Dec 2019 11:12:46 +0900
Message-Id: <20191216021247.24950-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216021247.24950-1-takahiro.akashi@linaro.org>
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
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

