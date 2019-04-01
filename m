Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAB2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhfNoPse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDATS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:18:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDATSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 15:18:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so13518952wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzLoaR8D3N7HvocGv0rCSTfMVWj0db+5QWRjE2wrnvg=;
        b=fhfNoPsepMCmVa1Q7lBsq34drIPJCgCln4CkoUgpOzNHZFLSt97HPZ0pq+jIaalXMV
         Pvsy24AmMsX5mA6oBjR/UHATcW9I6WTZAJY+XbVZLHingPApjeDloxhNOXvnJund7RDG
         H6srI6/tf2sun8/wT/Qwu5AgmnxsJPPkeoo/Mj2m+UFkuRTiYtVuLvZR/ZFrbyPtB61D
         6+jQsKLMmCvddOWyTgDKEohPnyv9KESZGpWutj5OXxdClU60aPMms0lz4Iy22hj0oEzp
         jYRzLwDKVu6xvJLsXHG7RqNMMCgFQfFhYWTb4X8N8v0C1+XFirWeX+R7gZDqEd2vw03j
         W9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzLoaR8D3N7HvocGv0rCSTfMVWj0db+5QWRjE2wrnvg=;
        b=pMDkJucczvxMtoAgioezOjsvW6yuNLdlKI305/pawezCAasodhbV5/ZVE9k4JDDhxP
         iPWxkn3UW464uIuzZTvWsaU7IlYpSM2EODKVI11aziDcKZkTszoRv7evRx0DoG2gvZaI
         79hrPDa1bQovO2G6YX7oYDeprC8NlWgLkGfjT68uHMWQTyUlKa4YuFTcEK1Eot0ICaI1
         7TkceKP5C64kp/0/s64DhdovF9IgB34dN0JyikY5VvPoTMgEVHVMsl1WpCoi3B18ipdt
         59yDy8+Na/McZWP+s0SM9sISWWOKYKOrZAQUR+setJs/Zm/e8b9U94b/81GUfgqBeg1r
         bNfg==
X-Gm-Message-State: APjAAAUj3Hh+Nam3BaXPs6QSvD/M+7CkTl4udv9nRotu/dYaTmVtrcyr
        PIiETPE9PdFvB6YBEyN5Ob4820J/6sFbZH2IMCuS0Q==
X-Google-Smtp-Source: APXvYqyXos+eVV1wLVH4WaLX2qsSGXmy3YHqgIeSW3vAVnkV71mtosic4GeW2EhJZa6DiIF3kYg2Y1OOCjSOA+nM/oo=
X-Received: by 2002:a5d:698b:: with SMTP id g11mr319311wru.65.1554146332843;
 Mon, 01 Apr 2019 12:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190326160901.4887-1-kan.liang@linux.intel.com> <20190326160901.4887-2-kan.liang@linux.intel.com>
In-Reply-To: <20190326160901.4887-2-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 1 Apr 2019 12:18:41 -0700
Message-ID: <CABPqkBTQTFq73EJU_FR3Z0oFUiSei4gY1+sQgWgPgjX4AsiNhw@mail.gmail.com>
Subject: Re: [PATCH V4 01/23] perf/x86: Support outputting XMM registers
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 9:11 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Starting from Icelake, XMM registers can be collected in PEBS record.
> But current code only output the pt_regs.
>
> Add a new struct x86_perf_regs for both pt_regs and xmm_regs.
> XMM registers are 128 bit. To simplify the code, they are handled like
> two different registers, which means setting two bits in the register
> bitmap. This also allows only sampling the lower 64bit bits in XMM.
>
You are adding this new x86_perf_regs struct but the patch does not
include how it is allocated.
I don't see from this patch where x86_perf_regs->xmm_regs is actually allocated.

> The index of XMM registers starts from 32. There are 16 XMM registers.
> So all reserved space for regs are used. Remove REG_RESERVED.
>
> Add PERF_REG_X86_XMM_MAX, which stands for the max number of all x86
> regs including both GPRs and XMM.
>
> XMM is not supported on all platforms. Adding has_xmm_regs to indicate
> the specific platform. Also add checks in x86_pmu_hw_config() to reject
> invalid config of regs_user and regs_intr.
>
> Add REG_NOSUPPORT for 32bit to exclude unsupported registers.
>
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>
> Changes since V3:
> - Keep the old names for GPRs. Rename PERF_REG_X86_MAX to
>   PERF_REG_X86_XMM_MAX
> - Remove unnecessary REG_RESERVED
> - Add REG_NOSUPPORT for 32bit
>
>  arch/x86/events/core.c                | 10 ++++++++++
>  arch/x86/events/perf_event.h          |  2 ++
>  arch/x86/include/asm/perf_event.h     |  5 +++++
>  arch/x86/include/uapi/asm/perf_regs.h | 23 ++++++++++++++++++++++-
>  arch/x86/kernel/perf_regs.c           | 27 ++++++++++++++++++++-------
>  5 files changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index e2b1447192a8..9378c6b2128f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -560,6 +560,16 @@ int x86_pmu_hw_config(struct perf_event *event)
>                         return -EINVAL;
>         }
>
> +       if (event->attr.sample_regs_user & ~PEBS_REGS)
> +               return -EINVAL;
> +       /*
> +        * Besides the general purpose registers, XMM registers may
> +        * be collected in PEBS on some platforms, e.g. Icelake
> +        */
> +       if ((event->attr.sample_regs_intr & ~PEBS_REGS) &&
> +           (!x86_pmu.has_xmm_regs || !event->attr.precise_ip))
> +               return -EINVAL;
> +
Shouldn't you be testing on PEBS_REGS only if the user is asking for
PEBS sampling?
That is not because PEBS may not capture a register that the kernel
could not do it
without PEBS.

