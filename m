Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED810C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE81320709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya3Rtbza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNVjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:39:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:39:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id q17so4607332pgt.9;
        Thu, 14 Nov 2019 13:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSWp50pAAwqlTArwFT6uNMa/JXzGry641Xx9MF15wCU=;
        b=Ya3RtbzajYc6VUawuSXVsOLtMZYE28BtqcakN4+lFX2h3unfjD+6rAdPzX1k3KJUyg
         2rZHo3L5kmdv+hCxpXGW21gOXgMjTPtx0zwF6EnMX9EXTu2WgizHMu/a+amF0Faw6xfG
         5DAMFE/m1AigMN2Pt2vmzDSkmq2QsmI1xloxpkS7dOFJiRRpeoYuorVoYqVsvLgirN2s
         XEIpDl9hLmNLTUEIcrwoa3GCVkPAHum3G1vbBU3txCYIY11A09ZJQByUX9n+o41FK8ek
         28040wcSBrPoNkvO2ebOhH9GNZ8eSeOcisLc3k4f8PJd3DkuYoyVVHN9fUWAKLGGzK3q
         O4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSWp50pAAwqlTArwFT6uNMa/JXzGry641Xx9MF15wCU=;
        b=LKlG3hH//zLHzEFtQGjzX1Os6fysrXPM4ZN/Vj1VTupPGt9Bvh5znlRtdCkFMK0Lz0
         vDd8rKadJEZxTLZpUAy1S27SM4nLfvKStNYDCDZMDFOLIW29msuD8iTIQ5qIDdZxEfKX
         KZq84IgqC1FjGTejLqiZHjz2iPaypSbxaG/zJgSJS0aM8Ccaxzweg7vzzO9riIFsrbZs
         W6UDKVPxdavsuUbuxjzwb0xRWY0ZQ+fwubKGA05vICLMOW6ZYtQqaBNDGuX22MWICGID
         aqS20smDp9lkwMEeo3Pycdtw9er8OLO4A65EqqB3TSPh/FcG/piibqpCmHluSCKKwWl1
         e3Vg==
X-Gm-Message-State: APjAAAUeWhKoJjJlx5LZ6xW6xiJ0kM8sfh6dS3RlEbyH/q1snLHQyhiA
        T04WiacLpQJzZJEDpRjXXJzGLJug
X-Google-Smtp-Source: APXvYqzAM13V2x9IXGrvGMU2JDkduZ2zY7cJJmi0AaZ8DcWe3OsU9SO8D3zFas4wGrq/NKGcmzgcJw==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr15434664pjh.60.1573767543317;
        Thu, 14 Nov 2019 13:39:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7sm9319869pfa.150.2019.11.14.13.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 13:39:02 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:39:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on
 SET_FAN
Message-ID: <20191114213901.GA28532@roeck-us.net>
References: <20191114211408.22123-1-gio@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114211408.22123-1-gio@debian.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:14:08PM +0100, Giovanni Mascellani wrote:
> On some Dell laptops the BIOS directly controls fan speed, ignoring
> SET_FAN commands. Also, the BIOS controller often happens to be buggy,
> failing to increase fan speed when the CPU is under heavy load and
> setting fan at full speed even when the CPU is idle and relatively
> cool.
> 
> Disable BIOS fan control on such laptops as soon as a SET_FAN command
> is issued, and re-enable it at module unloading, so that a userspace
> controller like i8kmon can take control of the fan.
> 
> There is a missing feature: interaction with PM; I think that when
> suspending on RAM the fans should be stopped (this BIOS doesn't always
> do this automatically, neither when fan control is enabled nor when it
> is disabled); when recovering from hibernation to disk, also, the
> command to disable BIOS fan control should be issued again, because
> the computer will have had a power cycle in the meantime.
> 
> I don't know how to implement these two actions; can someone suggest a
> way? Also, I would be happy to know from more experienced people if
> these actions are sensible.
> 

I think this is too drastic: Not everyone wants to use this driver for
fan control, and even automatic switching to manual mode on write
operations may be unexpected.

I can see two possibilities: Either add a pwm1_enable attribute to
be able to set manual/automatic fan control, or add a module parameter
to enable manual fan speed control on affected systems.

As for PM support, this would have to be implemented using the standard
PM functions.

Guenter

