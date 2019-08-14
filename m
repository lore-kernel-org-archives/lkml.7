Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F443C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1586521744
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565798748;
	bh=t8YB9w/NyDEFJ8R04VkRmMIum8o5mlh32jKnzGQ7x+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hprEchES4IE1mhSSQDs1VdieKE6lH1T6D+knoo8p9pM/gMb41yp4GKtapCES6kPR3
	 24pkS7E+WSN+U8wMwZ0lTHdoJit9a5IzmCwstfqRyxUn+4f02JF9L5C9PBncvMMm78
	 K6IuN4wuOEWLK8C3U3fQCcde1b+SyuvTsZQnOcus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHNQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:05:46 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:45702 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHNQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:05:46 -0400
Received: by mail-ed1-f97.google.com with SMTP id x19so104450848eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8YB9w/NyDEFJ8R04VkRmMIum8o5mlh32jKnzGQ7x+k=;
        b=MWZgoW6g9QbXGieNBSemgRXXWC1Ao82BbiUq5u/giDxrUgoU9NAULv5NyLrDkBVwZe
         IOZ3eYAHZVjeRXIYD+9alGonbzWao+LsrhccuBdWvTBiihzmCAgFPXgu8b/gtslj3QTP
         XimlcrctO2hb2xKANt6LYbV3fcJtZQqQDdvCwiQs8gxydUHNMLIsUVcdZZQGbUSbHOyW
         X1IZb+lWD0ijHaA9bBsIxnXp/lAiX9VtzUs+lML+jpmT822tCzvrMzt4OjlHVrOxw+Ul
         RmIHcpcidqBVeEqPXjnjoOYYCTeSaGZSLruBDu2Myrc15K6Qdfms+hAZJNu1Qshkx1NX
         bHow==
X-Gm-Message-State: APjAAAWCksADlNEM2TBJRU9TTMs/lGvSHq45/m2v6M/qnzXIFtEfGAPN
        rMdQagps5tHPFIfs0lm2f4r+EiFThv/S3rXnddk1jFKo6jwI+MBZhAA5tUnfxFhD2Q==
X-Google-Smtp-Source: APXvYqwfgb59lhOHc3ZwQ3D0vFsnpDVkoZfKKspzFYgw72WDW9v//7G32mwjXE8TxmXQJQBkFICt2jeLfHz4
X-Received: by 2002:a50:ce5a:: with SMTP id k26mr375400edj.218.1565798744508;
        Wed, 14 Aug 2019 09:05:44 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id p43sm6384edc.49.2019.08.14.09.05.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 09:05:44 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxvmS-0006ii-6J; Wed, 14 Aug 2019 16:05:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 46F322742B4A; Wed, 14 Aug 2019 17:05:43 +0100 (BST)
Date:   Wed, 14 Aug 2019 17:05:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
Message-ID: <20190814160543.GH4640@sirena.co.uk>
References: <20190813212251.12316-1-ben.whitten@gmail.com>
 <20190814100115.GF4640@sirena.co.uk>
 <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
 <4ba5dd72-4a55-c383-0899-62109f10c020@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline
In-Reply-To: <4ba5dd72-4a55-c383-0899-62109f10c020@suse.de>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 03:32:37PM +0200, Andreas F=E4rber wrote:

> Then please add a Fixes: header to your commit message, so that it gets
> backported to all affected upstream and downstream trees.

This still isn't a sensible fix for the reasons I outlined.

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1UMVYACgkQJNaLcl1U
h9Aq4Af+PjAAM5ldvmFdFzXfWNnl0++UkdJsZSKlvVnEZKGG2C4UdVBuE2Pzd9vP
o/IhCK8FxXcBXDq97rAK6l2l64VESkm7AgndN/uEzAhFmkvUJzH2lGS27ZjQC5qq
WYy4dfsPUYtgJvqpfd6Xa+80F4ff/qct7jiep3yKYp8WYaxGuzpwlmrAm0RI9Gr6
ySzXZwSyCXwjZVqcRfxao/rwZxP+K6t6dYMhZYzQdOjpsfZ/fUqjyVaGBXiAC8G2
6k/VS6geVwR3sjw9Zx3Vy4wxEPBcDN4ABmURNnI0txjAJoQ0lszdNo3AdHlj6Vi7
DrxPT3QJZ9smh32o9d56rJg3hrrULg==
=pDvh
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
