Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BFB20578
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfEFQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:46:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:4605 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfEFQqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:46:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 09:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="171355585"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2019 09:46:08 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 8116D58010A;
        Mon,  6 May 2019 09:46:07 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
To:     Vinod Koul <vkoul@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
 <20190506151953.GA13178@kroah.com> <20190506162208.GI3845@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <be72bbb1-b51f-8201-fdff-958836ed94d1@linux.intel.com>
Date:   Mon, 6 May 2019 11:46:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506162208.GI3845@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 11:22 AM, Vinod Koul wrote:
> On 06-05-19, 17:19, Greg KH wrote:
>> On Mon, May 06, 2019 at 09:42:35AM -0500, Pierre-Louis Bossart wrote:
>>>>> +
>>>>> +int sdw_sysfs_slave_init(struct sdw_slave *slave)
>>>>> +{
>>>>> +	struct sdw_slave_sysfs *sysfs;
>>>>> +	unsigned int src_dpns, sink_dpns, i, j;
>>>>> +	int err;
>>>>> +
>>>>> +	if (slave->sysfs) {
>>>>> +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
>>>>> +		err = -EIO;
>>>>> +		goto err_ret;
>>>>> +	}
>>>>> +
>>>>> +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
>>>>
>>>> Same question as patch 1, why a new device?
>>>
>>> yes it's the same open. In this case, the slave devices are defined at a
>>> different level so it's also confusing to create a device to represent the
>>> slave properties. The code works but I am not sure the initial directions
>>> are correct.
>>
>> You can just make a subdir for your attributes by using the attribute
>> group name, if a subdirectory is needed just to keep things a bit more
>> organized.
> 
> The key here is 'a subdir' which is not the case here. We did discuss
> this in the initial patches for SoundWire which had sysfs :)
> 
> The way MIPI disco spec organized properties, we have dp0 and dpN
> properties each of them requires to have a subdir of their own and that
> was the reason why I coded it to be creating a device.

Vinod, the question was not for dp0 and dpN, it's fine to have 
subdirectories there, but rather why we need separate devices for the 
master and slave properties.

> 
> Do we have a better way to handle this?
> 
>> Otherwise, you need to mess with having multiple "types" of struct
>> device all associated with the same bus.  It is possible, and not that
>> hard, but I don't think you are doing that here.
>>
>> thnaks,
>>
>> greg k-h
> 

