Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6539C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8E320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfHEPaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:30:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:26315 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfHEPaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:30:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 08:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="164681288"
Received: from nupurjai-mobl.amr.corp.intel.com (HELO [10.251.149.179]) ([10.251.149.179])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 08:27:16 -0700
Subject: Re: [alsa-devel] [RFC PATCH 21/40] soundwire: export helpers to find
 row and column values
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
 <20190805093923.GC22437@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <75539c39-da33-efba-d320-42fab738c5f0@linux.intel.com>
Date:   Mon, 5 Aug 2019 10:27:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805093923.GC22437@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/19 4:39 AM, Sanyog Kale wrote:
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
>> +
>> +int sdw_find_row_index(int row);
>> +int sdw_find_col_index(int col);
> 
> We use index values only in bank switch operations to program registers. Do we
> really need to export sdw_find_row_index & sdw_find_col_index?? If i understand
> correctly the allocation algorithm only needs to know about cols and rows values
> and not index.

The allocation does work with cols and rows indeed, but will first run 
the code below where the information f is required:

static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
{
	struct sdw_master_prop *prop = &bus->prop;
	int frame_int, frame_freq;
	int r, c;

	for (c = 0; c < SDW_FRAME_COLS; c++) {
		for (r = 0; r < SDW_FRAME_ROWS; r++) {
			if (sdw_rows[r] != prop->default_row ||
			    sdw_cols[c] != prop->default_col)
				continue;

			frame_int = sdw_rows[r] * sdw_cols[c];
			frame_freq = clk_freq / frame_int;

			if ((clk_freq - (frame_freq * SDW_FRAME_CTRL_BITS)) <
			    bus->params.bandwidth)
				continue;

			bus->params.row = sdw_rows[r];
			bus->params.col = sdw_cols[c];
			return 0;
		}
	}

	return -EINVAL;
}

as for the two helpers, they are used in both the allocation and the 
cadence code (to determine the initial frame shape from properties).

And other solutions for non-Intel platforms will also need this to 
convert from indices to frame shape.

So yes all of this is needed.


> 
>>   
>>   /**
>>    * sdw_port_runtime: Runtime port parameters for Master or Slave
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index a0476755a459..53f5e790fcd7 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -21,37 +21,39 @@
>>    * The rows are arranged as per the array index value programmed
>>    * in register. The index 15 has dummy value 0 in order to fill hole.
>>    */
>> -int rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
>> +int sdw_rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
>>   			96, 100, 120, 128, 150, 160, 250, 0,
>>   			192, 200, 240, 256, 72, 144, 90, 180};
>>   
>> -int cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
>> +int sdw_cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
>>   
>> -static int sdw_find_col_index(int col)
>> +int sdw_find_col_index(int col)
>>   {
>>   	int i;
>>   
>>   	for (i = 0; i < SDW_FRAME_COLS; i++) {
>> -		if (cols[i] == col)
>> +		if (sdw_cols[i] == col)
>>   			return i;
>>   	}
>>   
>>   	pr_warn("Requested column not found, selecting lowest column no: 2\n");
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(sdw_find_col_index);
>>   
>> -static int sdw_find_row_index(int row)
>> +int sdw_find_row_index(int row)
>>   {
>>   	int i;
>>   
>>   	for (i = 0; i < SDW_FRAME_ROWS; i++) {
>> -		if (rows[i] == row)
>> +		if (sdw_rows[i] == row)
>>   			return i;
>>   	}
>>   
>>   	pr_warn("Requested row not found, selecting lowest row no: 48\n");
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL(sdw_find_row_index);
>>   
>>   static int _sdw_program_slave_port_params(struct sdw_bus *bus,
>>   					  struct sdw_slave *slave,
>> -- 
>> 2.20.1
>>
> 
