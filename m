Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA818C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887D720863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGLMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:10:27 -0400
Received: from foss.arm.com ([217.140.110.172]:56552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLMK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:10:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2440228;
        Fri, 12 Jul 2019 05:10:26 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC153F71F;
        Fri, 12 Jul 2019 05:10:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64/vdso: fix flip/flop vdso build bug
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>
References: <20190712101556.17833-1-naohiro.aota@wdc.com>
 <20190712101556.17833-2-naohiro.aota@wdc.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b3d06dc3-f8be-9744-f45b-608e17a4f76f@arm.com>
Date:   Fri, 12 Jul 2019 13:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712101556.17833-2-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2019 11:15, Naohiro Aota wrote:
> Running "make" on an already compiled kernel tree will rebuild the kernel
> even without any modifications:
> 
> $ make ARCH=arm64 CROSS_COMPILE=/usr/bin/aarch64-unknown-linux-gnu-
> arch/arm64/Makefile:58: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOSYM include/generated/vdso-offsets.h
>   CHK     include/generated/compile.h
>   CC      arch/arm64/kernel/signal.o
>   CC      arch/arm64/kernel/vdso.o
>   CC      arch/arm64/kernel/signal32.o
>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>   OBJCOPY arch/arm64/kernel/vdso/vdso.so
>   AS      arch/arm64/kernel/vdso/vdso.o
>   AR      arch/arm64/kernel/vdso/built-in.a
>   AR      arch/arm64/kernel/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
> 
> This is the same bug fixed in commit 92a4728608a8 ("x86/boot: Fix
> if_changed build flip/flop bug"). We cannot use two "if_changed" in one
> target. Fix this build bug by merging two commands into one function.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/kernel/vdso/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 4ab863045188..068c614b1231 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -57,8 +57,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
>  
>  # Link rule for the .so file, .lds has to be first
>  $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
> -	$(call if_changed,ld)
> -	$(call if_changed,vdso_check)
> +	$(call if_changed,ld_and_vdso_check)
>  
>  # Strip rule for the .so file
>  $(obj)/%.so: OBJCOPYFLAGS := -S
> @@ -77,6 +76,9 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>  quiet_cmd_vdsocc = VDSOCC   $@
>        cmd_vdsocc = $(CC) $(a_flags) $(c_flags) -c -o $@ $<
>  
> +quiet_cmd_ld_and_vdso_check = LD      $@
> +      cmd_ld_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
> +
>  # Install commands for the unstripped file
>  quiet_cmd_vdso_install = INSTALL $@
>        cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
> 

-- 
Regards,
Vincenzo
