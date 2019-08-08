Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6639C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6214C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToWlY0+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfHHCFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:05:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46211 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfHHCFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:05:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id c3so20007695pfa.13;
        Wed, 07 Aug 2019 19:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S52KechwZrFMygWXl5D5kWJUlVWI9YjJM3R9E3PaHiU=;
        b=ToWlY0+Xr7O9r1Dro39ViLUZ61LmBXhuwPVIcPlYGqrNa1xbwq488NHxRm0WRNaPFX
         kveaGTSQEcZ93m300vqfrmQP3mQrf/Pv6B02wfFdIU/8AOmQurKmOFC8aA11iZ5IKHMA
         7HZv4aunK5LkGFKqTiJg/TBcVDQXITPHHD80zl46IlwFET/0mbhpksWwmfFtwXzC0VUS
         45RMOMR4uFz8xx72WYSGsNl72VugFPMUP60OTisFpYwH5xGYjNB2dytzOD7wMQTymgP/
         c0ipt8vSoNhAuqV6yHI/arhzRyeDFN9WTDd8ELZaCSfY+FS59EubyHggsCearz+wM4iB
         GNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S52KechwZrFMygWXl5D5kWJUlVWI9YjJM3R9E3PaHiU=;
        b=uM0JTwsPlQNtO2LkTEQEXVmduxj/2VhObaQjIHxFNZ53yI22lmAShNDI0HkoWXtEsO
         6UuCjwOpfFUL4fgj5DQD0hGnuO2Xa/ZEMlIaFkWiCNN3tn9Inuz1RP+VbAA8nuKS1B6G
         hoxAnatWgilMhWifNWRnUAX3inC+tRKOkw5Roc4VQL4ZNrcpFDwcCCHKKnS52Vm7lHEj
         JO8/2tVyLKLnSHrBYuu7rEwf56bsREuDrT9e08titxU5qhY5RHvLNIakuOb1NVatISMN
         DOWZOIZ6aINf0Tb6p/Ey/KKO6mbePaEX2aHhdkM487TeqMGjHC34n19JyuF5TwhVOUN2
         jnEw==
X-Gm-Message-State: APjAAAWZFmPFkzSAsMwZXxP+9ou1Z9ZwC9Bae7WSpSBES+w8rajoB+v2
        opC2tOJFtZ0S3xce5FOtZ0I=
X-Google-Smtp-Source: APXvYqzGF+EWRK3qgDhprqAfzqu9BKxZqPVMxOrGqvg8VrnkJ2l4UI0qyhpgQG0ouLaDvacPYFRO8Q==
X-Received: by 2002:a62:1b0c:: with SMTP id b12mr12451729pfb.17.1565229912831;
        Wed, 07 Aug 2019 19:05:12 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id n5sm98259369pfn.38.2019.08.07.19.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 19:05:12 -0700 (PDT)
Subject: Re: [PATCH v7 2/7] driver core: Add edit_links() callback for drivers
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-3-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c8e2ee8d-f005-379a-8c9a-415d8f6eeba3@gmail.com>
Date:   Wed, 7 Aug 2019 19:05:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724001100.133423-3-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 23 Jul 2019 17:10:55 -0700
> Subject: [PATCH v7 2/7] driver core: Add edit_links() callback for drivers
> From: Saravana Kannan <saravanak@google.com>
> 
> The driver core/bus adding supplier-consumer dependencies by default

> enables functional dependencies to be tracked correctly even when the
> consumer devices haven't had their drivers registered or loaded (if they
> are modules).

  enables functional dependencies to be tracked correctly before the
  consumer device drivers are registered or loaded (if they are modules).

> 
> However, when the bus incorrectly adds dependencies that it shouldn't

                    ^^^ driver core/bus

> have added, the devices might never probe.

Explain what causes a  dependency to be incorrectly added.

Is this a bug in the dependency detection code?

Are there cases where the dependency detection code can not reliably determine
whether there truly is a dependency?

> 
> For example, if device-C is a consumer of device-S and they have
> phandles to each other in DT, the following could happen:
> 
> 1.  Device-S get added first.
> 2.  The bus add_links() callback will (incorrectly) try to link it as
>     a consumer of device-C.
> 3.  Since device-C isn't present, device-S will be put in
>     "waiting-for-supplier" list.
> 4.  Device-C gets added next.
> 5.  All devices in "waiting-for-supplier" list are retried for linking.
> 6.  Device-S gets linked as consumer to Device-C.
> 7.  The bus add_links() callback will (correctly) try to link it as
>     a consumer of device-S.
> 8.  This isn't allowed because it would create a cyclic device links.
> 
> Neither devices will get probed since the supplier is marked as
> dependent on the consumer. And the consumer will never probe because the
> consumer can't get resources from the supplier.
> 
> Without this patch, things stay in this broken state. However, with this
> patch, the execution will continue like this:
> 
> 9.  Device-C's driver is loaded.

