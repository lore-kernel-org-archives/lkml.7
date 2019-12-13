Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30D1C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606F52467B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576273743;
	bh=N7ld8QpWhFKFVlnsxwXVqKOE2P/6aREGj1EyVdGbtVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wC4YxU84PjGveA9YI5wQSOjRruhCZexe/WZcdp3bTBH8Sdlnp4bs/Wn/R7Ii7wjF3
	 fhH+/U0FRgfxrUzwjL9E3pJiCwEqx3M/v8E3DCibOkQtxtm1Q99CkqHB6p/lZXZXx6
	 CHOkiyMc/9z2ZRXifNXB9w8yYT12acxJSKTkI9Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLMVtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLMVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:48:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118892465B;
        Fri, 13 Dec 2019 21:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576273738;
        bh=N7ld8QpWhFKFVlnsxwXVqKOE2P/6aREGj1EyVdGbtVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y8YzYSCMInoCO3CmS3C3d2st2xu9ICzKSfa/M9uR5gXKM6rb7JMBP71djJXiOXJmq
         tfp7xfiC+2AYWpQP5SFUstHGQQPa5xQBIjO0f0FvLZI7E+vAtlO/4GZG/AO0qg3+Jt
         SUa8SL67t0qGDql2E5CjaiPhS7uitw0Wp5Nua8vM=
Date:   Fri, 13 Dec 2019 17:10:46 +0100
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
Subject: Re: [PATCH v4 08/15] soundwire: add initial definitions for
 sdw_master_device
Message-ID: <20191213161046.GA2653074@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 09:49:57AM -0600, Pierre-Louis Bossart wrote:
> On 12/13/19 1:28 AM, Greg KH wrote:
> > On Thu, Dec 12, 2019 at 11:04:02PM -0600, Pierre-Louis Bossart wrote:
> > > Since we want an explicit support for the SoundWire Master device, add
> > > the definitions, following the Grey Bus example.
> > 
> > "Greybus"  All one word please.
> 
> Ack, will fix.
> 
> > > @@ -59,9 +59,12 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
> > >   		if (add_uevent_var(env, "MODALIAS=%s", modalias))
> > >   			return -ENOMEM;
> > > +	} else if (is_sdw_md(dev)) {
> > 
> > Ok, "is_sdw_md()" is a horrid function name.  Spell it out please, this
> > ends up in the global namespace.
> 
> ok, will use is_sdw_master_device.
> 
> > 
> > Actually, why are you not using module namespaces here for this new
> > code?  That would help you out a lot.
> 
> I must admit I don't understand the question. This is literally modeled
> after is_gb_host_device(), did I miss something in the Greybus
> implementation?

No, I mean the new MODULE_NAMESPACE() support that is in the kernel.
I'll move the greybus code to use it too, but when you are adding new
apis, it just makes sense to use it then as well.

thanks,

greg k-h
