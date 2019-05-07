Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6EFC04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12E206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfEGCYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:24:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:40196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEGCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:24:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 19:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,440,1549958400"; 
   d="scan'208";a="149048898"
Received: from speesari-mobl.amr.corp.intel.com (HELO [10.251.22.59]) ([10.251.22.59])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2019 19:24:18 -0700
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
Message-ID: <b0059709-027e-26c4-25a1-bd55df7c507f@linux.intel.com>
Date:   Mon, 6 May 2019 21:24:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504065242.GA9770@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

I tried a quick hack and indeed we could simplify the code with 
something as simple as:

[attributes omitted]

static const struct attribute_group sdw_master_node_group = {
	.attrs = master_node_attrs,
	.name = "mipi-disco"
};

int sdw_sysfs_bus_init(struct sdw_bus *bus)
{
	return sysfs_create_group(&bus->dev->kobj, &sdw_master_node_group);
}

void sdw_sysfs_bus_exit(struct sdw_bus *bus)
{
	sysfs_remove_group(&bus->dev->kobj, &sdw_master_node_group);	
}

which gives me a simpler structure and doesn't require additional 
pretend-devices:

/sys/bus/acpi/devices/PRP00001:00/int-sdw.0/mipi-disco# ls
clock_gears
/sys/bus/acpi/devices/PRP00001:00/int-sdw.0/mipi-disco# more clock_gears
8086

The issue I have is that for the _show() functions, I don't see a way to 
go from the device argument to bus. In the example above I forced the 
output but would need a helper.

static ssize_t clock_gears_show(struct device *dev,
				struct device_attribute *attr, char *buf)
{
	struct sdw_bus *bus; // this is what I need to find from dev
	ssize_t size = 0;
	int i;

	return sprintf(buf, "%d \n", 8086);
}

my brain is starting to fry, but I don't see how container_of() would 
work here since the bus structure contains a pointer to the device. I 
don't also see a way to check for all devices for the bus_type soundwire.
For the slaves we do have a macro based on container_of(), so wondering 
if we made a mistake in the bus definition? Vinod, any thoughts?
