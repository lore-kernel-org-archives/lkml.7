Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323DCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F28D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LesI+bsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfJ2Rx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:53:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44308 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2Rx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:53:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id q26so6461319pfn.11;
        Tue, 29 Oct 2019 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ffur91RJ45WjuF1j0OoXHAk+x+fTfAOAes4m/hZK27s=;
        b=LesI+bsj7gvcEjArf5uNLUIadhJKPkB7a2DHCoUXVRF2MFmCEhJpIwP3IAU+urpWtn
         xD3YUgBiEjbnXZyigx+GNd3BjVNmLRNQq9Zzid88aEkgV9EugLZ7kEunTqJYYCeyoQ0o
         UVhGGni694g7tuWFrtQIeuNqHz8s3AUtquD16jg8jFdvOBMfvb37BJHKlbgu8mwDn0qp
         /UJXr20qdE6wNZ7P5l9+5PNlNIGKyN8Yj4volXp8viAxiC0ILXuVFxW26ssRQIuFXhHw
         lv4Z7/E2S57gn8WaxLWpHvhaHOJjyCYyvo54R7Ln1vxxS2Hok2FgB/RE28fndollfDEr
         n7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ffur91RJ45WjuF1j0OoXHAk+x+fTfAOAes4m/hZK27s=;
        b=f5xZFiPM1yD47v0s4GW7+hYBENa4NO1uRcg19q4xFmYlw+i16g02Jhw94jfX1IenHh
         T9p/Zg6yDkybyy+wmn0cvoEZ0m2EuWoSw0GAyQRo7vz3oh0j6jxTQ4sM3IgGZk7pZxvb
         DjYznGw7MudhxKhwnUpfruclMB7onM+OVpE/LqF1EPQaMJhA3r3Xo2Nd5w1v7ExpUmtJ
         TJAmkhrg73iQSXbe1gY80EnHsblCU/WyL4iVCdDnuP43ZNR7AThLO6YeKWMpLP9C6Hks
         4i/au27X6bqj3SWx9lIbilgljfbEogOZyFo69AujXHVsyTKB/i+ig/U1YC8pl89tORp8
         dDGw==
X-Gm-Message-State: APjAAAXQ7y+8UcAu3SUYdRtxclN03ZdCgGq5eFxnElBl4mn17MkEUrw+
        wimRXmZhI54oW7zwaU6zlCy8jX5Myn0=
X-Google-Smtp-Source: APXvYqxq0GYNvu9R00b6ROGRfOUhpnAhlbfvib2ce+Fqczk+mWH4aICoCM9V0q57ILXcEQqjN4GTEw==
X-Received: by 2002:a62:6546:: with SMTP id z67mr29041352pfb.32.1572371605773;
        Tue, 29 Oct 2019 10:53:25 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::1:3a3e])
        by smtp.gmail.com with ESMTPSA id h66sm8041831pfg.23.2019.10.29.10.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 10:53:25 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:53:17 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH 1/3] hwmon: (pmbus) add BEL PFE1100 power supply driver
Message-ID: <20191029175316.GA26890@taoren-ubuntu-R90MNF91>
References: <20191028234904.12441-1-rentao.bupt@gmail.com>
 <20191028234904.12441-2-rentao.bupt@gmail.com>
 <20191029124255.GA23349@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029124255.GA23349@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 05:42:55AM -0700, Guenter Roeck wrote:
> On Mon, Oct 28, 2019 at 04:49:02PM -0700, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add the driver to support BEL PFE1100 which is 1100 Wat AC to DC power
> > supply. The chip has only 1 page.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Please combine with the next patch.

Sure. Will combine the 2 patches in v2.

> > ---
> >  drivers/hwmon/pmbus/Kconfig   |  9 +++++
> >  drivers/hwmon/pmbus/Makefile  |  1 +
> >  drivers/hwmon/pmbus/bel-pfe.c | 68 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 78 insertions(+)
> >  create mode 100644 drivers/hwmon/pmbus/bel-pfe.c
> > 
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index d62d69bb7e49..59859979571d 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -36,6 +36,15 @@ config SENSORS_ADM1275
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called adm1275.
> >  
> > +config SENSORS_BEL_PFE
> > +	tristate "Bel PFE Compatible Power Supplies"
> > +	help
> > +	  If you say yes here you get hardware monitoring support for BEL
> > +	  PFE1100 and PFE3000 Power Supplies.
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called bel-pfe.
> > +
> >  config SENSORS_IBM_CFFPS
> >  	tristate "IBM Common Form Factor Power Supply"
> >  	depends on LEDS_CLASS
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > index 03bacfcfd660..3f8c1014938b 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -6,6 +6,7 @@
> >  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
> >  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> >  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
> > +obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> >  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> >  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> >  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> > diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
> > new file mode 100644
> > index 000000000000..117f9af21bf3
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/bel-pfe.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hardware monitoring driver for BEL PFE family power supplies.
> > + *
> > + * Copyright (c) 2019 Facebook Inc.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> 
> Alphabetic include file order, please.

Got it. Will take care of it in v2.
 
> > +#include "pmbus.h"
> > +
> > +enum chips {pfe1100};
> > +
> > +static struct pmbus_driver_info pfe_driver_info[] = {
> > +	[pfe1100] = {
> > +		.pages = 1,
> > +		.format[PSC_VOLTAGE_IN] = linear,
> > +		.format[PSC_VOLTAGE_OUT] = linear,
> > +		.format[PSC_CURRENT_IN] = linear,
> > +		.format[PSC_CURRENT_OUT] = linear,
> > +		.format[PSC_POWER] = linear,
> > +		.format[PSC_TEMPERATURE] = linear,
> > +		.format[PSC_FAN] = linear,
> > +
> > +		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> > +			   PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> > +			   PMBUS_HAVE_POUT |
> > +			   PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> > +			   PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> > +			   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> > +			   PMBUS_HAVE_STATUS_TEMP |
> > +			   PMBUS_HAVE_FAN12,
> > +	},
> > +};
> > +
> > +static int pfe_pmbus_probe(struct i2c_client *client,
> > +			   const struct i2c_device_id *id)
> > +{
> > +	int model;
> > +
> > +	model = (int)id->driver_data;
> > +	return pmbus_do_probe(client, id, &pfe_driver_info[model]);
> > +}
> > +
> > +static const struct i2c_device_id pfe_device_id[] = {
> > +	{"pfe1100", pfe1100},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, pfe_device_id);
> > +
> > +static struct i2c_driver pfe_pmbus_driver = {
> > +	.driver = {
> > +		   .name = "bel-pfe",
> > +	},
> > +	.probe = pfe_pmbus_probe,
> > +	.remove = pmbus_do_remove,
> > +	.id_table = pfe_device_id,
> > +};
> > +
> > +module_i2c_driver(pfe_pmbus_driver);
> > +
> > +MODULE_AUTHOR("Tao Ren <rentao.bupt@gmail.com>");
> > +MODULE_DESCRIPTION("PMBus driver for BEL PFE Family Power Supplies");
> > +MODULE_LICENSE("GPL");
