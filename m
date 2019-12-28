Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF864C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31020882
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfL1AQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:16:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:58305 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL1AQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:16:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 16:16:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="243364226"
Received: from vdoan2-mobl.ccr.corp.intel.com (HELO [10.251.152.151]) ([10.251.152.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 16:16:11 -0800
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
 <20191227090826.GM3006@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5be4d9df-0f46-d36f-471c-aae9e1f55cc0@linux.intel.com>
Date:   Fri, 27 Dec 2019 18:13:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227090826.GM3006@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> +extern struct sdw_md_driver intel_sdw_driver;
> 
> who uses this intel_sdw_driver? I would assumed someone would register
> this with the core...

this is a structure used by intel_init(), see the following code.

+		md = sdw_md_add(&intel_sdw_driver,
+				res->parent,
+				acpi_fwnode_handle(adev),
+				i);

that will in turn call intel_master_probe() as defined below:

+struct sdw_md_driver intel_sdw_driver = {
+	.probe = intel_master_probe,
+	.startup = intel_master_startup,
+	

>> -		link->pdev = pdev;
>> -		link++;
>> +		/* let the SoundWire master driver to its probe */
>> +		md->driver->probe(md, link);
> 
> So you are invoking driver probe here.. That is typically role of driver
> core to do that.. If we need that, make driver core do that for you!
> 
> That reminds me I am missing match code for master driver...

There is no match for the master because it doesn't have an existence in 
ACPI. There are no _ADR or HID that can be used, the only thing that 
exists is the Controller which has 4 sublinks. Each master must be added 
  by hand.

Also the SoundWire master cannot be enumerated or matched against a 
SoundWire bus, since it controls the bus itself (that would be a chicken 
and egg problem). The SoundWire master would need to be matched on a 
parent bus (which does not exist for Intel) since the hardware is 
embedded in a larger audio cluster that's visible on PCI only.

Currently for Intel platforms, the SoundWire master device is created by 
the SOF driver (via the abstraction in intel_init.c).

> So we seem to be somewhere is middle wrt driver probing here! IIUC this
> is not a full master driver, thats okay, but then it is not
> completely transparent either...
> 
> I was somehow thinking that the driver will continue to be
> 'platform/acpi/of' driver and master device abstraction will be
> handled in the core (for example see how the busses like i2c handle
> this). The master device is created and used to represent but driver
> probing etc is not done

I2C controllers are typically PCI devices or have some sort of ACPI 
description. This is not the case for SoundWire masters on Intel 
platforms, so even if I wanted to I would have no ability to implement 
any matching or parent bus registration.

Also the notion of 'probe' does not necessarily mean that the device is 
attached to a bus, we use DAI 'drivers' in ASoC and still have 
probe/remove callbacks.

And if you look at the definitions, we added additional callbacks since 
probe/remove are not enough to deal with hardware restrictions:

For Intel platforms, we have a startup() callback which is only invoked 
once the DSP is powered and the rails stable. Likewise we added an 
'autonomous_clock_stop()' callback which will be needed when the Linux 
driver hands-over control of the hardware to the DSP firmware, e.g. to 
deal with in-band wakes in D0i3.

FWIW, the implementation here follows what was suggested for Greybus 
'Host Devices' [1] [2], so it's not like I am creating any sort of 
dangerous precedent.

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/greybus/es2.c#L1275
[2] https://elixir.bootlin.com/linux/latest/source/drivers/greybus/hd.c#L124

