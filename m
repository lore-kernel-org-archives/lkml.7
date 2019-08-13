Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFADC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D617820665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565723999;
	bh=kdNXJ8hZlcNjicps4RuD0AxoaO5Tr3w7XkkUVNHMbRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ip6aFRj8jfZNzqFesU338bx2ayuhHQW+ZvFeGLzDFjS5x3LI8UCAuYwxfLDJRUcE2
	 y2pvS60q6+J1R50yTJCrAfv4gFNunZ8ZDdm90ZQacoRGlZpvCbaZlU+lkAr5ZvTWOl
	 lhrFbP7Pq9ovYp8VI9HiUzXsY/FrC8ibHesnfYlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHMTT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:19:58 -0400
Received: from mail-wm1-f100.google.com ([209.85.128.100]:50299 "EHLO
        mail-wm1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:19:58 -0400
Received: by mail-wm1-f100.google.com with SMTP id v15so2518694wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdNXJ8hZlcNjicps4RuD0AxoaO5Tr3w7XkkUVNHMbRc=;
        b=RfDOaodwqKLDAHimyW56k3nV2jVa5kwsqaPy++fJMRgLpk7nZU/2dOmNNiGa9uZrV5
         +BO5eRJd3CcI3f3ciZEhXBMb5e4NpfxXbzhVaO1IuNyDk5if3u0n08nKtlsDMJ/Z7Z8Y
         nWrp8sfx18QMjWRch9zIboNDFxBVoD0XCyyqZaBAnPVdhfv4Fkch77l+anYb0LZhJLYR
         z4f0SA6HQ2UJ7lFL0xERXsoakcWtkK7EVNDBfw7VPH7bFhMvlxueDJHRu7zIuV9e6WRS
         du8u2jHXdt64i9Y2GNh36ujQvDnJ7F560stpuF48tp6iI+Kx0P1dxex5cSEOVBSJhRXD
         CFlw==
X-Gm-Message-State: APjAAAWcmJGR/CmQM/DH8OpjNIjHXYERcy2tYvTR7tSQsJog/Y/CZSk9
        3B62erC5TMsm/NmzXirR7yAUgJ+501sDH0aauRaRY1n8fJVh7FhXK8IVdmPo6cyssw==
X-Google-Smtp-Source: APXvYqxDXmnQpbTfnKHxwWKEHiAnm5HDPFf0Na5cPMw/tFx5BP6wBOsl5jdt0xMls7c23haoHM3VhwNlwb22
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr4601088wmj.62.1565723996474;
        Tue, 13 Aug 2019 12:19:56 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id q2sm1473920wre.51.2019.08.13.12.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 12:19:56 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxcKq-0000z7-1L; Tue, 13 Aug 2019 19:19:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 659F92742B44; Tue, 13 Aug 2019 20:19:55 +0100 (BST)
Date:   Tue, 13 Aug 2019 20:19:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
Subject: Re: [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Message-ID: <20190813191955.GJ5093@sirena.co.uk>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <95c517ab-7c63-5d13-a03a-1db01812bb69@intel.com>
 <71fb21d0-3083-e590-db83-dbe489a4357e@linaro.org>
 <34a1a317-ac6b-bb1e-6b1b-08209f0d1923@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <34a1a317-ac6b-bb1e-6b1b-08209f0d1923@intel.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 07:29:50PM +0200, Cezary Rojewski wrote:
> On 2019-08-13 18:52, Srinivas Kandagatla wrote:
> > On 13/08/2019 17:03, Cezary Rojewski wrote:
> > > On 2019-08-13 10:35, Srinivas Kandagatla wrote:

> > > > +=A0=A0=A0 if (dai->driver->ops->get_sdw_stream)
> > > > +=A0=A0=A0=A0=A0=A0=A0 return dai->driver->ops->get_sdw_stream(dai,=
 direction);
> > > > +=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0 return ERR_PTR(-ENOTSUPP);

> > > Drop redundant else.

> > Not all the dai drivers would implement this function, I guess else is
> > not redundant here!

> Eh. By that I meant dropping "else" keyword and reducing indentation for
> "return ERR_PTR(-ENOTSUPP);"

The above is the idiom used throughout the rest of the file.

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1TDVoACgkQJNaLcl1U
h9Bc/Qf+N4icKyyTDGlB5i1IOi6wDoQsSE1SgcAlrHFKoE0fOmNhKrhSQvskWPhS
4k6/x6JLxBu8CH9ZJAq8njVhSJ6BdfPkPM7H6Nd0tA29DaUCwHR4IDeZ9iIuAMOi
pX+z060wwGKdMbQUbYMOR4P1eLL1LYlxVZx1zWjXSxsDoYQYvhg8lMkeNDc6xLFI
smVcoYd0fRYsLRZtZXfSRQORdKdlYh34z7uLXkSTQpQIJtLH3Okb3U6pdOhkD1fu
steqUnEf89sHiHNuXZ506xZP8iUlLK13pzSfizTyI/Zl6Qp9PrQuMtN3KW5P2ZBT
kdXtRZSolgTjhJT5CgVHQUA8yneXgQ==
=vuyE
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