> Signed-off-by: Giovanni Mascellani <gio@debian.org>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 64 ++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 4212d022d253..6d72e207076f 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -32,6 +32,12 @@
>  
>  #include <linux/i8k.h>
>  
> +/*
> + * The code for enabling and disabling BIOS fan control were found by
> + * trial and error with the program at
> + *  https://github.com/clopez/dellfan.
> + */
> +
>  #define I8K_SMM_FN_STATUS	0x0025
>  #define I8K_SMM_POWER_STATUS	0x0069
>  #define I8K_SMM_SET_FAN		0x01a3
> @@ -43,6 +49,8 @@
>  #define I8K_SMM_GET_TEMP_TYPE	0x11a3
>  #define I8K_SMM_GET_DELL_SIG1	0xfea3
>  #define I8K_SMM_GET_DELL_SIG2	0xffa3
> +#define I8K_SMM_DISABLE_BIOS	0x30a3
> +#define I8K_SMM_ENABLE_BIOS	0x31a3
>  
>  #define I8K_FAN_MULT		30
>  #define I8K_FAN_MAX_RPM		30000
> @@ -68,6 +76,8 @@ static uint i8k_pwm_mult;
>  static uint i8k_fan_max = I8K_FAN_HIGH;
>  static bool disallow_fan_type_call;
>  static bool disallow_fan_support;
> +static bool disable_bios;
> +static bool bios_disabled;
>  
>  #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
>  #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
> @@ -419,6 +429,26 @@ static int i8k_get_power_status(void)
>  	return (regs.eax & 0xff) == I8K_POWER_AC ? I8K_AC : I8K_BATTERY;
>  }
>  
> +/*
> + * Disable BIOS fan control.
> + */
> +static int i8k_disable_bios(void)
> +{
> +	struct smm_regs regs = { .eax = I8K_SMM_DISABLE_BIOS, .ebx = 0 };
> +
> +	return i8k_smm(&regs) ? : regs.eax & 0xff;
> +}
> +
> +/*
> + * Enable BIOS fan control.
> + */
> +static int i8k_enable_bios(void)
> +{
> +	struct smm_regs regs = { .eax = I8K_SMM_ENABLE_BIOS, .ebx = 0 };
> +
> +	return i8k_smm(&regs) ? : regs.eax & 0xff;
> +}
> +
>  /*
>   * Procfs interface
>   */
> @@ -488,6 +518,13 @@ i8k_ioctl_unlocked(struct file *fp, unsigned int cmd, unsigned long arg)
>  		if (copy_from_user(&speed, argp + 1, sizeof(int)))
>  			return -EFAULT;
>  
> +                if (disable_bios && !bios_disabled) {
> +			val = i8k_disable_bios();
> +			if (val < 0)
> +				return val;
> +			bios_disabled = true;
> +                }
> +
>  		val = i8k_set_fan(val, speed);
>  		break;
>  
> @@ -1135,6 +1172,22 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
>  	{ }
>  };
>  
> +/*
> + * On some machines the BIOS disregards all SET_FAN commands unless it
> + * is explicitly disabled.
> + * See bug: https://bugzilla.kernel.org/show_bug.cgi?id=200949
> + */
> +static struct dmi_system_id i8k_disable_bios_dmi_table[] __initdata = {
> +	{
> +		.ident = "Dell Precision 5530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +	},
> +	{ }
> +};
> +
>  /*
>   * Probe for the presence of a supported laptop.
>   */
> @@ -1169,6 +1222,11 @@ static int __init i8k_probe(void)
>  			disallow_fan_type_call = true;
>  	}
>  
> +	if (dmi_check_system(i8k_disable_bios_dmi_table)) {
> +		pr_warn("broken Dell BIOS detected, will disable BIOS fan control\n");

The above is your interpretation: Since there is a command to enable/disable
BIOS fan control, we can not just claim that it is broken because we don't like
how it works.

> +		disable_bios = true;
> +	}
> +
>  	strlcpy(bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
>  		sizeof(bios_version));
>  	strlcpy(bios_machineid, i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
> @@ -1241,6 +1299,12 @@ static void __exit i8k_exit(void)
>  {
>  	hwmon_device_unregister(i8k_hwmon_dev);
>  	i8k_exit_procfs();
> +
> +	if (bios_disabled) {
> +		pr_warn("re-enabling BIOS fan control\n");

I don't see the point of this warning.

> +		if (i8k_enable_bios())
> +			pr_warn("could not re-enable BIOS fan control\n");
> +	}
>  }
>  
>  module_init(i8k_init);
> -- 
> 2.24.0
> 
