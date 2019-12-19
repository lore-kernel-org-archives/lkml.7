Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C1A24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS03K9zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSMzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:55:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54632 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLSMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:55:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so5316218wmj.4;
        Thu, 19 Dec 2019 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JAK1BFdpMxVFR2Romis4Cw0wHYh9wB5IFQ5zyLGf5z0=;
        b=lS03K9zLVxOBTapqbHoRIVadiGCI8Bvl4FlNidxjBxXG8B+2/mPvTwpITGI+u06gKE
         BjTmlinM1a2YxH1mogzwOOq+AHit40a3JDvDbWUuifcVj+K87/KgUdi89cTnFkmbB027
         QNanxmYRmv4+QN+EGDFOp4zr8J79MOz9S17ONcUOEVOsgXaONC9viEQ290FnUkqYjver
         NPxeyDVxo7cC1hR24ikPiQCNoonLrlO4chG2OpBvns/+PddoeHl3eF24PuMsXxSLa9As
         w2PPhooAytanDKOcHPhuVvGuAqYFbEjEsUEGjQrs+C/gBGmy7RcFkrMuaK1l10hH/m7O
         /Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JAK1BFdpMxVFR2Romis4Cw0wHYh9wB5IFQ5zyLGf5z0=;
        b=JG7Au269Pgam7YTmwCqO4uJcAfzR2WJsjqAgbnjZRh5VOL9Jy2DhMLjGt9IeJWINqM
         QqS0/sTXG/3zjG/5mWPqcSfllIDuWf5ZSx6dwZH04TCb515+VeDMJaOFDdFGBqjqQL1b
         YwOSB/Dk/QN4RRj6dhJ1cbJtzwWnpjwusaw4GBTvzpsOiUjjHX42NqxRyaqlFRe2VdjY
         EzoLWJKID93yEp3yIh5hAFaRXPrI3cbYCynURn3XL9GcnAE1USfkR5ohB3ZsjkRRo5NJ
         Fs5cXSC4JPhU8gwWWVQ4XwnhNc0dHXbEI+fqBwTvXRsok4ildp74SDW763u4FtZfukpC
         oLNw==
X-Gm-Message-State: APjAAAVc+ajwdLrAp50Z3P5sOhtVFlGZkyrKeuolarOVa2sPY47JHBlo
        X87DSmWXJLMpQJ7KpQWTDOY=
X-Google-Smtp-Source: APXvYqzNzoEd6A+v3GWmjc55KfZSe54sAilFf98Ff3jpDfcu24n8DDky3nVJblI2C52iU1NtddYAZw==
X-Received: by 2002:a1c:6406:: with SMTP id y6mr9858912wmb.144.1576760136013;
        Thu, 19 Dec 2019 04:55:36 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id 188sm6419234wmd.1.2019.12.19.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 04:55:34 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:55:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA
 Tegra support
Message-ID: <20191219125533.GD1440537@ulmo>
References: <20191218175313.16235-1-digetx@gmail.com>
 <20191218175313.16235-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20191218175313.16235-2-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 08:53:10PM +0300, Dmitry Osipenko wrote:
> NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37c0UACgkQ3SOs138+
s6EGdQ//TKxi8EHlh+A/5nnHL2w2DyYzzJP5AOBstZmUQrGDHxZm/ucpqsXm/rgi
ffDAuANz0tVHdLY8Q2lFn0cefao+P3SfOEB1ziajYv6+3C670eYDDDDUYTFpaQ5Z
t6WBXfiZl2rUaV64WXZhicZVPUKMhGWM6Gzt7CaD3/1bhdNi/rs216vvyLlqropR
fkXnpsIeX3KayK0sdH1zbf0lqdKHda+LgC9xgX5ydgfwqgqq7R2QT3y58PUve2lH
R7QnBNYJ4+bl14LtfKmzevQ7T2Cu1HK/0XD4hqi7jYkzhK3c+aIAl/ItNdw7O1lm
Nn1xnbqXDyZ7OmDpxzcj9iU2MvmsHbwalWDLHioMOe4J3q/NI/XS2lWGPcP2LOt6
2z+3eQ1MkOEGlhdepURCka/CV3pYP0BmWyyXmk15YczBn0HhzT4vE4WsSFunUYD6
5G3Y4/dirUtQTcaNRH6jCzEeHRiI0tUjrvA/maymXPpXLr7XaIkdwugAVB6CJjWS
1jGXfrnMJbdBG7q+7+ZlQNprN+v1unz4z2C5Ao7HfNyyTgOt7IJYPVFwFrpwACf9
/tfjeV+NWqR2IlRml/F2xKTDU6MgoIZSxK3WwufHleibMowyrfVFnbc9qrTpqZPY
G0JzJN/RTGAK05xcClVh9Ui6dRMpoX7Gie1AuBoOi+y5icT0IEc=
=WYKR
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
