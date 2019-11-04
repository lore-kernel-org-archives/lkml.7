Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DADECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA3E21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfKDV4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:56:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:13965 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388293AbfKDV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:56:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 13:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="226888814"
Received: from trowland-mobl.amr.corp.intel.com (HELO [10.254.97.182]) ([10.254.97.182])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2019 13:56:01 -0800
Subject: Re: [alsa-devel] [PATCH 06/14] soundwire: add support for
 sdw_slave_type
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-7-pierre-louis.bossart@linux.intel.com>
 <71b50d6d-0000-340a-eb5d-6a63564dd2d6@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0290d80b-08fc-d85f-3f9b-fea41d3df3a8@linux.intel.com>
Date:   Mon, 4 Nov 2019 13:41:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <71b50d6d-0000-340a-eb5d-6a63564dd2d6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> @@ -49,9 +49,16 @@ int sdw_slave_modalias(const struct sdw_slave 
>> *slave, char *buf, size_t size)
>>   static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>> -    struct sdw_slave *slave = to_sdw_slave_device(dev);
>> +    struct sdw_slave *slave;
>>       char modalias[32];
>> +    if (is_sdw_slave(dev)) {
>> +        slave = to_sdw_slave_device(dev);
>> +    } else {
>> +        dev_warn(dev, "uevent for unknown Soundwire type\n");
>> +        return -EINVAL;
>> +    }
>> +
>>       sdw_slave_modalias(slave, modalias, sizeof(modalias));
>>       if (add_uevent_var(env, "MODALIAS=%s", modalias))
> 
> Positive evaluation of is_sdw_slave() check is required for function to 
> continue, thus you might as well do:
> 
> if (!is_sdw_slave(dev)) {
>      dev_warn();
>      return -EINVAL;
> }
> 
> slave = to_sdw_slave_device(dev);

see the following patch 7, it becomes a 2-case test (slave and master).
I am all for optimizations but wait until the actual changes are added...
