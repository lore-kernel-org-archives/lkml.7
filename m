Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC3AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B82083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR2/POTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfFTJje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:39:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38636 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfFTJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:39:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so2303733wrs.5;
        Thu, 20 Jun 2019 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06q+IUz4x3brguy1Axldl8hNrGUPdNJ6HxbjQOaOaDE=;
        b=NR2/POTosO85dWP4ibMl9b7T/BqHz61FlX284QwqIuY0gmDS0mFqwf/ZJ0/YMV+LlN
         JPn9VLkmGyPZR8X0+l57EBd37VldtfiR1NdYu72tDgQpweaNJQvEExJFPE6IcnQQ5LIw
         78szcH0pmwZ8V0xMj/lsZl6QnvqNdGIN6jNtc8NxIkX7Y058zwWSFc3QDWVOJqbLwimQ
         IyTqAfKEkFc8HfC7m8yRmjf1nupHnn7d6rnmqVmFhfdMyT4o/dtCSSYmWmolHQZCnpez
         Esvz8VBuVyVIGG5YixwvQ1UKVx5aJuAoEs1gUBVBJoYPifGiasFmKKPA/m8Gw2zM+XZ+
         1ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06q+IUz4x3brguy1Axldl8hNrGUPdNJ6HxbjQOaOaDE=;
        b=meWkfHsRSAJesKper3zdkZ6F5HcVK5sfgKTozRRvRJGjFCNGz/IIXhzHxbd66W8djo
         5hts8sjF1h4q+ru9kY6QJ/wAN8D0yyZgOcd0lmHgba7raJzQkTmPqIvEP+ioeQILPUTb
         /K6YADhBy4p8/I8MSSEumRbcwxvK2KtaDOoYq/RKunEvQKAts0iz1nHXjYfIz08/zWwZ
         Mt1D678uXMyfcc2mSMgbIss//jrjWDP3DNSllWN9gQ4ONBLOcw0mX4VtXEYfrSrxXycW
         zr7YNViaLekaKZj8OYl9bB9vWf/K8KHjzqAL7Olluo600s2Vtd5Te0NztbIkbT1rS18a
         a8IQ==
X-Gm-Message-State: APjAAAVunXqDDhLlA+N+pdQL7JYA1cFlw/6lnNB9QnbKgNCClXYGbiAY
        mTHbGOi9A+9BdqXz3cidPCA=
X-Google-Smtp-Source: APXvYqxnx6w958D37dnllqgc0ca3kXUczjrKXpiQPNjaQm6AsX0xaxEKEjtXBqClV7B6aVvX+KVZVg==
X-Received: by 2002:a05:6000:e:: with SMTP id h14mr17415067wrx.112.1561023570753;
        Thu, 20 Jun 2019 02:39:30 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id o20sm30138247wrh.8.2019.06.20.02.39.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:39:30 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:39:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mkumard@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
Message-ID: <20190620093929.GI26689@ulmo>
References: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline
In-Reply-To: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 05:21:21PM +0530, Sameer Pujar wrote:
> Add DT nodes for following devices on Tegra186 and Tegra194
>  * ACONNECT
>  * ADMA
>  * AGIC
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  changes in current revision
>    * updated ranges property for aconnect
>    * renamed agic node
>=20
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++=
++++++
>  2 files changed, 134 insertions(+)

Applied to for-5.3/arm64/dt, thanks.

