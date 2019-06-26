Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11BEC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BAF216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="yWvxd7Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfFZPUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:20:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45442 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:20:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so1940301qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ELXLhOLz04A2c7tl3nrQG1+Ijqzqm4Q9d9UrTY8MYRg=;
        b=yWvxd7Pwuo//+rbSXY1t/j5A20ZyNH31mVRjbjHmYPNP2Ydsjms4Ey0wTUNhIvE1lv
         I8VLUog7xRGPwzt+ATI7UaLcSKgyFvVFv40zJnihWQPb31LhRUfD2RbFNF4ZiCWA1FFD
         AFFG4lfi4t75EnKiZqmc0wTG3PHeiBb4yHkBvKlzuNGxfj+ttY3bK1bIT6T8B5cXK5m+
         pHZWf4iunHW3XHxj8nADwTVUbq00UTVazxdsESfisOOP5/Ch0huLKPqkMLcUl07EqjAH
         ITIaXZqPkM322LDQgCFcQepj7+WPo2zUmZ6hbPkGrOMSpuswHGNvDhgc4qP2mmmGsrdC
         DL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ELXLhOLz04A2c7tl3nrQG1+Ijqzqm4Q9d9UrTY8MYRg=;
        b=RZ644Dw6PPA44hiesDTMynTrua49eouwr06UNSjPytpLLTZ4MZyVtwk742vgDf26cd
         RDK9mtHTdQZydx3r4YtdF29iEogeNrRhuFZA8aRfyWhkDNqLS/7YYOWylZUmVm4xr9cA
         fMYP8Uha0iiiET/qPHcqsHLv+sXLh5tKqDdMQ0dlkqLzdHZJiNjwXg75yYts8xm577Vw
         vjfoG+blUwL014qN+HwSnMMLke1hPPV88LHc4R87zsN4RkN22I5nZTB8lXcqp4gZbZ6j
         PwE+h4LlRvHobc+iSiEMinyB5brc2nnmj7YbHnVB6LCxzlKRllOiV+VfeR6q1DON8RSZ
         PEcw==
X-Gm-Message-State: APjAAAUni9Th/ikl51/lSwLpIQhcJaYyVH3sQ+7nTldxyHZdnASVTatw
        ooWiGq+2FEOj88MxoP9UAGdzRTCJXb0+4BE7/wKQ1w==
X-Google-Smtp-Source: APXvYqz23DtqahM0L3H5wlbSC7MZTjjpe1x3hDzHbGAVHmblW+IEs1zZMfufBkl3TyuTVXoHt4XAoOTzJXbeBnZT+aY=
X-Received: by 2002:a37:6782:: with SMTP id b124mr4034848qkc.242.1561562439876;
 Wed, 26 Jun 2019 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132632.32629-1-axel.lin@ingics.com> <20190626132632.32629-2-axel.lin@ingics.com>
 <e1ba816f-1ecc-acc1-1f69-bc474da1061a@ti.com>
In-Reply-To: <e1ba816f-1ecc-acc1-1f69-bc474da1061a@ti.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 26 Jun 2019 23:20:28 +0800
Message-ID: <CAFRkauCtHtG0mfqXp=FuBYYqGhhMGfP3o_N3iBoRHwkQNQYtNw@mail.gmail.com>
Subject: Re: [RFT][PATCH 2/2] regulator: lm363x: Fix n_voltages setting for lm36274
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Murphy <dmurphy@ti.com> =E6=96=BC 2019=E5=B9=B46=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hello
>
> On 6/26/19 8:26 AM, Axel Lin wrote:
> > According to the datasheet http://www.ti.com/lit/ds/symlink/lm36274.pdf=
:
> > Table 23. VPOS Bias Register Field Descriptions VPOS[5:0]:
> > VPOS voltage (50-mV steps): VPOS =3D 4 V + (Code =C3=97 50 mV), 6.5 V m=
ax
> > 000000 =3D 4 V
> > 000001 =3D 4.05 V
> > :
> > 011110 =3D 5.5 V (Default)
> > :
> > 110010 =3D 6.5 V
> > 110011 to 111111 map to 6.5 V
> >
> > So the LM36274_LDO_VSEL_MAX should be 0b110010 (0x32).
> > The valid selectors are 0 ... LM36274_LDO_VSEL_MAX, n_voltages should b=
e
> > LM36274_LDO_VSEL_MAX + 1. Similarly, the n_voltages should be
> > LM36274_BOOST_VSEL_MAX + 1 for LM36274_BOOST.
> >
> > Fixes: bff5e8071533 ("regulator: lm363x: Add support for LM36274")
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> >   drivers/regulator/lm363x-regulator.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/l=
m363x-regulator.c
> > index e4a27d63bf90..4b9f618b07e9 100644
> > --- a/drivers/regulator/lm363x-regulator.c
> > +++ b/drivers/regulator/lm363x-regulator.c
> > @@ -36,7 +36,7 @@
> >
> >   /* LM36274 */
> >   #define LM36274_BOOST_VSEL_MAX              0x3f
> > -#define LM36274_LDO_VSEL_MAX         0x34
> > +#define LM36274_LDO_VSEL_MAX         0x32
>
> This does not seem correct the max number of voltages are 0x34.
>
> The register is zero based so you can have 33 voltage select levels and
> + 1 is 34 total selectors
>
> Liam/Mark correct me if I am incorrect.

From the datasheet, the maximum voltage 110010 =3D 6.5 V, the 0b110010 is 0=
x32.
I know it is 0 based, so .n_voltages     =3D LM36274_LDO_VSEL_MAX + 1,
(And that coding style is to match the original code.)

With your current code where LM36274_LDO_VSEL_MAX and n_voltages is 0x34,
the maximum voltage will become 400000 + 50000 * 0x34 =3D 6.6V which
does not match the datasheet.

Would you mind double check again?
