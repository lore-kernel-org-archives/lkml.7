Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D559AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6853214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576221692;
	bh=1irYrXGOcxexWbuIpAf9P38P6DG0tz6DxNZJDv6EmtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ussYYG7PAJp1Qo9ZImOwBTD71x5WSj5Q9qea1hyxMvJKYP2b7/7x2UEukNu1O4DJc
	 B6r1QVnPALnPCPa58bruqbVmYGpvTtHZGI8C9CAUkfZeXbotEb0PI4+hcsBdSz+NPx
	 8gRlbvxJa2UISxK9m3bzn3e4ADq8aH3yeMIO7btU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfLMHVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfLMHVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:21:31 -0500
Received: from localhost (unknown [84.241.199.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF17A22527;
        Fri, 13 Dec 2019 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576221690;
        bh=1irYrXGOcxexWbuIpAf9P38P6DG0tz6DxNZJDv6EmtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nK0mkKVmXw7yPAns6tFG57mYIF/DC4ECaDxa6MTMHPSLqnk+MSMsR085zVutvYQAV
         7UYPqnsEhYcTghhvcofVsrcuPD2B/7IRgn+8EPaWeCWXZbUDRoQSgvL7oOtB+XzUcm
         pjE/UUBFae5wZF8Yqo2aWF/lI+X0Txh4bbAcpKTM=
Date:   Fri, 13 Dec 2019 08:21:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 06/15] soundwire: add support for sdw_slave_type
Message-ID: <20191213072127.GD1750354@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213050409.12776-7-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:04:00PM -0600, Pierre-Louis Bossart wrote:
> Currently the bus does not have any explicit support for master
> devices.
> 
> First add explicit support for sdw_slave_type and error checks if this type
> is not set.
> 
> In follow-up patches we can add support for the sdw_md_type (md==Master
> Device), following the Grey Bus example.

How are you using greybus as an example of "master devices"?  All you
are doing here is setting the type of the existing devices, right?


> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c       | 16 ++++++++++++----
>  drivers/soundwire/slave.c          |  7 ++++++-
>  include/linux/soundwire/sdw_type.h |  6 ++++++
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 9a0fd3ee1014..bbdedce5eb26 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -49,13 +49,21 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>  
>  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
> +	struct sdw_slave *slave;
>  	char modalias[32];
>  
> -	sdw_slave_modalias(slave, modalias, sizeof(modalias));
> +	if (is_sdw_slave(dev)) {
> +		slave = to_sdw_slave_device(dev);
> +
> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
>  
> -	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> -		return -ENOMEM;
> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
> +			return -ENOMEM;
> +	} else {
> +		/* only Slave device type supported */
> +		dev_warn(dev, "uevent for unknown Soundwire type\n");
> +		return -EINVAL;

Right now, this can not happen, right?

Not a problem, just trying to understand the sequence of patches here...

thanks,

greg k-h