I ended up deciding to put the aconnect node among the nodes with unit-
addresses, in the numerical order that it would fit in if the top-level
aconnect node didn't exist. I think that looks much more consistent in
the end, even though it's slightly bending the rules that we have.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra186.dtsi
> index 426ac0b..4bb765d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -1295,4 +1295,71 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent =3D <&gic>;
>  	};
> +
> +	aconnect {
> +		compatible =3D "nvidia,tegra210-aconnect";

I've also added a "nvidia,tegra186-aconnect" to this list following the
rules that we always need to have a most specific compatible string in
addition to any older compatible strings. This is useful in case where
the new version, even if basically compatible, might require workaround
code or similar.

Thanks,
Thierry

> +		clocks =3D <&bpmp TEGRA186_CLK_APE>,
> +			 <&bpmp TEGRA186_CLK_APB2APE>;
> +		clock-names =3D "ape", "apb2ape";
> +		power-domains =3D <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0x02900000 0x0 0x02900000 0x200000>;
> +		status =3D "disabled";
> +
> +		dma-controller@2930000 {
> +			compatible =3D "nvidia,tegra186-adma";
> +			reg =3D <0x02930000 0x20000>;
> +			interrupt-parent =3D <&agic>;
> +			interrupts =3D  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			clocks =3D <&bpmp TEGRA186_CLK_AHUB>;
> +			clock-names =3D "d_audio";
> +			status =3D "disabled";
> +		};
> +
> +		agic: interrupt-controller@2a40000 {
> +			compatible =3D "nvidia,tegra210-agic";
> +			#interrupt-cells =3D <3>;
> +			interrupt-controller;
> +			reg =3D <0x02a41000 0x1000>,
> +			      <0x02a42000 0x2000>;
> +			interrupts =3D <GIC_SPI 145
> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks =3D <&bpmp TEGRA186_CLK_APE>;
> +			clock-names =3D "clk";
> +			status =3D "disabled";
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index c77ca21..d6aee0d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1054,4 +1054,71 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent =3D <&gic>;
>  	};
> +
> +	aconnect {
> +		compatible =3D "nvidia,tegra210-aconnect";
> +		clocks =3D <&bpmp TEGRA194_CLK_APE>,
> +			 <&bpmp TEGRA194_CLK_APB2APE>;
> +		clock-names =3D "ape", "apb2ape";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_AUD>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0x02900000 0x0 0x02900000 0x200000>;
> +		status =3D "disabled";
> +
> +		dma-controller@2930000 {
> +			compatible =3D "nvidia,tegra186-adma";
> +			reg =3D <0x02930000 0x20000>;
> +			interrupt-parent =3D <&agic>;
> +			interrupts =3D  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells =3D <1>;
> +			clocks =3D <&bpmp TEGRA194_CLK_AHUB>;
> +			clock-names =3D "d_audio";
> +			status =3D "disabled";
> +		};
> +
> +		agic: interrupt-controller@2a40000 {
> +			compatible =3D "nvidia,tegra210-agic";
> +			#interrupt-cells =3D <3>;
> +			interrupt-controller;
> +			reg =3D <0x02a41000 0x1000>,
> +			      <0x02a42000 0x2000>;
> +			interrupts =3D <GIC_SPI 145
> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks =3D <&bpmp TEGRA194_CLK_APE>;
> +			clock-names =3D "clk";
> +			status =3D "disabled";
> +		};
> +	};
>  };
> --=20
> 2.7.4
>=20

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LVE4ACgkQ3SOs138+
s6FS3A//Vm2CGNN2agZRifXL72aaS/PKkWK/n606KpUVeWCdWoOsPQzUBtsyqtj+
hqu/+cenwpdg4qYtmbE/H+O0+6Em9QvYMdcsxZHqxC7s2vyrFRyEITigZx9EKsJZ
uAtzqkOlygS8UvHISSD9ojkD/qY0/72VwpBehV5LFNco2s3hBkXDzTBr5D553xhR
f+Gilk4yiplD52GSpbJeMN0ewygHmEznSdW/WNt+GT8lEAQ8uCyf0K3Oh1zXKSmG
eqJ0fD92J46fTOykPEAXBysKxiH/AmEQdD7Juhq5rlNuR+tIwvvsfuwGA9e1LeP8
aVX1EKF61E7xNEnp5vJXSwuLQqm3t1Uak4B1JyHvyZufxg0Z2GGJRTvP6RBbK5Of
sn/UVReRXxZU3XWe8eSIb31yjQwOwf9jFTyqi1kqK+XegEWgln3CXvK66xs6EYCc
DxUQqZqxcW8Zm60YPrxmPjqy1z2IXRjAUSSpgW7feDfqO/8LfDGWe/QTJOkY5Ku5
qDTfI0EgIBaPDvpqXrvRc8ik5BynBiUq1NVZI3oDc0gF880mHGLSbdObJ9KRqnrU
anxdFaOJMzoAcwn/iTW4Hzk7V/hQyWCIy7iWiYPCYcfuapRYE9TOGiNgQvZW8FYa
Xo6qAFeS5K4pE55pmF2xAU1kZaDZHcWmSAkh3x5us13ytccdIvU=
=4g/d
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
