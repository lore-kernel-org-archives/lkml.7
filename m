Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F92C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05702214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3lvkHY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfHGCBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:01:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42718 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfHGCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:01:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so84457254eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSxIAXbv8ExFvSycUA39nVYD9BShuSBNkZ9RH9JdzLk=;
        b=d3lvkHY54HHwWMqrrTyKaHhC6VikfgbBrVqW8Tlh8LCl1k9n70l6DpS3W6zYDh5y/o
         BGhAcjgj0Lkskh8MuzGFeOheJhjWylBQN2Zc674bJnbZ49w4LhinZOH8q/QeCJc/nWY5
         M4GnjdULtoOFq1D7w7V36WE1+SAfFnADDUnNxKqmfmudx9c3jYoXlm1E9O+UzCutjPZi
         sBuDuyTYVcHLFbhQQxAstTuaea3ZkYIVBLgpsb3/PrNGwVktxAVlHWXT67fS5WiPlJKl
         sLJ57kxOo5FhONpORp/axPLcTYV09MH0jLXcIqFKILXfEIAmV+gEtKtgPbos+nhYqNXk
         T2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSxIAXbv8ExFvSycUA39nVYD9BShuSBNkZ9RH9JdzLk=;
        b=V2r5UUWQ+YSObfwaOAzc5UcvclShp2qaj8H3pHrzMYfPPgBoBUPTkzrwYGE5uEr0QY
         zUAuaCYCJ7O8HJWUC4Uh32cwLXTnH0ZtuXEe+pigD27yYRESVi9WMKe1C0OJJ1Wf5ida
         JwyjwfOWKlDRHlaeUqHRe4ruPnezPY0ikt/azbzEezAIp1jBKaIS0Ht/YhaiRXtrGh8X
         PY8PH78IRpe5n6LapdcJGX5Y0gOdFFikV1p0Ox1RqTVt/Z+u47vM99ATe9qST9PJL1tQ
         7eaeMU/o6PEKw8jedwur7hL4wK/hPaNflPXMofun8unQMZaa38w8xFwwLdLgPO5HrxN8
         6c+Q==
X-Gm-Message-State: APjAAAX6hC/6zosPo4dTjbSrz/2AwuftsBAnIFVjmZgjdAyxSeDcnt+Z
        Gsu0Xsl0Zu47HUrUYYfZqGlcpobS/wHGaDTtH5A=
X-Google-Smtp-Source: APXvYqz29vV9A8mI8IX/00lL/jLiFXmgo9w6VXFnXJzPF8lxOD9DGC+2qF+GC9EXOBtU0YnQD/OQ+zMbmfrl4FKT45E=
X-Received: by 2002:a50:9729:: with SMTP id c38mr7273593edb.283.1565143269726;
 Tue, 06 Aug 2019 19:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190806013329.28574-1-joseespiriki@gmail.com>
 <20190806115305.GF1974@kadam> <8d6c6714f9ca46ab90b2a747c05b899b@AcuMS.aculab.com>
In-Reply-To: <8d6c6714f9ca46ab90b2a747c05b899b@AcuMS.aculab.com>
From:   =?UTF-8?Q?Jos=C3=A9_Carlos_Cazarin_Filho?= <joseespiriki@gmail.com>
Date:   Tue, 6 Aug 2019 23:00:33 -0300
Message-ID: <CABVhQQPDR6od5Tu0QUUqvQxvMh2pWz_3GQKsvuNDpy3s5JGdmQ@mail.gmail.com>
Subject: Re: [PATCH] rtl8712: rtl871x_ioctl_linux.c: fix unnecessary typecast
To:     David Laight <David.Laight@aculab.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "florian.c.schilhabel@googlemail.com" 
        <florian.c.schilhabel@googlemail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry folks, I haven't properly tested this before sending the patch
After I've removed the cast, I got this error:

drivers/staging/rtl8712/rtl871x_ioctl_linux.c:668:13: error: SSE
register return with SSE disabled
    (fwrq->m >=3D 2.412e8) &&
    ~~~~~~~~~^~~~~~~~~~~

But I think it's strange since you said that this compiled fine in
your environments.
I think we need to take a deeper look into this.

Kind regards

Em ter, 6 de ago de 2019 =C3=A0s 10:10, David Laight
<David.Laight@aculab.com> escreveu:
>
> From: Dan Carpenter
> > Sent: 06 August 2019 12:53
> > On Mon, Aug 05, 2019 at 10:33:29PM -0300, Jose Carlos Cazarin Filho wro=
te:
> > > Fix checkpath warning:
> > > WARNING: Unnecessary typecast of c90 int constant
> > >
> > > Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> > > ---
> > >  Hello all!
> > >  This is my first commit to the Linux Kernel, I'm doing this to learn=
 and be able
> > >  to contribute more in the future
> > >  Peace all!
> > >  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > > index 944336e0d..da371072e 100644
> > > --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > > +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> > > @@ -665,8 +665,8 @@ static int r8711_wx_set_freq(struct net_device *d=
ev,
> > >
> > >  /* If setting by frequency, convert to a channel */
> > >     if ((fwrq->e =3D=3D 1) &&
> > > -     (fwrq->m >=3D (int) 2.412e8) &&
> > > -     (fwrq->m <=3D (int) 2.487e8)) {
> > > +     (fwrq->m >=3D 2.412e8) &&
> > > +     (fwrq->m <=3D 2.487e8)) {
> >
> > I don't think we can do this.  You're not allowed to use floats in the
> > kernel (because they make context switching slow).  I could have sworn
> > that we use the -nofp to stop the compile when people use floats but
> > this compiles fine for me.
>
> My guess is the 'c90 int constant' text.
>
> It rather implies that '2.412e8' has become the same as '2141200000'.
> Which is rather worrying because suddenly 'int_var * 2.4e8' might
> be an integer multiply rather than a double one and overflow.
> Have the standard people broken code again?
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
