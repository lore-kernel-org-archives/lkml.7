Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7DBC41514
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3642173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpALctmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfIBHiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:38:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42142 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBHiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:38:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so2817155ede.9;
        Mon, 02 Sep 2019 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BlUusxOrxaCgMhXu0ZvmfJnQXORRPsMrgdIIDkov7+0=;
        b=YpALctmpSx7YjEgiI9SuGVl7dMwk/SEK5o1T0kfxhfQ5XqdN12E4NwZ4afeqD6tdg9
         l2+WuDUpxBppRmdo4g27iv7JCGBTm0Oh+H0oeRLZYPjYOpbsWs4hcfmk8K4vt4ZuSPAL
         yEXUSIVLjwxpPSBN9vQeBfmTTzB7G6uR87dsjLuyBS3qGG15nAJFT5Xv65L5DKghKdJl
         zpEqeWsFx4ZrnnAAyeMpTTERCJ/8F6bOqai1AthPs2ddc4uQPV4r5aSu6Hza4BaKM6ft
         YhXXSuZHeqwmgj9GJ/XsnXYwKoqtSUjMKDti9H5vZt+dD+Wj/n61bcnjOwyxDP+ZSnBV
         NbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BlUusxOrxaCgMhXu0ZvmfJnQXORRPsMrgdIIDkov7+0=;
        b=TQh52+tWU/VHayZllD2c9lEYkfxixH30dWXHXmMIYIt/SHEOOMNxI9SDZ+i/AhNAfm
         Oo4pD+O22BEuFC31gKJN98IB05BX5Tmy83ZesmKH4UHjyc4iiPf2JBGIWnC4aXW9BwMu
         ZtGPoBkDAi+xMHwXQFajbJf4gMxbYPQ2nrp7yO6LoRKyEYlUTKzWCEB3/ihHVdxi038n
         VKPrQDL9RhD0GJeFblgWrFk9+P2IuCxzc3uU7Fyw3eo9tmES3kbpV/9nqvfmpUXhOGP8
         ZoH0QMT7AeQYe8tWzksF0pdY9OOlgyhusW8PaTsCR1FS0JaBaMrbhKDrQXyA3+Lzhhhc
         aNUw==
X-Gm-Message-State: APjAAAWdWtOy+H8tTR/67fJYOqXWlwJgd5sFJ+iEqtTjKAe/tR+kLzJx
        LmZuXHt8TpqLnrGgVAXexRo+Fef0STA=
X-Google-Smtp-Source: APXvYqwBFeYG7Dq7UMXgmFD2WxbHkj27kQRrNBFLJil5mA01IdIMDyjZ3VnT5a8rho8cIXtM7B3Xdw==
X-Received: by 2002:a17:906:318d:: with SMTP id 13mr22669114ejy.281.1567409888769;
        Mon, 02 Sep 2019 00:38:08 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id i5sm2751920edf.32.2019.09.02.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 00:38:07 -0700 (PDT)
Date:   Mon, 2 Sep 2019 09:38:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Sachin Nikam <Snikam@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/7] dt-bindings: arm-smmu: Add binding for nvidia,smmu-v2
Message-ID: <20190902073806.GA930@ulmo>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-3-git-send-email-vdumpa@nvidia.com>
 <37034b76-7e3f-5f3c-25b2-696e25127682@arm.com>
 <BYAPR12MB271012F225E35C1459E58D07B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB271012F225E35C1459E58D07B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 06:12:08PM +0000, Krishna Reddy wrote:
> >> +                        "nidia,smmu-v2"
> >>                           "qcom,smmu-v2"
>=20
> >I agree with Mikko that the compatible must be at least SoC-specific, bu=
t potentially even instance-specific (e.g. "nvidia,tegra194-gpu-smmu")
> > depending on how many of these parallel-SMMU configurations might be hi=
ding in current and future SoCs.
>=20
> I am correcting the spelling mistake pointed by Mikko.  The NVIDIA SMMUv2=
 implementation is getting used beyond  Tegra194 SOC. =20
> To be able to use the smmu compatible string across multiple SOC's, "nvid=
ia,smmu-v2" compatible string is chosen.
> Are you suggesting to make it soc specific and add another one in future?

Yeah, I think that's the safest thing to do. Even if we're using the
same implementation in future SoCs, chances are there will be some
changes. Even if the changes are just fixes, having a SoC-specific
compatible string will ensure we can apply workarounds only to the
implementations that are missing the fixes.

So I think "nvidia,tegra194-smmu" is a good candidate. It uniquely
identifies the instantiation of the IP in Tegra194. Also, if it ever
turns out that the instantiation of the SMMU in the next Tegra
generation is *exactly* the same (even if highly unlikely), there's
nothing wrong with reusing the "nvidia,tegra194-smmu".

We've done similar things in the past, where some new IP was mostly
compatible with old IP. Typically we still include a new compatible
string in case any errata are discovered subsequently. It's not uncommon
to see things like:

	compatible =3D "nvidia,tegra124-xyz", "nvidia,tegra20-xyz";

Basically this means that this is the IP that was also used in Tegra20
and the same Tegra20 driver can be used to drive this hardware on
Tegra124. The Tegra124-specific compatible string may enable newer
features if there's a driver that supports it.

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1sxtoACgkQ3SOs138+
s6GyPBAApW9UCw6JCRUfPi6qMLdZo6ec3gtTq0ja+vujc8MIwNw0hNPf3Z6XrJxr
23cQ6NAbVv869Lv6yBjoa/s90EimzSOn9MSQh7u5Vocwxv+ptUcL3S+zeE5cYWCq
6il8nVLmckknwL7lWG7gYfxJ0VC/jVtnzblUWSBQVUyRLNiABMEZomEvi9/8UaMk
Ac9m3z7K5Le2aWyAeGgh1jsrkb/Vmid9f8stmrsM/kwp0v9CVfxXR0C9Wwt/n91A
ibiOWlFW3mHuo0uadSLjyUFpA8YAj0dNsTCK1Gws0ojSoMMQM5arb+qSULe3tsmh
nylujZWpqzpjSxZJ/0TgJxgJONmgRLamvFlbmFQNuApVK3oTc7PHNC3GPQVB/owk
bbw4CNVlatnwXUPT+Wis14qid/rE5hxWHdEQTpAPd/kF5yFjTEWqHgDX1BPVMbnv
HpxQmPwq8+x1W+9eHMBWrBoHvGXI2V4p5szFvst4fKlWH2cyfDNxMgJR6K6zBze7
Qw81D3FhJ4ZdwsABSmMTULv8EYuCInKgZGjNPlmtlyuuAiKDZDU7xfxntVNvK7cj
ay0xxvRolXiaKhFL5PptMX7hE+H/hlNeFcBqzGtf0hHOupI2g6gCZrB5+5h93ovq
fy8z4p2GCZaEsJscj7Fp3nvBu+DMiFUp4rmygKSC+MWt4tMyXSI=
=+U+B
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
