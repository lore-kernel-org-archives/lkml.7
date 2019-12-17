Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB6E206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CyxZ01f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfLQHie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:38:34 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39493 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfLQHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:38:33 -0500
Received: by mail-pj1-f68.google.com with SMTP id v11so264105pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=DHaDrl235NuvgBUSyAOzbDvsPHKRkOLqxkSTI0CukQc=;
        b=CyxZ01f02VTK5G8Vitp+PG429XCf+O+Ei1G40C/SnnuTw1FRTmLd6yJTwaI7RF7A3M
         40KmHdWXDQ4uIP+fNeOTbVZFQM5SJWqlCr3Da0EI3V7XINwJvaTH5OZAIcplLWy1Jkgb
         TNGKsMkNgob2xMihaZXgT3ImbKK02SfsUxWSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=DHaDrl235NuvgBUSyAOzbDvsPHKRkOLqxkSTI0CukQc=;
        b=msW1X5vES7gFApkEj19lOictjTh9/RKgLEYZj5UMDf1m/akvzzXCDgnYhm3M+Kn6CZ
         NjX5WU+MQrhtwf5Imq7a4NRkAcV10VeImhHbRLkvBKomn5lPHNMiGG4V8FOKVJPQ1EWN
         QOIaQqiEH7ve/99VXT4Rb1yVsQNAjZUWriQY77crEWZizAU3jz82utPmml15rjcAv/Po
         oR3eetSKWjHBM5gO4+uIOkvJPgS55WDmPlLUx0byT/4SsSSKjVg3aCdUjjJT+KqKMpTO
         Nmb35/J7XGYonjj5o+fawarhrfWdoNj6MPua+RGMtyQFMX+t8BLmC6oLYLuIF8gyPmKR
         rDdg==
X-Gm-Message-State: APjAAAUo1wnoqWBH6NiME0QaZaYIiCh5gfCQWgbKl3vqW4LNjyeYwDBf
        A+joIm5CfJuO8aShmEjJKVcYHA==
X-Google-Smtp-Source: APXvYqxTyWnLbL8Y+krBRTsiWE+3UHBS6mTkqx6KkZPX4L5wRLVKLlrkHlo5Gqzt6XJRgZzP2XT4kA==
X-Received: by 2002:a17:902:27:: with SMTP id 36mr21061539pla.270.1576568312863;
        Mon, 16 Dec 2019 23:38:32 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p185sm1010654pfg.61.2019.12.16.23.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 23:38:32 -0800 (PST)
Message-ID: <5df885f8.1c69fb81.13dda.20bb@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191128125100.14291-2-patrick.rudolph@9elements.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com> <20191128125100.14291-2-patrick.rudolph@9elements.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 23:38:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2019-11-28 04:50:50)
> diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/=
ABI/stable/sysfs-bus-coreboot
> new file mode 100644
> index 000000000000..1b04b8abc858
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-bus-coreboot
> @@ -0,0 +1,43 @@
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/id
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/id if the device corresponds to a CBMEM
> +               buffer.
> +               The file holds an ASCII representation of the CBMEM ID in=
 hex
> +               (e.g. 0xdeadbeef).
> +
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/size
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/size if the device corresponds to a CBMEM
> +               buffer.
> +               The file holds an representation as decimal number of the
> +               CBMEM buffer size (e.g. 64).
> +
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/address
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/address if the device corresponds to a C=
BMEM
> +               buffer.
> +               The file holds an ASCII representation of the physical ad=
dress
> +               of the CBMEM buffer in hex (e.g. 0x000000008000d000).

What is the purpose of this field? Can't userspace read the 'data'
attribute to get the data out?

> +
> +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/data
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               cbmem_attributes/data if the device corresponds to a CBMEM
> +               buffer.
> +               The file holds a read-only binary representation of the C=
BMEM
> +               buffer.
> diff --git a/drivers/firmware/google/cbmem-coreboot.c b/drivers/firmware/=
google/cbmem-coreboot.c
> new file mode 100644
> index 000000000000..c67651a9c287
> --- /dev/null
> +++ b/drivers/firmware/google/cbmem-coreboot.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * fmap-coreboot.c
> + *
> + * Exports CBMEM as attributes in sysfs.
> + *
> + * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> + * Copyright 2017 Google Inc.
> + * Copyright 2019 9elements Agency GmbH
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/module.h>
> +#include <linux/io.h>

Is this include used? Should probably include linux/memremap.h instead.

