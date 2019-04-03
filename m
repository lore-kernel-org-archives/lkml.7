Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3529C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC722148E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzhZccbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDCIlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:41:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37239 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDCIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:41:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so20141922wrm.4;
        Wed, 03 Apr 2019 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tiELVaFfJ/+OiAQ9hbITDe9Vde9bklCzFMjDBuVa+AY=;
        b=XzhZccbhUmymoqp7RHmgEvhLWAyTi6yYsfxAcB2vSZweoMHiwSU6jpWs0PRSr3jdOe
         3WUFmhu+06Wf5NubAfICRTKEdPxL2P3VHLlXvldHtiOMwhDF4kNLp9jwHsxz+Yel3mm5
         DJxe6+LDVuwWZllWkADnZxnNpUa4XYWacE5EkKTId9PbA99tUL6wGWPW8jRqoV4G5feN
         b8530rOBy3yAt1sA1OFESyS08swRh2ieGgbdFOBmYW+HxA4TAqFwcbKloZWk4F2ZqRsW
         jAlA93mosrpjFBEsNLC8ym5GXlLiT4eNthy1bnUIv+nrIm2xgRnN68YfluG+Ay+5xory
         mDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tiELVaFfJ/+OiAQ9hbITDe9Vde9bklCzFMjDBuVa+AY=;
        b=Er7Z2HdMzVc0qabyxawFb7ARwdBxDs/BUL/b+PudZKD2F2AJLbXahiaOFH0o8dU+x8
         RVKefRBFVGxAFRg4OsA4tOIxgXUDk9XcmpLMpnVkYxeFcsp53kB6OI4h7MSEJGuy4+mk
         vhe9AM+W8F0VK/+KY2irpaH1qT0ndb4vn/Z9PRcmmoMgSioC8H5yOjbX8PrHgxEue/fx
         H+HCATBDc4ioy9VbETXIZBrhxGRTXFconvktUHCJHB0mlvxdKLz78HZ14z0fLwAUJGSI
         NciI7sSRf+iONgwJxuANDOPyB1kE8RyPMyXHPE3Qk2T5I+KJgaNUlR+9UN6mDzMo9GXd
         rocw==
X-Gm-Message-State: APjAAAX3eztT2/npyQ4yQ9zGWCCEjeRNkEKoh8LS6/NBNhjCZP5nYxSB
        LZ8wHGzkt1Jqpoa2zkJONSU=
X-Google-Smtp-Source: APXvYqx5dOZ+CaI+U/3RoK//TodAH5weO91zGJIDaSeUbRbI+5oQ5VrmvJ1ljZ8Yf+FZhGO4qf1uZg==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr5343532wrv.45.1554280905626;
        Wed, 03 Apr 2019 01:41:45 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id o130sm23719922wmo.43.2019.04.03.01.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:41:44 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:41:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] iommu/tegra-smmu: Fix invalid ASID bits on
 Tegra30/114
Message-ID: <20190403084142.GA5238@ulmo>
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20190306225009.3391-2-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:50:07AM +0300, Dmitry Osipenko wrote:
> Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
> the TLB_FLUSH register differs from later Tegra generations that have 128
> ASID's.
>=20
> In a result the PTE's are now flushed correctly from TLB and this fixes
> problems with graphics (randomly failing tests) on Tegra30.
>=20
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 5182c7d6171e..8d30653cd13a 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu,=
 unsigned long offset)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
> -#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)

Given that the same operation is repeated three times below, it might
have been worth to fold the conditional into the macro. That'd require
the macro to take an smmu parameter, but would otherwise leave the
individual instances shorter.

But either way, the fix is good, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykcb4ACgkQ3SOs138+
s6HhKA/+IpRuLcBkUwgiebKV4hTvqFg1deczqWWrMafxSFjSuPWer+yFU9nlgZ0X
4h3FnxqTNu+Am7oDc1mLuHFw4ylmxprSoXrrpW1QR8PYk8fbfeMKrs4jN4wdLKXz
qK5zTkL7U5t89vmbRu52J1vN/zeulAigPhCnhGNquCGWQ8Rf6so6/ZEpQ2PY4dee
IlRGRQbLUFYuW1+eQ5YjO/8u+7Fe8qMYmnabkdMiq/aSG4NrDZSC5r67eoD6j+JJ
C/t/fhKz6NccAkpE9YmfVNQk+cFeqqzoyOXRY5MuJ/0mPDr71Xfk8HzAOjicxK7M
ZssbwXqhPqQ9TuZNvBZM4mYZzPvDkWk5dTuLGxe3gGM7qMdiGJsOX0h/xEmdWtpt
Q1qhqjLEXACVl3Fu38Roc/TIUJlSsDuPmrxArqhS7JV6SUXIkAi3amCTrlfkqUMt
W7fDQMH2Lt+r/tmyiIM7Z34aQVbi9jC6ORY8gy2GScNGirvKJDTtd7Ygk5fveMll
BCHCM3ULuYqTzLwVrUkDCfMko6eIdzrvjMQc7v88cWvMBaTR1Z5HZVHeYirrHdd6
QM5m/wU+XmBOLriUVyDukZWNnhZ523bw2TM6KlhNaM6IKxz7lIZhMLBITKmhvNPH
AP/e3KF6AqcT0Gk2f2F6xFFM3hFV3bQZHuP10fxMAkfhvwGh/9E=
=nX1U
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
