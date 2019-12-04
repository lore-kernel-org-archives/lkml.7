Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03050C0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC54E24658
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLRSP252"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfLDGNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:13:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34079 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLDGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:13:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id cx19so5581941edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 22:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87Ai/2GBcoKT6fPUij1cG0QGHCMEFL+e1yuViHU4bI0=;
        b=jLRSP252BPRHKnFzTkeVM2nQnu9zlZWlYg40vA1moDpFLFl6Gucf8MPRDDQELvBBNM
         +/rcr/9SuaeRVu7ZP0eXGTQwlhWmixr94Js1SeZQIB/MMh6Ir3RF6ErERvgyeEgn9eAF
         QRbmV+svqBfG7XHjDXEauI+urlRFyEwYGFFIg6GwtepNUX0XbNh2li/wZl6p/BFIWGjF
         8IkIJAcpgzC9Ts8w5g3dlnmxKMhgXTeSd4LGF1aPNbyAgCCU9Ye0/7D4stgLRmu5h59e
         SVt94OcmMFx6+uRMaaHzFsod952JTySKYJtfwt1IjaPq6vymOFLgdqG25hR58lTiY+7r
         W55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87Ai/2GBcoKT6fPUij1cG0QGHCMEFL+e1yuViHU4bI0=;
        b=L0gNkauw2ynRqWn3+8MdKH1i6BpOaImGj0oQ3lMcqFMY6ztoFgHgP5QE6NSfs5ar5c
         tVG9Jxd4/hTwRHop7lYeuoYtBL8/uSHXiKWzhaD4Ypw74awt6YErxJmPQIKvSJMtTOrd
         uLujp056uj0tyfkTZXMl+up3faqafne9ttClBP/XDesVHomPSt/ZruTYos1V8w1cHhlA
         DWZLfcUFRbCf2FGr+y2f/u+uFZPZ2GROhcREJuKgvM8AEMgJyL29qDockGKrmxCfi2uq
         91NcRHwVg9n6lVvQPo1M+3ijLT9PDGgPokWdU2mtS/9bQ1xCDKAaXesdqrH0G6oN6DA7
         Uj1w==
X-Gm-Message-State: APjAAAWf+ltVcoT6wjKJhsWW8MiTCh9N0SFFUInqzwtsWIVwgTxqA2/+
        fG7WqGcrb1GYYXcp5FZ7h3IUZInB6f4z8XJavbA=
X-Google-Smtp-Source: APXvYqyNIk1C2c5BxdS1lstyDxH8vHJG7tYTPiXTFdZx4gXRSNQbWhRSDSLJjVCQfC1T7Xt5x+1i+P6dpe77QNSFaNc=
X-Received: by 2002:aa7:d44a:: with SMTP id q10mr2221137edr.45.1575440014305;
 Tue, 03 Dec 2019 22:13:34 -0800 (PST)
MIME-Version: 1.0
References: <fd89d78030914d19939a1fc1c6eb5048@huawei.com> <e04e35e0a14f1507ac4a3d56899adcae@www.loen.fr>
 <c8649d75-a9b8-4680-c253-3172774ac33d@huawei.com> <c03d0b67a814288402b90bcdba600d26@www.loen.fr>
