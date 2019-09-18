Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C6C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECC821920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568808393;
	bh=EiWNRaKT5YKCl1MF5pVlHDrq82FVL6w4JQ56eo+DjoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GeQpUMveXrRN8KvXozxUWFtuMIf33vCwSB1wXNNABJuG8yH8Eee/o+4qoIQCTZr0x
	 uTmq+K92kfRg0f2OFgcXc2rlyATyUsxYrCEAmO3k3jv4OqOh3tfUoVSiz7qUDQamg4
	 XI7Cv6vS67pCKdl/+jlt93d8FbwSOqqsgCzPSf8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfIRMGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfIRMGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:06:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD71C21907;
        Wed, 18 Sep 2019 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568808391;
        bh=EiWNRaKT5YKCl1MF5pVlHDrq82FVL6w4JQ56eo+DjoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdcH7MB66ggbdWktSVnY3VzHJlS8bsN5IkHUobkxNTzwB1bFEASD8r+TFslycQW8N
         BFLC3FGMlmZ8A2mhzTwoFsbUqt3ypKVT42WSwsKWVPzRgkDD0v8XlBDEn/wYJBW11k
         DRC8eYqnPeAv+gO9IyDepuQqQ0GOa0YcBwUwj5Sk=
Date:   Wed, 18 Sep 2019 14:06:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 8/9] soundwire: intel: remove platform
 devices and provide new interface
Message-ID: <20190918120629.GD1901208@kroah.com>
References: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
 <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
 <20190917055512.GE2058532@kroah.com>
 <ab06c0c9-6224-a7b8-51c2-01226f763b98@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab06c0c9-6224-a7b8-51c2-01226f763b98@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:29:52AM -0500, Pierre-Louis Bossart wrote:
> On 9/17/19 12:55 AM, Greg KH wrote:
> > On Mon, Sep 16, 2019 at 04:23:41PM -0500, Pierre-Louis Bossart wrote:
> > > +/**
> > > + * sdw_intel_probe() - SoundWire Intel probe routine
> > > + * @parent_handle: ACPI parent handle
> > > + * @res: resource data
> > > + *
> > > + * This creates SoundWire Master and Slave devices below the controller.
> > > + * All the information necessary is stored in the context, and the res
> > > + * argument pointer can be freed after this step.
> > > + */
> > > +struct sdw_intel_ctx
> > > +*sdw_intel_probe(struct sdw_intel_res *res)
> > > +{
> > > +	return sdw_intel_probe_controller(res);
> > > +}
> > > +EXPORT_SYMBOL(sdw_intel_probe);
> > > +
> > > +/**
> > > + * sdw_intel_startup() - SoundWire Intel startup
> > > + * @ctx: SoundWire context allocated in the probe
> > > + *
> > > + */
> > > +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> > > +{
> > > +	return sdw_intel_startup_controller(ctx);
> > > +}
> > > +EXPORT_SYMBOL(sdw_intel_startup);
> > 
> > Why are you exporting these functions if no one calls them?
> 
> They are used in the next series, see '[RFC PATCH 04/12] ASoC: SOF: Intel:
> add SoundWire configuration interface'

That wasn't obvious :)

Also, why not EXPORT_SYMBOL_GPL()?  :)

thanks,

greg k-h
