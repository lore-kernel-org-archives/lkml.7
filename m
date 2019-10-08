Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA60C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802C2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="J87nWh58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfJHJyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:54:53 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:21640 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbfJHJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:54:53 -0400
Date:   Tue, 08 Oct 2019 09:54:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1570528490;
        bh=xaYziXcn3PAogMjdsVmux+RpIIeoIUGVyhfe2ngISyU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=J87nWh58/WbHccqw04w1aFW617Wn/Y3uSdwQzjpiLOjEXCHPITPvPGKTxof3gNKZP
         E0PIAz9EHOSiK6dBoqI2ka1HMswUGC4giG5LT9bFLSsxrAiUSmk8jlhN79dpNJNBCz
         xRj+NJFVBq1WL3/toghW6kw1f6j0b69ehIuV79y4=
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Reply-To: Dmitry Goldin <dgoldin@protonmail.ch>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
Message-ID: <n5BwuDIsuq0djY79hLfkS_FlzIsHBcAKB9GQSvb448zSpNrSgpw9usv-UTKAIX1aRJ0ftwd_GVIGAVgp5WMWeWRd2mzP6YRg3lojH72oZuk=@protonmail.ch>
In-Reply-To: <CAK7LNASwrKohUUY22Ru06DcG5nUpqRJW3ZjZR+2BZYsX8hfvJw@mail.gmail.com>
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
 <874l0k3hd0.fsf@igel.home>
 <20191007115217.GA835482@kroah.com>
 <87zhic212y.fsf@igel.home>
 <BbFL6w_pvJJ1heDKuGhto7sFNt-6M-GQSqysyQ75Lgd_MOwqEGzkFdhqvmcDhS27MbsEZ239tZ-1BMjC_ObkRB16jR8vS2Ri8HGJWul6wsw=@protonmail.ch>
 <CAK7LNASwrKohUUY22Ru06DcG5nUpqRJW3ZjZR+2BZYsX8hfvJw@mail.gmail.com>
Feedback-ID: Z14zYPZ70AFJyYagXjx-jk2Vw9RTvF5p9C9xp4Pq6DJAMFg9PDsfB7GoMmtR_dfa0BaFgToZb9Q4V0UiY2YiMQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, October 8, 2019 10:14 AM, Masahiro Yamada <yamada.masahiro@soci=
onext.com> wrote:

> On Tue, Oct 8, 2019 at 5:07 PM Dmitry Goldin dgoldin@protonmail.ch wrote:
>
> > Hmm. --sort was introduced in 1.28 in 2014. Do you think it would warra=
nt some sort of version check and fallback or is this something we can expe=
ct the user to handle if their distribution happens to not ship anything mo=
re recent? A few sensible workarounds come to mind.
>
> I think the former.

After pondering it briefly, maybe substituting the option is a bit less has=
sle than checking for
the version and then degrading to a possibly non-reproducible archive.

Maybe we could go with something like the sketch below to replace --sort=3D=
name. That is, if
that's the only problematic flag.

find $cpio_dir -printf "%P\n" | LC_ALL=3DC sort | \
    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
    --owner=3D0 --group=3D0 --numeric-owner \
    -Jcf $tarfile -C $cpio_dir/ -T - > /dev/null

I will look at this a bit more closely and give it a test-run later today o=
r early tomorrow. Then we can decide if its sufficient before submitting an=
other patch. Other suggestions and pointers are welcome, of course.

--
Best regards,
    Dmitry
