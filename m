Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56DCC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7019D2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2b3aRAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDLUl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:41:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38853 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDLUl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:41:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so5672664plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MbXQHPFKFs9QXh+4FcoXqj3E9S6gjKkLjMQR1K+xGQ=;
        b=v2b3aRAZHPk3PMqTaGuLwmPFT7VCMq41xJ7xuhDT8eR5Vj/xZOHE3XXUuT+dDVCnoU
         8P44f1PviyOgYDO9bIzlvhhhKdonzEDuBcgOdRH3ZmckISkOX8STZC8EQMRtve0UnQIZ
         6vWOUldI+XAADrc3FEsT1+gJcrMqSvzTan5Jk+WTfe4pVNRTLAyOCIhNsNtG5ptBwO1k
         Br20+fhO1qAjXdZwY+7e0PP7GSIFP0xuXv3Kn4AOqTrkE3r4Bzt8atw3t+K9ln42/VvV
         6M0FB34+Wy+jIpYqFh2PdckWj6HaRky3vSErvO1IoDqj2JzPG4mxWE0NgUnMM/Egaal0
         nAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MbXQHPFKFs9QXh+4FcoXqj3E9S6gjKkLjMQR1K+xGQ=;
        b=KF4BbwcMFSxZzVAv0ISQJELDSoFG2F+OR2JNt6QnYyA3fDg61oH34mlSgc5O0E2UKN
         ODAmfFyCt3WMq1lGh19qbiF9BkKe1Gqo6N/oz2tIEVVKqm5sK7hK5TGy1V4XJy45uDjB
         ZzcocY65meosC8RBefKsjWZFYKkgTL/tajuVMv19Eh3TTj6/+P/NdvO/9KdCDYVPX0Kc
         B0eKCMtM+KkyISv5yODhlMjfYfqbTIY1BJevVHbE164LC4pSWchudUe8sqkgyPy1BZOe
         NGhxUHUM4Kgq7EL5jYhyHOPO/LTZf740dmPmAVOLZSkJKoJxww4k/B2n2huLB5GhikbS
         rmWA==
X-Gm-Message-State: APjAAAWrUChETm3un6W9O2cs5wrbrHeDOcpqnuuoWtW3Y1T5s0nCu2d/
        /s7SE38ttw2cKnoZMT8mvukaD5E+Jir4GdIEekjUow==
X-Google-Smtp-Source: APXvYqyBqQqbX0juWWXl3/d2E/RKVYFaBVA7OPlSQhfwmKIxfsQzVi0KmmGcIaCiOGExT4TfpXeDwuJcSz0ON0j+eIQ=
X-Received: by 2002:a17:902:854c:: with SMTP id d12mr12445767plo.150.1555101686024;
 Fri, 12 Apr 2019 13:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190412194348.225570-1-venture@google.com> <57e7d1e5-b980-fc80-ae2f-8a0ab12a0dbd@roeck-us.net>
In-Reply-To: <57e7d1e5-b980-fc80-ae2f-8a0ab12a0dbd@roeck-us.net>
From:   Patrick Venture <venture@google.com>
Date:   Fri, 12 Apr 2019 13:41:15 -0700
Message-ID: <CAO=notx0_F64goou+PNwmi4AmthRY28EvhM1e+6ERtvTi6yYSw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/ir38064): Add driver for Infineon
 IR38064 Voltage Regulator
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net,
        Maxim Sloyko <maxims@google.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 1:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/12/19 12:43 PM, Patrick Venture wrote:
