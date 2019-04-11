Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEBFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C842083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdq8Zmxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDKIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:30:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53483 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKIaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:30:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so5541388wmj.3;
        Thu, 11 Apr 2019 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s4CEvxLXTf/Tr9nUw2W0mFgsCBbteLfVw7kEtOc00/g=;
        b=Hdq8Zmxzc7CFTTuAWQjfyX+y2N4xAiHBnZfGkRflHSMYPYugnEjZF6K6wvsprHGGf1
         2H3+OcPHRqFLcn9Apt1DLpyA1siHyX1LZ4e44ZE5khtacoSV97GXv10xjEgy0tcNbVOw
         br+qHQxRZLH8RlM5cZpYldth6Th/2q2srcI9BgFP/9zIvncteiR0QTKWwsPw+SiJnCZ0
         vxnY9xwk+bnnnjZksmPbVHxx6F/vQt8XmMxHikNR/x7bIWhV8mLcYl0iBM2K3sOT/CHU
         SoLcgKp0ILTGKfsa0dQhLDEYGtbOIOvYSXNpvVMjJCFsCImi6wT/5CWrAUOD2cylEJ7L
         bbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s4CEvxLXTf/Tr9nUw2W0mFgsCBbteLfVw7kEtOc00/g=;
        b=tgXwLau+pRj25GF/ZqeB1q7UtWKnQNm9C0QzsQs1Q2HU05FeIH6vZw/oWXDf9VKHKC
         BLfb/uTUOm9rwsyo6Pzpo31eQWslV3NVJuZw69uhQKb086+E/cCmKHNTwkzcQISbmbnP
         UaNGS3rhMGRbIbyuyzF582Ac+q7TPpJeldj79pqzd8TtRjqy+xcMuWdX2rGQ+36xW98b
         MGSapmrg6hxZnDo9ii30mYjQLW+SjmDZnnJs4kTsKjapFYmuAH05bUUa9T8LKlyTpkzk
         WtOSBvuVw9txIxCUt7BPr0hi19TNwvr0NhlUObHwCJUGKHVqPEP2n7pEKuN8JksNfbEt
         EiqA==
X-Gm-Message-State: APjAAAUjSmqdUpe8f60vZ1DKyHHEWXPFxOlkc6NFGAsd8zdOyJxwwS0t
        TGBuEUbwY73O13MQAZSWVtk=
X-Google-Smtp-Source: APXvYqxaZDsOmaSpewBLuzavRG0bp1bygiMiK+Q6KdOQ6MlDVHlo6I4MnnwN/JahKyUOfIAweqyPKA==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr5673602wmb.101.1554971418672;
        Thu, 11 Apr 2019 01:30:18 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id u8sm38814927wrt.69.2019.04.11.01.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 01:30:18 -0700 (PDT)
Date:   Thu, 11 Apr 2019 10:30:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Stefan Agner <stefan@agner.ch>, digetx@gmail.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: fix compile error when IOMMU API is not
 available
Message-ID: <20190411083017.GB4633@ulmo>
References: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
 <7371b1573ddd0b127713724ef5051a6f@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <7371b1573ddd0b127713724ef5051a6f@codethink.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 09:23:13AM +0100, Ben Dooks wrote:
>=20
>=20
> On 2019-04-10 23:47, Stefan Agner wrote:
> > In case the IOMMU API is not available compiling host1x fails with
> > the following error:
> >   In file included from drivers/gpu/host1x/hw/host1x06.c:27:
> >   drivers/gpu/host1x/hw/channel_hw.c: In function
> > =E2=80=98host1x_channel_set_streamid=E2=80=99:
> >   drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit
> > declaration of function
> >     =E2=80=98dev_iommu_fwspec_get=E2=80=99; did you mean =E2=80=98iommu=
_fwspec_free=E2=80=99?
> > [-Werror=3Dimplicit-function-declaration]
> >   struct iommu_fwspec *spec =3D
> > dev_iommu_fwspec_get(channel->dev->parent);
> >                               ^~~~~~~~~~~~~~~~~~~~
> >                               iommu_fwspec_free
> >=20
> > Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>=20
> would it be better to provide something like this i nthe header that
> defines dev_iommu_fwspec_get() to be:
>=20
> static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *de=
v)
> { return NULL; }
>=20
> although returning an PTR_ERR would have been better.

I don't think there's really a large number of failures here. Either
your device has an IOMMU fwspec or it doesn't.

But yes, I think it'd be better to have the above static inline dummy in
iommu.h, but I'll apply this for now in the hopes of getting it in
before v5.1 final.

Thierry

>=20
> > ---
> >  drivers/gpu/host1x/hw/channel_hw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/host1x/hw/channel_hw.c
> > b/drivers/gpu/host1x/hw/channel_hw.c
> > index 27101c04a827..4030d64916f0 100644
> > --- a/drivers/gpu/host1x/hw/channel_hw.c
> > +++ b/drivers/gpu/host1x/hw/channel_hw.c
> > @@ -114,7 +114,7 @@ static inline void synchronize_syncpt_base(struct
> > host1x_job *job)
> >=20
> >  static void host1x_channel_set_streamid(struct host1x_channel *channel)
> >  {
> > -#if HOST1X_HW >=3D 6
> > +#if IS_ENABLED(CONFIG_IOMMU_API) &&  HOST1X_HW >=3D 6
> >  	struct iommu_fwspec *spec =3D
> > dev_iommu_fwspec_get(channel->dev->parent);
> >  	u32 sid =3D spec ? spec->ids[0] & 0xffff : 0x7f;

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyu+xUACgkQ3SOs138+
s6EFHBAAk44H2K1jNNl7wZcBvpROax7r9TTL5TIwr5Unzg+opeXElx0+pM0/A5//
hq+p1oArJNPazReuo1QX+vLFHd3sNi4h48LooFs+/uF4gprz8KtGQZ/4RaNcu4Zn
A9z0x8tXLWTBdKssQ340wOYGk5iWanjoq7bjZdA/f0VZNCzznJME7log7r7xWMQv
el0QGQPjyd4lKd5/RcTgCWV4AbB3fzYBkyxuNq9NbKORo7i+NjDhy7LCHBI0kVUM
dbBopX19BcW1gihEU9mRpSIA1wMDClFRnUuOK61c30bGlCic2kVcYZyVpqH1KHey
n755I2NwoOkFJxwFxIA3H/EFRQY69edpEOzWdbNuSh6lO/W5Q0AZ6jBw04ROdt2i
IYmTzaR4JLUwiZnYFRu1sHPVJILQg3rU+q/8CWe3OBrcBQaSj5E8S/+23PlBV9xE
Wxh+qA/BpXUaGcdb3l7p91gyWG5Dy4EOHSRlYt+ScDDdxdhn8QYcAzcXpMYNgRak
5YVaH7I6Ccoy1mDb/OEhyD2zILmy+r2XNUNOp630HudIYLlTt9lGjZ9HZF2CiqLp
gPcmFYWlpTMx2V2LAQnuEEUZKh8s5ILzcExpSISSXmDEvSv+UPR3ZX0gcGY2D8pa
LbZHExXVY4xv8Njo/orhrO9JJlL3IA3QlMMdIfUYr+rvs47Qd+E=
=mRJf
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
