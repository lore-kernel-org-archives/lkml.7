Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563AFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F7A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502055AbfJXMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:41:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:7929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfJXMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:41:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 05:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="188577330"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 05:41:55 -0700
Received: from atirumal-mobl1.amr.corp.intel.com (unknown [10.251.26.228])
        by linux.intel.com (Postfix) with ESMTP id B986658029F;
        Thu, 24 Oct 2019 05:41:54 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 1/3] soundwire: remove bitfield for
 unique_id, use u8
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
 <20191022234808.17432-2-pierre-louis.bossart@linux.intel.com>
 <20191024112955.GC2620@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3b41953e-df3b-cf20-dae9-f3635c532895@linux.intel.com>
Date:   Thu, 24 Oct 2019 07:42:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024112955.GC2620@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 6:29 AM, Vinod Koul wrote:
> On 22-10-19, 18:48, Pierre-Louis Bossart wrote:
>> There is no good reason why the unique_id needs to be stored as 4
>> bits. The code will work without changes with a u8 since all values
> 
> Well this was due to the fact the slave id defined by MIPI has unique id
> as 4 bits. In fact if you look closely there are other fields in
> sdw_slave_id doing this

it's not because we extract 4 bits that we need to store the information 
in 4 bits.

> 
>> are already filtered while parsing the ACPI tables and Slave devID
>> registers.
>>
>> Use u8 representation. This will allow us to encode a
>> "IGNORE_UNIQUE_ID" value to account for firmware/BIOS creativity.
> 
> Why are we shoving firmware/BIOS issues into the core?

The core uses a matching formula which is too strict and does not work 
on multiple platforms.

You can argue that the BIOS should be fixed, but the counter argument is 
that the practice of ignoring the unique ID is allowed by the MIPI standard.

> 
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/linux/soundwire/sdw.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index 688b40e65c89..28745b9ba279 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -403,6 +403,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave);
>>    * SDW Slave Structures and APIs
>>    */
>>   
>> +#define SDW_IGNORED_UNIQUE_ID 0xFF
>> +
>>   /**
>>    * struct sdw_slave_id - Slave ID
>>    * @mfg_id: MIPI Manufacturer ID
>> @@ -418,7 +420,7 @@ struct sdw_slave_id {
>>   	__u16 mfg_id;
>>   	__u16 part_id;
>>   	__u8 class_id;
>> -	__u8 unique_id:4;
>> +	__u8 unique_id;
>>   	__u8 sdw_version:4;
>>   };
>>   
>> -- 
>> 2.20.1
> 