> +#include <linux/slab.h>
> +
> +#include "coreboot_table.h"
> +
> +#define CB_TAG_CBMEM_ENTRY 0x31
> +
> +struct cb_priv {
> +       void *remap;
> +       struct lb_cbmem_entry entry;
> +};
> +
> +static ssize_t id_show(struct device *dev,
> +                      struct device_attribute *attr, char *buffer)
> +{
> +       const struct cb_priv *priv;
> +
> +       priv =3D (const struct cb_priv *)dev_get_platdata(dev);

Please drop useless casts from void *.

> +
> +       return sprintf(buffer, "0x%08x\n", priv->entry.id);

Use %#08x. Also not sure we need newlines but I guess it's OK.

> +}
> +
> +static ssize_t size_show(struct device *dev,
> +                        struct device_attribute *attr, char *buffer)
> +{
> +       const struct cb_priv *priv;
> +
> +       priv =3D (const struct cb_priv *)dev_get_platdata(dev);
> +
> +       return sprintf(buffer, "%u\n", priv->entry.size);
> +}
> +
> +static ssize_t address_show(struct device *dev,
> +                           struct device_attribute *attr, char *buffer)
> +{
> +       const struct cb_priv *priv;
> +
> +       priv =3D (const struct cb_priv *)dev_get_platdata(dev);
> +
> +       return sprintf(buffer, "0x%016llx\n", priv->entry.address);
> +}
> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(size);
> +static DEVICE_ATTR_RO(address);
> +
> +static struct attribute *cb_mem_attrs[] =3D {
> +       &dev_attr_address.attr,
> +       &dev_attr_id.attr,
> +       &dev_attr_size.attr,
> +       NULL
> +};
> +
> +static ssize_t data_read(struct file *filp, struct kobject *kobj,
> +                        struct bin_attribute *bin_attr,
> +                        char *buffer, loff_t offset, size_t count)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       const struct cb_priv *priv;
> +
> +       priv =3D (const struct cb_priv *)dev_get_platdata(dev);
> +
> +       return memory_read_from_buffer(buffer, count, &offset,
> +                                      priv->remap, priv->entry.size);
> +}
> +
> +static BIN_ATTR_RO(data, 0);
> +
> +static struct bin_attribute *cb_mem_bin_attrs[] =3D {
> +       &bin_attr_data,
> +       NULL
> +};
> +
> +static struct attribute_group cb_mem_attr_group =3D {

Can it be const?

> +       .name =3D "cbmem_attributes",
> +       .attrs =3D cb_mem_attrs,
> +       .bin_attrs =3D cb_mem_bin_attrs,
> +};
> +
> +static int cbmem_probe(struct coreboot_device *cdev)
> +{
> +       struct device *dev =3D &cdev->dev;
> +       struct cb_priv *priv;
> +       int err;
> +
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> +
> +       priv->remap =3D memremap(priv->entry.address,
> +                              priv->entry.entry_size, MEMREMAP_WB);
> +       if (!priv->remap) {
> +               err =3D -ENOMEM;
> +               goto failure;
> +       }
> +
> +       err =3D sysfs_create_group(&dev->kobj, &cb_mem_attr_group);
> +       if (err) {
> +               dev_err(dev, "failed to create sysfs attributes: %d\n", e=
rr);
> +               memunmap(priv->remap);
> +               goto failure;
> +       }
> +
> +       dev->platform_data =3D priv;

Can we use dev_{set,get}_drvdata() instead?

> +
> +       return 0;
> +failure:
> +       kfree(priv);
> +       return err;
> +}
> +
> +static int cbmem_remove(struct coreboot_device *cdev)
> +{
> +       struct device *dev =3D &cdev->dev;
> +       const struct cb_priv *priv;
> +
> +       priv =3D (const struct cb_priv *)dev_get_platdata(dev);
> +
> +       sysfs_remove_group(&dev->kobj, &cb_mem_attr_group);
> +
> +       if (priv)
> +               memunmap(priv->remap);
> +       kfree(priv);
> +
> +       dev->platform_data =3D NULL;

This shouldn't be necessary if the driver_data APIs are used instead.
The driver core does it for us then.

> +
> +       return 0;
> +}
> +
> +static struct coreboot_driver cbmem_driver =3D {
> +       .probe =3D cbmem_probe,
> +       .remove =3D cbmem_remove,
> +       .drv =3D {
> +               .name =3D "cbmem",
> +       },
> +       .tag =3D CB_TAG_CBMEM_ENTRY,
> +};
> +
> +module_coreboot_driver(cbmem_driver);
> +
> +MODULE_AUTHOR("9elements Agency GmbH");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/=
google/coreboot_table.h
> index 7b7b4a6eedda..506048c724d8 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -59,6 +59,18 @@ struct lb_framebuffer {
>         u8  reserved_mask_size;
>  };
> =20
> +/* There can be more than one of these records as there is one per cbmem=
 entry.

Please add a bare /* for multi-line comments.

> + * Describes a buffer in memory containing runtime data.
> + */
> +struct lb_cbmem_entry {
> +       u32 tag;
> +       u32 size;
> +
> +       u64 address;
> +       u32 entry_size;
> +       u32 id;
> +};
> +
>  /* A device, additionally with information from coreboot. */
>  struct coreboot_device {
>         struct device dev;
