Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF41C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B188124656
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576221756;
	bh=0sPm7J7BCIEhMIoIedEg2UHth35LruEqtDCfrEnZ7Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AGqGw9IXTihslhC1XhIKk/L8H08be2ioHVBZBj6xv756qLS5+PGNpan4iJPH+Kurq
	 /NhdSk8ezhyO2m9BQSDA2ZBBkPEfuzy5THFb/Eu82Wh+OKHC3+oK70kFB3yGbk8ZlL
	 9JAK1T20wLqdf6vVtMdAF2suB9mzK+us+AeHAzAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMHWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfLMHWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:22:35 -0500
Received: from localhost (unknown [84.241.199.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E955222527;
        Fri, 13 Dec 2019 07:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576221754;
        bh=0sPm7J7BCIEhMIoIedEg2UHth35LruEqtDCfrEnZ7Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2flDD/pRkDALP6RVioapKjvMd3DFwlByvJfqSwkUOzH4yhMOzaWu38P/krZc6cA4Y
         fEKZ0sbG0hWTa4ccqYWjXdK6wy+iPKQMAlcUiZ4cpvW14Cfx8ti65ilWrLypCL6E2z
         hO47UMngPqdR2r53YuwyJErkX1obP+uB1JvrdHD0=
Date:   Fri, 13 Dec 2019 08:22:31 +0100
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
Subject: Re: [PATCH v4 07/15] soundwire: slave: move uevent handling to slave
Message-ID: <20191213072231.GE1750354@kroah.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-8-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213050409.12776-8-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:04:01PM -0600, Pierre-Louis Bossart wrote:
> Currently the code deals with uevents at the bus level, but we only care
> for Slave events

What does this mean?  I can't understand it, can you please provide more
information on what you are doing here?

> 
> Suggested-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h      | 2 ++
>  drivers/soundwire/bus_type.c | 3 +--
>  drivers/soundwire/slave.c    | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index cb482da914da..be01a5f3d00b 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -6,6 +6,8 @@
>  
>  #define DEFAULT_BANK_SWITCH_TIMEOUT 3000
>  
> +int sdw_uevent(struct device *dev, struct kobj_uevent_env *env);
> +
>  #if IS_ENABLED(CONFIG_ACPI)
>  int sdw_acpi_find_slaves(struct sdw_bus *bus);
>  #else
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index bbdedce5eb26..5c18c21545b5 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -47,7 +47,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>  			slave->id.mfg_id, slave->id.part_id);
>  }
>  
> -static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
> +int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct sdw_slave *slave;
>  	char modalias[32];
> @@ -71,7 +71,6 @@ static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  struct bus_type sdw_bus_type = {
>  	.name = "soundwire",
>  	.match = sdw_bus_match,
> -	.uevent = sdw_uevent,
>  };
>  EXPORT_SYMBOL_GPL(sdw_bus_type);
>  
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index c87267f12a3b..014c3ece1f17 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -17,6 +17,7 @@ static void sdw_slave_release(struct device *dev)
>  struct device_type sdw_slave_type = {
>  	.name =		"sdw_slave",
>  	.release =	sdw_slave_release,
> +	.uevent = sdw_uevent,

Align this with the other ones?

does this cause any different functionality?

thanks,

greg k-h
