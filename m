Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE64207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554195972;
	bh=O4ryyfuyWqBCUvs+14tFDyrs3WEqNlrDFRoWNSFfwbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UMOsNSufMKa1b5Jj1i4jgrSBMFXKN9RGVIipQmqz/TJy1QD1iJWX7AHUj1fsw4K7f
	 Kq5Aqzo9N6fGmAbO5SOavV9Mi8xfp+rt/pIAColb2T9J3HD5JuGMY1xm5nzEh4Wu+9
	 kJ0yi2OSasKiQTM5LAKN9AsxxU3u4CuADyLAnHZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfDBJGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:06:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42438 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDBJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J+yTkPnSkYPKatQiv44dU+Ff4S5A4plnRRlN+4IJ6QE=; b=bTYzX2ih1BX0P8BvqN4UPq28I
        pMrMdN/lPNeV42dyCIEM5PidvokLrZJlvOBZF7y77EpRm+gkDFuaMydxGS6em1TPbFYWx91S8pceT
        hMuYZ6CcnQwEfDdi90QvN/pP/cFx0gfhpylvb5kT1UoH7yQiA3twOIhI9t6CCoy4ct2/M=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBFMr-0006l3-GE; Tue, 02 Apr 2019 09:06:05 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 044B5440082; Tue,  2 Apr 2019 10:06:01 +0100 (BST)
Date:   Tue, 2 Apr 2019 16:06:01 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] Verify if register is writeable before a write
 operation
Message-ID: <20190402090601.GB2059@sirena.org.uk>
References: <20190402080100.4875-1-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kncZREqT6Wt3NQEl"
Content-Disposition: inline
In-Reply-To: <20190402080100.4875-1-nandor.han@vaisala.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kncZREqT6Wt3NQEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 08:01:21AM +0000, Han Nandor wrote:
> Description
> -----------
> This is an RFC because I don't know if this is a bug or a normal use
> case. It seems that the function `_regmap_raw_write_impl` from the regmap
> framework verifies that a register is writable only using
> the callback function, ignoring the other two (max allowed register,
> register ranges)

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--kncZREqT6Wt3NQEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjJfYACgkQJNaLcl1U
h9DRFgf+MdqDeBy6Gt3D0VDMdBLWjJoY4KAWu1VeeEzC+Sqrdc9pfDA5JVeSPXM3
GzvdI22mei7imMWFf95OBBAgNsVoAZ/EviZrw3ruarkewhhwCN6b2bU4pBPwxHPS
bRVkF5P3EYPyfIrqIHB6Fc8ZwGuAyQQkmt/29QOqdpsnkv8omuX5n+IVIYGitfU2
lRfzB2Mlot/rpL+y6vTSYsnlbSATwc1v3XZfRza6pQQanqjh2hhu0plS8jwFgCOy
IXRoju9AhMWQdlic8OJ6uHDfaMW6vioMoWsHVlyXPBKrSckp4yfgQQXd4xJlv+p8
dTi7rpGag9x4dUJ8gD1hT/+dUL1aOQ==
=IOIA
-----END PGP SIGNATURE-----

--kncZREqT6Wt3NQEl--
