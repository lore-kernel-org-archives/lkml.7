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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB68C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C420B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 02:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS/EPTHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfHHCEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 22:04:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44728 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730718AbfHHCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 22:04:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so43155628pgl.11;
        Wed, 07 Aug 2019 19:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXjl4n1lvArgo8cX2i6yOg0JMkmYiPzAP2ZnE6PFHhk=;
        b=XS/EPTHLRF9QzxHbrgdwgYUij0c849qMlRxKc3h6/WsDbmrHk/+VVNyP4yGwZNy+WE
         YzD/mLs2B8Aw1+1PpdRcCbtxgWtGEMdDFYgRC484KbxkqkhLUWOS/HvGQbg0ZRBde1tK
         IibRltnqP/AeFCBu3shg8sqRkWIL7CMRIIYDNItPrAMG0mMufPOSD9IWrl/x8sD3e4LU
         xdtA1paoiVcbkojfCuHNwYTNpSrOpzhaWgxEVdKr3dl4gXwD/QOBGf2FqGKbYbKap2fb
         Q4SyMremDJf13Wt+oSDILPIs6I71xanT7dWGF48Kd8Rxkxc5hjM7FqGaZfFy9sqTg7kI
         tZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXjl4n1lvArgo8cX2i6yOg0JMkmYiPzAP2ZnE6PFHhk=;
        b=f73gOwPkcq53SNl5It6mic1C/OB6RstfjoWnzYFTI9LNOnSjJOm6wsiWof/Adl82as
         ENbMY5CWSABMqjrbjw0cQsHthYSDx/3ix+bT+1iVKUNgWi9XDpeSGLgH7jS0KhYP/IJ3
         /yLrSJrXsc4EPSwlMPwuc+1o8qOAQd5kEkhNyNJ1bFLYU4nbnPDZvpLMIaPkSb54V2Nn
         aWMIkuvWEMoxQADvfHdOoPKgtOqnYEHilyQEeQdW+JPwV8ZJXkuflerV2DGe+mnrUSM7
         rLWtrEhj6EmcaCU61ANHpJZTeYyx/73zegd/bjFRK9ihAXf2OFEF8R9O64xJgn/eAOY2
         69Hg==
X-Gm-Message-State: APjAAAXFP48dO5pgQh1cDNHVtO/fbDfUra4KhKPx5dZ0dd+udAphc3Y+
        S3+MKraJAnTgj+AtlpPSzRg=
X-Google-Smtp-Source: APXvYqzFpQA8CNQ+crETyc8Atju9RiNE0Z03UaB9x+osd9CW15UDq8zJm3LVR9UZAo7ImE9V107n6A==
X-Received: by 2002:a17:90a:7788:: with SMTP id v8mr1468380pjk.132.1565229850438;
        Wed, 07 Aug 2019 19:04:10 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id g1sm150319711pgg.27.2019.08.07.19.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 19:04:10 -0700 (PDT)
Subject: Re: [PATCH v7 1/7] driver core: Add support for linking devices
 during device addition
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-2-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <32a8abd2-b6a4-67df-eee9-0f006310e81e@gmail.com>
Date:   Wed, 7 Aug 2019 19:04:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724001100.133423-2-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 23 Jul 2019 17:10:54 -0700
> Subject: [PATCH v7 1/7] driver core: Add support for linking devices during
>  device addition
> From: Saravana Kannan <saravanak@google.com>
> 
> When devices are added, the bus might want to create device links to track
> functional dependencies between supplier and consumer devices. This
> tracking of supplier-consumer relationship allows optimizing device probe
> order and tracking whether all consumers of a supplier are active. The
> add_links bus callback is added to support this.

Change above to:

When devices are added, the bus may create device links to track which
suppliers a consumer device depends upon.  This
tracking of supplier-consumer relationship may be used to defer probing
the driver of a consumer device before the driver(s) for its supplier device(s)
are probed.  It may also be used by a supplier driver to determine if
all of its consumers have been successfully probed.
The add_links bus callback is added to create the supplier device links

> 
> However, when consumer devices are added, they might not have a supplier
> device to link to despite needing mandatory resources/functionality from
> one or more suppliers. A waiting_for_suppliers list is created to track
> such consumers and retry linking them when new devices get added.

Change above to:

If a supplier device has not yet been created when the consumer device attempts
to link it, the consumer device is added to the wait_for_suppliers list.
When supplier devices are created, the supplier device link will be added to
the relevant consumer devices on the wait_for_suppliers list.

> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/core.c    | 83 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h | 14 +++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index da84a73f2ba6..1b4eb221968f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -44,6 +44,8 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
>  #endif
>  
>  /* Device links support. */
> +static LIST_HEAD(wait_for_suppliers);
> +static DEFINE_MUTEX(wfs_lock);
>  
>  #ifdef CONFIG_SRCU
>  static DEFINE_MUTEX(device_links_lock);
> @@ -401,6 +403,51 @@ struct device_link *device_link_add(struct device *consumer,
>  }
>  EXPORT_SYMBOL_GPL(device_link_add);
>  
> +/**

> + * device_link_wait_for_supplier - Mark device as waiting for supplier

    * device_link_wait_for_supplier - Add device to wait_for_suppliers list


> + * @consumer: Consumer device
> + *
> + * Marks the consumer device as waiting for suppliers to become available. The
> + * consumer device will never be probed until it's unmarked as waiting for
> + * suppliers. The caller is responsible for adding the link to the supplier
> + * once the supplier device is present.
> + *
> + * This function is NOT meant to be called from the probe function of the
> + * consumer but rather from code that creates/adds the consumer device.
> + */
> +static void device_link_wait_for_supplier(struct device *consumer)
> +{
> +	mutex_lock(&wfs_lock);
> +	list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
> +	mutex_unlock(&wfs_lock);
> +}
> +
> +/**


> + * device_link_check_waiting_consumers - Try to remove from supplier wait list
> + *
> + * Loops through all consumers waiting on suppliers and tries to add all their
> + * supplier links. If that succeeds, the consumer device is unmarked as waiting
> + * for suppliers. Otherwise, they are left marked as waiting on suppliers,
> + *
> + * The add_links bus callback is expected to return 0 if it has found and added
> + * all the supplier links for the consumer device. It should return an error if
> + * it isn't able to do so.
> + *
> + * The caller of device_link_wait_for_supplier() is expected to call this once
> + * it's aware of potential suppliers becoming available.

Change above comment to:

    * device_link_add_supplier_links - add links from consumer devices to
    *                                  supplier devices, leaving any consumer
    *                                  with inactive suppliers on the
    *                                  wait_for_suppliers list

    * Scan all consumer devices in the devicetree.  For any supplier device that
    * is not already linked to the consumer device, add the supplier to the
    * consumer device's device links.
    *
    * If all of a consumer device's suppliers are available then the consumer
    * is removed from the wait_for_suppliers list (if previously on the list).
    * Otherwise the consumer is added to the wait_for_suppliers list (if not
    * already on the list).


    * The add_links bus callback must return 0 if it has found and added all
    * the supplier links for the consumer device. It must return an error if
    * it is not able to do so.
    *
    * The caller of device_link_wait_for_supplier() is expected to call this once
    * it is aware of potential suppliers becoming available.



> + */
> +static void device_link_check_waiting_consumers(void)

Function name is misleading and hides side effects.

I have not come up with a name that does not hide side effects, but a better
name would be:

   device_link_add_supplier_links()


> +{
> +	struct device *dev, *tmp;
> +
> +	mutex_lock(&wfs_lock);
> +	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
> +				 links.needs_suppliers)
> +		if (!dev->bus->add_links(dev))
> +			list_del_init(&dev->links.needs_suppliers);

Empties dev->links.needs_suppliers, but does not remove dev from
wait_for_suppliers list.  Where does that happen?

