Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B512C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4455B206E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7rXbX8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKPO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 09:58:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33787 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKPO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 09:58:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so14146312wrr.0;
        Sat, 16 Nov 2019 06:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h0udf82brVZ5dKEPIIucnAv8UsZHUCyZwxGJqAYbiGE=;
        b=N7rXbX8v5lPpBEeqHQQtYkHawDhG/oKoSPYrYWomCh2jbMnFHpUUNJ+/+eDuLzhxgY
         tzRiTofVplp/XpYr+8usysEH70gCDudTwGZd7n7rLk8sgpKyXeIUuRJSl3Q1OTa8Foii
         z1so7KsrK5bRFqagyoNXRwIOlCvQUIAcE043jhLZ/ZB9U01bKDneEG3p3VzpecmT+gUz
         vNuyzSA15tPY9CM24GNP3CkiPI9P6E/0ZNLbGK8Dwci5LjjpBX9TQ3iRR0fOCiURkVbZ
         8+3iMFxTIWkEzknrQO5Pr12LLbO4vKecebZiui2Vn5QKYSD/nS9YYCpGOH+vW+A1oslT
         dbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h0udf82brVZ5dKEPIIucnAv8UsZHUCyZwxGJqAYbiGE=;
        b=Fbi4wovyMlh4A6SL1QoSk9xxN3qwVfXkgya76HatTIcQ+bk3LVJmNNuWD9oqYZeaDD
         ZcizVlJHsDgPekxv7oToP/z1oksVXyNtUJl4x5tWtpxrkBoORPdGZ501aiHm/9hjXXN2
         wEoSKZSmEGCBqLoWzg7pqzL3InhsTPzpOGqbbyLhDnjR7C2uNjzcccuUBlzpE3PoSmz5
         Yrnz7nBj9xrMe00JOhZs+AkCB46jDgWuc8/cLgH3H9e6lm7Isp4Umx7W1U7ampNUa+/C
         tMcDTjh4EY7eisheyRyjb4uw8C8ByfhbN4xCu9iyg/UBCIM1EplIOMXxO5qq7Mux9DLr
         sLWA==
X-Gm-Message-State: APjAAAWsU4xceVQlDsdWH3dTOQXaft2ie1DoNPwhc1DAX+8y5wKJ5D2Y
        9s97DuAYAdvctrDHXSl04iQ=
X-Google-Smtp-Source: APXvYqxKk3yex7UjQvXjKl/VTudiQGHV1vyw7gk8womX759G80OpgOzAiUoACkyQ6vRgyOx1S8o6DQ==
X-Received: by 2002:adf:f084:: with SMTP id n4mr13923157wro.369.1573916327382;
        Sat, 16 Nov 2019 06:58:47 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x205sm15649856wmb.5.2019.11.16.06.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Nov 2019 06:58:46 -0800 (PST)
Date:   Sat, 16 Nov 2019 15:58:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dell-smm-hwmon: Add support for disabling automatic
 BIOS fan control
Message-ID: <20191116145845.xmhki3ckza26eoln@pali>
References: <20191116140649.114592-1-gio@debian.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yzzegtsg3gayqnni"
Content-Disposition: inline
In-Reply-To: <20191116140649.114592-1-gio@debian.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzzegtsg3gayqnni
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 16 November 2019 15:06:49 Giovanni Mascellani wrote:
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

Hello! Patch looks good, see small suggestions below. The only important
change for this patch is to hide those new pwmX_enable entries on
unsupported machines.

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 111 ++++++++++++++++++++++++++++++---
>  1 file changed, 101 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmo=
n.c
> index 4212d022d253..67b8c0adede8 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
>  static uint i8k_fan_max =3D I8K_FAN_HIGH;
>  static bool disallow_fan_type_call;
>  static bool disallow_fan_support;
> +static unsigned int smm_manual_fan;
> +static unsigned int smm_auto_fan;
> =20
>  #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
>  #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
> @@ -300,6 +302,17 @@ static int i8k_get_fan_nominal_speed(int fan, int sp=
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

For safely reasons I would suggest to add:

	if (disallow_fan_support)
		return -EINVAL;

> +	regs.eax =3D enable ? smm_auto_fan : smm_manual_fan;
> +	return i8k_smm(&regs);
> +}
> +
>  /*
>   * Set the fan speed (off, low, high). Returns the new fan status.
>   */
> @@ -726,6 +739,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *de=
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
> +	if (!smm_auto_fan)
> +		return -ENODEV;
> +
> +	err =3D kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +

=3D=3D=3D=3D

> +	if (val =3D=3D 0)
> +		return -EINVAL;
> +	if (val > 2)
> +		return -EINVAL;
> +
> +	enable =3D (val !=3D 1);

=3D=3D=3D=3D

Just small suggestion: I would write it more-opencoded to immediately
see what values are valid and what are they meaning. It look me quite
more time to check that above logic is correct (according to hwmon
documentation).

	if (val =3D=3D 1)
		enable =3D false;
	else if (val =3D=3D 2)
		enable =3D true;
	else
		return -EINVAL;

