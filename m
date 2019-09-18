Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A5BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DC0214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+tdx0dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfIRJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:20:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727159AbfIRJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568798428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sT7fK0x+jqQz+lWk9ETuM9jraq8bFSuZGMnYH4NOLGY=;
        b=K+tdx0dJaiNd5noixd2JHDvrzu9dROtzOwz+j/seL8EW5qmJrpCJAGbO0ttir9TXy/DJUL
        UH+pxZbv5u8znmhNZ1ZqQ3FXsBTFXIO3fuuChQICLSDSmJiulgziIdg2SvMxrarBEvTGRV
        N8Cz6s61D4yPyeY2Bv7+McCnPTs7JEw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-LvC9ugRoNwuO2h4P9j_chw-1; Wed, 18 Sep 2019 05:20:24 -0400
Received: by mail-ed1-f69.google.com with SMTP id l11so4003131edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhWvIgedm112neEMmxYV/DwwCSYfDA6TLXIMSq6shag=;
        b=CYm+/4QCiq1E1TPwxRU5k1i4VqfLXZ7xlo7kfQG6iz87pSZvPEl3QQiuVRpOw3nqEw
         zuQRKM8UEK3cRL0Gi1meNCW3EEN6ksMz7opTPH5UaLoxUPRA3bG0ILeEqvduaFcOfNbh
         h5ib2BDZO9cz1/Pfs1XmrsF5bBzOvKD9xV/wUgbX7XYOyrZk0GIkgmCSLZ3xZiH9DV2x
         uIlDNVT99TZFqbOZIjZ9guoFnFqjsJ3H4EGohaZ9sPohIL957E/C9kK3LZb8Rrbn+Q0d
         nEr8MHeV1hrdWd15iF5F4Au2e4HtP5Cn93UOD1P4sd/wYUZuT0NHE4owmA5mqfLQ0DIm
         6g1A==
X-Gm-Message-State: APjAAAX6OU2BOLBqrR2rcQeIxDgdvP6QFRqMIcTCqDZ4DD+p1fvB/jzj
        OP9mmj/VH2lUhZC6Uot7doxABnyrn3gpewzIR6qqNgg5m9GOoUw4Q8zUjmYkZMGIZictbbV3Ybh
        jkWGxkOtEftsBCvQMkvoIkeWH
X-Received: by 2002:a50:aa96:: with SMTP id q22mr9077560edc.179.1568798423101;
        Wed, 18 Sep 2019 02:20:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzw90gaE0hIQ/CJKTrAtBykFLjucwBsmYVudnqyuhgy/FXOYp+2xpBRXrv2W88CvPoiWRLjbQ==
X-Received: by 2002:a50:aa96:: with SMTP id q22mr9077543edc.179.1568798422909;
        Wed, 18 Sep 2019 02:20:22 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h10sm932148edf.81.2019.09.18.02.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 02:20:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f578a65b-af02-5fe8-dd59-9918c000da64@redhat.com>
Date:   Wed, 18 Sep 2019 11:20:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917194507.14771-2-jekhor@gmail.com>
Content-Language: en-US
X-MC-Unique: LvC9ugRoNwuO2h4P9j_chw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17-09-2019 21:45, Yauhen Kharuzhy wrote:
> Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
> hardware has TypeC connector and register related devices described as
> I2C connections in the _CRS resource.
>=20
> There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
> USB B connector exists. It has INT33FE device in the DSDT table but
> there are only two I2C connection described: PMIC and BQ27452 battery
> fuel gauge.
>=20
> Splitting existing INT33FE driver allow to maintain code for USB type B
> (AB) connector variant separately and make it simpler.
>=20
> Split driver to intel_cht_int33fe_common.c and
> intel_cht_int33fe_{typeb,typec}.c. Compile all this source to one .ko
> module to make user experience easier.
>=20
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Thank you for doing this, this version looks much better IMHO.

Note that this does not apply to Linus' current master, please
rebase. Specifically this conflicts with this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D78cd4bf53635d3aeb73435bc89eb6eb39450f315

Which just got merged. Instead of rebasing on Linus' master
(which is always a bit adventurous to use during the merge window)
you can also cherry-pick that single commit on top of v5.3
and use that as a base.

Note that that patch makes changes to struct cht_int33fe_data
specifically it drops the:

=09struct fwnode_handle *mux;

Member, so when rebasing you should drop that in the new
version of the struct on common.h .

Besides that this need a rebase, overall this looks good, I have some
small remarks inline:

<snip>

