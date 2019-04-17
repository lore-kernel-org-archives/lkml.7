Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E398C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA7E20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555522243;
	bh=EdDKP2v2XJ4A72v1Ol4nO6a3SZ84z9vrO9tTU7EJFJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hVtGZCBYCoYjOPs73f0mJ2rllqO5DyyPemC3L7us17qI7xtLkQXqBoEmH8FhecfZa
	 VLDPpRYaLuRGSBG64g9c8DRsSqz2HpSrii+mAC/78Kiahz9fRnPXrlcD94Ttc/V5RS
	 cdljoIEgIzX032kMkneviOxOCAynqEyhctsFqnbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfDQRam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733116AbfDQRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z4NFFmMFqd0ev92zoogo70gGg3//WdcYc+2hYhOFmCA=; b=iJB719y1YI1/BqRsl0Pz1TYbb
        erPYbUmee9kf32+lELcufbYY6Qx2JGuZapvELr9RpLk8jXK6VNlcRTG88MUXnHaCDEc2M8YQtUJfg
        QUJKQGxphQbWsgrmv1lBVFPlil73tcCAFpqTOMyHJJe+WSmioXbzwX+pe78h8sil8U2go=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGoOD-0001YA-Fr; Wed, 17 Apr 2019 17:30:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C3ECE1128FC8; Wed, 17 Apr 2019 18:30:28 +0100 (BST)
Date:   Wed, 17 Apr 2019 18:30:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH] regulator: core: do not report EPROBE_DEFER as error.
Message-ID: <20190417173028.GF5703@sirena.org.uk>
References: <20190417085411.14552-1-jorge.ramirez-ortiz@linaro.org>
 <20190417154638.GC5703@sirena.org.uk>
 <7d84d820-c3e9-16cb-b5b7-31761589d4ec@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
In-Reply-To: <7d84d820-c3e9-16cb-b5b7-31761589d4ec@linaro.org>
X-Cookie: Boy!  Eucalyptus!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 07:05:52PM +0200, Jorge Ramirez wrote:
> On 4/17/19 17:46, Mark Brown wrote:

> > Please leave at least a debug log in place, it's not good to just
> > silently fail - even if we will retry someone might still need some help
> > debugging (eg, figuring out that they need to enable whatever driver is
> > providing the supply in their config) so we should tell them why we're
> > deferring.

> you mean replacing dev_err with dev_dbg on all cases or only on defer
> leaving  dev_err on the rest?

Only on defer.

> > BTW does an e-mail address need updating somewhere here?

> dont know, whose email? I got these from get_maintainer.pl (below); or
> are you referring to mine (in which case it is correct, I am back at
> least for a bit longer)

It was yours - you didn't show up in meet the team yet so I wasn't clear
if it was just an old patch where the e-mail address had been copied
over.

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3YrQACgkQJNaLcl1U
h9Ai0Af/cFsyU/9BDDsEbm+0lTYtK1LC7EyOfS6Ijqvb4M26O5hETmx2JIOf8ri6
ijGXHv/oXis5FBQ3Q9aHcvab0sRlKn7eb8bJD8A7aALXCvkjgkJexmguenbvk1wT
2gsHT482iSAmg2+i1iyt6aYUc0bFWvsAGrFUFuCO5aNxxiH3J5IMVqEtQEZouImP
mvqEb89vRdwFQ5DYva7J91ldLrKM8W83dn92Ug5WYlJAvfLg3LU/mIvMcs/rKBiG
WO5rEAgRx/BSf5JkbilId15vBObFXW9TcKq9LI9oXei9CwIhwxmq0SUI07Ghz1zn
QeU/nuNHl5qrqGLqftKhcHkYKsN9ow==
=Jih1
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
