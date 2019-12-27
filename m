Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5188C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE32168B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfL1AQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:16:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:58305 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL1AQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:16:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 16:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="scan'208";a="243364207"
Received: from vdoan2-mobl.ccr.corp.intel.com (HELO [10.251.152.151]) ([10.251.152.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 16:16:06 -0800
Subject: Re: [alsa-devel] [PATCH v5 03/17] soundwire: rename
 drv_to_sdw_slave_driver macro
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
 <20191217210314.20410-4-pierre-louis.bossart@linux.intel.com>
 <20191227070011.GJ3006@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e5b45832-6a7e-1538-8069-ef366b87a8b7@linux.intel.com>
Date:   Fri, 27 Dec 2019 17:23:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227070011.GJ3006@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/27/19 1:00 AM, Vinod Koul wrote:
> On 17-12-19, 15:03, Pierre-Louis Bossart wrote:
>> Align with previous renames and shorten macro
>>
>> No functionality change
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus_type.c       | 9 ++++-----
>>   include/linux/soundwire/sdw_type.h | 3 ++-
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
>> index c0585bcc8a41..2b2830b622fa 100644
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -34,7 +34,7 @@ sdw_get_device_id(struct sdw_slave *slave, struct sdw_driver *drv)
>>   static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
>>   {
>>   	struct sdw_slave *slave = to_sdw_slave_device(dev);
>> -	struct sdw_driver *drv = drv_to_sdw_slave_driver(ddrv);
>> +	struct sdw_driver *drv = to_sdw_slave_driver(ddrv);
> 
> so patch 1 does:
> 
> -       struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
> +       struct sdw_driver *drv = drv_to_sdw_slave_driver(dev->driver);
> 
> and here we move drv_to_sdw_slave_driver to to_sdw_slave_driver... why
> not do this in first patch and save step1... or did i miss something??

because patch1 introduces replaces 'sdw_' by 'sdw_slave_' in several 
places, not just for drv_to_sdw_driver()

I can squash all these patches if you want to but then you'll tell me 
one step at a time...
