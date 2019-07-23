Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF0DC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E93222387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DC+LOqW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfGWWY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:24:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52054 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbfGWWY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:24:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so39972951wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycFVF6PULvBjNz8AdZGy8PuycX5V7CruUR+NdGiRv3Q=;
        b=DC+LOqW8HDUKuSISwKU1Icnv77rhum8xl7oSHv3Etmp8OgvlsfFcSkiIFD8J5ZWIMu
         5jhLWpzhU8XD45oobipXrstgm+rc7D2uWwYo7PaHBE6LvGqtNqIY9UFQYceuzA2fKaXG
         zwvj7pba8f3EzPQ5XacRdbMFYlGruLImGXneDE1uYY0xzUMrWK+pK1GluZ+Kx0+UIELA
         wU2q+UDmt7+fAna0aWlXZVCjPhRevfvehGKzoWTvVFEi/b2nPZufwbLMAqoOLOt5w5FX
         Ysa6FonWr1E4bl7hCWxToBEKsG8WA9c/WBHKYQQYaOTMuwKLH+yN77J2plGBHgT2rWpD
         VrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycFVF6PULvBjNz8AdZGy8PuycX5V7CruUR+NdGiRv3Q=;
        b=getK7Gh874NHC7H7rr3HJzJpYZH7136jCoEjgjO/gxSd28bc97RQykf3TpVeZ+gSWM
         lsqKGEltdROXDOUodaVNmV3lieFi/1l39SIqpbYjLCdIXf5frZ8pAJn8tOag8Gr48Zks
         WSyejng6mvct7TkhnAlKCM7vVOSwXdtX2tREQL9de2zixmPVrOPaGHxvQi/BSuQe2R5J
         kiKzjaQ5cqttH+llqfGExdv7aXp2rZIbz+9CNACWNFU2luFckgsVjZt+xgXmx9VU2Ead
         /OnUW3ncH926zz8Si5ZtybkLvf2XW4ph+h1motoaYcb4YR5d53DTZNdMXSzEp1vJ3V84
         1jbA==
X-Gm-Message-State: APjAAAUcxXmA1piYwAmZXFabgDjjZPcwasqweqgZJNCdKzFj2B2PSCn7
        oU9dX2i7LO6P9JFQKXGe+glu51VUF7/z3o317uXW
X-Google-Smtp-Source: APXvYqx6QBr0zClP8sJ9l5lcsqVKECo/is0ATH/J+vN1rOqJqrCCcGSyjkIL9AVFxX/ijzj/vZLMWK5KeARcWMYO1o4=
X-Received: by 2002:a1c:a101:: with SMTP id k1mr72310390wme.98.1563920692824;
 Tue, 23 Jul 2019 15:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190723221838.12024-1-suzuki.poulose@arm.com> <20190723221838.12024-7-suzuki.poulose@arm.com>
In-Reply-To: <20190723221838.12024-7-suzuki.poulose@arm.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 23 Jul 2019 17:24:40 -0500
Message-ID: <CAErSpo5odia1KWnkADJ7NNbWKs5C1nRzZCiANfNrGQdNVVkP6g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drivers: Add generic helper to match any device
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Elie Morisse <syniurge@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 5:19 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Add a generic helper to match any/all devices. Using this
> introduce new wrappers {bus/driver/class}_find_next_device().
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Elie Morisse <syniurge@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # PCI

