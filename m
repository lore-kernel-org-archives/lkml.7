Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1FFC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BB521939
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWX+jjii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKRRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:32:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55651 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:32:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so126543wmb.5;
        Mon, 18 Nov 2019 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cUOn4dXQObR7q+VBOZahx/ugZjKHh2rWdB8yZdQGkI=;
        b=nWX+jjiizY/XT+BAk1ctVJ1fdnxY5KQ50xN1jo+PQ4iae9XeYK6gM/spIaPzc8Nb07
         bFNlxbj9VyzaEzfZDXWrzQ5D1a7BGV7PpqQFB73jOORcMYP0fCJL15e+iglW39/+nzcL
         /5bjXHEzM85mreMl5DUfCf1Y23HhN9SSyWz+GC42DDKvERWzjSMk3q3P89ggVsVv4edx
         eKYGwWmeno1SWhK5ZXdmoA9EiI3foSzDdy0Vp+sBW0yYOFNqcVtMc6WFWTxbocF6HY4l
         qY5Yo4HuGPOdnwmCeuTYq16iYHk58zz6G+QY7pcDjtj32fotR8vMo1jgy026iNNOwVAF
         cEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cUOn4dXQObR7q+VBOZahx/ugZjKHh2rWdB8yZdQGkI=;
        b=umyAdOB/uWtoNn/voqCCz3SMlxVNRKpW0KQFzqr2C8kx7Sxw+TNcb5v8J74EZS28JN
         8mrUWiXcxDEz8b5U7p9Wmm45VIpSIPdc05WqHNJTkOyvgmiqfXcE6abA9aYBwUxo651g
         64cC96srTRsPPV4dYY9dW9IlDyXKIhpBQZLfLRQfGfgvGcJyYvewngpd/PT+DTv8P8JA
         qciQkGtuzU1IZaDzizaJp6PGDpt+KwYF6CwVPsDkgaruRoUueGHEVDrsq6Bdm+9ZCFVr
         6ZwfyVa3t58SkQqy1gLNF5KwsLHmmZh34KZKtFeRSFG97TPAhUetFRq2zX5sxuDyjK9N
         l2kQ==
X-Gm-Message-State: APjAAAWP9is6dYNlwhzoqb+bdpA38T38cqaTDnY5yFzpWkhBnkZWGqkz
        ioy8SUCtr5ncerplUzxiIoA=
X-Google-Smtp-Source: APXvYqxBASmSBziAl7PKRwEoLyPls2LH9/l314Fd8pkEnVKPTAzBofCwPdmeJNVo3SBbmPo3YIht9A==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr201252wmb.142.1574098351306;
        Mon, 18 Nov 2019 09:32:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n1sm24456636wrr.24.2019.11.18.09.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 09:32:29 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:32:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dell-smm-hwmon: Add support for disabling
 automatic BIOS fan control
Message-ID: <20191118173228.gn2y5ssp7v3fcctn@pali>
References: <20191118171148.76373-1-gio@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dntxtsgj3xed2gg4"
Content-Disposition: inline
In-Reply-To: <20191118171148.76373-1-gio@debian.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dntxtsgj3xed2gg4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 18 November 2019 18:11:47 Giovanni Mascellani wrote:
> This patch exports standard hwmon pwmX_enable sysfs attribute for
> enabling or disabling automatic fan control by BIOS. Standard value
> "1" is for disabling automatic BIOS fan control and value "2" for
> enabling.
>=20
> By default BIOS auto mode is enabled by laptop firmware.
>=20
> When BIOS auto mode is enabled, custom fan speed value (set via hwmon
> pwmX sysfs attribute) is overwritten by SMM in few seconds and
> therefore any custom settings are without effect. So this is reason
> why implementing option for disabling BIOS auto mode is needed.
>=20
> So finally this patch allows kernel to set and control fan speed on
> laptops, but it can be dangerous (like setting speed of other fans).
>=20
> The SMM commands to enable or disable automatic fan control are not
> documented and are not the same on all Dell laptops. Therefore a
> whitelist is used to send the correct codes only on laptopts for which
> they are known.
>=20
> This patch was originally developed by Pali Roh=C3=A1r; later Giovanni
> Mascellani implemented the whitelist.
>=20
> Signed-off-by: Giovanni Mascellani <gio@debian.org>
> Co-Developer-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

