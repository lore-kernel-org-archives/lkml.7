Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E522089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw/Pn5GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfJVIo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:44:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJVIo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:44:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id z9so17008601wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w9hE3H2QqcKC0k4cAF5UP1zSQ3qEgbtQSjagp+w7kTY=;
        b=Mw/Pn5GBAg50VeKizp3ggQBlLa29y4QBd34pwIlWgxuB1CnU7Bv+6Y23h4VW6aBJtz
         SPfSQnHVEOQG1qM8h4gB/p2SrP+ycwUxTkhF7kxdB3njZFq4Etuwp80cmJIzXC1IYDsq
         1AmADuJ7ApPdGp1/jOsLTPQIqHIHHKtk7fkpqLfMzSAk6BoDFDJiLAYhuQRDUOIMffOw
         FK1eCm+6iPpdydn2NsXcSolat6gk7uy3jp2XUdf/mNKIZtwVh6V7JTcsZAvLCqIyOTOR
         YKIVhfOppkBJaxnY1KqrXwJ/IyCiNoSU+wHYFebLK0Gje39GJIqyyR5GYaXKZjgkaZwO
         8udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9hE3H2QqcKC0k4cAF5UP1zSQ3qEgbtQSjagp+w7kTY=;
        b=OlRKaKS6F0BwhesNGiKGoOZKxnROVXTHssQhUmzLSh/UpdbXArDsmATxNm3yW2GZLV
         LzCNKrUGtW6vW/v8IvBViKvjg1626D6BvZ/lbaPTrQso8Ybx1fLcB4ELE133tbTxax89
         8GJ2Dfwo3/XPQhZHPbbRSgg/boFMpJmtt17sUEDAgzDQmOVi0iLxB98TLplVCpUPKr2P
         UVp3iViiQjSiFuk8rEPz/ZExv0xtrY6fsPf4iNPzp+sB7krEwUYVAo2NZ91MUJUkpuea
         7gElr7Lap1ooaK25CRVkqtj0lFyUNl/+18hMAk8Xao7kN5PInXrqwD17l+EhVfZLi5I6
         +5AA==
X-Gm-Message-State: APjAAAUUp/ga/2C6YaB9Z9kyG7EpnLDgDl4y/Zrm5BSIY531sfePX8WB
        7JAhQLjaEK+4MyDgYuXQMkk=
X-Google-Smtp-Source: APXvYqxb9CtmaeKXSI41YCIJ6lDnZcFZzJDQW1jQX5COHVXCfaamJPNMfbN8l+Cb+uDVwQu+IPUUcQ==
X-Received: by 2002:adf:eec4:: with SMTP id a4mr2331771wrp.38.1571733866143;
        Tue, 22 Oct 2019 01:44:26 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r27sm31936247wrc.55.2019.10.22.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:44:24 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:44:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <treding@nvidia.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS
Message-ID: <20191022084423.GB1531961@ulmo>
References: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
 <87lftdfb4c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <87lftdfb4c.fsf@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 11:16:51AM +0300, Jani Nikula wrote:
> On Wed, 16 Oct 2019, Patrik Jakobsson <patrik.r.jakobsson@gmail.com> wrot=
e:
> > Fix typo where bits got compared (x < y) instead of shifted (x << y).
>=20
> Fixes: 3ad33ae2bc80 ("drm: Add SCDC helpers")
> Cc: Thierry Reding <treding@nvidia.com>

I'm not sure we really need the Fixes: tag here. These defines aren't
used anywhere, so technically there's no bug.

Thierry

>=20
> > Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > ---
> >  include/drm/drm_scdc_helper.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/drm/drm_scdc_helper.h b/include/drm/drm_scdc_helpe=
r.h
> > index f92eb2094d6b..6a483533aae4 100644
> > --- a/include/drm/drm_scdc_helper.h
> > +++ b/include/drm/drm_scdc_helper.h
> > @@ -50,9 +50,9 @@
> >  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
> > =20
> >  #define SCDC_STATUS_FLAGS_0 0x40
> > -#define  SCDC_CH2_LOCK (1 < 3)
> > -#define  SCDC_CH1_LOCK (1 < 2)
> > -#define  SCDC_CH0_LOCK (1 < 1)
> > +#define  SCDC_CH2_LOCK (1 << 3)
> > +#define  SCDC_CH1_LOCK (1 << 2)
> > +#define  SCDC_CH0_LOCK (1 << 1)
> >  #define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_L=
OCK)
> >  #define  SCDC_CLOCK_DETECT (1 << 0)
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2uwWcACgkQ3SOs138+
s6F4VQ/9Fh26YyxOGOPt6U2FJ+9WXA66c18kbCj663XQekyTjTlDa1/TirKGwiTz
XMN3mpwKhTjK0UXga841fW5yiGqlIHHWtNLcgOFnZxlryc1YX70ZcHVoNMZfrDsL
iRxgkuHhvLcPc3UpBmG2zCK84a0kqw7xEQlrd31erUpOWHrZKUruw1EoefzqTsx1
nT/6Yw3BZNpzb6qilOAqdK98aTdE08wzeAFPbwXOfI2ZdcGWhWbE9zyAMb6Rt9BM
TADOW2MkrkCaRZ6pUd/xTrd6d9SHAymGBd8tN97Q4kL4C8aXO8zZi2MZO1QIIrcr
Vtq2Q8jMNiQEswZ/NN3/5lnDxtVl/pjuiBB7rOuuZUi7pEopgArL24OoeM4LZN95
3Ejt/bhnhHd6yd18l0Yvu3GEZwS+1TAHZ3hdMUHuVTK0K/bqgo8xPm34SO/ECbUj
B7zAIQ6HPc5YFpL+AHoRoJdAsHVPjqeIWeJi25aMhBo8H7EU0xoYg83Uro7/maoy
3VCv25JHyGXyUvRjy37rDwJ04lN8rlarzTISOz2et8VOlON94isov0fW6E3GU4fX
efEKbnJqqcc5xAsOTO1QWvonKTpFjcwC77dlDouA8vhEbc+wLxbC25RbbX+vjKTS
wn2b0eSfJPEFB6dRP91ouHvojJYQuJgtzpa7TddCOM4+7pIV9RU=
=Vn4o
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
