Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB75C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C402085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzM6ns8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfFTJEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:04:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38481 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:04:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so2183488wrs.5;
        Thu, 20 Jun 2019 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frEcVN2zYwEjXXcdpOrh/A8lpjK7Wt/Osnn6cOQk8TI=;
        b=MzM6ns8vtQLkNpw0Dn4I9cpgJVYEWNm8OtSBtlnD8FX9n575n8/Oeff0k2KkOlIhoY
         MLpRvANlojpKMQa0MjsCAupanapxcV4Z+33srJb+JpUrQPr6vCApYJkhb7NNyRe24EoG
         8by8vQ2fDNgh2EZOxuKUTYendMlvjCsv5zJMEQX122JLpqpyQmZf9x4drJ9McaeUtztk
         CZ6nkLV0lQ9WCkRJMjskMqlQTDG/M1Fz4u12+qGZnZaIAxcFjECy5GvxncqbAYHbZvsz
         vvxHvsW5O+ZDkT1hKQ82irQbm96C1ZCTnS3w06/SH+dW0bwGo3rs0N8+FCfgcdTn2Jsm
         T++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frEcVN2zYwEjXXcdpOrh/A8lpjK7Wt/Osnn6cOQk8TI=;
        b=Ir3ac5zgknIUAFR0z08wTpb0glo7pqzFWvDCjFl6Bme9OfEEODE0Hvq9wXpyHYgeJ7
         boEiGKi5+GInRsqMKR9oxy3kINrp7gTu7KEL6hMBHHD/QVE2Y8gieDeJf7t4NNbFYqrN
         hKWmDqZjhQx45YugChlMkgvK+ZxmpeIvXBYspyJx79dt5m32lVODPw0inytSWcja0ZwO
         W1urmiELm0KcW1QSdn7uKjMUTLxOXunZ53+WJSo4WB0v/zat51onsC97yh6n+FzEbiuz
         2Ur4sfNsjq4ZLGAPsmKtkq6hlQwYLGWG6AlpuJ3ZPWdb9MF2XrmWrksNIVPUHtPkmOs9
         1kZQ==
X-Gm-Message-State: APjAAAXSlu7eWeszlwla0N1Ov4oJ/vRHFHrAfBVfIQINkgoLLDXmgSE3
        G6CM3+E47462c83E5l2s5No2YafU+9M=
X-Google-Smtp-Source: APXvYqyxsynCQ2c9RC9uAK6hutNbPLw+1d7pYKO6/QteD5atlKmrp+VbDxgVsVkhM4eMyRx67ptWXQ==
X-Received: by 2002:adf:fb81:: with SMTP id a1mr6192035wrr.329.1561021475036;
        Thu, 20 Jun 2019 02:04:35 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id i25sm9974743wrc.91.2019.06.20.02.04.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:04:34 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:04:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 2/4] dt-bindings: display: Convert
 ampire,am-480272h3tmqw-t01h panel to DT schema
Message-ID: <20190620090433.GC26689@ulmo>
References: <20190619215156.27795-1-robh@kernel.org>
 <20190619215156.27795-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20190619215156.27795-2-robh@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 03:51:54PM -0600, Rob Herring wrote:
> Convert the ampire,am-480272h3tmqw-t01h panel binding to DT schema.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../panel/ampire,am-480272h3tmqw-t01h.txt     | 26 ------------
>  .../panel/ampire,am-480272h3tmqw-t01h.yaml    | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/ampir=
e,am-480272h3tmqw-t01h.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampir=
e,am-480272h3tmqw-t01h.yaml

Acked-by: Thierry Reding <treding@nvidia.com>

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LTCEACgkQ3SOs138+
s6GvOQ//XxDI3X8EUQGi0NRcbq7IOM9paPnzNrYo2a4zkZMJ5ujAQrRoZiW1J2FI
toUoyxQG9LTUGhOVrWccCwZEvmpvzJANlJRfgPL4Cpa49w75eywf7t4ZLnckaz4S
xUdHR2OV8cSl5WnrqEVBXnPIuafBv3DRdjw8VtI3EIOXE5LwvuQML1avCPbD71uB
SOFGia2wXlGoDfu4G/RW9LuEFoRbY9mZFIJxFFXLi9RvuGwP0/bPOsPbML+i+BJI
hV4hh3fvX3FiS/vl8DSAaUC+SFehXKJX8ch9Nw4VO8S++sE6FmR8PHUSiRIGN6Z1
KktrzUsJFs1oe4N0gRm+xZZHKzAGXS7VgOSp3Vjva49ZpTl3rJuShhMpMoWWikQB
WUjsONmVfQyOuzwMPSdHbRVbOK3XG40V9WB7gqv5R9ofoW7hNbhqdPAXnRtY3z1x
3eEukFHYOKl0mAzAYBHp+Zhro/94H50l+lrx12n6nwXoBB7VOix32BtWb6DHEhvr
ZKuGSbzhyZr7VPpyMt2xpSQr0c0y/NOCRGrnSZQ4pa06p3pEej04PyzxOmmv0dqm
/vE5lK4+78h9mDJrIByuWU1iv/3J4KiqBEb+v8i17+VE2hu48BbvdxpJ1D99y1Ys
MKW1PyO0J9gyj2P/dOwi60W/MfcyR+IDzJRyBJ19pbElya/zs4A=
=cdt8
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
