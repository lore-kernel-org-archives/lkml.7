Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C32C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636712084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfHNODs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:03:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:28212 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfHNODr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:03:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 07:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,385,1559545200"; 
   d="scan'208";a="376051764"
Received: from dthummal-mobl.amr.corp.intel.com (HELO [10.254.111.70]) ([10.254.111.70])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2019 07:03:46 -0700
Subject: Re: [alsa-devel] [PATCH 06/17] soundwire: cadence_master: use
 firmware defaults for frame shape
To:     Vinod Koul <vkoul@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, Blauciak@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        Slawomir <slawomir.blauciak@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-7-pierre-louis.bossart@linux.intel.com>
 <03b6091b-af41-ac54-43c7-196a3583a731@intel.com>
 <024b4fb4-bdfa-a6dc-48bb-c070f2ed36b2@linux.intel.com>
 <2445b5dc-246c-9c3b-b26e-784032feccf9@intel.com>
 <20190814043139.GV12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0e40ecee-d081-3cee-3e95-cd3c0f3e5b30@linux.intel.com>
Date:   Wed, 14 Aug 2019 09:03:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814043139.GV12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> +static u32 cdns_set_initial_frame_shape(int n_rows, int n_cols)
>>>>> +{
>>>>> +    u32 val;
>>>>> +    int c;
>>>>> +    int r;
>>>>> +
>>>>> +    r = sdw_find_row_index(n_rows);
>>>>> +    c = sdw_find_col_index(n_cols) & CDNS_MCP_FRAME_SHAPE_COL_MASK;
>>>>> +
>>>>> +    val = (r << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | c;
>>>>> +
>>>>> +    return val;
>>>>> +}
>>>>> +
>>>>
>>>> Guess this have been said already, but this function could be
>>>> simplified - unless you really want to keep explicit variable
>>>> declaration. Both "c" and "r" declarations could be merged into
>>>> single line while "val" is not needed at all.
>>>>
>>>> One more thing - is AND bitwise op really needed for cols
>>>> explicitly? We know all col values upfront - these are static and
>>>> declared in global table nearby. Static declaration takes care of
>>>> "initial range-check". Is another one necessary?
>>>>
>>>> Moreover, this is a _get_ and certainly not a _set_ type of
>>>> function. I'd even consider renaming it to: "cdns_get_frame_shape"
>>>> as this is neither a _set_ nor an explicit initial frame shape
>>>> setter.
>>>>
>>>> It might be even helpful to split two usages:
>>>>
>>>> #define sdw_frame_shape(col_idx, row_idx) \
>>>>       ((row_idx << CDNS_MCP_FRAME_SHAPE_ROW_OFFSET) | col_idx)
>>>>
>>>> u32 cdns_get_frame_shape(u16 rows, u16 cols)
>>>> {
>>>>       u16 c, r;
>>>>
>>>>       r = sdw_find_row_index(rows);
>>>>       c = sdw_find_col_index(cols);
>>>>
>>>>       return sdw_frame_shape(c, r);
>>>> }
>>>>
>>>> The above may even be simplified into one-liner.
>>>
>>> This is a function used once on startup, there is no real need to
>>> simplify further. The separate variables help add debug traces as needed
>>> and keep the code readable while showing how the values are encoded into
>>> a register.
>>
>> Eh, I've thought it's gonna be exposed to userspace (via uapi) so it can be
>> fetched by tests or tools.
> 
> Uapi? I dont see anything in this or other series posted, did I miss
> something? Also I am not sure I like the idea of exposing these to
> userland!

Vinod, that was never the intent, and Cezary agreed, see following line

> 
>>
>> In such case - if there is a single usage only - guess function is fine as
>> is.
> 
