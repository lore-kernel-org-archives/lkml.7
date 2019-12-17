Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD0EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292B720733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJGVJp1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfLQHT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:19:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43750 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfLQHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:19:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so5674366pli.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 23:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=48Ydbr8QsQG9KegpsVTYP2CV3/61PSOu5sJsOTbGtG0=;
        b=WJGVJp1hkaRmFAUnfgB71DejuQdCgSiG8S483+7zXnuzn/nNPHvcUKyikbvnnQ232P
         K9mvZqwkuRF4Da653LYVkPn7fwtSVnof8mOzE4bdm7hkXmdOKKBuprWG4+ljYj0VXpXj
         mi7vcnwmeG4QUgz1FjRrnJrpB45UCRkIezltg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=48Ydbr8QsQG9KegpsVTYP2CV3/61PSOu5sJsOTbGtG0=;
        b=gPF6fg07OLejDdWWH3GybO3zZ8/71CD3xKFUwrt734wYLhbGi8WfFAsSHvC5G+sTG+
         WHCWOwLoyW6WXjNnM64dnl+Kk9GjvdzrN6iquiwXuuj4FVJ1sY5YKCRFdwgmAgewkWfl
         TQXD454ED8wImkH9e4iKg7XvzxLu4egW9HapxJw9aSX1mDK+TZ66Z+8rviONYIuJSd8K
         Qh1JKq5SzQPlNXU6UXUC9s79V3u/QwKhfyV77EQIiAnKdYRI7/IFcnL/Gx0OtH4pjmha
         4yLPAr7tSuz1fd57Vg2LyE/GXDqv4VVeIyqBHN+gj6+XdBiOdooa7BNsXbfMXJYLkrB6
         1F3Q==
X-Gm-Message-State: APjAAAUuQVe1pihkiSAwUiBfuKG1PZVuud0Zc9EVa4RkWDWSgRliXiJl
        ehfMl3gTdIzFC2bjYlKKu6riNg==
X-Google-Smtp-Source: APXvYqzGSHs3hx31NhWmjt7wEYs3MuSHxxTb2zqEt8ASVs0jEcZ5U1Q5i7eucD8Y68LzG+QuJ48hMA==
X-Received: by 2002:a17:90a:2521:: with SMTP id j30mr4243821pje.98.1576567167851;
        Mon, 16 Dec 2019 23:19:27 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d27sm25228074pgm.53.2019.12.16.23.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 23:19:27 -0800 (PST)
Message-ID: <5df8817f.1c69fb81.cdbb8.b15c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191128125100.14291-3-patrick.rudolph@9elements.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com> <20191128125100.14291-3-patrick.rudolph@9elements.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3 2/2] firmware: google: Expose coreboot tables over sysfs
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 23:19:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2019-11-28 04:50:51)
> diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/=
ABI/stable/sysfs-bus-coreboot
> index 1b04b8abc858..0f28601229f3 100644
> --- a/Documentation/ABI/stable/sysfs-bus-coreboot
> +++ b/Documentation/ABI/stable/sysfs-bus-coreboot
> @@ -41,3 +41,33 @@ Description:
>                 buffer.
>                 The file holds a read-only binary representation of the C=
BMEM
>                 buffer.
> +
> +What:          /sys/bus/coreboot/devices/.../attributes/id
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named attrib=
utes/id.
> +               The file holds an ASCII representation of the coreboot ta=
ble ID
> +               in hex (e.g. 0x000000ef). On coreboot enabled platforms t=
he ID is
> +               usually called TAG.

Why don't we call it 'tag' then?

> +
> +What:          /sys/bus/coreboot/devices/.../attributes/size
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               attributes/size.

Can we drop this first sentence in all the places? I don't see what
value it adds.

> +               The file holds an ASCII representation as decimal number =
of the
> +               coreboot table size (e.g. 64).
> +
> +What:          /sys/bus/coreboot/devices/.../attributes/data
> +Date:          Nov 2019
> +KernelVersion: 5.5
> +Contact:       Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +               coreboot device directory can contain a file named
> +               attributes/data.
> +               The file holds a read-only binary representation of the c=
oreboot
> +               table.

Maybe the attributes directory should be called 'table'? Given that
we're exposing the coreboot table contents directly to userspace?

> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/=
google/coreboot_table.c
> index 8d132e4f008a..1f7329d72f54 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -6,6 +6,7 @@
>   *
>   * Copyright 2017 Google Inc.
>   * Copyright 2017 Samuel Holland <samuel@sholland.org>
> + * Copyright 2019 9elements Agency GmbH
>   */
> =20
>  #include <linux/acpi.h>
> @@ -84,6 +85,60 @@ void coreboot_driver_unregister(struct coreboot_driver=
 *driver)
>  }
>  EXPORT_SYMBOL(coreboot_driver_unregister);
> =20
> +static ssize_t id_show(struct device *dev,
> +                      struct device_attribute *attr, char *buffer)
> +{
> +       struct coreboot_device *device =3D CB_DEV(dev);
> +
> +       return sprintf(buffer, "0x%08x\n", device->entry.tag);

Use %#08x instead?

> +}
> +
> +static ssize_t size_show(struct device *dev,
> +                        struct device_attribute *attr, char *buffer)
> +{
> +       struct coreboot_device *device =3D CB_DEV(dev);
> +
> +       return sprintf(buffer, "%u\n", device->entry.size);
> +}
> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(size);
> +
> +static struct attribute *cb_dev_attrs[] =3D {
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
> +       struct coreboot_device *device =3D CB_DEV(dev);
> +
> +       return memory_read_from_buffer(buffer, count, &offset,
> +                                      &device->entry, device->entry.size=
);
> +}
> +
> +static BIN_ATTR_RO(data, 0);

Can we fill in the size of the data at runtime somehow? Might require
making a different struct bin_attribute for each coreboot entry I
suppose but then we can probably leave out the 'size' attribute and only
have the 'data' and 'tag' attributes.

> +
> +static struct bin_attribute *cb_dev_bin_attrs[] =3D {
> +       &bin_attr_data,
> +       NULL
> +};
