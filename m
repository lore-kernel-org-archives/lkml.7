Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332EDC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A4920828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577430882;
	bh=49Lm7+RozsQClCk5xLTdStGzPbj3kdYXaIJf87sbKDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iVFkYd3x0xS0cRshKXkpsw64RFfwr0vEHbaWHg8+Gk0P+QrKEfvXOkj40XJJQJMFU
	 eO1P+Go1Yj5W0DbVqDG06XAoo3zxS1ia87WyycnoUNipJLK//7wGX9GgszYu8hp71w
	 +4cLe0Tvz8tvtVAvGMdtzuQzwYmJdRcaddBpQcNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL0HOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 02:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfL0HOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 02:14:40 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F7E2053B;
        Fri, 27 Dec 2019 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577430879;
        bh=49Lm7+RozsQClCk5xLTdStGzPbj3kdYXaIJf87sbKDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZEwq+VvfBH9zNooswKee02UuEVKFclYXC00+XJJBYZumMqasI7lmZzC6a4C4zqhp
         htbCOR7tc8NwCKaSnpbq4yBFw9hdbz60w7SCFdn4sxbTzEiuE3h7lylxSCISAcoTGA
         1f88U7Ug7Dmi8WI+1SgZtvJe5mPzTcfLFP3GwePA=
Date:   Fri, 27 Dec 2019 12:44:33 +0530
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
Subject: Re: [PATCH v5 08/17] soundwire: add initial definitions for
 sdw_master_device
Message-ID: <20191227071433.GL3006@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
> Since we want an explicit support for the SoundWire Master device, add
> the definitions, following the Greybus example of a 'Host Device'.
> 
> A parent (such as the Intel audio controller) would use sdw_md_add()
> to create the device, passing a driver as a parameter. The
> sdw_md_release() would be called when put_device() is invoked by the
> parent. We use the shortcut 'md' for 'master device' to avoid very
> long function names.

I agree we should not have long name :) but md does not sound great. Can
we drop the device and use sdw_slave and sdw_master for devices and
append _driver when we are talking about drivers... 

we dont use sd for slave and imo this would gel well with existing names

> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -66,7 +66,10 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  		 * callback is set to use this function for a
>  		 * different device type (e.g. Master or Monitor)
>  		 */
> -		dev_err(dev, "uevent for unknown Soundwire type\n");
> +		if (is_sdw_master_device(dev))
> +			dev_err(dev, "uevent for SoundWire Master type\n");

see below [1]:

> +static void sdw_md_release(struct device *dev)

sdw_master_release() won't be too long!

> +{
> +	struct sdw_master_device *md = to_sdw_master_device(dev);
> +
> +	kfree(md);
> +}
> +
> +struct device_type sdw_md_type = {

sdw_master_type and so on :)

> +	.name =		"soundwire_master",
> +	.release =	sdw_md_release,

[1]:
There is no uevent added here, so sdw_uevent() will never be called for
this, can you check again if you see the print you added?

>  
> +struct sdw_master_device {

we have sdw_slave, so would be better if we call this sdw_master

> +	struct device dev;
> +	int link_id;
> +	struct sdw_md_driver *driver;
> +	void *pdata;

no sdw_bus pointer and I dont see bus adding this object.. Is there no
link between bus and master device objects?

-- 
~Vinod
