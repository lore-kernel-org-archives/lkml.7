Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD3CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A4215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572759173;
	bh=sWpt+8gx2UCKCgB2KXVS3k69C+FooSSl8zh1C67GoGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1NbgTlmUhlreswiziOziegIXhCnkkzDm74SpVg3g18ln9Zv8mctGCyJFfHao2oyD
	 7j3p8bCfqAbpLcfWqaho+rCPcL7ja65IVeJzmGVaYO6F+gRnJwmzG4BZgJurWgPRla
	 Rfjh2IAsOh6HGvcqjN470kYA3xXCPDgrnhXdpkyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfKCFcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 01:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfKCFcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 01:32:51 -0400
Received: from localhost (unknown [106.206.115.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F42C20848;
        Sun,  3 Nov 2019 05:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572759170;
        bh=sWpt+8gx2UCKCgB2KXVS3k69C+FooSSl8zh1C67GoGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+V868ELK1D52quKLVGl8UHoVERdMDQV+Cr9+e2uPPQsfFKUGlLKA9zdLqQtPREfM
         kub4ts0/RKcabrscvpgQNVm/ZUCVTPx2yLSD08SccaKNyha2lYPjUfoG0WYzY79NT7
         o2qywTz1CkFBzx826wuhuF0UuP8U2k8Oc+psUTqg=
Date:   Sun, 3 Nov 2019 11:02:43 +0530
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
Subject: Re: [PATCH 06/14] soundwire: add support for sdw_slave_type
Message-ID: <20191103053243.GI2695@vkoul-mobl.Dlink>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023212823.608-7-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
> Currently the bus does not have any explicit support for master
> devices.  Add explicit support for sdw_slave_type, so that in
> follow-up patches we can add support for the sdw_md_type (md==Master
> Device), following the Grey Bus example.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus_type.c       | 9 ++++++++-
>  drivers/soundwire/slave.c          | 7 ++++++-
>  include/linux/soundwire/sdw_type.h | 6 ++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 9a0fd3ee1014..5df095f4e12f 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -49,9 +49,16 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>  
>  static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
> +	struct sdw_slave *slave;
>  	char modalias[32];
>  
> +	if (is_sdw_slave(dev)) {
> +		slave = to_sdw_slave_device(dev);
> +	} else {
> +		dev_warn(dev, "uevent for unknown Soundwire type\n");
> +		return -EINVAL;

when is the case where this would be triggered?

> +	}
> +
>  	sdw_slave_modalias(slave, modalias, sizeof(modalias));
>  
>  	if (add_uevent_var(env, "MODALIAS=%s", modalias))
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index 48a513680db6..c87267f12a3b 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -14,6 +14,11 @@ static void sdw_slave_release(struct device *dev)
>  	kfree(slave);
>  }
>  
> +struct device_type sdw_slave_type = {
> +	.name =		"sdw_slave",
> +	.release =	sdw_slave_release,
> +};
> +
>  static int sdw_slave_add(struct sdw_bus *bus,
>  			 struct sdw_slave_id *id, struct fwnode_handle *fwnode)
>  {
> @@ -41,9 +46,9 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  			     id->class_id, id->unique_id);
>  	}
>  
> -	slave->dev.release = sdw_slave_release;
>  	slave->dev.bus = &sdw_bus_type;
>  	slave->dev.of_node = of_node_get(to_of_node(fwnode));
> +	slave->dev.type = &sdw_slave_type;
>  	slave->bus = bus;
>  	slave->status = SDW_SLAVE_UNATTACHED;
>  	slave->dev_num = 0;
> diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
> index 7d4bc6a979bf..c681b3426478 100644
> --- a/include/linux/soundwire/sdw_type.h
> +++ b/include/linux/soundwire/sdw_type.h
> @@ -5,6 +5,12 @@
>  #define __SOUNDWIRE_TYPES_H
>  
>  extern struct bus_type sdw_bus_type;
> +extern struct device_type sdw_slave_type;
> +
> +static inline int is_sdw_slave(const struct device *dev)
> +{
> +	return dev->type == &sdw_slave_type;
> +}
>  
>  #define to_sdw_slave_driver(_drv) \
>  	container_of(_drv, struct sdw_driver, driver)
> -- 
> 2.20.1

-- 
~Vinod
