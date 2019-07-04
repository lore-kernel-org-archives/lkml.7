Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FB6C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00562189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rarry6Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfGDHwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:52:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45846 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGDHwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:52:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so5158188lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvNPF1w0C/lHt8cFlDsYMq1Agd3shTDcWVlw29qHYe0=;
        b=rarry6Eh+UGj2wtvqX7oBKlZLPOcek9CfKHmrRswMwJrPekFEbUAwF+dI7CTil+TAf
         BHtbCgAy2Wztu9556XAZH2zLF7NEJniBGSFk9fassdSMWA3x0iRssBkc2mvkJiXt0+bH
         k2A85JXlG+XC/NISE4qqmjjMXmqcRAS8BF51PghO+hF8mcc9NKTr0ixkq8dxcKO5lpQT
         MYwRjqAgrLPL1IZSls+AlDlI9lOqhAqZsnvsenLoCLiW2HjI+N7vwt5VPOEK/Wclabe9
         Na8wWHj6YfandgmrjNSavtNmjCSHAYRPRGM+3KPobGStaLcYNXs/KkY0+kD32mbjter5
         8KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvNPF1w0C/lHt8cFlDsYMq1Agd3shTDcWVlw29qHYe0=;
        b=HNIvs52qYHU14u2+h4Fto6VUbg30ocOriDlkmKS7SZFVYErlT/EmUoTxSRBzi7sC8F
         14SRoU21GR0vJ+RASh0C/EH310rQmDf2/gJM5bNAQJ5dlB2Jg4eATyOQH5I8YWZA3TD7
         YU4NsDA1Nfmhrc+GdNwXobqEC4VwsXRvVTkqOYVZdP3qUralGK68zYsyglXP1j0900fK
         ZNUgOC3I25b0lVtikSj6JiI3OJd86heM8xMyTwvX087XUgYnKwDX7fzMRMkmaiyNJaOS
         5zHvC+wCN8DX+4xS/3oUj9UeWRAIhujZPVgWTvXpe6p8rcLssoJLH+SXarOYbgfFBWVH
         Do4A==
X-Gm-Message-State: APjAAAXhOZ/a6WEB57BFRuxDkyHiwxbAvSPwBzRsHaGi62KBS8E7g91O
        UApw35PFEMXStb76TMoPpmToeDXm50fqxLLl04DBxA==
X-Google-Smtp-Source: APXvYqztiwxXkmmBstrAOqmsCjqAoPSovj8wAWrgmZZ6/7LRVsvTidj759pkddpLOpbhm07zZh/DJ8wwGe1EuNLxNqg=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr2103514ljs.54.1562226753487;
 Thu, 04 Jul 2019 00:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <tip-f3d705d506a2afa6c21c2c728783967e80863b31@git.kernel.org>
 <CACRpkdboWWKfaTu=TKqnZgjy4HNWr+fjmQXLBBmePsaDihkbSA@mail.gmail.com> <be57afd0-5a81-4d79-3ee4-1fb23644f424@arm.com>
In-Reply-To: <be57afd0-5a81-4d79-3ee4-1fb23644f424@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:52:21 +0200
Message-ID: <CACRpkdbgyWmMM+3L6rjpWr4Z=qu4w6cri3cv0DG51JpFd9Ej4g@mail.gmail.com>
Subject: Re: [tip:irq/core] gpio: mb86s7x: Enable ACPI support
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 3:50 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 03/07/2019 13:26, Linus Walleij wrote:
> > On Wed, Jul 3, 2019 at 11:24 AM tip-bot for Ard Biesheuvel
> > <tipbot@zytor.com> wrote:
> >
> >> Committer:  Marc Zyngier <marc.zyngier@arm.com>
> >> CommitDate: Wed, 29 May 2019 10:42:19 +0100
> >>
> >> gpio: mb86s7x: Enable ACPI support
> >>
> >> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> >> support for ACPI GPIO interrupts routed via platform interrupts, by
> >> wiring the two together via the to_irq() gpiochip callback.
> >>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >
> > OK!
> >
> >> +#include "gpiolib.h"
> >> +
> >
> > But this isn't needed anymore, is it?
>
> You tell me! ;-)
>
> > I can try to remember to remove it later though.
>
> Yeah, please send a separate patch. tip is stable, and we can't roll
> this back.

I'll just fix it in the GPIO tree after -rc1.
Made a personal TODO note!

Yours,
Linus Walleij
