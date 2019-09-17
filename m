Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A39C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946D72171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="CFMJ9hdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfIQOGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:06:55 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:13667 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfIQOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:06:54 -0400
Date:   Tue, 17 Sep 2019 14:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568729209;
        bh=IzxXyf9LUqJRZ0W8vp8MTxeBb0vPHdEwkUasYCPeF90=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=CFMJ9hdKjn2aCG9YQCmmp71v8ZTD11TwZDi5LFDlbLfg6t3IFfSAePNh+sipGs7XN
         Hm4SEN4SazYKJFhWytWwStqkkSXK8DZGWtY1tGwZtRimoSqUU7Y/Wwaj1WG6RhsOUx
         wEAjEB1dU9dwC7y7HaRIgyFD1NvImDLS30YSqxw8=
To:     Paul Walmsley <paul.walmsley@sifive.com>
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
Message-ID: <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
In-Reply-To: <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in>
 <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, September 17, 2019 5:45 PM, Paul Walmsley <paul.walmsley@sifive=
.com> wrote:

> On Tue, 17 Sep 2019, Baolin Wang wrote:
>
> > On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan mail@aurabindo.in w=
rote:
> >
> > > platform_get_resource() may return NULL. If it is so, return -ENXIO
> > >
> > > Signed-off-by: Aurabindo Jayamohanan mail@aurabindo.in
> > >
> > > -------------------------------------------------------
> > >
> > > drivers/spi/spi-sifive.c | 6 ++++++
> > > 1 file changed, 6 insertions(+)
> > > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > > index 93ec2c6cdbfd..67485067a694 100644
> > > --- a/drivers/spi/spi-sifive.c
> > > +++ b/drivers/spi/spi-sifive.c
> > > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_devi=
ce *pdev)
> > > platform_set_drvdata(pdev, master);
> > >
> > >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >
> > >
> > > -         if (!res) {
> > >
> > >
> > > -                 dev_err(&pdev->dev, "no IOMEM resource found\\n");
> > >
> > >
> > > -                 ret =3D -ENXIO;
> > >
> > >
> > > -                 goto put_master;
> > >
> > >
> > > -         }
> > >
> > >
> >
> > Seems unnecessary, the devm_ioremap_resource() already validated if
> > the resource is available.
>
> Just doublechecked lib/devres.c and I agree with you.
>
> Aurobindo, is this a patch for a real problem that you've encountered?
>
> -   Paul

Geert is right. I was just breezing through the source and found it odd sin=
ce
I noticed other instances checking for return value. Apparently none of tho=
se
use the managed api.

If you didnt already do Geert's suggestion, here is a patch:
____

spi: sifive: use device managed api to get plaform resource

calls to devm_ioremap_resource() preceeded by platform_get_resource()
may be replaced by devm_platform_ioremap_resource().

Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
---
 drivers/spi/spi-sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 93ec2c6cdbfd..c0925aa98aad 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -292,7 +292,6 @@ sifive_spi_transfer_one(struct spi_master *master, stru=
ct spi_device *device,
 static int sifive_spi_probe(struct platform_device *pdev)
 {
 =09struct sifive_spi *spi;
-=09struct resource *res;
 =09int ret, irq, num_cs;
 =09u32 cs_bits, max_bits_per_word;
 =09struct spi_master *master;
@@ -307,8 +306,7 @@ static int sifive_spi_probe(struct platform_device *pde=
v)
 =09init_completion(&spi->done);
 =09platform_set_drvdata(pdev, master);

-=09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-=09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
+=09spi->regs =3D devm_platform_ioremap_resource(pdev, 0);
 =09if (IS_ERR(spi->regs)) {
 =09=09ret =3D PTR_ERR(spi->regs);
 =09=09goto put_master;
--
2.23.0
