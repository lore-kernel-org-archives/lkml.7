Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3286C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77D720833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKSJMA3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDHKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:23:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38098 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:23:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so14082134wmc.3;
        Mon, 08 Apr 2019 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1tOtlx9serua49BmQ+VOc10T4QpibtAM3MKuEgctzT0=;
        b=uKSJMA3m7WuTVJc9pogWcPYrgDi29wF8CWXJJ72JSZ5pCkxoItj0BTmuTPpmbVZkzt
         UPNttho1vO5CenKjZo7eLl0msuQTG5kRJmLn2oq8EMVHTtRSAOTlQ5qtaaSvTXdUA1Lv
         Lf8tkR5NeTfAJh5DVXwvXSfuZswLauz5cgNCl7ACr4nEW14pyyq5/FCK3F8iOkJGRdYL
         wcBxYHxBRbTyIlk6xvTczAZ657oK9qHjTZoogeinQg/UNwYusMC+u9vaVvzvq229J/E4
         6oFZllj0upwZLAWNI11/UXd8vGUFkpTCCrlyO+estE5fjE6DyBz7noD68teJxKTQQAUg
         oBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1tOtlx9serua49BmQ+VOc10T4QpibtAM3MKuEgctzT0=;
        b=jmvf2cxzYIoewe7K5XkjeR8BrZ/RWioHmSRWJrEASXfHOb4cIHhSo14JYh9SY8h5Gv
         sdBo2K3vHDjaYzJJ6r8rhyppqmCab5PedudjS4I0L7/Zg7aaB4nAbhLG8rd++WwI+IKw
         yc8fns+bC0SkfXc6z84x/q35wcmO+b8w09b9DQU9j9svHsMICc4TjzO6mBF+d9XQJlBa
         A5qg8xg+6jQtGmQP7kQqcmw5dJjP8e8TefUtW005BBTEzbetJi4Z+Mxk/HL5gU0uTvAF
         2ZL8m/sz0rdJwEDnx+R/prfn7wtBF3jyvy5NtyMQoU3bXkXJ2JQSrlIEg9J233q+yJdt
         tglw==
X-Gm-Message-State: APjAAAVadzi69o1gdwD2RLRj3WH/TVNaLyf8MtU2k6hOPHU9GufhChen
        tp424HkjyCp/OA3Cs2B2zIZv04E8
X-Google-Smtp-Source: APXvYqzwROpPwljzoh4PEzc9ANQCWw9IQo94qawt28WEhptK18s1SeJBIc0Cy6jRCI1oKxPAJC9DBA==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr15872222wmg.56.1554719032341;
        Mon, 08 Apr 2019 03:23:52 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id c16sm10286929wme.31.2019.04.08.03.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 03:23:51 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:23:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: tegra: convert to SPDX identifier
Message-ID: <20190408102350.GE6644@ulmo>
References: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
 <20190407211646.14962-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20190407211646.14962-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 07, 2019 at 11:16:46PM +0200, Alexandre Belloni wrote:
> Use SPDX-License-Identifier instead of a verbose license text.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-tegra.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrITYACgkQ3SOs138+
s6H9HQ/+JjzCxPggw/X0VhcIAijbbsshGx8YCLXkHeEiwqZEc7JVdm+2QfyPwZ/a
EEeiYayKfwpB2qdC6NB4ju/sKVBxesjC7QC139ayUa3St76UtRj5yevAR8s93AQv
yOuUNK7RmUyWh9i4/UnnpRhx5juU5rk2gR5x9SHuHD27UknQEDfYDMhmN4745X9j
J+d38Dqhazf6zsh9UlHoDkDNJytOqSwl8hBNuQjIxfpeP86VGao7g1HjrQ4QTVrD
fCd7oa4U4THAuoSRU+he2/O0WnBU3bKng5MIk57B5XbCsf3j+EH3yJl6doYPByvo
Vg9W+DbEZFkz0Hj2ASyml70zcRRx1yygjnFhbw8c6FLyaAmFdoLMu3iPhfOvpb7/
ilvldiXjPCzab4idMjymXsotNAtlZKasTFM83zyV04m1IX1KBprHJXjaPpGvqhM0
dXC93vC59w6dH7S4AkLJtHXDU0L81SCigtTbTDxLLwH1w28WZx2Z3ajBcliY/K6Q
vNo09u6YLsT//sGNVai+q4/3AqzgQTAKh6zViq2N/KdsJgbiS+gjCOks/LcXn5m/
T+gUovUQgPXN+YJj5eb5viX5fR11Dr4+UY6P7wX8i0LY4NaWLIXg02cHnuDjG0WX
YhqHEh3B8edAc8YxH64u/cE6zOZ514GQfHKyGD5WpFGG05xybBY=
=N71O
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
