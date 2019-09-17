Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE70C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397C206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TYmeD0Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfIQOLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:11:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36947 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfIQOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:11:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so3354505wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Z6VrYNesVKMXJ+ulzIbEsB6YF+R/fyaC0hYVzmRgjEU=;
        b=TYmeD0Xlf52MIkWG8R8WIJ7lZz9MwhhLj+MT1AJ8zWHj9x1B+ORaEdI11YZB1cV/KP
         Q43MgenEWbllJFTHX/xauVLsvP2zqxkJXxjK+m3iYnul8QTD6Xq/RpNrgbQmHMGK3Bly
         fWs/YCjsvy55FV7DMdlA5l1TE1Rbj7CChd/0uBsSxBPiGV5viVDgTK4R5EjIIFlGlSnC
         Jsw9uCVAS8CNYfk9RbRdwon/Ssof/GXNeYwZIsMrfJ8I6HYeGN2EGVZZ/OKflbvY3m/E
         Fqq2RpyO7FDMAqnU06Zb/PtQ5hcexCpnLCllq2OwkwCH3DUuLA4ya2v36P7TncDMrKfj
         hXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Z6VrYNesVKMXJ+ulzIbEsB6YF+R/fyaC0hYVzmRgjEU=;
        b=PjWOhlaznbJ4/AVyUymj7vZ2cWLf4gqmHvb6ucv8E9iWH7rcup0G+Hh2+ZAtkAN+FG
         Y1B1XqYjaa5obwH5gIKn/u0QJlMagmSFcHDERpV4o/+LbWZ6kw7ArUOXghOskSNybvZm
         ukZyTMQLlNeuPKduX4b4ZMx6E12Vi8ywRRybXe8rZjW+MCxCHBIAl2DvYoTQdX6q5yIg
         ZhUTpx0tRQg2Rs9A8laSjeIQeKLJ0pzlX3747Qwk0INwFQSDDWWpDelx/alockpNRf4x
         LHU5hhJzN6F9eWHZ6Pxq5KkvjBSq3QQRmICBqI/3oKh/1fWr3tzrJpySbVPaGLxK/3J7
         lKNQ==
X-Gm-Message-State: APjAAAUGjkKaY1lnGWTbNAwLnv+QerS+QDGDLyxjZKdHA91fa2ef/yyb
        wbWsXmRcXnimzwYgd9O4Maza+g==
X-Google-Smtp-Source: APXvYqybEIGjc3b1spUt+GGCetbHRNtPijTdAl9qvfY4a2Gv0hS2ZMdtaN0aUZ9iyLtr+zebc9MUzA==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr3303400wrr.302.1568729477864;
        Tue, 17 Sep 2019 07:11:17 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id r18sm3800225wme.48.2019.09.17.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:11:17 -0700 (PDT)
Date:   Tue, 17 Sep 2019 07:11:16 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
Message-ID: <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com> <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
 <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1565122568-1568729476=:8198"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1565122568-1568729476=:8198
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Aurobindo,=20

On Tue, 17 Sep 2019, Aurabindo Jayamohanan wrote:

> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> On Tuesday, September 17, 2019 5:45 PM, Paul Walmsley <paul.walmsley@sifi=
ve.com> wrote:
>=20
> > On Tue, 17 Sep 2019, Baolin Wang wrote:
> >
> > > On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan mail@aurabindo.in=
 wrote:
> > >
> > > > platform_get_resource() may return NULL. If it is so, return -ENXIO
> > > >
> > > > Signed-off-by: Aurabindo Jayamohanan mail@aurabindo.in
> > > >
> > > > -------------------------------------------------------
> > > >
> > > > drivers/spi/spi-sifive.c | 6 ++++++
> > > > 1 file changed, 6 insertions(+)
> > > > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > > > index 93ec2c6cdbfd..67485067a694 100644
> > > > --- a/drivers/spi/spi-sifive.c
> > > > +++ b/drivers/spi/spi-sifive.c
> > > > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_de=
vice *pdev)
> > > > platform_set_drvdata(pdev, master);
> > > >
> > > >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >
> > > >
> > > > -         if (!res) {
> > > >
> > > >
> > > > -                 dev_err(&pdev->dev, "no IOMEM resource found\\n")=
;
> > > >
> > > >
> > > > -                 ret =3D -ENXIO;
> > > >
> > > >
> > > > -                 goto put_master;
> > > >
> > > >
> > > > -         }
> > > >
> > > >
> > >
> > > Seems unnecessary, the devm_ioremap_resource() already validated if
> > > the resource is available.
> >
> > Just doublechecked lib/devres.c and I agree with you.
> >
> > Aurobindo, is this a patch for a real problem that you've encountered?
> >
> > -   Paul
>=20
> Geert is right. I was just breezing through the source and found it odd s=
ince
> I noticed other instances checking for return value. Apparently none of t=
hose
> use the managed api.
>=20
> If you didnt already do Geert's suggestion,

Mark Brown is the maintainer, so he'd be the one to apply anything=20
touching these drivers.

> here is a patch:

Could you please send this as a separate E-mail?

> ____
>=20
> spi: sifive: use device managed api to get plaform resource

"platform resource"

>=20
> calls to devm_ioremap_resource() preceeded by platform_get_resource()

"Calls"

"preceded"

> may be replaced by devm_platform_ioremap_resource().

Please explain why.  In this case "removing boilerplate from the code"=20
seems like a reasonable explanation.

>=20
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> ---
>  drivers/spi/spi-sifive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> index 93ec2c6cdbfd..c0925aa98aad 100644
> --- a/drivers/spi/spi-sifive.c
> +++ b/drivers/spi/spi-sifive.c
> @@ -292,7 +292,6 @@ sifive_spi_transfer_one(struct spi_master *master, st=
ruct spi_device *device,
>  static int sifive_spi_probe(struct platform_device *pdev)
>  {
>  =09struct sifive_spi *spi;
> -=09struct resource *res;
>  =09int ret, irq, num_cs;
>  =09u32 cs_bits, max_bits_per_word;
>  =09struct spi_master *master;
> @@ -307,8 +306,7 @@ static int sifive_spi_probe(struct platform_device *p=
dev)
>  =09init_completion(&spi->done);
>  =09platform_set_drvdata(pdev, master);
>=20
> -=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -=09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +=09spi->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  =09if (IS_ERR(spi->regs)) {
>  =09=09ret =3D PTR_ERR(spi->regs);
>  =09=09goto put_master;
> --
> 2.23.0
>=20


- Paul
--8323329-1565122568-1568729476=:8198--
