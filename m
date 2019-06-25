Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B58C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C34320656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="d8JpBEyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfFYEgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 00:36:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35472 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYEgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:36:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so11557536qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 21:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4VoluwjYn3Ks0ZIkGlg8Yc+4trodUbg3aXJYu6f9aA=;
        b=d8JpBEyr4bqLJ0bCZdULxxz6Wh0yxXPVAfduL/AaZ819HoTQMaSoA+uFWz8wU1O6Sw
         0sMt9b5su3qhSP95Dg44UzOPaJA8RzF9imxVwUeD+4aKMLVzHfUAOhR6GE1uKFKedMDX
         kgShTZ8oy5Po/Tk6nP/PmDmZWZalcc2M9gCOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4VoluwjYn3Ks0ZIkGlg8Yc+4trodUbg3aXJYu6f9aA=;
        b=aM+6UIX+m1sg2s2YsG7stDWVXaP62NkNoPKC7QmB+vVaq2of6rYJmBlOOpkBUdd5bW
         EYZ+i9MlN8V3i/LhVq+6CJF5PPUlSfRoAXRvM5z5LiXgih1oSTPUouqNcux3kp3AADTd
         qGz5gLhRDjLGmxNizmXZzh7z3rUMgkVrCpCTLte5sr1wvcdNtDYqvuQMsNVRk7Vf+Xi6
         qnu8ucamsspOW/GyWcxAmn0s6aCg/c3eYkfYpyEcXtcAKCuPi+CrZ1EQPdLQsUlUuBHb
         fEZfd3r3n6Y2+MjM0UB93hXfqzkisTQzvTh+KSRZrib0Jo+reh6rj6KtYmpQtzvfLjP3
         2BKQ==
X-Gm-Message-State: APjAAAUTXgv6zGSBTZueid4KqG1Q1e+HwJortpjLlkrWsPw2cMtGGkIX
        GD6HZnj95w7dQGIFSYfvLC8phFEFwbTQAoHSk5Y=
X-Google-Smtp-Source: APXvYqy0NjWIKEjqeTKAOAopWh+hj+cONUs6ND0MCiv0+3feFzpJJoC+Ah8VomnDUGVPq0bmEo7OH2v0Aka1lUAXGUg=
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr20459205qkn.414.1561437363245;
 Mon, 24 Jun 2019 21:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <1548090958-25908-1-git-send-email-eajames@linux.ibm.com>
 <1780173.icGFXHrAMq@townsend> <CACPK8XfqSyMB4pWLffzx+8qOj+m54h=aWUhYsKMV4TQR0fKVUg@mail.gmail.com>
In-Reply-To: <CACPK8XfqSyMB4pWLffzx+8qOj+m54h=aWUhYsKMV4TQR0fKVUg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 Jun 2019 04:35:50 +0000
Message-ID: <CACPK8Xfns=dSD5gaVJ--OkmVe7ggqF8acGsszdPqM1AqpPSAiA@mail.gmail.com>
Subject: Re: [PATCH] fsi: sbefifo: Don't fail operations when in SBE IPL state
To:     Alistair Popple <alistair@popple.id.au>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 17 Jun 2019 at 05:41, Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, 17 Jun 2019 at 02:09, Alistair Popple <alistair@popple.id.au> wrote:
> >
> > On Monday, 21 January 2019 11:15:58 AM AEST Eddie James wrote:
> > > SBE fifo operations should be allowed while the SBE is in any of the
> > > "IPL" states. Operations should succeed in this state.
> > >
> > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >
> > This fixed the problem I was having trying to issue istep operations to the
> > SBE.
> >
> > Tested-by: Alistair Popple <alistair@popple.id.au>
>
> This one slipped through the cracks.
>
> Fixes: 9f4a8a2d7f9d fsi/sbefifo: Add driver for the SBE FIFO
> Reviewed-by: Joel Stanley <joel@jsm.id.au>
>
> Greg, can you please queue this one up for 5.3?

Ping?

>
> Cheers,
>
> Joel
>
> > > ---
> > >  drivers/fsi/fsi-sbefifo.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> > > index c7d13ac..f7665b3 100644
> > > --- a/drivers/fsi/fsi-sbefifo.c
> > > +++ b/drivers/fsi/fsi-sbefifo.c
> > > @@ -290,11 +290,11 @@ static int sbefifo_check_sbe_state(struct sbefifo
> > > *sbefifo) switch ((sbm & CFAM_SBM_SBE_STATE_MASK) >>
> > > CFAM_SBM_SBE_STATE_SHIFT) { case SBE_STATE_UNKNOWN:
> > >               return -ESHUTDOWN;
> > > +     case SBE_STATE_DMT:
> > > +             return -EBUSY;
> > >       case SBE_STATE_IPLING:
> > >       case SBE_STATE_ISTEP:
> > >       case SBE_STATE_MPIPL:
> > > -     case SBE_STATE_DMT:
> > > -             return -EBUSY;
> > >       case SBE_STATE_RUNTIME:
> > >       case SBE_STATE_DUMP: /* Not sure about that one */
> > >               break;
> >
> >
