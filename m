Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B135C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14655208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfHFQPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:15:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:48602 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387493AbfHFQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:15:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 09:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="174218905"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.15.113]) ([10.252.15.113])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2019 09:06:16 -0700
Subject: Re: [alsa-devel] [PATCH 06/17] soundwire: cadence_master: use
 firmware defaults for frame shape
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Blauciak@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        Slawomir <slawomir.blauciak@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-7-pierre-louis.bossart@linux.intel.com>
 <03b6091b-af41-ac54-43c7-196a3583a731@intel.com>
 <024b4fb4-bdfa-a6dc-48bb-c070f2ed36b2@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <2445b5dc-246c-9c3b-b26e-784032feccf9@intel.com>
Date:   Tue, 6 Aug 2019 18:06:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <024b4fb4-bdfa-a6dc-48bb-c070f2ed36b2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-06 17:36, Pierre-Louis Bossart wrote:
> 
> 
> On 8/6/19 10:27 AM, Cezary Rojewski wrote:
>> On 2019-08-06 02:55, Pierre-Louis Bossart wrote:
>>> diff --git a/drivers/soundwire/cadence_master.c 
>>> b/drivers/soundwire/cadence_master.c
>>> index 5d9729b4d634..89c55e4bb72c 100644
>>> --- a/drivers/soundwire/cadence_master.c
>>> +++ b/drivers/soundwire/cadence_master.c
>>> @@ -48,6 +48,8 @@
>>>   #define CDNS_MCP_SSPSTAT            0xC
>>>   #define CDNS_MCP_FRAME_SHAPE            0x10
>>>   #define CDNS_MCP_FRAME_SHAPE_INIT        0x14
>>> +#define CDNS_MCP_FRAME_SHAPE_COL_MASK        GENMASK(2, 0)
>>> +#define CDNS_MCP_FRAME_SHAPE_ROW_OFFSET        3
>>>   #define CDNS_MCP_CONFIG_UPDATE            0x18
>>>   #define CDNS_MCP_CONFIG_UPDATE_BIT        BIT(0)
>>> @@ -175,7 +177,6 @@
>>>   /* Driver defaults */
>>>   #define CDNS_DEFAULT_CLK_DIVIDER        0
>>> -#define CDNS_DEFAULT_FRAME_SHAPE        0x30
>>>   #define CDNS_DEFAULT_SSP_INTERVAL        0x18
>>>   #define CDNS_TX_TIMEOUT                2000
>>> @@ -901,6 +902,20 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>>>   }
>>>   EXPORT_SYMBOL(sdw_cdns_pdi_init);
>>> +static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
>>> +{
>>> +    u32 val;
>>> +    int c;
>>> +    int r;
>>> +
>>> +    r = sdw_find_row_index(n_rows);
>>> +    c = sdw_find_col_index(n_cols) & CDNS_MCP_FRAME_SHAPE_COL_MASK;
>>> +
>>> +    val = (r << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | c;
>>> +
>>> +    return val;
>>> +}
>>> +
>>
>> Guess this have been said already, but this function could be 
>> simplified - unless you really want to keep explicit variable 
>> declaration. Both "c" and "r" declarations could be merged into single 
>> line while "val" is not needed at all.
>>
>> One more thing - is AND bitwise op really needed for cols explicitly? 
>> We know all col values upfront - these are static and declared in 
>> global table nearby. Static declaration takes care of "initial 
>> range-check". Is another one necessary?
>>
>> Moreover, this is a _get_ and certainly not a _set_ type of function. 
>> I'd even consider renaming it to: "cdns_get_frame_shape" as this is 
>> neither a _set_ nor an explicit initial frame shape setter.
>>
>> It might be even helpful to split two usages:
>>
>> #define sdw_frame_shape(col_idx, row_idx) \
>>      ((row_idx << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | col_idx)
>>
>> u32 cdns_get_frame_shape(u16 rows, u16 cols)
>> {
>>      u16 c, r;
>>
>>      r = sdw_find_row_index(rows);
>>      c = sdw_find_col_index(cols);
>>
>>      return sdw_frame_shape(c, r);
>> }
>>
>> The above may even be simplified into one-liner.
> 
> This is a function used once on startup, there is no real need to 
> simplify further. The separate variables help add debug traces as needed 
> and keep the code readable while showing how the values are encoded into 
> a register.

Eh, I've thought it's gonna be exposed to userspace (via uapi) so it can 
be fetched by tests or tools.

In such case - if there is a single usage only - guess function is fine 
as is.
