Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BFDC2D0C9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 09:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DD82467E
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 09:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfLNJNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 04:13:12 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:38754 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfLNJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 04:13:12 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DAF9A1C25E0; Sat, 14 Dec 2019 10:13:09 +0100 (CET)
Date:   Sat, 14 Dec 2019 10:13:09 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jonas Meurer <jonas@freesources.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>,
        Yannik Sembritzki <yannik@sembritzki.me>
Subject: Re: [PATCH 1/2] PM: Add a switch for disabling/enabling sync()
 before, suspend
Message-ID: <20191214091309.GE16834@duo.ucw.cz>
References: <1ee5b9ef-f30e-3fde-2325-ba516a96ced5@freesources.org>
 <fceb198d-af5b-4d2e-ca55-8232295b202d@freesources.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline
In-Reply-To: <fceb198d-af5b-4d2e-ca55-8232295b202d@freesources.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-12-02 18:07:05, Jonas Meurer wrote:
> The switch allows to enable or disable the final sync() from the suspend.c
> Linux Kernel system suspend implementation. This is useful to avoid race
> conditions if block devices have been suspended before. Be aware that you
> have to take care of sync() yourself before suspending the system if you
> disable it here.
>=20
> Signed-off-by: Jonas Meurer <jonas@freesources.org>
> ---
>  Documentation/ABI/testing/sysfs-power | 14 ++++++++++++
>  include/linux/suspend.h               |  2 ++
>  kernel/power/main.c                   | 33 +++++++++++++++++++++++++++
>  kernel/power/suspend.c                |  2 +-
>  4 files changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/te=
sting/sysfs-power
> index 6f87b9dd384b..f164a364e89a 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -407,3 +407,17 @@ Contact:	Kalesh Singh <kaleshsingh96@gmail.com>
>  Description:
>  		The /sys/power/suspend_stats/last_failed_step file contains
>  		the last failed step in the suspend/resume path.
> +
> +What:		/sys/power/sync_on_suspend
> +Date:		October 2019
> +Contact:	Jonas Meurer <jonas@freesources.org>
> +Description:
> +		This file controls the switch to enable or disable the final
> +		sync() before system suspend. This is useful to avoid race
> +		conditions if block devices have been suspended before. Be
> +		aware that you have to take care of sync() yourself before
> +		suspending the system if you disable it here.
> +
> +		Writing a "1" (default) to this file enables the sync() and
> +		writing a "0" disables it. Reads from the file return the
> +		current value.

This pushes kernel's responsibility on the user, and adds to the mess
we already have there.

Just... don't do it? Move sync somewhere where it can be done?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXfSnpQAKCRAw5/Bqldv6
8q6bAJ92QKXMCK/ZABzn9Z7P07mkVNnNEwCdH3hSEys6FZPbk5dgcCAUt/5PYAI=
=GrT5
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
