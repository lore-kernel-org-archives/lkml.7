Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB81C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CFF21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WXs7f3IG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfJHWsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:48:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40015 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:48:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so102044pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=NfD1q7GCRaa2Ad3LNcgKfQaWqxWe9sCdZ0FYIW2FBsc=;
        b=WXs7f3IG23UW4CadUmGz5ikCG+xZEK5kPB02a7eOPPGShCl4ELspSgpj7pIzTkyVcg
         seHqzxdJNzXonc0oUAD9SWuSowi0837YQFARSeDPXej09ILPEcxcwnOdFu1ZNFBBa2VH
         WPcholztqkEm0C3Y8Kj8YcjV6Y/BYeHOn+uPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=NfD1q7GCRaa2Ad3LNcgKfQaWqxWe9sCdZ0FYIW2FBsc=;
        b=IwMForOi90wRUBQjUt7wvjRdogIoRlVJr6D/pIG3aTuF58z+ptjUhF9hLGtebQMxDi
         ghkvhFw+85NnI/bh9eDqN6iC3zQQpHaOBMFVf7BfpYYDUSX0M96LXvzgPRvqE3fVC9HB
         X0xcpNEXDV2XpUdLsX8+g0j0fiZgLXzwaeQEbT/evyRDdGJ+xzM8VHfPsj8CDJfEdN9D
         Wxzm6uJOMAV7qMMyevn4oJVH6VDUvnWQYaZVkAUL2bA7fDshZKWKK0hbFycioAY/MxcG
         /CpNIfw8pjzo/sQ9g4E0YTdEM7XoCo39sNiD7xFmJ0ARvaAXjh6Gq48f8KYxGihuB85B
         +h0w==
X-Gm-Message-State: APjAAAU9d5syBK20c3hPfqixKwl1REDZ19sr2duTm4qXIBJwDvKyhaSD
        hjN1iBdp2ieqyFE8OMApRW+6jBF/aos=
X-Google-Smtp-Source: APXvYqzb5XB+GCneCuoH5bZ1uIIL2TxJ6fLp5OnjUQEhiiandzQwVthG1W/lJaKxW5jazxKMT3fDqQ==
X-Received: by 2002:a17:90a:9b86:: with SMTP id g6mr245526pjp.76.1570574880690;
        Tue, 08 Oct 2019 15:48:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k65sm238795pga.94.2019.10.08.15.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:48:00 -0700 (PDT)
