Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A22C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D456220B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfHETS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:18:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:37794 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfHETS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:18:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 12:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="373180072"
Received: from amerhebi-mobl1.amr.corp.intel.com (HELO [10.251.154.70]) ([10.251.154.70])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2019 12:18:35 -0700
Subject: Re: [alsa-devel] [RFC PATCH 28/40] soundwire: intel: handle disabled
 links
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-29-pierre-louis.bossart@linux.intel.com>
 <20190805165729.GC24889@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4c4e64fb-9657-0312-a19f-2a17b44fbae3@linux.intel.com>
Date:   Mon, 5 Aug 2019 14:18:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805165729.GC24889@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/19 11:57 AM, Sanyog Kale wrote:
> On Thu, Jul 25, 2019 at 06:40:20PM -0500, Pierre-Louis Bossart wrote:
>> On most hardware platforms, SoundWire interfaces are pin-muxed with
>> other interfaces (typically DMIC or I2S) and the status of each link
>> needs to be checked at boot time.
>>
>> For Intel platforms, the BIOS provides a menu to enable/disable the
>> links separately, and the information is provided to the OS with an
>> Intel-specific _DSD property. The same capability will be added to
>> revisions of the MIPI DisCo specification.

[snip]

>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index c7dfc824be80..f78b076a8782 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -380,6 +380,7 @@ struct sdw_slave_prop {
>>    * @err_threshold: Number of times that software may retry sending a single
>>    * command
>>    * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
>> + * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
>>    */
>>   struct sdw_master_prop {
>>   	u32 revision;
>> @@ -395,6 +396,7 @@ struct sdw_master_prop {
>>   	bool dynamic_frame;
>>   	u32 err_threshold;
>>   	u32 mclk_freq;
>> +	bool hw_disabled;
> 
> Do we have such cases where some of SoundWire links are disabled and
> some enabled?

Yes, by default my ICL test board uses HDaudio for the codec so the 
SoundWire link0 is disabled. If I rework the board and change the BIOS 
advanced menu then SoundWire link0 is enabled. This information is 
dynamically provided to the OS after the _INI step.
SoundWire-2/3 are used typically for attached DMICs or for a combination 
of SoundWire amplifier and mic capture. It's really platform-specific.

> 
>>   };
>>   
>>   int sdw_master_read_prop(struct sdw_bus *bus);
>> -- 
>> 2.20.1
>>
> 