>         return x86_setup_perfctr(event);
>  }
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index a75955741c50..6428941a5073 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -657,6 +657,8 @@ struct x86_pmu {
>          * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
>          */
>         int (*check_period) (struct perf_event *event, u64 period);
> +
> +       unsigned int    has_xmm_regs : 1; /* support XMM regs */
>  };
Is this an Intel specific field? If so, then say intel_has_xmm_regs,
just like amd_nb_constraints above.
If not, then define what is is supposed to mean? Because I am sure
there is another way to detect if
the CPU support XMM regs, like cpufeatures?

>
>  struct x86_perf_task_context {
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 8bdf74902293..d9f5bbe44b3c 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -248,6 +248,11 @@ extern void perf_events_lapic_init(void);
>  #define PERF_EFLAGS_VM         (1UL << 5)
>
>  struct pt_regs;
> +struct x86_perf_regs {
> +       struct pt_regs  regs;
> +       u64             *xmm_regs;
> +};
> +
>  extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
>  extern unsigned long perf_misc_flags(struct pt_regs *regs);
>  #define perf_misc_flags(regs)  perf_misc_flags(regs)
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index f3329cabce5c..ac67bbea10ca 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -27,8 +27,29 @@ enum perf_event_x86_regs {
>         PERF_REG_X86_R13,
>         PERF_REG_X86_R14,
>         PERF_REG_X86_R15,
> -
> +       /* These are the limits for the GPRs. */
>         PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>         PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
> +
> +       /* These all need two bits set because they are 128bit */
> +       PERF_REG_X86_XMM0  = 32,
> +       PERF_REG_X86_XMM1  = 34,
> +       PERF_REG_X86_XMM2  = 36,
> +       PERF_REG_X86_XMM3  = 38,
> +       PERF_REG_X86_XMM4  = 40,
> +       PERF_REG_X86_XMM5  = 42,
> +       PERF_REG_X86_XMM6  = 44,
> +       PERF_REG_X86_XMM7  = 46,
> +       PERF_REG_X86_XMM8  = 48,
> +       PERF_REG_X86_XMM9  = 50,
> +       PERF_REG_X86_XMM10 = 52,
> +       PERF_REG_X86_XMM11 = 54,
> +       PERF_REG_X86_XMM12 = 56,
> +       PERF_REG_X86_XMM13 = 58,
> +       PERF_REG_X86_XMM14 = 60,
> +       PERF_REG_X86_XMM15 = 62,
> +
> +       /* These include both GPRs and XMMX registers */
> +       PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
>  };
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index c06c4c16c6b6..07c30ee17425 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -59,18 +59,34 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
>
>  u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
> +       struct x86_perf_regs *perf_regs;
> +
> +       if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
> +               perf_regs = container_of(regs, struct x86_perf_regs, regs);
> +               if (!perf_regs->xmm_regs)
> +                       return 0;
> +               return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
> +       }
> +
>         if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
>                 return 0;
>
>         return regs_get_register(regs, pt_regs_offset[idx]);
>  }
>
> -#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
> -
>  #ifdef CONFIG_X86_32
> +#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
> +                      (1ULL << PERF_REG_X86_R9) | \
> +                      (1ULL << PERF_REG_X86_R10) | \
> +                      (1ULL << PERF_REG_X86_R11) | \
> +                      (1ULL << PERF_REG_X86_R12) | \
> +                      (1ULL << PERF_REG_X86_R13) | \
> +                      (1ULL << PERF_REG_X86_R14) | \
> +                      (1ULL << PERF_REG_X86_R15))
> +
>  int perf_reg_validate(u64 mask)
>  {
> -       if (!mask || mask & REG_RESERVED)
> +       if (!mask || (mask & REG_NOSUPPORT))
>                 return -EINVAL;
>
>         return 0;
> @@ -96,10 +112,7 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>
>  int perf_reg_validate(u64 mask)
>  {
> -       if (!mask || mask & REG_RESERVED)
> -               return -EINVAL;
> -
> -       if (mask & REG_NOSUPPORT)
> +       if (!mask || (mask & REG_NOSUPPORT))
>                 return -EINVAL;
>
>         return 0;
> --
> 2.17.1
>
