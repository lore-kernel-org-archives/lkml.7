Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20422C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF8024670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCNWEuVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFO5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:57:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39144 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:57:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so8076260wrt.6;
        Fri, 06 Dec 2019 06:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fjQyN0hx9rv9fintx6NLRb2PhJV7T1klApPwrl5e5Hg=;
        b=MCNWEuVrRVP5zm/6sYa6DENEpqlKNX9aqbObt2mF3C9wv7XotTpOL7uvdIjO0uELUS
         rBIUTwlBUpYY45esJfnH8aXVC/aXe5GaSb+IOCzNZ6B98z3vvu1hv811Yc04iSJqikJ+
         tE/23YmK5BCQEUJgcKAwpgXp7H3/iQLHcmh95k648nWCNs9UDIDdyizkwIYGcqFXV8YT
         mOVRZQdDz6WZxHqnz210UmyDjPb0odZdl+l6p2PT3SgmERSocXHd6jyb2Vzclc9eeRL5
         0vhEXm0kgvtWVDACYdwicrNDnIBQCsZNtnS5bhAzK7JYE/VWge4A/inpSGHEq6Hoe/c9
         +6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fjQyN0hx9rv9fintx6NLRb2PhJV7T1klApPwrl5e5Hg=;
        b=XHpSyRf9JF1AHMAYrNiwGYkzwjg4kF/B/E7PTWcuqfTWISOmgSpaSLOAZYYHVardR7
         D94EN4GMReb20vpgrmTk5LNrzknqw9mShSYEP7HTGFbw8tsAsM7YCew8cqbj72n3HTMj
         GItp/Z7aJEQ+gbvzi+2bkGm/Gl8DLO8MRKlq1jCsxbmi4Evgqj29VPfVijgkKUh2V8D5
         TX9lDnO0fUcVXQ1mAdo75VhQSXu1Pi557STalOX/nir3QDNymJVaQr7ZAezMA8yUpiII
         Z+kpMEU4u/jDKSBx2CCo2tD0LDJEQU1Y7jSYddJy7aURo1sgK/7qBK2pPEHow8fYMVag
         mnpA==
X-Gm-Message-State: APjAAAVckh/77JJehbWnx9LSD4gxpVv6b0zTDCl2HH4kVKxhTU+Dp/7Z
        tZXaqim+zWyPSILgyPAKeqo=
X-Google-Smtp-Source: APXvYqzIRzgQG+pYBO+siRBJ/O8QjsCTtncUPE+fw/YZpZ1sjFLmAIzAwmx+vRf/TdYtWxw1ei6PGA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr16160103wrr.116.1575644262849;
        Fri, 06 Dec 2019 06:57:42 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id c9sm3501352wmc.47.2019.12.06.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:57:41 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:57:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] phy: tegra: xusb: Add support to get companion USB
 3 port
Message-ID: <20191206145740.GE2085684@ulmo>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-6-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <1575629421-7039-6-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 04:20:08PM +0530, Nagarjuna Kristam wrote:
> Tegra XUSB host, device mode driver requires the USB 3 companion port
> number for corresponding USB 2 port. Add API to retrieve the same.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
>  drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
>  include/linux/phy/tegra/xusb.h |  2 ++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 4c86c99..2e73cf8 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1254,6 +1254,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
>  }
>  EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
> =20
> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padct=
l,
> +				    unsigned int port)
> +{
> +	struct tegra_xusb_usb2_port *usb2 =3D tegra_xusb_find_usb2_port(padctl,
> +								      port);
> +	struct tegra_xusb_usb3_port *usb3;
> +	int i;
> +
> +	if (!usb2)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < padctl->soc->ports.usb3.count; i++) {
> +		usb3 =3D tegra_xusb_find_usb3_port(padctl, i);
> +		if (usb3 && usb3->port =3D=3D usb2->base.index)
> +			return usb3->base.index;
> +	}
> +
> +	return -1;

Since you return -EINVAL above, callers will have to interpret negative
return values as standard errors, which would make this EPERM. That does
not really make sense. Perhaps something like -ENODEV would be more
appropriate in this case?

Thierry

> +}
> +EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
> +
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>  MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xus=
b.h
> index 1235865..71d9569 100644
> --- a/include/linux/phy/tegra/xusb.h
> +++ b/include/linux/phy/tegra/xusb.h
> @@ -21,4 +21,6 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra=
_xusb_padctl *padctl,
>  int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
>  					bool val);
>  int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padct=
l,
> +					 unsigned int port);
>  #endif /* PHY_TEGRA_XUSB_H */
> --=20
> 2.7.4
>=20

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3qbGQACgkQ3SOs138+
s6EBng//ZD1txYbayU7r8gWWPywLZYTWLkLPBVoXL2gb0lhitZLGZMtXVx7CyDKr
XAh4D1V7NqZBg8rSvmYNcEpCsybaZS8BFfKTqOQD9BO0TUIGVoKCzlcyh+OeuP4M
jN/v+rJprwWWjQbaZHsaKVydTJvjY4lngXubBnowibIg89ZDKJpZETSCR3h0bBEz
1Eos0KAbSOa6+s5yJ3nnNFbIvRM7NGDWECFXB18hR9H5koQ808qCw9+/s9qcaA9w
eNru53dXdPGhLRUFl+5AFoJBrkWwgweT/MJ2RZ616c6xGJgPXJbJHK32AsMGNnsc
1ubGAxO4/3Nd4rt5JfL+07yKyFDXSjx5KEsCSJOwx72q89+M1Hk6vJ/yq4U0Ngno
7icQaGNz9WnvO4Pf1WdNMaqmMZaGn5hMHV+hVc9j+Icks3ZhYpwnxcBy8KRd8p23
n223vdogFfx8kCSsoE6CXl0qJ5Eac1jZfjPlAhLQLmk6bnWdLc1WgiA8V5w4iuK8
7MQV0rKipFuEUfEMU70M5OsqRuqHIQX7YLk6q1/Nsg5T8D2h7MksVqvHGxVjvzoF
YJqu/HI/0rK0wSvO/0knMsWGnipb19tii0jOe7NRB6CwcTsr1rn0eoaSojRt0Xm5
SYfPnXB2+BOtcPFuSMpzkvC0U9yGIRTU4lVB8iNrdz4R/gkYRxo=
=CtXd
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
