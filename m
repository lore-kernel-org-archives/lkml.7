Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E56420989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557206861;
	bh=UVbc4iB6zImLc+u0YFa5xDna8kmTDTd7akBPgEp3Vm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwiLc/p5CXPsMLw3r6XZ/qhY7CTW1UW6YsTlImBkkSs8hAXavKOFvflWEQJZ1ZRtM
	 YjHUH00ano21O5qeLraxAK8ZuE/9E+umGWGDVKles+62jnw6ZbBjWTtdzovG28sv8Y
	 QXSpIuSs+VEufgDlYxkQYo2f3nH4xcfBT5bu8VRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEGF1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfEGF1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:27:39 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99391206A3;
        Tue,  7 May 2019 05:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557206858;
        bh=UVbc4iB6zImLc+u0YFa5xDna8kmTDTd7akBPgEp3Vm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/+Tyj3EJnEfQtmPl4wAuOQmnEKvTFlW8qYh1dF6fbWNETkJKsnDW4/hwieXjvtRh
         e6JxXYLq0TKNmzbFmn/p+2eDhYS30fnWzdO6OAXl9PLL0ps1lSJktKaNZeYrHg1sq4
         XDQEjEqG4MpYNu5dAjwWMA0jGzYWSNhwVqhJBhGA=
Date:   Tue, 7 May 2019 10:57:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Message-ID: <20190507052732.GD16052@vkoul-mobl>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
 <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-05-19, 21:24, Pierre-Louis Bossart wrote:
> 
> > > +int sdw_sysfs_bus_init(struct sdw_bus *bus)
> > > +{
> > > +	struct sdw_master_sysfs *master;
> > > +	int err;
> > > +
> > > +	if (bus->sysfs) {
> > > +		dev_err(bus->dev, "SDW sysfs is already initialized\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	master = kzalloc(sizeof(*master), GFP_KERNEL);
> > > +	if (!master)
> > > +		return -ENOMEM;
> > 
> > Why are you creating a whole new device to put all of this under?  Is
> > this needed?  What will the sysfs tree look like when you do this?  Why
> > can't the "bus" device just get all of these attributes and no second
> > device be created?
> 
> I tried a quick hack and indeed we could simplify the code with something as
> simple as:
> 
> [attributes omitted]
> 
> static const struct attribute_group sdw_master_node_group = {
> 	.attrs = master_node_attrs,
> 	.name = "mipi-disco"
> };
> 
> int sdw_sysfs_bus_init(struct sdw_bus *bus)
> {
> 	return sysfs_create_group(&bus->dev->kobj, &sdw_master_node_group);
> }
> 
> void sdw_sysfs_bus_exit(struct sdw_bus *bus)
> {
> 	sysfs_remove_group(&bus->dev->kobj, &sdw_master_node_group);	
> }
> 
> which gives me a simpler structure and doesn't require additional
> pretend-devices:
> 
> /sys/bus/acpi/devices/PRP00001:00/int-sdw.0/mipi-disco# ls
> clock_gears
> /sys/bus/acpi/devices/PRP00001:00/int-sdw.0/mipi-disco# more clock_gears
> 8086
> 
> The issue I have is that for the _show() functions, I don't see a way to go
> from the device argument to bus. In the example above I forced the output
> but would need a helper.
> 
> static ssize_t clock_gears_show(struct device *dev,
> 				struct device_attribute *attr, char *buf)
> {
> 	struct sdw_bus *bus; // this is what I need to find from dev
> 	ssize_t size = 0;
> 	int i;
> 
> 	return sprintf(buf, "%d \n", 8086);
> }
> 
> my brain is starting to fry, but I don't see how container_of() would work
> here since the bus structure contains a pointer to the device. I don't also
> see a way to check for all devices for the bus_type soundwire.
> For the slaves we do have a macro based on container_of(), so wondering if
> we made a mistake in the bus definition? Vinod, any thoughts?

yeah I dont recall a way to get bus fed into create_group, I did look at
the other examples back then and IIRC and most of them were using a
global to do the trick (I didn't want to go down that route).

I think that was the reason I wrote it this way...

BTW if you do use psedo-device you can create your own struct foo which
embeds device and then then you can use container approach to get foo
(and foo contains bus as a member).

Greg, any thoughts?

Thanks
-- 
~Vinod
