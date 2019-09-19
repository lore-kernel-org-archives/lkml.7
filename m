Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E4CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BDF214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQXGj3gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfISDcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:32:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38420 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISDcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:32:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so1822872otl.5;
        Wed, 18 Sep 2019 20:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XLXh4xNHALuOZK8dyA3iFHDzalrZl/6foxvzoKSQZJ4=;
        b=CQXGj3gbHNXcqcdjIR6t+AnhuRdTrZKzzV1RhBswUgSyDaDBF7OpsnVVvfOUIXFkFf
         Mh/pojzQL06QOpPq32HupO8Unptfx/1TkVDfwtg3jfMuKBiq6B1S7PI8/ZJPquhWVHm9
         w0HUlQ6E/leKOgx7hdiajTvn23bosTNqVvVbKe6n4W0ej6PWPmjuxgoScyLV+Z1n2pKq
         k0UZtrPN7luNRscaLFz80HOqzZEtS2y/NsS0ZGggTN3q5h/+7BLNKZwsTXn0voARb5Xh
         O0gzkE9b6icjMDoAt+lodF2acv5nc7yc/MxSp1Zp7Ap0yt7sNqXlb3vm2fsaORKIphd4
         r6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XLXh4xNHALuOZK8dyA3iFHDzalrZl/6foxvzoKSQZJ4=;
        b=J5R7Vj97QvIPuFO7lLJ/Mt/sor0CoCLn3fUiBlS8WBSVTl6lLRSkYoi9Sp+3acPMqa
         XqDip66vYDOWEt1s0PshIdHZC8T0gQZ8FVW9tyHjKVaLwWhaXwRO8g86N6i2iQueOhkS
         nqK5+B2SWOqrxwfUNgbSpJaLwNCPbYatpL0h/UgETE+P23IpTaCiEeed52Rs08Kekcil
         5hcqsbG15PtjfztYsaMzl1baVr46fMG4vEukBKBspdvwzgQzAI2TE1RbjoWrfRrLoo5/
         PyS5YTFLpI1fTOHSC1ibnA7YEsQMQJk6ueV1CcNOOV+gpukGHMw2LNgM1ODY1OyAXuq+
         IzWw==
X-Gm-Message-State: APjAAAXCAk+tIOc9vO0XPrkbxT0D8WhdIBtfv5OqMNoPGpV6QjV0SU4Y
        Lzgos2I6EBU78in0Xrff3Zxp/VP6HerLDSq9sCE=
X-Google-Smtp-Source: APXvYqxQHk/8EEfucooDW0QXIuYL1tQAaE9sURwlyRdBwibAoGuIR16btyLoVL3eSpmvKvZqNu5Fdzul1WRH2AyIlNs=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr5023325otp.313.1568863950244;
 Wed, 18 Sep 2019 20:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
 <CAMz4kuJzYa_4TsvgdWo4nZ9ReroEf9+LCqQh4DD5jO8jfSnf3w@mail.gmail.com>
In-Reply-To: <CAMz4kuJzYa_4TsvgdWo4nZ9ReroEf9+LCqQh4DD5jO8jfSnf3w@mail.gmail.com>
From:   hhome liu <liuhhome@gmail.com>
Date:   Thu, 19 Sep 2019 11:32:19 +0800
Message-ID: <CAHshu7PFHv_i=rvxkgdmPqyego1PsEO2z4qzi4pYnWH=6LovUg@mail.gmail.com>
Subject: Re: [PATCH v2] serial: sprd: Add polling IO support
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= 
        <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linaro.org> =E4=BA=8E2019=E5=B9=B49=E6=9C=8819=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Thu, 19 Sep 2019 at 11:10, Lanqing Liu <liuhhome@gmail.com> wrote:
> >
> > In order to access the UART without the interrupts, the kernel uses
> > the basic polling methods for IO with the device. With these methods
> > implemented, it is now possible to enable kgdb during early boot over s=
erial.
> >
> > Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> > ---
> > Change from v1:
> >  - Add poll_init() support.
>
> Looks good to me and the KGDB can work well on my board, so feel free
> to add my tags:
> Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Baolin Wang <baolin.wang@linaro.org>
>
ok, thanks
> > ---
> >  drivers/tty/serial/sprd_serial.c | 33 ++++++++++++++++++++++++++++++++=
+
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 73d71a4..d833160 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -911,6 +911,34 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         }
> >  }
> >
> > +#ifdef CONFIG_CONSOLE_POLL
> > +static int sprd_poll_init(struct uart_port *port)
> > +{
> > +       if (port->state->pm_state !=3D UART_PM_STATE_ON) {
> > +               sprd_pm(port, UART_PM_STATE_ON, 0);
> > +               port->state->pm_state =3D UART_PM_STATE_ON;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int sprd_poll_get_char(struct uart_port *port)
> > +{
> > +       while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
> > +               cpu_relax();
> > +
> > +       return serial_in(port, SPRD_RXD);
> > +}
> > +
> > +static void sprd_poll_put_char(struct uart_port *port, unsigned char c=
h)
> > +{
> > +       while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
> > +               cpu_relax();
> > +
> > +       serial_out(port, SPRD_TXD, ch);
> > +}
> > +#endif
> > +
> >  static const struct uart_ops serial_sprd_ops =3D {
> >         .tx_empty =3D sprd_tx_empty,
> >         .get_mctrl =3D sprd_get_mctrl,
> > @@ -928,6 +956,11 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         .config_port =3D sprd_config_port,
> >         .verify_port =3D sprd_verify_port,
> >         .pm =3D sprd_pm,
> > +#ifdef CONFIG_CONSOLE_POLL
> > +       .poll_init      =3D sprd_poll_init,
> > +       .poll_get_char  =3D sprd_poll_get_char,
> > +       .poll_put_char  =3D sprd_poll_put_char,
> > +#endif
> >  };
> >
> >  #ifdef CONFIG_SERIAL_SPRD_CONSOLE
> > --
> > 1.9.1
> >
>
>
> --
> Baolin Wang
> Best Regards
