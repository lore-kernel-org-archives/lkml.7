Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AB42176D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfL1AQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:16:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:58305 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL1AQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:16:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 16:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="243364220"
Received: from vdoan2-mobl.ccr.corp.intel.com (HELO [10.251.152.151]) ([10.251.152.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 16:16:10 -0800
Subject: Re: [alsa-devel] [PATCH v5 08/17] soundwire: add initial definitions
 for sdw_master_device
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
 <20191227071433.GL3006@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
Date:   Fri, 27 Dec 2019 17:38:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227071433.GL3006@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/27/19 1:14 AM, Vinod Koul wrote:
> On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
>> Since we want an explicit support for the SoundWire Master device, add
>> the definitions, following the Greybus example of a 'Host Device'.
>>
>> A parent (such as the Intel audio controller) would use sdw_md_add()
>> to create the device, passing a driver as a parameter. The
>> sdw_md_release() would be called when put_device() is invoked by the
>> parent. We use the shortcut 'md' for 'master device' to avoid very
>> long function names.
> 
> I agree we should not have long name :) but md does not sound great. Can
> we drop the device and use sdw_slave and sdw_master for devices and
> append _driver when we are talking about drivers...
> 
> we dont use sd for slave and imo this would gel well with existing names

In SoundWire parlance, both 'Slave' and 'Master' are 'Devices', so yes 
we do in the standard talk about 'Slave Devices' and 'Master Devices'.

Then we have Linux 'Devices' which can be used for both.

If we use 'sdw_slave', would we be referring to the actual physical part 
or the Linux device?

FWIW the Greybus example used 'Host Device' and 'hd' as shortcut.

> 
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -66,7 +66,10 @@ int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   		 * callback is set to use this function for a
>>   		 * different device type (e.g. Master or Monitor)
>>   		 */
>> -		dev_err(dev, "uevent for unknown Soundwire type\n");
>> +		if (is_sdw_master_device(dev))
>> +			dev_err(dev, "uevent for SoundWire Master type\n");
> 
> see below [1]:
> 
>> +static void sdw_md_release(struct device *dev)
> 
> sdw_master_release() won't be too long!

yes, but there is no such operation as 'Master Release' in SoundWire.
At least the 'md' shortcut conveys the implicit convention that this is 
a Linux device only.

I really would like to avoid overloading the standard definitions with 
the Linux ones...

> 
>> +{
>> +	struct sdw_master_device *md = to_sdw_master_device(dev);
>> +
>> +	kfree(md);
>> +}
>> +
>> +struct device_type sdw_md_type = {
> 
> sdw_master_type and so on :)
> 
>> +	.name =		"soundwire_master",
>> +	.release =	sdw_md_release,
> 
> [1]:
> There is no uevent added here, so sdw_uevent() will never be called for
> this, can you check again if you see the print you added?

as explained this is to avoid errors at a later point. I don't see any 
harm in providing error checks for a routine that can only be used for 1 
of the 3 devices defined in the standard?

>>   
>> +struct sdw_master_device {
> 
> we have sdw_slave, so would be better if we call this sdw_master
> 
>> +	struct device dev;
>> +	int link_id;
>> +	struct sdw_md_driver *driver;
>> +	void *pdata;
> 
> no sdw_bus pointer and I dont see bus adding this object.. Is there no
> link between bus and master device objects?

There is currently no bus device object, see the structure definition 
it's a pointer to a device (which leads to all sorts of issues because 
we can't use container_of).

when the master device gets added, that's where the Linux device is 
created and the pointer saved in the bus structure, with IIRC 
sdw_add_bus_master().


  	ret = sdw_add_bus_master(&sdw->cdns.bus);
