Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADFDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3795920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuivZUkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDHIRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:17:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39287 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHIRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:17:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so15185946wrn.6;
        Mon, 08 Apr 2019 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bEsw5ua8rvDmmKnykFRWyXLqnx583cH0nPtNZnDfDYM=;
        b=UuivZUkS/GSWKWWwR+YB6pIfK0sEKGxYJLlTr0l0Hcu2NGRsbDxK4TxNaDvkUZyEcV
         L0aqJ4JYBKVofwD/8AmnK+FFjTWexrlkKFpkX4PFJ0ARh/MI0GiACJ9MXEm7O3q9rIle
         0u7vvtzHxp5gjp32gDb2tOz6Xd05ZmMuhH8YLuimCSA63AJu6ZEa/z3EhaH8gqlYrDNI
         SRu/zSHmJizD1EnBHq2tVGPnpZsq/I5sHZO3D+axrSf4k08LBdgTLawdwtPla0PBqeYw
         Md98l6TTzBgh36v+JkHqIaQ8AvB8uEFmcMWNrKvgIBv53YdnN1jKZ+FFhObGvi6tQBX+
         fEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEsw5ua8rvDmmKnykFRWyXLqnx583cH0nPtNZnDfDYM=;
        b=agPidLL/tW/qzCJpegcczMWoBWUyyg8y8J9YCOfwVEAc7m88QQ8bnyNOUsg2MSro2R
         EtpHdNIwUK7+4GERNOOGcwelMWCdp5tb6lbbnR4IE60ukhYrka01cIzxiBrv7LpaAbrk
         Cok6+LhJctG56FXGsJIXKLCjxAJhgqQtXSOK7z9T0xIJgNgzL/tsIqYgtK/Z+zIINVA1
         99jZEFQ63aDwN6pmnkveXLe8Fiklw5uLjh1kPcVbLtWh6SvYY9SgX/URF//Amn9JONAB
         oHMVljRCEZtXYFRFKlCq5i4ZEhhSs6gzAOgUxv/bsvEwhLiAjEhHZtsIzw9Ch9UYdFIA
         vTZw==
X-Gm-Message-State: APjAAAVsdb28F/sldUgCgSsYavSwa+jFpjGsJPgqNFnSojWn5uJk0BJP
        Ci2O6LGBPjVyHiLiBnSPF1Q=
X-Google-Smtp-Source: APXvYqyJkqmyS/98ugYohNWGEtMLU2vk1mfvFqfHfgnvJkEKWB/SQLu1PsY83ltaqUMkuNxI90oyHg==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr16354610wro.81.1554711460917;
        Mon, 08 Apr 2019 01:17:40 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id t24sm12690669wmi.10.2019.04.08.01.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 01:17:40 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:17:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] usb: host: xhci-tegra: Add Tegra186 XUSB support
Message-ID: <20190408081739.GB6644@ulmo>
References: <20190401104050.31355-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190401104050.31355-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 12:40:44PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi,
>=20
> This series introduces support for XUSB to the Tegra186 SoC. This is
> mostly the same as on earlier generations in that it provides an XHCI
> compatible interface with a bit of vendor-specific glue. Perhaps the
> most notable change is the removal of the IPFS wrapper. Patches for
> the UPHY related changes that control the PHYs for the XUSB controller
> were merged into v5.1.
>=20
> This version is a rebase of the series posted here:
>=20
>     http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D88193
>=20
> There have been no code changes and I collected Reviewed-by and Acked-by
> tags.
>=20
> Greg, can you pick up patches 1-3 with Rob's and Mathias' Acked-by,
> respectively? I'll pick up patches 4-6 into the Tegra tree.

Hi Greg,

would you mind picking up patches 1-3 of this series?

Thanks,
Thierry

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrA6MACgkQ3SOs138+
s6HZIQ/+IDrPopch617P4krSq4RRYSipiePmD/iKvBjodWR/t/npMJJLji9bckIp
PIE9KSBY1FqcYo9txWx6jy03WU1JhPvHimYyq4DwDPytI+BjJc/qsXHqDQep8QxT
ENuG2A/k0ANmZInPeM3Y3YK0C1fVudXOA9YT5aBJ51cyp34UFYPOWleIKDoRgi7A
L1mnbo45EsW7zs1eiDOHIVQhGr8XYFDQrnU8FozHD3VJG2D18InhRvwMTLIJnSZa
DDnA2qfIgaaWWcWvN0tcTsBd1WEXLsYMrSUdBj1/wJOV6qFfixCKSduWkxbNcEP/
/5vybxYJg1pAA6eTYCdLPmOkwNOhAo5iOvmaFqCm0132SWNaLmg63G7q9WWE3DZa
GmV8oTndXLZohpLqQw9IwTnyMFeOUeFw0HoEUFgx7mHbbDQjNUB6JZMiY/GaBpHi
ITE5dPt5DXQJ89i3Bv3uHI4X47U8WsjECm5XrIfD/NBYxXXOiaiGZERpedcQUbeQ
VWRhxK783b9ovlqaU5CrDX+bahG4fg2K3pXc5hdM/L6z5SK97cNGn4C2dT+y4ej4
GXq5bGhZSbTkqcvqNGxVFNhwY+fSucZnZxg+k7Mmp7Bg/K9iX0uIPnYhe+wgPFQB
C+6M3VVnggmJcshMx16vFD+Py3nT57tpjy2gI7X1QoAawpHTtS0=
=1XCU
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
