Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E7C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627FE22CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbfGZNne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:43:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:61886 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388209AbfGZNn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 06:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322042154"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 06:43:26 -0700
Subject: Re: [alsa-devel] [RFC PATCH 01/40] soundwire: add debugfs support
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-2-pierre-louis.bossart@linux.intel.com>
 <20190725221554.GA16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3a45625f-72a8-cb0c-1467-460000d1d8f7@linux.intel.com>
Date:   Fri, 26 Jul 2019 08:43:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725221554.GA16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/19 5:15 PM, Guennadi Liakhovetski wrote:
> Hi Pierre,
> 
> A couple of nitpicks:

Thanks for the feedback!

>>   create mode 100644 drivers/soundwire/debugfs.c
> 
> [snip]
> 
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 3048ca153f22..06ac4adb0074 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -18,6 +18,30 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>>   			  u64 addr, struct sdw_slave_id *id);
>>   
>> +#ifdef CONFIG_DEBUG_FS
>> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus);
>> +void sdw_bus_debugfs_exit(struct dentry *d);
>> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave);
>> +void sdw_slave_debugfs_exit(struct dentry *d);
>> +void sdw_debugfs_init(void);
>> +void sdw_debugfs_exit(void);
>> +#else
>> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
>> +{ return NULL; }
> 
> static?
> 
>> +
>> +void sdw_bus_debugfs_exit(struct dentry *d) {}
>> +
>> +struct dentry *sdw_slave_debugfs_init(struct sdw_slave *slave)
>> +{ return NULL; }
>> +
>> +void sdw_slave_debugfs_exit(struct dentry *d) {}
>> +
>> +void sdw_debugfs_init(void) {}
>> +
>> +void sdw_debugfs_exit(void) {}
> 
> Same for all the above. You could also declare them inline, but I really hope
> the compiler will be smart enough to do that itself.

yes, I'll add static inline for all this.

>> +struct dentry *sdw_bus_debugfs_init(struct sdw_bus *bus)
>> +{
>> +	struct dentry *d;
> 
> I would remove the above
> 
>> +	char name[16];
>> +
>> +	if (!sdw_debugfs_root)
>> +		return NULL;
>> +
>> +	/* create the debugfs master-N */
>> +	snprintf(name, sizeof(name), "master-%d", bus->link_id);
>> +	d = debugfs_create_dir(name, sdw_debugfs_root);
>> +
>> +	return d;
> 
> And just do
> 
> +	return debugfs_create_dir(name, sdw_debugfs_root);

yep, will do.

>> +static ssize_t sdw_sprintf(struct sdw_slave *slave,
>> +			   char *buf, size_t pos, unsigned int reg)
>> +{
>> +	int value;
>> +
>> +	value = sdw_read(slave, reg);
> 
> I personally would join the two lines above, but that's just a personal
> preference.

I prefer splitting variables and code, I just can't mentally split the two.

> 
>> +
>> +	if (value < 0)
>> +		return scnprintf(buf + pos, RD_BUF - pos, "%3x\tXX\n", reg);
>> +	else
> 
> I think it's advised to not use an else in such cases.
> 
> Thanks
> Guennadi
> 
>> +		return scnprintf(buf + pos, RD_BUF - pos,
>> +				"%3x\t%2x\n", reg, value);
>> +}

The intent was to provide a visual cue that the register is not 
implemented, which is quite useful. Not all registers are mandatory and 
not all vendors document the entire set of registers, so it's a good way 
to figure things out. The value is not used for any functional purpose, 
it's just a register dump for the integrator to look at. I'll add a note 
to explain the idea.
