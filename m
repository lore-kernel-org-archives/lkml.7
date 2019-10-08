Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED835C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECA7206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="Y15T2+Cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfJHIHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:07:23 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:18361 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfJHIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:07:22 -0400
Date:   Tue, 08 Oct 2019 08:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1570522039;
        bh=R5QcdOE+v9okFkaEXqHZRwsdShwM5f79Ms4sEgcnOyA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Y15T2+CxUuF6BWDJPlMraCAKHJ8TMYE2E9bcPocRK8SfFQhXKmDkmJDMl8RN345Fg
         VLd9AdGa/KGebHXBZJaCbZpJRYjn24DrY1UhWzd5aAyOKvEMJJ26bl6IdY/Y1SJgUb
         DsQ1FTRz6QgStLnyq1ZsnivoLghigRS4+di7IEFc=
To:     Andreas Schwab <schwab@linux-m68k.org>
From:   Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Reply-To: Dmitry Goldin <dgoldin@protonmail.ch>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
Message-ID: <BbFL6w_pvJJ1heDKuGhto7sFNt-6M-GQSqysyQ75Lgd_MOwqEGzkFdhqvmcDhS27MbsEZ239tZ-1BMjC_ObkRB16jR8vS2Ri8HGJWul6wsw=@protonmail.ch>
In-Reply-To: <87zhic212y.fsf@igel.home>
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
 <874l0k3hd0.fsf@igel.home>
 <20191007115217.GA835482@kroah.com>
 <87zhic212y.fsf@igel.home>
Feedback-ID: Z14zYPZ70AFJyYagXjx-jk2Vw9RTvF5p9C9xp4Pq6DJAMFg9PDsfB7GoMmtR_dfa0BaFgToZb9Q4V0UiY2YiMQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, October 7, 2019 2:26 PM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:

> On Okt 07 2019, Greg KH gregkh@linuxfoundation.org wrote:
>
> > On Mon, Oct 07, 2019 at 01:49:47PM +0200, Andreas Schwab wrote:
> >
> > > GEN kernel/kheaders_data.tar.xz
> > > tar: unrecognized option '--sort=3Dname'
> > > Try `tar --help' or`tar --usage' for more information.
> > > make[2]: *** [kernel/kheaders_data.tar.xz] Error 64
> > > make[1]: *** [kernel] Error 2
> > > make: *** [sub-make] Error 2
> > > $ tar --version
> > > tar (GNU tar) 1.26
> > > Copyright (C) 2011 Free Software Foundation, Inc.
> >
> > Wow that's an old version of tar. 2011? What happens if you use a more
> > modern one?
>
> That's the most modern I have available on that machine.

Hmm. --sort was introduced in 1.28 in 2014. Do you think it would warrant s=
ome sort of version check and fallback or is this something we can expect t=
he user to handle if their distribution happens to not ship anything more r=
ecent? A few sensible workarounds come to mind.

In any case, likely it would make sense to at least update to https://githu=
b.com/torvalds/linux/blob/master/Documentation/process/changes.rst with the=
 minimal version we decide on.


Dmitry
