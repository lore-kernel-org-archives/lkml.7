Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A54C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883A621872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVUe26Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLU3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:29:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726388AbfKLU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573590542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFJkukgipNbKWN+ICsYni15SDtbEI/aVJQySVn2TvCo=;
        b=dVUe26Z0y5fFsgjXw6qr2XIfCun4xJbSQ2OAH2/q2/TObWj92CGwodofBK30jriz95a27D
        fyOS0uBwu2BdpGE/vV6jMF11+9ecVFI6K7g/rejf1FND0st/lI72FHfhcltqg3Q1sJTxsT
        pRlocFAbeqZ6OHJg4vB9BEy8ow5BG6Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-C909gJKVP_yx8nUfnGdVxg-1; Tue, 12 Nov 2019 15:29:01 -0500
Received: by mail-lf1-f72.google.com with SMTP id i25so2754103lfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QhteZ3MuQobJDpOEwpP4Wab9K3xVn23HLOglEOIOc04=;
        b=JpjUXfAN9CPNmqSmWpilgeUKHspOiUFaUrAFkcf3iORd9EJyhIeXOUBRxTs9wZSGyu
         d9odlrWcJ+MRnmkFhs/C5k6ub6uow6t9D2vNc5iPWqgVD2ZSjA/14mqL6U7Yr3GJphm6
         UQI28AfM43H3KPqR13Tl6te3+QoGgSIkq/QARPhUeXD6/Ol5GUb6uSr+exqV4YxOTO2t
         qYcEM1uo3yeOAbJNBIU7eo2WnwUzfRzfZPn4ZyrAF+ebI5iPzQu5/Nf4LJdQOcIcR3Qc
         vHCs0rzk2i//y3tOF+ObHQ4PjtOmk4hpW4gxtzoDxUPgJrptKSi/FrFC7z44RA40/j00
         p+NQ==
X-Gm-Message-State: APjAAAXyChyjv7radAAIBY3rW+X9VrKm7IspFAWRYxDbxQ2EGCEF5V0q
        f8hduNAoq08R+Ko03SuOvTAWJr3UQSOfm4wYZqb+uvppMvqhS8QIgDYD0EnR2PSQEoESuI+crBl
        NOXHOCoKf2bwn4HpABTfSPMnTv7nDxBx88M1q8yY1
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr19244262ljj.85.1573590540215;
        Tue, 12 Nov 2019 12:29:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqybXyS9y5RP5SjBRQINrW6nR2l2GW8c5yxSjUhGbQvK4JUfyEtuPFq0YyWeM2TvaVLDqvoS1yQv/md3ymu9/ZQ=
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr19244251ljj.85.1573590540042;
 Tue, 12 Nov 2019 12:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20191111233418.17676-1-jsnitsel@redhat.com> <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com> <20191112202623.GB5584@ziepe.ca>
In-Reply-To: <20191112202623.GB5584@ziepe.ca>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 12 Nov 2019 13:28:49 -0700
Message-ID: <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
X-MC-Unique: C909gJKVP_yx8nUfnGdVxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > With power gating moved out of the tpm_transmit code we need
> > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > >
> > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: linux-stable@vger.kernel.org
> > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_tr=
ansmit()")
> > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm=
_tis_core.c
> > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, str=
uct tpm_tis_data *priv, int irq,
> > > >                * to make sure it works. May as well use that comman=
d to set the
> > > >                * proper timeouts for the driver.
> > > >                */
> > > > +             tpm_chip_start(chip);
> > > >               if (tpm_get_timeouts(chip)) {
> > > >                       dev_err(dev, "Could not get TPM timeouts and =
durations\n");
> > > >                       rc =3D -ENODEV;
> > > > +                     tpm_stop_chip(chip);
> > > >                       goto out_err;
> > > >               }
> > >
> > > Couldn't this call just be removed?
> > >
> > > /Jarkko
> > >
> >
> > Probably. It will eventually get called when tpm_chip_register
> > happens. I don't know what the reason was for trying it prior to the
> > irq probe.
>
> At least tis once needed the timeouts before registration because it
> was issuing TPM commands to complete its setup.
>
> If timeouts have not been set then no TPM command should be executed.
>
> Jason
>

Would it function with the timeout values set at the beginning of
tpm_tis_core_init (max values)?

