Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D788CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B067222C1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfKDOcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:32:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:2377 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbfKDOcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:32:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:32:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="402989494"
Received: from cckuo1-mobl2.amr.corp.intel.com (HELO [10.251.130.8]) ([10.251.130.8])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2019 06:32:38 -0800
Subject: Re: [alsa-devel] [PATCH 1/4] soundwire: sdw_slave: add new fields to
 track probe status
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
 <20191023210657.32440-2-pierre-louis.bossart@linux.intel.com>
 <20191103045604.GE2695@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f53b28bb-1ec7-a400-54ed-51fd55819ecd@linux.intel.com>
Date:   Mon, 4 Nov 2019 08:32:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191103045604.GE2695@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/19 11:56 PM, Vinod Koul wrote:
> On 23-10-19, 16:06, Pierre-Louis Bossart wrote:
>> Changes to the sdw_slave structure needed to solve race conditions on
>> driver probe.
> 
> Can you please explain the race you have observed, it would be a very
> useful to document it as well

the races are explained in the [PATCH 00/18] soundwire: code hardening 
and suspend-resume support series.

>>
>> The functionality is added in the next patch.
> 
> which one..?

[PATCH 00/18] soundwire: code hardening and suspend-resume support


> 
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/linux/soundwire/sdw.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index 688b40e65c89..a381a596212b 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -545,6 +545,10 @@ struct sdw_slave_ops {
>>    * @node: node for bus list
>>    * @port_ready: Port ready completion flag for each Slave port
>>    * @dev_num: Device Number assigned by Bus
>> + * @probed: boolean tracking driver state
>> + * @probe_complete: completion utility to control potential races
>> + * on startup between driver probe/initialization and SoundWire
>> + * Slave state changes/imp-def interrupts
>>    */
>>   struct sdw_slave {
>>   	struct sdw_slave_id id;
>> @@ -559,6 +563,8 @@ struct sdw_slave {
>>   	struct list_head node;
>>   	struct completion *port_ready;
>>   	u16 dev_num;
>> +	bool probed;
>> +	struct completion probe_complete;
>>   };
>>   
>>   #define dev_to_sdw_dev(_dev) container_of(_dev, struct sdw_slave, dev)
>> -- 
>> 2.20.1
> 
