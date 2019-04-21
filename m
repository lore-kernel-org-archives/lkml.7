Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605BC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E7B20833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555871329;
	bh=O3qXImVzzm+gXU6ZlsudcENaxcHhZKHl3eNuNB4lyew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tVrLJQP+OmnMSDLLmTu3ouyiD90cXXyTdcdEGVbg2PNb+VVG8pyM84wwFhzf9/A3u
	 3PTjUcfJXdcSi0z3I6V2/ximwIOjRH5xT/6UGGopGvARQJAFC6rUB+mjkKZ0g4n0QF
	 G3VCtucjVm6R5WnYdOr0G5S325Y5bL+VZK8lGSjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfDUS2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:28:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33750 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDUS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:28:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3so3770900wrx.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 11:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ArCPFqYwX7UMiHzjad2PhTqbe1uWNJioXFBsHyNJRk=;
        b=OpcivUCi/Wgy5zYTevEE0SLf/70N+pW36kOqpQDp0bsl76vAdS21olCg+GAOyr2xn5
         VsEAx6SX3lfTFuKkHtXFBYm3g5SDeLaPU3unA73Ff6O+Xbsd/N2mVLcSOexwVf2qPH1m
         BGPTUsomKzaBxZd+JUHmKHLfW9JsIkHCGoDaYuEnWOZkDA26LFhqXedjj3NH+3NRqJNh
         5UprNxVxsyg3wTnA78UGMNQI5584SB7hyuqxFCOm1YxtLF69iGiPZCqdWB4PHabZxIo2
         yVQLDpncphVbBe967W3ph0Q4pAGMYwHq2g39+NfnG5mlajE0NC0jE5BkgQzDFq5nI4Ar
         3mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ArCPFqYwX7UMiHzjad2PhTqbe1uWNJioXFBsHyNJRk=;
        b=sFZX0WQTV4OSq+dDXfo4PMyI2bdFPlPDvWO2wI/ulCgBxEFmT4FHcgnMCTotNl9dRN
         cYTTMeHgqz3uhfwTR16HrnMW+8pPgijN91vEwAPmXWFRYPHXMPmIryTYt0QdykrEgiIo
         yWHjP0KoGRhfwaCFplB8vobf4j98M5JNZ9TSqlm09oN82A0UOA63hZ7E3M98bKhf86St
         wE0Ic6krNdOikQd5RVCu65b3/7DsbbVnEw0NYRqsmjtqvebwrZ7JxUzRNjpuzAujCIIb
         bPeUcapsh8MEw7MjqJ5ZfeCpQkeFA5v63vomVaeXXE6yyco9K+42Abvtu2By7cfm1kKb
         vjsg==
X-Gm-Message-State: APjAAAUkJWEm3NfY6zNYgX9ALmH2PR3/2e+scAG6frw667duEWJWjnxC
        OWZjIUylJuI43+DXBCLI3uI=
X-Google-Smtp-Source: APXvYqyJH75dKpio1qLE4EeZP4ivbVK4UuI+/mjRK5w8lo8TAfHtztj88rtfgHeAiw/ikKSA4+eD+g==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr10561106wrt.13.1555871325743;
        Sun, 21 Apr 2019 11:28:45 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y125sm16675618wmc.39.2019.04.21.11.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 11:28:45 -0700 (PDT)
Date:   Sun, 21 Apr 2019 20:28:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190421182842.GD35603@gmail.com>
References: <20190421160600.GA31092@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421160600.GA31092@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> TASK_SIZE macro is quite deceptive: it looks like a constant but in fact
> compiles to 50+ bytes.
> 
> Space savings on x86_64 defconfig:
> 
> add/remove: 1/0 grow/shrink: 3/24 up/down: 77/-2247 (-2170)
> Function                                     old     new   delta
> _task_size                                     -      52     +52
> mpol_shared_policy_init                      344     363     +19
> shmem_get_unmapped_area                       92      97      +5
> __rseq_handle_notify_resume.cold              34      35      +1
> copy_from_user_nmi                           123     113     -10
> mmap_address_hint_valid                       92      56     -36
> arch_get_unmapped_area_topdown               471     435     -36
> tlb_gather_mmu                               164     126     -38
> hugetlb_get_unmapped_area                    774     736     -38
> __create_xol_area                            497     458     -39
> arch_tlb_gather_mmu                          160     120     -40
> setup_new_exec                               380     336     -44
> __x64_sys_mlockall                           378     333     -45
> __ia32_sys_mlockall                          378     333     -45
> tlb_flush_mmu                                235     189     -46
> unmap_page_range                            2098    2048     -50
> copy_mount_options                           518     465     -53
> __get_user_pages                            1737    1675     -62
> get_unmapped_area                            270     204     -66
> perf_prepare_sample                         1176    1098     -78
> perf_callchain_user                          549     469     -80
> mremap_to.isra                               545     457     -88
> arch_tlb_finish_mmu                          394     305     -89
> __do_munmap                                 1039     927    -112
> elf_map                                      527     409    -118
> prctl_set_mm                                1509    1335    -174
> __rseq_handle_notify_resume                 1116     906    -210
> load_elf_binary                            11761   11111    -650
> Total: Before=14121337, After=14119167, chg -0.02%
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/x86/include/asm/processor.h |    4 ++--
>  arch/x86/kernel/Makefile         |    1 +
>  arch/x86/kernel/task_size_64.c   |    9 +++++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -887,8 +887,8 @@ static inline void spin_lock_prefetch(const void *x)
>  
>  #define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
>  					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
> -#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
> -					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
> +unsigned long _task_size(void);
> +#define TASK_SIZE		_task_size()
>  #define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
>  					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
>  
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -46,6 +46,7 @@ CFLAGS_irq.o := -I$(src)/../include/asm/trace
>  
>  obj-y			:= process_$(BITS).o signal.o
>  obj-$(CONFIG_COMPAT)	+= signal_compat.o
> +obj-$(CONFIG_X86_64)	+= task_size_64.o
>  obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
>  obj-y			+= time.o ioport.o dumpstack.o nmi.o
>  obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
> new file mode 100644
> --- /dev/null
> +++ b/arch/x86/kernel/task_size_64.c
> @@ -0,0 +1,9 @@
> +#include <linux/export.h>
> +#include <linux/sched.h>
> +#include <linux/thread_info.h>
> +
> +unsigned long _task_size(void)
> +{
> +	return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET : TASK_SIZE_MAX;
> +}
> +EXPORT_SYMBOL(_task_size);

Good idea - but instead of adding yet another compilation unit, why not 
stick _task_size() into arch/x86/kernel/process_64.c, which is the 
canonical place for process management related arch functions?

Thanks,

	Ingo
