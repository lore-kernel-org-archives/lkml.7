Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D20C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B70A21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568814876;
	bh=Qe6au5z5hXayAw27Vw361lE68Lf4o3n8SyGPFRWhuqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IjiYKppTPYg+VoN6S5zDIKgInNQlq+7eJBdlOPuJsxsAbURNB5mu4c/6m/AOfLh5J
	 rn+xJoFaulDTssIIW+hRHLfHGDhyvozhujkpTyYrgiH0e8RQ4kjQleyUOfLA/UcYaQ
	 O5cEK9abaFSwQfewq88sRYtylCJclf/g+XbUXgQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfIRNyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfIRNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:54:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FED82054F;
        Wed, 18 Sep 2019 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568814874;
        bh=Qe6au5z5hXayAw27Vw361lE68Lf4o3n8SyGPFRWhuqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pea49RvmmhwH16hgVmgZwak5t+0ies5xaMi3pedsbgp7HZbMBz7Q1jWie00LZZe+8
         s+vndJSssq4mISj6VztcRNyrotY60vWvMVmdVJmEwYJrX5sB4Ot4qcFCptgXdGfirT
         tkkhJ9cqGG6ybwdkbXS3u9YuHdjGpv1BJJ5dM0EQ=
Date:   Wed, 18 Sep 2019 15:54:31 +0200
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
Message-ID: <20190918135431.GA1919350@kroah.com>
References: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
 <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
 <20190917055512.GE2058532@kroah.com>
 <ab06c0c9-6224-a7b8-51c2-01226f763b98@linux.intel.com>
 <20190918120629.GD1901208@kroah.com>
 <c8f21078-1462-5463-ef12-957ebd9ba085@linux.intel.com>
 <20190918135302.GA1919118@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918135302.GA1919118@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 03:53:02PM +0200, Greg KH wrote:
> On Wed, Sep 18, 2019 at 08:48:33AM -0500, Pierre-Louis Bossart wrote:
> > On 9/18/19 7:06 AM, Greg KH wrote:
> > > On Tue, Sep 17, 2019 at 09:29:52AM -0500, Pierre-Louis Bossart wrote:
> > > > On 9/17/19 12:55 AM, Greg KH wrote:
> > > > > On Mon, Sep 16, 2019 at 04:23:41PM -0500, Pierre-Louis Bossart wrote:
> > > > > > +/**
> > > > > > + * sdw_intel_probe() - SoundWire Intel probe routine
> > > > > > + * @parent_handle: ACPI parent handle
> > > > > > + * @res: resource data
> > > > > > + *
> > > > > > + * This creates SoundWire Master and Slave devices below the controller.
> > > > > > + * All the information necessary is stored in the context, and the res
> > > > > > + * argument pointer can be freed after this step.
> > > > > > + */
> > > > > > +struct sdw_intel_ctx
> > > > > > +*sdw_intel_probe(struct sdw_intel_res *res)
> > > > > > +{
> > > > > > +	return sdw_intel_probe_controller(res);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(sdw_intel_probe);
> > > > > > +
> > > > > > +/**
> > > > > > + * sdw_intel_startup() - SoundWire Intel startup
> > > > > > + * @ctx: SoundWire context allocated in the probe
> > > > > > + *
> > > > > > + */
> > > > > > +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
> > > > > > +{
> > > > > > +	return sdw_intel_startup_controller(ctx);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(sdw_intel_startup);
> > > > > 
> > > > > Why are you exporting these functions if no one calls them?
> > > > 
> > > > They are used in the next series, see '[RFC PATCH 04/12] ASoC: SOF: Intel:
> > > > add SoundWire configuration interface'
> > > 
> > > That wasn't obvious :)
> > > 
> > > Also, why not EXPORT_SYMBOL_GPL()?  :)
> > 
> > Since the beginning of this SoundWire work, the intent what that the code
> > could be reused in non-GPL open-source circles, hence the dual license and
> > EXPORT_SYMBOL.
> 
> Hah, you _have_ talked to your lawyers about this, right?
> 
> You have a chance to do something like this for header files, for .c
> files, good luck.  That's going to be a hard road to go down.  Many have
> tried in the past, all but 1 have failed.

Also note, the last I checked, the _default_ license for Linux kernel
code from Intel was GPLv2.  If you got an exception for this, please
work with your legal council on how to do this "properly" as that was
part of getting that exception, right?

If you didn't get the exception, um, you have some people to go talk to,
and how come I am the one asking you about this?  :(

thanks,

greg k-h
