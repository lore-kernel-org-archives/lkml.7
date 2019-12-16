Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B41C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DB7205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoSEgNBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfLPP14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:27:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41031 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfLPP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:27:56 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so7339941ioo.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+TXBDJlLKRthy3SvNozHuFdhzDGbzNbCr+3TAoHawCg=;
        b=VoSEgNBCENpFW3uJyVhX71hU6o0ddmfGEJumF7AHjX+zi6hcQodN7hVzzXD9wXH5bM
         igZevvCEWXBBAkHUxcDQGQiHlJoXlsL2BpeSOB2t3JwKjXVXnVysJ/H/WiTK6qlHjhj5
         FSKe8Zm5R+Uqm8CnYrxBGs+6fXQygv/2Ct/JUwCMTyWGVqSzNTARQRFj/4UfTwNPkjZT
         WST2dc/shU3uBYvUEoh3tmfAAlUK8SjSyFH5bcU0ebALud6WN1tJWVz7WtSnwh72D6oC
         Akcp77Z2f68LQgK4tVCXU86aVnlFWxdmsDd5vjqYSfl5OmYzRz6YPY7m0Y+zd8Io1gHB
         YGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+TXBDJlLKRthy3SvNozHuFdhzDGbzNbCr+3TAoHawCg=;
        b=dQRA/VIXRUhHLaCeJG0I/1aV5MzrSbhjTCYQvlsOkmwcB8p+owCBaFR+Z9fVPFRllR
         MJ9F0p/XIQJYqZakLp0eWVSTCKCLh5I7eN5JYFgjNLk+EN/wJOAxl1mb//6++0H7+p5D
         FazRZXLUYk09UlqMlQWmEygBXw31zWvr0/j9ZdO2UEWNA/O9kOMQZNIrJulzUHYMFiwN
         MsnCOIoCeIvkPAttQX4dCeElpiPzINPvShMf/gkxeUe/1yaBp8QNmMjHKLXvy9dk11b3
         TXqmEE3RW2e9IvX3t3Q61Jaghr2Dip0YDc8zLpVp1c2MUSWK+FffHyOWF4/mQ/BVRdmT
         zhIw==
X-Gm-Message-State: APjAAAX5AtB5NEAx7WQBY8Kic04jcjXgEg59VKWph6tRMp0iSFl2r3FJ
        ejsy99rWbtnQCRu0T48GqHa51+JO19LSAD8P5MxkdlIliXQ=
X-Google-Smtp-Source: APXvYqxUOb1zUcnIbkqKPnJBbk1GShq7jAEjIm4Q5ZQW/tOmzg86A2aWVfIDWar1IAEg9Ic0c8gLUuXNSakwvHkSYSI=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr4519403ioa.18.1576510075354;
 Mon, 16 Dec 2019 07:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20191215151707.31264-1-tiny.windzz@gmail.com> <ceabec4e-0b4b-ee31-e99b-ac62a03e3aeb@linaro.org>
In-Reply-To: <ceabec4e-0b4b-ee31-e99b-ac62a03e3aeb@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 16 Dec 2019 23:27:44 +0800
Message-ID: <CAEExFWugke0PnqtSAOV6eWBRb1CB5qf+umiNBC3d+GQiGaREtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clocksource: em_sti: convert to devm_platform_ioremap_resource
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 9:44 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/12/2019 16:17, Yangtao Li wrote:
> > Use devm_platform_ioremap_resource() to simplify code.
>
> Even if the change is obvious, elaborate a bit the changelog.
>
> > BTW, do another small cleanup.
>
> Keep one change per patch.

OK... My fault.

Any comments on the other two?

MBR,
Yangtao

>
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/clocksource/em_sti.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.=
c
> > index 9039df4f90e2..ab190dffb1ed 100644
> > --- a/drivers/clocksource/em_sti.c
> > +++ b/drivers/clocksource/em_sti.c
> > @@ -279,9 +279,7 @@ static void em_sti_register_clockevent(struct em_st=
i_priv *p)
> >  static int em_sti_probe(struct platform_device *pdev)
> >  {
> >       struct em_sti_priv *p;
> > -     struct resource *res;
> > -     int irq;
> > -     int ret;
> > +     int irq, ret;
> >
> >       p =3D devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> >       if (p =3D=3D NULL)
> > @@ -295,8 +293,7 @@ static int em_sti_probe(struct platform_device *pde=
v)
> >               return irq;
> >
> >       /* map memory, let base point to the STI instance */
> > -     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     p->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +     p->base =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(p->base))
> >               return PTR_ERR(p->base);
> >
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
