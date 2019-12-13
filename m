Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605BC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D762073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLMWQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:16:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:47588 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfLMWQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:16:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 14:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="239424482"
Received: from dmjacob-mobl2.amr.corp.intel.com (HELO [10.252.129.36]) ([10.252.129.36])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2019 14:16:15 -0800
Subject: Re: [alsa-devel] [PATCH v4 07/15] soundwire: slave: move uevent
 handling to slave
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-8-pierre-louis.bossart@linux.intel.com>
 <20191213072231.GE1750354@kroah.com>
 <032e6505-22b6-45bb-ff04-87db1f8d8be9@linux.intel.com>
 <20191213161122.GB2653074@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e05f0b2a-e9c5-3fb7-6459-f3388c305ac8@linux.intel.com>
Date:   Fri, 13 Dec 2019 16:15:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213161122.GB2653074@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/19 10:11 AM, Greg KH wrote:
> On Fri, Dec 13, 2019 at 09:11:27AM -0600, Pierre-Louis Bossart wrote:
>> On 12/13/19 1:22 AM, Greg KH wrote:
>>> On Thu, Dec 12, 2019 at 11:04:01PM -0600, Pierre-Louis Bossart wrote:
>>>> Currently the code deals with uevents at the bus level, but we only care
>>>> for Slave events
>>>
>>> What does this mean?  I can't understand it, can you please provide more
>>> information on what you are doing here?
>>
>> In the earlier versions of the patch, the code looks like this and there was
>> an open on what to do with a master-specific event.
>>
>>   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>> +	struct sdw_master_device *md;
>>   	struct sdw_slave *slave;
>>   	char modalias[32];
>>
>> -	if (is_sdw_slave(dev)) {
>> +	if (is_sdw_md(dev)) {
>> +		md = to_sdw_master_device(dev);
>> +		/* TODO: do we need to call add_uevent_var() ? */
>> +	} else if (is_sdw_slave(dev)) {
>>   		slave = to_sdw_slave_device(dev);
>> +
>> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
>> +
>> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
>> +			return -ENOMEM;
>>   	} else {
>>   		dev_warn(dev, "uevent for unknown Soundwire type\n");
>>   		return -EINVAL;
>>   	}
>>
>> Vinod suggested this was not needed and suggested the code for uevents be
>> moved to be slave-specific, which is what this patch does.
> 
> Then describe it really really well in the changelog text.  We have no
> rememberance of prior conversations when looking at commits in the tree
> in the future.

ok, will do.
