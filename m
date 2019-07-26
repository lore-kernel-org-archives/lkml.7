Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6689FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4206122BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfGZRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:32:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:50005 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfGZRcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:32:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="198463139"
Received: from andawes-mobl.amr.corp.intel.com (HELO [10.251.145.66]) ([10.251.145.66])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2019 10:31:53 -0700
Subject: Re: [alsa-devel] [RFC PATCH 37/40] soundwire: cadence_master: add
 hw_reset capability in debugfs
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
 <20190726155717.GM16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd17efe9-04bf-4cf5-6527-8fdba8d39419@linux.intel.com>
Date:   Fri, 26 Jul 2019 12:31:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726155717.GM16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int cdns_hw_reset(void *data, u64 value)
>> +{
>> +	struct sdw_cdns *cdns = data;
>> +	int ret;
>> +
>> +	if (value != 1)
>> +		return 0;
>> +
>> +	dev_info(cdns->dev, "starting link hw_reset\n");
>> +
>> +	ret = sdw_cdns_exit_reset(cdns);
>> +
>> +	dev_info(cdns->dev, "link hw_reset done\n");
> 
> Both really should be dev_info()? Maybe at least one of them can be dev_dbg()?

I have to walk back on what I explained to Greg. The idea was to have a 
dmesg trace when this function as called when the user plays with 
debugfs, otherwise the dmesg log is difficult to interpret (devices can 
go off the bus on their own). I'll keep the first one only and demote it 
to dev_dbg.
