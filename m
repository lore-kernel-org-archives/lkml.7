Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0225FC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE78220872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfGKMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:23:10 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50895 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfGKMXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:23:10 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9FD24C0004;
        Thu, 11 Jul 2019 12:23:07 +0000 (UTC)
Date:   Thu, 11 Jul 2019 13:20:39 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     kishon@ti.com, Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: Change the configuration interface param to void*
 to make it more general
Message-ID: <20190711112039.leuvelpm7opeoaxq@flea>
References: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c2tecu4d2tdhze26"
Content-Disposition: inline
In-Reply-To: <1562868255-31467-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c2tecu4d2tdhze26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2019 at 02:04:08AM +0800, Zeng Tao wrote:
> The phy framework now allows runtime configurations, but only limited
> to mipi now, and it's not reasonable to introduce user specified
> configurations into the union phy_configure_opts structure. An simple
> way is to replace with a void *.

I'm not sure why it's unreasonable?

> We have already got some phy drivers which introduce private phy API
> for runtime configurations, and with this patch, they can switch to
> the phy_configure as a replace.

If you have a custom mode of operation, then you'll need a custom
phy_mode as well, and surely you can have a custom set of parameters.

Since those functions are meant to provide a two-way negotiation of
the various parameters, you'll have to have that structure shared
between the two either way, so the only thing required in addition to
what you would have passing a void is one line to add that structure
in the union.

That's barely unreasonable.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c2tecu4d2tdhze26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXScbegAKCRDj7w1vZxhR
xR7EAP44QxBQgbt8VyM5okXONW5XGgzi5lMv3iAHBL15ZA3WXwEAnVGOHiv5Ouz3
Bw95hMz8t5Qmcma+5/zZiPcoNIPCdwA=
=sALA
-----END PGP SIGNATURE-----

--c2tecu4d2tdhze26--
