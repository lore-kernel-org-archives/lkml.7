Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ECAC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0B208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577430187;
	bh=pK5NjLlc8HWBe47WJjU0g8KCM1MJ3oftsVNdPgivXf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EFXQFjSkcH5F9q/K2+km5Bc5ByY2G4TSGPsCq5lPYoagu9Zpc8pJox4xd1YwLy6hE
	 +6Fhz4mujlp5GaMFfe5Ioa08Q8WJnWM5lsxftOcMosTGCIKmMTEFVu9cDesAJfqNrF
	 LPyp4GHGEhEJeemcuXEsQnfvRtoHl017hgnRoCpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfL0HDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0HDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:03:06 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822DB206CB;
        Fri, 27 Dec 2019 07:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577430185;
        bh=pK5NjLlc8HWBe47WJjU0g8KCM1MJ3oftsVNdPgivXf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdaRs8QXBYpI2r4LreKJRhblBBK09MHiUsO0+7huZUxbJwstfxXw0v8PjlK68WVVu
         Gm3c/IV1aFRx0IMm25OXBpy9AO+ZX4NZdOQGZBGcrGp/DBA3am1FSfTILalUud0bn8
         uX0EQZNbS9o43FCSDVHpn31M8IqMPjLGV3RSijGc=
Date:   Fri, 27 Dec 2019 12:33:01 +0530
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
Subject: Re: [PATCH v5 06/17] soundwire: add support for sdw_slave_type
Message-ID: <20191227070301.GK3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217210314.20410-7-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> In the existing SoundWire code, the bus does not have any explicit
> representation for Master Devices - only SoundWire Slaves are exposed.
> 
> In SoundWire, the Master Device provides the clock, synchronization
> information and command/control channels. When multiple links are
> supported, a Controller may expose more than one Master Device; they
> are typically embedded inside a larger audio cluster (be it in an
> SOC/chipset or an external audio codec), and we need to describe it
> using the Linux device and driver model.  This will allow for
> configuration functions to account for external dependencies such as
> power rails, clock sources or wake-up mechanisms. This transition will
> also allow for better sysfs support without the reference count issues
> mentioned in the initial reviews.
> 
> In this patch, we first convert the existing code to use an explicit
> sdw_slave_type and add error checks if this type is not set.
> 
> In follow-up patches we can add support for the sdw_master_type.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c       | 23 ++++++++++++++++++-----
>  drivers/soundwire/slave.c          |  7 ++++++-
>  include/linux/soundwire/sdw_type.h |  6 ++++++
>  3 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 9a0fd3ee1014..9719680a1e48 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -49,13 +49,26 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>  
>  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
> +	struct sdw_slave *slave;
>  	char modalias[32];
>  
> -	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> -
> -	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> -		return -ENOMEM;
> +	if (is_sdw_slave(dev)) {
> +		slave = to_sdw_slave_device(dev);
> +
> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
> +
> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
> +			return -ENOMEM;
> +	} else {
> +		/*
> +		 * We only need to handle uevents for the Slave device
> +		 * type. This error cannot happen unless the .uevent
> +		 * callback is set to use this function for a
> +		 * different device type (e.g. Master or Monitor)
> +		 */
> +		dev_err(dev, "uevent for unknown Soundwire type\n");
> +		return -EINVAL;

At this point and after next patch, the above code would be a no-op, do
we want this here, if so why?

-- 
~Vinod
