Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2309C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A22183F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="nos6fIGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfF0C5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:57:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36857 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0C5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:57:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so902236qtl.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XOv8a68IoLvOnBZKQyev48vSHHjPWWYAoVTjhVRmmak=;
        b=nos6fIGyKSPvDtLYyUua79Vspxg0BS56MKAbpwYWSnvwyF7UKcJR02CcnMv7u2GDUs
         VHMQozQYsw4tsdVJtfhxzDrigf9TbY99aBLypH8lhIARmGQpCWU7yr+9CpnWTlNWvXvO
         l33j22R4AZIGvIMTMNoTkwgkCrFmW/w9XR6ohPwcntcvDoS9pQR54Wa8kzLWnle1hYtm
         eX8KiAzlmZd4bGZO2JaxUrpnbxL6Y/dhV+gEozhMobfhU683ZFu+VN4bIC9HbrnTmdlI
         /bZCdY3E4eqbnxAzLSYYHArDG82iDMiwVOVBnfF+pTZ4SE26EnbQ2NAamGwyV8K5KHnQ
         6dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XOv8a68IoLvOnBZKQyev48vSHHjPWWYAoVTjhVRmmak=;
        b=De5I9DIfnAyva/qy8UXCHEC8tuFWN69IqXDZBxuzL9ZxqjuXcYQBWu15+b+UF2WXuM
         EqOo5e/TrfCYg+gmva4yO1gzTdMDfYLoydOon8DzFoQ+dRPIYx9jOYiJLSEPyiY9QFdn
         iGG1tWGy1l74MiqkCdyUJjdgxoXQGIh+LWyl4QmbYCbc/7Qt29Uwm0u79Eap0CqZsQ44
         mSmb3MmH1hUbpFokWXXhPhEw2GW+jc1tXyM7mpstkGJ0yJ2nJ8OkxjhC1B/sp24nf+v6
         wzUOLYYfi4ESB6yyqewMF451mOGYnqpryPQESpguKJmdbUhskptbmZk8dVQ3kGcL14hy
         yNgw==
X-Gm-Message-State: APjAAAVghOgKBCn3TfkKw9oJD9N6npIWdPP7mLZigxeC6QZdtBB5l3dv
        WYC06raYBp2/ih2sK99MezvjyZ1fU2KwSzFR0IH0Xw==
X-Google-Smtp-Source: APXvYqxg5Pzkz8pdfQiWdRrU/4QKC0TYL/QuCUWNEHRQXETGdfdyQy9zxuj6JawFSj1zcDLeGB/5Cg1gGQTrdCN++yY=
X-Received: by 2002:a0c:ae6d:: with SMTP id z42mr1272989qvc.8.1561604255633;
 Wed, 26 Jun 2019 19:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190626133007.591-1-axel.lin@ingics.com> <40ae33d4-10fd-852a-30e6-db56d709ef1c@hisilicon.com>
In-Reply-To: <40ae33d4-10fd-852a-30e6-db56d709ef1c@hisilicon.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 27 Jun 2019 10:57:24 +0800
Message-ID: <CAFRkauDFf0qWpovNaaMkB48RXAsRsGEQ_=osSM7+Ze59C8DEkw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mfd: hi655x-pmic: Fix missing return value check
 for devm_regmap_init_mmio_clk
To:     Chen Feng <puck.chen@hisilicon.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

Chen Feng <puck.chen@hisilicon.com> =E6=96=BC 2019=E5=B9=B46=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Thanks
I assume this is an Ack.
If you can add your Acked-by in the reply, it's easier for maintainer to ac=
cept
the patch.

>
> On 2019/6/26 21:30, Axel Lin wrote:
> > Since devm_regmap_init_mmio_clk can fail, add return value checking.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > Acked-by: Chen Feng <puck.chen@hisilicon.com>
> > ---
> > This was sent on https://lkml.org/lkml/2019/3/6/904
> >
> >   drivers/mfd/hi655x-pmic.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
> > index 96c07fa1802a..6693f74aa6ab 100644
> > --- a/drivers/mfd/hi655x-pmic.c
> > +++ b/drivers/mfd/hi655x-pmic.c
> > @@ -112,6 +112,8 @@ static int hi655x_pmic_probe(struct platform_device=
 *pdev)
> >
> >       pmic->regmap =3D devm_regmap_init_mmio_clk(dev, NULL, base,
> >                                                &hi655x_regmap_config);
> > +     if (IS_ERR(pmic->regmap))
> > +             return PTR_ERR(pmic->regmap);
> >
> >       regmap_read(pmic->regmap, HI655X_BUS_ADDR(HI655X_VER_REG), &pmic-=
>ver);
> >       if ((pmic->ver < PMU_VER_START) || (pmic->ver > PMU_VER_END)) {
> >
>
