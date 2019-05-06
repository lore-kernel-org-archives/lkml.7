Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B043C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D3720578
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEFQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:43:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:55209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfEFQny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:43:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 09:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="230000844"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2019 09:43:53 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 08F6258010A;
        Mon,  6 May 2019 09:43:51 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 1/7] soundwire: Add sysfs support for
 master(s)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-2-pierre-louis.bossart@linux.intel.com>
 <20190504065242.GA9770@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b36e5b42-6069-0a73-8cab-7fcfc999f3a8@linux.intel.com>
Date:   Mon, 6 May 2019 11:43:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504065242.GA9770@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick feedback Greg!

>> +static const struct attribute_group sdw_master_node_group = {
>> +	.attrs = master_node_attrs,
>> +};
>> +
>> +static const struct attribute_group *sdw_master_node_groups[] = {
>> +	&sdw_master_node_group,
>> +	NULL
>> +};
> 
> Minor nit, you can use the ATTRIBUTE_GROUPS() macro here to save you a
> few lines.

will do.

>> +
>> +static void sdw_device_release(struct device *dev)
>> +{
>> +	struct sdw_master_sysfs *master = to_sdw_device(dev);
>> +
>> +	kfree(master);
>> +}
>> +
>> +static struct device_type sdw_device_type = {
>> +	.name =	"sdw_device",
>> +	.release = sdw_device_release,
>> +};
>> +
>> +int sdw_sysfs_bus_init(struct sdw_bus *bus)
>> +{
>> +	struct sdw_master_sysfs *master;
>> +	int err;
>> +
>> +	if (bus->sysfs) {
>> +		dev_err(bus->dev, "SDW sysfs is already initialized\n");
>> +		return -EIO;
>> +	}
>> +
>> +	master = kzalloc(sizeof(*master), GFP_KERNEL);
>> +	if (!master)
>> +		return -ENOMEM;
> 
> Why are you creating a whole new device to put all of this under?  Is
> this needed?  What will the sysfs tree look like when you do this?  Why
> can't the "bus" device just get all of these attributes and no second
> device be created?

This is indeed my main question on this code (see cover letter) and why 
I tagged the series as RFC. I find it odd to create an int-sdw.0 
platform device to model the SoundWire master, and a sdw-master:0 device 
whose purpose is only to expose the properties of that master. it'd be 
simpler if all the properties were exposed one level up.

Vinod and Sanyog might be able to shed some light on this?