In-Reply-To: <c03d0b67a814288402b90bcdba600d26@www.loen.fr>
From:   Ivid Suvarna <ivid.suvarna@gmail.com>
Date:   Wed, 4 Dec 2019 11:43:23 +0530
Message-ID: <CABXF_AA+93p+1yVeDwmeMG3cn_2vUbvycN7TeV=8cDJ6bd8Leg@mail.gmail.com>
Subject: Re: ITS restore/save state when HCC == 0
To:     Marc Zyngier <maz@kernel.org>
Cc:     Yao HongBo <yaohongbo@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 9:46 PM Marc Zyngier <maz@kernel.org> wrote:
>
> + James, who wrote most (if not all) of the arm64 hibernate code
>
> On 2019-12-03 02:23, Yao HongBo wrote:
> > On 12/2/2019 9:22 PM, Marc Zyngier wrote:
> >> Hi Yaohongbo,
> >>
> >> In the future, please refrain from sending HTML emails, they
> >> don't render very well and force me to reformat your email
> >> by hand.
> >
> > Sorry. I'll pay attention to this next time.
> >
> >> On 2019-12-02 12:52, yaohongbo wrote:
> >>> Hi, marc.
> >>>
> >>> I met a problem with GIC ITS when I try to power off gic logic in
> >>> suspend.
> >>>
> >>> In hisilicon hip08, the value of GIC_TYPER.HCC is zero, so that
> >>> ITS_FLAGS_SAVE_SUSPEND_STATE will have no chance to be set to 1.
> >>
> >> And that's a good thing. HCC indicates that you have collections
> >> that
> >> are backed by registers, and not memory. Which means that once the
> >> GIC
> >> is powered off, the state is lost.
> >>
> >>> It goes well for s4, when I simply remove the condition judgement
> >>> in
> >>> the code.
> >>
> >> What is "s4"? Doing so means you are reprogramming the ITS with
> >> mappings
> >> that already exist in the tables, and that is UNPRED territory.
> >
> > Sorry, I didn't describe it clearly.
> > S4 means "suspend to disk".
> > In s4, The its will reinit and malloc an new its address.
>
> Huh, hibernate... Yeah, this is not expected to work, I'm afraid.
>
> > My expectation is to reprogram the ITS with original mappings. If
> > ITS_FLAGS_SAVE_SUSPEND_STATE
> > is not set, i'll have no chance to use the original its table
> > mappings.
> >
> > What should i do if i want to restore its state with hcc == 0?
>
> HCC is the least of the problems, and there are plenty more issues:
>
> - I'm not sure what guarantees that the tables are at the same
>    address in the booting kernel and the the resumed kernel.
>    That covers all the ITS tables and as well as the RDs'.
>
> - It could well be that restoring the ITS base addresses is enough
>    for everything to resume correctly, but this needs some serious
>    investigation. Worse case, we will need to replay the whole of
>    the ITS programming.
>
> - This is going to interact more or less badly with the normal suspend
>    to RAM code...
>
> - The ITS is only the tip of the iceberg. The whole of the SMMU setup
>    needs to be replayed, or devices won't resume correctly (I just tried
>    on a D05).
>
> Anyway, with the hack below, I've been able to get D05 to resume
> up to the point where devices try to do DMA, and then it was dead.
> There is definitely some work to be done there...
>
>          M.
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c
> index 4ba31de4a875..a05fc6bac203 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -27,6 +27,7 @@
>   #include <linux/of_platform.h>
>   #include <linux/percpu.h>
>   #include <linux/slab.h>
> +#include <linux/suspend.h>
>   #include <linux/syscore_ops.h>
>
>   #include <linux/irqchip.h>
> @@ -42,6 +43,7 @@
>   #define ITS_FLAGS_WORKAROUND_CAVIUM_22375     (1ULL << 1)
>   #define ITS_FLAGS_WORKAROUND_CAVIUM_23144     (1ULL << 2)
>   #define ITS_FLAGS_SAVE_SUSPEND_STATE          (1ULL << 3)
> +#define ITS_FLAGS_SAVE_HIBERNATE_STATE         (1ULL << 4)
>
>   #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING   (1 << 0)
>   #define RDIST_FLAGS_RD_TABLES_PREALLOCATED    (1 << 1)
> @@ -3517,8 +3519,16 @@ static int its_save_disable(void)
>         raw_spin_lock(&its_lock);
>         list_for_each_entry(its, &its_nodes, entry) {
>                 void __iomem *base;
> +               u64 flags;
>
> -               if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> +               if (system_entering_hibernation())
> +                       its->flags |= ITS_FLAGS_SAVE_HIBERNATE_STATE;
> +
> +               flags = its->flags;
> +               flags &= (ITS_FLAGS_SAVE_SUSPEND_STATE |
> +                         ITS_FLAGS_SAVE_HIBERNATE_STATE);
> +
> +               if (!flags)
>                         continue;
>
>                 base = its->base;
> @@ -3559,11 +3569,17 @@ static void its_restore_enable(void)
>         raw_spin_lock(&its_lock);
>         list_for_each_entry(its, &its_nodes, entry) {
>                 void __iomem *base;
> +               u64 flags;
>                 int i;
>
> -               if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
> +               flags = its->flags;
> +               flags &= (ITS_FLAGS_SAVE_SUSPEND_STATE |
> +                         ITS_FLAGS_SAVE_HIBERNATE_STATE);
> +               if (!flags)
>                         continue;
>
> +               its->flags &= ~ITS_FLAGS_SAVE_HIBERNATE_STATE;
> +
>                 base = its->base;
>
>                 /*

How about this one to reinit GIC for restore:
 - https://source.codeaurora.org/quic/la/kernel/msm-4.14/commit/drivers/irqchip/irq-gic-v3.c?h=msm-4.14&id=b0079fb73c08e195498ba2b2ea9623b0cc0f5fed
