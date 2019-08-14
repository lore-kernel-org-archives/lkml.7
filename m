Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32D52084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565776885;
	bh=ZzByOnA5+LCa0xXAXUmUCm2ROnZKxna6lCMc0coKu+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z7aXvz0YrDp0tqEh9wBAuwJsK0Gv2uE7PJCBvwTKzsFFnTv51twtV1/QPlMjW4tVw
	 vSBDqRcK+ojxoDpjReWf9cO3e4HttaMWthByZ8/9K/sqwl8WsfnZ/ZtU5kh4NIBYzS
	 9kZ7NeZI9oTzCdLhcfPZbXVEdyXfFloN/XrnQgYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfHNKBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:01:19 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:34409 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:01:18 -0400
Received: by mail-wr1-f99.google.com with SMTP id 31so110542376wrm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cxebrAA4qwXUsrw/utWWY2iCY1zg8Q+R46d3aRf1h38=;
        b=XfPZxGgKlEiAajzjYREZgTLsk+du4uemSgzn9sbvYQ+Rqw6HuIZTorqP37WGYj++0K
         3ltUoyWpLW3THWQ6WiqCNIiLwsBeRW1ZdVpL8TFhaP2/MA6PztBH/1JdzUjIAkvpK/Jj
         xH/prxBXksqVrIULh9eMCcXEgdI7GQSJey/+SiJGGzmU69V/Cx8eR38++MMmkpjArXaA
         ll49oBgydFfZ/v6/dC6xx6LiKadHlNDBGd1tS3VV3lOOT1ip1QqNk+GO0YJvNtF//cY/
         hceTKsZplUy01+9GbzI05sDT4OWes+45mUQ2C/16OloSSLwGlr7PTGVAzwfjXf5IgMkk
         6y4w==
X-Gm-Message-State: APjAAAWo9djGXeCGYOSKwP/0OIIsxvHJ+4XJc9qbY+0ZLVLIzMhvlSir
        XnuoxdFAhv7/1msvv+6y8Bdsv3FH3FnICptUI9QzzbXMqBvYFLwwwlhjFW4Iav2Eaw==
X-Google-Smtp-Source: APXvYqz1P+o5bjs43C8iWeM522k1XMUB/uoqir7rPvJxkFRrmtNR/fyjxH7zF5KZbnGLQY/G1fhgOzOc4HY2
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr10300129wrs.117.1565776876953;
        Wed, 14 Aug 2019 03:01:16 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id y6sm29162wmi.15.2019.08.14.03.01.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 03:01:16 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxq5k-0004tf-N4; Wed, 14 Aug 2019 10:01:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E0AAA2742B4F; Wed, 14 Aug 2019 11:01:15 +0100 (BST)
Date:   Wed, 14 Aug 2019 11:01:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     linux-kernel@vger.kernel.org, afaerber@suse.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
Message-ID: <20190814100115.GF4640@sirena.co.uk>
References: <20190813212251.12316-1-ben.whitten@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20190813212251.12316-1-ben.whitten@gmail.com>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 10:22:51PM +0100, Ben Whitten wrote:

> @@ -1489,10 +1489,11 @@ static int _regmap_raw_write_impl(struct regmap *=
map, unsigned int reg,
>  	WARN_ON(!map->bus);
> =20
>  	/* Check for unwritable registers before we start */
> -	for (i =3D 0; i < val_len / map->format.val_bytes; i++)
> -		if (!regmap_writeable(map,
> -				     reg + regmap_get_offset(map, i)))
> -			return -EINVAL;
> +	if (!regmap_writeable_noinc(map, reg))
> +		for (i =3D 0; i < val_len / map->format.val_bytes; i++)
> +			if (!regmap_writeable(map,
> +					     reg + regmap_get_offset(map, i)))
> +				return -EINVAL;

This feels like we're getting ourselves confused about nonincrementing
registers and probably have other breakage somewhere else - we're
already checking for nonincrementability in regmap_write_noinc(), and
here we're only checking if the first register in the block has that
property which might blow up on us if there's a register in the middle
of the block that is nonincrementable.  If we're going to check this
here I think we should check on every register, but this is
_raw_write_impl() which is part of the call path for implementing
regmap_noinc_write() so checking here will break the API purpose
designed for nonincrementing writes.

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1T2+sACgkQJNaLcl1U
h9DiCAf+NkGrG44e6bBSmbdGlvwEH+uWw3YNmF8ZBR0BQ2PEj+JHd0Pmg+7mrtmi
SYF2DD/vUbZkALAWQWlo+/+bK96VutNUbuo1poKUEPbZt2f949bWi8XOCBkWRpgw
N0t8BbhjqSqv9eMtYdqukU8sXg3Jjwtp1ctnU/R/Y5sXGIBYaZnvrTUFPaJh42av
kyjurYlhXMIgwL25RTwwAoQelR7izDuktSg7f6J87OtUFJTSfdBzKvMgDcNo0k/a
68SvK7TpClIQyI3GJ0diwc8RUp7fAtS+9eStBdKRURFirPqqoyQF/QDa57PThX7y
NLciOVJy82hAyaJCQGgIM44v3iT5AQ==
=dgtC
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
