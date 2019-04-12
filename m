Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182B7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E3D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDLJei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:34:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52497 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:34:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4284B802DD; Fri, 12 Apr 2019 11:34:27 +0200 (CEST)
Date:   Fri, 12 Apr 2019 11:34:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     ulf.hansson@linaro.org, kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>,
        Trivial patch monkey <trivial@kernel.org>
Subject: [PATCH] Fix warning and undefined behavior in mmc voltage handling
Message-ID: <20190412093434.GA24516@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

!voltage_ranges is tested for too late, allowing warning and undefined
behavior. Fix that.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

---

Plus I guess author should add parenthesis in the expression. a / b /
c is _not_ common idiom.

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 3a4402a..b3fa9c9 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -363,11 +363,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 =
*mask)
 	int num_ranges, i;
=20
 	voltage_ranges =3D of_get_property(np, "voltage-ranges", &num_ranges);
-	num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
 	if (!voltage_ranges) {
 		pr_debug("%pOF: voltage-ranges unspecified\n", np);
 		return 0;
 	}
+	num_ranges =3D num_ranges / sizeof(*voltage_ranges) / 2;
 	if (!num_ranges) {
 		pr_err("%pOF: voltage-ranges empty\n", np);
 		return -EINVAL;

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlywW6oACgkQMOfwapXb+vKoUwCfWbPLHUct8b8G0sHsIgxXQ7Pd
cBsAnRKktGDA/0jZ7O3fxF7sYFkQGZyb
=ZJX/
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
