Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E732C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232C2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m96R2/og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDJWIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:08:09 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41462 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:08:09 -0400
Received: by mail-vk1-f194.google.com with SMTP id d15so930082vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZUME/eqLvdUZEtRyIFBAWIEyUsBbr1es25my7b+d2c=;
        b=m96R2/ogyjqbkhuFyibhS0kP4qM9WoDBUC4AuMcnCCuIlWmdRCvLyvEbKoEaFIPd8X
         ZGgBtFuVuKPt+hbhJ4xaXf2vQ0vt9yg9Yh5hTvD6KJindqFw4Z6vAEhtULTp7yrt8ZYv
         16WS9qjGABKc68v7qVhcnIL6j0fWXHAhEPpig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZUME/eqLvdUZEtRyIFBAWIEyUsBbr1es25my7b+d2c=;
        b=q+IZFOxrtjJThmzevqL8+DHRyuxirwXtBxgpCPnWW2utFKwCmC25aBorwfF9JrLvp2
         KWBTXXwKhFLkzOs9DV2/5GsTJuqBJs2smQxrltXJ8bCGlklzqUwieQ3kuP6okt8TM/nf
         3eV9SOYVw+Yh7KjmtnU332qqvt6Nqq8XXt/H8hPBxQkm1y7zjkxSZvkOdTbsoZqT6zBt
         xK8CrBL4FMCmh506eXDBFfRsI4C9wU6rRF7NZo8toCW7o6WvZZcVyFRwZzkv0/xoKbVh
         gKXs5ZPDOJqtYTTpBBi2E0Xoc8SLvcJMK1EEla/BYbP8eQRdjIzHMb+UFKdtjZK20kki
         uBQQ==
X-Gm-Message-State: APjAAAUPYqhLiPFY4Nk7x++8mBlwkQckQ2Sbei8OW4GfbqcX3IMaexEd
        D6H53kD4dIIp9OnXuPt72ILWzMse15Y=
X-Google-Smtp-Source: APXvYqw+KQwgl+yEcUqto6ISQiihuX9fhFeZN4QM/C+iJ+lEpFL9Pyd4a49tze+eaX4MVf/tQ7v7zA==
X-Received: by 2002:a1f:bcf:: with SMTP id 198mr15138078vkl.35.1554934086217;
        Wed, 10 Apr 2019 15:08:06 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id r3sm2215227vkr.18.2019.04.10.15.08.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:08:04 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id a190so2326782vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:08:04 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr26791774vsc.196.1554934084084;
 Wed, 10 Apr 2019 15:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190410212627.29514-1-okaya@kernel.org> <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org> <1603884360.3426.1554933853589.JavaMail.zimbra@efficios.com>
