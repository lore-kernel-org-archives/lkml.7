Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA3BC32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E89421775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578289354;
	bh=3RhNzBGs+D8rTsIRLrcYDaHymOOyLXkNlDfsc8JeyZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ud+5ejJWq08SWYbye85ikNmP/tyKUGjMxzW3Ly7VctoCt+Fy0N6JG8pcbnsLCeyHj
	 UUTSKEjvXFRSrp7c8JlPl21dzWVCPcBqixBZVp8rLLfnDOAIjsDotPOv5OQdrp26J0
	 RxWmwzNRhX52pSP0EWidliFI9trGbp8vYusHKDqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFFm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgAFFmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:42:25 -0500
Received: from localhost (unknown [117.99.94.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C1121734;
        Mon,  6 Jan 2020 05:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578289345;
        bh=3RhNzBGs+D8rTsIRLrcYDaHymOOyLXkNlDfsc8JeyZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MinmSbcCkzk1oiZEJyhRn/jaFO5NQ/wKcCKKfRm5rrLa7GBYYqS9ZqTNBrXcPIW94
         vBzhi30/Faml22jv2YFmujSrhy3fH15V+28W/X8yn6AR5Y8i4QcVdVik9MvJ4CD6zo
         ZvjRndP7VTCN1eHYPOGKz2/oTI/s7L/UjbaGFm28=
Date:   Mon, 6 Jan 2020 11:12:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 09/17] soundwire: intel: remove platform
 devices and use 'Master Devices' instead
Message-ID: <20200106054221.GN2818@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-10-pierre-louis.bossart@linux.intel.com>
 <20191227090826.GM3006@vkoul-mobl>
 <5be4d9df-0f46-d36f-471c-aae9e1f55cc0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be4d9df-0f46-d36f-471c-aae9e1f55cc0@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-19, 18:13, Pierre-Louis Bossart wrote:
> 
> 
> > > +extern struct sdw_md_driver intel_sdw_driver;
> > 
> > who uses this intel_sdw_driver? I would assumed someone would register
> > this with the core...
> 
> this is a structure used by intel_init(), see the following code.
> 
> +		md = sdw_md_add(&intel_sdw_driver,
> +				res->parent,
> +				acpi_fwnode_handle(adev),
> +				i);
> 
> that will in turn call intel_master_probe() as defined below:
> 
> +struct sdw_md_driver intel_sdw_driver = {
> +	.probe = intel_master_probe,
> +	.startup = intel_master_startup,
> +	
> 
> > > -		link->pdev = pdev;
> > > -		link++;
> > > +		/* let the SoundWire master driver to its probe */
> > > +		md->driver->probe(md, link);
> > 
> > So you are invoking driver probe here.. That is typically role of driver
> > core to do that.. If we need that, make driver core do that for you!
> > 
> > That reminds me I am missing match code for master driver...
> 
> There is no match for the master because it doesn't have an existence in
> ACPI. There are no _ADR or HID that can be used, the only thing that exists
> is the Controller which has 4 sublinks. Each master must be added  by hand.
> 
> Also the SoundWire master cannot be enumerated or matched against a
> SoundWire bus, since it controls the bus itself (that would be a chicken and
> egg problem). The SoundWire master would need to be matched on a parent bus
> (which does not exist for Intel) since the hardware is embedded in a larger
> audio cluster that's visible on PCI only.
> 
> Currently for Intel platforms, the SoundWire master device is created by the
> SOF driver (via the abstraction in intel_init.c).

That is okay for me, the thing that is bit confusing is having a probe
etc and no match.. (more below)..

> > So we seem to be somewhere is middle wrt driver probing here! IIUC this
> > is not a full master driver, thats okay, but then it is not
> > completely transparent either...
> > 
> > I was somehow thinking that the driver will continue to be
> > 'platform/acpi/of' driver and master device abstraction will be
> > handled in the core (for example see how the busses like i2c handle
> > this). The master device is created and used to represent but driver
> > probing etc is not done
> 
> I2C controllers are typically PCI devices or have some sort of ACPI
> description. This is not the case for SoundWire masters on Intel platforms,

Well the world is not PCI/ACPI... We have controllers which are DT
described and work in same manner as a PCI device.

> so even if I wanted to I would have no ability to implement any matching or
> parent bus registration.
> 
> Also the notion of 'probe' does not necessarily mean that the device is
> attached to a bus, we use DAI 'drivers' in ASoC and still have probe/remove
> callbacks.

The "big" difference is that probe is called by core (asoc) and not by
driver onto themselves.. IMO that needs to go away.

> And if you look at the definitions, we added additional callbacks since
> probe/remove are not enough to deal with hardware restrictions:
> 
> For Intel platforms, we have a startup() callback which is only invoked once
> the DSP is powered and the rails stable. Likewise we added an
> 'autonomous_clock_stop()' callback which will be needed when the Linux
> driver hands-over control of the hardware to the DSP firmware, e.g. to deal
> with in-band wakes in D0i3.
> 
> FWIW, the implementation here follows what was suggested for Greybus 'Host
> Devices' [1] [2], so it's not like I am creating any sort of dangerous
> precedent.
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/greybus/es2.c#L1275
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/greybus/hd.c#L124

And if you look closely all this work is done by core not by drivers!
Drivers _should_ never do all this, it is the job of core to do that for
you.

-- 
~Vinod
