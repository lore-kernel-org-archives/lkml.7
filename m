Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09440C3A5A8
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0C622D6D
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWRgtwud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfHaP2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:28:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35981 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHaP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:28:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so818046pfr.3;
        Sat, 31 Aug 2019 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzIDZ/Y3p8mE/YfP5L16dMWmiE8dYK2diKs+M4D4Cgc=;
        b=VWRgtwud29/jLxkWyt35yqG74YJ+cyqUHSWJ++dKjBJ96NRE15Gr7MU207xXof2hXl
         ZvYZ+qN3FJ+vmMWGGrJLOMCAHCynfJ0wV7wlk93DAk/nu5RaZUUs7p9mMbrtLLNm4slA
         2ZpF3n7qVqbcaBhD4MXwWax7PuXtIjdrGV6UKGcH3t48O0rmw1YMVW0qRUgOFcKKvhao
         helFewJdV/zHLrC6a+tFh4/O2hwXJe7VVgYsBEzvtl6dVCuFHHE3FD5JaqWBwGaBKEVr
         U+qmh9GVlmzdRFC5U5brqFFsSbXSUPFidcSVZlqEwbAme4m7x0LnVpOzLlEiOGcz5m5E
         yPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzIDZ/Y3p8mE/YfP5L16dMWmiE8dYK2diKs+M4D4Cgc=;
        b=UD2At86VSHO5uONf8zqVzx9X0NGjc5bac2dG8nR0zeeejBWp2h5HTPKS0SpWMSaAqq
         4wPWE8LsTPRNnvNLzocWYTiDSl0oGvaOv4I5EQWu4yJ5S6lSjTfM8Qr6gyepcozQLuM4
         d6DXctuvQhdgYFOLL9i6gIr0Em9HIry4xuQeA9XsqCcyvb15+/qo7AGSBLHxT5nfN+5n
         W/395d4yaCHvIPgiKM9QmCLdWVcTVOTsuCjPmBeK1IR+dhE6H+ZZrBbquhFIbNIbKFsJ
         XWgaEIk2rbRpu2GvL7WPtsDoYatM7VbfIEmsEnVzwxPfbtXW8WtE8qq1aMc/eGuwm+1T
         1drA==
X-Gm-Message-State: APjAAAVwQDcb2gCcn/O2PGP8UzwqZztD7LcRU3RPxo/fxEzYWm9RkzKQ
        EkYSqPqKCRChhpBwO4e/Qe0=
X-Google-Smtp-Source: APXvYqyAedlEYt09FSt6C+s32rSCfqEidrAj77ncA9rZ6m+ZCPnRSVQ2/hg/rkmSv4DjTtbdzRdk7Q==
X-Received: by 2002:a17:90a:1916:: with SMTP id 22mr4476855pjg.62.1567265295363;
        Sat, 31 Aug 2019 08:28:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1sm7212452pgh.61.2019.08.31.08.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 08:28:14 -0700 (PDT)
Date:   Sat, 31 Aug 2019 08:28:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, mark.rutland@arm.com,
        robh+dt@kernel.org, jdelvare@suse.com
Subject: Re: [PATCH v2 3/3] pmbus: ibm-cffps: Add support for version 2 of
 the PSU
Message-ID: <20190831152814.GA9950@roeck-us.net>
References: <1567192263-15065-1-git-send-email-eajames@linux.ibm.com>
 <1567192263-15065-4-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567192263-15065-4-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:11:03PM -0500, Eddie James wrote:
