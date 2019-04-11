Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0FCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9D920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndXumORZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfDKWbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:31:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40085 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:31:50 -0400
Received: by mail-oi1-f193.google.com with SMTP id 3so6346819oir.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlqPacvTI9KENMlE3BznpG2qt0IA/SO0RkGjHSjKdhc=;
        b=ndXumORZlQoy1aLZ41GaObQvJ7bWfeKZIt4NisQEhiDK6tp4zO/Q8T6ulrIrQw9osA
         wBGKMXsO8QM2sWQm8R6lMy0vPJleFv7keaV1Xzt7/WDH+ZuIRTuoLUOHGRXc4qR4GpuV
         KFK9yM/+D48xw/8WpsdvcJA3ZniRmFFFQXyhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlqPacvTI9KENMlE3BznpG2qt0IA/SO0RkGjHSjKdhc=;
        b=BNZVL0Ca1pKz59Tx1PTnL6csosDtB1UmLvCGvU1BHMGyOzMzgjfI8L4KRTc6SeQ4Fk
         YGW77zC34TG92Fbsr21o8Wr8AH7Z5ZJOh7igMFlGtC77KkRi+s46uGkVzXD++PtFnh0M
         lc/M3XtWZ7lJbwNYyGpQ4wFGc5tnvxbPsf5u5uz3LzG3/qTL2OkzM/VwdEifHD7RmbPc
         CEcF9fA3gmfIKtc/57gFyk4Zss7PaZdmmfNL9bIOhdXbhE43wPE+XXM6+1Qg85c9LEvy
         78jYlUlLWdl/a5VoVJFwd6ZzoJ9qFHQrKCFimjdvDctpv8Pp552LiRtGBoPb6eMWsEkr
         8+Sw==
X-Gm-Message-State: APjAAAXbghKzNrueHN0pgepSgJurHu3rDSlsVOlQ9HTau7Lqt3ttX2A0
        uDdpYEf4rfJtVyISDK6pVmgvH73AySw=
X-Google-Smtp-Source: APXvYqygPxwEDiBCpiSh/0egPVNiZqmRDFsMTb4oIoO4mMq25+KqhPHDh9Or5UcYWzJqlrc8buQASg==
X-Received: by 2002:aca:c30f:: with SMTP id t15mr8007918oif.157.1555021909717;
        Thu, 11 Apr 2019 15:31:49 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id w141sm15966694oie.1.2019.04.11.15.31.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:31:49 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id f10so6706531otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 15:31:48 -0700 (PDT)
X-Received: by 2002:a05:6830:1390:: with SMTP id d16mr35738951otq.30.1555021908247;
 Thu, 11 Apr 2019 15:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190410220703.51627-1-ncrews@chromium.org> <CAFqH_52Yy8U6RFf3brOb7A0U173Z8PDcF=j9_RhwfDu0CegGYw@mail.gmail.com>
In-Reply-To: <CAFqH_52Yy8U6RFf3brOb7A0U173Z8PDcF=j9_RhwfDu0CegGYw@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 11 Apr 2019 16:31:36 -0600
X-Gmail-Original-Message-ID: <CAHX4x87+KhHGhbywP2wsmae_A8PkfMfS6nM_qD7Ysn2ovh=e+g@mail.gmail.com>
Message-ID: <CAHX4x87+KhHGhbywP2wsmae_A8PkfMfS6nM_qD7Ysn2ovh=e+g@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: wilco_ec: Add h1_gpio status to debugfs
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, alevkoy@chromium.org,
        keithshort@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments Enric! I'll resend in a day or two.

On Thu, Apr 11, 2019 at 3:43 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Nick,
>
> Some comments below ...
>
> Missatge de Nick Crews <ncrews@chromium.org> del dia dj., 11 d=E2=80=99ab=
r.
> 2019 a les 0:09:
> >
> > As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
> > tests, we need to ensure that the H1 chip is properly setting
> > some GPIO lines. The h1_gpio attribute exposes the state
> > of the lines:
> > - ENTRY_TO_FACT_MODE in BIT(0)
> > - SPI_CHROME_SEL in BIT(1)
> >
> > There are two reasons that I am exposing this in debugfs,
> > and not as a GPIO:
> > 1. This is only useful for testing, so end users shouldn't ever
> > care about this. In fact, if it passes the tests, then the value of
> > h1_gpio will always be 2, so it would be really uninteresting for users=
.
> > 2. This GPIO is not connected to, controlled by, or really even related
> > to the AP. The GPIO runs between the EC and the H1 security chip.
> >
> > Changes in v3:
> > - Fix documentation to correspond with formatting change in v2.
> > Changes in v2:
> > - Zero out the unused fields in the request.
> > - Format result as "%02x\n" instead of as a decimal.
>
> I don't really mind, but wouldn't be more clear prefix with 0x (0x%02x)?

