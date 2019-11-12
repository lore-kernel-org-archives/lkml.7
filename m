Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85DEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5E5206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI4WrEWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLUb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:31:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54131 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfKLUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573590685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IByCdOcsK7z2wqcglE3nDgjbdw+hHaKusrjX1MWd/k0=;
        b=GI4WrEWESI045e4WUffdSxKlM2QqkRYzcwhkogFCJWqmcHHbSQzuOFlkFMBSJ/5CgTbGvQ
        hY6baX5Vqi0nNY3C9m1ZXpx3IJ/6xzEezM0FpOjqx1Ls1Y2qBx84Yo6DO9YR/zJ2ARsSKB
        aNFrlmk9TzClZE7Vc45DUm+hBJlkDuw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-esboA5dMPd2F-Yy7M9ChXA-1; Tue, 12 Nov 2019 15:31:24 -0500
Received: by mail-lf1-f72.google.com with SMTP id o140so4265929lff.18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIQasmDACRm3A9ZstJoEy2oYlDFM8WAP33PBbVt6iPM=;
        b=YcUDP2mC5KzSwMxs3DM5cb+JJwezWesm7p36/cnB/tEa+wFjaxQabgIkRwT8FTwIrg
         FXYl1lwo1XVd8vBCn/9bp16a7PX9SZhCo5SESVegkAizZKojN1Zqo3QvtRTFRnGbB2eY
         cwPDPUtTxFriQiFU2DlOMbZTSg4pi4mrursP4JA42we3l6EhQIjVD8i/YjwcqLz1EcC4
         fueniygxLnZ7AO8IWpbErLOqUgae8NGyrEHQAa72Aa86azuWssum+OdyKVK+LAQxbTJE
         HyC6ekFqmXY6fmJ0nzkTXTXtOZQHODpsFxsXuRSDFsJIFiSrn5U0pOkFOXS0o20I+oqP
         B21Q==
X-Gm-Message-State: APjAAAVTGWKqvK3pMAJ6F6xexbTJ5T0FrABSs7PDqneQMVgTZrHOtXzk
        Xg4jDSRBiS7ehSFEhy48RkiQxh1eHbO7VNeDJ/+SJQgEN2qLG6CyZRm1CC/Yg2aTlINWNtjRZUi
        v1ZoTgyuZGx/AfbEPhqfnV4QWerZY26VYf6IwAvyy
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr19116998lfo.166.1573590680207;
        Tue, 12 Nov 2019 12:31:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIcWFUT5nlqJEHWH82BamRW6gkAt+gP4B65DcWbI3oa48KtBNMKOyThKMcfVE1uMMHjJ0kjFclKe3d0NFpOtM=
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr19116984lfo.166.1573590680032;
 Tue, 12 Nov 2019 12:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20191111233418.17676-1-jsnitsel@redhat.com> <20191112200328.GA11213@linux.intel.com>
 <CALzcddtMiSzhgZv5R6xqb1Amyk7cdY4mJdYDS86KRxH4wR_EGA@mail.gmail.com>
 <20191112202623.GB5584@ziepe.ca> <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
In-Reply-To: <CALzcddtse-4bKWaA0+ns-gVKGyQzMrYWS4n1rFpbbhKLb83z7g@mail.gmail.com>
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Tue, 12 Nov 2019 13:31:09 -0700
Message-ID: <CALzcddv2aLQ1krYFeNtWNOxyF3aSD0-p3j_p3CgS2Vx-__sQPA@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis: turn on TPM before calling tpm_get_timeouts
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-stable@vger.kernel.org,
        Christian Bundy <christianbundy@fraction.io>
X-MC-Unique: esboA5dMPd2F-Yy7M9ChXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 1:28 PM Jerry Snitselaar <jsnitsel@redhat.com> wrot=
e:
>
> On Tue, Nov 12, 2019 at 1:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Nov 12, 2019 at 01:23:33PM -0700, Jerry Snitselaar wrote:
> > > On Tue, Nov 12, 2019 at 1:03 PM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >
> > > > On Mon, Nov 11, 2019 at 04:34:18PM -0700, Jerry Snitselaar wrote:
> > > > > With power gating moved out of the tpm_transmit code we need
> > > > > to power on the TPM prior to calling tpm_get_timeouts.
> > > > >
> > > > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: linux-stable@vger.kernel.org
> > > > > Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_=
transmit()")
> > > > > Reported-by: Christian Bundy <christianbundy@fraction.io>
> > > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > >  drivers/char/tpm/tpm_tis_core.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/t=
pm_tis_core.c
> > > > > index 270f43acbb77..cb101cec8f8b 100644
> > > > > +++ b/drivers/char/tpm/tpm_tis_core.c
> > > > > @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, s=
truct tpm_tis_data *priv, int irq,
> > > > >                * to make sure it works. May as well use that comm=
and to set the
> > > > >                * proper timeouts for the driver.
> > > > >                */
> > > > > +             tpm_chip_start(chip);
> > > > >               if (tpm_get_timeouts(chip)) {
> > > > >                       dev_err(dev, "Could not get TPM timeouts an=
d durations\n");
> > > > >                       rc =3D -ENODEV;
> > > > > +                     tpm_stop_chip(chip);
> > > > >                       goto out_err;
> > > > >               }
> > > >
> > > > Couldn't this call just be removed?
> > > >
> > > > /Jarkko
> > > >
> > >
> > > Probably. It will eventually get called when tpm_chip_register
> > > happens. I don't know what the reason was for trying it prior to the
> > > irq probe.
> >
> > At least tis once needed the timeouts before registration because it
> > was issuing TPM commands to complete its setup.
> >
> > If timeouts have not been set then no TPM command should be executed.
> >
> > Jason
> >
>
> Would it function with the timeout values set at the beginning of
> tpm_tis_core_init (max values)?

I guess that doesn't set the duration values though

