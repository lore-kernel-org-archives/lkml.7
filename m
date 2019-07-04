Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA2AC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B9921738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKoirI07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfGDSSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:18:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52824 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGDSSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:18:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so6538792wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOccgZnQy5hIx+UTygBn7LoMMwKQq9FVum5dh+JbdE8=;
        b=EKoirI072GmHOj8HB2RBKVdYqs6cEH8BvDM8nILLOYG6hI6Q5wx0RzDGU41F5KsaJw
         VRagy77A4oOqDf2TRo55AadtWGQOWjn7dYnWAdb1ILyYfenI2nU73ko+QdJcFCVYNfzS
         2VBLDCPqzGp3biOoNKKraK2ZFqKfNZD6+kKNEKydAligwngxauAfriDhNWu5Dpkx2/ra
         YDNtcuvI1MkExGCsNZmC0emsWLve/oxd16kl1Co723s9cdqXisypx2+eQ7du50Wsggw1
         77mzJn3LlDhEAKAtTV8kx2ruV/qzMBVGt9XHCyhJqIQYQB2hoeKZ9YB+2NqFbghyhGZZ
         rmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOccgZnQy5hIx+UTygBn7LoMMwKQq9FVum5dh+JbdE8=;
        b=QYLmw7ue/nQ81BISM8rqts7EcWRRgLUfqgirTDJb4EDYnmRHhrG2mFhDU5F+uworMA
         t4xdqkyizSjWm2fip1HAcm+zMnBE0h6Ag9rzsCxyRaWoJd5HtmGP4IX92XNhW7YPKZg/
         CU6a+VLaEPFu63GBNmmf8a6fPNgJIMTDy+MGi27S1Ju1SdBdkS1pQ2kun6qKyRZgRy9N
         rA3EQ01AKv1M05AeXRAeE9O1uzHKAAz0bWL13UnkPbOC1R6o2dWV6RN0FBROghiSmj4X
         C45fcJEBw7zXEZscLOl91vmo/wMnrzCMstcOehsi1rXrEj5DVB/4AWwogeExEQrUf1Pm
         QM6Q==
X-Gm-Message-State: APjAAAUUq9MGB8suoqLq48nz7sA6Ca2jZKeY02TIP4zRAynM1AbYseFZ
        P7JIA6Qlr7yL16mDZ5/SZRfUcysnrHlmw1EF0kzHVA==
X-Google-Smtp-Source: APXvYqxNfP87ju03Meqbw78KhYgfN2HcOA7izel91RqJkpCs3L9lcKwwZwtsYdlkaI0Dy54Q1M0YBpXHku0YgKavgh8=
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr487196wmh.136.1562264317799;
 Thu, 04 Jul 2019 11:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <tip-f3d705d506a2afa6c21c2c728783967e80863b31@git.kernel.org>
 <CACRpkdboWWKfaTu=TKqnZgjy4HNWr+fjmQXLBBmePsaDihkbSA@mail.gmail.com>
 <be57afd0-5a81-4d79-3ee4-1fb23644f424@arm.com> <CACRpkdbgyWmMM+3L6rjpWr4Z=qu4w6cri3cv0DG51JpFd9Ej4g@mail.gmail.com>
In-Reply-To: <CACRpkdbgyWmMM+3L6rjpWr4Z=qu4w6cri3cv0DG51JpFd9Ej4g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 4 Jul 2019 20:18:21 +0200
Message-ID: <CAKv+Gu_=4P=caK4mFiAf+sqnKSZciCH0w8wUp19ef4xDVLH9-w@mail.gmail.com>
Subject: Re: [tip:irq/core] gpio: mb86s7x: Enable ACPI support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
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

On Thu, 4 Jul 2019 at 09:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jul 3, 2019 at 3:50 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 03/07/2019 13:26, Linus Walleij wrote:
> > > On Wed, Jul 3, 2019 at 11:24 AM tip-bot for Ard Biesheuvel
> > > <tipbot@zytor.com> wrote:
> > >
> > >> Committer:  Marc Zyngier <marc.zyngier@arm.com>
> > >> CommitDate: Wed, 29 May 2019 10:42:19 +0100
> > >>
> > >> gpio: mb86s7x: Enable ACPI support
> > >>
> > >> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> > >> support for ACPI GPIO interrupts routed via platform interrupts, by
> > >> wiring the two together via the to_irq() gpiochip callback.
> > >>
> > >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > >
> > > OK!
> > >
> > >> +#include "gpiolib.h"
> > >> +
> > >
> > > But this isn't needed anymore, is it?
> >
> > You tell me! ;-)
> >
> > > I can try to remember to remove it later though.
> >
> > Yeah, please send a separate patch. tip is stable, and we can't roll
> > this back.
>
> I'll just fix it in the GPIO tree after -rc1.
> Made a personal TODO note!
>

Why wouldn't it be needed anymore?
