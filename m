Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD21C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfLKOW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:22:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:10486 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKOW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:22:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 06:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="215796782"
Received: from unknown (HELO pbossart-mac02.local) ([10.254.97.107])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2019 06:22:27 -0800
Subject: Re: [alsa-devel] [PATCH v4 05/11] soundwire: intel: update interfaces
 between ASoC and SoundWire
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
 <20191209235520.18727-6-pierre-louis.bossart@linux.intel.com>
 <20191211114247.GI2536@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <13e24f85-bf48-cf63-d738-dfb62b28a814@linux.intel.com>
Date:   Wed, 11 Dec 2019 08:22:26 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211114247.GI2536@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 5:42 AM, Vinod Koul wrote:
> On 09-12-19, 17:55, Pierre-Louis Bossart wrote:
> 
>> @@ -138,8 +126,6 @@ static struct sdw_intel_ctx
>>   		pdevinfo.name = "int-sdw";
>>   		pdevinfo.id = i;
>>   		pdevinfo.fwnode = acpi_fwnode_handle(adev);
>> -		pdevinfo.data = &link->res;
>> -		pdevinfo.size_data = sizeof(link->res);
>>   
>>   		pdev = platform_device_register_full(&pdevinfo);
>>   		if (IS_ERR(pdev)) {
>> @@ -224,10 +210,8 @@ EXPORT_SYMBOL(sdw_intel_init);
> 
> This is still exported
> 
>>   struct sdw_intel_res {
>> +	int count;
>>   	void __iomem *mmio_base;
>>   	int irq;
>>   	acpi_handle handle;
>>   	struct device *parent;
>>   	const struct sdw_intel_ops *ops;
>> -	void *arg;
>> +	struct device *dev;
>> +	u32 link_mask;
>>   };
>>   
>> -void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res);
> 
> But prototype removed, so i think this is a miss in the series, can you
> fix that up

This is updated in a later patch that implements the new interfaces

-EXPORT_SYMBOL(sdw_intel_init);
+EXPORT_SYMBOL(sdw_intel_acpi_scan);

I will fix this but since there is no user for that function there will 
be no impact.

