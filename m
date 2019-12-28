Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C81C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1770620409
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577535201;
	bh=wJqzOZYfIUcwpsmayT7euq6E2bx0zdBap1jaRbyPzBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n9Qcsz7+C0pTeL9wwQ+WeWHDvfXzYBflX/7Dg22WSR7tU7G1F3m6bQlrDMeJSGAn7
	 uVZzYeXH58L6Wf3hvlMUleV1vXJopRPd93QsBZBb0vMOhUaAZoIkvX79IsyQPpICnM
	 y5jp0KqPsCqNvVSofIyUFItt/GILNpzQXsDUT8O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfL1MFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 07:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfL1MFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 07:05:24 -0500
Received: from localhost (unknown [122.178.200.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A98020748;
        Sat, 28 Dec 2019 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577534724;
        bh=wJqzOZYfIUcwpsmayT7euq6E2bx0zdBap1jaRbyPzBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9g4NRybIzJEDKgs1IRroNq1Jq4yHpfiCZkRuZF/BYQJYqAj5V9t1L+M9rCyyLaea
         WG7EfAewoU6ouhF0RPwQlgwi4ssh423j4Gcww7REytIqYxYndl6FDTT5ilt/exuSBx
         OpUWbuuetvhqrmiGz1rEEPlhs63POYFlyEyS0DqU=
Date:   Sat, 28 Dec 2019 17:35:20 +0530
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
Subject: Re: [alsa-devel] [PATCH v5 06/17] soundwire: add support for
 sdw_slave_type
Message-ID: <20191228120520.GQ3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-7-pierre-louis.bossart@linux.intel.com>
 <20191227070301.GK3006@vkoul-mobl>
 <2913a70d-f1e1-7d91-eb3c-33005c5c4007@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2913a70d-f1e1-7d91-eb3c-33005c5c4007@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-12-19, 17:26, Pierre-Louis Bossart wrote:
> 
> > >   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
> > >   {
> > > -	struct sdw_slave *slave = to_sdw_slave_device(dev);
> > > +	struct sdw_slave *slave;
> > >   	char modalias[32];
> > > -	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> > > -
> > > -	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> > > -		return -ENOMEM;
> > > +	if (is_sdw_slave(dev)) {
> > > +		slave = to_sdw_slave_device(dev);
> > > +
> > > +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
> > > +
> > > +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
> > > +			return -ENOMEM;
> > > +	} else {
> > > +		/*
> > > +		 * We only need to handle uevents for the Slave device
> > > +		 * type. This error cannot happen unless the .uevent
> > > +		 * callback is set to use this function for a
> > > +		 * different device type (e.g. Master or Monitor)
> > > +		 */
> > > +		dev_err(dev, "uevent for unknown Soundwire type\n");
> > > +		return -EINVAL;
> > 
> > At this point and after next patch, the above code would be a no-op, do
> > we want this here, if so why?
> 
> to be future proof if someone wants to add support for a monitor, as
> explained above.
> I can remove this if you don't want it.

It can be added with monitor support whenever that comes. We dont like
dead code in kernel, the piece can come when future arrives :)

-- 
~Vinod