or via switch:

	switch (val) {
	case 1:
		enable =3D false;
		break;
	case 2:
		enable =3D true;
		break;
	default:
		return -EINVAL;
	}

> +
> +	mutex_lock(&i8k_mutex);
> +	err =3D i8k_enable_fan_auto_mode(enable);
> +	mutex_unlock(&i8k_mutex);
> +
> +	return err ? -EIO : count;
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
> @@ -749,12 +791,15 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmo=
n_temp_label, 9);
>  static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
>  static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
> +static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
>  static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
>  static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
> +static SENSOR_DEVICE_ATTR_WO(pwm2_enable, i8k_hwmon_pwm_enable, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan3_input, i8k_hwmon_fan, 2);
>  static SENSOR_DEVICE_ATTR_RO(fan3_label, i8k_hwmon_fan_label, 2);
>  static SENSOR_DEVICE_ATTR_RW(pwm3, i8k_hwmon_pwm, 2);
> +static SENSOR_DEVICE_ATTR_WO(pwm3_enable, i8k_hwmon_pwm_enable, 0);
> =20
>  static struct attribute *i8k_attrs[] =3D {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,	/* 0 */
> @@ -780,12 +825,15 @@ static struct attribute *i8k_attrs[] =3D {
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
> +	&sensor_dev_attr_pwm2_enable.dev_attr.attr,	/* 27 */
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 28 */
> +	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 29 */
> +	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 30 */
> +	&sensor_dev_attr_pwm3_enable.dev_attr.attr,	/* 31 */
>  	NULL
>  };
> =20
> @@ -828,13 +876,13 @@ static umode_t i8k_is_visible(struct kobject *kobj,=
 struct attribute *attr,
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
>  		return 0;
> =20
> -	if (index >=3D 20 && index <=3D 22 &&
> +	if (index >=3D 20 && index <=3D 23 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
>  		return 0;
> -	if (index >=3D 23 && index <=3D 25 &&
> +	if (index >=3D 24 && index <=3D 27 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
>  		return 0;
> -	if (index >=3D 26 && index <=3D 28 &&
> +	if (index >=3D 28 && index <=3D 31 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
>  		return 0;


Indexes 23, 27 and 31 should not be visible when "smm_auto_fan" is not
available. Please add check for this.

> =20
> @@ -1135,12 +1183,48 @@ static struct dmi_system_id i8k_blacklist_fan_sup=
port_dmi_table[] __initdata =3D {
>  	{ }
>  };
> =20
> +struct i8k_manual_fan_data {
> +	unsigned int smm_manual_fan;
> +	unsigned int smm_auto_fan;
> +};

Just cosmetic suggestion: As this structure contains data for both
manual and automatic mode I would not use "manual" in name. But e.g.
something like "i8k_bios_fan_control_data"...

> +
> +enum i8k_manual_fans {
> +	I8K_FAN_34A3_35A3,
> +};
> +
> +static const struct i8k_manual_fan_data i8k_manual_fan_data[] =3D {
> +	[I8K_FAN_34A3_35A3] =3D {
> +		.smm_manual_fan =3D 0x34a3,
> +		.smm_auto_fan =3D 0x35a3,
> +	},
> +};
> +
> +static struct dmi_system_id i8k_whitelist_manual_fan[] __initdata =3D {
> +	{
> +		.ident =3D "Dell Precision 5530",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +		.driver_data =3D (void *)&i8k_manual_fan_data[I8K_FAN_34A3_35A3],
> +	},
> +	{
> +		.ident =3D "Dell Latitude E6440",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
> +		},
> +		.driver_data =3D (void *)&i8k_manual_fan_data[I8K_FAN_34A3_35A3],
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
> +	const struct dmi_system_id *id, *manual_fan;
>  	int fan, ret;
> =20
>  	/*
> @@ -1200,6 +1284,13 @@ static int __init i8k_probe(void)
>  	i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>  	i8k_pwm_mult =3D DIV_ROUND_UP(255, i8k_fan_max);
> =20
> +	manual_fan =3D dmi_first_match(i8k_whitelist_manual_fan);
> +	if (manual_fan && manual_fan->driver_data) {
> +		const struct i8k_manual_fan_data *manual_fan_data =3D manual_fan->driv=
er_data;
> +		smm_manual_fan =3D manual_fan_data->smm_manual_fan;
> +		smm_auto_fan =3D manual_fan_data->smm_auto_fan;

As this feature is experimental, I would suggest to add some pr_info
message that experimental BIOS fan control support is exported via hwmon
interface. It may happen that it would not work for some people and for
debugging purposes it would be easier to spot problem if dmesg provides
such message.

> +	}
> +
>  	if (!fan_mult) {
>  		/*
>  		 * Autodetect fan multiplier based on nominal rpm

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yzzegtsg3gayqnni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdAOowAKCRCL8Mk9A+RD
Un9EAJ9rvEWpaQ+tOj2mE6bPYQzHL7GAiQCgqgrZQmRf4HmWVrfW0o65ga55Uzc=
=ErRr
-----END PGP SIGNATURE-----

--yzzegtsg3gayqnni--
