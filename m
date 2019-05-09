Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF83C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B582175B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557376005;
	bh=BTFLcMlAore+8BPqJnH+mQxkkDWN3gE2tXUgHZgQ4vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D2KZaCxFBo8gFEh0117RomBqNh/pxBFjxssGsle0ApMW9pRns2NgznwWikwTcUDBp
	 VlJIOIPC/jPihwJZ5RPPedM+ilpO1lIfYPRzXcpLLaLqs1p3zX+zUuadBJLS5EX+gJ
	 +IAo3VJNJuynHdyKLUBP7mJQKxT1O7zdtn8e+J/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEIE0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfEIE0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:26:43 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC34216C4;
        Thu,  9 May 2019 04:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557376001;
        bh=BTFLcMlAore+8BPqJnH+mQxkkDWN3gE2tXUgHZgQ4vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNz/u8qqH3SBUlmOJtHHegFvP57qUsdB4GleSRyfOjH1Nm8YuxaRXU8yFHPpYbJ4U
         p7KovupqvTuIB5w5DN6Il6iHBsbb6fcYTONbC/JhSPD1GlBGp/17XZJ4fxD3yQ7SmO
         uUzJPV4fD/Hp6zKxok8X3OoABBdk9pZTWSXIKm9E=
Date:   Thu, 9 May 2019 09:56:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Message-ID: <20190509042636.GY16052@vkoul-mobl>
References: <20190507052732.GD16052@vkoul-mobl>
 <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl>
 <20190507111956.GB1092@kroah.com>
 <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
 <20190508074606.GV16052@vkoul-mobl>
 <20190508091628.GB1858@kroah.com>
 <c0161db3-69d7-0a76-f4bd-d5feb3529128@linux.intel.com>
 <20190508165945.GC6157@kroah.com>
 <0b8d5238-6894-e2b4-5522-28636e40dd63@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b8d5238-6894-e2b4-5522-28636e40dd63@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-19, 15:57, Pierre-Louis Bossart wrote:
> 
> 
> On 5/8/19 11:59 AM, Greg KH wrote:
> > On Wed, May 08, 2019 at 11:42:15AM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > On 5/8/19 4:16 AM, Greg KH wrote:
> > > > On Wed, May 08, 2019 at 01:16:06PM +0530, Vinod Koul wrote:
> > > > > On 07-05-19, 17:49, Pierre-Louis Bossart wrote:
> > > > > > 
> > > > > > > > The model here is that Master device is PCI or Platform device and then
> > > > > > > > creates a bus instance which has soundwire slave devices.
> > > > > > > > 
> > > > > > > > So for any attribute on Master device (which has properties as well and
> > > > > > > > representation in sysfs), device specfic struct (PCI/platfrom doesn't
> > > > > > > > help). For slave that is not a problem as sdw_slave structure takes care
> > > > > > > > if that.
> > > > > > > > 
> > > > > > > > So, the solution was to create the psedo sdw_master device for the
> > > > > > > > representation and have device-specific structure.
> > > > > > > 
> > > > > > > Ok, much like the "USB host controller" type device.  That's fine, make
> > > > > > > such a device, add it to your bus, and set the type correctly.  And keep
> > > > > > > a pointer to that structure in your device-specific structure if you
> > > > > > > really need to get to anything in it.
> > > > > > 
> > > > > > humm, you lost me on the last sentence. Did you mean using
> > > > > > set_drv/platform_data during the init and retrieving the bus information
> > > > > > with get_drv/platform_data as needed later? Or something else I badly need
> > > > > > to learn?
> > > > > 
> > > > > IIUC Greg meant we should represent a soundwire master device type and
> > > > > use that here. Just like we have soundwire slave device type. Something
> > > > > like:
> > > > > 
> > > > > struct sdw_master {
> > > > >           struct device dev;
> > > > >           struct sdw_master_prop *prop;
> > > > >           ...
> > > > > };
> > > > > 
> > > > > In show function you get master from dev (container of) and then use
> > > > > that to access the master properties. So int.sdw.0 can be of this type.
> > > > 
> > > > Yes, you need to represent the master device type if you are going to be
> > > > having an internal representation of it.
> > > 
> > > Humm, confused...In the existing code bus and master are synonyms, see e.g.
> > > following code excerpts:
> > > 
> > >   * sdw_add_bus_master() - add a bus Master instance
> > >   * @bus: bus instance
> > >   *
> > >   * Initializes the bus instance, read properties and create child
> > >   * devices.
> > > 
> > > struct sdw_bus {
> > > 	struct device *dev; <<< pointer here
> > 
> > That's the pointer to what?  The device that the bus is "attached to"
> > (i.e. parent, like a platform device or a pci device)?
> > 
> > Why isn't this a "real" device in itself?

Correct, I am revisiting this and I think I have a fair idea of
expectations here (looking at usb and greybus model), will hack
something up

> Allow me to provide a bit of background. I am not trying to be pedantic but
> make sure we are on the same page.
> 
> The SoundWire spec only defines a Master and Slaves attached to that Master.
> 
> In real applications, there is a need to have multiple links, which can
> possibly operate in synchronized ways, so Intel came up with the concept of
> Controller, which expose multiple Master interfaces that are in sync (two
> streams can start at exactly the same clock edge of different links).
> 
> The Controller is exposed in ACPI as a child of the HDAudio controller (ACPI
> companion of a PCI device). The controller exposes a 'master-count' and a
> set of link-specific properties needed for bandwidth/clock scaling.
> 
> For some reason, our Windows friends did not want to have a device for each
> Master interface, likely because they did not want to load a driver per
> Master interface or have 'yellow bangs'.
> 
> So the net result is that we have the following hierarchy in ACPI
> 
> Device(HDAS) // HDaudio controller
>   Device(SNDW) // SoundWire Controller
>     Device(SDW0) { // Slave0
> 	_ADR(link0, vendorX, partY...)
>     }
>     Device(SDW1) { // Slave0
> 	_ADR(link0, vendorX, partY...)
>     }
>     Device(SDW2) { // Slave0
> 	_ADR(link1, vendorX, partY...)
>     }
>     Device(SDWM) { // Slave0
> 	_ADR(linkM, vendorX, partY...)
>     }
> 
> There is no master device represented in ACPI and the only way by which we
> know to which Master a Slave device is attached by looking up the _ADR which
> contains the link information.
> 
> So, coming back to the plot, when we parse the Controller properties, we
> find out how many Master interfaces we have, create a platform_device for
> each of them, then initialize all the bus stuff.

So the idea here would be to go back and create a sdw_master device and
use that in the bus instance. I think it should be doable..

> > I thought I asked that a long time ago when first reviewing these
> > patches...

Sorry my fault, I should have fixed it back then.

> > 
> > > 	unsigned int link_id;
> > > 	struct list_head slaves;
> > > 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
> > > 	struct mutex bus_lock;
> > > 	struct mutex msg_lock;
> > > 	const struct sdw_master_ops *ops;
> > > 	const struct sdw_master_port_ops *port_ops;
> > > 	struct sdw_bus_params params;
> > > 	struct sdw_master_prop prop;
> > > 
> > > The existing code creates a platform_device in
> > > drivers/soundwire/intel_init.c, and it's assigned by the following code:
> > 
> > The core creates a platform device, don't assume you can "take it over"
> > :)
> > 
> > That platform device lives on the platform bus, you need a "master"
> > device that lives on your soundbus bus.
> > 
> > Again, look at how USB does this.  Or better yet, greybus, as that code
> > is a lot smaller and simpler.
> 
> The learning curve is not small here...
> 
> > > 
> > > static int intel_probe(struct platform_device *pdev)
> > > {
> > > 	struct sdw_cdns_stream_config config;
> > > 	struct sdw_intel *sdw;
> > > 	int ret;
> > > 
> > > 	sdw = devm_kzalloc(&pdev->dev, sizeof(*sdw), GFP_KERNEL);
> > > [snip]
> > > 	sdw->cdns.dev = &pdev->dev;
> > > 	sdw->cdns.bus.dev = &pdev->dev;
> > 
> > Gotta love the lack of reference counting :(
> > 
> > > I really don't see what you are hinting at, sorry, unless we are talking
> > > about major surgery in the code.

Not really we have object here which should contain a real device for
master and need plumbing for it..

> > It sounds like you need a device on your bus that represents the master,
> > as you have attributes associated with it, and other things.  You can't
> > put attributes on a random pci or platform device, as you do not "own"
> > that device.
> > 
> > does that help?
> 
> Looks like we are doing things wrong at multiple levels.
> 
> It might be better to have a more 'self-contained' solution where the bus
> initialization creates/registers a master device instead of having this
> proxy platform_device. That would avoid all these refcount issues and make
> the translation from device to bus straightforward.

yes that is my thinking as well. We still need to link to
platform/pci/whatever device you have and grab a refcount to that one.

> Am I on the right track or still in the weeds?


-- 
~Vinod
