Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42B22173B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557301151;
	bh=NAecy8/LTJ7hWdxvHmhesqeccfIV6KG5zu9YFY2wFxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZBGubU5dAjOVT/wwJb/3rqskQOnYRan3WoJn2OfXxy1kuvdd+QdSASaj7IxVtDc9B
	 byT0ByS7xsvD0xADfIFnMbFhVgly9RRw2fF7ETXYYPHM8DaoXOZlVjc9/UWUpMQvKf
	 Jg2HJp22uwfceWnaZTPbdTL+xahM80Xs5Jct1Gx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfEHHjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:39:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47276 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfEHHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rcGh0WO6MG4XNO9hM5CGQV3g0vl7i85mz3ORoIw4Ecw=; b=NpG4UZkp/faf48Hj2lcxFSmBb
        1VQQ4hcEPKpq1YO/EAWwoHbjL8MjDWykM8GXEPRyBo+gIRxKGd+XP+CB3r3PkQW7Xe0SGCGwfQ9Ic
        yyPMxkT8RBXxV9/NPln7xhUPKYyDH+SGghSNQHeenV4ER8cdJQFF9+xQTauavSsbd+Qlk=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHAL-0007LY-6i; Wed, 08 May 2019 07:39:05 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 2D558440036; Wed,  8 May 2019 08:00:58 +0100 (BST)
Date:   Wed, 8 May 2019 16:00:58 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the current
 substream
Message-ID: <20190508070058.GQ14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YQa7rwQ/GRwZE7J4"
Content-Disposition: inline
In-Reply-To: <20190506095815.24578-3-jbrunet@baylibre.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YQa7rwQ/GRwZE7J4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 11:58:13AM +0200, Jerome Brunet wrote:

> Remove current_substream pointer and replace the exclusive locking
> mechanism with a simple variable and some atomic operations.

The advantage of mutexes is that they are very simple and clear to
reason about.  It is therefore unclear that this conversion to use
atomic variables is an improvement, they're generally more complex=20
to reason about and fragile.

--YQa7rwQ/GRwZE7J4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSfqkACgkQJNaLcl1U
h9CNHgf8DPUPcHpJuCKPN3bSkYe+k+fejr2ZSHO7YjXjHpH77DkAB87qstFvZ3mO
Y99N2oT9nVhdO/Z0SvUx++6583NK1E9Kgymo4yLbsIYAR3z0lGLi494e8QzvCvov
IyVuT4Bsj0HT/l2j1778lIy6QT7zGMtk+Q87LwWb2AZvlxFNkfjKCg3MiilMA6tu
oFt6FJmazbFH+hhePFVsdaFVTEkn+lxJR7cquICuIHhxenGP3c0z6sTBR6Nn41aK
W4ug1it7JnLohbh9qgQkBlo83GWEWKEC9TgiaN2/ByWDBdADgvC6dE9IPVG2xBD0
jelL896tYbN4WASe9U9mW1CDwi2qhg==
=Cq88
-----END PGP SIGNATURE-----

--YQa7rwQ/GRwZE7J4--
