Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BADFA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC012089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYZdLxZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394689AbfJQNgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:36:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45358 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfJQNgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:36:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so1666577pfb.12;
        Thu, 17 Oct 2019 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zg6xsxX43NwJNaUijMAvvFCSXNnBfu7Z7VVGMLNPK+4=;
        b=FYZdLxZXYJToNk6FPREOKcfO5mvfjsK8AXtspR9yeoa8l7yBfhCBK5BxHyLJOdt/aq
         Kik2XjOaZNGTwzgRNqrwscHTyKJdJg4MxYdatM/dbsa4iausUW5KjlbspimyYWgKXR9c
         n+YNQ0Q4QG4fvqex+oLWJl8ggw6uB3NaebgoFmc0D27oJ2+VcycayyW8hiuquO1Ptp/N
         8w+EO6NhycuFEaZML34utdhRdq4HbuoAta1bBerjjV8ZWdGKMxPDAttH8nqNZDuk02yR
         WUXUhGr+VZy/nFExr+XAAt4eZUOQh16M9zatEDHzAp4tQJsSMejL0t+mqXagwrwN412B
         j8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zg6xsxX43NwJNaUijMAvvFCSXNnBfu7Z7VVGMLNPK+4=;
        b=PuCuthM4jlp99cAYUXYenl3ivrR2LDAmheKJ+Wc8CCM42Qi4OVv56qERb4SxfF1kls
         Buwdq5JMhq703BGcq8cuB39l2s6Xh7i1XLIjUAYmw4IjEHeWoPTX7N2tKn6tvaKHXPnj
         zQ66iIZreK1OSmg53PyvCgaBgL0O/UHOcrVdHsNx2k80bJmvdFmpHzOYhbxIu9dcxBQy
         vC70LElBG6Y96dqUcOTgHz11u2NPfQ+op3I2VuGNxXtobi2sypNnvlITSpDOKZQqo+Sl
         UG5KwAGK9i7qBTQ03d+Pln2mWVnUktJjXtHekVcodqNAjCQ9BQiSarWeM09D3PzsBbUm
         V1nQ==
X-Gm-Message-State: APjAAAXmPB+iG80Pqbd3mH/CVK92nY5t37eq31vw8UZWGXLiHjKbpuja
        us8U/6RAhSrdCNoWsPp2aT0=
X-Google-Smtp-Source: APXvYqza6q/866iFO8Bg+FPbnr8o3johImxxI0Kt4re1cXDCvUQe7PZ49pscgX+90tZ5h2oqo1RYeg==
X-Received: by 2002:a63:fb15:: with SMTP id o21mr4135935pgh.193.1571319370870;
        Thu, 17 Oct 2019 06:36:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ce16sm2894133pjb.29.2019.10.17.06.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 06:36:10 -0700 (PDT)
Date:   Thu, 17 Oct 2019 06:36:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Add version detection
 capability
Message-ID: <20191017133609.GA23473@roeck-us.net>
References: <1570648262-25383-1-git-send-email-eajames@linux.ibm.com>
 <1570648262-25383-3-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570648262-25383-3-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:11:02PM -0500, Eddie James wrote:
> Some systems may plug in either version 1 or version 2 of the IBM common
> form factor power supply. Add a version-less compatibility string that
> tells the driver to try and detect which version of the power supply is
> connected.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index d44745e..d61547e 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -3,6 +3,7 @@
>   * Copyright 2017 IBM Corp.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> @@ -29,6 +30,10 @@
>  #define CFFPS_INPUT_HISTORY_CMD			0xD6
>  #define CFFPS_INPUT_HISTORY_SIZE		100
>  
> +#define CFFPS_CCIN_VERSION			GENMASK(15, 8)
> +#define CFFPS_CCIN_VERSION_1			 0x2b
> +#define CFFPS_CCIN_VERSION_2			 0x2e
> +
>  /* STATUS_MFR_SPECIFIC bits */
>  #define CFFPS_MFR_FAN_FAULT			BIT(0)
>  #define CFFPS_MFR_THERMAL_FAULT			BIT(1)
> @@ -54,7 +59,7 @@ enum {
>  	CFFPS_DEBUGFS_NUM_ENTRIES
>  };
>  
> -enum versions { cffps1, cffps2 };
> +enum versions { cffps1, cffps2, cffps_unknown };
>  
>  struct ibm_cffps_input_history {
>  	struct mutex update_lock;
> @@ -395,7 +400,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
>  	int i, rc;
> -	enum versions vs;
> +	enum versions vs = cffps_unknown;
>  	struct dentry *debugfs;
>  	struct dentry *ibm_cffps_dir;
>  	struct ibm_cffps *psu;
> @@ -405,8 +410,27 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  		vs = (enum versions)md;
>  	else if (id)
>  		vs = (enum versions)id->driver_data;
> -	else
> -		vs = cffps1;
> +
> +	if (vs == cffps_unknown) {
> +		u16 ccin_version = CFFPS_CCIN_VERSION_1;
> +		int ccin = i2c_smbus_read_word_swapped(client, CFFPS_CCIN_CMD);
> +
> +		if (ccin > 0)
> +			ccin_version = FIELD_GET(CFFPS_CCIN_VERSION, ccin);
> +
> +		switch (ccin_version) {
> +		default:
> +		case CFFPS_CCIN_VERSION_1:
> +			vs = cffps1;
> +			break;
> +		case CFFPS_CCIN_VERSION_2:
> +			vs = cffps2;
> +			break;
> +		}
> +
> +		/* Set the client name to include the version number. */
> +		snprintf(client->name, I2C_NAME_SIZE, "cffps%d", vs + 1);
> +	}
>  
>  	client->dev.platform_data = &ibm_cffps_pdata;
>  	rc = pmbus_do_probe(client, id, &ibm_cffps_info[vs]);
> @@ -465,6 +489,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  static const struct i2c_device_id ibm_cffps_id[] = {
>  	{ "ibm_cffps1", cffps1 },
>  	{ "ibm_cffps2", cffps2 },
> +	{ "ibm_cffps", cffps_unknown },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
> @@ -478,6 +503,10 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  		.compatible = "ibm,cffps2",
>  		.data = (void *)cffps2
>  	},
> +	{
> +		.compatible = "ibm,cffps",
> +		.data = (void *)cffps_unknown
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ibm_cffps_of_match);
