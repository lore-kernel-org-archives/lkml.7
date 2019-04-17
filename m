Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E512AC282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AD121850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555554945;
	bh=9tvhrTqKB3szgb6yq7OydqhhWOzHUAaudyWsUudeAtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ANY6ISNs3cjDWFrrXvXSW2xVFc6BvnPyWjG7LyPUL3auR8lJunU1AjaYnhFfS13Ib
	 03nR3soA7voq3cIXb5xVnf/BIZE8DAYRVz8iubotpRG296+B6JwWpaBb8KNxuNCb1j
	 Qe3NCJuBDzleRy4SXXAJq86gboDBDrwXzZC6WM94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbfDRCfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387839AbfDRCfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:35:16 -0400
Received: from earth.universe (dyndsl-037-138-087-229.ewe-ip-backbone.de [37.138.87.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DF321871;
        Thu, 18 Apr 2019 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555554915;
        bh=9tvhrTqKB3szgb6yq7OydqhhWOzHUAaudyWsUudeAtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYLaWUEynyzqCHh/YZO28y19TbP7ZQOhvaMnKftwp1dquKbGYaCKKj6XIxIJK2fR0
         RMT5NbqbWjeLtGKW2DhDuW9L6Joo5eRDAJAeG4iYVW9/xs/EibB8DqGaoEAM8gD7V2
         Z4FLs5tvuSTf6YqBcCW/XAnmGY7mOCPWBIEbr0R0=
Received: by earth.universe (Postfix, from userid 1000)
        id A48F33C0986; Thu, 18 Apr 2019 00:37:08 +0200 (CEST)
Date:   Thu, 18 Apr 2019 00:37:08 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sysfs: prevent endless uevent loop with
 CONFIG_POWER_SUPPLY_DEBUG
Message-ID: <20190417223708.4irrwrm4q7vig3vh@earth.universe>
References: <20190405073020.10361-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjgjrdmhm5424q6v"
Content-Disposition: inline
In-Reply-To: <20190405073020.10361-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjgjrdmhm5424q6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 05, 2019 at 12:30:20AM -0700, Andrey Smirnov wrote:
> Fix a similar endless event loop as was done in commit 8dcf32175b4e
> ("i2c: prevent endless uevent loop with CONFIG_I2C_DEBUG_CORE"):
>=20
>   The culprit is the dev_dbg printk in the i2c uevent handler. If
>   this is activated (for instance by CONFIG_I2C_DEBUG_CORE) it results
>   in an endless loop with systemd-journald.
>=20
>   This happens if user-space scans the system log and reads the uevent
>   file to get information about a newly created device, which seems
>   fair use to me. Unfortunately reading the "uevent" file uses the
>   same function that runs for creating the uevent for a new device,
>   generating the next syslog entry
>=20
> Both CONFIG_I2C_DEBUG_CORE and CONFIG_POWER_SUPPLY_DEBUG were reported
> in https://bugs.freedesktop.org/show_bug.cgi?id=3D76886 but only former
> seems to have been fixed. Change debug prints to use pr_debug insted
> to resolve the issue.
>=20
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

I think we should just drop these debug messages, just like I2C did.
They don't offer any useful information considering the info is already
exposed to userspace via the uevent.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index dce24f596160..5e91946731fd 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -383,14 +383,14 @@ int power_supply_uevent(struct device *dev, struct =
kobj_uevent_env *env)
>  	char *prop_buf;
>  	char *attrname;
> =20
> -	dev_dbg(dev, "uevent\n");
> +	pr_debug("%s: uevent\n", dev_name(dev));
> =20
>  	if (!psy || !psy->desc) {
>  		dev_dbg(dev, "No power supply yet\n");
>  		return ret;
>  	}
> =20
> -	dev_dbg(dev, "POWER_SUPPLY_NAME=3D%s\n", psy->desc->name);
> +	pr_debug("%s: POWER_SUPPLY_NAME=3D%s\n", dev_name(dev), psy->desc->name=
);
> =20
>  	ret =3D add_uevent_var(env, "POWER_SUPPLY_NAME=3D%s", psy->desc->name);
>  	if (ret)
> @@ -427,7 +427,8 @@ int power_supply_uevent(struct device *dev, struct ko=
bj_uevent_env *env)
>  			goto out;
>  		}
> =20
> -		dev_dbg(dev, "prop %s=3D%s\n", attrname, prop_buf);
> +		pr_debug("%s: prop %s=3D%s\n", dev_name(dev), attrname,
> +			 prop_buf);
> =20
>  		ret =3D add_uevent_var(env, "POWER_SUPPLY_%s=3D%s", attrname, prop_buf=
);
>  		kfree(attrname);
> --=20
> 2.20.1
>=20

--xjgjrdmhm5424q6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3qpEACgkQ2O7X88g7
+pqOSQ//QuszE8iHqFMu2cJSEUKk0bWMOrbSpl/rEsxCFW0+hQPXNxLy/Yscs11l
cTTSMX11dDp8JYHtZFBEsccX052mg/+W0DGzdIRNQ2X9cPjTgF+mWAcBR7wzcD2O
LkON9QAroF6K6Lsc/oiu3BNg8us6dJu0YdBIKa+L4OBE6MBhq/wvtAHOsmK1n7m2
lP3rLTzeojKODAuhyLt568DhJ57V3Bq5ioPumf9b1+FEJlGCrwpnyFM5LvM0Jg2u
f3TdCVdVHiDLGGyj1jMZ91vQ8Zb4mSYC3h3UZaTYTdus6vgbYda8c2vI/FiP8UIG
CxVHrOVFQEOGkAyBMGro7BR6107TF6SH4nizIQSgKGS7GhdnJaM96wqoiZFKutuT
asR5NB3W/CBX5iHZ1jBUqld1fVZJezht2GVonbWJrVWARqGjVioKNPdCQQino/du
ULSMJnhftce97Ku1GHMNmgFGRAj6OEmsiArLhiE9r9Jgn67n8yt0VEJJleCTqmTa
50y1CjjiGEtSuyar1DcElLtz3slqsM/oSbmkje1X1PGoIjLa+Hm9kvsDCKyeTxXl
J7i9O9zLPsUKSrnefrysTzizy216DOfS0ssJjxAvmlNlnVmN5jGWg9HbtXtv+rkj
JC3OU7ElMgHzcB92FOYdUAxcgkbWSMG3/t+p0vPas0ZVL0ln5P4=
=7bQo
-----END PGP SIGNATURE-----

--xjgjrdmhm5424q6v--