In-Reply-To: <1603884360.3426.1554933853589.JavaMail.zimbra@efficios.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 15:07:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+UN5ozXibFrv0OT9CftSOssCorJOu=w0Y349GV-RTZnA@mail.gmail.com>
Message-ID: <CAGXu5j+UN5ozXibFrv0OT9CftSOssCorJOu=w0Y349GV-RTZnA@mail.gmail.com>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Sinan Kaya <Okaya@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>, gor <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 3:04 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 10, 2019, at 5:53 PM, Sinan Kaya Okaya@kernel.org wrote:
>
> > On 4/10/2019 5:45 PM, Kees Cook wrote:
> >> On Wed, Apr 10, 2019 at 2:26 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>>
> >>> We can't seem to have a kernel with CONFIG_EXPERT set but
> >>> CONFIG_DEBUG_KERNEL unset these days.
> >>>
> >>> While some of the features under the CONFIG_EXPERT require
> >>> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
> >>>
> >>> The meaning of CONFIG_EXPERT and CONFIG_DEBUG_KERNEL has been
> >>> mixed here.
> >>
> >> I don't agree: the point of EXPERT is to show _everything_, which
> >> means DEBUG_KERNEL should be selected to show those options as well. I
> >> think this is fine as-is. What is the problem you want to solve?
> >>
> >> I think of it as low (nothing selected) medium (DEBUG_KERNEL) and high
> >> (EXPERT and DEBUG_KERNEL). So EXPERT enables DEBUG_KERNEL too.
> >>
> >
> > Sure, let's see if there is a better option.
> >
> > I don't want any of the debug features in my kernel but still
> > need all the expert features. My kernel is considered a production
> > kernel. I don't really want to ship all the good debug enables.
> >
> > On the other hand, I need the features under CONFIG_EXPERT to have
> > a functional system.
> >
> > Let's take "multiple users" as an example.
> >
> > What's the point of having a kernel without multiple users? :)
> >
> > I don't see the relationship between CONFIG_DEBUG and CONFIG_EXPERT
> > as none of the features except KALLSYMS depend on it. If there was
> > a compile time dependency, I'd say move it to the things that need
> > it as this patch suggests.
> >
> > P.S. I found a circular dependency now. I can respin the patch based
> > on feedback.
>
> I think part of the issue here is that a few .c/.S files use CONFIG_DEBUG_KERNEL
> as #ifdef directly, which I'm not sure was meant to be. For instance:
>
> arch/powerpc/kernel/sysfs.c:
>
> #ifdef CONFIG_DEBUG_KERNEL
> SYSFS_SPRSETUP(hid0, SPRN_HID0);
> SYSFS_SPRSETUP(hid1, SPRN_HID1);
> SYSFS_SPRSETUP(hid4, SPRN_HID4);
> SYSFS_SPRSETUP(hid5, SPRN_HID5);
> SYSFS_SPRSETUP(ima0, SPRN_PA6T_IMA0);
> SYSFS_SPRSETUP(ima1, SPRN_PA6T_IMA1);
> SYSFS_SPRSETUP(ima2, SPRN_PA6T_IMA2);
> SYSFS_SPRSETUP(ima3, SPRN_PA6T_IMA3);
> SYSFS_SPRSETUP(ima4, SPRN_PA6T_IMA4);
> SYSFS_SPRSETUP(ima5, SPRN_PA6T_IMA5);
> SYSFS_SPRSETUP(ima6, SPRN_PA6T_IMA6);
> SYSFS_SPRSETUP(ima7, SPRN_PA6T_IMA7);
> SYSFS_SPRSETUP(ima8, SPRN_PA6T_IMA8);
> SYSFS_SPRSETUP(ima9, SPRN_PA6T_IMA9);
> SYSFS_SPRSETUP(imaat, SPRN_PA6T_IMAAT);
> SYSFS_SPRSETUP(btcr, SPRN_PA6T_BTCR);
> SYSFS_SPRSETUP(pccr, SPRN_PA6T_PCCR);
> SYSFS_SPRSETUP(rpccr, SPRN_PA6T_RPCCR);
> SYSFS_SPRSETUP(der, SPRN_PA6T_DER);
> SYSFS_SPRSETUP(mer, SPRN_PA6T_MER);
> SYSFS_SPRSETUP(ber, SPRN_PA6T_BER);
> SYSFS_SPRSETUP(ier, SPRN_PA6T_IER);
> SYSFS_SPRSETUP(sier, SPRN_PA6T_SIER);
> SYSFS_SPRSETUP(siar, SPRN_PA6T_SIAR);
> SYSFS_SPRSETUP(tsr0, SPRN_PA6T_TSR0);
> SYSFS_SPRSETUP(tsr1, SPRN_PA6T_TSR1);
> SYSFS_SPRSETUP(tsr2, SPRN_PA6T_TSR2);
> SYSFS_SPRSETUP(tsr3, SPRN_PA6T_TSR3);
> #endif /* CONFIG_DEBUG_KERNEL */
>
>
> arch/mips/kernel/setup.c:
>
> #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
>                 /*
>                  * This information is necessary when debugging the kernel
>                  * But is a security vulnerability otherwise!
>                  */
>                 show_kernel_relocation(KERN_INFO);
> #endif

This one is unfortunate for sure. :P

> net/netfilter/core.c:
>
> static void hooks_validate(const struct nf_hook_entries *hooks)
> {
> #ifdef CONFIG_DEBUG_KERNEL
>         struct nf_hook_ops **orig_ops;
>         int prio = INT_MIN;
>         size_t i = 0;
>
>         orig_ops = nf_hook_entries_get_hook_ops(hooks);
>
>         for (i = 0; i < hooks->num_hook_entries; i++) {
>                 if (orig_ops[i] == &dummy_ops)
>                         continue;
>
>                 WARN_ON(orig_ops[i]->priority < prio);
>
>                 if (orig_ops[i]->priority > prio)
>                         prio = orig_ops[i]->priority;
>         }
> #endif
> }

This seems best to just always enable, neither caller appears to be fast-path.

>
> and also:
> arch/xtensa/kernel/smp.c
> arch/xtensa/kernel/entry.S
>
> I was under the impression that config DEBUG_KERNEL was only making a
> "group" of menu entries visible without any direct impact on the code,
> but it does not appear to be the case for a few exceptions. Perhaps this
> is the actual issue ? (and lack of documentation of this Kconfig entry)

Yeah, that's certainly not how it was intended. But under EXPERT, I
think there is still an argument to made that it's the right thing to
do.

-- 
Kees Cook
