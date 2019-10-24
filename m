Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4805ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E152166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571917161;
	bh=btv1T62kZlTa2GqfHH4BS6VB02TuYQ5KdYGyc08+TRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oNyP456KnBvVIAtK4TjJ8FXMpGXIZdUVsq1ki9ovPhIguwqMhIesGyFm5gQwZ/uT6
	 NbkUq35cHw6tXK6Ubg03lZFu2pE4XLXqcSLSMG/ZUrbfzwC719ZIarVfYvjI81U5Uu
	 XQP5EybfOeAs+p3O1+jQbuHDqPd0NvvVfJI8n+J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393389AbfJXLjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfJXLjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:39:19 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D37B20679;
        Thu, 24 Oct 2019 11:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571917158;
        bh=btv1T62kZlTa2GqfHH4BS6VB02TuYQ5KdYGyc08+TRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nD7zqHMLHLaS0MspoOdBs9SSyekBu/RzDoBVMLHUJ3u+4Zfsm+4J+wNsw3RA0fdqI
         I/ZnVPtccAexpTnhp3QdlFjKmHU61l7ZkdcU/tJJmM6wcZ0bfvIwNEjUS7c4UYEvpT
         faUnHCgEUchMSyvTtKSOL0wIv+r1i+DlUJBcYIgY=
Date:   Thu, 24 Oct 2019 17:09:11 +0530
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
Subject: Re: [PATCH 3/3] soundwire: ignore uniqueID when irrelevant
Message-ID: <20191024113911.GD2620@vkoul-mobl>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
 <20191022234808.17432-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022234808.17432-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:48, Pierre-Louis Bossart wrote:
> The uniqueID is useful when there are two or more devices of the same
> type (identical manufacturer ID, part ID) on the same link.

Right!

> When there is a single device of a given type on a link, its uniqueID
> is irrelevant. It's not uncommon on actual platforms to see variations
> of the uniqueID, or differences between devID registers and ACPI _ADR
> fields.

Ideally this should be fixed in firmware, I do not like the fact the we are
poking in core for firmware issues!

> This patch suggests a filter on startup to identify 'single' devices
> and tag them accordingly. 

So you try to see if the board has a single device and mark them so that
you can skip the unique id, did I get that right?

What about the boards which have multiple devices? How doing solve
these?

> The uniqueID is then not used for the probe,
> and the device name omits the uniqueID as well.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.c   |  7 +++---
>  drivers/soundwire/slave.c | 52 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index fc53dbe57f85..be5d437058ed 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -422,10 +422,11 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
>  
>  static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
>  {
> -	if (slave->id.unique_id != id.unique_id ||
> -	    slave->id.mfg_id != id.mfg_id ||
> +	if (slave->id.mfg_id != id.mfg_id ||
>  	    slave->id.part_id != id.part_id ||
> -	    slave->id.class_id != id.class_id)
> +	    slave->id.class_id != id.class_id ||
> +	    (slave->id.unique_id != SDW_IGNORED_UNIQUE_ID &&
> +	     slave->id.unique_id != id.unique_id))
>  		return -ENODEV;
>  
>  	return 0;
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index 5dbc76772d21..19919975bb6d 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -29,10 +29,17 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	slave->dev.parent = bus->dev;
>  	slave->dev.fwnode = fwnode;
>  
> -	/* name shall be sdw:link:mfg:part:class:unique */
> -	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
> -		     bus->link_id, id->mfg_id, id->part_id,
> -		     id->class_id, id->unique_id);
> +	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
> +		/* name shall be sdw:link:mfg:part:class */
> +		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x",
> +			     bus->link_id, id->mfg_id, id->part_id,
> +			     id->class_id);
> +	} else {
> +		/* name shall be sdw:link:mfg:part:class:unique */
> +		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
> +			     bus->link_id, id->mfg_id, id->part_id,
> +			     id->class_id, id->unique_id);
> +	}
>  
>  	slave->dev.release = sdw_slave_release;
>  	slave->dev.bus = &sdw_bus_type;
> @@ -103,6 +110,7 @@ static bool find_slave(struct sdw_bus *bus,
>  int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  {
>  	struct acpi_device *adev, *parent;
> +	struct acpi_device *adev2, *parent2;
>  
>  	parent = ACPI_COMPANION(bus->dev);
>  	if (!parent) {
> @@ -112,10 +120,46 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>  
>  	list_for_each_entry(adev, &parent->children, node) {
>  		struct sdw_slave_id id;
> +		struct sdw_slave_id id2;
> +		bool ignore_unique_id = true;
>  
>  		if (!find_slave(bus, adev, &id))
>  			continue;
>  
> +		/* brute-force O(N^2) search for duplicates */
> +		parent2 = parent;
> +		list_for_each_entry(adev2, &parent2->children, node) {
> +
> +			if (adev == adev2)
> +				continue;
> +
> +			if (!find_slave(bus, adev2, &id2))
> +				continue;
> +
> +			if (id.sdw_version != id2.sdw_version ||
> +			    id.mfg_id != id2.mfg_id ||
> +			    id.part_id != id2.part_id ||
> +			    id.class_id != id2.class_id)
> +				continue;
> +
> +			if (id.unique_id != id2.unique_id) {
> +				dev_dbg(bus->dev,
> +					"Valid unique IDs %x %x for Slave mfg %x part %d\n",
> +					id.unique_id, id2.unique_id,
> +					id.mfg_id, id.part_id);
> +				ignore_unique_id = false;
> +			} else {
> +				dev_err(bus->dev,
> +					"Invalid unique IDs %x %x for Slave mfg %x part %d\n",
> +					id.unique_id, id2.unique_id,
> +					id.mfg_id, id.part_id);
> +				return -ENODEV;
> +			}
> +		}
> +
> +		if (ignore_unique_id)
> +			id.unique_id = SDW_IGNORED_UNIQUE_ID;
> +
>  		/*
>  		 * don't error check for sdw_slave_add as we want to continue
>  		 * adding Slaves
> -- 
> 2.20.1

-- 
~Vinod
