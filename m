Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E9620716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bMHnoivk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLTHU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:20:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40020 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfLTHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:20:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so8080977wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 23:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=avWv5+NSiZKD+yREDtAVwFIGk9ypvPhyDceSwXxt+kg=;
        b=bMHnoivk+qaYjwJcV8/cVHaCESPm2s3Dttk3p3EicAQ56y23gcZHCz3EpDygr3Hn8g
         5eovAaD/J4mxweyu1l2AvZE0Yl7mg723YDPqZijg0U5H247SxipjpKCSWDBcDqYoU1Oo
         911dSEMsLE4c9Y4ASiCQHc7Dbm0SCQ7fnjBDw8plgWcq0DLRS+U4YQCU/Tc8ty55q7xS
         1TuRX2Ze2yPObH2enJffLuyopEh/USNTp9j6NYrcH1FIPK2HBpgrNROjJgg9oVZu7nZt
         g4CQQH7BZLfIcKMZCdrPAUtq7jv0fCFVeWwJzWIOKhl7l22sovbN9vKUYh6Lp1V3ntbA
         NG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=avWv5+NSiZKD+yREDtAVwFIGk9ypvPhyDceSwXxt+kg=;
        b=jKEEW2BCl3mVA2N0n1AhNu66lvYdiAOLQoURP08MlEeqftAAES3TY4yNkqn/IyMhoI
         me7HlmIIZWKAY8JbX3mHXR2UAvcvwm/qDzcPBZruH4CbolMnhxqDK/7JrCmaaS7QLjj5
         L98sRo252cww5wsIoeiF0tZphqJnbTcv5uc4q3QlH8jGeleFN0xJmPKd45OiporMTH67
         idvXFCLLC+CSv7nbXR4ghESRZUzbgJGFjc+8XpnNOvW4l8UYvtcR8DO/A+DnK8b3xcy9
         HSNBfq4VngdFBriJ7zehMec2lXivmSIo87BMqqXW4SpdvT6Tv+0avExjASGuHUSW6Ai9
         zQXw==
X-Gm-Message-State: APjAAAU/ULLEd3w3I7uFbMnOireD+S6djRVQa7rW/boa9iqVrLD1lhoS
        r4aTosxN0TxIpsQSujLlitEPHW3fM8GIag==
X-Google-Smtp-Source: APXvYqzp9eujWP8nSbD7ogQl0QiU6Ckjd6x72wi7e5VA6Kl8aI+u/0gour8oMzMPs6Zi7ZtafXbwLw==
X-Received: by 2002:a1c:5a0a:: with SMTP id o10mr14059374wmb.114.1576826425449;
        Thu, 19 Dec 2019 23:20:25 -0800 (PST)