> > From: Maxim Sloyko <maxims@google.com>
> >
> > Add the pmbus driver for the Infineon ir38064 voltage regulator.
> >
> > Signed-off-by: Maxim Sloyko <maxims@google.com>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> > v2:
> >   - Cleaned up weird tabbing behavior in doc.
> > v1:
> >   - Initial patchset.
> > ---
> >   Documentation/hwmon/ir38064   | 64 +++++++++++++++++++++++++++++++++++
> >   drivers/hwmon/pmbus/Kconfig   |  9 +++++
> >   drivers/hwmon/pmbus/Makefile  |  1 +
> >   drivers/hwmon/pmbus/ir38064.c | 60 ++++++++++++++++++++++++++++++++
> >   4 files changed, 134 insertions(+)
> >   create mode 100644 Documentation/hwmon/ir38064
> >   create mode 100644 drivers/hwmon/pmbus/ir38064.c
> >
> > diff --git a/Documentation/hwmon/ir38064 b/Documentation/hwmon/ir38064
> > new file mode 100644
> > index 0000000000000..618779a329da0
> > --- /dev/null
> > +++ b/Documentation/hwmon/ir38064
> > @@ -0,0 +1,64 @@
> > +Kernel driver ir38064
> > +=====================
> > +
> > +Supported chips:
> > +  * Infineon IR38064
> > +    Prefix: 'ir38064'
> > +    Addresses scanned: -
> > +    Datasheet: Publicly available at the Infineon webiste
> > +      https://www.infineon.com/dgdl/Infineon-IR38064MTRPBF-DS-v03_07-EN.pdf?fileId=5546d462584d1d4a0158db0d9efb67ca
> > +
> > +Datasheet is not publicly available.
> > +
> > +
> > +Authors:
> > +        Maxim Sloyko <maxims@google.com>
> > +        Patrick Venture <venture@google.com>
> > +
> > +Description
> > +-----------
> > +
> > +IR38064 is a Single-input Voltage, Synchronous Buck Regulator, DC-DC Converter.
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not probe for PMBus devices. You will have to instantiate
> > +devices explicitly.
> > +
> > +Sysfs attributes
> > +----------------
> > +
> > +curr1_label          "iout1"
> > +curr1_input          Measured output current
> > +curr1_crit           Critical maximum current
> > +curr1_crit_alarm     Current critical high alarm
> > +curr1_max            Maximum current
> > +curr1_max_alarm      Current high alarm
> > +
> > +in1_label            "vin"
> > +in1_input            Measured input voltage
> > +in1_crit             Critical maximum input voltage
> > +in1_crit_alarm               Input voltage critical high alarm
> > +in1_min              Minimum input voltage
> > +in1_min_alarm                Input voltage low alarm
> > +
> > +in2_label            "vout1"
> > +in2_input            Measured output voltage
> > +in2_lcrit            Critical minimum output voltage
> > +in2_lcrit_alarm      Output voltage critical low alarm
> > +in2_crit             Critical maximum output voltage
> > +in2_crit_alarm               Output voltage critical high alarm
> > +in2_max              Maximum output voltage
> > +in2_max_alarm                Output voltage high alarm
> > +in2_min              Minimum output voltage
> > +in2_min_alarm                Output voltage low alarm
> > +
> > +power1_label         "pout1"
> > +power1_input         Measured output power
> > +
> > +temp1_input          Measured temperature
> > +temp1_crit           Critical high temperature
> > +temp1_crit_alarm     Chip temperature critical high alarm
> > +temp1_max            Maximum temperature
> > +temp1_max_alarm      Chip temperature high alarm
> > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > index 629cb45f8557a..de87abab990e5 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -54,6 +54,15 @@ config SENSORS_IR35221
> >         This driver can also be built as a module. If so, the module will
> >         be called ir35521.
> >
> > +config SENSORS_IR38064
> > +     tristate "Infineon IR38064"
> > +     help
> > +       If you say yes here you get hardware monitoring support for Infineon
> > +       IR38064.
> > +
> > +       This driver can also be built as a module. If so, the module will
> > +       be called ir38064.
> > +
> >   config SENSORS_LM25066
> >       tristate "National Semiconductor LM25066 and compatibles"
> >       help
> > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > index ea0e39518c216..7d1fa6b3c8c93 100644
> > --- a/drivers/hwmon/pmbus/Makefile
> > +++ b/drivers/hwmon/pmbus/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)   += pmbus.o
> >   obj-$(CONFIG_SENSORS_ADM1275)       += adm1275.o
> >   obj-$(CONFIG_SENSORS_IBM_CFFPS)     += ibm-cffps.o
> >   obj-$(CONFIG_SENSORS_IR35221)       += ir35221.o
> > +obj-$(CONFIG_SENSORS_IR38064)        += ir38064.o
> >   obj-$(CONFIG_SENSORS_LM25066)       += lm25066.o
> >   obj-$(CONFIG_SENSORS_LTC2978)       += ltc2978.o
> >   obj-$(CONFIG_SENSORS_LTC3815)       += ltc3815.o
> > diff --git a/drivers/hwmon/pmbus/ir38064.c b/drivers/hwmon/pmbus/ir38064.c
> > new file mode 100644
> > index 0000000000000..4b957ebb6fa71
> > --- /dev/null
> > +++ b/drivers/hwmon/pmbus/ir38064.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Hardware monitoring driver for Infineon IR38064
> > + *
> > + * Copyright (c) 2017 Google Inc
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include "pmbus.h"
> > +
> > +static struct pmbus_driver_info ir38064_info = {
> > +     .pages = 1,
> > +     .format[PSC_VOLTAGE_IN] = linear,
> > +     .format[PSC_VOLTAGE_OUT] = direct,
>
> The datasheet says this is linear16 format with exponent=-8.
> Oddly enough, the datasheet also suggests that VOUT_MODE is
> not supported, which would normally report the exponent.
> I think it would be is better to implement a local read function
> and fake VOUT_MODE instead of declaring direct mode, but then
> I understand that it would make the code more complex. I'll
> leave it up to you, but if you want to keep it as-is,
> please explain in a comment that you are faking linear16
> mode with exponent -8.

Added to commit message in v3.

>
> > +     .format[PSC_CURRENT_OUT] = linear,
> > +     .format[PSC_POWER] = linear,
> > +     .format[PSC_TEMPERATURE] = linear,
> > +     .m[PSC_VOLTAGE_OUT] = 256,
> > +     .b[PSC_VOLTAGE_OUT] = 0,
> > +     .R[PSC_VOLTAGE_OUT] = 0,
> > +     .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> > +         | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> > +         | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> > +         | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> > +         | PMBUS_HAVE_POUT,
> > +};
> > +
>
> Not mandatory, but the chip does support VOUT_PEAK, IOUT_PEAK,
> and TEMPERATURE_PEAK, just in case you are interested adding
> support for it.

Added to commit message in v3.

>
> Thanks,
> Guenter

Thanks.

>
> > +static int ir38064_probe(struct i2c_client *client,
> > +                      const struct i2c_device_id *id)
> > +{
> > +     return pmbus_do_probe(client, id, &ir38064_info);
> > +}
> > +
> > +static const struct i2c_device_id ir38064_id[] = {
> > +     {"ir38064", 0},
> > +     {}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, ir38064_id);
> > +
> > +/* This is the driver that will be inserted */
> > +static struct i2c_driver ir38064_driver = {
> > +     .driver = {
> > +                .name = "ir38064",
> > +                },
> > +     .probe = ir38064_probe,
> > +     .remove = pmbus_do_remove,
> > +     .id_table = ir38064_id,
> > +};
> > +
> > +module_i2c_driver(ir38064_driver);
> > +
> > +MODULE_AUTHOR("Maxim Sloyko <maxims@google.com>");
> > +MODULE_DESCRIPTION("PMBus driver for Infineon IR38064");
> > +MODULE_LICENSE("GPL");
> >
>
