Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D228C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB16206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 07:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRA95+Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfHAH4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:56:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35464 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfHAH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:56:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so27392683pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xW6ONCr3YPR5Tw0YltEjjNQS5d8zHOdokb5qkwZm4tw=;
        b=lRA95+Fju6L78spy1Gf8TNC7JPdddt9yOvn+uoCHcex2vkApm7EnomgOXL5J5upzq/
         /VVkbtfQOA2KKUiofGHDYlOyNqWEbvNxdKtmG0op9REABmYSC1ukK5/MOXbLjPMk9qRQ
         zmnNQ6Gyd2OR1pwemXI36fx+8xD3y3geo7oc5HjHaFEC6qT9NeoiAYOhHlauGG4ZPTTV
         FOSQX/lbr82BvG6Rhe+JYOphVeL6a9QP48fv+sp9gss+nE7FWNmt1+NjaccYpHC+BIqN
         mylwVXzVX7tp+o8GBn+oaJwX1I70E0PiRcItltB6tERG1rEQaeTQ0LscAmtyEWKHZJMS
         T5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xW6ONCr3YPR5Tw0YltEjjNQS5d8zHOdokb5qkwZm4tw=;
        b=VrH9/d/whXB6JBRBmDZO5UZ6xNr8aQOr76YIwxsghcMptgOPWv6Gfuz3UdInvM+bE8
         A6lyDVA6T6Ofy4iexp/OlUy2Ke2ckyMDX/f+GWKHFQKPl9SO0ok5T41ygRPP4c4nOmKE
         IDq4Mlq0YGXzzNz/ZZi6p30EjdLm+qwUARqUgRAv/ZtQTBvnMlYP1ljdxZkPN/AZjpJR
         yGivj/TOHGUDvJJh5YAlhQvA3tQC3oH+qwIQL4m5TtMZZ3nd8EHEa8YnAE/yl8KchII8
         UH2kxppBBDz7aCfGYOTJzPq+24mpsF6t/ERnRJkJhkiGfQTraeDgAa7sZ7eFcF/KqKjw
         Z0lg==
X-Gm-Message-State: APjAAAUa1yjGn2kqeFnjO0P22qGxiPINlSbJWM0FHMWRRbLOUfXeRNxt
        L+wppkiwmOaq0zYrXr05ZAr+jj1WbkEja+AooE0=
X-Google-Smtp-Source: APXvYqyv0sTpOr5H78CO593BreF4nyOO84llMCqqIE8YWEhjvVx+Mox1JFgtdMapYQ47eWEkEL/rkgabMmd7AFkq/jc=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr7102326pjt.16.1564646198948;
 Thu, 01 Aug 2019 00:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 1 Aug 2019 15:56:27 +0800
Message-ID: <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Drake <drake@endlessm.com>, x86@kernel.org,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 3:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 1 Aug 2019, Aubrey Li wrote:
> > On Thu, Aug 1, 2019 at 2:26 PM Daniel Drake <drake@endlessm.com> wrote:
> > > global_clock_event is NULL here. This is a "reduced hardware" ACPI
> > > platform so acpi_generic_reduced_hw_init() has set timer_init to NULL,
> > > avoiding the usual codepaths that would set up global_clock_event.
> > >
> > IIRC, acpi_generic_reduced_hw_init() avoids initializing PIT, the status of
> > this legacy device is unknown in ACPI hw-reduced mode.
> >
> > > I tried the obvious:
> > >  if (!global_clock_event)
> > >     return -1;
> > >
> > No, the platform needs a global clock event, can you turn on some other
>
> Wrong. The kernel boots perfectly fine without a global clock event. But
> for that the TSC and LAPIC frequency must be known.

I think LAPIC fast calibrate is only supported on intel platform, while
Daniel's box is an AMD platform. That's why lapic_init_clockevent() failed
and fall into the code path which needs a global clock event.

Thanks,
-Aubrey
