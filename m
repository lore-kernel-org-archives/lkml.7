Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7881C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6881520856
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562428435;
	bh=uT3EnJ1csJNvVEUQ9BXrl6vxOcXvYVkS8DMZsOFZjIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q/lNzb6Bgg0QixmRl8/UtFnI5UID5H9bSbiHfN/k8IXPgs8mOOh+/b1D+vY80Wamt
	 0tm1+gtZUjPLGJXDT0JmgPCzKLE1X7OCcCRJUbMd0NwnhEImVJlK1Fdt34D2oUNxUs
	 v9K35nn4Hf62S4F3zcoQSE1c//xSIaRBAP5I9vbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGFPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 11:53:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39022 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGFPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uT3EnJ1csJNvVEUQ9BXrl6vxOcXvYVkS8DMZsOFZjIs=; b=H7qkrD3Ue4J7TvYoknFUj8/Mr
        sR8rWPLAT/YPjzf8/MKnBxtoGLrf4AwGPc1PsbxwuA4JgyfS0Bo6ky8Va8syfmuVSEQzb/cEq6yOe
        9tNpHZyjsq0kG1tC4zE1kZ189GCwPL1qdYoDmRL3PLdiWz/7/NHaNrR85rzpQO5NVdRqI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hjn0S-000770-Rc; Sat, 06 Jul 2019 15:53:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D8B9E2742D9E; Sat,  6 Jul 2019 16:53:43 +0100 (BST)
Date:   Sat, 6 Jul 2019 16:53:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] debugfs: make error message a bit more verbose
Message-ID: <20190706155343.GI20625@sirena.org.uk>
References: <20190706154256.GA2683@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <20190706154256.GA2683@kroah.com>
X-Cookie: How you look depends on where you go.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 06, 2019 at 05:42:56PM +0200, Greg Kroah-Hartman wrote:
> When a file/directory is already present in debugfs, and it is attempted
> to be created again, be more specific about what file/directory is being
> created and where it is trying to be created to give a bit more help to
> developers to figure out the problem.

Reviewed-by: Mark Brown <broonie@kernel.org>

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0gxAcACgkQJNaLcl1U
h9CgEQf/bH/ALZv7b7d9lTDRogs0FI8baJvBAUVbFnxy6l7jIs4xHjIHCzYH9uFT
P94K5PwJVRyg3A8JU3xDt/mBiJ36qpz9eoyTW9vtcWV0QAcj3Zb/H61PxeKVxwf3
DVigmFOHOWeqAqMKH9x32xvh+3235z5ALSqJRzs94p+0q4cXGfWI7GG4hAX5GAdy
iecUAwuolo42kux5AB+rONFy81zWdJfsUuHCE7/u+/jMNP+MVHQ1hN1TM4mO0P1V
6pR/jKxKf3xhTKGLg/ucVenTDGqfReXguzKGEBuWo4N+6dwB7AR90jB4iLEfy1bo
7GO7Za5akavM9VgSw51E3h6LZV2STA==
=bfOD
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
