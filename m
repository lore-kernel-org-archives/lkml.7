Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE140C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BCB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfDHSXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:23:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:56792 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfDHSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:23:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 11:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="147550354"
Received: from wfang3-mobl.amr.corp.intel.com (HELO [10.254.107.245]) ([10.254.107.245])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2019 11:23:13 -0700
Subject: Re: [alsa-devel] [PATCH] soundwire: fix pm_runtime_get_sync return
 code checks
To:     Jan Kotas <jank@cadence.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "sanyog.r.kale@intel.com" <sanyog.r.kale@intel.com>
References: <20190405072655.25995-1-jank@cadence.com>
 <367316fa-9d92-2dfc-32c4-3e0e8c76ef43@linux.intel.com>
 <92538D7E-C628-40AC-AFE9-52C97B3BC42D@global.cadence.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ace7e7f7-c3bf-f38c-0e70-da826175e3c5@linux.intel.com>
Date:   Mon, 8 Apr 2019 12:43:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <92538D7E-C628-40AC-AFE9-52C97B3BC42D@global.cadence.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/19 2:12 AM, Jan Kotas wrote:
> 
> 
>> On 5 Apr 2019, at 17:04, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> On 4/5/19 2:26 AM, Jan Kotas wrote:
>>>
>>>   
>>>   	ret = pm_runtime_get_sync(slave->bus->dev);
>>> -	if (ret < 0)
>>> +	if (ret < 0 && ret != -EACCES)
>>>
>> There was a patch submitted on 3/28 by Srinivas Kandagatla who suggested an alternate solution for exactly the same code.
>>
>> +	if (pm_runtime_enabled(slave->bus->dev)) {
>> +		ret = pm_runtime_get_sync(slave->bus->dev);
>> +		if (ret < 0)
>> +			return ret;
>>
>> I am far from an expert on pm_runtime but Srinivas' solution looks more elegant to me.
> 
> Hello Pierre,
> 
> Please take a look at this patch, that was my inspiration:
> https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html

The two patches seems to be identical:

static inline bool pm_runtime_enabled(struct device *dev)
{
	return !dev->power.disable_depth;
}

static int rpm_resume()
[...]
else if (dev->power.disable_depth > 0)
		retval = -EACCES;


However I am still not clear on why this might fail.

I can only think of one possible explanation: there is no explicit 
pm_runtime_enable() in the soundwire code, so maybe the expectation is 
that the pm_runtime status is inherited from the parent (in the intel 
case the PCI driver), and that's missing in non-intel configurations?

> I also took a look, and it seems the value returned by
> pm_runtime_get_syncis simply ignored in a lot of places,
> so checking its value may be excessive.
But not checking seems careless at best...