Change comment to:
  
  For example, if device-C is a consumer of device-S and they have phandles
  referencing each other in the devicetree, the following could happen:

  1.  Device-S is added first.
        - The bus add_links() callback will (incorrectly) link device-S
          as a consumer of device-C, and device-S will be put in the
          "wait_for_suppliers" list.

  2.  Device-C is added next.
        - All devices in the "wait_for_suppliers" list are retried for linking.
        - Device-S remains linked as a consumer to device-C.
        - The bus add_links() callback will (correctly) try to link device-C as
          a consumer of device-S.
        - The link attempt will fail because it would create a cyclic device
          link, and device-C will be put in the "wait_for_suppliers" list.

  Device-S will not be probed because it is in the "wait_for_suppliers" list.
  Device-C will not be probed because it is in the "wait_for_suppliers" list.
  
> 
> Without this patch, things stay in this broken state. However, with this
> patch, the execution will continue like this:
> 
> 9.  Device-C's driver is loaded.

What is "loaded"?  Does that mean the device-C probe succeeds?

What causes device-C to be probed?  The normal processing of -EPROBE_DEFER
devices?


> 10. Device-C's driver removes Device-S as a consumer of Device-C.
> 11. Device-C's driver adds Device-C as a consumer of Device-S.
> 12. Device-S probes.
> 14. Device-C probes.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 24 ++++++++++++++++++++++--
>  drivers/base/dd.c      | 29 +++++++++++++++++++++++++++++
>  include/linux/device.h | 18 ++++++++++++++++++
>  3 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1b4eb221968f..733d8a9aec76 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -422,6 +422,19 @@ static void device_link_wait_for_supplier(struct device *consumer)
>  	mutex_unlock(&wfs_lock);
>  }
>  
> +/**
> + * device_link_remove_from_wfs - Unmark device as waiting for supplier
> + * @consumer: Consumer device
> + *
> + * Unmark the consumer device as waiting for suppliers to become available.
> + */
> +void device_link_remove_from_wfs(struct device *consumer)

Misleading function name.
Incorrect description.

Does not remove consumer from list wait_for_suppliers.

At best, consumer might eventually get removed from list wait_for_suppliers
if device_link_check_waiting_consumers() is called again.

