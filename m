Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A250C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AAE20665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKHRDl7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfHAPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:23:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40937 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbfHAPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:23:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so69518201eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=npl7N80MmZBIHx6RTeaJpSZSlY3/u9gRYYg1tmf3W0Q=;
        b=EKHRDl7gAACsadCtqApsW+xXKEyXy5TbF2hEya+9SJVGhWvdKErwWg0R1cXBf+CKt1
         w7APcxQkvYMxwTGWsc/ZOx4E4pyvXrJrGjAGoK8l5S/bV7VsdctbeWXRKQSvwXeY6pyw
         E7QLS7ymeG/YpP18y+Ee9XFPZlf7LlOwDo2gBk+smhXyHjfWr8DCY0YPX4Zeqnr0f68M
         dC2WCrkyX5kmLd7E1Ibz6SS+L6T9ioOKAm8ZqTeBK8ZTVZEC+sxR+dx+vGMwO2kfJK6f
         PxjGLOeAq4ZbzzSEf0+aqeR2ByzvbesEqXRwfe9VqCSElR3XpHI4+0wfa2UGiEIl1vSw
         kYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=npl7N80MmZBIHx6RTeaJpSZSlY3/u9gRYYg1tmf3W0Q=;
        b=CPooi78JFD/CmHgBMidjlAqIBmobq4fz4Shf84WyqYPaqBWR5pdtgAIIUmEjyU1uCL
         8EE+UGzkovQvKuniRCB3zIcbBv7boWl3f5z43yTQwPuW4AS2X5ZlTLw3UbfHRkkQcAZD
         4FPjEB7l4zzENxfSV7O7W30mNagKbW/Lo83o68oycakBYMBo03o0G/Bq7IvU/WrPT6Zr
         yeZgHl6yXTIeEHLALTo0YbR2c2IC4+KxVIQivXOgY6Mf4d3bX4A/Pt9AsoDee8XO9QP5
         1S2e1PFUe70nA5mCfeUs4I5T1EVKQHVyRF9wFD+C/qqoJz2Xp5IToOSF/GpBi8Ce9ty4
         fL6w==
X-Gm-Message-State: APjAAAUMHh9ARHA319gLtwoN/4LYmMe6DgVOOHhbCXDd30gyB6gw3K2T
        lDC0H1Ppgcdu9GxwGjsU2EtkgPonZIiljZj29EI=
X-Google-Smtp-Source: APXvYqyht9DhYfAcKFAEDrHPxjp/V/bK/n4GyiPl/S+A58tLat15QfaQF9GcypqwNLxm96LHJuQke2ZS6IpGI3uH2Bc=
X-Received: by 2002:aa7:cf8e:: with SMTP id z14mr114013981edx.40.1564673023905;
 Thu, 01 Aug 2019 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190729151505.9660-1-hslester96@gmail.com> <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
In-Reply-To: <5dee05d6cb8498b3e636f5e8a62da673334cb5a9.camel@perches.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Thu, 1 Aug 2019 23:23:33 +0800
Message-ID: <CANhBUQ2RD065Dn8eGkbzSQxfie5XrR_kgaFQ1QgOS4cKNhAfPA@mail.gmail.com>
Subject: Re: [PATCH 08/12] printk: Replace strncmp with str_has_prefix
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=888:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2019-07-29 at 23:15 +0800, Chuhong Yuan wrote:
> > strncmp(str, const, len) is error-prone.
> > We had better use newly introduced
> > str_has_prefix() instead of it.
> []
> > diff --git a/kernel/printk/braille.c b/kernel/printk/braille.c
> []
> > @@ -11,10 +11,10 @@
> >
> >  int _braille_console_setup(char **str, char **brl_options)
> >  {
> > -     if (!strncmp(*str, "brl,", 4)) {
> > +     if (str_has_prefix(*str, "brl,")) {
> >               *brl_options =3D "";
> >               *str +=3D 4;
> > -     } else if (!strncmp(*str, "brl=3D", 4)) {
> > +     } else if (str_has_prefix(*str, "brl=3D")) {
> >               *brl_options =3D *str + 4;
>
> Better to get rid of the +=3D 4 uses too by storing the result
> of str_has_prefix and using that as the addend.
>
> Perhaps
>         size_t len;
>
>         if ((len =3D str_has_prefix(*str, "brl,"))) {
>                 *brl_options =3D "";
>                 *str +=3D len;
>         } else if ((len =3D str_has_prefix(*str, "brl=3D"))) {
>                 etc...
>

I find that checkpatch.pl forbids assignment in if condition.
So this seems to be infeasible...

> >               *str =3D strchr(*brl_options, ',');
> >               if (!*str) {
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> []
> > @@ -121,13 +121,13 @@ static int __control_devkmsg(char *str)
> >       if (!str)
> >               return -EINVAL;
> >
> > -     if (!strncmp(str, "on", 2)) {
> > +     if (str_has_prefix(str, "on")) {
> >               devkmsg_log =3D DEVKMSG_LOG_MASK_ON;
> >               return 2;
> > -     } else if (!strncmp(str, "off", 3)) {
> > +     } else if (str_has_prefix(str, "off")) {
> >               devkmsg_log =3D DEVKMSG_LOG_MASK_OFF;
> >               return 3;
> > -     } else if (!strncmp(str, "ratelimit", 9)) {
> > +     } else if (str_has_prefix(str, "ratelimit")) {
> >               devkmsg_log =3D DEVKMSG_LOG_MASK_DEFAULT;
> >               return 9;
> >       }
>
> here too.
>
>
