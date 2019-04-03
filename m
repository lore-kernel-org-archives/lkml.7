Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E796C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD24206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugG+ZPxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfDCIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:44:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40362 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfDCIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:44:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so7150126wmi.5;
        Wed, 03 Apr 2019 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TgNJkiIJco64eBTAO+WtdYBGVP372Xd3zBa8xXutFu8=;
        b=ugG+ZPxL6C33RUOHfeEaTf+XoiqxkVQC+37gkRIOy31Jd8l0TM+nufJpJlGHBBuZdj
         1eibYkOVxrpP/Ei/ejWvFMGKv40rLoR0GGMfSa8Tr6mzRH2dLuNWWJyHxZpTslOFYr3t
         wnWL07Un460wZvxJtfYyMLJfUG2u1hR/27ZMjVxh0RFMovAnuauZpS/hAmV9PpDSjUrr
         DrC2afAYrhjpNhID4xBfNTDoM8Z97blN+nyivnOpwy/LK+elE3WAlnDojBNZhSUdXWga
         8CpdOXTipzrqxDwMR3Pz2UuyLSE1Gdsp+KaDm3qJ/OxiQ9thGl6mTzuYSnpGe5sdTNWa
         CAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TgNJkiIJco64eBTAO+WtdYBGVP372Xd3zBa8xXutFu8=;
        b=QzPiHoCZLnCz9+FPMhvWN23MjRvIpwD3/VuVxlPOlc8xF8sZ8ASR3KQIyJFCiyPfDl
         PRRP2PVJZjBjjcSxdoaFy0pxEB3cy/xYNBKY0J243q7BK3FOPaTGUwA5wIQ2WMjbrHrL
         vAUtUiu5H/AlGbaCSU3oK6RzEAwt9MFwKtsI7pGxQsL3G/7iMYRjbmxn/e1l/8juqa6S
         vUnN6LuiJ/fiPvLU83V3uWasbtFzuINGOMXsNwUkFHHj70mG0PfMjgZu/YGrdASIQNS+
         6c9dEM5dO+4JlauszTAo/QEWMtS6UwPVZC0nRRZP7KDxkloRdWjXaWoBtdrqCuMRY+3N
         l0bA==
X-Gm-Message-State: APjAAAWMPpKfTkm6UDNwcq59PggqcEdBya6Opbm2etnTgYuFKocr8oJP
        kyIgZefslaL91dcsHa/KDVE=
X-Google-Smtp-Source: APXvYqze7Zk81YamM/hxo1KAaLcwqgmzJlsAHK3xKvuZbJyM7So2BZRVXQdhVVTRMfdCk0D3o22EXw==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr1194121wme.91.1554281055988;
        Wed, 03 Apr 2019 01:44:15 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id v16sm29430429wro.48.2019.04.03.01.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:44:15 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:44:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] iommu/tegra-smmu: Respect IOMMU API read-write
 protections
Message-ID: <20190403084414.GC5238@ulmo>
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <20190306225009.3391-4-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:50:09AM +0300, Dmitry Osipenko wrote:
> Set PTE read/write attributes accordingly to the the protections requested
> by IOMMU API.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykcl4ACgkQ3SOs138+
s6H28xAAgNjdDZjkv5RLkJ4TWzCDzmFPgu2T9fGG6G1y/ZluTwUWVSufoTnXpQQA
fgPeZypWXbodkcIk8YRrPUo/vF47hNO4bJJrnFS6/7AQdzgHEf698LnOBh9mzN5R
QXmDBX/EmcwBL9Tmd6V8LIFN6FqrCl+q1jSi3odAFCbb/n+6AdLT4R2B7op1TvBy
xIV47Tq7pY5uQ71KSjT8zN5mHP1WNcEjWg3uuLp3OpZ0Ifv69ihvgU2xd8bGuayH
4IIu3SC4rAycDfPcYveq2EeVuuzuBXxPNiDUlEtCLQCYyNs0BC090xo3mQRBrKF5
rtQHvip+24w1HZxO4Na9eWm52h2Zhi9maw27cgYmfGRwwXA4z2lyYml/7+MOR5JC
tZKPbX5AnymdqAEgdsqAr+y3iGHYydeVS6Jbf//y0vPKylJDK9nUDZdFdFK2MA9c
sPUjYO/6zRdtqmvtg9EWja+8GGQ4/V+UlyswqjXNRv+qZEAxCg3l3gy9hZQVWe01
46zL5U2by3F4+m5HGXqUiQLgUSi5tzUHTl0vlcetJHi9vidKDqQTxlZo3bksjwNg
TmSlm1I6eUqvqE/dZsv0TCfigGvUTxlExOqxIkRcPnfH4y8VRiUtkFIto4u1idQI
g4KaEcvPvnmbd6X0nfPLFJDIhUWRNu1j28czRMFA1ODAzHltloA=
=1HwV
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