> ---
>  drivers/base/core.c                  |  6 ++++++
>  drivers/i2c/busses/i2c-amd-mp2-pci.c |  8 +-------
>  drivers/pci/probe.c                  |  7 +------
>  drivers/s390/cio/ccwgroup.c          |  8 +-------
>  drivers/scsi/scsi_proc.c             |  9 ++-------
>  include/linux/device.h               | 17 +++++++++++++++++
>  6 files changed, 28 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 57d71bc2c559..e22e29b3dc97 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3379,3 +3379,9 @@ int device_match_acpi_dev(struct device *dev, const void *adev)
>         return ACPI_COMPANION(dev) == adev;
>  }
>  EXPORT_SYMBOL(device_match_acpi_dev);
> +
> +int device_match_any(struct device *dev, const void *unused)
> +{
> +       return 1;
> +}
> +EXPORT_SYMBOL_GPL(device_match_any);
> diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
> index c7fe3b44a860..5e4800d72e00 100644
> --- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
> +++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
> @@ -457,18 +457,12 @@ static struct pci_driver amd_mp2_pci_driver = {
>  };
>  module_pci_driver(amd_mp2_pci_driver);
>
> -static int amd_mp2_device_match(struct device *dev, const void *data)
> -{
> -       return 1;
> -}
> -
>  struct amd_mp2_dev *amd_mp2_find_device(void)
>  {
>         struct device *dev;
>         struct pci_dev *pci_dev;
>
> -       dev = driver_find_device(&amd_mp2_pci_driver.driver, NULL, NULL,
> -                                amd_mp2_device_match);
> +       dev = driver_find_next_device(&amd_mp2_pci_driver.driver, NULL);
>         if (!dev)
>                 return NULL;
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3c7338fad86..dbeeb385fb9f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -64,11 +64,6 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
>         return &r->res;
>  }
>
> -static int find_anything(struct device *dev, const void *data)
> -{
> -       return 1;
> -}
> -
>  /*
>   * Some device drivers need know if PCI is initiated.
>   * Basically, we think PCI is not initiated when there
> @@ -79,7 +74,7 @@ int no_pci_devices(void)
>         struct device *dev;
>         int no_devices;
>
> -       dev = bus_find_device(&pci_bus_type, NULL, NULL, find_anything);
> +       dev = bus_find_next_device(&pci_bus_type, NULL);
>         no_devices = (dev == NULL);
>         put_device(dev);
>         return no_devices;
> diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
> index d843e362c167..0005ec9285aa 100644
> --- a/drivers/s390/cio/ccwgroup.c
> +++ b/drivers/s390/cio/ccwgroup.c
> @@ -581,11 +581,6 @@ int ccwgroup_driver_register(struct ccwgroup_driver *cdriver)
>  }
>  EXPORT_SYMBOL(ccwgroup_driver_register);
>
> -static int __ccwgroup_match_all(struct device *dev, const void *data)
> -{
> -       return 1;
> -}
> -
>  /**
>   * ccwgroup_driver_unregister() - deregister a ccw group driver
>   * @cdriver: driver to be deregistered
> @@ -597,8 +592,7 @@ void ccwgroup_driver_unregister(struct ccwgroup_driver *cdriver)
>         struct device *dev;
>
>         /* We don't want ccwgroup devices to live longer than their driver. */
> -       while ((dev = driver_find_device(&cdriver->driver, NULL, NULL,
> -                                        __ccwgroup_match_all))) {
> +       while ((dev = driver_find_next_device(&cdriver->driver, NULL))) {
>                 struct ccwgroup_device *gdev = to_ccwgroupdev(dev);
>
>                 ccwgroup_ungroup(gdev);
> diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
> index c074631086a4..5b313226f11c 100644
> --- a/drivers/scsi/scsi_proc.c
> +++ b/drivers/scsi/scsi_proc.c
> @@ -372,15 +372,10 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
>         return err;
>  }
>
> -static int always_match(struct device *dev, const void *data)
> -{
> -       return 1;
> -}
> -
>  static inline struct device *next_scsi_device(struct device *start)
>  {
> -       struct device *next = bus_find_device(&scsi_bus_type, start, NULL,
> -                                             always_match);
> +       struct device *next = bus_find_next_device(&scsi_bus_type, start);
> +
>         put_device(start);
>         return next;
>  }
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7514ef3d3f1a..8ae3f4b47293 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -169,6 +169,7 @@ int device_match_of_node(struct device *dev, const void *np);
>  int device_match_fwnode(struct device *dev, const void *fwnode);
>  int device_match_devt(struct device *dev, const void *pdevt);
>  int device_match_acpi_dev(struct device *dev, const void *adev);
> +int device_match_any(struct device *dev, const void *unused);
>
>  int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
>                      int (*fn)(struct device *dev, void *data));
> @@ -225,6 +226,16 @@ static inline struct device *bus_find_device_by_devt(struct bus_type *bus,
>         return bus_find_device(bus, NULL, &devt, device_match_devt);
>  }
>
> +/**
> + * bus_find_next_device - Find the next device after a given device in a
> + * given bus.
> + */
> +static inline struct device *
> +bus_find_next_device(struct bus_type *bus,struct device *cur)
> +{
> +       return bus_find_device(bus, cur, NULL, device_match_any);
> +}
> +
>  #ifdef CONFIG_ACPI
>  struct acpi_device;
>
> @@ -465,6 +476,12 @@ static inline struct device *driver_find_device_by_devt(struct device_driver *dr
>         return driver_find_device(drv, NULL, &devt, device_match_devt);
>  }
>
> +static inline struct device *driver_find_next_device(struct device_driver *drv,
> +                                                    struct device *start)
> +{
> +       return driver_find_device(drv, start, NULL, device_match_any);
> +}
> +
>  #ifdef CONFIG_ACPI
>  /**
>   * driver_find_device_by_acpi_dev : device iterator for locating a particular
> --
> 2.21.0
>
