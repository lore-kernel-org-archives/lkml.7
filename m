Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD55C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6296921835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLyIHoRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFOtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:49:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35928 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:49:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so8088968wru.3;
        Fri, 06 Dec 2019 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aalaEaVKfHAlKY2p1rpxj3inrK0861vRpI8dmURXSc=;
        b=rLyIHoRdLAQgJnQCNdtN19CAAB7uTqFw0HldC/x0BVmwK7qtcDk80++dmEgLc7Fthv
         Tt+XwIDLmwWby6E5+g+CwdkC4XdFHNnTRsW7eqhvDRuJxviTIVSxb+3i1Cev5AaU4Ddq
         0JRD7cvyIDqM0t6CxHHfPLUsJ7jfM7n2qvNj5BylEmCVRidLUXhsg/daO/Q/ab5HHx5A
         leH+yBJKx8Vmstr8p4b1XfUM5zb1/f5dZkGaRcBuFARyPoTqV3YPctQug6m9TKc1pNLc
         1nILLMG62vp1U4YUsBWlVADAGfFPL9SGtYm1CexXqGxWalpotLbwa8V/FV1GPyPnMkUZ
         deCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aalaEaVKfHAlKY2p1rpxj3inrK0861vRpI8dmURXSc=;
        b=pzPjV3iWCEPwc61COOO2cfnxmNuLsxb+GOVRyfEJjsc2cVbMwpLVUM5WilcEYuIA5g
         p5a3BzFIYVX96p830cYMG41Tu+6rf59dPoMMo3zg9cujsqQ69GPCwPe4Qw5UiEchueW8
         xX1vJv7e9PqPWAXW8fue6BAbMWgz9CTqXD/ZGf2uyzCnzULQa4wabm8Rv1Z6hMbfnFcL
         hYEq5cwVvd/RCOj1CRFnLA/WCBBmEiyXm1jAWAHzGqLh+ou00QBo3huNXEO5gUClelRb
         iLt6x6a2c6d8IScehDA+V++JYbRrE7J2eA/DQKFZ7iwWHuG25VukGzEMgNlE/btzT7+N
         gNJw==
X-Gm-Message-State: APjAAAWSkX8LRlOzFsFGXmiJz4gGCBYQr+RSLM27+6lPtzSVGWfzq3wj
        UpBDXNJZI7QvH3JT/6tlPNA=
X-Google-Smtp-Source: APXvYqySmeMk3VIYBGLIgJSqtRCYSHhZfeUzyl/1OUtAsXT8QOiFDgrU+AcvwlGN+zgjD8qSDflJeQ==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr16759890wrb.22.1575643747476;
        Fri, 06 Dec 2019 06:49:07 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id 5sm16841135wrh.5.2019.12.06.06.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:49:06 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:49:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] dt-bindings: phy: tegra-xusb: Add usb-role-switch
Message-ID: <20191206144905.GC2085684@ulmo>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
 <1575629421-7039-2-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <1575629421-7039-2-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 04:20:04PM +0530, Nagarjuna Kristam wrote:
> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
> entry is used by XUSB pad controller driver to register for role changes
> for OTG/Peripheral capable USB 2 ports.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
>  Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | =
4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-p=
adctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padc=
tl.txt
> index 9fb682e..0f19ed6 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> @@ -179,6 +179,10 @@ Optional properties:
>    is internal. In the absence of this property the port is considered to=
 be
>    external.
>  - vbus-supply: phandle to a regulator supplying the VBUS voltage.
> +- usb-role-switch: boolean property to indicate use of USB Role Switch.

That first sentence here seems a bit useless and vague. It doesn't
really convey anything other than the name already does. Perhaps
something like:

	Boolean property to indicate that the port support OTG. If
	present, the port supports switching between USB host and
	peripheral roles.

> +  This property is MUST for OTG,Peripheral capable USB 2 ports. Connector

If this is mandatory, why not add it to the list of required properties?
I guess since it's only mandatory for ports that support OTG, perhaps we
could add a section "Required properties for OTG capable ports:" or
something like that? Then you can also omit the second sentence in the
description.

> +  should be added as subnode, see connector.txt. vbus-gpio in connector =
is

There's no file called "connector.txt". Are you referring to

	Documentation/devicetree/bindings/connector/usb-connector.txt

? Also, that file calls the property "vbus-gpios" and lists it as
optional. What would happen if we don't specify it? Doesn't that just
mean that we can't support role detection?

> +  Mandatory.

"mandatory"

Thierry

> =20
>  ULPI ports:
>  -----------
> --=20
> 2.7.4
>=20

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3qal8ACgkQ3SOs138+
s6FCvw//W+tif2kSJJtiPRCRw6jpSoXUwVAjU7ZwbXXADIhJu5fnxdzio29NFIsp
BAe7QcXP8emgeUdOvZuRedDX5RX1KZkSz8i3JV2o6kMHa1u2Jnu+pQFv1nQz2HnE
ATTUej+WAX8pPy/EVkW3UX0dqUWw8/agZzJckfuoQpXhjgZB5to7ZAAb0eN8Oxwb
uNqYVxunX+A4mRcyHNCZlAsdH5K8qv4ueZezgChS5zmK9nou7pV3vjS5SK2KPrZp
aHwXhtM98CcLto2nOs4S84GDMUMgECxIM9LCLETt6oLNjs+J6UVmJrh2yJ+xqQTG
BKp6mwp53p3KMMT+7nUG7WsRElFP/w9QPcLbxBXCfqUzlA57/yj/DVWqitJbaSkS
U+bEAhxg/n7NJVDFF0JR06YABn/fYE2uRX8otXE18DtrVFaQgRV9jx2sFWrOh1gv
6a5Je+nXSQvx4j3/0otBIuoPqDli85rDHwpWamqW3PmBCyqJF3eg1kepOcwFnB1V
lZ4Y9bsGy/yKsQjrfLpe0AEC3Jo+OxIBrwrSz3VATz0LLnXUH+tbt7bTrJetE29a
qiXlTtdWLsnYMGvnmYts+bKw7FaEuKqz9b/Yd/iw4LO47xo4r/Pfx5tXMng+KiG0
Ve+Bp9KBju8Llg/5nojd9FVQtlV4n+uY+XnibgICSsjJdhMyQfQ=
=Ud+/
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
