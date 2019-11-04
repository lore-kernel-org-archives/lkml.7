Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E964ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C740421D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfKDOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:44:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:29247 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfKDOoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:44:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="402993333"
Received: from cckuo1-mobl2.amr.corp.intel.com (HELO [10.251.130.8]) ([10.251.130.8])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2019 06:44:09 -0800
Subject: Re: [alsa-devel] [PATCH 06/14] soundwire: add support for
 sdw_slave_type
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-7-pierre-louis.bossart@linux.intel.com>
 <20191103053243.GI2695@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d0f4cf88-7799-6176-2336-7bdacbd2b621@linux.intel.com>
Date:   Mon, 4 Nov 2019 08:35:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191103053243.GI2695@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/19 12:32 AM, Vinod Koul wrote:
> On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
>> Currently the bus does not have any explicit support for master
>> devices.  Add explicit support for sdw_slave_type, so that in
>> follow-up patches we can add support for the sdw_md_type (md==Master
>> Device), following the Grey Bus example.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus_type.c       | 9 ++++++++-
>>   drivers/soundwire/slave.c          | 7 ++++++-
>>   include/linux/soundwire/sdw_type.h | 6 ++++++
>>   3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
>> index 9a0fd3ee1014..5df095f4e12f 100644
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -49,9 +49,16 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
>>   
>>   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
>> +	struct sdw_slave *slave;
>>   	char modalias[32];
>>   
>> +	if (is_sdw_slave(dev)) {
>> +		slave = to_sdw_slave_device(dev);
>> +	} else {
>> +		dev_warn(dev, "uevent for unknown Soundwire type\n");
>> +		return -EINVAL;
> 
> when is the case where this would be triggered?

this is in preparation for the master case, where you will have 2 types 
of devices, so need to check if the type is correct.

