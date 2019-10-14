Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E3C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC68A2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQcd8id1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfJNNZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:25:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38157 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNNZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:25:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id y18so10278217wrn.5;
        Mon, 14 Oct 2019 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4wRNeAmQeU6KF/xY7xB28T1cCU8tNpyHOvvEk8pe7I=;
        b=PQcd8id1m/X3CX6HW9q3xr0dhRdQBjo3+5VnjmitGWkbKtadhjdWiFJvt+IuiuulMC
         UHbaYSqhn8z89mcljHyzd7tCHp6ehFVnu91kuqYPvUjOwIJqIoCtuXaI1hhUU9I3CtiQ
         kkPKBeoXAdCmJkqXytRdpvs+NW8HE7z5APA7y6bY0DgZTRBy35E9R9NOOI89FuJXm91V
         f/ckB6cO4qfMX2auZB2G4GyveOuSs6AgEB+9brNQquZQTUxULIVQ2ahADRsJSOkcy5OW
         5y8LCvMlJxMgNm29S3ic6pQBvi10eWOkaIRD8mq6RAhTB9sbklKDN4SXsbWaUgBgEDyj
         FApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4wRNeAmQeU6KF/xY7xB28T1cCU8tNpyHOvvEk8pe7I=;
        b=EhqlA8dcKsVn858ZEVVCDXryQA7Io1FoMm97fDCuwRbmx1bYJcuv4eVNwHy7szd1gm
         K/tsFFcZuLQPFOvDnENJiqrg7gPbHTmsA8V/DjBdyw02cswpc4JxJBsu8KnUSvNGtUnx
         q+jSOX1BSD90COYgOpVljURQtohmxGNuxDmGsIyH5FQoD0SCCjSdS8u2bNhD8z055UBt
         XenlikRoKEf/2gQGawZLrTs37jiM/gLgdMU1HMP5gXUlIxk5u2BHuB9E05Oh4XPa/TW5
         5Si+y/Z8YxuiFTGR/L4rAd9Ly1U4cEMup8/GK1Eec7ctaUSs6vOaNdRWxYnuigVICjBS
         a8Jg==
X-Gm-Message-State: APjAAAXR+sTuzS6KSsMROWoLQ1T10CyHfW1XX3W0GO5DggTEq0KQoLsC
        vH1tTCte4gcYc92DRlbS+ig=
X-Google-Smtp-Source: APXvYqxhLow/vhAk2PV0yH8RlRMyKlPByDDvUHrnnrW9Uu9G7yAN5sItRGV4yUn3aQAoLn3tYhEiUQ==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr25470991wro.285.1571059500709;
        Mon, 14 Oct 2019 06:25:00 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y19sm16868350wmi.13.2019.10.14.06.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:24:59 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:24:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] mailbox: tegra: Fix superfluous IRQ error message
Message-ID: <20191014132458.GG422231@ulmo>
References: <20191011083459.11551-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <20191011083459.11551-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 09:34:59AM +0100, Jon Hunter wrote:
> Commit 7723f4c5ecdb ("driver core: platform: Add an error message to
> platform_get_irq*()") added an error message to avoid drivers having
> to print an error message when IRQ lookup fails. However, there are
> some cases where IRQs are optional and so new optional versions of
> the platform_get_irq*() APIs have been added for these cases.
>=20
> The IRQs for Tegra HSP module are optional because not all instances
> of the module have the doorbell and all of the shared interrupts.
> Hence, since the above commit was applied the following error messages
> are now seen on Tegra194 ...
>=20
>  ERR KERN tegra-hsp c150000.hsp: IRQ doorbell not found
>  ERR KERN tegra-hsp c150000.hsp: IRQ shared0 not found
>=20
> The Tegra HSP driver deliberately does not fail if these are not found
> and so fix the above errors by updating the Tegra HSP driver to use
> the platform_get_irq_byname_optional() API.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/mailbox/tegra-hsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Perhaps Greg should pick up this patch because he's carrying the patch
that adds the platform_get_irq_byname_optional() patch for v5.5.

Greg, would you prefer a copy of this in your mailbox, or does the
following patchwork link suffice:

	http://patchwork.ozlabs.org/patch/1175012/

Either way, this patch:

Acked-by: Thierry Reding <treding@nvidia.com>

Thierry

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kdyoACgkQ3SOs138+
s6HehxAAgC4Sj44wpLRlcNKL7bVIgUtRtc6C5Wu++Zsj+4UDw82vgYCVrFU+dAgy
tApzwfpUXsP9xnkhU2QxCXs+bLDJTa9amAFXDU4FyPTVZBKYk7SB7YgO6h5EvPC2
kmiRIPFaGj79Ufmn6ZP31RlYt0r+VOPdd0ihsKXWuItYlFTrbQMdQpfQuRuveZUD
UCn2RUu9CLFVkNb9HimfFDoSVo+/RiPrzFptzYBAtLw6uePdwj9cS4NoHUp6Q82R
+Emvumx0gkYE8bbsNEZce+hU1jQncjk8JXWLLdFRVDPOGlAA6V+SZd9awIlfKizX
InAtf9AkyPAALGbPJzrg4VmJxzOqlZK1f2ESJSlrUy0q6WFy6yh/6cuDTa7+eMbP
F/Z3KNyelVIB08JEmxvaeHLemX51QDaf34LKrshkMJXg+jh5xRHFyDrlWAm0zZpy
4917C1XKHHQXNcfuW5LVYvNF10gOpuTWYaLSCeCG4E7xZqvl2Ry1NVHmRYr7WPnH
tt5RmPxyJHDB0EgbLIiVcXh2QKTx6aXQOknFzR3Lb9uyzq2EBT7EwpR24qoJnr5Q
9EN62+A6eSVMuy8t6cAD2Ssn5AWPBu7zcBmZfBPNqqvoEIBgqhwbwkKadq1UMD7d
WWzI2TH4xWAqcd8GdmuZg51EsQIcR2N1zKCQphH1ZvveAMUDYqI=
=Kp6p
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
