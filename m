Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C10720B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="oWQVQFEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbfHHKPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:15:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55542 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbfHHKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:15:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so1811512wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+UYL1lJMEimsIxPQMAwClByr6W4+EzjyE/vwfvpU4E=;
        b=oWQVQFExEkqD49HHdq86d/5EnT0D3srhgWm5H7g9sSxBiejIOwa876X7+OWoIkqhjO
         D7lefyGhoJayobHcSloaoBuihf/zvTN9aDM+66dCHu1k6yFDNlwPE3I9BifwnQZuOeFK
         3WT8xLSk5EH09smVEig6QEAhfXxAgnGrP/QyzT2VZosDzdycqOkjoDHTKUVLB0IhDnT7
         yGykATt9nh56o683vCj8TKfu6x9LxmARAvq3dRApE/q3QowYCEB8UFu4RLS39SodB8CA
         FWcPm0bEoBPpAnqYLRzTl6GF4HHuGSVa3IYu1rvKyfj851VYyJe2qADdyRT3B9WntHQt
         Kj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+UYL1lJMEimsIxPQMAwClByr6W4+EzjyE/vwfvpU4E=;
        b=m/Z90mZ7eyNSH08Fo5qns4lz2C6tpxhEuMJtusK8BQe5mNRxAAIk1nmG7UAZMA/3gd
         JSuVOceHhcDx8JFm5PAJqPVl0FUbKAFzZmqgH7wPUluhqJ1nlqaCnCJ+UYLE5dwWmyOk
         4CpvnwdXelwE1a8og+PU4zKjXZDK7C6jeAWKsuJVM+qY/r1ZJ0KYHe2vCDShgGEOavWO
         7dweu6zL90H6OAwaRAzH/mUJe/DJNA6iKRHJ1kfE5mZGr9xTrcpF3+TRMs966TzZHeua
         ZnyAU3+ae/PNAgtDyYJqyidubiIJO2i0yD5589MJjGcstY/1bhQKK/WbV2R1yuFQQVSj
         1U3A==
X-Gm-Message-State: APjAAAUj2Q/LV2DTlemJT/WwVpCNtQNCOmnHdNFdsvtchEMPHAJxr6VS
        Em1ayoPHE1ki7qpsj7gxIx6tzcrMr1R6apGXEV3Bxw==
X-Google-Smtp-Source: APXvYqy0QPTJxlaTBbkJSS+701e1FKbCCCoXMDsYqh5lcfzvyuvc5yqBqQonOV+TOXmh21HonrzIqoc5iJ1K4S910w0=
X-Received: by 2002:a1c:3d89:: with SMTP id k131mr3224593wma.24.1565259312766;
 Thu, 08 Aug 2019 03:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com> <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
In-Reply-To: <1565251121-28490-2-git-send-email-vincent.chen@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 8 Aug 2019 15:45:00 +0530
Message-ID: <CAAhSdy0BNN4G270WJ+OqrFAv3-z9o2iE+QDHHo-FY0fqh5wGqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: Correct the initialized flow of FP register
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 1:30 PM Vincent Chen <vincent.chen@sifive.com> wrote:
>
>   The following two reasons cause FP registers are sometimes not
> initialized before starting the user program.
> 1. Currently, the FP context is initialized in flush_thread() function
>    and we expect these initial values to be restored to FP register when
>    doing FP context switch. However, the FP context switch only occurs in
>    switch_to function. Hence, if this process does not be scheduled out
>    and scheduled in before entering the user space, the FP registers
>    have no chance to initialize.
> 2. In flush_thread(), the state of reg->sstatus.FS inherits from the
>    parent. Hence, the state of reg->sstatus.FS may be dirty. If this
>    process is scheduled out during flush_thread() and initializing the
>    FP register, the fstate_save() in switch_to will corrupt the FP context
>    which has been initialized until flush_thread().
>
>   To solve the 1st case, the initialization of the FP register will be
> completed in start_thread(). It makes sure all FP registers are initialized
> before starting the user program. For the 2nd case, the state of
> reg->sstatus.FS in start_thread will be set to SR_FS_OFF to prevent this
> process from corrupting FP context in doing context save. The FP state is
> set to SR_FS_INITIAL in start_trhead().
>
> Tested on both QEMU and HiFive Unleashed using BBL + Linux.
>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  arch/riscv/include/asm/switch_to.h |  6 ++++++
>  arch/riscv/kernel/process.c        | 13 +++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 853b65e..d5fe573 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -19,6 +19,12 @@ static inline void __fstate_clean(struct pt_regs *regs)
>         regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
>  }
>
> +static inline void fstate_off(struct task_struct *task,
> +                              struct pt_regs *regs)
> +{
> +       regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;

The SR_FS_OFF is 0x0 so no need for ORing it.

> +}
> +
>  static inline void fstate_save(struct task_struct *task,
>                                struct pt_regs *regs)
>  {
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index f23794b..e3077ee 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -64,8 +64,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>         unsigned long sp)
>  {
>         regs->sstatus = SR_SPIE;
> -       if (has_fpu)
> +       if (has_fpu) {
>                 regs->sstatus |= SR_FS_INITIAL;
> +#ifdef CONFIG_FPU
> +               /*
> +                * Restore the initial value to the FP register
> +                * before starting the user program.
> +                */
> +               fstate_restore(current, regs);
> +#endif
> +       }
>         regs->sepc = pc;
>         regs->sp = sp;
>         set_fs(USER_DS);
> @@ -75,10 +83,11 @@ void flush_thread(void)
>  {
>  #ifdef CONFIG_FPU
>         /*
> -        * Reset FPU context
> +        * Reset FPU state and context
>          *      frm: round to nearest, ties to even (IEEE default)
>          *      fflags: accrued exceptions cleared
>          */
> +       fstate_off(current, task_pt_regs(current));
>         memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
>  #endif
>  }
> --
> 2.7.4
>

Apart from above minor comment, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