> diff --git a/drivers/platform/x86/intel_cht_int33fe_common.c b/drivers/pl=
atform/x86/intel_cht_int33fe_common.c
> new file mode 100644
> index 000000000000..4a3d7ebd37dd
> --- /dev/null
> +++ b/drivers/platform/x86/intel_cht_int33fe_common.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common code for Intel Cherry Trail ACPI INT33FE pseudo device drivers
> + * (USB TypeB and TypeC connector variants).
> + *
> + * Copyright (c) 2019 Yauhen Kharuzhy <jekhor@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "intel_cht_int33fe_common.h"
> +
> +#define EXPECTED_PTYPE=09=094
> +
> +static int cht_int33fe_i2c_res_filter(struct acpi_resource *ares, void *=
data)
> +{
> +=09struct acpi_resource_i2c_serialbus *sb;
> +=09int *count =3D data;
> +
> +=09if (i2c_acpi_get_i2c_resource(ares, &sb))
> +=09=09(*count)++;
> +
> +=09return 1;
> +}
> +
> +static int cht_int33fe_count_i2c_clients(struct device *dev)
> +{
> +=09struct acpi_device *adev;
> +=09LIST_HEAD(resource_list);
> +=09int count =3D 0;
> +
> +=09adev =3D ACPI_COMPANION(dev);
> +=09if (!adev)
> +=09=09return -EINVAL;
> +
> +=09acpi_dev_get_resources(adev, &resource_list,
> +=09=09=09       cht_int33fe_i2c_res_filter, &count);
> +
> +=09acpi_dev_free_resource_list(&resource_list);
> +
> +=09return count;
> +}
> +
> +static int cht_int33fe_check_hw_type(struct device *dev)
> +{
> +=09unsigned long long ptyp;
> +=09acpi_status status;
> +=09int ret;
> +
> +=09status =3D acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &pty=
p);
> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_err(dev, "Error getting PTYPE\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09/*
> +=09 * The same ACPI HID is used for different configurations check PTYP
> +=09 * to ensure that we are dealing with the expected config.
> +=09 */
> +=09if (ptyp !=3D EXPECTED_PTYPE)
> +=09=09return -ENODEV;
> +
> +=09/* Check presence of INT34D3 (hardware-rev 3) expected for ptype =3D=
=3D 4 */
> +=09if (!acpi_dev_present("INT34D3", "1", 3)) {
> +=09=09dev_err(dev, "Error PTYPE =3D=3D %d, but no INT34D3 device\n",
> +=09=09=09EXPECTED_PTYPE);
> +=09=09return -ENODEV;
> +=09}
> +
> +=09ret =3D cht_int33fe_count_i2c_clients(dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09switch (ret) {
> +=09case 2:
> +=09=09return INT33FE_HW_TYPEB;
> +=09case 4:
> +=09=09return INT33FE_HW_TYPEC;
> +=09default:
> +=09=09return -ENODEV;
> +=09}
> +}
> +
> +static int cht_int33fe_probe(struct platform_device *pdev)
> +{
> +=09struct cht_int33fe_data *data;
> +=09struct device *dev =3D &pdev->dev;
> +=09int ret;
> +
> +=09ret =3D cht_int33fe_check_hw_type(dev);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +=09if (!data)
> +=09=09return -ENOMEM;
> +
> +=09data->hw_type =3D ret;
> +=09data->dev =3D dev;
> +
> +=09switch (data->hw_type) {

I suggested adding hw_type to data so that it could be used to
select the right remove function in cht_int33fe_remove(),
since you are using a remove function pointer in data for this
(which is fine), there is no reason to store hw_type in
cht_int33fe_data anymore, please drop this and change the

=09switch (data->hw_type) {

to:

=09switch (ret) {


> +=09case INT33FE_HW_TYPEB:
> +=09=09data->probe =3D cht_int33fe_typeb_probe;
> +=09=09data->remove =3D cht_int33fe_typeb_remove;
> +=09=09break;
> +
> +=09case INT33FE_HW_TYPEC:
> +=09=09data->probe =3D cht_int33fe_typec_probe;
> +=09=09data->remove =3D cht_int33fe_typec_remove;
> +=09=09break;
> +=09}
> +
> +=09platform_set_drvdata(pdev, data);
> +
> +=09return data->probe(data);
> +}
> +
> +static int cht_int33fe_remove(struct platform_device *pdev)
> +{
> +=09struct cht_int33fe_data *data =3D platform_get_drvdata(pdev);
> +
> +=09return data->remove(data);
> +}

<snip>

> diff --git a/drivers/platform/x86/intel_cht_int33fe_common.h b/drivers/pl=
atform/x86/intel_cht_int33fe_common.h
> new file mode 100644
> index 000000000000..cb0cc4552017
> --- /dev/null
> +++ b/drivers/platform/x86/intel_cht_int33fe_common.h
> @@ -0,0 +1,44 @@

<snip>

> +int cht_int33fe_typec_remove(struct cht_int33fe_data *data);
> +
> +#endif /* _INTEL_CHT_INT33FE_COMMON_H */
> +

Please drop the empty line at the end of intel_cht_int33fe_common.h .

> diff --git a/drivers/platform/x86/intel_cht_int33fe_typeb.c b/drivers/pla=
tform/x86/intel_cht_int33fe_typeb.c
> new file mode 100644
> index 000000000000..905c29f2f714
> --- /dev/null
> +++ b/drivers/platform/x86/intel_cht_int33fe_typeb.c
> @@ -0,0 +1,64 @@

<snip>

> +int cht_int33fe_typeb_remove(struct cht_int33fe_data *data)
> +{
> +=09i2c_unregister_device(data->battery_fg);
> +
> +=09return 0;
> +}
> +
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/=
x86/intel_cht_int33fe_typec.c

Please drop the empty line at the end of intel_cht_int33fe_typeb.c .

Regards,

Hans

p.s.

I've done the rebase myself and I'm building a kernel with my re-based vers=
ion of this
patch to test it on a typec device. I will get back to you with the results
(I expect things will just work, just making sure).

