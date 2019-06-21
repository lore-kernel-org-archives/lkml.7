Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4346AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125C82089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1uawYuat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfFUQ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:58:46 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30028 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:58:46 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x5LGwQCk013255
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 01:58:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x5LGwQCk013255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561136307;
        bh=BdGlYHfhJn0WnD4j8rj3j0Dpi7bkUswm7gLUuW2VoBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1uawYuatNdqEqxzcJpgQW/gvsybkA6Ru4SsyggVJAXjQslufFjMtq4AlphsSdE6Jj
         TPc+JfVJOQLXuhkJ3ClXJbarN6pg8Z4A2lpf3RwZM/TMT2TNakvusNat9c0Ona3zfc
         2Xz+X/iepW2zl0IWoMIXlE5iF4GmJC3JHZk9jO70kDzD8PBB0iD1UJzSPA2KRwrqnF
         QuBVevl16he/A1o1rE2Fkjqb6sAiPcTxDFHkOanpCBIb24zVzk9Rv1H14VqD1zddyV
         MAhKQBjd9Bi4NyIH1ah9SsaTm+Lix+m5LcmSrAv8825JopeEm7XR6weJnbVQspCM+K
         /oW4Mex8JgFMA==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id o19so3184076uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:58:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWwuusnil8vYVFWOaJsZhHlp4FI5CHp5x1te/ELnZRMcFPH6pWJ
        URnbFdrBxUTGrhmsqUfzg9ffIo1jJoFGexFHsQc=
X-Google-Smtp-Source: APXvYqynjTsOBby/fwoXbj0npyktZc+1wLFGdI9BsLVjzp1gJwjGqgGJv0WpCwLjiHLXKxj5mqMFlE2d7ItZhUSMS88=
X-Received: by 2002:ab0:2b0a:: with SMTP id e10mr43253033uar.109.1561136305833;
 Fri, 21 Jun 2019 09:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190618131048.543-1-will.deacon@arm.com> <CAK8P3a3phkiL8LFQM_AewMCE0EpQaCTOmgkVJe4x9oV84F4_7g@mail.gmail.com>
 <20190618162021.GA4270@fuggles.cambridge.arm.com>
In-Reply-To: <20190618162021.GA4270@fuggles.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 22 Jun 2019 01:57:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRMnovWQA0F8A6mEqDjPxXOGM-1AHoyh1gQa367f+FqQ@mail.gmail.com>
Message-ID: <CAK7LNAQRMnovWQA0F8A6mEqDjPxXOGM-1AHoyh1gQa367f+FqQ@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Teach parser about 128-bit built-in types
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 1:21 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Arnd,
>
> On Tue, Jun 18, 2019 at 04:17:35PM +0200, Arnd Bergmann wrote:
> > On Tue, Jun 18, 2019 at 3:10 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > +       { "__int128", BUILTIN_INT_KEYW },
> > > +       { "__int128_t", BUILTIN_INT_KEYW },
> > > +       { "__uint128_t", BUILTIN_INT_KEYW },
> >
> > I wonder if it's safe to treat them as the same type, since
> > __int128_t and __uint128_t differ in signedness.
> >
> > If someone exports a symbol with one and changes it to the other, they
> > would appear to be the same type.
>
> My understanding is that the actual CRC generation for normal symbols is
> based purely on the string-representation of the function signature, and
> so the underlying type information isn't relevant to that. I can also
> confirm that the CRC for an exported symbol that returns a __uint128_t
> is not the same if you change it to return a __int128_t instead.

Right.
Applied to linux-kbuild. Thanks!


-- 
Best Regards
Masahiro Yamada
