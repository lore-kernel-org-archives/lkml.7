Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F997C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053C1206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 11:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570532882;
	bh=4kY5An87uzyz+0sviXcMxpEenHMYMAASPINVI2WYN4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSxE/2lYbqJ0Xit+1gPeuRD3Kd/U7rLqjfmYwBwxjpLeD1MAn7mAjbVNzkJKAYQx4
	 a7+4ax3N8U0C9QsUaAJ+14K0sTQzGSuWQp3/rdsKADSVNQj+FfkARCMj2jdAwAZvtv
	 rVo298HFdf7iiaTJCog1/tR7zHzBefxGONHqXdG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfJHLIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 07:08:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfJHLIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=arx0iJ9oCcD6kiiS1i6MFFkHgoYnfedXHBCD6Yt/pqM=; b=P+C81FXqN4/H9k4+FPHIXGHl0
        1oxcHV7+qVHe4/Pu2yWrd1H70E1lV1Wq7iYNxlHgEUITWP/tbW+ewZR2ihhcz7PGBFDi4pavECOkW
        Gn5VZL2VGVsa/JIsgwMDezgrslv2cmD9QLAao8H8sElGAohdPWUFcZTE2oumgL8xjv8AQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHnLS-00086j-Fk; Tue, 08 Oct 2019 11:07:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0343B2742998; Tue,  8 Oct 2019 12:07:57 +0100 (BST)
Date:   Tue, 8 Oct 2019 12:07:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [RESEND][PATCH 2/2] regulator: da9062: Simplify
 da9062_buck_set_mode for BUCK_MODE_MANUAL case
Message-ID: <20191008110757.GE4382@sirena.co.uk>
References: <20191007115009.25672-1-axel.lin@ingics.com>
 <20191007115009.25672-2-axel.lin@ingics.com>
 <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com>
 <20191008104407.GA4382@sirena.co.uk>
 <CAFRkauDq=6X9LRj7APwKOV+7CVZN5OSVuWXmwBQ3QQPWD9Nauw@mail.gmail.com>
 <20191008105101.GB4382@sirena.co.uk>
 <CAFRkauCft5p4P_LkZVLde62Yh03p-_2hNPm6wEct5XSeg-p0Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <CAFRkauCft5p4P_LkZVLde62Yh03p-_2hNPm6wEct5XSeg-p0Bg@mail.gmail.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 06:53:22PM +0800, Axel Lin wrote:

> But if I generate the patch on for-5.5 branch, I think you will get
> conflict when merge for-5.4 and for-5.5 to for-next.

Right.  I will probably merge the 5.4 branch into the 5.5 branch at some
point, if something doesn't apply I will say so.  Like I say I've not
looked at that yet.

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cbg0ACgkQJNaLcl1U
h9BCrQf9HN89mZXia0lhlu9Ty/WeykpHCfJaU5mT5duKOGcV6gqwea7nQOYqRYXz
nZvgK4SCjQmnfRp72HZhR6I+B58oW+srv6y/+JDdHgN8W6Ut7Y4yIGk4asU0AXqf
kYZakmfy88t9bR1RtbsN36kcVTyLCP1b2sGewQ0oPMJFMFIUV49IVDI5eTN8xM+D
ZhtoOqZDM6yQz2CaoSTKDbZy7IJquYnngvFb20t25RcLzaK6YZ0Ig1oAvJ43OYGM
AtHeENsSsdHUFNX2ZVL7CGZXVs6G+ijABMWlTBXm102M/olOsdalMK6MoBVKuKDB
nlZaQbcdkzN35yH5wc5F45WsQI8+Rw==
=F7Du
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
