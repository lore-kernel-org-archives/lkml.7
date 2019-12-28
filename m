Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B403DC47409
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816AA20409
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577535201;
	bh=q49tqPH7tWafvxKLb/LDDT7f3OVFmJjvV/wyX/oHtic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12aM4mHYISMrBy8e8QjpqIA7sFJSZk2yrupX+ZV5R9qQkHcUKbZLYhPjj/2oTprNk
	 OhFUiIgOk/qm7TLBQ8cG6lBBjLgnZfmsXEI2xWnLmQsG2BxmBu/n8yX4JAkRObxk93
	 aBoD8wfA/HzLpkjA5asDVzTJYDzoFZL4sNye5JDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfL1MJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 07:09:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1MJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 07:09:36 -0500
Received: from localhost (unknown [122.178.200.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0258B20409;
        Sat, 28 Dec 2019 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577534975;
        bh=q49tqPH7tWafvxKLb/LDDT7f3OVFmJjvV/wyX/oHtic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0j29eL0yns+J51T/AsO3uu9vm2Qk/EnCOtm0eYwpLLSHOMGfkvaFef8K2CS3es/zj
         ApR0tGsf1JrocGTXpSfpjlxn7P1hlAYAtFVRBlxgqvEEccbMW5V5l+EYHqCcpTk91L
         eK0ryDmZY5S+JGRd2sw2tei7o/ToyaA/1v/fviyQ=
Date:   Sat, 28 Dec 2019 17:39:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 08/17] soundwire: add initial definitions
 for sdw_master_device
Message-ID: <20191228120930.GR3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
 <20191227071433.GL3006@vkoul-mobl>
 <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-19, 17:38, Pierre-Louis Bossart wrote:
> 
> 
> On 12/27/19 1:14 AM, Vinod Koul wrote:
> > On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> > > Since we want an explicit support for the SoundWire Master device, add
> > > the definitions, following the Greybus example of a 'Host Device'.
> > > 
> > > A parent (such as the Intel audio controller) would use sdw_md_add()
> > > to create the device, passing a driver as a parameter. The
> > > sdw_md_release() would be called when put_device() is invoked by the
> > > parent. We use the shortcut 'md' for 'master device' to avoid very
> > > long function names.
> > 
> > I agree we should not have long name :) but md does not sound great. Can
> > we drop the device and use sdw_slave and sdw_master for devices and
> > append _driver when we are talking about drivers...
> > 
> > we dont use sd for slave and imo this would gel well with existing names
> 
> In SoundWire parlance, both 'Slave' and 'Master' are 'Devices', so yes we do
> in the standard talk about 'Slave Devices' and 'Master Devices'.
> 
> Then we have Linux 'Devices' which can be used for both.
> 
> If we use 'sdw_slave', would we be referring to the actual physical part or
> the Linux device?
> 
> FWIW the Greybus example used 'Host Device' and 'hd' as shortcut.

But this messes up consistency in the naming of sdw objects. I am all for
it, if we do sd for slave and name all structs and APIs accordingly. The key
is consistency!

So it needs to be sd/md and so on or sdw_slave and sdw_master and so
on... not a mix of both

> > > --- a/drivers/soundwire/bus_type.c
> > > +++ b/drivers/soundwire/bus_type.c
> > > @@ -66,7 +66,10 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
> > >   		 * callback is set to use this function for a
> > >   		 * different device type (e.g. Master or Monitor)
> > >   		 */
> > > -		dev_err(dev, "uevent for unknown Soundwire type\n");
> > > +		if (is_sdw_master_device(dev))
> > > +			dev_err(dev, "uevent for SoundWire Master type\n");
> > 
> > see below [1]:
> > 
> > > +static void sdw_md_release(struct device *dev)
> > 
> > sdw_master_release() won't be too long!
> 
> yes, but there is no such operation as 'Master Release' in SoundWire.
> At least the 'md' shortcut conveys the implicit convention that this is a
> Linux device only.
> 
> I really would like to avoid overloading the standard definitions with the
> Linux ones...

I agree with you on not overloading but from a linux pov, we need names
which are consistent with each other...

> > > +{
> > > +	struct sdw_master_device *md = to_sdw_master_device(dev);
> > > +
> > > +	kfree(md);
> > > +}
> > > +
> > > +struct device_type sdw_md_type = {
> > 
> > sdw_master_type and so on :)
> > 
> > > +	.name =		"soundwire_master",
> > > +	.release =	sdw_md_release,
> > 
> > [1]:
> > There is no uevent added here, so sdw_uevent() will never be called for
> > this, can you check again if you see the print you added?
> 
> as explained this is to avoid errors at a later point. I don't see any harm
> in providing error checks for a routine that can only be used for 1 of the 3
> devices defined in the standard?
> 
> > > +struct sdw_master_device {
> > 
> > we have sdw_slave, so would be better if we call this sdw_master
> > 
> > > +	struct device dev;
> > > +	int link_id;
> > > +	struct sdw_md_driver *driver;
> > > +	void *pdata;
> > 
> > no sdw_bus pointer and I dont see bus adding this object.. Is there no
> > link between bus and master device objects?
> 
> There is currently no bus device object, see the structure definition it's a
> pointer to a device (which leads to all sorts of issues because we can't use
> container_of).
> 
> when the master device gets added, that's where the Linux device is created
> and the pointer saved in the bus structure, with IIRC sdw_add_bus_master().
> 
> 
>  	ret = sdw_add_bus_master(&sdw->cdns.bus);
-- 
~Vinod
