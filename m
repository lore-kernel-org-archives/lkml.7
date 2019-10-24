Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75456CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C7F21928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDgBQuLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439405AbfJXLuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:50:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38206 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfJXLuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:50:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so2291828wmi.3;
        Thu, 24 Oct 2019 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTaYwp4qZXlJvMAwS4iXKftIgoAUkmfWWcCon6/YMJg=;
        b=aDgBQuLIIoqRlDd/Y3c+xWyM81CmMvlByTYclS93SsJVQqIN3nLJgUrH0S4PieBKXN
         k1rVnqdVpgKOU2/ITuTKF24yvCDzfJJKxiT7Po/KlGPbqtGOnLfYT+kgGePav63jbt14
         jh8QYj907cxiRu77a8sIMb493q3bRcaQ2AukPvb3gn1Dzc8q9r6VInJpD29NRcUK3VKi
         /8Uq1MWtRQFwmdWW2LPoK5LCD9ggyfvmiM16AWwEW0STET0e7v8+j3ADnGlwcn48dyiV
         k71jwi+/8YqM9KkRYfwmd/V4VepIlP+s4w3pGemdpRgoy2gAQV2SD+JqdCoT6QOBOWbV
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTaYwp4qZXlJvMAwS4iXKftIgoAUkmfWWcCon6/YMJg=;
        b=Pw3OxloeWasHkGBkS22Da1mlQwtO6aJtluhMBXNsFLdOWrXycYjQvNRNuPjvC8TL5p
         /pnLrH3d8gYfUAnkB5Fcz/Zz7g5dm/zLINxkYV2yxJEMMx5Ynib3RxFjE4ZlqwzyJ6qI
         lCG2y4RvJ7mCIyRDfcAIg2OvWRc6Gzf+DMHXE2ttSABFp+ieaHouI6rAkfBnTEyV9mdu
         mXmHxjJIW5bKcdY5nhJgjXJos02P/f0gdzNpUJdvW1hQrPjaCVmCwBKGZAvYXEZMV7Pj
         mQR5oVCi7TnuaRe5vBPWwXBGvbG/moawPmNyzOKupzX2gNyvFwbZZRl3fxz7cZueHiWM
         Sf7w==
X-Gm-Message-State: APjAAAVl2F6G6qiXsGQbQyH4sKpwAbp1f2m/Uf1UmwwXtT/oFQFExnsg
        Id56k2G7TRsgdhrPNzqQrp4=
X-Google-Smtp-Source: APXvYqxBPbJJRTAt4tbFmXMSYKLVZkQ5Z1Ry8t3R4o4pNtsOWPojoX4Y8SURN7kbq91D+f3FQ1WfZA==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr4396831wmg.71.1571917822265;
        Thu, 24 Oct 2019 04:50:22 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id z189sm2833364wmc.25.2019.10.24.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 04:50:17 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:50:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
Message-ID: <20191024115016.GA2924027@ulmo>
References: <20190623173743.24088-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20190623173743.24088-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2019 at 08:37:41PM +0300, Dmitry Osipenko wrote:
> On ARM32 we don't want any of the clients device to be backed by the
> implicit domain, simply because we can't afford such a waste on older
> Tegra SoCs that have very few domains available in total. The recent IOMMU
> support addition for the Video Decoder hardware uncovered the problem
> that an unfortunate drivers probe order results in the DRM driver probe
> failure if CONFIG_ARM_DMA_USE_IOMMU=3Dy due to a shortage of IOMMU domains
> caused by the implicit backing. The host1x_client_register() is a common
> function that is invoked by all of the relevant DRM drivers during theirs
> probe and hence it is convenient to remove the implicit backing there,
> resolving the problem.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/bus.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

I don't really want to do this in a central place like this. If we
really do need this, why can't we do it in the individual drivers? Also,
we already call host1x_client_iommu_attach() from all the drivers and
that detaches from the IOMMU as well. So I'm not sure I understand why
this is needed.

Thierry

>=20
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 742aa9ff21b8..559df3974afb 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -14,6 +14,10 @@
>  #include "bus.h"
>  #include "dev.h"
> =20
> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +#include <asm/dma-iommu.h>
> +#endif
> +
>  static DEFINE_MUTEX(clients_lock);
>  static LIST_HEAD(clients);
> =20
> @@ -710,6 +714,21 @@ int host1x_client_register(struct host1x_client *cli=
ent)
>  	struct host1x *host1x;
>  	int err;
> =20
> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +	/*
> +	 * The client's driver could be backed by implicit IOMMU mapping
> +	 * and we don't want to have that because all of current Tegra
> +	 * drivers are managing IOMMU by themselves. This is a convenient
> +	 * place for unmapping of the implicit mapping because this function
> +	 * is called by all host1x drivers during theirs probe.
> +	 */
> +	if (client->dev->archdata.mapping) {
> +		struct dma_iommu_mapping *mapping =3D
> +			to_dma_iommu_mapping(client->dev);
> +		arm_iommu_detach_device(client->dev);
> +		arm_iommu_release_mapping(mapping);
> +	}
> +#endif
>  	mutex_lock(&devices_lock);
> =20
>  	list_for_each_entry(host1x, &devices, list) {
> --=20
> 2.22.0
>=20

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2xj/UACgkQ3SOs138+
s6HkpA//YOpfeYtP6xh+CQ5j2ZbD2rIvdDo20CunZvL5l67FbNp+cPfNZ5Pi6oZ2
dkOn/d+D9+xSOA5ix6QA4/wz2wb0mzpw/FKv45y09hWl9znqrdB6SNiZPXIewFp7
/CPbN/7MsZOA/s8VO2oJV/iDXjp7RHMXQANRe2myanv/PMcP9MNNtv192rQoevkS
Co1WCPbmJjeGIe0Cv+nBtqc53+YW6zb4vNKzLQ9l3aE6AZW61C3rS65y0bhdqCYh
yYr7Rfd3lagKZbBoLShqMDijO/OntWsoPb2aqHOfJrRwYEzrgquhfkGyzxEYlOZz
O9eAxL0bO8R9hswcUAh2pNyYqpWDPA/97JffHDV71xvyQUzqgSACi0+3p1mQrVfz
6sCx8c0pJ3OesuZIQBWjdyNAgJXoKeGTlg/GKO2U2uu2PBbqQLRtagQnwkL+VJ4b
YD8OWcrtwjcFWxsqYesZecAi359jdNWsvtnaJxbyFtsXPmldBq7u8/aKskbCSfDZ
GgvaJlk9BTRYeU7gGVS30s4gY0SIwNmt5oDQ3VzaEGuwHDDzdt8+JMT97LmfDq5S
mFD7sDlfoGAAI8TQBaqFVP3lJ0n65bN24Nye1z9zDE13Yb+mmylyB7wsXw2J/JZr
N6PjGf93wqnopXfUpDU7r+CoC/VOLHuou6CNipxhKA+bbslRKrk=
=/3Lb
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
