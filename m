Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B7C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED34521872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIPiPzVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfJANbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:31:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfJANbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:31:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so3247591wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TMOiK/ong3gVzdDTe/F2NxVHI4YyPekmJVpFma1NZ2M=;
        b=nIPiPzVKnQAkILb7/EzPHhsDF2+v4bXcalvcQXJeQKOA4N+jVzjyDbK8NjlW95n28s
         8vKsmhY90Zl/B9XBeYtrjSVB5jTOkdXb+ZOPjiHMB+XqmlGxqH2ujiWh9wEZJ45nm09s
         SL81/457W5tfseotqUjFqDaiV70issdDlAQsoMIGe1DZVlPhwDwxCAo1C/JY+VPqZMcg
         QsnkWPQEwC/5fvSZpf+PIqIk550RAIctKBBwcwIWfBWWLGfG7dLVsgRmYk3XTDj5fY+y
         wWJDXygEKf01xhUjPWDudr7hFAYNLsclJ9XMTZgQpx1kZXa8MNplXsYbXoaAbZ3Oo9WL
         XORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMOiK/ong3gVzdDTe/F2NxVHI4YyPekmJVpFma1NZ2M=;
        b=Wqu5tUZvoq9csTR5n9TZfSTD1f+3847bCVujaSA+GRRw1Tc0HoGJHn/okXBJvAK38p
         cEVmXeDFrzETTviW4K5Eacu+j8GpUDIHyh5gFXNjkrh77YlATfJP0jfODGkMNmSsrtfU
         5kQ1uzWMEpK2MBGgLf7IiuYKJTGTJLjEIIcxXNs6vG51bRsqnCBN6yOCJ9GP6gXhgtKc
         KYU4tFWNbnkKCpHdp07gaJX7K03BwBD9iJiSWhQsEILtzJBjbBXyCPOJUtQcncJEFn5U
         kD6lpHmWTfgvjYn4dc9VAbC7aKgZ3P13GkYG/a6Xajg1adNO3Z7OyEurtI4KjTzwrQAQ
         tnNQ==
X-Gm-Message-State: APjAAAXsgDBjmIVSXG0zv2qKDWlm6Kr/2xxqOp4GgSQVnTg8dyvo8OuA
        WkcavIHYzLeUBYn5OjalTX0=
X-Google-Smtp-Source: APXvYqzKO+rBSIj5aqRA7kJeiKI+PdbSFr6ErDjtCUo5sN87MBRsM85wjYbIa3xE6uFSyaFSWxQ3rw==
X-Received: by 2002:a1c:4c12:: with SMTP id z18mr3702146wmf.45.1569936659185;
        Tue, 01 Oct 2019 06:30:59 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id o9sm40313990wrh.46.2019.10.01.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 06:30:57 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:30:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 4/4] usb: host: xhci-tegra: Switch to use %ptT
Message-ID: <20191001133055.GA3563296@ulmo>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190104193009.30907-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20190104193009.30907-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 09:30:09PM +0200, Andy Shevchenko wrote:
> Use %ptT instead of open coded variant to print content of
> time64_t type in human readable format.
>=20
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/host/xhci-tegra.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 938ff06c0349..ed3eea3876e2 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -820,7 +820,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb=
 *tegra)
>  	const struct firmware *fw;
>  	unsigned long timeout;
>  	time64_t timestamp;
> -	struct tm time;
>  	u64 address;
>  	u32 value;
>  	int err;
> @@ -925,11 +924,8 @@ static int tegra_xusb_load_firmware(struct tegra_xus=
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

If I understand correctly, this will now print:

	Firmware timestamp: YYYY-mm-ddTHH:MM:SS UTC

whereas it earlier printed:

	Firmware timestamp: YYYY-mm-dd HH:MM:SS UTC

So the 'T' character is different now. Could we make this something
along the lines of:

	dev_info(dev, "Firmware timestamp: %ptTd %ptTt UTC\n", &timestamp,
		 &timestamp);

To keep the output identical? It's possible that there are some scripts
that parse the log to find out which firmware was loaded.

Thierry

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2TVQwACgkQ3SOs138+
s6FHsw/8C8TdckQdLtcvasjLL642TQY/rkVk+I9v1mPG28VZD8cEECNuIMM6nHRP
IMLX4zk6KcizU4UqKGsc6dtI0NwjrpEU8yXaZj98gBZxDy4xY6fSoreFV5AtbRgz
5VyS244I3weK88MhFbb5IDwF+GcNu7RxIohs8gpipCpUfSDsV4QsxQtWc/AS9G6P
p5o+BgPGPcPS4wkpWyBDyi0WBg5aw/p+AQ74SW1/phVmypVfyEiStTixzicrEAu3
v2W95xU+JH9UOc5RlIiyC/Ni72wCUGMz1uKyjpvOhh7ih8fOyGHpRfIssjko589c
ojJk4MfDTQA6ghRBShPU6LyeUTmnjR8SejdjtNZOXSNygWCGkhRbtN6tXcQzkd8D
NtTqmkXbl3PPDLwrFNp+5QFfBsftnyK/Pnsk0/G+Y6Mb0n1CuAneOUI6YueXDgGv
T4K59RylicPuTFc3RIB+eVcnfvYloDoLYJDekSPAy2LeDyRYFgrG84WsZn/4lWZC
GYaJbPZ3NCR9MxWSIzKvqXJCeDl/e/zziYDhIiqpAjBbWEZNaZOGol4lR6pT+IK9
gRxvqglWXsHhAZ3+mfw4f7TqEpDkDGa4Mr6mCckSXVAaxZ1QLSR2En2GO3Vp3+5P
iihHaXYEJBzqc0Lqn2iHexLj+gydqmov9WcwWirOlWQeWPftU5Q=
=5ex1
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
