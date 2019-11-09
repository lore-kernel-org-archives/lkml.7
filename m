Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E90C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 07:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D51E21882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 07:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpMTxbz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfKIHt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 02:49:26 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43425 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 02:49:26 -0500
Received: by mail-qk1-f193.google.com with SMTP id z23so7107360qkj.10;
        Fri, 08 Nov 2019 23:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nopz6p/0eVwA5MBkjexhZJgREL2RCccF+GgtiqK2rVo=;
        b=fpMTxbz30dxR3eF4dparSCcLENWoeCgTlIuKzTPKueSzdbn5iiCY7/v3Wfhw1TOjpP
         OSVsGlvAtsWpRkLr2JQBpiiVhNvi2OH4UuYc6ctM+4aIOgIXUC+x2+/v+sKEsgz3OAQ9
         35Tuyh2NSIwEVhNBQxZ8gfnfm3G3yNFU9sSc478UDmeoU6YmoewMuM0owirN3sDXQaEA
         FJ1Zju2FXnruaMcYmtkX2TVxFbs5p/NfPwVGZ9TdkivKB+mv0NLLiL03HVNlB7wLHBla
         yThKt4f/iohKEBzeLv0BWAKHWUNcDAA302DHnHfby0ddZZJGmKnrjH1omhe7QvEC17F2
         UpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nopz6p/0eVwA5MBkjexhZJgREL2RCccF+GgtiqK2rVo=;
        b=n6S55kgNKZKu2ElktFhXn/7YD50DCqus7WgfQ9idvvYzmZ1JZUkQSOvLAZJASj88Xb
         MSEdB/QbPN2rZTCo2/B41ScXaGuhjYAW54e5eEjLNxdHdlu+zhayAPI2A+7HTFC0p81Z
         1BmY+AVHlSqTiNWhzUY5WftmHqHeF2e5Oc4/Us65Mikfr6x3/R0o5GiDUgW+p1irm+Io
         PLHIEFhr+DmHhvIP+Ac9G8agbnkj1OocNuhjJ0aeqfyV/lkmy947VDycUBBaNQZM3uhh
         UgGxry+ZgUY9xEORgGyyda0ZmNuvKJYL6Owg//4Hbkkkk6JQGTuOB0djq476UDefQcW9
         ysnA==
X-Gm-Message-State: APjAAAVsh3f+kTcDaHyPEjDLQWp9gMeKlwVhGiDlPScLWK+S8fx3y6WP
        iobzS6TkUJ1djIujnR+qvW7bbSXUFiQsCWmCy70=
X-Google-Smtp-Source: APXvYqxNo8BSzvwxPoKUCCX3oytYv/3FN0ZDO2ok1rci203Xxz6ElfWjmw6z/EEzL+dl++wpbYZvtkCkbFMB/TJWToA=
X-Received: by 2002:a05:620a:532:: with SMTP id h18mr967425qkh.41.1573285763677;
 Fri, 08 Nov 2019 23:49:23 -0800 (PST)
MIME-Version: 1.0
References: <1572749044-6091-1-git-send-email-yanghui.def@gmail.com> <20191103124201.GB619218@kroah.com>
In-Reply-To: <20191103124201.GB619218@kroah.com>
From:   hui yang <yanghui.def@gmail.com>
Date:   Sat, 9 Nov 2019 15:49:13 +0800
Message-ID: <CA+wXOo2nzANnbfFA6mHa3ZQxyA6bYgL9CM3Ykq12m_rxkRyQ4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] USB(u_serial.c): it has a NULL point
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, mirq-linux@rere.qmqm.pl,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for my fault . Now I send to everyone .

When we use USB to transmit data
with PC, the phone will crashed Low probability .
We found port->port.tty became NULL.

Thanks

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2019=E5=B9=B411=E6=9C=883=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Nov 03, 2019 at 10:44:04AM +0800, hui yang wrote:
> > From: YangHui <yanghui.def@gmail.com>
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
002a0
> > Kernel BUG at tty_wakeup+0x18/0x8c
> > [<0000000095135e9d>] tty_wakeup+0x18/0x8c
> > [<00000000c35f19e4>] gs_start_io+0xc8/0x158
> > [<00000000b11b184e>] gserial_connect+0xd0/0x174
> > [<00000000642201de>] acm_set_alt+0x70/0x180
> > [<00000000a9d38e8b>] composite_setup+0x1848/0x1a7c
> > [<0000000072c88781>] android_setup+0x1ec/0x1f4
> > [<000000004c0127a5>] msm_udc_irq+0x8d0/0xc0c
> > [<00000000f8bb9acf>] __handle_irq_event_percpu+0x74/0x294
> > [<00000000afd57256>] handle_irq_event+0x60/0xc8
> > [<0000000076719b24>] handle_fasteoi_irq+0xc8/0x1c4
> > [<00000000421f3d87>] generic_handle_irq+0x34/0x4c
> > [<00000000b2f2d343>] __handle_domain_irq+0x6c/0xbc
> > [<00000000c74325e8>] gic_handle_irq+0x6c/0xe0
> > yes,we can see the port->port.tty=3D=3DNULL, so system crashed
> >
> > Signed-off-by: YangHui <yanghui.def@gmail.com>
> > ---
> >  drivers/usb/gadget/function/u_serial.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadge=
t/function/u_serial.c
> > index 65f634e..a1c2ac2 100644
> > --- a/drivers/usb/gadget/function/u_serial.c
> > +++ b/drivers/usb/gadget/function/u_serial.c
> > @@ -562,6 +562,8 @@ static int gs_start_io(struct gs_port *port)
> >
> >       /* unblock any pending writes into our circular buffer */
> >       if (started) {
> > +             if (port->port.tty =3D=3D NULL)
> > +                     return -EIO;
>
> How can this happen?  Shouldn't this be handled earlier?
>
> If not, can you document this how this can be true and what should be
> done about it?
>
> thanks,
>
> greg k-h
