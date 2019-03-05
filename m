Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1ED20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIviXu01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfCEMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:23:54 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40437 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfCEMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:23:52 -0500
Received: by mail-it1-f196.google.com with SMTP id l139so4111749ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTizrJikDuURsh7ju2nIlbUvamNTTxqkGIZX5fmbgCY=;
        b=nIviXu011Xu3Cj2kaH7vSSCOfdNXvTZHj8R/MEqLPXIPJJIZ0EzEJnIHvzQT3+vcg2
         bxzzvGGo3h6VNClXNBZHspNegDKm9zLs/z2hvJTdmGtGIviM6F8N0WgZCx7VPNfmJ5Ww
         MSfCmctMMyCU80KBXwBOX6Nr9fSMYvw6Lm7MXGw7KUXmnDMafeK3FNEMarsGqpdisZGL
         kegIrgBF/cStXrez78a3Pf4dBwasPoREudjzph7Hpqs+Zal1oaAcvQlmyizjstTK24CC
         LybB2W+xZRPAxUFAwFw8Vgu/b5o31SAp/8FY663rjcbHUaGCDF5S1paifsYwICCcVQ1z
         U86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTizrJikDuURsh7ju2nIlbUvamNTTxqkGIZX5fmbgCY=;
        b=Frk8GRCLGK9Q7x073n+EO/Q2JfODcvN1J8exQ3FLFAxttTQ3ChZomdhOjXPWnK7rqm
         BXw788ZWpOms5HIEB2lbGwgq/1PogecKszoFomUQtiOPiC6OxkFBWDdYj14dbg1Korm5
         oZmS4qwFX4y94nMaxa0cMdqOzDQ8aKHKyvLA1DlpMH2OFuRAtM0pp9Xv1BeenddiRFCL
         eY6K77a8Y8zMPKGo1V9EPHwWzFb4LyCv3C7VbTQAoWbappiD9CU4atoh/F0O/p5QifzG
         6lDjC/Gw9jZcOQmWwc3m4vVuAwtz7MX3uP10FBHIkftXvlWrP3+e9gSc1xgr5DWbi53N
         K/vg==
X-Gm-Message-State: APjAAAU8FzjTFWEjZA/x+EHL7+E3w5LPehaEBOL3uWKoJBVt53bMq1+z
        vlRZ/yuaBftueHopvVbxpSmJRAmA4xDRmwy1i6e82P0F
X-Google-Smtp-Source: APXvYqzsfQLLohCrJZ3kBp75OpqrV6vEd8DGG2hvVDwG0lCwu09SyUNEY4fagoVNe5OMPzpgM58YvZwzctigHlJNaGA=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr938375jaq.2.1551788630887;
 Tue, 05 Mar 2019 04:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20190305122038.GA2472@gmail.com>
In-Reply-To: <20190305122038.GA2472@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 5 Mar 2019 13:23:39 +0100
Message-ID: <CAKv+Gu_P-tmM-tFCDuxy+6mE-tGUUbcFoCUbJMAsitMk5Ahstw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI changes for v5.1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ingo,

On Tue, 5 Mar 2019 at 13:20, Ingo Molnar <mingo@kernel.org> wrote:
>
> Linus,
>
> Please pull the latest efi-core-for-linus git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus
>
>    # HEAD: 5c418dc789a3898717ebf2caa5716ba91a7150b2 efi: Fix build error due to enum collision between efi.h and ima.h
>
> The main EFI changes in this cycle were:
>
>  - Move BGRT table handling to earlier in the boot so we don't overwrite it

This one actually got reverted because it broke x86. I haven't heard
back from the Intel engineers that reported the issue, so i will
revisit this at a later date.

