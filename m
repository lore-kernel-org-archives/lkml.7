Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D49C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B17F21734
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557345164;
	bh=WvqlE0zoyG0HaDjphQsaFq6mRxNdKTiq1F02ec0+6Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bIZpPWG1JUXVVSPKzqttOQQFcb6FT5SsEDkbLxm86KpCFPVo/eNZnVztZ0caFW4Db
	 m4BbzQ1mB1uV6gZ89o1EChBkolWc+/cpOdCzul01m47Gcby/P1I5gQsUv+ERg3agp0
	 QwFN7Q+2Mk5xn/7uKSCzYq1xJbiYW57Xc0Qnyt8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfEHTwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 15:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfEHTwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:52:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 389EC214AF;
        Wed,  8 May 2019 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557345161;
        bh=WvqlE0zoyG0HaDjphQsaFq6mRxNdKTiq1F02ec0+6Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmfX5vc3on/JzT6wUcFitavY0RbtRsD+JW/PFXruSyUpQmR07wgSrqVDy6GaoSa/F
         pFtRYcbBqQgrIni09uMAjm/TAa5viZhb4GBCgTjtFi6S5/nyxhv/n88lXjXuFVEns7
         V3lpZWZvYKJu2emVGDK049Uw1XD8Q1tb7UeYtFcM=
Date:   Wed, 8 May 2019 18:59:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Message-ID: <20190508165945.GC6157@kroah.com>
References: <20190504065242.GA9770@kroah.com>
 <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
 <20190507052732.GD16052@vkoul-mobl>
 <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl>
 <20190507111956.GB1092@kroah.com>
 <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
 <20190508074606.GV16052@vkoul-mobl>
 <20190508091628.GB1858@kroah.com>
 <c0161db3-69d7-0a76-f4bd-d5feb3529128@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0161db3-69d7-0a76-f4bd-d5feb3529128@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:42:15AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 5/8/19 4:16 AM, Greg KH wrote:
> > On Wed, May 08, 2019 at 01:16:06PM +0530, Vinod Koul wrote:
> > > On 07-05-19, 17:49, Pierre-Louis Bossart wrote:
> > > > 
> > > > > > The model here is that Master device is PCI or Platform device and then
> > > > > > creates a bus instance which has soundwire slave devices.
> > > > > > 
> > > > > > So for any attribute on Master device (which has properties as well and
> > > > > > representation in sysfs), device specfic struct (PCI/platfrom doesn't
> > > > > > help). For slave that is not a problem as sdw_slave structure takes care
> > > > > > if that.
> > > > > > 
> > > > > > So, the solution was to create the psedo sdw_master device for the
> > > > > > representation and have device-specific structure.
> > > > > 
> > > > > Ok, much like the "USB host controller" type device.  That's fine, make
> > > > > such a device, add it to your bus, and set the type correctly.  And keep
> > > > > a pointer to that structure in your device-specific structure if you
> > > > > really need to get to anything in it.
> > > > 
> > > > humm, you lost me on the last sentence. Did you mean using
> > > > set_drv/platform_data during the init and retrieving the bus information
> > > > with get_drv/platform_data as needed later? Or something else I badly need
> > > > to learn?
> > > 
> > > IIUC Greg meant we should represent a soundwire master device type and
> > > use that here. Just like we have soundwire slave device type. Something
> > > like:
> > > 
> > > struct sdw_master {
> > >          struct device dev;
> > >          struct sdw_master_prop *prop;
> > >          ...
> > > };
> > > 
> > > In show function you get master from dev (container of) and then use
> > > that to access the master properties. So int.sdw.0 can be of this type.
> > 
> > Yes, you need to represent the master device type if you are going to be
> > having an internal representation of it.
> 
> Humm, confused...In the existing code bus and master are synonyms, see e.g.
> following code excerpts:
> 
>  * sdw_add_bus_master() - add a bus Master instance
>  * @bus: bus instance
>  *
>  * Initializes the bus instance, read properties and create child
>  * devices.
> 
> struct sdw_bus {
> 	struct device *dev; <<< pointer here

That's the pointer to what?  The device that the bus is "attached to"
(i.e. parent, like a platform device or a pci device)?

Why isn't this a "real" device in itself?

I thought I asked that a long time ago when first reviewing these
patches...

> 	unsigned int link_id;
> 	struct list_head slaves;
> 	DECLARE_BITMAP(assigned, SDW_MAX_DEVICES);
> 	struct mutex bus_lock;
> 	struct mutex msg_lock;
> 	const struct sdw_master_ops *ops;
> 	const struct sdw_master_port_ops *port_ops;
> 	struct sdw_bus_params params;
> 	struct sdw_master_prop prop;
> 
> The existing code creates a platform_device in
> drivers/soundwire/intel_init.c, and it's assigned by the following code:

The core creates a platform device, don't assume you can "take it over"
:)

That platform device lives on the platform bus, you need a "master"
device that lives on your soundbus bus.

Again, look at how USB does this.  Or better yet, greybus, as that code
is a lot smaller and simpler.

> 
> static int intel_probe(struct platform_device *pdev)
> {
> 	struct sdw_cdns_stream_config config;
> 	struct sdw_intel *sdw;
> 	int ret;
> 
> 	sdw = devm_kzalloc(&pdev->dev, sizeof(*sdw), GFP_KERNEL);
> [snip]
> 	sdw->cdns.dev = &pdev->dev;
> 	sdw->cdns.bus.dev = &pdev->dev;

Gotta love the lack of reference counting :(

> I really don't see what you are hinting at, sorry, unless we are talking
> about major surgery in the code.

It sounds like you need a device on your bus that represents the master,
as you have attributes associated with it, and other things.  You can't
put attributes on a random pci or platform device, as you do not "own"
that device.

does that help?

greg k-h
