Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DCCA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A9222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lr3v4oXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439052AbfJRFfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:35:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJRFfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:35:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so4726925wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b9R5y98NMKaH6jPS3dt8xcB/piVcBix4tD337dUVV+U=;
        b=lr3v4oXMaRG5gAZxgoVM3k6FFXgrbPR30EKD0XeOzoTPooPshQgi/yBeZU9Fddzbk0
         s6eQnTxY+kbK4MsX0PYmszVhgXYLC+DCYcUnrqoolsWhpgNywn7Fq30K70sVNdw91KFk
         TzaG076OeZ5IpoWli4BM2pL6chZGiBpYUuZyaBgLzmK1BIQu/2+7ifsZCooc8xO/G3WC
         HUIkK1Ijgg7FL3FTDhnof/SnW+LCZkqMCr433uM3yHy0EC+kGV46R+88Ss4W64/2e9tF
         KIPKJ4FQWeK3t4KCOZXPCgpnGY7s7MGgGHWdvkCHrHS94RLVUlLFl0L9mZ2QiRFcAf0w
         ZKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9R5y98NMKaH6jPS3dt8xcB/piVcBix4tD337dUVV+U=;
        b=aCExtKyIAZVQNjfB71I7/R1ZKMR0+7Ksdm0g2i6fzFc5AtO1H021fQwxjkOeOaoywf
         UOt1rGcSzAlBokLALDGI5+90ZI5sf3JsKPrykmjBcx4dvBDvMh1VwrS7OByoCpkboFH+
         UHiwLfo+4s12kgbvx1NbE/PXYKYUWJ/Bp7Oc9/3mEL9YYF6xCi8/MOc3bfe+6Le/Tp0O
         P6rzy1Wp6jw6ynDW3XiAXzvd7axuSthKAR52hV+jpU78SPT308zwbnn1b0bpNGSe+MGy
         NhgFwb2mwzNgBpAMQE79gGWrlJh68WtTeft76jlIY3cSPT8XtI+QTpHoHpvtyEVKKb/o
         pkBA==
X-Gm-Message-State: APjAAAVovHKV/bM0n8AnKeWoccaKM7qTjupxc8qEmtV3YQX2AidrAziv
        aLW7YMA9Zq49gAw9MXUrsmlvNsV6YQD3wt2Tiv8nCOvTiNU=
X-Google-Smtp-Source: APXvYqyTYzEZUIKg7RKPL0BwgYt3EvlXgVLixIK52nT6nnsRms//UwXq52SaF5H9Wk4WR3zS92oAobPbRNX/hWyfNjE=
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr5328686wrr.251.1571367079285;
 Thu, 17 Oct 2019 19:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191017173743.5430-1-hch@lst.de> <20191017173743.5430-3-hch@lst.de>
In-Reply-To: <20191017173743.5430-3-hch@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:21:08 +0530
Message-ID: <CAAhSdy27==MERM6H1dL4L_vndgSQcwyise=+_ER3kXHxEh9PYw@mail.gmail.com>
Subject: Re: [PATCH 02/15] riscv: cleanup do_trap_break
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:07 PM Christoph Hellwig <hch@lst.de> wrote:
>
> If we always compile the get_break_insn_length inline function we can
> remove the ifdefs and let dead code elimination take care of the warn
> branch that is now unreadable because the report_bug stub always
> returns BUG_TRAP_TYPE_BUG.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/kernel/traps.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 1ac75f7d0bff..10a17e545f43 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -111,7 +111,6 @@ DO_ERROR_INFO(do_trap_ecall_s,
>  DO_ERROR_INFO(do_trap_ecall_m,
>         SIGILL, ILL_ILLTRP, "environment call from M-mode");
>
> -#ifdef CONFIG_GENERIC_BUG
>  static inline unsigned long get_break_insn_length(unsigned long pc)
>  {
>         bug_insn_t insn;
> @@ -120,28 +119,15 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
>                 return 0;
>         return (((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL);
>  }
> -#endif /* CONFIG_GENERIC_BUG */
>
>  asmlinkage void do_trap_break(struct pt_regs *regs)
>  {
> -       if (user_mode(regs)) {
> -               force_sig_fault(SIGTRAP, TRAP_BRKPT,
> -                               (void __user *)(regs->sepc));
> -               return;
> -       }
> -#ifdef CONFIG_GENERIC_BUG
> -       {
> -               enum bug_trap_type type;
> -
> -               type = report_bug(regs->sepc, regs);
> -               if (type == BUG_TRAP_TYPE_WARN) {
> -                       regs->sepc += get_break_insn_length(regs->sepc);
> -                       return;
> -               }
> -       }
> -#endif /* CONFIG_GENERIC_BUG */
> -
> -       die(regs, "Kernel BUG");
> +       if (user_mode(regs))
> +               force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->sepc);
> +       else if (report_bug(regs->sepc, regs) == BUG_TRAP_TYPE_WARN)
> +               regs->sepc += get_break_insn_length(regs->sepc);
> +       else
> +               die(regs, "Kernel BUG");
>  }
>
>  #ifdef CONFIG_GENERIC_BUG
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
