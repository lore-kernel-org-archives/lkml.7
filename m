Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CDEC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64F62189F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="TRCdVx84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfFQFlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 01:41:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42937 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfFQFlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 01:41:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so9311698qtk.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxXch08d4fZ3Id5fmyA7W1u3b6+ZfF1CBfigkq8s2rA=;
        b=TRCdVx849aZAkqtLV02bMa4euX7m+BPENpqhvNw2fjUnqv503vwLcv+FZglI31fh1l
         v7Z3f5tFXdq40DgCRaEsk8lAGhJusVC8MHZ5Kdg7jZH4saZjScPwN4VT40GqRrDUZwRU
         CxtYX4u4qOOU6ah4mvfFwREASXybQZATZsdJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxXch08d4fZ3Id5fmyA7W1u3b6+ZfF1CBfigkq8s2rA=;
        b=a03S+owOqeJRQXb83AoyOxm9/+L3SrhSr7NaEOwnRImmWycof+6CtFp4kGLLEaSLzy
         CH3PIOLnFa7A49PP0sM6MPLfc0sdfIjttU8BBBAAXknvmTlTM46BOjiF/8Dv+Y4s+Tx2
         /VrxdQeU0KCCsb77dtDCSQohBSjV39OYV0iy10RfiaDcbqE3J5h6wWiOW7EYzkVRiAb6
         lrrOwQLfT/AUCwtHIRFGZJD19E51E3/sHGr6f3uyzT7d/PThdY9TwdQm71lWhy+mnTUG
         pQb73EDWb2j367/PZwgLTOPTZ5aQ73T7fyUP6UOp5FFPyHq1jC3NxcbbmmhT4gQ6X0ZC
         jTZQ==
X-Gm-Message-State: APjAAAVacGeCwVGcdNk/XNLIE9tz+Ug7KR719WigOjbOw5IoaTVrrzdh
        1e7unv4YViZll1FHLs+BdnVEcLNWOVwz71NPAPXQtkcxEZ4=
X-Google-Smtp-Source: APXvYqwtJ9yjwN8q8bNTEnUD+BU1xWmAf7Vp0BGjcSYK+UCjwQQ/9+zWWbU7bLlwTYKHgWELeJ9LXv2OptmtbXr91Vw=
X-Received: by 2002:ac8:2d69:: with SMTP id o38mr78635529qta.169.1560750105862;
 Sun, 16 Jun 2019 22:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <1548090958-25908-1-git-send-email-eajames@linux.ibm.com> <1780173.icGFXHrAMq@townsend>
In-Reply-To: <1780173.icGFXHrAMq@townsend>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 17 Jun 2019 05:41:34 +0000
Message-ID: <CACPK8XfqSyMB4pWLffzx+8qOj+m54h=aWUhYsKMV4TQR0fKVUg@mail.gmail.com>
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

On Mon, 17 Jun 2019 at 02:09, Alistair Popple <alistair@popple.id.au> wrote:
>
> On Monday, 21 January 2019 11:15:58 AM AEST Eddie James wrote:
> > SBE fifo operations should be allowed while the SBE is in any of the
> > "IPL" states. Operations should succeed in this state.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> This fixed the problem I was having trying to issue istep operations to the
> SBE.
>
> Tested-by: Alistair Popple <alistair@popple.id.au>

This one slipped through the cracks.

Fixes: 9f4a8a2d7f9d fsi/sbefifo: Add driver for the SBE FIFO
Reviewed-by: Joel Stanley <joel@jsm.id.au>

Greg, can you please queue this one up for 5.3?

Cheers,

Joel

> > ---
> >  drivers/fsi/fsi-sbefifo.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> > index c7d13ac..f7665b3 100644
> > --- a/drivers/fsi/fsi-sbefifo.c
> > +++ b/drivers/fsi/fsi-sbefifo.c
> > @@ -290,11 +290,11 @@ static int sbefifo_check_sbe_state(struct sbefifo
> > *sbefifo) switch ((sbm & CFAM_SBM_SBE_STATE_MASK) >>
> > CFAM_SBM_SBE_STATE_SHIFT) { case SBE_STATE_UNKNOWN:
> >               return -ESHUTDOWN;
> > +     case SBE_STATE_DMT:
> > +             return -EBUSY;
> >       case SBE_STATE_IPLING:
> >       case SBE_STATE_ISTEP:
> >       case SBE_STATE_MPIPL:
> > -     case SBE_STATE_DMT:
> > -             return -EBUSY;
> >       case SBE_STATE_RUNTIME:
> >       case SBE_STATE_DUMP: /* Not sure about that one */
> >               break;
>
>
