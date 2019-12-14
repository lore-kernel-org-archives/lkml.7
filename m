Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B05C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC7E2465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576312067;
	bh=YfYMxk4JzVffoALHiMNEb7YBKeYiCaTwSAvFQyGwuW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qgJyIGav4sfuKjACbXopxHDvgfWflFbaGkJiivMerbXiC2Pgay5r4rP8pmGCRZfhh
	 CJDPPtSHmvIo46hKt8DU6n20LODaqgRRR+pn0G9LG/QOZCXeLgezsm4yUHJnvoLsTc
	 0D3a01exMSVUZNSSTLnkTHjOZ9BA9LvHHRHHFpVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLNI1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 03:27:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfLNI1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:27:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01EE720706;
        Sat, 14 Dec 2019 08:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576312065;
        bh=YfYMxk4JzVffoALHiMNEb7YBKeYiCaTwSAvFQyGwuW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPfip066pDvDhwPSLDOIZHCbNb2KXELCqM5WVUR/2NvxgGdUYw8pNe0sHO3v0guao
         T9X6p+/sbf1jmfmmKNxhrRGfzN6YYI4G8q35hjC/mG7gh5UuxO3/rSpnGnodknWb0V
         E2OQzYsr6Svdkup7gNOP1V+lnefv6H6859h9ma4w=
Date:   Sat, 14 Dec 2019 09:27:42 +0100
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
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial definitions
 for sdw_master_device
Message-ID: <20191214082742.GA3318534@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
 <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 05:25:23PM -0600, Pierre-Louis Bossart wrote:
> 
> > No, I mean the new MODULE_NAMESPACE() support that is in the kernel.
> > I'll move the greybus code to use it too, but when you are adding new
> > apis, it just makes sense to use it then as well.
> 
> Greg, would the patch below be what you had in mind?
> Thanks
> -Pierre
> 
> 
> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
> index 76a5c52b12b4..5bad8422887e 100644
> --- a/drivers/soundwire/Makefile
> +++ b/drivers/soundwire/Makefile
> @@ -7,9 +7,11 @@ ccflags-y += -DDEBUG
>  #Bus Objs
>  soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o
> stream.o
>  obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
> +ccflags-$(CONFIG_SOUNDWIRE) += -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE
> 
>  soundwire-generic-allocation-objs := generic_bandwidth_allocation.o
>  obj-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
> soundwire-generic-allocation.o
> +ccflags-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
> -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE

Don't use ccflags, just use the correct MODULE_EXPORT_NS() tag instead.

And "SDW_CORE" is odd, "SOUNDWIRE" instead?

thanks,

greg k-h
