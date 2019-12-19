Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E75C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B900120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCHuEKCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSNFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:05:09 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37842 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfLSNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:05:08 -0500
Received: by mail-wr1-f50.google.com with SMTP id w15so5927709wru.4;
        Thu, 19 Dec 2019 05:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OCHI/dMTY1KXvOgZzKQJaerVI/CjlKxj8UCw2Ic0XBk=;
        b=NCHuEKCdJnumhEY3QqDycSaHcam5yUdqdgCh7QVLPRMqALZlb3nRvJ1a//tGhVju0l
         UYVFmsLCfwmJSIGV20xlalviyurEtn07aBLIFTp+aPW98cr1su89C1hPrLix5wZnNXBI
         w+Pf8IghBGE+PdtDBDzzPXCxIZ74Xs5tGizJx0HqYFTPJuETVvsdAHciRzvmC+Iw1RjQ
         c59NKk8MYinbK2l6ZlXxNsMLuDaZd/WE9g5no3Upu4taEBYhHQ/cJFcuD5hoJM4/p6fv
         pHKIrzGZaCQXOwLNmY415rzcy3TWnVBzvY06qM+8nlDqogJ9g0RTd3rPnCJcZekQZj53
         EFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OCHI/dMTY1KXvOgZzKQJaerVI/CjlKxj8UCw2Ic0XBk=;
        b=m5ghxmOxollFvT5rJQBdeJox1KesfliDtg3ZvEBZ9j4QG4tf6ASzgGpwLfX99mqhU4
         Uj8uODp9RsWgmaKxWR302zbMi5z3MdDPxw0Wk+z0++f+FWxFk/obtx3K9OKQWfDVjER9
         3pnr2lDniblg+w1MgW5bFNxANrEfzxhnjp62NFgouc9yqZa4kELdRpXZ4n5gZjmdywGv
         MpvPpSqZkmA/l/uj9cTb/Yxk5CV04qjBl05dFTMvuWiw/kI1JH7lj70HPx24R33MuapT
         xonmyDhxL+nNhyBWODo3JvCxQca2+tgKS8RBCLGJW+UzqT4ihwecqMQ/SFutBOVAYkWe
         qrMw==
X-Gm-Message-State: APjAAAVhFbBtfcNCiluSP8gFVjhMlz6+3y6vFd5TVUbyq4IBmyctXmdY
        xt0D/HvC6XxWBu0gSXOXbWc=
X-Google-Smtp-Source: APXvYqzZDqHm8LgsW+KxT2rMTeTEP2cpHX9jZsqlecdU4JrBzjCeXM875YI3hDJlTFm5dN8PBji4Xg==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr9279124wrs.326.1576760705553;
        Thu, 19 Dec 2019 05:05:05 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id e16sm6219256wrs.73.2019.12.19.05.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 05:05:04 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:05:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V2 01/18] dt-bindings: phy: tegra-xusb: Add
 usb-role-switch
Message-ID: <20191219130503.GG1440537@ulmo>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline
In-Reply-To: <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 02:46:14PM +0530, Nagarjuna Kristam wrote:
> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
> entry is used by XUSB pad controller driver to register for role changes
> for OTG/Peripheral capable USB 2 ports.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Moved usb-role-switch to seperate Required section as suggested by Thi=
erry.
>  - Added reference to usb/usb-conn-gpio.txt for connector subnode.
> ---
>  .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 6 =
++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-p=
adctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padc=
tl.txt
> index 9fb682e..23bf354 100644
> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.t=
xt
> @@ -174,6 +174,12 @@ Required properties:
>    - "device": for USB device mode
>    - "otg": for USB OTG mode
> =20
> +Required properties for OTG/Peripheral capable USB2 ports:
> +- usb-role-switch: Boolean property to indicate that the port support OT=
G or

"supports", and also, why if it supports OTG *or* peripheral? Doesn't
OTG imply peripheral? OTG means it can be either peripheral or host,
right? So I think the end of that sentence can be just:

	"... the port supports OTG."

Otherwise:

Acked-by: Thierry Reding <treding@nvidia.com>

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl37dX8ACgkQ3SOs138+
s6E9OA//bHh0F1BqO/aGb55yWkza+6Fr4szv7ielM9sc/RyfkwQ8jskeP5rb+7r/
IDTTzkYWxobsbwANTLhIwyEMwpuGEdIBQDe10fF6gDCHGKo2Lxkh144kAqr44SE+
6pvySmahNmCgv6tI3+CTx9aReMObvwwIwgTCqGWCxAcUHn2KhOlszma920DVcx0D
D0m+xayaAj27F3qGiHgMFkTrCFVxcDCPr7Jijhmp9jfsgnFX3olS8q8qKuiwwqHs
UkkUpwQpFgWuaoDbM10ZG6jk1rRFl005UyUxIPC9dpzZrcsF2SXcp1a+eYYK6j5I
DBOZ1Glhp2MNOU6FdrXrF/Y8bwwwMOgZvjPKoX0DUSJzrHNQ2w/ILnoRgFOifZ//
2HIx8B53g7OK/twNzRzMRsnRlrd+cMESq6KKAjQqBFhfZCIajcU/H9liwqRc2AGw
Vfo+B3VBxgpU+FNY5blJ2G8PQJtXfsZfLZbhqqBiGt+xXqoYu+gacYaBAzlj/1Zs
HPbDDD60DuivV2UXyNMi5Tzvl6LxXdtgjGWZgppPAbysmotdMq/Wn/Jkowj5jGkT
AfWdYe+Gomi7dwZHedqzRyqYNVLV9kVrkZp64I/xu8CgVvUBN4huDlUOW6PB18bv
jRecgrTUOcHWNyVoETkuggvGWuW1bywqR2dqeYimkZmQSfKf9Ro=
=F9ta
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
