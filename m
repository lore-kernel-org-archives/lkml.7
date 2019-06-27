Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD1AC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353B12146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="leocMh+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfF0RGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:06:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45923 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:06:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so1614317plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bdsN2jI/FELlC9aGarImK+iO4GI6+QC8xOBTkQwr7Uo=;
        b=leocMh+YBwde04/uIXfjz2YieYzRS5FqMbjPTJ10vQjD7K9KhJmYzj8uGTO9KHkZ2G
         eGueJKF+eupYvKCGf8ekpDoy35ZQRBTt/sI92JABhebgZwIzNS7K+6aY6JYIDs2jCWsA
         +YcIx3Ua7+ursIIyfRI8VduaMZ+AShloQTtEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bdsN2jI/FELlC9aGarImK+iO4GI6+QC8xOBTkQwr7Uo=;
        b=NrAijTd+8e8TbUjEMRt7gJBECZ6H/bx6FFORkyLTLZePEF+nN9Pm4bYwhIAAAQakJz
         6MaqlxfrWIys8nxOI8PVrzqSLIioSvhMag6McSe6MwoFUXt5C0iIXisda84M524JgWH3
         WamT6+fbyhZL6GSqAxGN3bXFmwvGHH/5l+OntolpWzWJZ2s8JPUxqX7iJx3ntjnYGJhh
         8CU59NLKH8ob1uS5bbzQm7HYKZnCcwWRa92EWNLwpQLq1ntEGUzgaGF/gqELUxxvsKLc
         vRrP5Z/clLzkrtEyuA02J694Hlz8vz/zMvaGVO++hYt7fI+zlqmnP2bkP0j/bm3076Qs
         HVRQ==
X-Gm-Message-State: APjAAAWwrzDSZKcaTbRDHuOw7NUc2Is9m2zcWh1xidh894vrE+07gWFq
        BaYUl/yACWZuNzR/PFrZGY401w==
X-Google-Smtp-Source: APXvYqwtH4ykXg+gxZSSwZHDrQ4S38C96XryyoZqYKbqSFTJfH6pvK5ICujDurElIfBh2C366Boz/A==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr5830722plb.277.1561655178067;
        Thu, 27 Jun 2019 10:06:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm5151768pju.14.2019.06.27.10.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:06:17 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:06:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, will@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] arm64: Move jump_label_init() before parse_early_param()
Message-ID: <201906271003.005303B52@keescook>
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
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
v2:
- add Acks
- direct to akpm's tree since init_on_alloc() depends on this for arm64
  https://lkml.kernel.org/r/20190627162505.GD9894@arrakis.emea.arm.com
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
