Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E03C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA0206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi34POsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCTzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:55:07 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46250 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:55:07 -0400
Received: by mail-io1-f68.google.com with SMTP id b9so15132264iot.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 12:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5JDg9BE8i0v0GIx9r1uZtuJoaGtNDxpmI6KlMDrFxrA=;
        b=mi34POsivnv8cmQd1Rl9sRFDAyRzQh/WDG5gkdX+RuSRoz8vquTIWYrlUy5xuJ9G/e
         510FKE51QrGKsOumdroKw5UniuFaxRiN93CnwUmdPLSyOvixtxquHQw80V8h9i8Uie60
         AJCzfFEMCp7mGX7bh+sVgvQjJXi/RRAvx89R8zV4kt2UYsiA8WXHleeHzoLCmpGE8Azl
         zL15EDFF5iYRwa8+637C6ZPbc8zBPGdue2FM4pXAcHlC+/2mTXVYEh4XSlEKuLo5Ytj1
         d/aJGgz+GThyKjW/Q4dUTfjaMPQuxoDt/TrgZoq5orToLSjEqCZcTQYy62gcN5HnRmqS
         vBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5JDg9BE8i0v0GIx9r1uZtuJoaGtNDxpmI6KlMDrFxrA=;
        b=F56ldq+9Qui15a/fWxTzd8odI3eBge4S20uq/3C5jgjVmg7Z7EbOrk4C2WGEiLvqeF
         RLEDOWdQuEQFuwqwhoE4XmYIOu47C83mrkfgztSheqejkRrTX12cEgPIegAe/q3Qu2qo
         gWIbASWmXOL+SRHULhNZD84Cng2ADOZhqPBOAoD1w5uJ2KzlwQCc7qHaBbxwrWV/hTFD
         z6gTpvBnW5Vdv+5ENJCSxPnDLYBhrpVEMsvuqGk2j3rKicmh/CqMiPEcg/ASuxfvaMht
         BpVIuCBbD3Af+lrNzUucKODsE90LQJzKYprS4GTt7dVAwAgINYBbhNyZIJR0KbEs7ZOs
         QoGg==
X-Gm-Message-State: APjAAAWtGaJbmjRtuWFBQFs6M81YxQ1xAgWd6F/jwkbFjV1NdXInwXiZ
        bjAgq+3zYR8QxndnKndPqZIfXFdcsRrN70U9RJVttA==
X-Google-Smtp-Source: APXvYqw09X0gvPVnwM61uq/k+1ZLqoAWn4Mo9zoXhswuMX5/ucvn4fKoWrvBMSfiRHufXoRz3uDoGQjEhmTceswCpB0=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr1568313iod.10.1554321306080;
 Wed, 03 Apr 2019 12:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190403183048.56750-1-egranata@chromium.org> <CABXOdTfvRryiMrFAe4wmvt5mm2k==b1BShbzHQ68vp5C3NFETA@mail.gmail.com>
 <CAPR809vTZSFtNp61WQsOFRkFacO_8XEdicqFq9uYMkUMdjEsqg@mail.gmail.com> <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
In-Reply-To: <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
From:   Enrico Granata <egranata@google.com>
Date:   Wed, 3 Apr 2019 12:54:55 -0700
Message-ID: <CAPR809tbp_vHUNOprsosHnDm2fvThDsUY3Q4Zp9jQvVyX2=wTw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: check for NULL transfer function
To:     Guenter Roeck <groeck@google.com>
Cc:     Enrico Granata <egranata@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because I did not know about it till right now. Thanks for the
suggestion. Will upload a v2 as soon as I get a chance.

On Wed, Apr 3, 2019 at 12:53 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Wed, Apr 3, 2019 at 12:40 PM Enrico Granata <egranata@google.com> wrot=
e:
> >
> > I can certainly add a "did_print_error" flag or some such, but in pract=
ice, if the transfer function is NULL, the initial handshake will fail, and=
 this will in turn cause EC registration to fail, and no further communicat=
ion should occur, so no further log entries will be printed.
> >
> Sorry, I am a bit lost. Why would dev_err_once() not work ?
>
> Guenter
>
> > Thanks
> >
> > Enrico Granata | egranata@google.com | ChromeOS | MTV1600
> >
> >
> > On Wed, Apr 3, 2019 at 11:51 AM Guenter Roeck <groeck@google.com> wrote=
:
> >>
> >> On Wed, Apr 3, 2019 at 11:31 AM <egranata@chromium.org> wrote:
> >> >
> >> > From: Enrico Granata <egranata@chromium.org>
> >> >
> >> > As new transfer mechanisms are added to the EC codebase, they may
> >> > not support v2 of the EC protocol.
> >> >
> >> > If the v3 initial handshake transfer fails, the kernel will try
> >> > and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
> >> > will be NULL, and the code will end up causing a kernel panic.
> >> >
> >> > Add a check for NULL before calling the transfer function, along
> >> > with a helpful comment explaining how one might end up in this
> >> > situation.
> >> >
> >> > Signed-off-by: Enrico Granata <egranata@chromium.org>
> >> > ---
> >> >  drivers/platform/chrome/cros_ec_proto.c | 10 ++++++++++
> >> >  1 file changed, 10 insertions(+)
> >> >
> >> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platf=
orm/chrome/cros_ec_proto.c
> >> > index 97a068dff192d..953076ab401aa 100644
> >> > --- a/drivers/platform/chrome/cros_ec_proto.c
> >> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> >> > @@ -56,6 +56,16 @@ static int send_command(struct cros_ec_device *ec=
_dev,
> >> >         else
> >> >                 xfer_fxn =3D ec_dev->cmd_xfer;
> >> >
> >> > +       if (xfer_fxn =3D=3D NULL) {
> >> > +               /* This error can happen if a communication error ha=
ppened and
> >> > +                * the EC is trying to use protocol v2, on an underl=
ying
> >> > +                * communication mechanism that does not support v2.
> >> > +                */
> >>
> >> I am not personally a friend of networking-style multi-line comments.
> >>
> >> > +               dev_err(ec_dev->dev,
> >> > +                       "missing EC transfer API, cannot send comman=
d\n");
> >>
> >> That message will be displayed each time a message is sent, ie in
> >> practice for each message. Is there any value in that, other than
> >> clogging the log ?
> >>
> >> Guenter
> >>
> >> > +               return -EIO;
> >> > +       }
> >> > +
> >> >         ret =3D (*xfer_fxn)(ec_dev, msg);
> >> >         if (msg->result =3D=3D EC_RES_IN_PROGRESS) {
> >> >                 int i;
> >> > --
> >> > 2.21.0.392.gf8f6787159e-goog
> >> >
