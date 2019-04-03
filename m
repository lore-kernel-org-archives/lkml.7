Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA84C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47A221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba67k8zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfDCInw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:43:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44154 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDCInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:43:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so20134148wrn.11;
        Wed, 03 Apr 2019 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dz/LxYLvdS1T0JAVoNkRhUUKZqB3gzQBaljPyU4T67k=;
        b=Ba67k8zid+iiTXak1I+DRajUxeEFRgBGdepHcIKOQEi04UKgzRCkBMHZ25csm0nSSS
         pGzMysmW+B2atEQTE5gqGOzspzaFTdLboBiRYlFX8HaG0H1bInySOqLkLzJI/Eg28Ual
         +EiRi9R1meaq/UtvL6x+ctdeR5S6g1BmL9qMqlLjrweGAvHjWUdIvlcvEDpsiARcRzL4
         HNtj+8v+owtM4b2AXL6XuY4TpKUbqF0o7OAMTWLwCDpBMu9jDwaHzq+mroKbnAwnKuKS
         NRLSAJkDgbBaQd12icKoRfYgCKkruksoNG0pthaNobBa4wmOjR879IFy0YBapgxv+cef
         Xy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dz/LxYLvdS1T0JAVoNkRhUUKZqB3gzQBaljPyU4T67k=;
        b=fnbwNRDBsaUrFMZSnOyMtedWXKVp1N/fZr8Fut+WJCxEFcOwduZ5fqya7C0gIYpl0z
         HoCRf9Upz6k3ZCerRgxvqiET7UghFd+WKfCysmQcfBQDQafe21dXaqEipcFcyPgAuyaf
         Fv6MBdqGo98vo8ToDmNABR+a0uPXjv3RLmuJeF4DZs5m0I36MqeRw0MMaU5DWLmzv2mv
         d63t83X065K0z853M0W/3ptsGLE64A/nF89A4Jv+9mwQ5z8phFDK16ldAX+6pp/n8XHH
         DkjfKEglzJwNCycE5cHpGtYXyN8VAiQj4vOSsboTpNAXihOGpW6N7OQCCuRFfnYz+K/L
         ZChw==
X-Gm-Message-State: APjAAAXSRyFAZleRXd/looMcykvgiBkzX5yuKtweHemZ8TUFc4GMPHZt
        RMRLut5+HnO5Vq+p0s/ndDA=
X-Google-Smtp-Source: APXvYqwYV0K6vHkByf5GsGj1bolEW6CfAHvcVVp+EGiuEin7x/pDacNCe6bHFAD0GjdWKEritkV+wg==
X-Received: by 2002:a05:6000:14a:: with SMTP id r10mr22286150wrx.107.1554281029072;
        Wed, 03 Apr 2019 01:43:49 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id z20sm3276449wmf.34.2019.04.03.01.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:43:48 -0700 (PDT)
Date:   Wed, 3 Apr 2019 10:43:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iommu/tegra-smmu: Properly release domain
 resources
Message-ID: <20190403084347.GB5238@ulmo>
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <20190306225009.3391-3-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:50:08AM +0300, Dmitry Osipenko wrote:
> Release all memory allocations associated with a released domain and emit
> warning if domain is in-use at the time of destruction.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykckMACgkQ3SOs138+
s6GSzg//cVlslOgK1ZaY2ZafDCO60gxqAHS8eLwbT0IXpDfdAcd51IWQwI9zvv4f
AY+eNqVuzrwccsL6gYnyZuIcp6v1zryeab/2VP7QySfoYTF4AXLXsZKI1bEBeT7H
fyq0Vg16P8BrIuzptVQH2H1ElgpRVjrsfIJsV33pqN8rn7VRMQYRPMXhXY1sC5zP
+7zXyg8RYKVtFhbFXuzm88QNk19DZ1kXgfIVbLD7cQ800MqE7eurwOwwxIOQlWup
61xgQHRWyRRgEKniYUR+nBxtf5MMvwmWNVXuHIqIpKrU5qt6WF4fSsea3eXeOIHV
Ubbu48yHrYHogZbH+GXPWZKAb75tapqqc0VbDbB7KVP2y85GnHHa4TPO7DOKLDv9
Uv6HPaDatWts7Es1XWkHdNFG+yhiMe+43bC3dKwfWfNnGSoBQ+WjSDOUr/zjMAZs
TNuGaO2C51H40LKxxmDYU3Aq1Mo9n9hgGnyANBK7F7PrV58QCzwVRNuX8CfXXdKu
DagdnXExfZqPTvXtE7UXqC6wR6KhRk/goEuboZ2TwBFqFPU5VcNSmbabv8vGRFnW
gUccLURShcs8OKfmTOymI7FHQQGkmI1U8JNT0KZGi4DgeC1/ZSyS8Rrz1GwXOdpA
wkwHMFstN4rfiKH2FTzwToaUHKHeXVKqeKgX6tXPSdBakDP58xs=
=51+Y
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
