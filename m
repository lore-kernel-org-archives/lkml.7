Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF13DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B585C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfHETJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:09:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:44726 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfHETJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:09:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 12:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="373176650"
Received: from amerhebi-mobl1.amr.corp.intel.com (HELO [10.251.154.70]) ([10.251.154.70])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2019 12:08:28 -0700
Subject: Re: [alsa-devel] [RFC PATCH 27/40] soundwire: Add Intel resource
 management algorithm
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-28-pierre-louis.bossart@linux.intel.com>
 <20190805165422.GB24889@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <89fe8170-c252-5bea-a565-631e5b682dbb@linux.intel.com>
Date:   Mon, 5 Aug 2019 14:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805165422.GB24889@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
>> +{
>> +	struct sdw_master_prop *prop = &bus->prop;
>> +	int frame_int, frame_freq;
>> +	int r, c;
>> +
>> +	for (c = 0; c < SDW_FRAME_COLS; c++) {
>> +		for (r = 0; r < SDW_FRAME_ROWS; r++) {
>> +			if (sdw_rows[r] != prop->default_row ||
>> +			    sdw_cols[c] != prop->default_col)
>> +				continue;
> 
> Are we only supporting default rows and cols?

for now yes. Note that the default is defined by firmware and e.g. 
different for ICL (50x4) and CML (125x2). The firmware itself also 
provides a single clock value so we'd need to override the DSDT or force 
the properties to be different to use multiple gears.

This will probably change at some point when we have multiple device per 
link. SoundWire 1.2 devices also provide a standard means to control the 
clock, otherwise with SoundWire 1.1 the clock management requires quite 
a bit of imp-def changes that we have not tested.

> 
>> +
>> +			frame_int = sdw_rows[r] * sdw_cols[c];
>> +			frame_freq = clk_freq / frame_int;
>> +
>> +			if ((clk_freq - (frame_freq * SDW_FRAME_CTRL_BITS)) <
>> +			    bus->params.bandwidth)
>> +				continue;
>> +
>> +			bus->params.row = sdw_rows[r];
>> +			bus->params.col = sdw_cols[c];
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> -- 
>> 2.20.1
>>
> 
