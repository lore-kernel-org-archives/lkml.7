Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4ABC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EDB20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R41Gv9bZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfFFQdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:33:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36459 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfFFQdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:33:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so1667062pgb.3;
        Thu, 06 Jun 2019 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqdbmB1dnJKNCDs65kjh4SPmSv2ZQrq68dZ7BpdF/vU=;
        b=R41Gv9bZ88zH69TMWSwO6pEEIr4xdB0Gbkp/5JpcZozK56B0aMTCXzOJNnQuM+4bdO
         4ABlsOWJxqfdZET7RkngDLizWiyaTR7J7YjPUV/X0kOq0PcxlLT252p3uU/xNSZQ2QeM
         HGs4S8UrKCOIcdmtqSMTaJHlIqqQPIWIkITzxHo63I4tynyGu3x5JzrylpTA1HDyEaO1
         EVWJD2EH0QDjhsPqOZrjulzzdcIA6A/mMGyxNOOoSp5sRUkBjx3dB6CJ0K5and/t3gcZ
         Rh9sv+QfMekCm+rVfjAsBWxVCulW3mU9LrQhVe29sgMVV5JopnZ/GnDrDOIgh19Gr/dp
         eX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqdbmB1dnJKNCDs65kjh4SPmSv2ZQrq68dZ7BpdF/vU=;
        b=O2ktVJKpKyryzEZN+RvbNFpP0q4mA8lSZbnlI9xtAOqAibzU58PHMvtBUVJIhmZhKr
         6UPSFqdEd0QMKzPwc4+QRJbhnomXOLI+luNjlRZ0HkhlzXVNEXdggIRMP7Pyv4BBaKb0
         T0gPXJCiDRcZNLcgpHjCl6XGklN0nar4kS0QR7/YeiFLxPto2yIYL9wmZ3Z/jt/jWen/
         y7CnaKlSFgJkTtnykuheeRd/gDHnCsFlJAGDHxPBXI/fxwWT5bMSJoIPy/O/a3WJhCv+
         xFZ/rmIDbNyjB/xdo8fA+F5CDrHYxgkSA0scM5exkvuIAsYbHirrqTcfA+9AevnrMG3O
         WQUw==
X-Gm-Message-State: APjAAAV/qe4DDDQoub05ecALanUEs2FyUSRMHbQStmbDZ+0h4o0LG2rc
        fx77E6xj8Zx0TBbZSUk4T3qHvq3L
X-Google-Smtp-Source: APXvYqwDov8LVCDSSisaES0FKrleZb0l0NQfmPduue9Xl9iMm6Ig4RK9igDn+svdZsMk/Sc0WZqKYA==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr763313pjh.116.1559838791160;
        Thu, 06 Jun 2019 09:33:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n66sm4567695pfn.52.2019.06.06.09.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 09:33:09 -0700 (PDT)
Date:   Thu, 6 Jun 2019 09:33:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] drivers: hwmon: i5k_amb: simplify probing / device
 identification
Message-ID: <20190606163308.GA29829@roeck-us.net>
References: <1559833233-25723-1-git-send-email-info@metux.net>
 <1559833233-25723-2-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559833233-25723-2-git-send-email-info@metux.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 05:00:33PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Simpilify the probing by putting all chip-specific data directly
> into the pci match table, removing the redundant chipset_ids table.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---

You don't need the introductory e-mail for a single patch.
Just add the extra comments here.

