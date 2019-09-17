Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B7C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E192F214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 09:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="h7fwfvpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfIQJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 05:58:25 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:47085 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfIQJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:58:23 -0400
Date:   Tue, 17 Sep 2019 09:58:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568714301;
        bh=ftJdTOKlBr/AG20OwG1MTUH8i2f7oG0aNtJYOC26Q5I=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=h7fwfvpvSgI4B6Q40CBaRg5cnJ0/Iz3EmB2KLqRa5RVwn3/TtbQTzhBzyGAQnNZEk
         NvzxRMs6HVFIIwV5sDuXUPIaB4Ra+CzcDL/4rqAROsAUEleubQTba+ogOA93AeTyuK
         SeZLT6owgA+nCuFWJwobVVA0qDDrI1ln6SMk7XRI=
To:     Baolin Wang <baolin.wang@linaro.org>
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
Message-ID: <7kLa83nF-ufh-AGA_LpBQ6M-ErUf-LEVXANxL2LmirJAh-snvVtJLTVFkBKFxaHvIH9Vi1E3iXDmxW6Ijktoo6k1S7pyFrwmVVLkhKr4Q_Q=@aurabindo.in>
In-Reply-To: <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
References: <20190917085627.4562-1-mail@aurabindo.in>
 <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, September 17, 2019 2:53 PM, Baolin Wang <baolin.wang@linaro.org=
> wrote:

> On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan mail@aurabindo.in wro=
te:
>
> > platform_get_resource() may return NULL. If it is so, return -ENXIO
> >
> > Signed-off-by: Aurabindo Jayamohanan mail@aurabindo.in
> >
> > -------------------------------------------------------
> >
> > drivers/spi/spi-sifive.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > index 93ec2c6cdbfd..67485067a694 100644
> > --- a/drivers/spi/spi-sifive.c
> > +++ b/drivers/spi/spi-sifive.c
> > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device=
 *pdev)
> > platform_set_drvdata(pdev, master);
> >
> >         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >
> >
> > -         if (!res) {
> >
> >
> > -                 dev_err(&pdev->dev, "no IOMEM resource found\\n");
> >
> >
> > -                 ret =3D -ENXIO;
> >
> >
> > -                 goto put_master;
> >
> >
> > -         }
> >
> >
>
> Seems unnecessary, the devm_ioremap_resource() already validated if
> the resource is available.
>

Okay, thanks for the headsup

