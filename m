Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437F1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BCA21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502237AbfJXM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:58:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:11911 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730113AbfJXM6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:58:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 05:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="210373133"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2019 05:58:48 -0700
Received: from atirumal-mobl1.amr.corp.intel.com (unknown [10.251.26.228])
        by linux.intel.com (Postfix) with ESMTP id 9D0D158049A;
        Thu, 24 Oct 2019 05:58:47 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 3/3] soundwire: ignore uniqueID when
 irrelevant
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
 <20191022234808.17432-4-pierre-louis.bossart@linux.intel.com>
 <20191024113911.GD2620@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cd8637df-a400-a683-13b9-fd98231d0134@linux.intel.com>
Date:   Thu, 24 Oct 2019 07:59:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024113911.GD2620@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 6:39 AM, Vinod Koul wrote:
> On 22-10-19, 18:48, Pierre-Louis Bossart wrote:
>> The uniqueID is useful when there are two or more devices of the same
>> type (identical manufacturer ID, part ID) on the same link.
> 
> Right!

the key part is "two or more". When it's "one" then the uniqueID has no 
defined meaning.

> 
>> When there is a single device of a given type on a link, its uniqueID
>> is irrelevant. It's not uncommon on actual platforms to see variations
>> of the uniqueID, or differences between devID registers and ACPI _ADR
>> fields.
> 
> Ideally this should be fixed in firmware, I do not like the fact the we are
> poking in core for firmware issues!

I will be the first to complain about BIOS issues, and the need for 
workarounds in the kernel, but here the BIOS vendors rely on permissions 
defined in the standard, see lines 3320..31 in the MIPI SoundWire 1.2 
document. You will see that there is no requirement to use the full set 
of devID registers to identify a Slave device. The only requirement is 
to read devID0 first to force a state machine transition and enable 
arbitration.

In other words, it's a nice case of BIOS folks telling the kernel folks 
we are too strict in our interpretation of the standard, and what they 
do is a feature and not a bug.

> 
>> This patch suggests a filter on startup to identify 'single' devices
>> and tag them accordingly.
> 
> So you try to see if the board has a single device and mark them so that
> you can skip the unique id, did I get that right?
> 
> What about the boards which have multiple devices? How doing solve
> these?

The uniqueID is used when multiple devices of the same type are detected 
in ACPI tables. No change, see [1] below

> 
>> The uniqueID is then not used for the probe,
>> and the device name omits the uniqueID as well.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.c   |  7 +++---
>>   drivers/soundwire/slave.c | 52 ++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index fc53dbe57f85..be5d437058ed 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -422,10 +422,11 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
>>   
>>   static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
>>   {
>> -	if (slave->id.unique_id != id.unique_id ||
>> -	    slave->id.mfg_id != id.mfg_id ||
>> +	if (slave->id.mfg_id != id.mfg_id ||
>>   	    slave->id.part_id != id.part_id ||
>> -	    slave->id.class_id != id.class_id)
>> +	    slave->id.class_id != id.class_id ||
>> +	    (slave->id.unique_id != SDW_IGNORED_UNIQUE_ID &&
>> +	     slave->id.unique_id != id.unique_id))

[1] this is where the unique_id is ignored if it was tagged as 
irrelevant while scanning ACPI tables. If it is not ignored, then the 
same comparison applied

>>   		return -ENODEV;
>>   
>>   	return 0;
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index 5dbc76772d21..19919975bb6d 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -29,10 +29,17 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>   	slave->dev.parent = bus->dev;
>>   	slave->dev.fwnode = fwnode;
>>   
>> -	/* name shall be sdw:link:mfg:part:class:unique */
>> -	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
>> -		     bus->link_id, id->mfg_id, id->part_id,
>> -		     id->class_id, id->unique_id);
>> +	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
>> +		/* name shall be sdw:link:mfg:part:class */
>> +		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x",
>> +			     bus->link_id, id->mfg_id, id->part_id,
>> +			     id->class_id);
>> +	} else {
>> +		/* name shall be sdw:link:mfg:part:class:unique */
>> +		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
>> +			     bus->link_id, id->mfg_id, id->part_id,
>> +			     id->class_id, id->unique_id);
>> +	}
>>   
>>   	slave->dev.release = sdw_slave_release;
>>   	slave->dev.bus = &sdw_bus_type;
>> @@ -103,6 +110,7 @@ static bool find_slave(struct sdw_bus *bus,
>>   int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   {
>>   	struct acpi_device *adev, *parent;
>> +	struct acpi_device *adev2, *parent2;
>>   
>>   	parent = ACPI_COMPANION(bus->dev);
>>   	if (!parent) {
>> @@ -112,10 +120,46 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   
>>   	list_for_each_entry(adev, &parent->children, node) {
>>   		struct sdw_slave_id id;
>> +		struct sdw_slave_id id2;
>> +		bool ignore_unique_id = true;
>>   
>>   		if (!find_slave(bus, adev, &id))
>>   			continue;
>>   
>> +		/* brute-force O(N^2) search for duplicates */
>> +		parent2 = parent;
>> +		list_for_each_entry(adev2, &parent2->children, node) {
>> +
>> +			if (adev == adev2)
>> +				continue;
>> +
>> +			if (!find_slave(bus, adev2, &id2))
>> +				continue;
>> +
>> +			if (id.sdw_version != id2.sdw_version ||
>> +			    id.mfg_id != id2.mfg_id ||
>> +			    id.part_id != id2.part_id ||
>> +			    id.class_id != id2.class_id)
>> +				continue;
>> +
>> +			if (id.unique_id != id2.unique_id) {
>> +				dev_dbg(bus->dev,
>> +					"Valid unique IDs %x %x for Slave mfg %x part %d\n",
>> +					id.unique_id, id2.unique_id,
>> +					id.mfg_id, id.part_id);
>> +				ignore_unique_id = false;
>> +			} else {
>> +				dev_err(bus->dev,
>> +					"Invalid unique IDs %x %x for Slave mfg %x part %d\n",
>> +					id.unique_id, id2.unique_id,
>> +					id.mfg_id, id.part_id);
>> +				return -ENODEV;
>> +			}
>> +		}
>> +
>> +		if (ignore_unique_id)
>> +			id.unique_id = SDW_IGNORED_UNIQUE_ID;
>> +
>>   		/*
>>   		 * don't error check for sdw_slave_add as we want to continue
>>   		 * adding Slaves
>> -- 
>> 2.20.1
> 

