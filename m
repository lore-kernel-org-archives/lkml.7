Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3E6C5ED6A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE24B2473D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfLMPyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:54:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:34227 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfLMPyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:54:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 07:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="246170765"
Received: from dbmoens-mobl1.amr.corp.intel.com ([10.255.228.102])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2019 07:54:19 -0800
Subject: Re: [PATCH v4 08/15] soundwire: add initial definitions for
 sdw_master_device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
Date:   Fri, 13 Dec 2019 09:49:57 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213072844.GF1750354@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 1:28 AM, Greg KH wrote:
> On Thu, Dec 12, 2019 at 11:04:02PM -0600, Pierre-Louis Bossart wrote:
>> Since we want an explicit support for the SoundWire Master device, add
>> the definitions, following the Grey Bus example.
> 
> "Greybus"  All one word please.

Ack, will fix.

>> @@ -59,9 +59,12 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   
>>   		if (add_uevent_var(env, "MODALIAS=%s", modalias))
>>   			return -ENOMEM;
>> +	} else if (is_sdw_md(dev)) {
> 
> Ok, "is_sdw_md()" is a horrid function name.  Spell it out please, this
> ends up in the global namespace.

ok, will use is_sdw_master_device.

> 
> Actually, why are you not using module namespaces here for this new
> code?  That would help you out a lot.

I must admit I don't understand the question. This is literally modeled 
after is_gb_host_device(), did I miss something in the Greybus 
implementation?

> 
>> +		/* this should not happen but throw an error */
>> +		dev_warn(dev, "uevent for Master device, unsupported\n");
> 
> Um, what?  This is supported as it will happen when you create such a
> device.  It's an issue of "I didn't write the code yet", not that it is
> not "supported".

I will remove, it cannot happen.

>> diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
>> new file mode 100644
>> index 000000000000..6210098c892b
>> --- /dev/null
>> +++ b/drivers/soundwire/master.c
>> @@ -0,0 +1,62 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> 
> Still with the crazy dual license?  I thought we went over this all
> before.
> 
> You can not do this for code that touches driver core stuff, like this.
> Please stop and just make all of this GPLv2 like we discussed months
> ago.

I don't recall this was the guidance but fine.

> 
>> +// Copyright(c) 2019 Intel Corporation.
>> +
>> +#include <linux/device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/soundwire/sdw.h>
>> +#include <linux/soundwire/sdw_type.h>
>> +#include "bus.h"
>> +
>> +static void sdw_md_release(struct device *dev)
>> +{
>> +	struct sdw_master_device *md = to_sdw_master_device(dev);
>> +
>> +	kfree(md);
>> +}
>> +
>> +struct device_type sdw_md_type = {
>> +	.name =		"soundwire_master",
>> +	.release =	sdw_md_release,
>> +};
>> +
>> +struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
> 
> Bad function names, please spell things out, you have plenty of
> characters to go around.

This was modeled after gb_hd_create ;-)

sdw_master_device_add starts to be on the long side, no?


>> +				     struct device *parent,
>> +				     struct fwnode_handle *fwnode,
>> +				     int link_id)
>> +{
>> +	struct sdw_master_device *md;
>> +	int ret;
>> +
>> +	if (!driver->probe) {
>> +		dev_err(parent, "mandatory probe callback missing\n");
> 
> The callback is missing for the driver you passed in, not for the
> parent, right?

yes, this function is called as part of the parent probe.

>> +	ret = device_register(&md->dev);
>> +	if (ret) {
>> +		dev_err(parent, "Failed to add master: ret %d\n", ret);
>> +		/*
>> +		 * On err, don't free but drop ref as this will be freed
>> +		 * when release method is invoked.
>> +		 */
>> +		put_device(&md->dev);
> 
> But you still return a valid pointer?  Why????

Ah, yes, this is clearly wrong, thanks for pointing this out.

What's the recommended error code for this? Greybus uses:

return ERR_PTR(-ENOMEM);

>> +EXPORT_SYMBOL(sdw_md_add);
> 
> EXPORT_SYMBOL_GPL()?

yes, will fix

> 
> 
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index 5b1180f1e6b5..af0a72e7afdf 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -585,6 +585,16 @@ struct sdw_slave {
>>   #define to_sdw_slave_device(d) \
>>   	container_of(d, struct sdw_slave, dev)
>>   
>> +struct sdw_master_device {
>> +	struct device dev;
>> +	int link_id;
>> +	struct sdw_md_driver *driver;
>> +	void *pdata; /* core does not touch */
> 
> Core of what?

SoundWire bus driver. This is a copy/paste from the SOF code I am 
afraid, will fix.

> 
>> +};
>> +
>> +#define to_sdw_master_device(d)	\
>> +	container_of(d, struct sdw_master_device, dev)
>> +
>>   struct sdw_driver {
>>   	const char *name;
>>   
>> @@ -599,6 +609,26 @@ struct sdw_driver {
>>   	struct device_driver driver;
>>   };
>>   
>> +struct sdw_md_driver {
>> +	/* initializations and allocations */
>> +	int (*probe)(struct sdw_master_device *md, void *link_ctx);
>> +	/* hardware enablement, all clock/power dependencies are available */
>> +	int (*startup)(struct sdw_master_device *md);
>> +	/* hardware disabled */
>> +	int (*shutdown)(struct sdw_master_device *md);
>> +	/* free all resources */
>> +	int (*remove)(struct sdw_master_device *md);
>> +	/*
>> +	 * enable/disable driver control while in clock-stop mode,
>> +	 * typically in always-on/D0ix modes. When the driver yields
>> +	 * control, another entity in the system (typically firmware
>> +	 * running on an always-on microprocessor) is responsible to
>> +	 * tracking Slave-initiated wakes
>> +	 */
>> +	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
>> +					    bool state);
>> +};
> 
> Use kerneldoc comments for this to make it easier to understand and for
> others to read?

yes, I used kerneldoc everywhere except here, will fix.


