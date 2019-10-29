Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E76621479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLggDLj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfJ2Muv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:50:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37946 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfJ2Muu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:50:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so7569306plq.5;
        Tue, 29 Oct 2019 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHCaGl9fv6YiMB+mVXvY7+SwWe5TfLaQW4JqhO/2TUs=;
        b=KLggDLj5bLWsqGiu6yICcD8zHkDhXoVdKvMrRM0ALxMgVvsWASHOS15cGLDTwOY9st
         BAuDlhvNLGklQjQfQ4KeIvxP6MRQZTtFEZB74ckR9l9/PDDSgGr8558SSkTuDn1XHIF9
         Fq/TvzvMgDxGK8TpgQNsC1y9PcaJs+EnjC6eygFpmu6VF3H4RncpE84LiSsZxWkSKAW9
         kBqEVw46Vxc6OblZTZYqc+46Nce/xhtL4HhDFEiWcUydkTPmz7cT2nqHSFtqsWxI1nOq
         x2rTPMfE6ZETgta8pgS6fX0daFl97Q3j6SQApJ1V+Wsbxjt7LYM68TnSCzbB7j+a7qaw
         C8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHCaGl9fv6YiMB+mVXvY7+SwWe5TfLaQW4JqhO/2TUs=;
        b=f571NOhx4tZ4C3FqeYbyIv+KeneUg1f2drA6M1GMqy2t4RIRmq6g9E6MDKPxdqbr9j
         ddyig8dwLCiSnceiw5yRSXtoGi70vNS3ARs01NInDyDboDHkN2mtj9ZpQdMrYsGaMqe+
         oiPH3XdTnCXz/XEF3crutQ9T0Qyxzh1eSXlyqamql2E1o2aKEsARMMVudgl0lAn9lyGE
         89GpcT7QdzzNMdj75GTwsicI2kXFByg2Q9MWijPynvSD9G9YVATGqzKGYlVeT29+YV5r
         aOXzOt+T/lc8tpEOkZRcmLeN+6LVU/nrl+YyYfxOT0ilsPXZwNjQWKTNswNp5aLnCiV8
         j7Ww==
X-Gm-Message-State: APjAAAV3z4FUfOQwhNADtDydrIvhowDfsd5XUPELtarK/sLZd/4w+B1J
        f9T5cr2jXXEn0VS/SstL9BdFzYa/
X-Google-Smtp-Source: APXvYqy030+UQ0PBOHJyB30/XeP04Yed8jt7GTDmTcLbJqWokWgJNB0cgJe6h23eYPuNiNtx3Nf5uw==
X-Received: by 2002:a17:902:b711:: with SMTP id d17mr3764796pls.298.1572353449619;
        Tue, 29 Oct 2019 05:50:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o185sm13968333pfg.136.2019.10.29.05.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 05:50:49 -0700 (PDT)
Date:   Tue, 29 Oct 2019 05:50:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     rentao.bupt@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH 2/3] hwmon: (pmbus) add BEL PFE3000 power supply driver
Message-ID: <20191029125048.GA32552@roeck-us.net>
References: <20191028234904.12441-1-rentao.bupt@gmail.com>
 <20191028234904.12441-3-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028234904.12441-3-rentao.bupt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:49:03PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add the driver to support BEL PFE3000 which is 3000 Wat AC to DC power

which is a ...

Watt

> supply. The chip has 8 pages.

FWIW, that is a bit misleading here. It isn't really 8 pages. I would suggest
to drop that comment (or, if you insist, at least add "two of which are
reserved").

> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  drivers/hwmon/pmbus/bel-pfe.c | 65 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
> index 117f9af21bf3..7b6c90b056c9 100644
> --- a/drivers/hwmon/pmbus/bel-pfe.c
> +++ b/drivers/hwmon/pmbus/bel-pfe.c
> @@ -10,9 +10,21 @@
>  #include <linux/init.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/pmbus.h>
> +
>  #include "pmbus.h"
>  
> -enum chips {pfe1100};
> +enum chips {pfe1100, pfe3000};
> +
> +/*
> + * Disable status check for pfe3000 devices, because some devices report
> + * communication error (invalid command) for VOUT_MODE command (0x20)
> + * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
> + * exponent in linear mode.
> + */
> +static struct pmbus_platform_data pfe3000_plat_data = {
> +	.flags = PMBUS_SKIP_STATUS_CHECK,
> +};
>  
>  static struct pmbus_driver_info pfe_driver_info[] = {
>  	[pfe1100] = {
> @@ -34,6 +46,45 @@ static struct pmbus_driver_info pfe_driver_info[] = {
>  			   PMBUS_HAVE_STATUS_TEMP |
>  			   PMBUS_HAVE_FAN12,
>  	},
> +
> +	[pfe3000] = {
> +		.pages = 8,
> +		.format[PSC_VOLTAGE_IN] = linear,
> +		.format[PSC_VOLTAGE_OUT] = linear,
> +		.format[PSC_CURRENT_IN] = linear,
> +		.format[PSC_CURRENT_OUT] = linear,
> +		.format[PSC_POWER] = linear,
> +		.format[PSC_TEMPERATURE] = linear,
> +		.format[PSC_FAN] = linear,
> +
> +		/* Page 0: V1. */
> +		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +			   PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12 |
> +			   PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> +			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> +			   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +			   PMBUS_HAVE_TEMP3 | PMBUS_HAVE_STATUS_TEMP |
> +			   PMBUS_HAVE_VCAP,
> +
> +		/* Page 1: Vsb. */
> +		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> +			   PMBUS_HAVE_POUT,
> +
> +		/*
> +		 * Page 2: V1 Ishare.
> +		 * Page 4: V1 Cathode.
> +		 * Page 5: Vsb Cathode.
> +		 * Page 6: V1 Sense.
> +		 * Page 3 and 7 are reserved.

If page 7 is reserved, and doesn't have any attributes, it doesn't really
make sense to claim support for 8 pages above. I would suugest to make it 7.

> +		 */
> +		.func[2] = PMBUS_HAVE_VOUT,
> +		.func[4] = PMBUS_HAVE_VOUT,
> +		.func[5] = PMBUS_HAVE_VOUT,
> +		.func[6] = PMBUS_HAVE_VOUT,
> +	},
>  };
>  
>  static int pfe_pmbus_probe(struct i2c_client *client,
> @@ -42,11 +93,23 @@ static int pfe_pmbus_probe(struct i2c_client *client,
>  	int model;
>  
>  	model = (int)id->driver_data;
> +
> +	/*
> +	 * PFE3000-12-069RA devices may not stay in page 0 during device
> +	 * probe which leads to probe failure (read status word failed).
> +	 * So let's set the device to page 0 at the beginning.
> +	 */
> +	if (model == pfe3000) {
> +		client->dev.platform_data = &pfe3000_plat_data;
> +		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
> +	}
> +
>  	return pmbus_do_probe(client, id, &pfe_driver_info[model]);
>  }
>  
>  static const struct i2c_device_id pfe_device_id[] = {
>  	{"pfe1100", pfe1100},
> +	{"pfe3000", pfe3000},
>  	{}
>  };
>  
