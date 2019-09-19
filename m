Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55134C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7E2214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 02:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvnklaXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfISCOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 22:14:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36158 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfISCOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 22:14:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id k20so1417803oih.3;
        Wed, 18 Sep 2019 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VBY2TI6sW6pflJ0u8FX5HSLEQmM9vGWsPIQFvfeaCg0=;
        b=tvnklaXjNaHa33RKFV4OXLDIp1FMx55Ui99DXIXTmVOtzCUVmWMy6v1nlgEYcNkWu5
         TLe0FO4yrqp5bUYF79iUDoKG2cHgtXljobj4Nh+l6f+6H85d1r119wyfspuhw3aqYG9d
         U3uWBTB9jQMKxzfxoZyrcmmpmiRil4HBLfsDyi4RD6Ca/zHnAgjhqvFHNBwNFDj/BXel
         fBB/RP4rsK8vnjF03qc8FKro0/9exEcAmuUmQtA3wJ/kp1+74AKs2E4fw5mx3nzQsWMA
         Do1c5sbBYvc7cAVrXnTVg3JIRH8oK0m+AtGxdM7+69eWAnFbeexHiT0sanPs4/3Bu7fb
         eizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VBY2TI6sW6pflJ0u8FX5HSLEQmM9vGWsPIQFvfeaCg0=;
        b=JQnUDu9VMk0HWJx61PMB+6UZwQbtbx80HmE4KqLo+Raj7k54e07P6dPyCoDCKnUn+Q
         18fz5VPJ6tyCvRWDchxlZq+OArUTJwsFBYAGDxImZkdhl1OZbtsh1sOr31gajCis7mNt
         iy434rbuc1kS6U/CqsTHHqZJeT8QBI5SLJuUiTmpHo+NANoO3laREWRSP0OKBCFKgTQM
         RZtFTPqvSCMf2LnsTCHSVwrWmJVg5XL7YoAvC7e4rmRFYH4qLbathAM8N911BHk0Aqlh
         sTIP0bcm1oYDMqxAwHGLfuZYrJuWERx/1OF4t3BzduRUpkF+ieC5WXEzg48PUh5RKw+J
         E49A==
X-Gm-Message-State: APjAAAXWZmm7j2JMknDGRHeaWrsWQsCwqvXztnuyZsUScoW/NOmogbpB
        b30/4rRy16Fhgo9cviNJFHJeJCk0gM8SIYwwMvQ=
X-Google-Smtp-Source: APXvYqz/wLAfImMW8PcbBtFygbL4scAqfazjrUNtzu7d6rj4w0qiO0yq38R1fI9Q5nWMvkFp8qU38no2eCldZqsitvw=
X-Received: by 2002:aca:4988:: with SMTP id w130mr654511oia.108.1568859282707;
 Wed, 18 Sep 2019 19:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <a634860d9194cc235298d6d8bbd2282bf6f853c4.1568793195.git.liuhhome@gmail.com>
 <CAMz4kuLrAWDaZj2Am452BX+aVO0yCQB_cCiNUx4FAamoX6KWtA@mail.gmail.com>
In-Reply-To: <CAMz4kuLrAWDaZj2Am452BX+aVO0yCQB_cCiNUx4FAamoX6KWtA@mail.gmail.com>
From:   hhome liu <liuhhome@gmail.com>
Date:   Thu, 19 Sep 2019 10:14:31 +0800
Message-ID: <CAHshu7PoJriq6R+rNzqAVrEy=mSWvu6k=83=pkRo0dNhrS1xhw@mail.gmail.com>
Subject: Re: [PATCH] serial: sprd: Add polling IO support
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

Baolin Wang <baolin.wang@linaro.org> =E4=BA=8E2019=E5=B9=B49=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Lanqing,
>
> On Wed, 18 Sep 2019 at 16:16, Lanqing Liu <liuhhome@gmail.com> wrote:
> >
> > In order to access the UART without the interrupts, the kernel uses
> > the basic polling methods for IO with the device. With these methods
> > implemented, it is now possible to enable kgdb during early boot over s=
erial.
> >
> > Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
> > ---
> >  drivers/tty/serial/sprd_serial.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 73d71a4..579ab41 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -911,6 +911,24 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         }
> >  }
> >
> > +#ifdef CONFIG_CONSOLE_POLL
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
>
> When I tested your patch, I found only one case can work if the port
> used by KGDB is same with the port selected as console, which means
> this port will be powered on all the time. We had implemented the
> power management for the UART ports, so I think you should enable the
> clock for the port used by KGDB in poll_init(), then other ports can
> be used by KGDB.
>
Yes, agree with you. I will add poll_init()  support.  Thanks for your
comments.
> > +
> >  static const struct uart_ops serial_sprd_ops =3D {
> >         .tx_empty =3D sprd_tx_empty,
> >         .get_mctrl =3D sprd_get_mctrl,
> > @@ -928,6 +946,10 @@ static void sprd_pm(struct uart_port *port, unsign=
ed int state,
> >         .config_port =3D sprd_config_port,
> >         .verify_port =3D sprd_verify_port,
> >         .pm =3D sprd_pm,
> > +#ifdef CONFIG_CONSOLE_POLL
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
