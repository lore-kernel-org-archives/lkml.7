Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C120854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuS1v9HL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfCRJ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:58:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34530 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:58:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so13933603wmc.1;
        Mon, 18 Mar 2019 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+wt9O8/knBy/XbIG/NsnkQg6tcU2qAwt4SpX8SxGOKg=;
        b=iuS1v9HLQYz/TpzHiPsQtjW+SxL5OUgJIveYoEcLsXd2rvCGlzSXUiVQHqlzLe3/kc
         bUmJFvKmCZPq/epSlygt7foYlne3zLnqir4YQ9pl9G4lo/uY2Bc5VJugTy4XaLZAXjP2
         M3QBAor/VoVm7U1oJvVAgdD2h8A6JZTFyWzgSwgs51XNxMwUCMBpjAXXr6Bz6ekD1RQe
         aKni8UkfY1Pt6PZoG1rblYgqyXtKH+QBjP/KXU4xkTSO/uTDKzz35xiOlOauO5wIFG7d
         Ed4G6dDtM9QhvO8WF6n0WwzuFB4Ywj/7HeRIwxiOgYB7cv79bZ0w4IcCsClPywyGU1xf
         6wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+wt9O8/knBy/XbIG/NsnkQg6tcU2qAwt4SpX8SxGOKg=;
        b=hrm0XSMjPj90kkaYmWs6+Icqw/2izUGd3vh4A823AXr6Nssn843EAt37lVwbVKqJnM
         LN3zNW6pBPogU8Lc9uw9isgnOWgcxMyB3gy2lNnrkgKfOcu3oApn7THjjeKqMqXtAjGS
         2oFXNMeQMY9VQa00/ky7WqJtDajv4agyvmcla258Xm1TC0XAXA9gSS4In8SyQmU6+9BF
         4ncl1r1Juj4GmmaIb6HeaChr8HsO3nHiHFOt6nozs4Tq99w3qLKJpyRRaVJvLPQXWj+T
         GQXxkCVVaY1vLs0416QX7xtj9Ye1XnzazpqZQJd841IowiSvC66jCAee2ETkY0GVBsuA
         Suhg==
X-Gm-Message-State: APjAAAWOj0MMbPyXBA0FZXAnAVAstGcjJ5GtXHB1Kts9tv7uJNsaSWoy
        71Fo2TU57pebmtbnGhVUgGChpKZ8
X-Google-Smtp-Source: APXvYqxz6YSnXNMLeUdzSuOqtoowvawp+csN2N03Fcm6Mdq3d7QQj+jEDpI+jcCF+w5nSO5rS0jR3g==
X-Received: by 2002:a1c:eb14:: with SMTP id j20mr11115000wmh.32.1552903124630;
        Mon, 18 Mar 2019 02:58:44 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id l3sm9019624wrt.62.2019.03.18.02.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 02:58:43 -0700 (PDT)
Date:   Mon, 18 Mar 2019 10:58:42 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Message-ID: <20190318095842.GD17565@ulmo>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 07:41:32AM +0000, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt | 19 +++++++++++++=
++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Docu=
mentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> new file mode 100644
> index 0000000..d47b8fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale i.MX TPM PWM controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx-tpm-pwm".

Should this perhaps only be "fsl,imx-tpm"? Sounds to me like this is a
hardware block called "TPM" that can be used as a PWM. The compatible
string should describe the hardware block, not the mode in which it is
used.

> +- reg: Physical base address and length of the controller's registers.
> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a descripti=
on of the cells format.
> +- clocks : The clock provided by the SoC to drive the PWM.
> +- interrupts: The interrupt for the pwm controller.

pwm -> PWM

Thierry

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPa9IACgkQ3SOs138+
s6G4NRAAvqo10mJNrbqB5kWDGp6jFuuJvnec5Eg1ws7eV7p63bS5JPPdqhwuaFk7
W4jaMMzt+uQ02+GhfXSYN2tElcKqWhdw2jtmOwHhLpY/i3o5rSRH1lEnchDAxaNn
eqfgiKMAN4ApM8FLYWeF5gINO+yfJTeRyPJ3HmXKYIzWM5f0Leaax6bJv9PvUZTQ
gGp3+3SRbSogU7Qm6KATDAZOa53kQyjX3nsRfKHSY4tgJVH5n7zGUeX9O1Zkjblz
dDHS5GAxCUFZLN9DPa8ukfPIdLjTBYIMJZnQJgtrWjnTen41+xJBbQTeM6m8xyhs
K5+oyg+olqjNdooIi3lhMoIXIDJDU0lUHhuBg9lnakcsiccGipccC3MrKsWRWl+b
ZwbKYHMiZlksqRfpiiK7R8r20090nVzTHKHkHGQqYDJiDNZu9Jvmy3ExBMMtxMy4
WHjqu+F9iRbPAz0Ky2S6JOhrJflKDaMrmaOLbmGFovQcjFdSmwCnkcy5Qap2tKVv
Nc2vBTKrLdUPMaYr2W9GPUCemyCXbWBmHYKja3I7+vW+q6h9u9yMEJfaqd9RJEI3
rLcPkCHzURjiqXCPsT/d5smYav5MmiH3WAABFOtr8mFFUnggMKEuQuCLV6beKsCc
BgOmHHREkIbmpMy3sXd612OjuJAL20ZbvpmxLU7Ne3HwHHm4/dQ=
=oKfO
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
