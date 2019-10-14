Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A536CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 23:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8E9217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 23:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="O70o41Dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfJNXgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 19:36:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38512 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfJNXgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 19:36:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id l21so16246845edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkziEWncJFESfbeN+tNU3lnfttVx9foN0npvs9N1QsY=;
        b=O70o41Dmveei74jWdiTluAuKZOpFdp96KyP9T2+VLvoKG3708U5MU64uqWTOjJw2DI
         8fVopJbte7kdQDLDcOkGWxqOo1hPyLSGm9W5pwD9uSuKBWkYzkLQFnL0pO9rTTUkuOwv
         YEKeJM4UaS36FSYnUDagTkfYpdKCDO1v58PJtngbqG4oKmWsHirTjN3FGADnX7mMblrq
         UoC9Mmp7mBesVzhNvG+fDBUv3wy6kw0zxiKZxsynzZSe6ujfai3BCrztgADTlvkRGS6j
         L5d9t+3fpiXBswUSa0ApWFQVBYX/GhB0xFLteIF/S20CrXAf1E8aB8uFws2F6tsq2Kpp
         vUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkziEWncJFESfbeN+tNU3lnfttVx9foN0npvs9N1QsY=;
        b=Dp+Ol6ZSBmTvUy9okg3hYithnGV9ApzIyRDux3A66nkFBq3AvJmNybM4TX/rt+YVWZ
         ZPCu2Ijbv0fXYvXoPmoammBWdlQcc8eX+UadJLEzWilPSude8DKYVzTMDvKyXVI8d+Bv
         cS/MkAt7f7rH20NVcKQDsAh1uC/QdJ6l9Ttzw49e57ZxkqEXJwdNJskNp9hozWa4A5hN
         +1HAl2noYv5Zhl8dL6h96Fv7Q73cujjkP8DeWywWrnkbf85wj2BtfYVdFLGrvWUd/MOa
         Ey6/k/y2saCZZ2sR3cT8183brUl45nDWgB0MGkV4oFErr6TEMMoRIUgqY2KPZi2ojmrW
         BvQw==
X-Gm-Message-State: APjAAAWD3epEviAd4yOd1oVnVnkTY6k2h9jjIybg0Xa0ksmq4hC+RKno
        wrbd4feLHqEOL5lp0yg5J7FZ+JB4hdcM7kxCPakYeQ==
X-Google-Smtp-Source: APXvYqw21dAMS585cJditaHg7KjhOgxBh6OmUSMoHjJ0YGRuL7a8yLmdCHKtPPDp4d/BFzWCo6uVZPGvN8Y+J4yqjTw=
X-Received: by 2002:a17:906:2cca:: with SMTP id r10mr31786307ejr.108.1571096163334;
 Mon, 14 Oct 2019 16:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-16-pasha.tatashin@soleen.com> <fe5a4aae-fae3-f30f-db15-f3eced229a6e@arm.com>
In-Reply-To: <fe5a4aae-fae3-f30f-db15-f3eced229a6e@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 14 Oct 2019 19:35:51 -0400
Message-ID: <CA+CK2bBRRQsepxrWnOUOnFfPUe5SYsOurQ3kL_P1ghxze77RFQ@mail.gmail.com>
Subject: Re: [PATCH v6 15/17] arm64: kexec: add expandable argument to
 relocation function
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +struct kern_reloc_arg {
> > +     unsigned long   head;
> > +     unsigned long   entry_addr;
> > +     unsigned long   kern_arg0;
> > +     unsigned long   kern_arg1;
> > +     unsigned long   kern_arg2;
> > +     unsigned long   kern_arg3;
>
> ... at least one of these should by phys_addr_t!

OK, changed them to phys_addr_t

>
> While the sizes are the same on arm64, this reminds the reader what kind of address this
> is, and lets the compiler warn you if you make a mistake.

OK

>
>
> > +};
>
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 214685760e1c..900394907fd8 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/suspend.h>
> >  #include <linux/kbuild.h>
> >  #include <linux/arm-smccc.h>
> > +#include <linux/kexec.h>
> >
> >  int main(void)
> >  {
> > @@ -126,6 +127,14 @@ int main(void)
> >  #ifdef CONFIG_ARM_SDE_INTERFACE
> >    DEFINE(SDEI_EVENT_INTREGS, offsetof(struct sdei_registered_event, interrupted_regs));
> >    DEFINE(SDEI_EVENT_PRIORITY,        offsetof(struct sdei_registered_event, priority));
> > +#endif
> > +#ifdef CONFIG_KEXEC_CORE
> > +  DEFINE(KRELOC_HEAD,                offsetof(struct kern_reloc_arg, head));
> > +  DEFINE(KRELOC_ENTRY_ADDR,  offsetof(struct kern_reloc_arg, entry_addr));
> > +  DEFINE(KRELOC_KERN_ARG0,   offsetof(struct kern_reloc_arg, kern_arg0));
> > +  DEFINE(KRELOC_KERN_ARG1,   offsetof(struct kern_reloc_arg, kern_arg1));
> > +  DEFINE(KRELOC_KERN_ARG2,   offsetof(struct kern_reloc_arg, kern_arg2));
> > +  DEFINE(KRELOC_KERN_ARG3,   offsetof(struct kern_reloc_arg, kern_arg3));
>
> Please use kexec as the prefix. The kernel also applies relocations during early boot.
> These are global values, and in isolation doesn't imply kexec.

OK
> >  .align 3     /* To keep the 64-bit values below naturally aligned. */
> > -
> >  .Lcopy_end:
> >  .org KEXEC_CONTROL_PAGE_SIZE
> >
>
> My eyes!
>
> Please don't make unnecessary changes. Its hard enough to read the assembly, moving
> whitespace, comments and re-allocating the register guarantees that no-one can work out
> what is happening.
>
> If something needs cleaning up to make the change obvious, it needs doing as a previous
> patch. Mechanical changes are fairly easy to review.
> Functional changes behind a whirlwind of mechanical changes will cause the reviewer to
> give up.

Sure, I have split this patch into several patches, and moved
clean-ups into separate patches.

Thank you,
Pasha
