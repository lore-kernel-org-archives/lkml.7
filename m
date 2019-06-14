Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75688C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4945A2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnmHLqPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfFNPsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:48:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35555 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:48:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so2814319wml.0;
        Fri, 14 Jun 2019 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Bvz3u8t2ujf4DJ9DCf0Q3skrJIVSOfEOUVgwXCsLcQ=;
        b=VnmHLqPeToDQZl4uC+0HNWQS1eOtcIcP+vosgyt8qr66idKAMLhW8fn2Sl0M6ZbI43
         MP2dIg6T7LPWIusawsCj6QEnILS7YVzUqvMgo3Hwst4GyoPhnl/GIcKb1TmXDSYoDbdt
         JWK5v8OASHNKpb8REdASiegYdK4SkuioApN0v2Zh4kImOJBdlG5t9WCjh0lxyGkpxmRg
         ASDtRDuRLBmI2/rMwiNGZT0DOMSs22/FENuN2PUQgk8YoQ9lXFRXOk1G+VkE/QnDzAA1
         u1hg775y9RKS7acUDDoc0zzzYijrI0JVnvSikCiMeIZD5Wqq6wq4JXLISchfp0BJeOQ5
         5FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Bvz3u8t2ujf4DJ9DCf0Q3skrJIVSOfEOUVgwXCsLcQ=;
        b=K5NsvbsJTAhOWNsazbjv/O1N23JT/OT0ZTp71gzsrhMmM1N7wxE4zPSNnRE/d6dKGi
         pt680zqD0dEXq1DjV3D7Fbp4tR37I2Lr3l4PvNcy8mbCPTYVVPCImjG0a1UxJwHwfbP0
         EoigqKmR9i9gNPdyyKOyOZrBY6crnC23BjvuCEwfloL1X9jYHTqV+7ti9oSB1DnRmwCB
         WE9CD3I71ilZ/vp/ky9V/R/sB3NNZWt+f7QUcv/WbyjmcnSeE3rdoP/XZCjnZTJzgSrs
         lth1r9f0wQwIAxAKTjoUg4N4gxMzR+XCYsc7q2d5WgrhVfeflKP79tp3l+tIvlxr3qLM
         nheg==
X-Gm-Message-State: APjAAAWPVZ9CUz+bNyASzdZkQJoh6AAMujRXsQ++t41C96xWQiD4lrsw
        jfuxYvKfym6h1GkJT1Jyb/5R7+NO
X-Google-Smtp-Source: APXvYqzoLlA+WObLgXTJm1TmuUHSh3XQLTLejA04LF06qSa7W+eb/Rgp6mPb21FHjFnzqxdLnLMcQg==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr9067217wmh.76.1560527308855;
        Fri, 14 Jun 2019 08:48:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id a19sm2094945wmm.46.2019.06.14.08.48.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 08:48:28 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:48:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bitan Biswas <bbiswas@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Sivaram Nair <sivaramn@nvidia.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] firmware: tegra: early resume bpmp
Message-ID: <20190614154827.GA26922@ulmo>
References: <1560515499-1015-1-git-send-email-bbiswas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <1560515499-1015-1-git-send-email-bbiswas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 05:31:39AM -0700, Bitan Biswas wrote:
> Early resume Tegra bpmp to fix Xavier clock rate error as follows:
> [  159.017101] of_serial 3110000.serial: calling platform_pm_resume+0x0/0=
x58 @ 317, parent: cbb
> [  159.025501] of_serial 3110000.serial: platform_pm_resume+0x0/0x58 retu=
rned 0 after 14 usecs
> [  159.033694] tegra-i2c 31c0000.i2c: calling platform_pm_resume+0x0/0x58=
 @ 317, parent: cbb
> [  159.042254] tegra-i2c 31c0000.i2c: failed changing clock rate: -22
> [  159.048216] PM: dpm_run_callback(): platform_pm_resume+0x0/0x58 return=
s -22
> [  159.055553] tegra-i2c 31c0000.i2c: platform_pm_resume+0x0/0x58 returne=
d -22 after 13072 usecs
> [  159.063875] PM: Device 31c0000.i2c failed to resume: error -22
>=20
> Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> index dd775e8..de09036 100644
> --- a/drivers/firmware/tegra/bpmp.c
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -811,7 +811,9 @@ static int __maybe_unused tegra_bpmp_resume(struct de=
vice *dev)
>  		return 0;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(tegra_bpmp_pm_ops, NULL, tegra_bpmp_resume);
> +const struct dev_pm_ops tegra_bpmp_pm_ops =3D {
> +	.resume_early =3D tegra_bpmp_resume
> +};

I've changed this to be static while applying to for-5.3/firmware.

Thanks,
Thierry

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0DwcgACgkQ3SOs138+
s6FrSA//YUjeQWiQlGeMcSwux1wp1dvL2rCYk6E9sAfygd3R6A82DGnwaus1D059
3mxsdy6EM2cevn8/nGzE9iBr3W0DuLhQq9PSKQmzhpB0vbBB95MrgJsuz610qFA2
oCErRcoIq1dSP84mjmdf+JyOoYuO3xfclatViHtpmQMFxiHivmLZOdnA4gRfZG+4
jIDAOCPwl+XHPAM3B57ziuW/vP03+FD3bf3/ZWQhoRaTSJyXAg0fbnZKM/CtE8sO
8DYSx8w2zYjC4O7UhUo/TLzF8rJVtztxN+skWfkGiSomOuCmbbk1P+WasWwnmWbK
8YxS73oiGHY5OU44UXFaB/v3G/khoAdFq1iPLRyO1ne8NGrvD85FdturGN341Uhd
1V9ptlMApXxlC4wi2ICb7MiunBb4EsNDh/Gm9TXyUgc6vwSJTkyPQDrnX1NePd/L
BOoE71cZOHMp1wKwHOwiwuXpr5py71BPB/Zcn7P1KphFUlC3IEDoXLP2NttltizB
glhG25km0jZO5EV/h3HFgYncVVf2Z1FR6i9Q7WkljtzJNvPGcZTJ37rF8A6q7avw
dHJXAPXfITIIxH063H0LbWKo8ium2TYSo3hVhxLo8YSO9SlpldPLsT8CyTufejF6
fAlL1vxehCsKl6cz5QmXnOHup9kHJFsoPo84iuV6FC9AporHFyQ=
=BROs
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
