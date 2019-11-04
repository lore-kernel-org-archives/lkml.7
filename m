Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B8BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7675821D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfKDOdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:33:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:2207 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfKDOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:33:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="402989557"
Received: from cckuo1-mobl2.amr.corp.intel.com (HELO [10.251.130.8]) ([10.251.130.8])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2019 06:32:57 -0800
Subject: Re: [alsa-devel] [PATCH 2/4] soundwire: add enumeration_complete
 structure
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
 <20191023210657.32440-3-pierre-louis.bossart@linux.intel.com>
 <20191103052243.GF2695@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <af5a7f19-045a-d4a8-8e17-99307724ac3f@linux.intel.com>
Date:   Mon, 4 Nov 2019 08:32:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191103052243.GF2695@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/19 12:22 AM, Vinod Koul wrote:
> On 23-10-19, 16:06, Pierre-Louis Bossart wrote:
>> We need an async mechanism to prevent access to Slaves that are not
>> fully-enumerated.
>>
>> init_completion() will be invoked when the Slave becomes UNATTACHED,
>> and complete() will be invoked when the state become ATTACHED. Any
>> read/write before this status change will be delayed with a
>> wait_for_completion().
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/linux/soundwire/sdw.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index a381a596212b..1381edfaa206 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -565,6 +565,7 @@ struct sdw_slave {
>>   	u16 dev_num;
>>   	bool probed;
>>   	struct completion probe_complete;
>> +	struct completion enumeration_complete;
> 
> Which series/patch uses this..?

[PATCH 00/18] soundwire: code hardening and suspend-resume support
