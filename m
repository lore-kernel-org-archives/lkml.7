Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEEFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E258B21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RzWxaM+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfJHWrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:47:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38168 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:47:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so107049pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=Y5s71I5sFKjSJ1eMTpexq5DQsl6rApOVmd9WoW4Bqm4=;
        b=RzWxaM+vPcD+4e4533TBh9DPT3BuTSIwQ7GaCgkvJ/P2Oo+YIa6hggq7jhWZMh/4CP
         8aQ4UuVmJkJ3K/4gmVG9jeoJW4b1HrbJZ/RWu7ne8cnZGtqu1i/90HUKj2/3fohz/AyU
         wTCQ13KFY16Njm1q20JQN8qqeE4ywFoLJprpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=Y5s71I5sFKjSJ1eMTpexq5DQsl6rApOVmd9WoW4Bqm4=;
        b=eSzR5LGKVR7/fpwJzfeNvVJqbPwObs0SKl1IoKv0jysEXuuxo3RMLEYwt7Zb8Ndhvh
         1aQnNqw8qe+uhCArBlHhp9m1yzsnzAJVjO1w+LrJA/v3eZndybdmDcvS3VYj0pcIB3FP
         rF+8Dz3N1pEoIAbBVTqyJ5QvelPwDXRPc+c2hSZvla6e7809eivTixXpJjT3lKDakGsB
         wY9+ayhzM3YANLEFCv14MvtISXHWRJAyHgaD6+QzxaUr96fo5OXYZMk1EssfR4Af+JQx
         EIzp/P4TXngUNBb93vtmXR3Js0fgPmnZEpZ385+H3brQlmTFHKI8YIZriorYfP5zPBuC
         qEQA==
X-Gm-Message-State: APjAAAWUXLbPl5uhti78PNaxYiokVbyYPdl2HF0cdH3slqE0e2ZHp8S5
        cOHd99GYxPIqnC0PpdrqVCFXig+mlEM=
X-Google-Smtp-Source: APXvYqwsi8qXPk5eRK3SGQnuaCqWQmtrcAB3/7G6su/PJbvOhnkRiqdwmKwscH8Up6WZWkx21Am4qA==
X-Received: by 2002:a63:3754:: with SMTP id g20mr835318pgn.349.1570574860560;
        Tue, 08 Oct 2019 15:47:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x12sm142152pfm.130.2019.10.08.15.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:47:39 -0700 (PDT)
Message-ID: <5d9d120b.1c69fb81.b6201.1477@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191008115342.28483-2-patrick.rudolph@9elements.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com> <20191008115342.28483-2-patrick.rudolph@9elements.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Zhang <benzh@chromium.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH 2/2] firmware: coreboot: Export active CBFS partition
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 15:47:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2019-10-08 04:53:26)
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Expose the name of the active CBFS partition under
> /sys/firmware/cbfs_active_partition

Somehow we've gotten /sys/firmware/log to be the coreboot log, and quite
frankly that blows my mind that this path was accepted upstream.
Userspace has to know it's running on coreboot firmware to know that
/sys/firmware/log is actually the coreboot log. But it is what it is so
we're not going to change it.

Why don't we expose fmap "areas" under some coreboot fmap class that has
sysfs nodes for the properties of that fmap_area? Basically

	/sys/class/coreboot_fmap/section0/version
	/sys/class/coreboot_fmap/section0/<area name>/{size,offset,flags}
	/sys/class/coreboot_fmap/section1/<area name>/{size,offset,flags}

I made 'section' an incrementing number because I'm not sure that the
fmap header, struct fmap::name, is unique for all fmaps. Is it? If it is
unique then we can have

	/sys/class/coreboot_fmap/<fmap name>/<area name>/{size,flags}

And we may want to make the fmap area a class too, so it would be

	/sys/class/coreboot_fmap/<fmap name>/coreboot_fmap_area/<area name>/{size,=
offset,flags}