>  - Use 32-bit alignment for efi_guid_t
>  - Allow the SetVirtualAddressMap() call to be omitted
>  - Implement earlycon=efifb based on existing earlyprintk code
>  - Various minor fixes and code cleanups from Sai, Ard and me
>
>  Thanks,
>
>         Ingo
>
> ------------------>
> Anders Roxell (1):
>       efi: Fix build error due to enum collision between efi.h and ima.h
>
> Ard Biesheuvel (6):
>       efi/memattr: Don't bail on zero VA if it equals the region's PA
>       efi: Use 32-bit alignment for efi_guid_t
>       efi: Replace GPL license boilerplate with SPDX headers
>       efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted
>       x86: Make ARCH_USE_MEMREMAP_PROT a generic Kconfig symbol
>       efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation
>
> Ingo Molnar (1):
>       efi/fdt: Apply more cleanups
>
> Sai Praneeth Prakhya (1):
>       x86/efi: Mark can_free_region() as an __init function
>
>
>  Documentation/admin-guide/kernel-parameters.txt |   8 +-
>  arch/Kconfig                                    |   3 +
>  arch/x86/Kconfig                                |   5 +-
>  arch/x86/Kconfig.debug                          |  10 -
>  arch/x86/include/asm/efi.h                      |   1 -
>  arch/x86/kernel/early_printk.c                  |   4 -
>  arch/x86/mm/ioremap.c                           |   4 +-
>  arch/x86/platform/efi/Makefile                  |   1 -
>  arch/x86/platform/efi/early_printk.c            | 240 ------------------------
>  arch/x86/platform/efi/quirks.c                  |   6 +-
>  drivers/firmware/efi/Kconfig                    |   6 +
>  drivers/firmware/efi/Makefile                   |   1 +
>  drivers/firmware/efi/apple-properties.c         |  13 +-
>  drivers/firmware/efi/arm-init.c                 |   6 +-
>  drivers/firmware/efi/arm-runtime.c              |   6 +-
>  drivers/firmware/efi/capsule-loader.c           |   4 +-
>  drivers/firmware/efi/capsule.c                  |   4 +-
>  drivers/firmware/efi/cper-arm.c                 |  14 +-
>  drivers/firmware/efi/cper.c                     |  14 +-
>  drivers/firmware/efi/dev-path-parser.c          |   9 +-
>  drivers/firmware/efi/earlycon.c                 | 206 ++++++++++++++++++++
>  drivers/firmware/efi/efi-bgrt.c                 |   5 +-
>  drivers/firmware/efi/efi-pstore.c               |   2 +
>  drivers/firmware/efi/efibc.c                    |  10 +-
>  drivers/firmware/efi/efivars.c                  |  58 +-----
>  drivers/firmware/efi/esrt.c                     |   1 +
>  drivers/firmware/efi/fake_mem.c                 |  16 +-
>  drivers/firmware/efi/libstub/Makefile           |   4 +-
>  drivers/firmware/efi/libstub/arm-stub.c         |   5 +
>  drivers/firmware/efi/libstub/arm32-stub.c       |   6 +-
>  drivers/firmware/efi/libstub/arm64-stub.c       |   6 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c  |  15 +-
>  drivers/firmware/efi/libstub/efistub.h          |  12 ++
>  drivers/firmware/efi/libstub/fdt.c              | 115 ++++++------
>  drivers/firmware/efi/libstub/gop.c              |   4 +-
>  drivers/firmware/efi/libstub/random.c           |   6 +-
>  drivers/firmware/efi/libstub/secureboot.c       |   4 +-
>  drivers/firmware/efi/libstub/tpm.c              |   4 +-
>  drivers/firmware/efi/memattr.c                  |   7 +-
>  drivers/firmware/efi/runtime-map.c              |   3 +-
>  drivers/firmware/efi/runtime-wrappers.c         |  48 ++---
>  drivers/firmware/efi/test/efi_test.c            |   1 +
>  drivers/firmware/efi/test/efi_test.h            |   2 +-
>  drivers/firmware/efi/tpm.c                      |   5 +-
>  drivers/firmware/efi/vars.c                     |  15 +-
>  include/linux/efi.h                             |  41 ++--
>  46 files changed, 393 insertions(+), 567 deletions(-)
>  delete mode 100644 arch/x86/platform/efi/early_printk.c
>  create mode 100644 drivers/firmware/efi/earlycon.c
>
