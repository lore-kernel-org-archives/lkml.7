Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BAFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9FC2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570536203;
	bh=lm5veWGc0jEbQxQoNUj/SkbpvxyqzrLa9+eoHuHx8p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iNXMNi64ztwLMEZwq2xPYBwCXQeCgDe7+Vnf/rl5/NCPt697yizxoHECnzvuylyY4
	 Peh/Ic+lWI4WYEajVSFbPm0Gc8Azv+72YZdoqSOACm4e7KzHHg+maL2h/EMMn3hHZ7
	 RaHldshqgp8x+gLrb670hZoPJe6OBSPTgc2Pj8v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfJHMDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbfJHMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:03:22 -0400
Received: from localhost (92-111-67-33.static.v4.ziggozakelijk.nl [92.111.67.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794DA206C2;
        Tue,  8 Oct 2019 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570536201;
        bh=lm5veWGc0jEbQxQoNUj/SkbpvxyqzrLa9+eoHuHx8p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hi22GS4rRiYKX77jF6mcqrHIDmxnbVAXypDsiqmD+jd75QZzoUjt6BzrO/UsR4Ozo
         Xcz3wn1ToOuG59rt101VKEux268jHk6QCGCMBsD225XFdyrL8H0vXESBz/dD48XTrt
         ujM3/x+Wm/NCm83pdfOkx1ma10vRaTB+E+6AyXnA=
Date:   Tue, 8 Oct 2019 14:03:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org,
        Filipe Brandenburger <filbranden@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/2] firmware: coreboot: Export the binary FMAP
Message-ID: <20191008120317.GA2761030@kroah.com>
References: <20191008115342.28483-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008115342.28483-1-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:53:25PM +0200, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Expose coreboot's binary FMAP[1] to /sys/firmware/fmap.
> 
> coreboot copies the FMAP to a CBMEM buffer at boot since CB:35377[2],
> allowing an architecture independ way of exposing the FMAP to userspace.
> 
> Will be used by fwupd[3] to determine the current firmware layout.
> 
> [1]: https://doc.coreboot.org/lib/flashmap.html
> [2]: https://review.coreboot.org/c/coreboot/+/35377
> [3]: https://fwupd.org/
> 
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
> 
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index a3a6ca659ffa..5fbbd7b8fef6 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -74,4 +74,12 @@ config GOOGLE_VPD
>  	  This option enables the kernel to expose the content of Google VPD
>  	  under /sys/firmware/vpd.
>  
> +config GOOGLE_FMAP
> +	tristate "Coreboot FMAP access"
> +	depends on GOOGLE_COREBOOT_TABLE
> +	help
> +	  This option enables the kernel to search for a Google FMAP in
> +	  the coreboot table.  If found, this binary file is exported to userland
> +	  in the file /sys/firmware/fmap.
> +
>  endif # GOOGLE_FIRMWARE
> diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
> index d17caded5d88..6d31fe167700 100644
> --- a/drivers/firmware/google/Makefile
> +++ b/drivers/firmware/google/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
> +obj-$(CONFIG_GOOGLE_FMAP)                  += fmap-coreboot.o
>  
>  vpd-sysfs-y := vpd.o vpd_decode.o
>  obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
> diff --git a/drivers/firmware/google/fmap-coreboot.c b/drivers/firmware/google/fmap-coreboot.c
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
> +	const char *name = NULL;
> +	struct fmap *iter;
> +	u32 size_old = ~0;
> +	int i;
> +
> +	iter = fmap;
> +	/* Find smallest containing region */
> +	for (i = 0; i < iter->nareas && fmap; i++) {
> +		if (iter->areas[i].offset <= start &&
> +		    iter->areas[i].size >= size &&
> +		    iter->areas[i].size <= size_old) {
> +			size_old = iter->areas[i].size;
> +			name = iter->areas[i].name;
> +		}
> +	}
> +
> +	if (name)
> +		return kstrdup(name, GFP_KERNEL);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(coreboot_fmap_region_to_name);
> +
> +static ssize_t fmap_read(struct file *filp, struct kobject *kobp,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t pos, size_t count)
> +{
> +	if (!fmap)
> +		return -ENODEV;
> +
> +	return memory_read_from_buffer(buf, count, &pos, fmap, fmap_size);
> +}
> +
> +static int fmap_probe(struct coreboot_device *dev)
> +{
> +	struct lb_cbmem_ref *cbmem_ref = &dev->cbmem_ref;
> +	struct fmap *header;
> +
> +	if (!cbmem_ref)
> +		return -ENODEV;
> +
> +	header = memremap(cbmem_ref->cbmem_addr, sizeof(*header), MEMREMAP_WB);
> +	if (!header) {
> +		pr_warn("coreboot: Failed to remap FMAP\n");

Doesn't memremap print an error if it fails?

> +		return -ENOMEM;
> +	}
> +
> +	/* Validate FMAP signature */
> +	if (memcmp(header->signature, FMAP_SIGNATURE,
> +		   sizeof(header->signature))) {
> +		pr_warn("coreboot: FMAP signature mismatch\n");

How can this happen?  Shouldn't it be an error?

> +		memunmap(header);
> +		return -ENODEV;
> +	}
> +
> +	/* Validate FMAP version */
> +	if (header->ver_major != FMAP_VER_MAJOR) {
> +		pr_warn("coreboot: FMAP version not supported\n");

error?

And why are these not dev_err() and friends?

> +		memunmap(header);
> +		return -ENODEV;
> +	}
> +
> +	pr_info("coreboot: Got valid FMAP v%u.%u for 0x%x byte ROM\n",
> +		header->ver_major, header->ver_minor, header->size);

Do not be noisy if all goes well.  This should be debugging only.


> +
> +	fmap_size = sizeof(*header) + header->nareas * sizeof(struct fmap_area);
> +	memunmap(header);
> +
> +	fmap = devm_memremap(&dev->dev, cbmem_ref->cbmem_addr, fmap_size,
> +			     MEMREMAP_WB);
> +	if (!fmap) {
> +		pr_warn("coreboot: Failed to remap FMAP\n");

Same here as above.

> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fmap_remove(struct coreboot_device *dev)
> +{
> +	struct platform_device *pdev = dev_get_drvdata(&dev->dev);
> +
> +	platform_device_unregister(pdev);
> +
> +	return 0;
> +}
> +
> +static struct coreboot_driver fmap_driver = {
> +	.probe = fmap_probe,
> +	.remove = fmap_remove,
> +	.drv = {
> +		.name = "fmap",
> +	},
> +	.tag = CB_TAG_FMAP,
> +};
> +
> +static struct bin_attribute fmap_bin_attr = {
> +	.attr = {.name = "fmap", .mode = 0444},
> +	.read = fmap_read,
> +};

BIN_ATTR_RO()?

And you forgot the Documentation/ABI/ update for your new sysfs file :(

I'm guessing all of these same issues are in your 2/2 patch, so I'll let
you fix them up and resend the series.

thanks,

greg k-h