But I also wonder why this is being exposed by the kernel at all? Why
can't userspace read the fmap table from the flash chip itself and then
parse it to understand how to update the firmware on the chip? Isn't
that better than relying on coreboot to populate something for us in
memory that describes the flash chip so we can seek around it? I guess
this is faster this way because reading flash chips may be slow?

>=20
> In case of Google's VBOOT[1] that currently can be one of:
> "FW_MAIN_A", "FW_MAIN_B" or "COREBOOT"
>=20
> Will be used by fwupd[2] to determinde the active partition in the

s/determinde/determine/ ?

> VBOOT A/B partition update scheme.
>=20
> [1]: https://doc.coreboot.org/security/vboot/index.html
> [2]: https://fwupd.org/

Can you link to the code in fwupd that is using this stuff from the
kernel?

>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/google/Kconfig              |  10 ++
>  drivers/firmware/google/Makefile             |   1 +
>  drivers/firmware/google/bootmedia-coreboot.c | 115 +++++++++++++++++++
>  drivers/firmware/google/coreboot_table.h     |  13 +++
>  4 files changed, 139 insertions(+)
>  create mode 100644 drivers/firmware/google/bootmedia-coreboot.c
>=20
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kc=
onfig
> index 5fbbd7b8fef6..f58b723d77de 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -82,4 +82,14 @@ config GOOGLE_FMAP
>           the coreboot table.  If found, this binary file is exported to =
userland
>           in the file /sys/firmware/fmap.
> =20
> +config GOOGLE_BOOTMEDIA

Please try to add this Kconfig somewhere alphabetically. Otherwise
people keep adding to the end of the list and it becomes sort of hard to
manage merges.

> +       tristate "Coreboot bootmedia params access"
> +       depends on GOOGLE_COREBOOT_TABLE
> +       depends on GOOGLE_FMAP
> +       help
> +         This option enables the kernel to search for a boot media params
> +         table, providing the active CBFS partition.  If found, the name=
 of
> +         the partition is exported to userland in the file
> +         /sys/firmware/cbfs_active_partition.
> +
>  endif # GOOGLE_FIRMWARE
> diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/M=
akefile
> index 6d31fe167700..e47c59376566 100644
> --- a/drivers/firmware/google/Makefile
> +++ b/drivers/firmware/google/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            +=3D memconsol=
e.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   +=3D memconsole-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) +=3D memconsole-x86-legacy.o
>  obj-$(CONFIG_GOOGLE_FMAP)                  +=3D fmap-coreboot.o
> +obj-$(CONFIG_GOOGLE_BOOTMEDIA)             +=3D bootmedia-coreboot.o

Same here, although it looks like FMAP would need to move in the
previous patch to be sorted by Kconfig name.

> =20
>  vpd-sysfs-y :=3D vpd.o vpd_decode.o
>  obj-$(CONFIG_GOOGLE_VPD)               +=3D vpd-sysfs.o
> diff --git a/drivers/firmware/google/bootmedia-coreboot.c b/drivers/firmw=
are/google/bootmedia-coreboot.c
> new file mode 100644
> index 000000000000..09c0caedaf05
> --- /dev/null
> +++ b/drivers/firmware/google/bootmedia-coreboot.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * bootmedia-coreboot.c
> + *
> + * Exports the active VBOOT partition name through boot media params.
> + *
> + * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> + * Copyright 2017 Google Inc.
> + * Copyright 2019 Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +
> +#include "coreboot_table.h"
> +#include "fmap-coreboot.h"
> +
> +#define CB_TAG_BOOT_MEDIA_PARAMS 0x30
> +
> +/* The current CBFS partition */
> +static char *name;

Can this be passed through some file pointer data member instead of
being a global?

> +
> +static ssize_t cbfs_active_partition_read(struct file *filp,
> +                                         struct kobject *kobp,
> +                                         struct bin_attribute *bin_attr,
> +                                         char *buf,
> +                                         loff_t pos, size_t count)
> +{
> +       if (!name)
> +               return -ENODEV;
> +
> +       return memory_read_from_buffer(buf, count, &pos, name, strlen(nam=
e));
> +}
> +
> +static int bmp_probe(struct coreboot_device *dev)

