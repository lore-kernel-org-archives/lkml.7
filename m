Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D126A20857
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 21:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To+XtwAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfDUVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 17:10:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53554 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfDUVKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 17:10:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so12372660wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bUDvkW8p4d8qAMbdt57k7N4pO8TXzPEFQPQQh6N7h4I=;
        b=To+XtwAmROK17RDbxn8ohi7mfKSQIIXelfowuOyl3SXpYIxLIPtdB5IBre6wNMzmcx
         /0JodldeWExXXk+bk2au6LW+vC+HuEWInjxj/9R2f6MEoh9A1Lhc4EeCqQ/gvrqmjAjQ
         aceIGn2b2CgnGYDjwrMomh0fnGL8uDRt3sAItaAQJ84PSPUQg3Gu0/LSaxQzC+Zq3V/U
         ClTswHQffZy6B0FUKenFIY2jgWpGG82XbFK5Wr2V1DeJVBzVX/MM+uJkvjIl7sLAsdoB
         R+siri+PJA4iVTXlh4XqWD/In5E+Tnx/tja/dlZddIyP3V5PCcG3m6/InCQTLTD0wzoL
         CYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bUDvkW8p4d8qAMbdt57k7N4pO8TXzPEFQPQQh6N7h4I=;
        b=gOAXOP39uhGe9D3pU/dDZjUHgCsydBzRroC+LtMql2WiUvbdL2Zy1lp8i6zHSS2TwL
         kAvQEZ8UkSQuKguMJXqzQ1SlK+a5+DoC2cKJc34oUwDQWnJDUEgi139I3fW1k4vJwW47
         TyfOUi0knjMg26LceyRAKDEl0UF2O5bUKEChNDMYIBCmTrUOMqAtVpx4qn8W4TDXGWPc
         DKlqAvMuYLUAPdRWMIMRU+aotD+xO9pNm650mtTzqHuHXRoI59pka7s4Y2+Q4/eRR/Gq
         6dqP3bgy45KnfF2JIc8ex2Ij5CgOycrZv+otxDK2jQRUqxkMaNPP5b1sxXzyya/tcfJ2
         tvgA==
X-Gm-Message-State: APjAAAVB5kEqKEYZyyb7fAF7r5uw3HtFSApbejAsoHnvA7scGPl+T4cN
        y4PFKspzLKjtoHxal6iBMA==
X-Google-Smtp-Source: APXvYqz5xwDeSQ5GOyeaSYe6w+b7neqdI/Mmn13N7LsLXZxF5aCCeYL9ZlXDh6ROvL0H4p0HJsdD3w==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr10343007wml.50.1555881011070;
        Sun, 21 Apr 2019 14:10:11 -0700 (PDT)
Received: from avx2 ([46.53.240.200])
        by smtp.gmail.com with ESMTPSA id d3sm22241443wmf.46.2019.04.21.14.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 14:10:10 -0700 (PDT)
Date:   Mon, 22 Apr 2019 00:10:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     hpa@zytor.com
Cc:     Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190421211007.GA30444@avx2>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 01:07:08PM -0700, hpa@zytor.com wrote:
> On April 21, 2019 11:28:42 AM PDT, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >* Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> >> TASK_SIZE macro is quite deceptive: it looks like a constant but in
> >fact
> >> compiles to 50+ bytes.
> >> 
> >> Space savings on x86_64 defconfig:
> >> 
> >> add/remove: 1/0 grow/shrink: 3/24 up/down: 77/-2247 (-2170)
> >> Function                                     old     new   delta
> >> _task_size                                     -      52     +52
> >> mpol_shared_policy_init                      344     363     +19
> >> shmem_get_unmapped_area                       92      97      +5
> >> __rseq_handle_notify_resume.cold              34      35      +1
> >> copy_from_user_nmi                           123     113     -10
> >> mmap_address_hint_valid                       92      56     -36
> >> arch_get_unmapped_area_topdown               471     435     -36
> >> tlb_gather_mmu                               164     126     -38
> >> hugetlb_get_unmapped_area                    774     736     -38
> >> __create_xol_area                            497     458     -39
> >> arch_tlb_gather_mmu                          160     120     -40
> >> setup_new_exec                               380     336     -44
> >> __x64_sys_mlockall                           378     333     -45
> >> __ia32_sys_mlockall                          378     333     -45
> >> tlb_flush_mmu                                235     189     -46
> >> unmap_page_range                            2098    2048     -50
> >> copy_mount_options                           518     465     -53
> >> __get_user_pages                            1737    1675     -62
> >> get_unmapped_area                            270     204     -66
> >> perf_prepare_sample                         1176    1098     -78
> >> perf_callchain_user                          549     469     -80
> >> mremap_to.isra                               545     457     -88
> >> arch_tlb_finish_mmu                          394     305     -89
> >> __do_munmap                                 1039     927    -112
> >> elf_map                                      527     409    -118
> >> prctl_set_mm                                1509    1335    -174
> >> __rseq_handle_notify_resume                 1116     906    -210
> >> load_elf_binary                            11761   11111    -650
> >> Total: Before=14121337, After=14119167, chg -0.02%
> >> 
> >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >> ---
> >> 
> >>  arch/x86/include/asm/processor.h |    4 ++--
> >>  arch/x86/kernel/Makefile         |    1 +
> >>  arch/x86/kernel/task_size_64.c   |    9 +++++++++
> >>  3 files changed, 12 insertions(+), 2 deletions(-)
> >> 
> >> --- a/arch/x86/include/asm/processor.h
> >> +++ b/arch/x86/include/asm/processor.h
> >> @@ -887,8 +887,8 @@ static inline void spin_lock_prefetch(const void
> >*x)
> >>  
> >>  #define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
> >>  					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
> >> -#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
> >> -					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
> >> +unsigned long _task_size(void);
> >> +#define TASK_SIZE		_task_size()
> >>  #define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child,
> >TIF_ADDR32)) ? \
> >>  					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
> >>  
> >> --- a/arch/x86/kernel/Makefile
> >> +++ b/arch/x86/kernel/Makefile
> >> @@ -46,6 +46,7 @@ CFLAGS_irq.o := -I$(src)/../include/asm/trace
> >>  
> >>  obj-y			:= process_$(BITS).o signal.o
> >>  obj-$(CONFIG_COMPAT)	+= signal_compat.o
> >> +obj-$(CONFIG_X86_64)	+= task_size_64.o
> >>  obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
> >>  obj-y			+= time.o ioport.o dumpstack.o nmi.o
> >>  obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
> >> new file mode 100644
> >> --- /dev/null
> >> +++ b/arch/x86/kernel/task_size_64.c
> >> @@ -0,0 +1,9 @@
> >> +#include <linux/export.h>
> >> +#include <linux/sched.h>
> >> +#include <linux/thread_info.h>
> >> +
> >> +unsigned long _task_size(void)
> >> +{
> >> +	return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET :
> >TASK_SIZE_MAX;
> >> +}
> >> +EXPORT_SYMBOL(_task_size);
> >
> >Good idea - but instead of adding yet another compilation unit, why not
> >
> >stick _task_size() into arch/x86/kernel/process_64.c, which is the 
> >canonical place for process management related arch functions?
> >
> >Thanks,
> >
> >	Ingo
> 
> Better yet... since TIF_ADDR32 isn't something that changes randomly, perhaps this should be a separate variable?

Maybe. I only thought about putting every 32-bit related flag under
CONFIG_COMPAT to further eradicate bloat (and force everyone else
to keep an eye on it, ha-ha).
