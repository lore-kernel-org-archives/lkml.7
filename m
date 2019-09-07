Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FEAC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110F4208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cm7pAzYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405542AbfIGAHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:07:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38028 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfIGAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:07:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so4405485pgo.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZNhT2QfsXCIqag8ZGvq4zmKC24C+ReFn+9g7HQVWXY=;
        b=cm7pAzYmo6Yz1Qlr4enA4PHvACuyng/ZoUP90+WFq5sxs45XHU6wPwfdWiRboDEKgd
         gJCeMhMc5u/BxxvfMRnN94aMW403UtZj7bcIyVgyJ81psqEOQK0p9m/Bq8JgRANUVGHQ
         vPCe42iPjhJVfDHZObKm5JyNIqkpjgZi3Zck0L8vG62qa2cjV0osZJ4X9nxH/dJ3YNzc
         cu5VPZD52JDEbGMeHOprk1s+gJl8knH/ikOTMBbt12XBji2dZhZIffSW0zh/rVEbbw+h
         oGI+2lFguZ6eBPpCvbHXew1dyZRZvoVm64zCymerPWAkekkEIgc2OQmeVp/WSEwIHAJH
         jk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZNhT2QfsXCIqag8ZGvq4zmKC24C+ReFn+9g7HQVWXY=;
        b=luMtpwTq8pj8Ju1hX0ioNxqlvRYst19QNB3RwezRmwLAyem8Ur2uci8q1g7FwVdjad
         uftb1dCeyUUkjLteN7oPNCKIJ4KMY3TPamAUv/QETUX0jGBVKX2proP3XwNRAVyReWX4
         ELG8H88ORDkRHEbuiKhfdiD6VhWq6OJbQJkpTFmTwZ1HkgNbAVp+kJ7akrXdeHWUXm3Q
         RRgbdjeNUZIGNnvQ19GtdGU4+nDp4D/eHoBuCs9JeYY6FHEKvPNEpxuaI18NlgMhrzuo
         d3TcN1Q4Y6uYd/usp6DXwB2GEHyGPCvIfhcn6iu2cZRCe1zEs+XP4cA5NkZtARx2ZqlV
         uaRA==
X-Gm-Message-State: APjAAAW7as2EHymzz4BeM11XnhM/HNxQzTGdoCxkDeltMA3tEoVBVd6W
        PxM/RKQuLI6UZZFbeeedcQrCrjkq0VS+Phinvnaxyw==
X-Google-Smtp-Source: APXvYqxFV1pQoGr5/FIGI4XABYnOoJ+0P/98vmkbEuZBo7qWjvtNx+Ns6H6lNqBs/+xnaxSAjzvGwoCU73NA9S2N9Xc=
X-Received: by 2002:a65:690b:: with SMTP id s11mr10156010pgq.10.1567814828292;
 Fri, 06 Sep 2019 17:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
 <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com> <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
In-Reply-To: <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 17:06:55 -0700
Message-ID: <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 4:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 6, 2019 at 3:47 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Sedat reported (https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-520042577,
> > https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-520065525)
> > that only the bottom two hunks of that patch
> > (https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755)
>
> [ missing "matters" or something here? ]

(Yes; I must have pasted the link over it, or I'm having an episode)

>
> If fixing two of the __section() uses in that tracing header file is
> needed, then just fix all four there. I'm ok with that.

So then Miguel should maybe split off a new branch, rebase to keep
just the relevant patch
(https://github.com/ojeda/linux/commit/c97e82b97f4bba00304905fe7965f923abd2d755),
and send a PR to you for inclusion in 5.3?
-- 
Thanks,
~Nick Desaulniers
