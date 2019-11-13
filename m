Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD496C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AF2206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKMUTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:19:17 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:33820 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfKMUTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:19:17 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 7604934CDB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 20:19:15 +0000 (UTC)
Received: (qmail 24118 invoked by uid 10000); 13 Nov 2019 20:19:07 -0000
Date:   Wed, 13 Nov 2019 20:19:07 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Drew DeVault <sir@cmpwn.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        " Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht, robbat2@gentoo.org
Subject: Re: [PATCH v2] firmware loader: log path to loaded firmwares
Message-ID: <robbat2-20191113T195158-869302266Z@orbis-terrarum.net>
References: <20191103180646.34880-1-sir@cmpwn.com>
 <20191113005628.GT11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rPF8rPXpDlNr1aSW"
Content-Disposition: inline
In-Reply-To: <20191113005628.GT11244@42.do-not-panic.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rPF8rPXpDlNr1aSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 12:56:28AM +0000, Luis Chamberlain wrote:
> On Sun, Nov 03, 2019 at 01:06:46PM -0500, Drew DeVault wrote:
> >=20
> > This is useful for users who are trying to identify the firmwares in use
> > on their system.
> >=20
> > Signed-off-by: Drew DeVault <sir@cmpwn.com>
> > ---
> > v2 uses dev_dbg instead of printk(KERN_INFO)
> >=20
> >  drivers/base/firmware_loader/main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmwar=
e_loader/main.c
> > index bf44c79beae9..2537da43a572 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -504,6 +504,7 @@ fw_get_filesystem_firmware(struct device *device, s=
truct fw_priv *fw_priv,
> >  					 path);
> >  			continue;
> >  		}
> > +		dev_dbg(device, "Loading firmware from %s\n", path);
>=20
> Because this is dev_dbg() I'm willing to consider it, so that its not
> always enabled. However its not in the right place, the code path you
> are addressing is only for direct filesystem lookups. If that fails
> some systems do a fallback call out to userspace. To cover both cases,
> you want it at the end of _request_firmware() on the success path. Can
> you send a new patch?
As the author of a separate patch that predates Drew's patch (originally
in July, with a later version sent to the list last week):
https://pastebin.com/Tf09x3ed (v1)
https://lkml.org/lkml/2019/11/7/800 (v2)

This already uses the _request_firmware path to fire after the firmware
was successfully loaded. The commit message is also specific that it's
to cover early boot situations, before UEVENT can be logged.

dev_dbg means that the loglevel must have been set to debug BEFORE the
firmware load took place, but this means either setting system-wide
debug spam or requiring debugfs, which is annoying for boot stuff (not
impossible, just annoying).

I have two uses cases overall:
- log so you know exactly when it's loaded successfully (great if
  loading a firmware causes your system to lock up a few seconds later)
- at some point in the future, being able to query what firmware was
  loaded in the past, and esp. exactly what version/data was in that
  firmware file.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--rPF8rPXpDlNr1aSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAABCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAl3MZTlfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSwNg//XS4T7SmC0xiblewKz/No+63tlObI8ZHVxPz0Pud6g2Jew1yXKg3cDvaX
P8bZwznqQUB4XrogsLKItf+tc4e+UsLHy+TNg891oPkcPv39aGcq/u695PaYy6AX
bMMK6C/q3L4wzXG46h0OZ75FXpGFuVWn7xrEConkVCjXF0AZ99Pk7UVcXCpTEsUG
Tc2vquofoqosUbc2MScfuCwNUvecgJB8RTqA8hrmTppgjgqoIxAUs3b9FLfzJAa0
bgOAmvQiYCe/Vj2iMfekY28jUQ0KCYh67c28R5ruQF83XsfXvDUasCuzr3P5c2bE
lWEDed2LGjqhc7gf1rG0HHoxMIw5vIQ0n8k7iRd+dEdFLsoIf5EGRQO6yCnTKWC9
JHfY0spuvyLygJHfc9rql8AveXhgvE7tFFQvKKdEXtKrXfkbw6UGp8/oTigKWFw8
ovRhAv2NTDcub3U7Q1A4gY8/CvR8vX9fnEV0kYCEt63fCX7aTov03RHrEvC5fK4t
RAEfQ2zLQEMETqT4wTLp/dGvnO1F7YkP2cV+eZJig32OWdM+qhZ3M4XqMMwvfhbb
JdY9w5Z/TibMCCfhQ5HBVMihURvtZ+k3MtMc2vTAjNW8HaoKk5L2k4qYYrJwk2tb
/ZSyLEO6geBnzVmcgx4txdz28uJQbj9gzvEuZE7xazkjAV6MHrU=
=tbEk
-----END PGP SIGNATURE-----

--rPF8rPXpDlNr1aSW--