Message-ID: <5d9d1220.1c69fb81.e1df.24e4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191008115342.28483-1-patrick.rudolph@9elements.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH 1/2] firmware: coreboot: Export the binary FMAP
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 15:47:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2019-10-08 04:53:25)
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Expose coreboot's binary FMAP[1] to /sys/firmware/fmap.
>=20
> coreboot copies the FMAP to a CBMEM buffer at boot since CB:35377[2],
> allowing an architecture independ way of exposing the FMAP to userspace.
>=20
> Will be used by fwupd[3] to determine the current firmware layout.
>=20
> [1]: https://doc.coreboot.org/lib/flashmap.html
> [2]: https://review.coreboot.org/c/coreboot/+/35377
> [3]: https://fwupd.org/
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/google/Kconfig           |   8 ++
>  drivers/firmware/google/Makefile          |   1 +
>  drivers/firmware/google/fmap-coreboot.c   | 156 ++++++++++++++++++++++
>  drivers/firmware/google/fmap-coreboot.h   |  13 ++
>  drivers/firmware/google/fmap_serialized.h |  59 ++++++++
>  5 files changed, 237 insertions(+)
>  create mode 100644 drivers/firmware/google/fmap-coreboot.c
>  create mode 100644 drivers/firmware/google/fmap-coreboot.h
>  create mode 100644 drivers/firmware/google/fmap_serialized.h
>=20
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kc=
onfig
> index a3a6ca659ffa..5fbbd7b8fef6 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -74,4 +74,12 @@ config GOOGLE_VPD
>           This option enables the kernel to expose the content of Google =
VPD
>           under /sys/firmware/vpd.
> =20
> +config GOOGLE_FMAP
> +       tristate "Coreboot FMAP access"
> +       depends on GOOGLE_COREBOOT_TABLE
> +       help
> +         This option enables the kernel to search for a Google FMAP in
> +         the coreboot table.  If found, this binary file is exported to =
userland
> +         in the file /sys/firmware/fmap.
> +
>  endif # GOOGLE_FIRMWARE
> diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/M=
akefile
> index d17caded5d88..6d31fe167700 100644
> --- a/drivers/firmware/google/Makefile
> +++ b/drivers/firmware/google/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  +=3D framebuff=
er-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE)            +=3D memconsole.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   +=3D memconsole-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) +=3D memconsole-x86-legacy.o
> +obj-$(CONFIG_GOOGLE_FMAP)                  +=3D fmap-coreboot.o
> =20
>  vpd-sysfs-y :=3D vpd.o vpd_decode.o
>  obj-$(CONFIG_GOOGLE_VPD)               +=3D vpd-sysfs.o
> diff --git a/drivers/firmware/google/fmap-coreboot.c b/drivers/firmware/g=
oogle/fmap-coreboot.c
> new file mode 100644
> index 000000000000..14050030ebc6
> --- /dev/null
> +++ b/drivers/firmware/google/fmap-coreboot.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * fmap-coreboot.c
> + *
> + * Exports the binary FMAP through coreboot table.
> + *
> + * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> + * Copyright 2017 Google Inc.
> + * Copyright 2019 9elements Agency GmbH <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/io.h>
> +
> +#include "coreboot_table.h"
> +#include "fmap_serialized.h"
> +
> +#define CB_TAG_FMAP 0x37
> +
> +static void *fmap;
> +static u32 fmap_size;
> +
> +/*
> + * Convert FMAP region to name.
> + * The caller has to free the string.
> + * Return NULL if no containing region was found.
> + */
> +const char *coreboot_fmap_region_to_name(const u32 start, const u32 size)
> +{
> +       const char *name =3D NULL;
> +       struct fmap *iter;
> +       u32 size_old =3D ~0;
> +       int i;
> +
> +       iter =3D fmap;
> +       /* Find smallest containing region */
> +       for (i =3D 0; i < iter->nareas && fmap; i++) {
> +               if (iter->areas[i].offset <=3D start &&
> +                   iter->areas[i].size >=3D size &&
> +                   iter->areas[i].size <=3D size_old) {
> +                       size_old =3D iter->areas[i].size;
> +                       name =3D iter->areas[i].name;
> +               }
> +       }
> +
> +       if (name)
> +               return kstrdup(name, GFP_KERNEL);
> +       return NULL;
> +}
> +EXPORT_SYMBOL(coreboot_fmap_region_to_name);
> +
> +static ssize_t fmap_read(struct file *filp, struct kobject *kobp,
> +                        struct bin_attribute *bin_attr, char *buf,
> +                        loff_t pos, size_t count)
> +{
> +       if (!fmap)
> +               return -ENODEV;
> +
> +       return memory_read_from_buffer(buf, count, &pos, fmap, fmap_size);
> +}
> +
> +static int fmap_probe(struct coreboot_device *dev)
> +{
> +       struct lb_cbmem_ref *cbmem_ref =3D &dev->cbmem_ref;
> +       struct fmap *header;
> +
> +       if (!cbmem_ref)
> +               return -ENODEV;

This is impossible.

> +
> +       header =3D memremap(cbmem_ref->cbmem_addr, sizeof(*header), MEMRE=
MAP_WB);
> +       if (!header) {
> +               pr_warn("coreboot: Failed to remap FMAP\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* Validate FMAP signature */
> +       if (memcmp(header->signature, FMAP_SIGNATURE,
> +                  sizeof(header->signature))) {
> +               pr_warn("coreboot: FMAP signature mismatch\n");
> +               memunmap(header);
> +               return -ENODEV;
> +       }
> +
> +       /* Validate FMAP version */
> +       if (header->ver_major !=3D FMAP_VER_MAJOR) {
> +               pr_warn("coreboot: FMAP version not supported\n");
> +               memunmap(header);
> +               return -ENODEV;
> +       }
> +
> +       pr_info("coreboot: Got valid FMAP v%u.%u for 0x%x byte ROM\n",
> +               header->ver_major, header->ver_minor, header->size);
> +
> +       fmap_size =3D sizeof(*header) + header->nareas * sizeof(struct fm=
ap_area);
> +       memunmap(header);
> +
> +       fmap =3D devm_memremap(&dev->dev, cbmem_ref->cbmem_addr, fmap_siz=
e,
> +                            MEMREMAP_WB);
> +       if (!fmap) {
> +               pr_warn("coreboot: Failed to remap FMAP\n");
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int fmap_remove(struct coreboot_device *dev)
> +{
> +       struct platform_device *pdev =3D dev_get_drvdata(&dev->dev);
> +
> +       platform_device_unregister(pdev);
> +
> +       return 0;
> +}
> +
> +static struct coreboot_driver fmap_driver =3D {
> +       .probe =3D fmap_probe,
> +       .remove =3D fmap_remove,
> +       .drv =3D {
> +               .name =3D "fmap",
> +       },
> +       .tag =3D CB_TAG_FMAP,
> +};
> +
> +static struct bin_attribute fmap_bin_attr =3D {
> +       .attr =3D {.name =3D "fmap", .mode =3D 0444},
> +       .read =3D fmap_read,
> +};
> +
> +static int __init coreboot_fmap_init(void)
> +{
> +       int err;
> +
> +       err =3D sysfs_create_bin_file(firmware_kobj, &fmap_bin_attr);
> +       if (err)
> +               return err;
> +
> +       return coreboot_driver_register(&fmap_driver);
> +}
> +
> +static void coreboot_fmap_exit(void)
> +{
> +       coreboot_driver_unregister(&fmap_driver);
> +       sysfs_remove_bin_file(firmware_kobj, &fmap_bin_attr);
> +}
> +
> +module_init(coreboot_fmap_init);
> +module_exit(coreboot_fmap_exit);
> +
> +MODULE_AUTHOR("9elements Agency GmbH");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/google/fmap-coreboot.h b/drivers/firmware/g=
oogle/fmap-coreboot.h
> new file mode 100644
> index 000000000000..7107a01af0e3
> --- /dev/null
> +++ b/drivers/firmware/google/fmap-coreboot.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * bootmedia-coreboot.h
> + *
> + * Copyright 2019 9elements Agency GmbH <patrick.rudolph@9elements.com>
> + */
> +
> +#ifndef __FMAP_COREBOOT_H
> +#define __FMAP_COREBOOT_H
> +
> +const char *coreboot_fmap_region_to_name(const u32 start, const u32 size=
);
> +
> +#endif /* __FMAP_COREBOOT_H */
> diff --git a/drivers/firmware/google/fmap_serialized.h b/drivers/firmware=
/google/fmap_serialized.h
> new file mode 100644
> index 000000000000..a001e47fa244
> --- /dev/null
> +++ b/drivers/firmware/google/fmap_serialized.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2010, Google Inc.
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *    * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *    * Redistributions in binary form must reproduce the above
> + * copyright notice, this list of conditions and the following disclaimer
> + * in the documentation and/or other materials provided with the
> + * distribution.
> + *    * Neither the name of Google Inc. nor the names of its
> + * contributors may be used to endorse or promote products derived from
> + * this software without specific prior written permission.
> + *
> + */
> +
> +#ifndef FLASHMAP_SERIALIZED_H__
> +#define FLASHMAP_SERIALIZED_H__
> +
> +#define FMAP_SIGNATURE         "__FMAP__"
> +#define FMAP_VER_MAJOR         1       /* this header's FMAP major versi=
on */
> +#define FMAP_VER_MINOR         1       /* this header's FMAP minor versi=
on */
> +#define FMAP_STRLEN            32      /* maximum length for strings,
> +                                        * including null-terminator
> +                                        */
> +
> +enum fmap_flags {
> +       FMAP_AREA_STATIC        =3D 1 << 0,
> +       FMAP_AREA_COMPRESSED    =3D 1 << 1,
> +       FMAP_AREA_RO            =3D 1 << 2,
> +       FMAP_AREA_PRESERVE      =3D 1 << 3,
> +};
> +
> +/* Mapping of volatile and static regions in firmware binary */
> +struct fmap_area {
> +       u32 offset;                /* offset relative to base */
> +       u32 size;                  /* size in bytes */
> +       u8  name[FMAP_STRLEN];     /* descriptive name */
> +       u16 flags;                 /* flags for this area */
> +} __packed;
> +
> +struct fmap {
> +       u8  signature[8];       /* "__FMAP__" (0x5F5F464D41505F5F) */
> +       u8  ver_major;          /* major version */
> +       u8  ver_minor;          /* minor version */
> +       u64 base;               /* address of the firmware binary */
> +       u32 size;               /* size of firmware binary in bytes */
> +       u8  name[FMAP_STRLEN];  /* name of this firmware binary */
> +       u16 nareas;             /* number of areas described by
> +                                * fmap_areas[] below
> +                                */
> +       struct fmap_area areas[];
> +} __packed;
> +
> +#endif /* FLASHMAP_SERIALIZED_H__ */
> --=20
> 2.21.0
>=20
