Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA059C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE75217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564747193;
	bh=MegDr0BzCf1Mp8IehHAFlKK+IwXvFjSU1XSVy88+78o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D2xyBScsyYspq+AVNBD3S1xrhklEhdTAeSXbpSWybSzr8U2kM8NwceQKdiungW2dY
	 26McNX0KmiAV1dJ4mY0YYCWNwYEf0YOaCZCb1Qv3aOzd6BO9yxMNtQRzVIpuGIP39i
	 qJ4qNgZjveF4zCXTtyO7s1bXFd+295O7LgWvNbfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392487AbfHBL7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 07:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391000AbfHBL7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 07:59:52 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855272173E;
        Fri,  2 Aug 2019 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564747191;
        bh=MegDr0BzCf1Mp8IehHAFlKK+IwXvFjSU1XSVy88+78o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeq1RVT0t01vVnxkj5ekOJaqCWt1Lh6DYOo9zIqiWqtiYesm+oJy+oJgnpsOdsfIk
         7XWdYsWcKAG3O9h7puBQ+xVJSg1e+DvpY6bElLLdgi6aSL8j8lRxXcH7vU9jUNb+ZK
         HvUFOTjzKPXRAMTZf+/0zW2ImD7O6VdgFzmFzNbE=
Date:   Fri, 2 Aug 2019 17:28:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 08/40] soundwire: intel: remove BIOS work-arounds
Message-ID: <20190802115838.GK12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-9-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-9-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> the values passed by all existing BIOS are fine, let's use them as is.
> The existing code must have been needed only on early prototypes.

Thanks for this, I am applying this.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 51990b192dc0..c718c9c67a37 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -922,17 +922,6 @@ static int intel_prop_read(struct sdw_bus *bus)
>  	/* Initialize with default handler to read all DisCo properties */
>  	sdw_master_read_prop(bus);
>  
> -	/* BIOS is not giving some values correctly. So, lets override them */
> -	bus->prop.num_clk_freq = 1;
> -	bus->prop.clk_freq = devm_kcalloc(bus->dev, bus->prop.num_clk_freq,
> -					  sizeof(*bus->prop.clk_freq),
> -					  GFP_KERNEL);
> -	if (!bus->prop.clk_freq)
> -		return -ENOMEM;
> -
> -	bus->prop.clk_freq[0] = bus->prop.max_clk_freq;
> -	bus->prop.err_threshold = 5;
> -
>  	return 0;
>  }
>  
> -- 
> 2.20.1

-- 
~Vinod
