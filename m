Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEC5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39CF2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfCEL7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:59:33 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38583 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfCEL7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:59:32 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D4C8FC0007;
        Tue,  5 Mar 2019 11:59:26 +0000 (UTC)
From:   maxime.ripard@bootlin.com
Date:   Tue, 5 Mar 2019 12:59:26 +0100
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 10/15] ARM: sunxi: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190305115926.za332f63piwpnxux@flea>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-10-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ffjjji2iwbywqv7a"
Content-Disposition: inline
In-Reply-To: <1551785646-46173-10-git-send-email-wen.yang99@zte.com.cn>
gFrom:  Maxime Ripard <maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ffjjji2iwbywqv7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 07:34:01PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>=20
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-sunxi/platsmp.c:55:2-8: ERROR: missing of_node_put; acqui=
red a node pointer with refcount incremented on line 46, but without a corr=
esponding object release within this function.
> ./arch/arm/mach-sunxi/platsmp.c:138:2-8: ERROR: missing of_node_put; acqu=
ired a node pointer with refcount incremented on line 129, but without a co=
rresponding object release within this function.
>=20
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ffjjji2iwbywqv7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH5kngAKCRDj7w1vZxhR
xX4qAQC3g5Y+G6BrB/fhaiogrHS0yAs7jzz4grg3O2c5NOKMGgEAi5UIlA6a/t8H
YETwNXj9AssBJxxxv3JBNOxTSF0AdQs=
=Scxs
-----END PGP SIGNATURE-----

--ffjjji2iwbywqv7a--
