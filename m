Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D1FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4980D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hQ+5vfiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfJHK2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:28:36 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:60489 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJHK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:28:36 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x98ASHZG014542
        for <linux-kernel@vger.kernel.org>; Tue, 8 Oct 2019 19:28:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x98ASHZG014542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570530498;
        bh=Ro3IwQhUtN8hjL6s+IXt8h05Htw+O0E3OtIDEn/I81g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hQ+5vfiV2YicKKIWkJZx0TJhvgrlzmcjMSRMDckGKSrAyTNO5t3kHp1JwziRBkoGG
         uz7zwiWA88BeN6Kl9sKRlO0SM8mIL75AvEAsCA+0UNxbTZ+BcAdm001Bbt/t/FEVve
         odSHckdGk2M+ak2NQCdwjf+JrDGtN1zmtLW+wJY+pWbnC+pUuHDcx8Vouud8CY4OHC
         rorNvJN9WwwNKIIxCgY9brgsQTgWd9EoMslUznWORzEbgJXpCFgIWVltBiTCVoLdcV
         bPVQly57XKEeN9bTXJg3apc1lN6jPOJLWrt5RheS/ooSPddkUJU9tZ2HI5WM5e5hyn
         P5FUBEtwIsEWw==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id p189so3636996vkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:28:18 -0700 (PDT)
X-Gm-Message-State: APjAAAUeUeGg3arj82RZx8JkSKyzNof61ntob71WrKcjXvFIIscVdR9k
        h031fqI9BNafAjhYjIxLqaCA4pr2cXQ3/uSqyvw=
X-Google-Smtp-Source: APXvYqxsLps1veCDAEnQRR5QvRopT1wbxu4cRLoJ0kisOKlDpKYN9ac5fIE8dPhAHU8KojDOLd6V4a1vtEujv/5GLKk=
X-Received: by 2002:a1f:5243:: with SMTP id g64mr16756813vkb.26.1570530491980;
 Tue, 08 Oct 2019 03:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
 <874l0k3hd0.fsf@igel.home> <20191007115217.GA835482@kroah.com>
 <87zhic212y.fsf@igel.home> <BbFL6w_pvJJ1heDKuGhto7sFNt-6M-GQSqysyQ75Lgd_MOwqEGzkFdhqvmcDhS27MbsEZ239tZ-1BMjC_ObkRB16jR8vS2Ri8HGJWul6wsw=@protonmail.ch>
 <CAK7LNASwrKohUUY22Ru06DcG5nUpqRJW3ZjZR+2BZYsX8hfvJw@mail.gmail.com> <n5BwuDIsuq0djY79hLfkS_FlzIsHBcAKB9GQSvb448zSpNrSgpw9usv-UTKAIX1aRJ0ftwd_GVIGAVgp5WMWeWRd2mzP6YRg3lojH72oZuk=@protonmail.ch>
In-Reply-To: <n5BwuDIsuq0djY79hLfkS_FlzIsHBcAKB9GQSvb448zSpNrSgpw9usv-UTKAIX1aRJ0ftwd_GVIGAVgp5WMWeWRd2mzP6YRg3lojH72oZuk=@protonmail.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 8 Oct 2019 19:27:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNARhd7Ogmk8wMnDS9K=jvbBNUAZjkK66U++gGHhWLvgvww@mail.gmail.com>
Message-ID: <CAK7LNARhd7Ogmk8wMnDS9K=jvbBNUAZjkK66U++gGHhWLvgvww@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 6:54 PM Dmitry Goldin <dgoldin@protonmail.ch> wrote:
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Tuesday, October 8, 2019 10:14 AM, Masahiro Yamada <yamada.masahiro@so=
cionext.com> wrote:
>
> > On Tue, Oct 8, 2019 at 5:07 PM Dmitry Goldin dgoldin@protonmail.ch wrot=
e:
> >
> > > Hmm. --sort was introduced in 1.28 in 2014. Do you think it would war=
rant some sort of version check and fallback or is this something we can ex=
pect the user to handle if their distribution happens to not ship anything =
more recent? A few sensible workarounds come to mind.
> >
> > I think the former.
>
> After pondering it briefly, maybe substituting the option is a bit less h=
assle than checking for
> the version and then degrading to a possibly non-reproducible archive.
>
> Maybe we could go with something like the sketch below to replace --sort=
=3Dname. That is, if
> that's the only problematic flag.
>
> find $cpio_dir -printf "%P\n" | LC_ALL=3DC sort | \
>     tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
>     --owner=3D0 --group=3D0 --numeric-owner \
>     -Jcf $tarfile -C $cpio_dir/ -T - > /dev/null
>
> I will look at this a bit more closely and give it a test-run later today=
 or early tomorrow. Then we can decide if its sufficient before submitting =
another patch. Other suggestions and pointers are welcome, of course.


I am fine with this solution too.

Thanks!

--=20
Best Regards
Masahiro Yamada
