Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B86C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F3621920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568024294;
	bh=0jzpYrQDQLNG9Dg32tb7hfka498MiOABCqXtbU9Cufg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vPkEzC4AB0pTRDNObnxxgH3mxjkAk/Y1JMEdysryzBWt8GJQdivxAvEal/8b8IzxV
	 QZEcVigiNzxbi1IckE67Fdp7W8WLr6uZOaI8Us1zS82ffgxONG60BOPOzHtL7Qd+0w
	 6sGvU9WCx0BuQS7M9oLrDyn9LhxK37gnJh89UQGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbfIIKSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390297AbfIIKSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:18:12 -0400
Received: from earth.universe (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A8F21924;
        Mon,  9 Sep 2019 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568024292;
        bh=0jzpYrQDQLNG9Dg32tb7hfka498MiOABCqXtbU9Cufg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiEFFr2wi7KPPr/jhw/rQudOlUYSObafeuP85b44ybynxes97QfXWDi+gATuA/DvG
         A0HoIyCs4IIHY6VYWPewPtN50qeVJ29y7P8Hq5sj7r8nP310sVrWxDG0gnCJOMG3Oc
         V+uRmW/NmhE0w7YpYfva4dj5WmydyQMzoA4j1/HQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 2E8153C0CFA; Mon,  9 Sep 2019 12:18:10 +0200 (CEST)
Date:   Mon, 9 Sep 2019 11:18:10 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Nandor Han <nandor.han@vaisala.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: fix nvmem_cell_write inline function
Message-ID: <20190909101810.gtqouke7vyu63r7e@earth.universe>
References: <20190908121038.6877-1-sre@kernel.org>
 <d5017670-5622-283e-1376-8161d6e39dcd@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qss4xo2ixrxhdmym"
Content-Disposition: inline
In-Reply-To: <d5017670-5622-283e-1376-8161d6e39dcd@vaisala.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qss4xo2ixrxhdmym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 09, 2019 at 12:26:06PM +0300, Nandor Han wrote:
> On 9/8/19 3:10 PM, Sebastian Reichel wrote:
> > From: Sebastian Reichel <sebastian.reichel@collabora.com>
> >=20
> > nvmem_cell_write's buf argument uses different types based on
> > the configuration of CONFIG_NVMEM. The function prototype for
> > enabled NVMEM uses 'void *' type, but the static dummy function
> > for disabled NVMEM uses 'const char *' instead. Fix the different
> > behaviour by always expecting a 'void *' typed buf argument.
> >=20
> > Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reb=
oot mode write interface")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Han Nandor <nandor.han@vaisala.com>
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >   include/linux/nvmem-consumer.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consu=
mer.h
> > index 8f8be5b00060..5c17cb733224 100644
> > --- a/include/linux/nvmem-consumer.h
> > +++ b/include/linux/nvmem-consumer.h
> > @@ -118,7 +118,7 @@ static inline void *nvmem_cell_read(struct nvmem_ce=
ll *cell, size_t *len)
> >   }
> >   static inline int nvmem_cell_write(struct nvmem_cell *cell,
> > -				    const char *buf, size_t len)
> > +				   void *buf, size_t len)
>=20
> nitpick: alignment issue?

This actually fixes the alignment issue as a side-effect.
I guess I should have mentioned it in the changelog.

> Review-By: Han Nandor <nandor.han@vaisala.com>

I suppose you meant to write "Reviewed-by" instead of inventing your
own tag?

-- Sebastian

--qss4xo2ixrxhdmym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl12JtgACgkQ2O7X88g7
+pq+5w//WFTsXR9hQ39fHiyVSsAdYdKNBuhCXUY94CzlZceJYrRB9YwbTP4lInFF
bTgIrC3myS3qLqEcXEpXOdZZmAw/Y7FjQFDSXaAia8NLOQiBiwhVRPcWKCxk1jKS
rHm2TIWPnTavtzQLI6m3xEcTpodfyYCrTVGRS12jNhQEokzuLrxEgP5xxX1d2KxT
esYmPbnOyW95kzLhoHk0Wt1gq7AXDM0xc0HbKxGuyrHFfmwOBEQiIGlZwAjvrIIL
ZD/EBfye7hNSAArgFz8ynehrj9vyxGPYUj7msIZYSk2u901MG7IaOVZpBYV9VBLe
CDk+uN/klWJlbBFeV9IMJ4nzgX5H1Rm2iuJ/hMZVcLe8s00IsgDhDOPBfbPlTjVx
IBZJMXog/ZQJxBsSycTPuT3swLRHvPQwnHjjxJYn6DkJYgY2xaBDwa/3d7t2FZvv
a02mT3t+AWqylKACzEYuAN/1xCEwJAhLuJACn2YXKtj0J5kOzBxcg4Y8ViW4NEJX
AFG7nqQ61hKhA0vljqUaWZDcfnNBM0szNISMqkd10YaOqBMRuUMATWsHr8cwd4L9
28ESIUYSBiapWFoPQByyq/plM25uhU3wCQ3oBqHsZE0cAoMzUE89qLMy9KFXoyvK
EYaznGEjO2JeRk/dJXgGt8gJD1Wh9nm4XiNtbmCzUUwFPL0Gd+k=
=5KCd
-----END PGP SIGNATURE-----

--qss4xo2ixrxhdmym--