Received: from rudolphp (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id q6sm9428341wrx.72.2019.12.19.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 23:20:24 -0800 (PST)
Message-ID: <b54daf34efd5866f4bb895511caa56599864bcf8.camel@9elements.com>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
From:   patrick.rudolph@9elements.com
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Date:   Fri, 20 Dec 2019 08:20:23 +0100
In-Reply-To: <5df885f8.1c69fb81.13dda.20bb@mx.google.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
         <20191128125100.14291-2-patrick.rudolph@9elements.com>
         <5df885f8.1c69fb81.13dda.20bb@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 23:38 -0800, Stephen Boyd wrote:
> Quoting patrick.rudolph@9elements.com (2019-11-28 04:50:50)
> > diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot
> > b/Documentation/ABI/stable/sysfs-bus-coreboot
> > new file mode 100644
> > index 000000000000..1b04b8abc858
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-bus-coreboot
> > @@ -0,0 +1,43 @@
> > +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/id
> > +Date:          Nov 2019
> > +KernelVersion: 5.5
> > +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> > +Description:
> > +               coreboot device directory can contain a file named
> > +               cbmem_attributes/id if the device corresponds to a
> > CBMEM
> > +               buffer.
> > +               The file holds an ASCII representation of the CBMEM
> > ID in hex
> > +               (e.g. 0xdeadbeef).
> > +
> > +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/size
> > +Date:          Nov 2019
> > +KernelVersion: 5.5
> > +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> > +Description:
> > +               coreboot device directory can contain a file named
> > +               cbmem_attributes/size if the device corresponds to
> > a CBMEM
> > +               buffer.
> > +               The file holds an representation as decimal number
> > of the
> > +               CBMEM buffer size (e.g. 64).
> > +
> > +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/addr
> > ess
> > +Date:          Nov 2019
> > +KernelVersion: 5.5
> > +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> > +Description:
> > +               coreboot device directory can contain a file named
> > +               cbmem_attributes/address if the device corresponds
> > to a CBMEM
> > +               buffer.
> > +               The file holds an ASCII representation of the
> > physical address
> > +               of the CBMEM buffer in hex (e.g.
> > 0x000000008000d000).
> 
> What is the purpose of this field? Can't userspace read the 'data'
> attribute to get the data out?

It's the linear address of the CBMEM buffer. It's more for debugging
purposes and could be matched with entries from the coreboot tables.
The 'data' field only returns the data itself, but says nothing about the
address stored. I'll update the documentation.

> 
> > +
> > +What:          /sys/bus/coreboot/devices/.../cbmem_attributes/data
> > +Date:          Nov 2019
> > +KernelVersion: 5.5
> > +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> > +Description:
> > +               coreboot device directory can contain a file named
> > +               cbmem_attributes/data if the device corresponds to
> > a CBMEM
> > +               buffer.
> > +               The file holds a read-only binary representation of
> > the CBMEM
> > +               buffer.
> > diff --git a/drivers/firmware/google/cbmem-coreboot.c
> > b/drivers/firmware/google/cbmem-coreboot.c
> > new file mode 100644
> > index 000000000000..c67651a9c287
> > --- /dev/null
> > +++ b/drivers/firmware/google/cbmem-coreboot.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * fmap-coreboot.c
> > + *
> > + * Exports CBMEM as attributes in sysfs.
> > + *
> > + * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> > + * Copyright 2017 Google Inc.
> > + * Copyright 2019 9elements Agency GmbH
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +#include <linux/module.h>
> > +#include <linux/io.h>
> 
> Is this include used? Should probably include linux/memremap.h
> instead.
> 
> > +#include <linux/slab.h>
> > +
> > +#include "coreboot_table.h"
> > +
> > +#define CB_TAG_CBMEM_ENTRY 0x31
> > +
> > +struct cb_priv {
> > +       void *remap;
> > +       struct lb_cbmem_entry entry;
> > +};
> > +
> > +static ssize_t id_show(struct device *dev,
> > +                      struct device_attribute *attr, char *buffer)
> > +{
> > +       const struct cb_priv *priv;
> > +
> > +       priv = (const struct cb_priv *)dev_get_platdata(dev);
> 
> Please drop useless casts from void *.
> 
> > +
> > +       return sprintf(buffer, "0x%08x\n", priv->entry.id);
> 
> Use %#08x. Also not sure we need newlines but I guess it's OK.
> 
> > +}
> > +
> > +static ssize_t size_show(struct device *dev,
> > +                        struct device_attribute *attr, char
> > *buffer)
> > +{
> > +       const struct cb_priv *priv;
> > +
> > +       priv = (const struct cb_priv *)dev_get_platdata(dev);
> > +
> > +       return sprintf(buffer, "%u\n", priv->entry.size);
> > +}
> > +
> > +static ssize_t address_show(struct device *dev,
> > +                           struct device_attribute *attr, char
> > *buffer)
> > +{
> > +       const struct cb_priv *priv;
> > +
> > +       priv = (const struct cb_priv *)dev_get_platdata(dev);
> > +
> > +       return sprintf(buffer, "0x%016llx\n", priv->entry.address);
> > +}
> > +
> > +static DEVICE_ATTR_RO(id);
> > +static DEVICE_ATTR_RO(size);
> > +static DEVICE_ATTR_RO(address);
> > +
> > +static struct attribute *cb_mem_attrs[] = {
> > +       &dev_attr_address.attr,
> > +       &dev_attr_id.attr,
> > +       &dev_attr_size.attr,
> > +       NULL
> > +};
> > +
> > +static ssize_t data_read(struct file *filp, struct kobject *kobj,
> > +                        struct bin_attribute *bin_attr,
> > +                        char *buffer, loff_t offset, size_t count)
> > +{
> > +       struct device *dev = kobj_to_dev(kobj);
> > +       const struct cb_priv *priv;
> > +
> > +       priv = (const struct cb_priv *)dev_get_platdata(dev);
> > +
> > +       return memory_read_from_buffer(buffer, count, &offset,
> > +                                      priv->remap, priv-
> > >entry.size);
> > +}
> > +
> > +static BIN_ATTR_RO(data, 0);
> > +
> > +static struct bin_attribute *cb_mem_bin_attrs[] = {
> > +       &bin_attr_data,
> > +       NULL
> > +};
> > +
> > +static struct attribute_group cb_mem_attr_group = {
> 
> Can it be const?
> 
> > +       .name = "cbmem_attributes",
> > +       .attrs = cb_mem_attrs,
> > +       .bin_attrs = cb_mem_bin_attrs,
> > +};
> > +
> > +static int cbmem_probe(struct coreboot_device *cdev)
> > +{
> > +       struct device *dev = &cdev->dev;
> > +       struct cb_priv *priv;
> > +       int err;
> > +
> > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv-
> > >entry));
> > +
> > +       priv->remap = memremap(priv->entry.address,
> > +                              priv->entry.entry_size,
> > MEMREMAP_WB);
> > +       if (!priv->remap) {
> > +               err = -ENOMEM;
> > +               goto failure;
> > +       }
> > +
> > +       err = sysfs_create_group(&dev->kobj, &cb_mem_attr_group);
> > +       if (err) {
> > +               dev_err(dev, "failed to create sysfs attributes:
> > %d\n", err);
> > +               memunmap(priv->remap);
> > +               goto failure;
> > +       }
> > +
> > +       dev->platform_data = priv;
> 
> Can we use dev_{set,get}_drvdata() instead?
> 
> > +
> > +       return 0;
> > +failure:
> > +       kfree(priv);
> > +       return err;
> > +}
> > +
> > +static int cbmem_remove(struct coreboot_device *cdev)
> > +{
> > +       struct device *dev = &cdev->dev;
> > +       const struct cb_priv *priv;
> > +
> > +       priv = (const struct cb_priv *)dev_get_platdata(dev);
> > +
> > +       sysfs_remove_group(&dev->kobj, &cb_mem_attr_group);
> > +
> > +       if (priv)
> > +               memunmap(priv->remap);
> > +       kfree(priv);
> > +
> > +       dev->platform_data = NULL;
> 
> This shouldn't be necessary if the driver_data APIs are used instead.
> The driver core does it for us then.
> 
> > +
> > +       return 0;
> > +}
> > +
> > +static struct coreboot_driver cbmem_driver = {
> > +       .probe = cbmem_probe,
> > +       .remove = cbmem_remove,
> > +       .drv = {
> > +               .name = "cbmem",
> > +       },
> > +       .tag = CB_TAG_CBMEM_ENTRY,
> > +};
> > +
> > +module_coreboot_driver(cbmem_driver);
> > +
> > +MODULE_AUTHOR("9elements Agency GmbH");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/firmware/google/coreboot_table.h
> > b/drivers/firmware/google/coreboot_table.h
> > index 7b7b4a6eedda..506048c724d8 100644
> > --- a/drivers/firmware/google/coreboot_table.h
> > +++ b/drivers/firmware/google/coreboot_table.h
> > @@ -59,6 +59,18 @@ struct lb_framebuffer {
> >         u8  reserved_mask_size;
> >  };
> >  
> > +/* There can be more than one of these records as there is one per
> > cbmem entry.
> 
> Please add a bare /* for multi-line comments.
> 
> > + * Describes a buffer in memory containing runtime data.
> > + */
> > +struct lb_cbmem_entry {
> > +       u32 tag;
> > +       u32 size;
> > +
> > +       u64 address;
> > +       u32 entry_size;
> > +       u32 id;
> > +};
> > +
> >  /* A device, additionally with information from coreboot. */
> >  struct coreboot_device {
> >         struct device dev;

Will send a new patch-set with the requested changes.

