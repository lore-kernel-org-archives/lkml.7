Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A9E208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nNXaWS4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFZUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:51:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40341 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:51:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so36433pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H+r2vBcNECsVnDzkokFfKqo1L2Yq9wEm31BFuIPb9Hg=;
        b=nNXaWS4VLhbT+JGsByuctQWNZJHp7JsAJavoqlKD21oUt7aSpAhw8jmWQk8SXJ6oRk
         z3jppV8bRyYbt+XckWcqle1lQZmOmlTr+6/F4sOrcd31lvBCgfPq8zrN7SbBtidllJfR
         h4t7Og1prhN0GtZm0/EPWsc/0BG56puURlNW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H+r2vBcNECsVnDzkokFfKqo1L2Yq9wEm31BFuIPb9Hg=;
        b=hvPeWWWKtbGBAA303le6sWlhDooyB7E1FFZG5DoUPGQCxByPUN+ioDW3eDTgOqOMS3
         HuKbh/PRb8WurDHotma6eFfHV0Z/rlr9Td1OPhP4uZtuEbbaExvlb50RlzNsiC6dgJOY
         X6DJbbVW82hph1dzM8Msi39Pbe69He5toY3B0WQWTRv0ifRol0jsSbVd4LDRMJV1ezlH
         Uv1n1xwartZExIgzgLPs5Sw9b6KvxEjsdskk8I8LsPPfP1bqIMxwiN4v4Al/0+UHruPb
         0FDq1GvRubCRVh3CTLQNEWEW1e9vz8quTdIfSwr+p4uZwVswuZZD5psszerYdWNgB5Ob
         GMgw==
X-Gm-Message-State: APjAAAVtABvGGkGblRTfG/00FMaVpd+5wPmMsCD4Wi1fhRmp8I+ARar4
        lWIENpeghzc0Bli8jef1vJkLFg==
X-Google-Smtp-Source: APXvYqyBv/+ru/osefLPahAqjs9bw+i1Nmf582BYVjCzxKVamE4wvmGiAQg9l3TKt/8gx0GZAvxbfA==
X-Received: by 2002:a65:6104:: with SMTP id z4mr4816917pgu.319.1561582276839;
        Wed, 26 Jun 2019 13:51:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm124279pfk.157.2019.06.26.13.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:51:16 -0700 (PDT)
Date:   Wed, 26 Jun 2019 13:51:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>, Qian Cai <cai@lca.pw>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64: Move jump_label_init() before parse_early_param()
Message-ID: <201906261343.5F26328@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While jump_label_init() was moved earlier in the boot process in commit
efd9e03facd0 ("arm64: Use static keys for CPU features"), it wasn't
early enough for early params to use it. The old state of things was as
described here...

init/main.c calls out to arch-specific things before general jump
label and early param handling:

asmlinkage __visible void __init start_kernel(void)
{
        ...
        setup_arch(&command_line);
        ...
        smp_prepare_boot_cpu();
        ...
        /* parameters may set static keys */
        jump_label_init();
        parse_early_param();
        ...
}

x86 setup_arch() wants those earlier, so it handles jump label and
early param:

void __init setup_arch(char **cmdline_p)
{
        ...
        jump_label_init();
        ...
        parse_early_param();
        ...
}

arm64 setup_arch() only had early param:

void __init setup_arch(char **cmdline_p)
{
        ...
        parse_early_param();
        ...
}

with jump label later in smp_prepare_boot_cpu():

void __init smp_prepare_boot_cpu(void)
{
        ...
        jump_label_init();
        ...
}

This moves arm64 jump_label_init() from smp_prepare_boot_cpu() to
setup_arch(), as done already on x86, in preparation from early param
usage in the init_on_alloc/free() series:
https://lkml.kernel.org/r/1561572949.5154.81.camel@lca.pw

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/setup.c | 5 +++++
 arch/arm64/kernel/smp.c   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7e541f947b4c..9c4bad7d7131 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -283,6 +283,11 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_machine_fdt(__fdt_pointer);
 
+	/*
+	 * Initialise the static keys early as they may be enabled by the
+	 * cpufeature code and early parameters.
+	 */
+	jump_label_init();
 	parse_early_param();
 
 	/*
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6dcf9607d770..20c456b3862c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -424,11 +424,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
 void __init smp_prepare_boot_cpu(void)
 {
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
-	/*
-	 * Initialise the static keys early as they may be enabled by the
-	 * cpufeature code.
-	 */
-	jump_label_init();
 	cpuinfo_store_boot_cpu();
 
 	/*
-- 
2.17.1


-- 
Kees Cook