I figured this would be easier for a program to parse, but you're right it
would be more clear. I can change it.

>
> >
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/platform/chrome/wilco_ec/debugfs.c | 64 +++++++++++++++++++++-
>
> ABI documentation missing.

Whoops, will do. The Documentation is out of date with the raw
attribute as well,
so I'll fix that too.

>
> >  1 file changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platf=
orm/chrome/wilco_ec/debugfs.c
> > index 17c4c9068aaf..1b93243c8954 100644
> > --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> > +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> > @@ -4,7 +4,7 @@
> >   *
> >   * Copyright 2019 Google LLC
> >   *
> > - * There is only one attribute used for debugging, called raw.
> > + * The raw attribute is very useful for EC debugging.
> >   * You can write a hexadecimal sentence to raw, and that series of byt=
es
> >   * will be sent to the EC. Then, you can read the bytes of response
> >   * by reading from raw.
> > @@ -30,6 +30,16 @@
> >   * Note that the first 32 bytes of the received MBOX[] will be printed=
,
> >   * even if some of the data is junk. It is up to you to know how many =
of
> >   * the first bytes of data are the actual response.
> > + *
> > + * There is also another debugfs attribute, called h1_gpio.
> > + * As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
> > + * tests, we need to ensure that the H1 chip is properly setting
> > + * some GPIO lines. The h1_gpio attribute exposes the state
> > + * of the lines:
> > + * - ENTRY_TO_FACT_MODE in BIT(0)
> > + * - SPI_CHROME_SEL in BIT(1)
> > +
> > + * Output will formatted with "%02x\n".
> >   */
> >
> >  #include <linux/ctype.h>
> > @@ -189,6 +199,56 @@ static const struct file_operations fops_raw =3D {
> >         .llseek =3D no_llseek,
> >  };
> >
> > +#define CMD_KB_CHROME          0x88
> > +#define SUB_CMD_H1_GPIO                0x0A
> > +
> > +struct h1_gpio_status_request {
> > +       u8 cmd;         /* Always CMD_KB_CHROME */
> > +       u8 reserved;
> > +       u8 sub_cmd;     /* Always SUB_CMD_H1_GPIO */
> > +} __packed;
> > +
> > +struct hi_gpio_status_response {
> > +       u8 status;      /* 0 if allowed */
> > +       u8 val;         /* BIT(0)=3DENTRY_TO_FACT_MODE, BIT(1)=3DSPI_CH=
ROME_SEL */
> > +} __packed;
> > +
> > +static ssize_t h1_gpio_read(struct file *file, char __user *user_buf,
> > +                           size_t count, loff_t *ppos)
> > +{
> > +       struct h1_gpio_status_request rq;
> > +       struct hi_gpio_status_response rs;
> > +       struct wilco_ec_message msg;
> > +       char buf[4];
> > +       int ret;
> > +
> > +       memset(&rq, 0, sizeof(rq));
> > +       rq.cmd =3D CMD_KB_CHROME;
> > +       rq.sub_cmd =3D SUB_CMD_H1_GPIO;
> > +
> > +       memset(&msg, 0, sizeof(msg));
> > +       msg.type =3D WILCO_EC_MSG_LEGACY;
> > +       msg.request_data =3D &rq;
> > +       msg.request_size =3D sizeof(rq);
> > +       msg.response_data =3D &rs;
> > +       msg.response_size =3D sizeof(rs);
> > +       ret =3D wilco_ec_mailbox(debug_info->ec, &msg);
> > +       if (ret < 0)
> > +               return ret;
> > +       if (rs.status)
> > +               return -EIO;
> > +
> > +       sprintf(buf, "%02x\n", rs.val);
> > +
> > +       return simple_read_from_buffer(user_buf, count, ppos, buf, size=
of(buf));
> > +}
> > +
> > +static const struct file_operations fops_h1_gpio =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .read =3D h1_gpio_read,
> > +       .llseek =3D no_llseek,
> > +};
> > +
>
> I think that I'd use the DEFINE_DEBUGFS_ATTRIBUTE here.

Will do.

>
> >  /**
> >   * wilco_ec_debugfs_probe() - Create the debugfs node
> >   * @pdev: The platform device, probably created in core.c
> > @@ -210,6 +270,8 @@ static int wilco_ec_debugfs_probe(struct platform_d=
evice *pdev)
> >         if (!debug_info->dir)
> >                 return 0;
> >         debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_r=
aw);
> > +       debugfs_create_file("h1_gpio", 0444, debug_info->dir, NULL,
> > +                           &fops_h1_gpio);
> >
> >         return 0;
> >  }
> > --
> > 2.20.1
> >
>
> Thanks,
>  Enric
