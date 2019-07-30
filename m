Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A74C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69405206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNprjwcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfG3CoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:44:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36253 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbfG3CoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:44:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so29012490pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 19:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqzdvLOjix3ylHr5YHUpqrsLpQJqoNPYugVAgDYHQRg=;
        b=ZNprjwcR8ZPESMHDjtZDx+jmV7BfMNzyfP5AuIEBjQQNiwzYumvw39qKO0AfReG5pc
         tWF5SUtKe0NQS1Ori1DBwFwbPgzLUYr3bxWs+fz2g773fV+CK1Jn8QeIHhQJEFUifdoT
         ju3MiewN6uO0p4nmyXDp05H9OBiHJy25hOxcl9AyUiXXL273Bwh9n6HhF/XXFnoQQES9
         G345LDTWvIuje/K2sBGV9Jqj0VVDHhAusnVKWCX9lutmtv26e2+h62e9/xt+X5kFBI73
         jpMJ3JlqHPo6qdHrv63H94VT6yNqWnsfYIeoBqqOf3dny+/6uYWq9qyabxRlKsCy4q9J
         nNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fqzdvLOjix3ylHr5YHUpqrsLpQJqoNPYugVAgDYHQRg=;
        b=bBmocZXkuko//7OIsrTVqK7GEnzacR96PPAZ8VqsKuXloV9CQLnI1MM6YczoGynsFy
         3vMgh2T215HzbdS855uWu4F90LUjWRWLHnRgCKhFHCx/xb4vcQfzzLys/H7pM/Aof+IW
         FGO7lYZjSMdeRaumQ0gJ673sRaQxnkZRHGCPamg38tRuZFCshgatQyOSoRJ76anP0C4r
         Ku8DfCLF0U3usuyGGC4+xp+Ml0JILgkGKesQ32vGHCe6c/su4RvsIFz8l5et7n62uZqN
         1xZh6HMgllMFoNQP+bbw18u2ZIIVTJzQHyuz4djjWC4wQJJ42k3dpCGcVG7OeVaVejk+
         pFKg==
X-Gm-Message-State: APjAAAXGIIUsaBZDXeewz7Jr5N+Gn+Js4kYYT7k/NKtPe12C8H1w2dW9
        VcEQgHg/fRio3StC0fMcY68=
X-Google-Smtp-Source: APXvYqyzFnJ4gujcomwVjsA1MDd6VuJvq1Tdkw8bgWN1Me4lcTvXF0T33qN6dYwKCvSUwv1GPeoEtw==
X-Received: by 2002:a17:90a:9f0b:: with SMTP id n11mr75786394pjp.98.1564454659910;
        Mon, 29 Jul 2019 19:44:19 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id n140sm65331184pfd.132.2019.07.29.19.44.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 19:44:19 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] arm64: Replace strncmp with str_has_prefix
Date:   Tue, 30 Jul 2019 10:44:15 +0800
Message-Id: <20190730024415.17208-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit b6b2735514bc
("tracing: Use str_has_prefix() instead of using fixed sizes")
the newly introduced str_has_prefix() was used
to replace error-prone strncmp(str, const, len).
Here fix codes with the same pattern.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/arm64/kernel/module-plts.c | 2 +-
 arch/arm64/mm/numa.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 044c0ae4d6c8..b182442b87a3 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -302,7 +302,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type, symbol index and addend */
 		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+		if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
 			core_plts += count_plts(syms, rels, numrels,
 						sechdrs[i].sh_info, dstsec);
 		else
diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4f241cc7cc3b..4decf1659700 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -29,7 +29,7 @@ static __init int numa_parse_early_param(char *opt)
 {
 	if (!opt)
 		return -EINVAL;
-	if (!strncmp(opt, "off", 3))
+	if (str_has_prefix(opt, "off"))
 		numa_off = true;
 
 	return 0;
-- 
2.20.1

