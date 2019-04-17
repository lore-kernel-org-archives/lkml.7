Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6DC282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EE021850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 02:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555554948;
	bh=XqSk/7BfSAchHuuE6uVRSRZheHtuXmINnGo2ccyeK2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdZtvu8WlYJlLldcMWrQRuAGlbaer3tpYJLjtewunD9Y7+J6fZMUPl3HKgtgwzzVY
	 +QsIKoZ8Ce072HxpV0mo6ImKLG5ePOCnT1It0nOzrxplwZ2H3FKYoBrAap/IuopHd0
	 Od+Y7ylYoia8c6sRC3xuBds/tR7HzlsTibTZJTCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfDRCfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387534AbfDRCfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 22:35:16 -0400
Received: from earth.universe (dyndsl-037-138-087-229.ewe-ip-backbone.de [37.138.87.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA90A21850;
        Thu, 18 Apr 2019 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555554915;
        bh=XqSk/7BfSAchHuuE6uVRSRZheHtuXmINnGo2ccyeK2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hE4HcFzB9L5abJv34b6+VNl5eJUO4GWzv7hC+x4HFWFaf11qoNZgKufUNo+dZd7Xp
         B7F1aEcMr+qyNXeaZ9HzMwJ4bUDYwdh15ycJmbrgRV0GQjFYV16CcIAw8sVb3+u68E
         QNyqvbZSs1wRme0+cZDZLxMW1XJAvkqEk99TYveY=
Received: by earth.universe (Postfix, from userid 1000)
        id A51233C0984; Wed, 17 Apr 2019 23:40:22 +0200 (CEST)
Date:   Wed, 17 Apr 2019 23:40:22 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, lamzin@google.com, bartfab@google.com,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        jchwong@chromium.org
Subject: Re: [PATCH v4 1/2] power_supply: Add more charge types and
 CHARGE_CONTROL_* properties
Message-ID: <20190417214022.7jk3usygcpnls3pr@earth.universe>
References: <20190417004320.232200-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ioz2ovoo2ntuswrd"
Content-Disposition: inline
In-Reply-To: <20190417004320.232200-1-ncrews@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ioz2ovoo2ntuswrd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The changes itself look all good to me, but this does multiple
things in a single patch, so please split it into multiple commits.

-- Sebastian

On Tue, Apr 16, 2019 at 06:43:19PM -0600, Nick Crews wrote:
> Add "Standard", "Adaptive", and "Custom" modes to the charge_type
> property, to expand the existing "Trickle" and "Fast" modes.
> In addition, add POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> and POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD properties, to expand
> the existing CHARGE_CONTROL_* properties. I am adding them in order
> to support a new Chrome OS device, but these properties should be
> general enough that they can be used on other devices.
>=20
> The meaning of "Standard" is obvious, but "Adaptive" and "Custom" are
> more tricky: "Adaptive" means that the charge controller uses some
> custom algorithm to change the charge type automatically, with no
> configuration needed. "Custom" means that the charge controller uses the
> POWER_SUPPLY_PROP_CHARGE_CONTROL_* properties as configuration for some
> other algorithm. For example, in the use case that I am supporting,
> this means the battery begins charging when the percentage
> level drops below POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD and
> charging ceases when the percentage level goes above
> POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD.
>=20
> v4 changes:
> - Add documentation for the new properties, and add documentation for
>   the the previously missing charge_control_limit and
>   charge_control_limit_max properties.
>=20
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 51 +++++++++++++++++++--
>  drivers/power/supply/power_supply_sysfs.c   |  4 +-
>  include/linux/power_supply.h                | 10 +++-
>  3 files changed, 59 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 5e23e22dce1b..b77e30b9014e 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -114,15 +114,60 @@ Description:
>  		Access: Read
>  		Valid values: Represented in microamps
> =20
> +What:		/sys/class/power_supply/<supply_name>/charge_control_limit
> +Date:		Oct 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum allowable charging current. Used for charge rate
> +		throttling for thermal cooling or improving battery health.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_control_limit_max
> +Date:		Oct 2012
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Maximum legal value for the charge_control_limit property.
> +
> +		Access: Read
> +		Valid values: Represented in microamps
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_control_start_thresh=
old
> +Date:		April 2019
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents a battery percentage level, below which charging will
> +		begin.
> +
> +		Access: Read, Write
> +		Valid values: 0 - 100 (percent)
> +
> +What:		/sys/class/power_supply/<supply_name>/charge_control_end_threshold
> +Date:		April 2019
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Represents a battery percentage level, above which charging will
> +		stop.
> +
> +		Access: Read, Write
> +		Valid values: 0 - 100 (percent)
> +
>  What:		/sys/class/power_supply/<supply_name>/charge_type
>  Date:		July 2009
>  Contact:	linux-pm@vger.kernel.org
>  Description:
>  		Represents the type of charging currently being applied to the
> -		battery.
> +		battery. "Trickle", "Fast", and "Standard" all mean different
> +		charging speeds. "Adaptive" means that the charger uses some
> +		algorithm to adjust the charge rate dynamically, without
> +		any user configuration required. "Custom" means that the charger
> +		uses the charge_control_* properties as configuration for some
> +		different algorithm.
> =20
> -		Access: Read
> -		Valid values: "Unknown", "N/A", "Trickle", "Fast"
> +		Access: Read, Write
> +		Valid values: "Unknown", "N/A", "Trickle", "Fast", "Standard",
> +			      "Adaptive", "Custom"
> =20
>  What:		/sys/class/power_supply/<supply_name>/charge_term_current
>  Date:		July 2014
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index dce24f596160..6104a3f03d46 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -56,7 +56,7 @@ static const char * const power_supply_status_text[] =
=3D {
>  };
> =20
>  static const char * const power_supply_charge_type_text[] =3D {
> -	"Unknown", "N/A", "Trickle", "Fast"
> +	"Unknown", "N/A", "Trickle", "Fast", "Standard", "Adaptive", "Custom"
>  };
> =20
>  static const char * const power_supply_health_text[] =3D {
> @@ -274,6 +274,8 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(constant_charge_voltage_max),
>  	POWER_SUPPLY_ATTR(charge_control_limit),
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
> +	POWER_SUPPLY_ATTR(charge_control_start_threshold),
> +	POWER_SUPPLY_ATTR(charge_control_end_threshold),
>  	POWER_SUPPLY_ATTR(input_current_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
>  	POWER_SUPPLY_ATTR(energy_empty_design),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 2f9c201a54d1..d59205170232 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -40,11 +40,15 @@ enum {
>  	POWER_SUPPLY_STATUS_FULL,
>  };
> =20
> +/* What algorithm is the charger using? */
>  enum {
>  	POWER_SUPPLY_CHARGE_TYPE_UNKNOWN =3D 0,
>  	POWER_SUPPLY_CHARGE_TYPE_NONE,
> -	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
> -	POWER_SUPPLY_CHARGE_TYPE_FAST,
> +	POWER_SUPPLY_CHARGE_TYPE_TRICKLE,	/* slow speed */
> +	POWER_SUPPLY_CHARGE_TYPE_FAST,		/* fast speed */
> +	POWER_SUPPLY_CHARGE_TYPE_STANDARD,	/* normal speed */
> +	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
> +	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
>  };
> =20
>  enum {
> @@ -121,6 +125,8 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD, /* in percents! */
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD, /* in percents! */
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
> --=20
> 2.20.1
>=20

--ioz2ovoo2ntuswrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3nUYACgkQ2O7X88g7
+ppslg//a/eyNS7uC8rs0eFylYaA2eKa2i6MZAaEyUhFOraXzRqz7Pi6kC2hoytr
pExxFBUSTrtYzRSAL6OMALMiummqPdiAwLEnfWkT9wVomzO+5RhGnhVzxWWuiPtI
QryvIYA53xwwa2nKvzfZ/oOk88AouUh8e6DerQ+KtmI5E1v24zyBlrDe7H6Lh+d/
sUq+StIpCutoPB/xYKJY7NwEjHs82ChnsPfTyjo55vLi11+V8iebZdS8wVSNGGnU
W6jMcPdFaX9ab+Jl3F8taReHFoqhEccbDj6AUiP0Nm3P4HCi3dnx/g6JA9cNGoZG
+uNIsWQzBSaZVMDv9f/gEHrp0eLEkKzdYig0QWm/xO70rRIOUlRk6UTMsy+oa5KY
8hm9GKaMoj/5ELwAq8opZ0TWfJEoc16iDwkzPulCS/VajcblRStLVV8b/217GJKp
9BT24P3/eZJR/a0KzyoH3VJRo9TvSO9tQQZs+nNW2bDkX18u0eGj2lkqvsBPdQDY
wAb3zpzZxVUAnxjz0Cbw3/kx5paV+YTPKWsx2Zi6TwC6QKuif5zVGhDPTISgkHRC
GGWhGM0SBdjyfl6YsnEoOwr4VT2lnpc1pLeohFwz17lycsOoRCtleejoSttYW1y5
g2cL7wiDB9QldPWVW49DtMeK/juD/A0y+cV3CQakioMfqD+GSM8=
=OL+G
-----END PGP SIGNATURE-----

--ioz2ovoo2ntuswrd--
