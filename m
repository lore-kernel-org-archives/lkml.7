Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BBBC3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A702C2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvJ529A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfHQJO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 05:14:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43706 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 05:14:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id h13so7089434edq.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sirr0PNWi30rC1+3FoJFRyHctdtSV+xSzXjml2UEUC4=;
        b=mvJ529A/blvAFkMU0nkpXUBqz+Yk2QjPFjBP3Sn3pBPDEC6EGRey+JFkd+viVaYzXb
         8oudACB0vsLfN2fo63EIDmVE7slQCVBLL1vrUgW9cTrxhNPQ9k5QvhhItUIycUSyCFAj
         xCk/XxFyo2O82cg/ToR2jzwSBfYlJxvXXKgocycw7Kp6Aixk1aW6HxdNmcz7Un6AZY03
         0LXD+CifY8ayqjXyDsQMH9NuyUDEZ/pf7205OnhWtdvTlWuhXUdkkXmz0lH9GbiVcRbG
         eDYoN+U44rBrE0dyd+NuYJJD8CNWDUr6Tpuncmhzpxly8nw7lNQaBswAve2VZPN3Y9Bf
         T7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sirr0PNWi30rC1+3FoJFRyHctdtSV+xSzXjml2UEUC4=;
        b=FPvBMSdjJb3iK6FU6XbXr1W9b+NwtfhX4YMP/fauixIgP/Sso3Vb+Aow0M9MRPOgIO
         qIyA3jDcMJNEOClD8cfP2wua3lDG4b45u1S9mM6ob0sne9dJvXGpfb2jKkYEDl9xXzvy
         CRwfQDMks8eI/VzNPu5PH0YUoxZWQCl9QQsgnwss9q3togBO33/bZO7BEWkJS5woJQOU
         SVB8Qn2zzz1oRynn52zqDrycJue0m1/3u+2buYhRiN4FWbgYiZaUgy+1rEjr6c5+H7vU
         K7DwJh9LwYtM5u+v5082zQqMO+qYArgvYMGhHrV/BkJnv4MTj7E3d5cmgSH2nY89moLC
         Ho2w==
X-Gm-Message-State: APjAAAVgWqvAsPhZUkC/5hozYNJDycJ4beT5c7WLDVbGbBqJpK6FPNzh
        3oRcvEx2TjhVufSsxSl/yKBr1n2ifa6MT8Bgu0E=
X-Google-Smtp-Source: APXvYqx8YnCqgmW+SJMM2KxQi7LlM/1/loQXZvtlig2ikAJSeV0lKhadRN+FfbIn1ocNg/q9kdwGfz8QG+DIlsEjpWs=
X-Received: by 2002:a17:906:2310:: with SMTP id l16mr6536483eja.0.1566033264390;
 Sat, 17 Aug 2019 02:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <1566010813-27219-1-git-send-email-huangzhaoyang@gmail.com> <20190817090021.GA10627@rapoport-lnx>
In-Reply-To: <20190817090021.GA10627@rapoport-lnx>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 17 Aug 2019 17:14:13 +0800
Message-ID: <CAGWkznGs0Y2PCowr2SDRnJrKXk08RS-sptTxhqR=6yo8G3tBnQ@mail.gmail.com>
Subject: Re: [PATCH] arch : arm : add a criteria for pfn_valid
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Berger <opendmb@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 5:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sat, Aug 17, 2019 at 11:00:13AM +0800, Zhaoyang Huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > pfn_valid can be wrong while the MSB of physical address be trimed as pfn
> > larger than the max_pfn.
>
> How the overflow of __pfn_to_phys() is related to max_pfn?
> Where is the guarantee that __pfn_to_phys(max_pfn) won't overflow?
eg, the invalid pfn value as 0x1bffc0 will pass pfn_valid if there is
a memory block while the max_pfn is 0xbffc0.
In ARM64, bellowing condition check will help to
>
> > Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
> > ---
> >  arch/arm/mm/init.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index c2daabb..9c4d938 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -177,7 +177,8 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
> >  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> >  int pfn_valid(unsigned long pfn)
> >  {
> > -     return memblock_is_map_memory(__pfn_to_phys(pfn));
> > +     return (pfn > max_pfn) ?
> > +             false : memblock_is_map_memory(__pfn_to_phys(pfn));
> >  }
> >  EXPORT_SYMBOL(pfn_valid);
> >  #endif
> > --
> > 1.9.1
> >
>
> --
> Sincerely yours,
> Mike.
>
