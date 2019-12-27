Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF142C47409
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E9E2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfL1AQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:16:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:58305 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL1AQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:16:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 16:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="243364217"
Received: from vdoan2-mobl.ccr.corp.intel.com (HELO [10.251.152.151]) ([10.251.152.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 16:16:08 -0800
Subject: Re: [alsa-devel] [PATCH v5 06/17] soundwire: add support for
 sdw_slave_type
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-7-pierre-louis.bossart@linux.intel.com>
 <20191227070301.GK3006@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2913a70d-f1e1-7d91-eb3c-33005c5c4007@linux.intel.com>
Date:   Fri, 27 Dec 2019 17:26:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227070301.GK3006@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>> -	struct sdw_slave *slave = to_sdw_slave_device(dev);
>> +	struct sdw_slave *slave;
>>   	char modalias[32];
>>   
>> -	sdw_slave_modalias(slave, modalias, sizeof(modalias));
>> -
>> -	if (add_uevent_var(env, "MODALIAS=%s", modalias))
>> -		return -ENOMEM;
>> +	if (is_sdw_slave(dev)) {
>> +		slave = to_sdw_slave_device(dev);
>> +
>> +		sdw_slave_modalias(slave, modalias, sizeof(modalias));
>> +
>> +		if (add_uevent_var(env, "MODALIAS=%s", modalias))
>> +			return -ENOMEM;
>> +	} else {
>> +		/*
>> +		 * We only need to handle uevents for the Slave device
>> +		 * type. This error cannot happen unless the .uevent
>> +		 * callback is set to use this function for a
>> +		 * different device type (e.g. Master or Monitor)
>> +		 */
>> +		dev_err(dev, "uevent for unknown Soundwire type\n");
>> +		return -EINVAL;
> 
> At this point and after next patch, the above code would be a no-op, do
> we want this here, if so why?

to be future proof if someone wants to add support for a monitor, as 
explained above.
I can remove this if you don't want it.
