Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C32C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01FF2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104099;
	bh=iYe97ap4MhMwQS3oQbVDOxFtzgZeIAewYMNaOik5q00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lYSTTAGIlGW3SIMe1K8GhYPzX/PrEk8nY+F2+u07asmIswDS9PMENEuNk/3MPZEdR
	 XQzMng6WM5E2oQYNghQDLzBSP+GvSOXkZLlpJTa8su/+aPHDNKiXcCq4eCINXiqPcO
	 s07t3Rzaxuhe1odPpou4YBMT0OJcMf4vto55zuIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfDAHe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:34:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40710 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfDAHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WQweUZODqds6vmyYGDRjUL8zoohkSyfOS1mPC4wQzdE=; b=WhyULKPeLL+ZFpJKYZRQxaFgt
        TeOq19mLR+cATp+I63neAYn5A01USmexsHdFCB42zZ2G09WzhkAhXVfxA2IoKQn3l7eQR4RpGi5GV
        0fURsHC0vjEC6AKCSycVeLjwI/3ylAFLnmvYPD0U7dLdb3f4VzgPoD/u/UesWS3oizBU4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArT4-00084i-9f; Mon, 01 Apr 2019 07:34:54 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AA1D1440082; Mon,  1 Apr 2019 08:34:50 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:34:50 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Message-ID: <20190401073450.GG2059@sirena.org.uk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 02:30:48PM +0000, Rasmus Villemoes wrote:
> I doubt patches 3 and 4 are acceptable, but I'd still like to get
> comments and/or alternative suggestions for making large transfers
> faster.

I see no problem with this from a framework point of view FWIW, it's
going to be a question of if there's any glitches like you say.  I'm not
sure how we can get wider testing/review unless the patches actually get
merged though...  I'll leave them for a bit longer but unless someone
sees a problem I'll probably go ahead and apply them.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhvxkACgkQJNaLcl1U
h9Bx5Af+Pr+rC/ITZQNvboGisfJgfLe37cO8q2ux6OZmZI5qpu2NXsA3yDk7hhQ+
4ypTq2IA0Bvr5VX0E56/45Tr6Cq5SNkRytaOyzcIXAPkqz+loW6JVn55Fu9Ht7au
wEv3BTnRKvbQjm10RU5xG9ZM5MUwSfdi3xQBMCdCBzhX338HhlEFbEuwgty3FFh/
jMXDT9BacGSZsY4avjFPeKGenqsGZcvnHVite2uDC7HWfM2M8RGgnvPReZdMpLTz
5e6VWfzF+GMu6iFermaykdGnmrpL2sbHR0WAQrzaRNRI27eehlMFSz/plt7Pz+oX
XpHu1evnNw0mwApNQ0waqvvVnxmiqA==
=VaAm
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
