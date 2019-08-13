Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7594C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B3120663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWT81dlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfHMJzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:55:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34207 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfHMJzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:55:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id e8so694388wme.1;
        Tue, 13 Aug 2019 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pli52NBy/OMsSqsnASCGrhls+/JLogpdAS1ylOATsQU=;
        b=dWT81dlFP1Rz6wHB1smXEGLQ7bSN0BUlypMEnVI66yLgTlDL6gjgprLvmOsuxPDfJv
         Z8TTmuHwe7J+VSGwmxzMLGgVyEq7lkAXfKsEMBYPkFVFFDQjyPg+RkWACR18IhByJwRs
         OJfaAaww2Iqf5auoVMKuB0kPctNYaIHJ+e63LgkUGtjexJLbcZ7zOm1/G02bQR+qoJlT
         F2jPzLaVQ+KPHjUAXI/tshf5ziZutIwTAY7QTVMQjF3LaXMyRX1zmOKh1WTPNPZk+dLc
         ctYbcBfnWoxlddFw7MtFS6+sSMfZk0HrN7W1lqSA9gRFNnT3TOivQhQRyBctJfJkU63y
         GY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pli52NBy/OMsSqsnASCGrhls+/JLogpdAS1ylOATsQU=;
        b=oZqA8LDxqvz3y63wBY4+3OLx+B/87WXX0SoWmIiksW+WWUVsQVvtgq1yLQHUyf0bSF
         S2h9MQ8NRU1+fYnxFPdTsTata9hm3fpARCoVWgmH8RA9TSJYShJZa8n+IwVwoIrCu3Yo
         UvpFPPWfV1nMm5ZZcYkhA4aTxKqKAA8wHUkGtD+iK5rrHistWwoAeE4forAgZ2K1Yb6H
         dXqD6JRwlhxBOOvX5CwwHBi0893a16zod6jAwZovTOV3cfkLj8M6zoMA8X/H4omBuo7p
         xq53WFzAekduPR+2S4EWps24fvVHmEw5lipqPnnHCJq/5uz3cEEWxa3tzudI4OONA2Pc
         WfjQ==
X-Gm-Message-State: APjAAAXqK7B2S1UHObO9vcjJk8I8u8aZGxtCm1WfGuCxszCj3qFwpcHi
        eUdMnLxONK7GROZM1+mMq4M=
X-Google-Smtp-Source: APXvYqxIhr3gIFWeFwigD1Tmfv24IOqVfVxzCMUsomct0kWqMTUD5Wo5Ln3bt360aD3DZ5s5yuTH1g==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr2063842wml.177.1565690133459;
        Tue, 13 Aug 2019 02:55:33 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id t19sm955025wmi.29.2019.08.13.02.55.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:55:32 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:55:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] serial: tegra: add compatible for new chips
Message-ID: <20190813095531.GL1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-8-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:16PM +0530, Krishna Yarlagadda wrote:
> Add new compatible string for Tegra186. It differs from earlier chips
> as it has fifo mode enable check and 8 byte dma buffer.
> Add new compatible string for Tegra194. Tegra194 has different error
> tolerance levels for baud rate compared to older chips.
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt | 3 +=
+-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I think device tree binding patches are supposed to start with
"dt-binding: ...".

Also: "fifo" -> "FIFO" and "dma" -> "DMA" in the commit message.

>=20
> diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsua=
rt.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> index d7edf73..187ec78 100644
> --- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
> @@ -1,7 +1,8 @@
>  NVIDIA Tegra20/Tegra30 high speed (DMA based) UART controller driver.
> =20
>  Required properties:
> -- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart=
".
> +- compatible : should be "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart=
",
> +  nvidia,tegra186-hsuart, nvidia,tegra194-hsuart.

Please use quotes around the compatible strings like the existing ones.
Also, I think it might be better to list these explicitly rather than
just give a list of potential values. As it is right now, it's
impossible to tell whether this is meant to say "should be all of these"
or whether it is meant to say "should be one of these".

Thierry

>  - reg: Should contain UART controller registers location and length.
>  - interrupts: Should contain UART controller interrupts.
>  - clocks: Must contain one entry, for the module clock.
> --=20
> 2.7.4
>=20

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1SiRMACgkQ3SOs138+
s6EJYw//YTnH42F/vn19weuxjELgdmwZkWjkvGeZf5gO2hiWgy5oR6J74ACsr87G
7IK6eQxszcqOsXXu/f5bX3XiTG8Xpz/6dyfutm9xP0/slRtpHJSLHHKuUofs8HQL
bHBAf9/ZG2mnrkWxm9q18AcZX4b9S7jAqnTI1gxMMZ+FvS2I8jL61dx+2S5bH9Jw
mp4JErcdf+ofxhM7o39q6jHlWhZBRj/3KwauW9sKyiQCKm4b/Lj9JePyeXjiz0Bv
Qs/H/k5GMqo5PqP6G1rw8m40V6hJtkUIdzKskOZJt94he1ULdMAFnXMlYwnK0OJU
MlSfuEhbJajQ4yOSXH+ShUw2j+p/zn+fXpPyWGH/4ckhNQS03T5QRedmpTGUYrkV
XlUyB9V26mYdyMtlNgozoWCHrkhSrmOCkPWDe0j9+F0LcoDNQGj4xvDT2wTAtmSu
wEMQQ47JmPP2rZ5dJi+rEeEVEOBv6VOBiwNgywL+aXV6o/jV71gHICKe6c6PFGnU
vqiRYWedvDtPhSFR9r6JCn7mZ77vgJfnkpSyQON1zupTAGXY+9dy/2m7no835gxe
7nvl072qH3b8GRytLuETp7sAcKNvJvL9Zb1Zjsa4XlJJZ/5M9xKPOVXfajXxLtQU
iEFehu7/BaMdggncN67Kb4s76xszM435j02l5m7aCxGM7eB65PU=
=/lhB
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
