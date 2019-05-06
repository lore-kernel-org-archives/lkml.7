Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB8AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571821019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557159736;
	bh=n4fUgB+1Yb+XpXuGuFZbm4TH64BgfrO5/gdAK66Tgjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QPr1w54e+TAGjvkbn8LLKbJeCsMAcY/8OWbn8E7du6kk9K1/z11U7DO9iJMPmfseW
	 aoi36vqfhchebKAamFa7W2QEZZ6O1w0LFFfCtJuXzMoWGTDwz0jw6OMR0/ZaKf1gYa
	 9AXhOjoxvdT1+Y8BoSWNxZ7DpYWlHbFoGea8emyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEFQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfEFQWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:22:14 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED7B214AE;
        Mon,  6 May 2019 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557159733;
        bh=n4fUgB+1Yb+XpXuGuFZbm4TH64BgfrO5/gdAK66Tgjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gip5lYLxnyF4TLfsEBmG5/lCfyhlpsZTj3Y3wzZvTOw49H76Xa09haJHj3KZn8lhh
         LVdtb+CRNREQcpE523dVrdyxDf/uJZdxxjujFOZpF3PwqKiOQX7tBMUXGObaigSfki
         4PV5iiqhjG2rEuBPF6+LibzDlcMdfBiN4rqiQE/g=
Date:   Mon, 6 May 2019 21:52:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
Message-ID: <20190506162208.GI3845@vkoul-mobl.Dlink>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
 <20190506151953.GA13178@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506151953.GA13178@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-05-19, 17:19, Greg KH wrote:
> On Mon, May 06, 2019 at 09:42:35AM -0500, Pierre-Louis Bossart wrote:
> > > > +
> > > > +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> > > > +{
> > > > +	struct sdw_slave_sysfs *sysfs;
> > > > +	unsigned int src_dpns, sink_dpns, i, j;
> > > > +	int err;
> > > > +
> > > > +	if (slave->sysfs) {
> > > > +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
> > > > +		err = -EIO;
> > > > +		goto err_ret;
> > > > +	}
> > > > +
> > > > +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
> > > 
> > > Same question as patch 1, why a new device?
> > 
> > yes it's the same open. In this case, the slave devices are defined at a
> > different level so it's also confusing to create a device to represent the
> > slave properties. The code works but I am not sure the initial directions
> > are correct.
> 
> You can just make a subdir for your attributes by using the attribute
> group name, if a subdirectory is needed just to keep things a bit more
> organized.

The key here is 'a subdir' which is not the case here. We did discuss
this in the initial patches for SoundWire which had sysfs :)

The way MIPI disco spec organized properties, we have dp0 and dpN
properties each of them requires to have a subdir of their own and that
was the reason why I coded it to be creating a device.

Do we have a better way to handle this?

> Otherwise, you need to mess with having multiple "types" of struct
> device all associated with the same bus.  It is possible, and not that
> hard, but I don't think you are doing that here.
> 
> thnaks,
> 
> greg k-h

-- 
~Vinod