> Version 2 of the PSU supports a second page of data and changes the
> format of the FW version. Use the devicetree binding to differentiate
> between the version the driver should use.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes since v1:
>  - use an enum for the version instead of integers 1, 2, etc
> 
>  drivers/hwmon/pmbus/ibm-cffps.c | 110 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 88 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index ee2ee9e..d44745e 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -12,6 +12,7 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of_device.h>
>  #include <linux/pmbus.h>
>  
>  #include "pmbus.h"
> @@ -20,8 +21,9 @@
>  #define CFFPS_PN_CMD				0x9B
>  #define CFFPS_SN_CMD				0x9E
>  #define CFFPS_CCIN_CMD				0xBD
> -#define CFFPS_FW_CMD_START			0xFA
> -#define CFFPS_FW_NUM_BYTES			4
> +#define CFFPS_FW_CMD				0xFA
> +#define CFFPS1_FW_NUM_BYTES			4
> +#define CFFPS2_FW_NUM_WORDS			3
>  #define CFFPS_SYS_CONFIG_CMD			0xDA
>  
>  #define CFFPS_INPUT_HISTORY_CMD			0xD6
> @@ -52,6 +54,8 @@ enum {
>  	CFFPS_DEBUGFS_NUM_ENTRIES
>  };
>  
> +enum versions { cffps1, cffps2 };
> +
>  struct ibm_cffps_input_history {
>  	struct mutex update_lock;
>  	unsigned long last_update;
> @@ -61,6 +65,7 @@ struct ibm_cffps_input_history {
>  };
>  
>  struct ibm_cffps {
> +	enum versions version;
>  	struct i2c_client *client;
>  
>  	struct ibm_cffps_input_history input_history;
> @@ -132,6 +137,8 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  	struct ibm_cffps *psu = to_psu(idxp, idx);
>  	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
>  
> +	pmbus_set_page(psu->client, 0);
> +
>  	switch (idx) {
>  	case CFFPS_DEBUGFS_INPUT_HISTORY:
>  		return ibm_cffps_read_input_history(psu, buf, count, ppos);
> @@ -152,16 +159,36 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  		rc = snprintf(data, 5, "%04X", rc);
>  		goto done;
>  	case CFFPS_DEBUGFS_FW:
> -		for (i = 0; i < CFFPS_FW_NUM_BYTES; ++i) {
> -			rc = i2c_smbus_read_byte_data(psu->client,
> -						      CFFPS_FW_CMD_START + i);
> -			if (rc < 0)
> -				return rc;
> +		switch (psu->version) {
> +		case cffps1:
> +			for (i = 0; i < CFFPS1_FW_NUM_BYTES; ++i) {
> +				rc = i2c_smbus_read_byte_data(psu->client,
> +							      CFFPS_FW_CMD +
> +								i);
> +				if (rc < 0)
> +					return rc;
> +
> +				snprintf(&data[i * 2], 3, "%02X", rc);
> +			}
>  
> -			snprintf(&data[i * 2], 3, "%02X", rc);
> -		}
> +			rc = i * 2;
> +			break;
> +		case cffps2:
> +			for (i = 0; i < CFFPS2_FW_NUM_WORDS; ++i) {
> +				rc = i2c_smbus_read_word_data(psu->client,
> +							      CFFPS_FW_CMD +
> +								i);
> +				if (rc < 0)
> +					return rc;
> +
> +				snprintf(&data[i * 4], 5, "%04X", rc);
> +			}
>  
> -		rc = i * 2;
> +			rc = i * 4;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
>  		goto done;
>  	default:
>  		return -EINVAL;
> @@ -279,6 +306,8 @@ static void ibm_cffps_led_brightness_set(struct led_classdev *led_cdev,
>  			psu->led_state = CFFPS_LED_ON;
>  	}
>  
> +	pmbus_set_page(psu->client, 0);
> +
>  	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
>  				       psu->led_state);
>  	if (rc < 0)
> @@ -299,6 +328,8 @@ static int ibm_cffps_led_blink_set(struct led_classdev *led_cdev,
>  	if (led_cdev->brightness == LED_OFF)
>  		return 0;
>  
> +	pmbus_set_page(psu->client, 0);
> +
>  	rc = i2c_smbus_write_byte_data(psu->client, CFFPS_SYS_CONFIG_CMD,
>  				       CFFPS_LED_BLINK);
>  	if (rc < 0)
> @@ -328,15 +359,32 @@ static void ibm_cffps_create_led_class(struct ibm_cffps *psu)
>  		dev_warn(dev, "failed to register led class: %d\n", rc);
>  }
>  
> -static struct pmbus_driver_info ibm_cffps_info = {
> -	.pages = 1,
> -	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> -		PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
> -		PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_VOUT |
> -		PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT |
> -		PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_FAN12,
> -	.read_byte_data = ibm_cffps_read_byte_data,
> -	.read_word_data = ibm_cffps_read_word_data,
> +static struct pmbus_driver_info ibm_cffps_info[] = {
> +	[cffps1] = {
> +		.pages = 1,
> +		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
> +			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_FAN12,
> +		.read_byte_data = ibm_cffps_read_byte_data,
> +		.read_word_data = ibm_cffps_read_word_data,
> +	},
> +	[cffps2] = {
> +		.pages = 2,
> +		.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_PIN | PMBUS_HAVE_FAN12 | PMBUS_HAVE_TEMP |
> +			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +			PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP |
> +			PMBUS_HAVE_STATUS_FAN12,
> +		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +			PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT,
> +		.read_byte_data = ibm_cffps_read_byte_data,
> +		.read_word_data = ibm_cffps_read_word_data,
> +	},
>  };
>  
>  static struct pmbus_platform_data ibm_cffps_pdata = {
> @@ -347,12 +395,21 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
>  	int i, rc;
> +	enum versions vs;
>  	struct dentry *debugfs;
>  	struct dentry *ibm_cffps_dir;
>  	struct ibm_cffps *psu;
> +	const void *md = of_device_get_match_data(&client->dev);
> +
> +	if (md)
> +		vs = (enum versions)md;
> +	else if (id)
> +		vs = (enum versions)id->driver_data;
> +	else
> +		vs = cffps1;
>  
>  	client->dev.platform_data = &ibm_cffps_pdata;
> -	rc = pmbus_do_probe(client, id, &ibm_cffps_info);
> +	rc = pmbus_do_probe(client, id, &ibm_cffps_info[vs]);
>  	if (rc)
>  		return rc;
>  
> @@ -364,6 +421,7 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  	if (!psu)
>  		return 0;
>  
> +	psu->version = vs;
>  	psu->client = client;
>  	mutex_init(&psu->input_history.update_lock);
>  	psu->input_history.last_update = jiffies - HZ;
> @@ -405,13 +463,21 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  }
>  
>  static const struct i2c_device_id ibm_cffps_id[] = {
> -	{ "ibm_cffps1", 1 },
> +	{ "ibm_cffps1", cffps1 },
> +	{ "ibm_cffps2", cffps2 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ibm_cffps_id);
>  
>  static const struct of_device_id ibm_cffps_of_match[] = {
> -	{ .compatible = "ibm,cffps1" },
> +	{
> +		.compatible = "ibm,cffps1",
> +		.data = (void *)cffps1
> +	},
> +	{
> +		.compatible = "ibm,cffps2",
> +		.data = (void *)cffps2
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ibm_cffps_of_match);