This patch is fine for me now. I'm not sure if Co-Developer-by: tag is
supported, but you can add:

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 114 ++++++++++++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmo=
n.c
> index 4212d022d253..25d160b36a57 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
>  static uint i8k_fan_max =3D I8K_FAN_HIGH;
>  static bool disallow_fan_type_call;
>  static bool disallow_fan_support;
> +static unsigned int manual_fan;
> +static unsigned int auto_fan;
> =20
>  #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
>  #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
> @@ -300,6 +302,20 @@ static int i8k_get_fan_nominal_speed(int fan, int sp=
eed)
>  	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * i8k_fan_mult;
>  }
> =20
> +/*
> + * Enable or disable automatic BIOS fan control support
> + */
> +static int i8k_enable_fan_auto_mode(bool enable)
> +{
> +	struct smm_regs regs =3D { };
> +
> +	if (disallow_fan_support)
> +		return -EINVAL;
> +
> +	regs.eax =3D enable ? auto_fan : manual_fan;
> +	return i8k_smm(&regs);
> +}
> +
>  /*
>   * Set the fan speed (off, low, high). Returns the new fan status.
>   */
> @@ -726,6 +742,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *de=
v,
>  	return err < 0 ? -EIO : count;
>  }
> =20
> +static ssize_t i8k_hwmon_pwm_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	int err;
> +	bool enable;
> +	unsigned long val;
> +
> +	if (!auto_fan)
> +		return -ENODEV;
> +
> +	err =3D kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	if (val =3D=3D 1)
> +		enable =3D false;
> +	else if (val =3D=3D 2)
> +		enable =3D true;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&i8k_mutex);
> +	err =3D i8k_enable_fan_auto_mode(enable);
> +	mutex_unlock(&i8k_mutex);
> +
> +	return err ? err : count;
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
> @@ -749,6 +794,7 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmon_=
temp_label, 9);
>  static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
>  static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
> +static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
>  static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
>  static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
> @@ -780,12 +826,13 @@ static struct attribute *i8k_attrs[] =3D {
>  	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 20 */
>  	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 21 */
>  	&sensor_dev_attr_pwm1.dev_attr.attr,		/* 22 */
> -	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 23 */
> -	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 24 */
> -	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 25 */
> -	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 26 */
> -	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 27 */
> -	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 28 */
> +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,	/* 23 */
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 24 */
> +	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 25 */
> +	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 26 */
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 27 */
> +	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 28 */
> +	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 29 */
>  	NULL
>  };
> =20
> @@ -828,16 +875,19 @@ static umode_t i8k_is_visible(struct kobject *kobj,=
 struct attribute *attr,
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
>  		return 0;
> =20
> -	if (index >=3D 20 && index <=3D 22 &&
> +	if (index >=3D 20 && index <=3D 23 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
>  		return 0;
> -	if (index >=3D 23 && index <=3D 25 &&
> +	if (index >=3D 24 && index <=3D 26 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
>  		return 0;
> -	if (index >=3D 26 && index <=3D 28 &&
> +	if (index >=3D 27 && index <=3D 29 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
>  		return 0;
> =20
> +	if (index =3D=3D 23 && !auto_fan)
> +		return 0;
> +
>  	return attr->mode;
>  }
> =20
> @@ -1135,12 +1185,48 @@ static struct dmi_system_id i8k_blacklist_fan_sup=
port_dmi_table[] __initdata =3D {
>  	{ }
>  };
> =20
> +struct i8k_fan_control_data {
> +	unsigned int manual_fan;
> +	unsigned int auto_fan;
> +};
> +
> +enum i8k_fan_controls {
> +	I8K_FAN_34A3_35A3,
> +};
> +
> +static const struct i8k_fan_control_data i8k_fan_control_data[] =3D {
> +	[I8K_FAN_34A3_35A3] =3D {
> +		.manual_fan =3D 0x34a3,
> +		.auto_fan =3D 0x35a3,
> +	},
> +};
> +
> +static struct dmi_system_id i8k_whitelist_fan_control[] __initdata =3D {
> +	{
> +		.ident =3D "Dell Precision 5530",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{
> +		.ident =3D "Dell Latitude E6440",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
> +		},
> +		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{ }
> +};
> +
>  /*
>   * Probe for the presence of a supported laptop.
>   */
>  static int __init i8k_probe(void)
>  {
> -	const struct dmi_system_id *id;
> +	const struct dmi_system_id *id, *fan_control;
>  	int fan, ret;
> =20
>  	/*
> @@ -1200,6 +1286,14 @@ static int __init i8k_probe(void)
>  	i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>  	i8k_pwm_mult =3D DIV_ROUND_UP(255, i8k_fan_max);
> =20
> +	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
> +	if (fan_control && fan_control->driver_data) {
> +		const struct i8k_fan_control_data *fan_control_data =3D fan_control->d=
river_data;
> +		manual_fan =3D fan_control_data->manual_fan;
> +		auto_fan =3D fan_control_data->auto_fan;
> +		pr_info("enabling support for setting automatic/manual fan control\n");
> +	}
> +
>  	if (!fan_mult) {
>  		/*
>  		 * Autodetect fan multiplier based on nominal rpm

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--dntxtsgj3xed2gg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdLVkwAKCRCL8Mk9A+RD
UptqAKCDV9GLxi+nzSzmFuka+tuytD4U1gCcDHwaFLNCmeHqC17JGAhujp0PRBE=
=B9yk
-----END PGP SIGNATURE-----

--dntxtsgj3xed2gg4--