> +{
> +	mutex_lock(&wfs_lock);
> +	list_del_init(&consumer->links.needs_suppliers);
> +	mutex_unlock(&wfs_lock);
> +}
> +
>  /**
>   * device_link_check_waiting_consumers - Try to unmark waiting consumers
>   *
> @@ -439,12 +452,19 @@ static void device_link_wait_for_supplier(struct device *consumer)
>  static void device_link_check_waiting_consumers(void)
>  {
>  	struct device *dev, *tmp;
> +	int ret;
>  
>  	mutex_lock(&wfs_lock);
>  	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
> -				 links.needs_suppliers)
> -		if (!dev->bus->add_links(dev))
> +				 links.needs_suppliers) {
> +		ret = 0;
> +		if (dev->has_edit_links)
> +			ret = driver_edit_links(dev);
> +		else if (dev->bus->add_links)
> +			ret = dev->bus->add_links(dev);
> +		if (!ret)
>  			list_del_init(&dev->links.needs_suppliers);
> +	}
>  	mutex_unlock(&wfs_lock);
>  }
>  
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 994a90747420..5e7041ede0d7 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -698,6 +698,12 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>  		 drv->bus->name, __func__, dev_name(dev), drv->name);
>  
> +	if (drv->edit_links) {
> +		if (drv->edit_links(dev))
> +			dev->has_edit_links = true;
> +		else
> +			device_link_remove_from_wfs(dev);
> +	}

For the purposes of the following paragraphs, I refer to dev as "dev_1" to
distinguish it from a new dev that will be encountered later.  The following
paragraphs assume dev_1 has a supplier dependency for a supplier that has
not probed yet.

Q. Why the extra level of indirection?

A. really_probe() does not set dev->driver before returning if
   device_links_check_suppliers() returned -EPROBE_DEFER.  Thus
   device_link_check_waiting_consumers() can not directly check
   "if (dev_1->driver->edit_links)".

   The added driver_probe_device() code is setting dev_1->has_edit_links in the
   probe path, then device_link_check_waiting_consumers() will use the value
   of dev_1->has_edit_links instead of directly checking
   "if (dev_1->driver->edit_links)".

   If really_probe() was modified to set dev->driver in this
   case then the need for dev->has_edit_links is removed and
   driver_edit_links() is not needed, since dev->driver would
   be available.  Removing driver_edit_links() simplifies the
   code.

device_add() calls dev_1->bus->add_links(dev_1), thus dev_1 will have the
supplier links set (for any suppliers not currently available) and be on
list wait_for_suppliers.

Then device_add() calls bus_probe_device(), leading to calling
driver_probe_device().  The above code fragment either sets
dev_1->has_edit_links or removes the needs_suppliers links from dev_1.
dev_1 remains on list wait_for_suppliers.

If (drv->edit_links(dev_1) returns 0 then device_link_remove_from_wfs()
removes the supplier links.  Shouldn't device_link_remove_from_wfs()  also
remove the device from the list wait_for_suppliers?

The next time a device is added, device_link_check_waiting_consumers() will
be called and dev_1 will be on list wait_for_suppliers, thus
device_link_check_waiting_consumers() will find dev_1->has_edit_links true
and thus call driver_edit_links() instead of calling dev->bus->add_links().

The comment in device.h, later in this patch, says that drv->edit_links() is
responsible for editing the device links for dev.  The comment provides no
guidance on how drv->edit_links() is supposed to determine what edits to
perform.  No example drv->edit_links() function is provided in this patch
series.  dev_1->bus->add_links(dev_1) may have added one or more suppliers
to its needs_suppliers link.  drv->edit_links() needs to be able to handle
all possible variants of what suppliers are on the needs_suppliers link.


>  	pm_runtime_get_suppliers(dev);
>  	if (dev->parent)
>  		pm_runtime_get_sync(dev->parent);
> @@ -786,6 +792,29 @@ struct device_attach_data {
>  	bool have_async;
>  };
>  
> +static int __driver_edit_links(struct device_driver *drv, void *data)
> +{
> +	struct device *dev = data;
> +
> +	if (!drv->edit_links)
> +		return 0;
> +
> +	if (driver_match_device(drv, dev) <= 0)
> +		return 0;
> +
> +	return drv->edit_links(dev);
> +}
> +
> +int driver_edit_links(struct device *dev)
> +{
> +	int ret;
> +
> +	device_lock(dev);
> +	ret = bus_for_each_drv(dev->bus, NULL, dev, __driver_edit_links);
> +	device_unlock(dev);
> +	return ret;
> +}
> +
>  static int __device_attach_driver(struct device_driver *drv, void *_data)
>  {
>  	struct device_attach_data *data = _data;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 5d70babb7462..35aed50033c4 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -263,6 +263,20 @@ enum probe_type {
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
>   * @of_match_table: The open firmware table.
>   * @acpi_match_table: The ACPI match table.
> + * @edit_links:	Called to allow a matched driver to edit the device links the

Where is the value of field edit_links set?

Is it only in an out of tree driver?  If so, I would like to see an
example implementation of the edit_links() function.


> + *		bus might have added incorrectly. This will be useful to handle
> + *		cases where the bus incorrectly adds functional dependencies
> + *		that aren't true or tries to create cyclic dependencies. But
> + *		doesn't correctly handle functional dependencies that are
> + *		missed by the bus as the supplier's sync_state might get to
> + *		execute before the driver for a missing consumer is loaded and
> + *		gets to edit the device links for the consumer.
> + *
> + *		This function might be called multiple times after a new device
> + *		is added.  The function is expected to create all the device
> + *		links for the new device and return 0 if it was completed
> + *		successfully or return an error if it needs to be reattempted
> + *		in the future.
>   * @probe:	Called to query the existence of a specific device,
>   *		whether this driver can work with it, and bind the driver
>   *		to a specific device.
> @@ -302,6 +316,7 @@ struct device_driver {
>  	const struct of_device_id	*of_match_table;
>  	const struct acpi_device_id	*acpi_match_table;
>  
> +	int (*edit_links)(struct device *dev);
>  	int (*probe) (struct device *dev);
>  	int (*remove) (struct device *dev);
>  	void (*shutdown) (struct device *dev);
> @@ -1078,6 +1093,7 @@ struct device {
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> +	bool			has_edit_links:1;

Add has_edit_links to the struct's kernel_doc


>  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> @@ -1329,6 +1345,7 @@ extern int  __must_check device_attach(struct device *dev);
>  extern int __must_check driver_attach(struct device_driver *drv);
>  extern void device_initial_probe(struct device *dev);
>  extern int __must_check device_reprobe(struct device *dev);
> +extern int driver_edit_links(struct device *dev);
>  
>  extern bool device_is_bound(struct device *dev);
>  
> @@ -1419,6 +1436,7 @@ struct device_link *device_link_add(struct device *consumer,
>  				    struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
>  void device_link_remove(void *consumer, struct device *supplier);
> +void device_link_remove_from_wfs(struct device *consumer);
>  
>  #ifndef dev_fmt
>  #define dev_fmt(fmt) fmt
> -- 
> 2.22.0.709.g102302147b-goog
> 
> 
