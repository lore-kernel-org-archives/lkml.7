Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD19EC32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A467024653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEKpT/HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgADQ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:26:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36709 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:26:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so5950475pjb.1;
        Sat, 04 Jan 2020 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T9hHZqO9DGpGt7YfJr7H+oNwKR349/WK0Q/IjGEJV1E=;
        b=kEKpT/HZWrsk4vfQUt4lrNpmUPxWUbnmmoJNCfVMQrEobTW13Vmnq6obXprNuUIc2U
         ry0qExBjloV7dnvdA+68iQRPiHi2juF7G7Gk8Pf34GRuP5VT7oB/aYQEKMuaUpmyB4ad
         bgV6+5wA2nyYwduO8fYcmmvgbGrFPXNBY8k7JXUjxdhQrauyVXr7NNuSdyPeFrFkfT9b
         yne6aMQRLdI/75wDMkuhNnRVpX+bsksqleKb+9M9GO7tKpArvVvuB6wKriTsudywQAhi
         1LgZQnrIVjC+6uCCB7oRCd4gduLf3VbA2b6vM4ntAx/zTD8n7QevgUED+feDXMO388es
         aXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9hHZqO9DGpGt7YfJr7H+oNwKR349/WK0Q/IjGEJV1E=;
        b=BJ8mgENFmr2JTHs19+vn0jgILFLq0ls7PAw5zycsiQ+//OsBw0o2hDsG6lJIyKITAi
         6OpdBK1RXaiA9magk1CDhh+qos4v2puGwkidFwfHytBJ8Vbv2Z1JaNAfsqJ9laeOeLnu
         HVMpC0Qsqgazq8A+EOVYkXzbkcarPCo1x/LWTMVGHZbdQIrr/zo0UGkqsA84qbX/J7ZQ
         4lGs6HF+YklAYJTthfu/eCAcPx//QaeLrhHUy2FfdMOODQgHulYc3XsrBfBASUFUFeDD
         PwbkQj3TV/BoCoE4IvigTNu6wju4IIHLRKOaxZ1Pqk6HPps+EQ2nV+2W8ZKb06Hb0BFs
         QpZQ==
X-Gm-Message-State: APjAAAVKAd1OsQiXbytn26an8RZfhb+ffAz0P3sr97B7QRPaeYATscAm
        OHmjYRalyB6bC8iH+CEvqZc=
X-Google-Smtp-Source: APXvYqzTpFd1BuCYDFoQnQyyf6W1kgQYa3tZcoBiZOG6MogzoBJV/UVuRzT2sd33X0gbFZKjSevh3w==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr97603242plp.193.1578155169979;
        Sat, 04 Jan 2020 08:26:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d21sm18365545pjs.25.2020.01.04.08.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jan 2020 08:26:09 -0800 (PST)
Date:   Sat, 4 Jan 2020 08:26:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, bjwyman@gmail.com
Subject: Re: [PATCH 1/3] hwmon: (pmbus/ibm-cffps) Add new manufacturer
 debugfs entries
Message-ID: <20200104162608.GA8155@roeck-us.net>
References: <1576788607-13567-1-git-send-email-eajames@linux.ibm.com>
 <1576788607-13567-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576788607-13567-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:50:05PM -0600, Eddie James wrote:
> Add support for a number of manufacturer-specific registers in the
> debugfs entries, as well as support to read and write the
> PMBUS_ON_OFF_CONFIG register through debugfs.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I assume you know what you are doing, letting the user write anything
into on_off_config. Applied to -next.

Guenter

> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 74 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index d359b76..a564be9 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -20,7 +20,9 @@
>  
>  #define CFFPS_FRU_CMD				0x9A
>  #define CFFPS_PN_CMD				0x9B
> +#define CFFPS_HEADER_CMD			0x9C
>  #define CFFPS_SN_CMD				0x9E
> +#define CFFPS_MAX_POWER_OUT_CMD			0xA7
>  #define CFFPS_CCIN_CMD				0xBD
>  #define CFFPS_FW_CMD				0xFA
>  #define CFFPS1_FW_NUM_BYTES			4
> @@ -57,9 +59,12 @@ enum {
>  	CFFPS_DEBUGFS_INPUT_HISTORY = 0,
>  	CFFPS_DEBUGFS_FRU,
>  	CFFPS_DEBUGFS_PN,
> +	CFFPS_DEBUGFS_HEADER,
>  	CFFPS_DEBUGFS_SN,
> +	CFFPS_DEBUGFS_MAX_POWER_OUT,
>  	CFFPS_DEBUGFS_CCIN,
>  	CFFPS_DEBUGFS_FW,
> +	CFFPS_DEBUGFS_ON_OFF_CONFIG,
>  	CFFPS_DEBUGFS_NUM_ENTRIES
>  };
>  
> @@ -136,15 +141,15 @@ static ssize_t ibm_cffps_read_input_history(struct ibm_cffps *psu,
>  				       psu->input_history.byte_count);
>  }
>  
> -static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
> -				    size_t count, loff_t *ppos)
> +static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
> +				      size_t count, loff_t *ppos)
>  {
>  	u8 cmd;
>  	int i, rc;
>  	int *idxp = file->private_data;
>  	int idx = *idxp;
>  	struct ibm_cffps *psu = to_psu(idxp, idx);
> -	char data[I2C_SMBUS_BLOCK_MAX] = { 0 };
> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>  
>  	pmbus_set_page(psu->client, 0);
>  
> @@ -157,9 +162,20 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  	case CFFPS_DEBUGFS_PN:
>  		cmd = CFFPS_PN_CMD;
>  		break;
> +	case CFFPS_DEBUGFS_HEADER:
> +		cmd = CFFPS_HEADER_CMD;
> +		break;
>  	case CFFPS_DEBUGFS_SN:
>  		cmd = CFFPS_SN_CMD;
>  		break;
> +	case CFFPS_DEBUGFS_MAX_POWER_OUT:
> +		rc = i2c_smbus_read_word_swapped(psu->client,
> +						 CFFPS_MAX_POWER_OUT_CMD);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, I2C_SMBUS_BLOCK_MAX, "%d", rc);
> +		goto done;
>  	case CFFPS_DEBUGFS_CCIN:
>  		rc = i2c_smbus_read_word_swapped(psu->client, CFFPS_CCIN_CMD);
>  		if (rc < 0)
> @@ -199,6 +215,14 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  			return -EOPNOTSUPP;
>  		}
>  		goto done;
> +	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
> +		rc = i2c_smbus_read_byte_data(psu->client,
> +					      PMBUS_ON_OFF_CONFIG);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = snprintf(data, 3, "%02x", rc);
> +		goto done;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -214,9 +238,42 @@ static ssize_t ibm_cffps_debugfs_op(struct file *file, char __user *buf,
>  	return simple_read_from_buffer(buf, count, ppos, data, rc);
>  }
>  
> +static ssize_t ibm_cffps_debugfs_write(struct file *file,
> +				       const char __user *buf, size_t count,
> +				       loff_t *ppos)
> +{
> +	u8 data;
> +	ssize_t rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct ibm_cffps *psu = to_psu(idxp, idx);
> +
> +	switch (idx) {
> +	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
> +		pmbus_set_page(psu->client, 0);
> +
> +		rc = simple_write_to_buffer(&data, 1, ppos, buf, count);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = i2c_smbus_write_byte_data(psu->client,
> +					       PMBUS_ON_OFF_CONFIG, data);
> +		if (rc)
> +			return rc;
> +
> +		rc = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +
>  static const struct file_operations ibm_cffps_fops = {
>  	.llseek = noop_llseek,
> -	.read = ibm_cffps_debugfs_op,
> +	.read = ibm_cffps_debugfs_read,
> +	.write = ibm_cffps_debugfs_write,
>  	.open = simple_open,
>  };
>  
> @@ -486,15 +543,24 @@ static int ibm_cffps_probe(struct i2c_client *client,
>  	debugfs_create_file("part_number", 0444, ibm_cffps_dir,
>  			    &psu->debugfs_entries[CFFPS_DEBUGFS_PN],
>  			    &ibm_cffps_fops);
> +	debugfs_create_file("header", 0444, ibm_cffps_dir,
> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_HEADER],
> +			    &ibm_cffps_fops);
>  	debugfs_create_file("serial_number", 0444, ibm_cffps_dir,
>  			    &psu->debugfs_entries[CFFPS_DEBUGFS_SN],
>  			    &ibm_cffps_fops);
> +	debugfs_create_file("max_power_out", 0444, ibm_cffps_dir,
> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_MAX_POWER_OUT],
> +			    &ibm_cffps_fops);
>  	debugfs_create_file("ccin", 0444, ibm_cffps_dir,
>  			    &psu->debugfs_entries[CFFPS_DEBUGFS_CCIN],
>  			    &ibm_cffps_fops);
>  	debugfs_create_file("fw_version", 0444, ibm_cffps_dir,
>  			    &psu->debugfs_entries[CFFPS_DEBUGFS_FW],
>  			    &ibm_cffps_fops);
> +	debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
> +			    &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
> +			    &ibm_cffps_fops);
>  
>  	return 0;
>  }
