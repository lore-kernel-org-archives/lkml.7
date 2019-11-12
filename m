Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970FC214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fzof296u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKLUXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:23:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33333 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbfKLUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573590227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sm43xd3IY5NxuGzENfU8epGVEGD0EhdYpwWq9AmG1kA=;
        b=Fzof296uzmrX4BgVeOli5nlhN57qwHjj2D6J1mVp0BBhAL7xrqzkkgCU/YMrW7d58Jrrgo
        ubs6/T23aX+nncShtn+wUSt+xuU6hdbTXcgmq1eULNdFK4x7PyRZBgwFl/BULwW8w0J+UJ
        dFgDU9QZDza6MiPEExzEMHk3EwU6gAg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-rk25ek6dO-eJ95mIE69tGA-1; Tue, 12 Nov 2019 15:23:46 -0500
Received: by mail-lf1-f72.google.com with SMTP id x16so2595940lfe.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huJzdqzI4XckJ8CuRctDocKEGaMJEuuYIpFJxV00rWg=;
        b=jypkGjkZgv0agP9o4gObfh5JKxD1bFNp9+aeQ1E8jqV/uf08XVULSx9wSWd4JCJ2zJ
         8hBaaBgrByuM1kHSOQsx6ceYoUW/vNvSexjjlKnWHTAqmwV/yayFL5ohjY/KfWxf8q6H
         d4H5kMo2P3mbeRNtX2LrkmJr5DVkIjRiMcc3G7hypMPBTA2XaT8S8Kz1S5bQUb4fFidk
         zxrxuLISODUJk7wRYDCivncjdxdyNlD2jbQqv3mfuenx/uHZqfZiuAb4ypbxotoS2XIL
         9Iz6ridsujdqEtHLMHntvusRhP8H6oDFdcyGZqbZmVkck1F4TsxDwvM+EFHWAtI5JvTF
         PJgw==
X-Gm-Message-State: APjAAAWY/RqERZhOxDv0eR9IUgYB/WPHHcQyXYYTc2ilBzvkl3BAYxEv
        eSjIag+Hc8ILRXTlX3aC3qYMm2nKNYDNepU2Q0Gqau9A2H3OdO924WBaiuSX+eqhJc0aX3hM36q
        Scw7t32VoigXqSpaHrgpu5GhcWteVH8brbIHdV2TE
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr20823217ljb.22.1573590225083;
        Tue, 12 Nov 2019 12:23:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqya3xfaP9CZmXxd5+77sxU7S+zzIIKgQp5UFFBbd/wwCS19AWFxN3a9aCXPF3CGUil3yJi6B2ALh/BCuiMZ0iE=
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr20823200ljb.22.1573590224814;
 Tue, 12 Nov 2019 12:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20191111233418.17676-1-jsnitsel@redhat.com> <20191112200328.GA11213@linux.intel.com>
In-Reply-To: <20191112200328.GA11213@linux.intel.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 12 Nov 2019 13:23:33 -0700
Message-ID: <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
X-MC-Unique: rk25ek6dO-eJ95mIE69tGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > With power gating moved out of the tpm_transmit code we need
> > to power on the TPM prior to calling tpm_get_timeouts.
> >
> > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Cc: Peter Huewe <peterhuewe@gmx.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-stable@vger.kernel.org
> > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transm=
it()")
> > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
> > index 270f43acbb77..cb101cec8f8b 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
> >                * to make sure it works. May as well use that command to=
 set the
> >                * proper timeouts for the driver.
> >                */
> > +             tpm_chip_start(chip);
> >               if (tpm_get_timeouts(chip)) {
> >                       dev_err(dev, "Could not get TPM timeouts and dura=
tions\n");
> >                       rc =3D -ENODEV;
> > +                     tpm_stop_chip(chip);
> >                       goto out_err;
> >               }
>
> Couldn't this call just be removed?
>
> /Jarkko
>

Probably. It will eventually get called when tpm_chip_register
happens. I don't know what the reason was for trying it prior to the
irq probe.

