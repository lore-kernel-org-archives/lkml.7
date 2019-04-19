Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9EC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184B920645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8/fKWOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfDSTAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:00:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35112 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfDSTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:00:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so4619803oib.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqNxZXmlm4MIVjXTC42lHvMb9a4inc1EZnreGHLRsCc=;
        b=L8/fKWOOVqAKNWaGAuNxuTdzRsmXnhHeg7hnkg1gl/EF4JhnjcDVmRpE4+8GfN6Tez
         5NOQakDiekNYChq2hDtIn/LdKqnbv+cz2arqZhLvwZFXJNmVkFyCMVTySiAtUhxmiKI0
         0FskFXWmYN0Hb/kPz++IrWdljsF4yJDUr14nblZajOxg+1MiHmRMYltM033CuygWwlxP
         C0UvdONla4IqRTHOireSisUWoFr9AeoXa40SclMNuOmULzXk2QohWxCc38Y292hX3q9Z
         BpjkEOpo6FT7aP72UYn66v7tPhPr/6ClyZzb64AzJnOT0Mxg5JVBeHbdNwsEkwaEMotU
         2ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqNxZXmlm4MIVjXTC42lHvMb9a4inc1EZnreGHLRsCc=;
        b=Og/M6bcvgRaUo8ibV66KElRWP4zJnD2Ke/aXexr2Y1nx2uJ9fsag1eNP/vf5jIWHW3
         FLgd3aFo/x0JxxQoFTysgUjmj2HGporcvb4O3ILgRibvUlr5EAYWT79F8eWlH646/bGj
         2u4CaIRhaRZmrbFrSFkNoIrlQIjXokFebKLCobUoMU9Dz1jtUHvesqChZTVA3vtVFAZA
         M06kqhwDB1LcN6ytnhOlmeRp1kNQcwtcGm0JjSqJ+2qRxuJPqbbIPoOdqUlYK9Rgsccf
         BISyHCKjyNXWBb5FJWCAaGnSRwP8NL2a8UFxZpw5trVSz0Jh4jdVi/sHYMNLaqVNCSYD
         WAMA==
X-Gm-Message-State: APjAAAW7CDRV5ZlQUguaGx0TjQo+QvZCA6yQIb39f+xwPy/oFxBe8AUP
        n+NQSW5/1jl6TznYpQqobo0qxbR9csAhAscZWxmWGYuo9H0=
X-Google-Smtp-Source: APXvYqwvFWwb2YOnYu3OdNbVyiSkEteaaxZdUMNUbCC5Yi/yhNb7t0R73FpQNME8ehdwjD4WOmIlEQC5lMoRUMxa9P0=
X-Received: by 2002:aca:c154:: with SMTP id r81mr1745885oif.160.1555680815113;
 Fri, 19 Apr 2019 06:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <1555669363-19782-1-git-send-email-bhanusreemahesh@gmail.com> <20190419112232.GB14886@kroah.com>
In-Reply-To: <20190419112232.GB14886@kroah.com>
From:   Bhanusree Mahesh <bhanusreemahesh@gmail.com>
Date:   Fri, 19 Apr 2019 19:02:47 +0530
Message-ID: <CAB0Mk-M72dSoT4y7_JfOA6M8TNeGsRoTH5MpX9zwr1h8KPdjUg@mail.gmail.com>
Subject: Re: [PATCH] Staging: rtl8723bs: core: Replace rtw_malloc with kmalloc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 at 16:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 19, 2019 at 03:52:43PM +0530, Bhanusree Pola wrote:
> > Replace rtw_malloc with kmalloc to make code OS independent
> > use kmalloc second argument as GFP_ATOMIC as these are called by functions
> > that holds lock.
> >
> > Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > index 18fabf5..6a6683c 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> > @@ -128,7 +128,7 @@ static void update_BCNTIM(struct adapter *padapter)
> >               }
> >
> >               if (remainder_ielen > 0) {
> > -                     pbackup_remainder_ie = rtw_malloc(remainder_ielen);
> > +                     pbackup_remainder_ie = kmalloc(remainder_ielen,GFP_ATOMIC);
>
> Always run checkpatch.pl on your patches so you do nto get grumpy
> maintainers telling you to run checkpatch.pl on your code :)

>
> Why not fix up all of the callers of this function?

There are many callers of this function. Should I send the whole thing
as of patch series?

>And are you sure
> that GFP_ATOMIC is the correct thing to do here?

yes, because it is called by the function which holds the lock.
correct me if I'm wrong.

>
> thanks,
>
> greg k-h
