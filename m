Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF06C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDE3206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mzEhWko4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfJHIPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:15:42 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:58133 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfJHIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:15:42 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x988FR4i029233
        for <linux-kernel@vger.kernel.org>; Tue, 8 Oct 2019 17:15:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x988FR4i029233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570522528;
        bh=6LRUPwIURK4vpFJVXoCYR8axEeDiThpXYfk5FWjPS10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mzEhWko4sFkDpAbLoA9mccwk68VeIFOfbdzK9CwRbTmCRgbwr+bUllfAjuqzZ+97V
         46WBSal+9rQx2vGLyZ7sX3lyxHqq5EfgOiYfyFlUealdXP6f5WTIMtifDwUtYhvbT2
         MpVX66gRGWmWXZ+Dp5/J7jzmvPBBVaM5XHU4Ol9JTKeWNsvB2cffskHKTBmpJV7ucL
         rJGRYRc4+Bm1kA6KWqeY6bDMPDLVtemuGm+y+EKtRExC4YMeuVGmcklzUcOMbF7pLk
         fzRZNEdrjRDVBh/70womkRliWZ7gcLzrHyyks7NKvfRt921Og3WnAFkCGJtcVAEZs4
         kVZz9AnVd+wuA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id b1so10720320vsr.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 01:15:28 -0700 (PDT)
X-Gm-Message-State: APjAAAVbeBfeI8DHCP+GVN/HGuyGV0d/vZkqud7/zx3A0zBy4MnmwS4c
        VrWMaW5V6JP3dv4xqlVs2Yo3Mf/+G936YNFxIZA=
X-Google-Smtp-Source: APXvYqw7EuyrvnLMOoGms5NTByY+HQoC5ngvlYEXlL5DXYZZEq1wHXVggwi3qIN3zzbLIOmct9kDDeI/QUutWlP6pJo=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr17600348vsd.181.1570522527324;
 Tue, 08 Oct 2019 01:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
 <874l0k3hd0.fsf@igel.home> <20191007115217.GA835482@kroah.com>
 <87zhic212y.fsf@igel.home> <BbFL6w_pvJJ1heDKuGhto7sFNt-6M-GQSqysyQ75Lgd_MOwqEGzkFdhqvmcDhS27MbsEZ239tZ-1BMjC_ObkRB16jR8vS2Ri8HGJWul6wsw=@protonmail.ch>
In-Reply-To: <BbFL6w_pvJJ1heDKuGhto7sFNt-6M-GQSqysyQ75Lgd_MOwqEGzkFdhqvmcDhS27MbsEZ239tZ-1BMjC_ObkRB16jR8vS2Ri8HGJWul6wsw=@protonmail.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 8 Oct 2019 17:14:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwrKohUUY22Ru06DcG5nUpqRJW3ZjZR+2BZYsX8hfvJw@mail.gmail.com>
Message-ID: <CAK7LNASwrKohUUY22Ru06DcG5nUpqRJW3ZjZR+2BZYsX8hfvJw@mail.gmail.com>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 5:07 PM Dmitry Goldin <dgoldin@protonmail.ch> wrote:
>
> Hi,
>
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Monday, October 7, 2019 2:26 PM, Andreas Schwab <schwab@linux-m68k.org=
> wrote:
>
> > On Okt 07 2019, Greg KH gregkh@linuxfoundation.org wrote:
> >
> > > On Mon, Oct 07, 2019 at 01:49:47PM +0200, Andreas Schwab wrote:
> > >
> > > > GEN kernel/kheaders_data.tar.xz
> > > > tar: unrecognized option '--sort=3Dname'
> > > > Try `tar --help' or`tar --usage' for more information.
> > > > make[2]: *** [kernel/kheaders_data.tar.xz] Error 64
> > > > make[1]: *** [kernel] Error 2
> > > > make: *** [sub-make] Error 2
> > > > $ tar --version
> > > > tar (GNU tar) 1.26
> > > > Copyright (C) 2011 Free Software Foundation, Inc.
> > >
> > > Wow that's an old version of tar. 2011? What happens if you use a mor=
e
> > > modern one?
> >
> > That's the most modern I have available on that machine.
>
> Hmm. --sort was introduced in 1.28 in 2014. Do you think it would warrant=
 some sort of version check and fallback or is this something we can expect=
 the user to handle if their distribution happens to not ship anything more=
 recent? A few sensible workarounds come to mind.

I think the former.

The release in 2014 is quite new, so
we can not always expect it on the users' system.




>
> In any case, likely it would make sense to at least update to https://git=
hub.com/torvalds/linux/blob/master/Documentation/process/changes.rst with t=
he minimal version we decide on.
>
>
> Dmitry



--=20
Best Regards
Masahiro Yamada
