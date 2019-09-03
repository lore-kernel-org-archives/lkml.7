Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C005C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BF6216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567512738;
	bh=YG82gTiuuy+0hjDFZwdVihvNtCRA+nbPq+TJHRMwA8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N2kZS2zl4M9tN/gnjGnFqagwnBzFaeqADfqVwhDw/9OHaTpUUpXZBrF4D8tA4HBBl
	 R5Z17lYwcDt+8LZCckCbw22sZ8ZsgZcKo//odQo8WfmrOQQKs+bD6WTS47WOnMkQgJ
	 VQXFwfv/l4Yf14ZWkkwoHMrm9C2l3z1L9GFmBgG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfICMMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:12:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfICMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YG82gTiuuy+0hjDFZwdVihvNtCRA+nbPq+TJHRMwA8g=; b=QVtX35MHWtQ5hElB6gtdpxIeU
        s3sh1krACvGd+5yXcOHzgxtF3q5KhaCK6CHRslv8J4WZBfYIA9FOce5sdI9Km0OcParWy3oQYWzDW
        4n7VnCclDWNi8eRH1SEtNr574EwlCS5JoO5lnRGzQIYZGJpOEMT7GGAYxubJqgiQ0EjzI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i57fP-0008VC-Na; Tue, 03 Sep 2019 12:12:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D972B2742D32; Tue,  3 Sep 2019 13:12:10 +0100 (BST)
Date:   Tue, 3 Sep 2019 13:12:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
Message-ID: <20190903121210.GA7916@sirena.co.uk>
References: <20190813212251.12316-1-ben.whitten@gmail.com>
 <20190814100115.GF4640@sirena.co.uk>
 <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
 <20190814161938.GI4640@sirena.co.uk>
 <CAF3==ivJycGpSpSy3Y9cL7kNf27=kZmETpb-v0=L7BNd1ZPJtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <CAF3==ivJycGpSpSy3Y9cL7kNf27=kZmETpb-v0=L7BNd1ZPJtg@mail.gmail.com>
X-Cookie: You will pass away very quickly.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2019 at 10:42:59AM +0100, Ben Whitten wrote:

> You mentioned that we likely have breakage elsewhere, I believe that
> regmap_noinc_write probably shouldn't ever have been calling
> _regmap_raw_write.

> Whilst regmap_noinc_read calls _regmap_raw_read, this function doesn't
> do any massage and just calls map->bus->read after selecting a page.
> regmap_raw_write on the other hand is meant for writing blocks to
> register ranges as these added checks show, and does split work based
> on page length etc.
> This splitting up is something that shouldn't apply to the FIFO as it's a
> deep register.

This just means that we need to take care of nonincrementing registers
in there, we don't want to end up with too many different places where
we might have to handle formatting since that leads to duplication.
It's about marshalling for physical I/O, it's a bit misnamed at this
point but nonincrementing registers definitely fit in there for me.

> I modified regmap_noinc_write to be much more like the raw_read
> internals, just select page then attempt a map->bus->gather_write,
> falling back to linearising if that's not supported.
> This approach worked at getting writing working into the FIFO.

Modify raw_write() to handle this instead, it is a mirror of the read
side it's just that writes are more complicated since there's more
things that could happen as you're discovering here.

> So I would propose that there are two 'Fixes:' patches here, one
> enhancing the checking when writing a register range to ensure you
> don't stumble into a noinc register.

Yes.

> And one to fix noinc_writes to send data directly to the bus once the
> page is selected with no splitting up as you would a range.

Push that into raw_write(), it just needs to special case when the first
register in a block is non-incrementing in the page selection logic (add
a !nonincrmenting in the while loop I think).

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1uWJoACgkQJNaLcl1U
h9DPtgf/QDJZEpN/oh11BWf2OipytBVamOF1yMTPyALBAHdYTihwHFTrO7gWAbg4
V+3wRiHEpEAjudpyqt+YnTxKEt3MJm2mqfMRcVuZah/FfXFOa3SEuJeBhi8fjWdE
568d9++vG2mRlrCgqcPFZBI3VhMpifwmfiHC/r3auNIDGWhSBr1gG1T31NemVsd7
XCvOjkHGRU7SowtC5VQ75w/LKmCYzDHzGo52sCh+RCPb5BlAJF9PCHeQ6np0SDvn
0ptOHJVJZsLu1MxcR8BP+bNKDIsO5N/Fnbop9ed95wW9tIYP2M0XAA3T75UXkVpR
gy2roGuCXQgZIs4QtdZ/vfJO3aQOSw==
=YiAn
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
