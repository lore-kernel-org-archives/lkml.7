Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE668C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559758771;
	bh=z2449oIoMxCMf05ewxCgr8nvzAgC1WKf7tzs4LUZww4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IrsoCdp+FtOXiHF5XAGBaLyuLVoz0o5sc7mJ62KVeYGw34vlrQq6LmOZdIAwN47Ll
	 K8bekwjzxAVwlbzKCD/WHhJFflUqAWlO3J4GxUpPStC3aJ9Y+HNuUuy8u4QFWsKsyQ
	 LEs5z4XAmDNS/16yOcXO5YuKc+yGKMD+K1ymO4qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFESTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:19:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36098 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFESTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z2449oIoMxCMf05ewxCgr8nvzAgC1WKf7tzs4LUZww4=; b=hnFDrNh2DslYLoRjh5wN7qj55
        gCrGZaH+wsTspLUeaiQHh65bvr7exJKjHxyMwiP0bRJ2kek8WECA8OcVyLZMtKu9wSt5uA54HmANN
        0rYKSwzl5mBHgJcf5h0Ug8hVjK32gtuquvevNpspgjWvp2mSYjc2MdVgQbrt3AHNyPb1Y=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYaUy-0001AG-Fj; Wed, 05 Jun 2019 18:18:56 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D4DF5440046; Wed,  5 Jun 2019 19:18:55 +0100 (BST)
Date:   Wed, 5 Jun 2019 19:18:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andreas Noever <andreas.noever@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Corey Minyard <minyard@acm.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Kershner <david.kershner@unisys.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>,
        Felipe Balbi <balbi@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Len Brown <lenb@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Jamet <michael.jamet@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 02/13] bus_find_device: Unify the match callback with
 class_find_device
Message-ID: <20190605181855.GV2456@sirena.org.uk>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EEDXPAtTg2mD7Iri"
Content-Disposition: inline
In-Reply-To: <1559747630-28065-3-git-send-email-suzuki.poulose@arm.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EEDXPAtTg2mD7Iri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2019 at 04:13:39PM +0100, Suzuki K Poulose wrote:
> There is an arbitrary difference between the prototypes of
> bus_find_device() and class_find_device() preventing their callers
> from passing the same pair of data and match() arguments to both of
> them, which is the const qualifier used in the prototype of

Acked-by: Mark Brown <broonie@kernel.org>

--EEDXPAtTg2mD7Iri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4B44ACgkQJNaLcl1U
h9AP1Qf7BosK6S5EJ3oSKd/4Ff/u6NARI5+Sut5+66fdSBrGM/hGX3xyPsbJ1wz7
6NNZ9Fa+LGnjiednm3MV4N26bMDSjObtSPHcN/RDrQXVj6FzvLWMy6RaHT8U60Vq
g0dYTLbl7C7rYzUi8hvgECvw2OcMC4fBSQqoRA6+Rngpt80JexV+GiDXdhssdQFM
MsPampHlCdVdoEROayITj1O3nJAMbXhKtAa5ITp/ZgGHbbdvThaP2yHqI4DY1ObE
7T0GGw/8C387ACiTS0kvX3bg/jUg1YpyfpfK1gc1HhoUC2j2vLFWsBoqG7rNO3W1
EasG+SiNHA5D1PA2EImJcNDIGmLSCQ==
=+R08
-----END PGP SIGNATURE-----

--EEDXPAtTg2mD7Iri--
