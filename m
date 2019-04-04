Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C26C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36992075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zthelytm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfDDRIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:08:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:08:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so4734957wre.7;
        Thu, 04 Apr 2019 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FvDg+OAAq3O2a9O1H6XOVbXgDSTdwLkFL/AT7i/BuPw=;
        b=ZthelytmMxVORufVPw/sBbfQ9J+SR0GoachVptLIUFCRGPFRycS+gWGkZ1GM9QEuyr
         23ex8kwXEJ9NPDgAcuh+0EaPhZdW1hkq06mY+ynRzXcuAuO+OZlqlpog4q344hLVJZni
         MhIVll3cn5w9m0Q8CCu+96pkiUFlwYYD9xDJUrcZRHyNy8FRedc7e8XPbh67Yl/C+Cko
         PKiT3T7w9V6NmJdcHiz/87etbqJZQRP7jCHMAH2YbLZcgbdjkBJe1VVmS/M2XRXu1kif
         cIo23Fii9PDhja5xJy73Q9uMx+kyJ+k4rssUwvGDFA9PTgliltDP/rSflgkqAiQvTwjA
         Ahng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FvDg+OAAq3O2a9O1H6XOVbXgDSTdwLkFL/AT7i/BuPw=;
        b=shOJMtDe2NLV94+HpyI77auOaec+YR/u9TxvG6pGgaVuiobuhwUl5YF09EntFW3xcT
         /gV6YTGhkNYAbRQHX3dHsRb9pHsj8vVlaBAdgP7ktCxYGRwXfsEKfjDmu3/4knggGcPS
         EAjvQs42bLC1UsFLixLe6iwG/e568M/31MeG0bOPy+NOGl2eiareJK2CYgrdxZXrm7nj
         eQ0UeVSBq3mzwQ+x0nX+6kIqSMSLgDAEvHMxr9uZnz6/YQS9VEA86nthOIrWh0/4BAJI
         gpZPEujhTPCHBJzmS/LquKSsSeMkYpYi9niBQTihHuyHHTEqG60/vxF/IQQkxYEXHEJZ
         5HTg==
X-Gm-Message-State: APjAAAVM9YBPuzYiLiW4NplOX+nzWta1l/CXFp2gIilUE4pDnVDNW7yp
        /ypYkjufvpSwqwGh0t9FVYM=
X-Google-Smtp-Source: APXvYqxRGh4lhImgGvVkvYUa3DuAQ424hZjc3KioDsNyQmXLrotFrhqbqkxr3aurWITEU9v/n77L1w==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr5019566wrl.154.1554397684007;
        Thu, 04 Apr 2019 10:08:04 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id v14sm23112192wrr.20.2019.04.04.10.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:08:02 -0700 (PDT)
Date:   Thu, 4 Apr 2019 19:08:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm/panel: Rocktech jh057n00900: Add terminating
 newlines to logging
Message-ID: <20190404170801.GA3078@ulmo>
References: <cover.1554114302.git.agx@sigxcpu.org>
 <20190403161735.GN5238@ulmo>
 <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
 <20190404105359.GA8255@bogon.m.sigxcpu.org>
 <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 08:06:09AM -0700, Joe Perches wrote:
> These were missing '\n' terminations, add them.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 19 ++++++++++------=
---
>  1 file changed, 10 insertions(+), 9 deletions(-)

Applied, thanks.

Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlymOegACgkQ3SOs138+
s6HOdw/+MJEKiLIvtJE7XqzgTE6sS8iV9oUxqR7a2oIHGRYLdyU40n+42nAuvdgI
4CKn6d19gWTtmJFUK+29oNv3kJ8LUJ/gIfuton7sivHUKZtUUh3YORLwnhmTzUCk
VWlJCTXmopkefZklTZ4BOFiGD9PM7BsCPMgz/deHbOp4TafnrGERJE2DfroKMmLo
Dit6wFLtFaYPNi7M1fGcpLkJsDn8GFKL/SyiU7HmbvIEqwyCvk4iPdQF7RCx5a2x
/GD/Z+pzmBwCp9scHeO54ajoy+MMxZ0uIaRp0a5l/Rc4qECnhnCRXeQSuNAvD2kq
Rp0bgd3xe0x8MIhr6HTR95hNQrWbiYFjTpIuoYKudLSg9Ji8a5mO1UEPzPCPPNpH
dTyW/FvLiknCRNyieec4y1bXdE1ill0l+5BOuQM9IQj2kJb8tKtQOnD0WMBFq+UB
WM95pA54e3PVMMljP6tMxOBp8bsEyH+YHwyimhIsCVwQ40HTrwe3VMm/IiH+OzPH
15Fwyu5NuxFNXSstaZtXmQad9iBUJomkGcFBvHdE27ZIdSy30oAQmpY3ssKPEy6x
571D/TuUiV9ZrWeA2nnsOK4L6w5dO//vC1hGxSO1+vgOVBDhfQX65U6B/TjTWZFX
AWqKHv46EvlTk9vHHoObpcN1xKKxRSTDBR3twjNx9/uNlf7FQwM=
=YxVM
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