>  drivers/hwmon/i5k_amb.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> index b09c39a..f06c40f 100644
> --- a/drivers/hwmon/i5k_amb.c
> +++ b/drivers/hwmon/i5k_amb.c
> @@ -414,15 +414,15 @@ static int i5k_amb_add(void)
>  }
>  
>  static int i5k_find_amb_registers(struct i5k_amb_data *data,
> -					    unsigned long devid)
> +				  const struct pci_device_id *devid)
>  {
>  	struct pci_dev *pcidev;
>  	u32 val32;
>  	int res = -ENODEV;
>  
>  	/* Find AMB register memory space */
> -	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
> -				devid,
> +	pcidev = pci_get_device(devid->vendor,
> +				devid->device,
>  				NULL);
>  	if (!pcidev)
>  		return -ENODEV;
> @@ -447,14 +447,18 @@ static int i5k_find_amb_registers(struct i5k_amb_data *data,
>  	return res;
>  }
>  
> -static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
> +static int i5k_channel_probe(u16 *amb_present,
> +			     const struct pci_device_id *devid,
> +			     int next)

'next' is a bit misleading. Something like "offset" or "id_offset" might be
better. A better option would be to not change the function parameters and
generate dev_id when the function is called. After all, the change in this
function is not really necessary and can be handled in calling code.

>  {
>  	struct pci_dev *pcidev;
>  	u16 val16;
>  	int res = -ENODEV;
>  
>  	/* Copy the DIMM presence map for these two channels */
> -	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL, dev_id, NULL);
> +	pcidev = pci_get_device(devid->vendor,
> +				(unsigned long)devid->driver_data + next,
> +				NULL);
>  	if (!pcidev)
>  		return -ENODEV;
>  
> @@ -473,23 +477,20 @@ static int i5k_channel_probe(u16 *amb_present, unsigned long dev_id)
>  	return res;
>  }
>  
> -static struct {
> -	unsigned long err;
> -	unsigned long fbd0;
> -} chipset_ids[]  = {
> -	{ PCI_DEVICE_ID_INTEL_5000_ERR, PCI_DEVICE_ID_INTEL_5000_FBD0 },
> -	{ PCI_DEVICE_ID_INTEL_5400_ERR, PCI_DEVICE_ID_INTEL_5400_FBD0 },
> -	{ 0, 0 }
> -};
> -
> -#ifdef MODULE
>  static const struct pci_device_id i5k_amb_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
> +	{
> +		.vendor		= PCI_VENDOR_ID_INTEL,
> +		.device		= PCI_DEVICE_ID_INTEL_5000_ERR,
> +		.driver_data	= PCI_DEVICE_ID_INTEL_5000_FBD0,
> +	},
> +	{
> +		.vendor		= PCI_VENDOR_ID_INTEL,
> +		.device		= PCI_DEVICE_ID_INTEL_5400_ERR,
> +		.driver_data	= PCI_DEVICE_ID_INTEL_5400_FBD0,

Why not use PCI_DEVICE_DATA() ?

> +	},
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
> -#endif
>  
>  static int i5k_amb_probe(struct platform_device *pdev)
>  {
> @@ -504,22 +505,22 @@ static int i5k_amb_probe(struct platform_device *pdev)
>  	/* Figure out where the AMB registers live */
>  	i = 0;
>  	do {
> -		res = i5k_find_amb_registers(data, chipset_ids[i].err);
> +		res = i5k_find_amb_registers(data, &i5k_amb_ids[i]);
>  		if (res == 0)
>  			break;
>  		i++;
> -	} while (chipset_ids[i].err);
> +	} while (i5k_amb_ids[i].device);
>  
>  	if (res)
>  		goto err;
>  
>  	/* Copy the DIMM presence map for the first two channels */
> -	res = i5k_channel_probe(&data->amb_present[0], chipset_ids[i].fbd0);
> +	res = i5k_channel_probe(&data->amb_present[0], &i5k_amb_ids[i], 0);
>  	if (res)
>  		goto err;
>  
>  	/* Copy the DIMM presence map for the optional second two channels */
> -	i5k_channel_probe(&data->amb_present[2], chipset_ids[i].fbd0 + 1);
> +	i5k_channel_probe(&data->amb_present[2], &i5k_amb_ids[i], 1);
>  
>  	/* Set up resource regions */
>  	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);
> -- 
> 1.9.1
> 