> +	mutex_unlock(&wfs_lock);
> +}
> +
>  static void device_link_free(struct device_link *link)
>  {
>  	while (refcount_dec_not_one(&link->rpm_active))
> @@ -535,6 +582,19 @@ int device_links_check_suppliers(struct device *dev)
>  	struct device_link *link;
>  	int ret = 0;
>  
> +	/*
> +	 * If a device is waiting for one or more suppliers (in
> +	 * wait_for_suppliers list), it is not ready to probe yet. So just
> +	 * return -EPROBE_DEFER without having to check the links with existing
> +	 * suppliers.
> +	 */

Change comment to:

	/*
	 * Device waiting for supplier to become available is not allowed
	 * to probe
	 */

> +	mutex_lock(&wfs_lock);
> +	if (!list_empty(&dev->links.needs_suppliers)) {
> +		mutex_unlock(&wfs_lock);
> +		return -EPROBE_DEFER;
> +	}
> +	mutex_unlock(&wfs_lock);
> +
>  	device_links_write_lock();

Update Documentation/driver-api/device_link.rst to reflect the
check of &dev->links.needs_suppliers in device_links_check_suppliers().

>  
>  	list_for_each_entry(link, &dev->links.suppliers, c_node) {
> @@ -812,6 +872,10 @@ static void device_links_purge(struct device *dev)
>  {
>  	struct device_link *link, *ln;
>  
> +	mutex_lock(&wfs_lock);
> +	list_del(&dev->links.needs_suppliers);
> +	mutex_unlock(&wfs_lock);
> +
>  	/*
>  	 * Delete all of the remaining links from this device to any other
>  	 * devices (either consumers or suppliers).
> @@ -1673,6 +1737,7 @@ void device_initialize(struct device *dev)
>  #endif
>  	INIT_LIST_HEAD(&dev->links.consumers);
>  	INIT_LIST_HEAD(&dev->links.suppliers);
> +	INIT_LIST_HEAD(&dev->links.needs_suppliers);
>  	dev->links.status = DL_DEV_NO_DRIVER;
>  }
>  EXPORT_SYMBOL_GPL(device_initialize);
> @@ -2108,6 +2173,24 @@ int device_add(struct device *dev)
>  					     BUS_NOTIFY_ADD_DEVICE, dev);
>  
>  	kobject_uevent(&dev->kobj, KOBJ_ADD);

> +
> +	/*
> +	 * Check if any of the other devices (consumers) have been waiting for
> +	 * this device (supplier) to be added so that they can create a device
> +	 * link to it.
> +	 *
> +	 * This needs to happen after device_pm_add() because device_link_add()
> +	 * requires the supplier be registered before it's called.
> +	 *
> +	 * But this also needs to happe before bus_probe_device() to make sure
> +	 * waiting consumers can link to it before the driver is bound to the
> +	 * device and the driver sync_state callback is called for this device.
> +	 */

	/*
	 * Add links to dev from any dependent consumer that has dev on it's
	 * list of needed suppliers (links.needs_suppliers).  Device_pm_add()
	 * must have previously registered dev to allow the links to be added.
	 *
	 * The consumer links must be created before dev is probed because the
	 * sync_state callback for dev will use the consumer links.
	 */

> +	device_link_check_waiting_consumers();
> +
> +	if (dev->bus && dev->bus->add_links && dev->bus->add_links(dev))
> +		device_link_wait_for_supplier(dev);
> +
>  	bus_probe_device(dev);
>  	if (parent)
>  		klist_add_tail(&dev->p->knode_parent,
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c330b75c6c57..5d70babb7462 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -78,6 +78,17 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
>   *		-EPROBE_DEFER it will queue the device for deferred probing.
>   * @uevent:	Called when a device is added, removed, or a few other things
>   *		that generate uevents to add the environment variables.

> + * @add_links:	Called, perhaps multiple times per device, after a device is
> + *		added to this bus.  The function is expected to create device
> + *		links to all the suppliers of the input device that are
> + *		available at the time this function is called.  As in, the
> + *		function should NOT stop at the first failed device link if
> + *		other unlinked supplier devices are present in the system.

* @add_links:	Called after a device is added to this bus.  The function is
*		expected to create device links to all the suppliers of the
*		device that are available at the time this function is called.
*		The function must NOT stop at the first failed device link if
*		other unlinked supplier devices are present in the system.
*		If some suppliers are not yet available, this function will be
*		called again when the suppliers become available.

but add_links() not needed, so moving this comment to of_link_to_suppliers()


> + *
> + *		Return 0 if device links have been successfully created to all
> + *		the suppliers of this device.  Return an error if some of the
> + *		suppliers are not yet available and this function needs to be
> + *		reattempted in the future.

*
*		Return 0 if device links have been successfully created to all
*		the suppliers of this device.  Return an error if some of the
*		suppliers are not yet available.


>   * @probe:	Called when a new device or driver add to this bus, and callback
>   *		the specific driver's probe to initial the matched device.
>   * @remove:	Called when a device removed from this bus.
> @@ -122,6 +133,7 @@ struct bus_type {
>  
>  	int (*match)(struct device *dev, struct device_driver *drv);
>  	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);


> +	int (*add_links)(struct device *dev);

              ^^^^^^^^^  add_supplier              ???
              ^^^^^^^^^  add_suppliers             ???

              ^^^^^^^^^  link_suppliers            ???

              ^^^^^^^^^  add_supplier_dependency   ???
              ^^^^^^^^^  add_supplier_dependencies ???
add_links() not needed


>  	int (*probe)(struct device *dev);
>  	int (*remove)(struct device *dev);
>  	void (*shutdown)(struct device *dev);




> @@ -893,11 +905,13 @@ enum dl_dev_state {
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
>   * @consumers: List of links to consumer devices.

> + * @needs_suppliers: Hook to global list of devices waiting for suppliers.

    * @needs_suppliers: List of devices deferring probe until supplier drivers
    *                   are successfully probed.

>   * @status: Driver status information.
>   */
>  struct dev_links_info {
>  	struct list_head suppliers;
>  	struct list_head consumers;
> +	struct list_head needs_suppliers;
>  	enum dl_dev_state status;
>  };
>  
> -- 
> 2.22.0.709.g102302147b-goog
> 
> 
