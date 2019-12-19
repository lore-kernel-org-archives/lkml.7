Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1B7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007F1227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/5sdBgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:55:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLSMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:55:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so5910277wrq.0;
        Thu, 19 Dec 2019 04:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V3fymhAFRSx63bHLLoQ1qANwG4LLhRhe9/8uuVFjrM0=;
        b=e/5sdBgs1ziYl2+JSPeok0AkZEmAR53sgzGrqwZ32Z08EyjwrfvIzeoQM4T8sjXqYP
         TA9WeTymh8R1WQnwDZ+eGav2eBcOU/Gh709ecwWEL7hkr3C3SwgRlIRMgr/1Dk4k+1h2
         uEmRwEsjLZjt7b6Rv0h+tOYWzXyudWgmunzJ91neT8IQi40tVR1h1Fa8PhM3rB+fjN1W
         XijQXDuMgukjMd0ColpPdAWsUqSnqOlRzaBUl4WEjYGlc9OHkjrbP6dJgVep+bc2DT/2
         AvfPmVX6mCuLsf51GhDTTj4oba88m32pldaz7M1SA01vjc4k8NejdW9sh1LS4pQ1Wkks
         wRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V3fymhAFRSx63bHLLoQ1qANwG4LLhRhe9/8uuVFjrM0=;
        b=FI02HIeVov+WzeDSFQA7OE1b4pSBIwsfQ5oyW9jrXZkrNVwvHrfr/HW/wqxS7dRc7p
         5+C7JfNcimW3IXgWXVqo1Eiv2fvzNBcDJ7smM3osBSt66KCoD955By0TwcDN23QMFKcx
         bejg29p+2jZKRl4qyqkZbcz2uyora6ewc5xaAZp3qfb1q0p9fak91Wwf7V1jOMOlZeeP
         nX5DzIu57ec0p6tF1KwTI3yzffPRHNbjFU+cdPLNOzpCoy7DspHeHyF+A5VMi52Ahd7p
         KVNMxbAKY7kixUqLeHx0HP9I2iiWpsok0n8+t8QfZneeZJRu+sB9H3ORKiJ08vD9i96F
         e9eQ==
X-Gm-Message-State: APjAAAX+jcs2RsdULIvih3Sv0Lrn8inpuX54gc2wDfMKh8mITDz5IJbR
        LJXYBydZLdGlvR55X54w2Yo=
X-Google-Smtp-Source: APXvYqzH3/vRJqNfoOBXa6HNYcbpnruGq2ZGUiYgioN0jXAEpwMllyy4+IppaSFX+4lrbK4KXwODuQ==
X-Received: by 2002:adf:f885:: with SMTP id u5mr9471206wrp.359.1576760117052;
        Thu, 19 Dec 2019 04:55:17 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id s15sm6684065wrp.4.2019.12.19.04.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 04:55:15 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:55:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] usb: phy: tegra: Use relaxed versions of
 readl/writel
Message-ID: <20191219125515.GC1440537@ulmo>
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20191218175313.16235-5-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 08:53:13PM +0300, Dmitry Osipenko wrote:
> There is nothing to synchronize in regards to memory stores, thus all
> readl/writel occurrences in the code could be replaced with a relaxed
> versions, for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 195 ++++++++++++++++----------------
>  1 file changed, 98 insertions(+), 97 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37czIACgkQ3SOs138+
s6HYyA//d/1tMFLOizTJ5NnTpWkjtiUdrRlwYMNo/u6A/FKCJfC8H45BdEmbGp93
b3W6VSuopFceXr1umc/3Fagd1Y72DRxSyazQcuFIDuoJ6d5MkGLEnpjZghyHzy8H
vIcsZwGWYC8VIS/rCTiE8PFt5cV6vuR16+CU2dACu2p0AtX3NfDuq+FgjzezwAxh
owUrtO5fJuedGYH+AAKG5hgIPB0QzCNtNEBBF56v0qbeRg5dnE/iVQIzKMrAzRYa
MQjEyGVztCB+jKuXTd5tJBXrGOtOLrzt/xHfizoUgO8SBqXCjvuFqhxBUtAFpwEO
KAX10NN1+LZAxim4i79KuaHXUFWWUwn7nJMncSenseT3BeVaMXq7gS2TjPSVA7te
GP85v00Yn32nSCB8Ez2t77ZHkYvbIlPKJmee3xL0KQkVO7UiqJns8o5A1BlFqRoU
4Wu1Rsg4uRiGO4i4XAxxOlZQBTYgcSw14yIIhxjH70/FQFRE99iS3e1gxAafHeCt
B3vKLILj5RQ96FGkDgdJLoZOCm8VVjN8UH6NNwU4OtG6hZptgSbm8DAy+D/qb/uM
kA3Xy6vFqTzkP1tZv3nIDN2Znc5v0xMmr8NdbX2F8fZ9W3NobiEt04KqYFAx+dH1
4phVoIUA0q3Cvr6lK5Pph8VRzrH2B3eUQVT4UGtdtSeZfYdgM4E=
=MWun
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