Maybe call this cdev instead of dev so the code reads as &cdev->dev. Or
'cbdev' maybe.

> +{
> +       struct lb_boot_media_params *b =3D &dev->bmp;
> +       const char *tmp;
> +
> +       /* Sanity checks on the data we got */
> +       if ((b->cbfs_offset =3D=3D ~0) ||

Please drop useless parenthesis.

> +           b->cbfs_size =3D=3D 0 ||
> +           ((b->cbfs_offset + b->cbfs_size) > b->boot_media_size)) {
> +               pr_warn("coreboot: Boot media params contains invalid dat=
a\n");

dev_err()

> +               return -ENODEV;
> +       }
> +
> +       tmp =3D coreboot_fmap_region_to_name(b->cbfs_offset, b->cbfs_size=
);
> +       if (!tmp) {
> +               pr_warn("coreboot: Active CBFS region not found in FMAP\n=
");

Use dev_warn() or dev_err() so 'coreboot:' can be dropped.

> +               return -ENODEV;
> +       }
> +
> +       name =3D devm_kmalloc(&dev->dev, strlen(tmp) + 2, GFP_KERNEL);
> +       if (!name) {
> +               kfree(tmp);
> +               return -ENODEV;
> +       }
> +       snprintf(name, strlen(tmp) + 2, "%s\n", tmp);

devm_kasprintf() can handle this all.

> +
> +       kfree(tmp);
> +
> +       return 0;
> +}
> +
> +static int bmp_remove(struct coreboot_device *dev)
> +{
> +       struct platform_device *pdev =3D dev_get_drvdata(&dev->dev);
> +
> +       platform_device_unregister(pdev);

What is this doing? Was some sort of platform device created?

> +
> +       return 0;
> +}
> +
> +static struct coreboot_driver bmp_driver =3D {
> +       .probe =3D bmp_probe,
> +       .remove =3D bmp_remove,
> +       .drv =3D {
> +               .name =3D "bootmediaparams",
> +       },
> +       .tag =3D CB_TAG_BOOT_MEDIA_PARAMS,
> +};
> +
> +static struct bin_attribute cbfs_partition_bin_attr =3D {
> +       .attr =3D {.name =3D "cbfs_active_partition", .mode =3D 0444},
> +       .read =3D cbfs_active_partition_read,
> +};
> +
> +static int __init coreboot_bmp_init(void)
> +{
> +       int err;
> +
> +       err =3D sysfs_create_bin_file(firmware_kobj, &cbfs_partition_bin_=
attr);
> +       if (err)
> +               return err;

I don't think we want to create a sysfs object whenever this driver is
loaded. We should only make sysfs nodes when a device matches a driver.

> +
> +       return coreboot_driver_register(&bmp_driver);
> +}
> +
> +static void coreboot_bmp_exit(void)
> +{
> +       coreboot_driver_unregister(&bmp_driver);
> +       sysfs_remove_bin_file(firmware_kobj, &cbfs_partition_bin_attr);
> +}
> +
> +module_init(coreboot_bmp_init);
> +module_exit(coreboot_bmp_exit);

Just use module_coreboot_driver() instead.

> +
> +MODULE_AUTHOR("9elements Agency GmbH");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/=
google/coreboot_table.h
> index 7b7b4a6eedda..a03e039425b8 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -59,6 +59,18 @@ struct lb_framebuffer {
>         u8  reserved_mask_size;
>  };
> =20
> +/* coreboot table with TAG 0x30 */
> +struct lb_boot_media_params {
> +       u32 tag;
> +       u32 size;

Not a problem with this patch, but I think we should make these two
common fields 'struct coreboot_table_entry' that is inside this struct
and also make all these fields __le{32,64} and do endian conversions in
the code.

> +
> +       /* offsets are relative to start of boot media */
> +       u64 fmap_offset;
> +       u64 cbfs_offset;
> +       u64 cbfs_size;
> +       u64 boot_media_size;
> +};
> +
>  /* A device, additionally with information from coreboot. */
>  struct coreboot_device {
>         struct device dev;
