Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046C320679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho83/VvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfHMJii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:38:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36405 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfHMJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:38:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so864346wme.1;
        Tue, 13 Aug 2019 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0lwNmBZD2LBdJ3AhnWwoF9mcY5exTpZEMicXowx8T4w=;
        b=Ho83/VvFnT7V+Rw62VKunmKnm+5i2XBLB4rTHWDqPFzfZ19qOXkaehYrZ2oA+Ssc5C
         HLo+bq0uDjwPnhWYq3BMU+z5+7ZEACn05h3x6mnuxPlfBjM7n1sl7WDSEIyEFwwajV0r
         5xqJ46ODARKCpqU5h3L7lzrFcF7apsdXnamTCJ5sUypPuQeyqUu/O6RcWpWzQZe+5ca+
         VHVbNBvhRSnMcQ66swhDg6Zui1k50HslhffAw35MLvwdxMWjAb1hy4CZbHhevENeyqQG
         JWzaUT/f2fT41WrRBdwYBxKu2XHLpYvFir/lDk9EHwtZa+kMO2vvLlm3+UbytxbH4Pdz
         rCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lwNmBZD2LBdJ3AhnWwoF9mcY5exTpZEMicXowx8T4w=;
        b=TMry/db7t7IGEcX8UqI1MHsycWZhyZxRfp5Au2z9a4ilgyoioPAQfszIMWs0ofdx0n
         yGQPkkvXt0pAJiFZde/oyWZWr2mXAxihKJXnDI+VWxsIU3INLmjktujC3InS+ZcrMm6x
         2DaSIfKNSTO2159vNzl1QGlCPOWdgkUNNEdfoaPHqjsS7YPNWZaH/hEJBd4o+D7CMCbR
         HSE94Xs1RorqiiRpPMzybNUvngjK8L8Q8wwDlsAvpco2fz0CJDs46aQBcKnTEz9MZmiC
         4IfrpoT9Xz+0lRj/+a6QrQl1cqAE9KEku/h57h9/2DmEqGFcFX18PboMRue2+I2jWjDi
         5Zdg==
X-Gm-Message-State: APjAAAV6YDeSUJYZQzDk+12nNouMMGxkhnLmmr7cAE8ni5K1yIwwPOGc
        QpZHzRWVFGf+Em7gJs4whi/0NFIG
X-Google-Smtp-Source: APXvYqx4vTkOO5tY20d4WDh7mChWAxDK+99GDj6oAFQmBA0yPx48SbNlmxCp6HYMgXfrNThHzMR6FQ==
X-Received: by 2002:a1c:e710:: with SMTP id e16mr2157890wmh.38.1565689114828;
        Tue, 13 Aug 2019 02:38:34 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id 4sm1729860wmd.26.2019.08.13.02.38.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:38:33 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:38:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Abel <aabel@nvidia.com>
Subject: Re: [PATCH 01/14] serial: tegra: add internal loopback functionality
Message-ID: <20190813093832.GF1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-2-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-2-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:10PM +0530, Krishna Yarlagadda wrote:
> From: Andreas Abel <aabel@nvidia.com>
>=20
> Add the internal loopback functionality that can be enabled with
> TIOCM_LOOP.
>=20
> Signed-off-by: Andreas Abel <aabel@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShRgACgkQ3SOs138+
s6FvcA/+O460rdaqlCYb/O1T4GYVbOQkOb/QbYwx+jFmLZ1ZaX43C5NJ4d5vYmqc
Eo9HNlYUgKut+AewjxX1fkNSebJT3SB0OlzW8ynLKsvAvEuloi54J2DfiSTqcRqr
QfkpEb5mAjBV6124k69a8a4vIb3xtgyYtheBmRNmFDgWscPTzm5u5Pys1yaferWV
mWvRFDQivavI/KH/OiN4/bB+w92ukbYZkK4gumohJD02T6T7CTscHLJscW5CGTUj
DET5xdJPKUkDYiOaXSZWxkEyGojGCIIOMpZ+pASUyHI73JanVO3uXVT2lopo49px
zVGqkXGqVCL2VhlHgnzVq/H+q6n2/sxDdeOcwzln/9vB/0BEDg7OI2kn9LcFRwOc
ThnObc5zTHvzagJm4zfAj+kMmLBELAyNYPSXnoJl+/wHhbK9FJutyo7Ys9onuKIi
tq1W34LBiWa6QkTjZaMRX4oLL0p6oa5upyMy5DJ4iaaUCQHlUHtD48UA3SqVQxxY
BmOAtUTjYyDt/w7sg6Ci6cPMYiOTYPyqd7XwleVQnDsmYom9JU2pvaSC2XDdAH2U
oFIrnX/CtBU9XSD8PSDjTl0m9yFVDH7RJQM0LhF7+fEa/2IxqgfgH7Y1yPQZGtQS
nYa7ftvYSqSoz3QLGGOVZmrhYjOzDEOQ3uuH5HX5tPgPJISbAbU=
=KYrm
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
