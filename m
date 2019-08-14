Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87061C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593462083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565799583;
	bh=mKCCZZoitGI745Q2pYO+VOR+Y8GNcrG7RZy5rD7j6d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ekbW1HcRkxgCyXvKPtnwzFQ9rd+eapoTXMgsx7ZhFo81kjXTPXdCwTwaad/tQXYw2
	 CTRsD2KhjHhfv8MOmQMlhtQE9sBfzkPrvPt4ImljV38R9Gmh1XtTijbYar1NWtPC+s
	 jHPtsth3W8n5KFjt2QFwhuEiTwvRCeNa8lA3ayac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfHNQTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:19:42 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:55154 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfHNQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:19:41 -0400
Received: by mail-wm1-f97.google.com with SMTP id p74so5093167wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+XUsvfqwN1xJX9j9BV7cjHLrFQRGZoNegq7jHCKmJ5Q=;
        b=GGBoOEVN7MeSyT41dCAiSgukv+dyleB6owWLFGvBsU8BGM5dcmZ3b5lpp46FKf9bxC
         r/Bs4Xd+q16UzTFb7kQkuSkbopBW9R2OKpFtnsB1+MW215v1e+AF0f5FoOeO2LbHWe6y
         6ruYIyqnVeQcAUJ2UsdBXUuRux4OxdiSP8fjqiXlq4nSRB2MUQQHzDlT5yocijxsuzID
         GOdfc/vzBhjfRqowwWQT5w7CnBL2coIf0B1P/mGw1tJmDctEqDjJtdD0O3PlSALLBVY5
         T+skiLE6laaPbeCXgicuSoQiA9//pEBauQqO5FtWJDXxq/q8gPp6zOjEjtaK2g5ymHnY
         0lOA==
X-Gm-Message-State: APjAAAVtjMqw97NbsIMiyGul1J9UoazH6cAGR8QBcIahOWoSz715ze2m
        k8lT01v2ZkSyc6UBsckRax5iDxXVvEsHacFZ8+Gl/i3kkw0vmXFmeXTkFXvmrW6aQQ==
X-Google-Smtp-Source: APXvYqyp3jsYqT1AdO6JMny32K6pQRQxJ0C0tdMaR034HU7LDs+2m9xAclYoAL2cagmKWO0CvtTl6ho0zUO5
X-Received: by 2002:a1c:d108:: with SMTP id i8mr9856551wmg.28.1565799579791;
        Wed, 14 Aug 2019 09:19:39 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id l16sm8038wru.86.2019.08.14.09.19.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 09:19:39 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxvzv-0006mg-BC; Wed, 14 Aug 2019 16:19:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B21D12742B4A; Wed, 14 Aug 2019 17:19:38 +0100 (BST)
Date:   Wed, 14 Aug 2019 17:19:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
Message-ID: <20190814161938.GI4640@sirena.co.uk>
References: <20190813212251.12316-1-ben.whitten@gmail.com>
 <20190814100115.GF4640@sirena.co.uk>
 <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Content-Disposition: inline
In-Reply-To: <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 02:09:11PM +0100, Ben Whitten wrote:

> So it appeared that the last patch in this area for validating a register
> block [1] broke the regmap_noinc_write use case.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> Because regmap_noinc_write calls _regmap_raw_write and in
> turn hits the _regmap_raw_write_impl, the val_len is the depth of the
> one register to write to and not a block of registers which is assumed
> by the previous check. By inserting a check that the first (and only)
> register is a noinc one allows me to start writing to my FIFO again.

> I'm all for an alternative solution though if there is a cleaner approach.

Like I said if we're checking for nonincrementing registers it shouldn't
just be on the first register, it should be for every address in the
range.  Probably accept it if the nonincrementing register is the first
and error otherwise, with some documentation explaining what's going on.

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1UNJkACgkQJNaLcl1U
h9Cqvgf+Plpr7TSEPNs5jwob0ySm/O4DJta9wplvxkYO9Wa0cElUqR4Z/ecGkpCO
ngV4Oo9IaJ37QbUW65D83edEaMr38K+J4sxQqeh+BILFEpDVP2dGixxT6qe5cmZQ
Rb0KRGhzN1lVDjNkQr3Rl324ky6BAKRTlLJMTM34SPpAsoWSC+9GLWzFHQLzXKvY
NN2AMOtvnFUfpw5JCBuAESWUeRuhhH1GYgML6WMyUpgP0u5vEtRW29T1+qk8H4G3
DFKcIfwZXJ1+i9SU3bhIeprHIsk9p5MYPoDgaZNZ/W7uzPJ6w206Dgn8SXElvtgC
nhlBUxdH1C5/MeSW0jKALeNwMGKoaQ==
=u0uX
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
