Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6706221530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557301573;
	bh=NsnfkXVI0T6faVZCvWn42jQMNpffXYblg42PO2k1kqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LBEtVCqTfQZ8DefkYyX3IRMKOPDP0+ISO9g5vLhz2ql/lkX1+zlhAb9zldhjbIy7k
	 MudzKawd91GuAyb/KL1DSKAgwvN1WaVCe8IyrEWOTwlLsD8APn0xZnYjsZVW4Tww3L
	 VYSB9lRi5yy47r5n8Sjp0AHL/nc1DgEKIKuQtBeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfEHHqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfEHHqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:46:12 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C602520644;
        Wed,  8 May 2019 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557301571;
        bh=NsnfkXVI0T6faVZCvWn42jQMNpffXYblg42PO2k1kqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPhKURIO+Ao87Hes/VhOjfiC+GnqbbR2hJxjP9z1OPaP/5GKkTzut1CvgceUci/Zl
         aEqurGRQcofhzWNHhJUImvtLT1SmaCTWJJzGJx7Vi8kxNg4Skn/+EDhxLyg50qylsQ
         FG/qDCGibyoi84ZyB7vtr4q8278ldA1j0TrskY1c=
Date:   Wed, 8 May 2019 13:16:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
Message-ID: <20190508074606.GV16052@vkoul-mobl>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
 <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
 <20190507052732.GD16052@vkoul-mobl>
 <20190507055432.GB17986@kroah.com>
 <20190507110331.GL16052@vkoul-mobl>
 <20190507111956.GB1092@kroah.com>
 <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fef156-7b01-7a08-77b4-ae3153eaaabc@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-19, 17:49, Pierre-Louis Bossart wrote:
> 
> > > The model here is that Master device is PCI or Platform device and then
> > > creates a bus instance which has soundwire slave devices.
> > > 
> > > So for any attribute on Master device (which has properties as well and
> > > representation in sysfs), device specfic struct (PCI/platfrom doesn't
> > > help). For slave that is not a problem as sdw_slave structure takes care
> > > if that.
> > > 
> > > So, the solution was to create the psedo sdw_master device for the
> > > representation and have device-specific structure.
> > 
> > Ok, much like the "USB host controller" type device.  That's fine, make
> > such a device, add it to your bus, and set the type correctly.  And keep
> > a pointer to that structure in your device-specific structure if you
> > really need to get to anything in it.
> 
> humm, you lost me on the last sentence. Did you mean using
> set_drv/platform_data during the init and retrieving the bus information
> with get_drv/platform_data as needed later? Or something else I badly need
> to learn?

IIUC Greg meant we should represent a soundwire master device type and
use that here. Just like we have soundwire slave device type. Something
like:

struct sdw_master {
        struct device dev;
        struct sdw_master_prop *prop;
        ...
};

In show function you get master from dev (container of) and then use
that to access the master properties. So int.sdw.0 can be of this type.

Thanks
-- 
~Vinod
