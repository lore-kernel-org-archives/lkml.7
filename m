Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3296CC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E9320863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGLMJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:09:49 -0400
Received: from foss.arm.com ([217.140.110.172]:56524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfGLMJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:09:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AAD928;
        Fri, 12 Jul 2019 05:09:48 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE9C3F71F;
        Fri, 12 Jul 2019 05:09:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] x86/vdso: fix flip/flop vdso build bug
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>
References: <20190712101556.17833-1-naohiro.aota@wdc.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <55d3bd43-d703-83f2-1258-6be9df8330b6@arm.com>
Date:   Fri, 12 Jul 2019 13:09:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712101556.17833-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naohiro,

I was working on a similar patch set, but I just noticed you posted this one.
Thanks for that.

In reply to your series I am adding similar fix for arm64 compat.

On 12/07/2019 11:15, Naohiro Aota wrote:
> Two consecutive "make" on an already compiled kernel tree will show
> different behavior:
> 
> $ make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
>   VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
> Kernel: arch/x86/boot/bzImage is ready  (#3)
>   Building modules, stage 2.
>   MODPOST 12 modules
> 
> $ make
> make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   VDSO    arch/x86/entry/vdso/vdso64.so.dbg
>   OBJCOPY arch/x86/entry/vdso/vdso64.so
>   VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
>   CC      arch/x86/entry/vdso/vdso-image-64.o
>   VDSO    arch/x86/entry/vdso/vdso32.so.dbg
>   OBJCOPY arch/x86/entry/vdso/vdso32.so
>   VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
>   CC      arch/x86/entry/vdso/vdso-image-32.o
>   AR      arch/x86/entry/vdso/built-in.a
>   AR      arch/x86/entry/built-in.a
>   AR      arch/x86/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
> <snip>
> 
> This is causing "LD vmlinux" once every two times even without any
> modifications. This is the same bug fixed in commit 92a4728608a8
> ("x86/boot: Fix if_changed build flip/flop bug"). We cannot use two
> "if_changed" in one target. Fix this build bug by merging two commands into
> one function.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/x86/entry/vdso/Makefile | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 39106111be86..34773395139a 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -56,8 +56,7 @@ VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
>  			-z max-page-size=4096
>  
>  $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
> -	$(call if_changed,vdso)
> -	$(call if_changed,vdso_check)
> +	$(call if_changed,vdso_and_check)
>  
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
>  hostprogs-y			+= vdso2c
> @@ -127,8 +126,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
>  $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
> -	$(call if_changed,vdso)
> -	$(call if_changed,vdso_check)
> +	$(call if_changed,vdso_and_check)
>  
>  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
>  VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
> @@ -167,8 +165,7 @@ $(obj)/vdso32.so.dbg: FORCE \
>  		      $(obj)/vdso32/note.o \
>  		      $(obj)/vdso32/system_call.o \
>  		      $(obj)/vdso32/sigreturn.o
> -	$(call if_changed,vdso)
> -	$(call if_changed,vdso_check)
> +	$(call if_changed,vdso_and_check)
>  
>  #
>  # The DSO images are built using a special linker script.
> @@ -184,6 +181,9 @@ VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
>  	-Bsymbolic
>  GCOV_PROFILE := n
>  
> +quiet_cmd_vdso_and_check = VDSO    $@
> +      cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
> +
>  #
>  # Install the unstripped copies of vdso*.so.  If our toolchain supports
>  # build-id, install .build-id links as well.
> 

-- 
Regards,
Vincenzo
