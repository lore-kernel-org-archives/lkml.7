Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29669C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D7C208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfGZOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:22:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:19210 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfGZOWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:22:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:22:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322051732"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:22:21 -0700
Subject: Re: [alsa-devel] [RFC PATCH 24/40] soundwire: cadence_master: use
 BIOS defaults for frame shape
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-25-pierre-louis.bossart@linux.intel.com>
 <7dbe6483-673f-f415-9ebc-700c090d9520@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3d1f1667-f165-024f-8a93-bb15500cd7ad@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:22:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7dbe6483-673f-f415-9ebc-700c090d9520@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 5:20 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> +static u32 cdns_set_default_frame_shape(int n_rows, int n_cols)
>> +{
>> +    u32 val;
>> +    int c;
>> +    int r;
>> +
>> +    r = sdw_find_row_index(n_rows);
>> +    c = sdw_find_col_index(n_cols);
>> +
>> +    val = (r << 3) | c;
>> +
>> +    return val;
>> +}
>> +
>>   /**
>>    * sdw_cdns_init() - Cadence initialization
>>    * @cdns: Cadence instance
>> @@ -977,7 +990,9 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>       cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>>       /* Set the default frame shape */
>> -    cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, 
>> CDNS_DEFAULT_FRAME_SHAPE);
>> +    val = cdns_set_default_frame_shape(prop->default_row,
>> +                       prop->default_col);
>> +    cdns_writel(cdns, CDNS_MCP_FRAME_SHAPE_INIT, val);
>>       /* Set SSP interval to default value */
>>       cdns_writel(cdns, CDNS_MCP_SSP_CTRL0, CDNS_DEFAULT_SSP_INTERVAL);
>>
> 
> Suggestion:
> declare "generic" _get_frame_frame(rows, cols) instead and let it do the 
> bitwise operations for you. Pretty sure this won't be the only place in 
> code where reg value for frame_shape needs to be prepared.
> 
> Said function could be as simple as:
> return (row << 3) | cols;
> +inline flag
> 
> i.e. could be even a macro..
> 
> Otherwise modify _set_default_frame_shape to simply:
> return (r << 3) | c
> 
> without involving additional local val variable (I don't really see the 
> point for any locals there though).

what this function does is take the standard-defined offsets for row and 
column and stores them in a Cadence-defined register. I think we can 
probably use a macro to remove the magic '3' value, but there are limits 
to what we can simplify. I should probably add comments so that people 
figure it out.
