Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3584DC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 06:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2B20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 06:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FO5SM9fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfHDGqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 02:46:09 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:43910 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfHDGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 02:46:09 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x746jst5012318
        for <linux-kernel@vger.kernel.org>; Sun, 4 Aug 2019 15:45:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x746jst5012318
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564901154;
        bh=je+UTj793agEnh3MYyyqsCIOZWLYGEf4dYfDOWDpCA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FO5SM9fPvl06Arttql8wxB1hDEjj5IEgmyFDl84lBoVv97Kn5I9WlawFmaKRQpnDi
         PbH+U66RAeSS/unI7f7ozY5K0HFAxa5SRTSx3IaElFgI/KC5gDiiq7JNvTOFxryX6H
         +GSKH/NY6qbEua0FSqO0HnwQl8U0Xhz2jpxASrGlQ/eyDvDptvZm3vPOXalELis/bG
         7R25gfKybDRIRsi+OWtT6EIwV5XrjWalB1kVGQyS9xZ/Y3hjzULrqIbOMfbWsvoC1X
         4C35HSBxhVT00t8PS3JZVVj6V9KNpNntJn1njFGswgwqmII8eKy9ugwOAT+eis0yCf
         PO5fjNRObcgDw==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id z13so31187511uaa.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 23:45:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXjQWZvX5aqkvx7xFPVyQIDh0sUmo2Do4baVcmHCQh7d17RLzo4
        xsQNc/mfQhJajh8zWl3298X42nAxlTMpR0JcDqI=
X-Google-Smtp-Source: APXvYqzKI/Hx6TRA6f7scptRTHyNBY3pMwnN90uTAsLNuUz61w6sEtAnmF2dUdoTwWFF8+4e9W1pVtBr+2V69c/viTA=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr74835901uaf.95.1564901153387;
 Sat, 03 Aug 2019 23:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com> <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
 <20190802181853.GA809@rikard> <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
 <CAK7LNAQv-5epL8DYDaUdHsQEQ=Va676t_6TgsaSYC30Eix=iyw@mail.gmail.com> <20190803183637.GA831@rikard>
In-Reply-To: <20190803183637.GA831@rikard>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 4 Aug 2019 15:45:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
Message-ID: <CAK7LNASBndh4yJKVdeMb7RQGopUzEUSNXPQcUgQdB8PiJetMuQ@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 3:36 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> On Sat, Aug 03, 2019 at 12:12:46PM +0900, Masahiro Yamada wrote:
> > On Sat, Aug 3, 2019 at 12:03 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >
> > >
> > > BTW, v2 is already inconsistent.
> > > If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
> > > you would have to cast (low) > (high) as well:
> > >
> > >                (unsigned long)((low) > (high)), UL(0))))
> > >
> > > This is totally redundant, and weird.
> >
> > I take back this comment.
> > You added (unsigned long) to the beginning of this macro.
> > So, the type is consistent, but I believe all casts should be removed.
>
> Maybe you're right. BUILD_BUG_ON_ZERO returns size_t regardless of
> inputs. I was worried that on some platform, size_t would be larger than
> unsigned long (as far as I could see, the standard does not give any
> guarantees), and thus all of a sudden GENMASK would be 8 bytes instead
> of 4, but perhaps that is not a problem?


How about adding (int) cast to BUILD_BUG_ON_ZERO() ?



-- 
Best Regards
Masahiro Yamada
