Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC0C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A522BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbfGZP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:26:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:33806 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387681AbfGZP0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:26:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322065176"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 08:26:01 -0700
Subject: Re: [alsa-devel] [RFC PATCH 21/40] soundwire: export helpers to find
 row and column values
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
 <20190726144325.GH16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d6268a75-b38c-aee5-0463-af8b602286bb@linux.intel.com>
Date:   Fri, 26 Jul 2019 10:26:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726144325.GH16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 9:43 AM, Guennadi Liakhovetski wrote:
> On Thu, Jul 25, 2019 at 06:40:13PM -0500, Pierre-Louis Bossart wrote:
>> Add a prefix for common tables and export 2 helpers to set the frame
>> shapes based on row/col values.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.h    |  7 +++++--
>>   drivers/soundwire/stream.c | 14 ++++++++------
>>   2 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 06ac4adb0074..c57c9c23f6ca 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -73,8 +73,11 @@ struct sdw_msg {
>>   
>>   #define SDW_DOUBLE_RATE_FACTOR		2
>>   
>> -extern int rows[SDW_FRAME_ROWS];
>> -extern int cols[SDW_FRAME_COLS];
>> +extern int sdw_rows[SDW_FRAME_ROWS];
>> +extern int sdw_cols[SDW_FRAME_COLS];
> 
> So these arrays actually have to be exported? In the current (5.2) sources they
> seem to only be used in stream.c, maybe make them static there?
> 
>> +
>> +int sdw_find_row_index(int row);
>> +int sdw_find_col_index(int col);

yes, they need to be exported, they are used by the allocation algorithm 
(in Patch 27).
Others will need this for non-Intel solutions, it's really a part of the 
standard definition and should be shared.
I can improve the commit message to make this explicit.
