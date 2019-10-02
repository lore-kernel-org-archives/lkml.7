Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C64C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3265421920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 11:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw9bwpSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfJBLj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 07:39:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33736 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfJBLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 07:39:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so19277997wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 04:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dDGNUb+Flzx1xhtpsn++omMq3pXeyC9cKPCnpSm6dH8=;
        b=Uw9bwpSdzirD+MjlRCIWPEzXSwUoTOmEfF9MQ1hPpwsQpjTLkvJrFs/KX2E4fgloWa
         r2AXHEfgyTmf3Ra5ma3Hg1UtUk2jCKJE47PnbCcW8eF1GlUlp82tvotAHG1PYy1hWUoY
         63PWaW5mN+QA+wysGYEw5viKsorSk5qOVA1IZjH9FTyGIfOPBsS1BBjJtPcq9ZRPQat6
         2dS4QPnJBAyspeHA7piadepIc7gGvdrFcE8Ce4sdFGWqND6n8+SuH0K2dEq755LES0BH
         U0XFRccG1ESJP+HY9t0mBxkHODBIAcR5vtpVoPlBYMEdGJkS6gA1dn3u6u7ckDfwin5H
         vk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dDGNUb+Flzx1xhtpsn++omMq3pXeyC9cKPCnpSm6dH8=;
        b=dvnuURf+ax05d5Ds0DVgy00JrVf5lcX65FWVgqB9arHbBbpbV7WKeb59KMz6uhTsB/
         sNeOTQovBH3x15WRJ9woZqworo4bwYQ2k1piRi44RCs4SfF1vLOmqMzucWP9n1DSbp6C
         ogXrdDK+0tRGDaZwmrjEKPIjltAenCfA8Tp85WbMgHv1Ur/qCPuPFZZyuya/BqneAPKo
         iB+Se4cM/HaQY6pe1sgk8PazYc5YWb33znNkpPCJ8qMAmbWdLEcIEOxjGdVPDR+vgBQG
         OQwoDlHP0B+AWe1zyMHvl1ASwEtDLRr27ZWvj52H0zcqqFYQBQVIxwALPRFHtXZblQ2+
         YcqA==
X-Gm-Message-State: APjAAAUjCSNq4pie9GFKET67ay81j/h0DSKs4KaA0f8e24JAivbI78rb
        Z/ZyePZ7VCvrGjYVIxZIOLU=
X-Google-Smtp-Source: APXvYqyT6UXF/w7fPMCWb04efRBvZt6c5DiU8PP8FQf3cJjACRkBkWQWx+PN8YW9dGNiiDNtq6uAbg==
X-Received: by 2002:adf:e701:: with SMTP id c1mr2400154wrm.296.1570016365833;
        Wed, 02 Oct 2019 04:39:25 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p7sm6683715wma.34.2019.10.02.04.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 04:39:24 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:39:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 4/4] usb: host: xhci-tegra: Switch to use %ptT
Message-ID: <20191002113923.GP3716706@ulmo>
References: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
 <20191001134717.81282-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vr2UxLU0KdcKBaxP"
Content-Disposition: inline
In-Reply-To: <20191001134717.81282-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vr2UxLU0KdcKBaxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 04:47:17PM +0300, Andy Shevchenko wrote:
> Use %ptT instead of open coded variant to print content of
> time64_t type in human readable format.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 2ff7c911fbd0..c1bf2ad1474d 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -802,7 +802,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb=
 *tegra)
>  	const struct firmware *fw;
>  	unsigned long timeout;
>  	time64_t timestamp;
> -	struct tm time;
>  	u64 address;
>  	u32 value;
>  	int err;
> @@ -907,11 +906,8 @@ static int tegra_xusb_load_firmware(struct tegra_xus=
b *tegra)
>  	}
> =20
>  	timestamp =3D le32_to_cpu(header->fwimg_created_time);
> -	time64_to_tm(timestamp, 0, &time);
> =20
> -	dev_info(dev, "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC\n",
> -		 time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
> -		 time.tm_hour, time.tm_min, time.tm_sec);
> +	dev_info(dev, "Firmware timestamp: %ptT UTC\n", &timestamp);

Can you please switch this to "Firmware timestamp: %ptTd %ptTt UTC\n" so
that the string stays the same? As discussed earlier there may be issues
if this string is changed. It may be unwise for someone to rely on the
exact format of this kernel log string, but why risk potentially causing
annoying changes in behaviour if we can easily avoid it?

Thierry

> =20
>  	return 0;
>  }
> --=20
> 2.23.0
>=20

--Vr2UxLU0KdcKBaxP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UjGsACgkQ3SOs138+
s6HyNhAAsjJ24hOyax/FQeQO96AAq/ZLDN7PX9oxa9FyZQ1feUpj3pAVNfWCpbVc
QOvXxgY+v+gyVMb6o0BsAXmPmbpKXwTV0Cjed8P3xAMY4NrhJ4UeDms24iFZT2O7
sTaWFJf9WAOgJGxIDcL3HrMCXAV2Ks2hPHJz0QkzC8h8mJdb/+ILswqoUhYbxFEt
RMCJD9GIMZKBz+bNpbaU0zCsAIjM8JjWjUzhdvm1ZERgtH78tUrWlPDcauziLes6
GbjxfjSPQ5LoixrPvsPsryAfCafJdo0z7oLhSIEG3NB64aH54Mm3ut/zFFUKmRIi
pApGY8c6YPWFAhTjYsysKN0me1rIcBG+NUkRHsyjQKvG5Isf26vCDbCcR6sNy5Sh
3MSNLxUkfb/XVZm4J0hLwNVfA9o0ZhQdx8g3i0WSz5iMf0tTS7JPWju7vdJCgnsR
RHtUPzrSFB+oycslPNJ+WDTCgw9R8oifWmNFKjAp49a15nwrv9UAt5O2/UXxdoTm
iGGepXols+bBVt/PZRwsGBa+ZK+pp6Z0VsOfStZkthLnkVxvBZdjlIA+KWJPydUe
5hNs0SRVttqyDUceADtZHDiRLqwpveotrUEan7Sw53A4wi2xFMYLfukxc9CDZtJL
+8aSSk+94h2lh9Yre2cOJmfSHKCwgRGogfGjuv7pH6QQE+YDcwo=
=Xrj1
-----END PGP SIGNATURE-----

--Vr2UxLU0KdcKBaxP--
