Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC1C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C579D207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575909479;
	bh=Y+fycx14m6RoaafnS2lJ7fBJdj74H70OsFzxd+srkAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wkglxAmVPmC8mXJ0nTfVEwuUzK7a62dauzgeextcASjjyu/8jMIk9cv2w0MsESiso
	 lV0zFqT0D3b4BhUtyWqwzCjX43Hv+BFQnd1v9fsKc73j/76RL0URkdiOvqZVtPBd8v
	 FX943mz/w1eaVoAmwNNADRHLkIEdA4vTjE2aM6mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLIQh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:37:58 -0500
Received: from foss.arm.com ([217.140.110.172]:37854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfLIQh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:37:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453F01FB;
        Mon,  9 Dec 2019 08:37:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B783F3F718;
        Mon,  9 Dec 2019 08:37:56 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:37:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: Regulator probe on demand (or circular dependencies)
Message-ID: <20191209163755.GF5483@sirena.org.uk>
References: <23236201-a387-7257-35a4-ee4ed2f6bfd0@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <23236201-a387-7257-35a4-ee4ed2f6bfd0@ideasonboard.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2019 at 04:38:04PM +0000, Kieran Bingham wrote:

> The MAX9286 also exposes 2 GPIO pins, as such I have configured the
> MAX9286 driver [1] to expose a gpio-chip [2].

So this seems like a MFD then?  The nice thing about using the MFD
subsystem is that it means that the drivers for the various subsystems
on the device can instantiate in any order and defer separately without
interfering with each other which seems like it's the issue here.

>  - is there anything I can do here within regulator_dev_lookup() to
>    attempt creating the regulator_dev 'on-demand' when
>    of_find_regulator_by_node(node) returns empty? (or is that crazy, and
>    just a rabbit-hole?)

This seems like a terrible idea, you'll have a half baked regulator in
the system which will need special casing all over the place and
doubtless be an ongoing source of bugs.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ueGIACgkQJNaLcl1U
h9DMDAf8CpQOBN0monPnjHxv964dVMtgkGtKsdUu8Oe9P6GjpeW7mEjijunzKrs6
sleWk7koDmdZlJkRnjYhnZISIOKlrxLG5qWQPXaQDhtEJMcyqMiKNL4lTk5UVDbB
sKMmSyFw+cOK03ocOiwZ3qVFXO8SpT3Xw3lp+1sw2z7v+R9LhY0QcicaqYmvtxal
DsH+LmdJfATO5dLdHYWBnBGoFMr5o5POk8WkqkualCFU3pSkA6khlR9KegwfzK6l
uy1zPcsMkrN47yYTFXREAZarPhmQ5AfSsE/k/qeyJiElP/uXJdhNswPYAO6m/yxr
jyWeDQX+l3rCS6EGzdJgNVYymBxFgw==
=AasC
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
