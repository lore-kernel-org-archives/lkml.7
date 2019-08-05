Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E22C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E74C21734
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfHEPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:20:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:36565 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfHEPUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:20:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 08:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="164679880"
Received: from nupurjai-mobl.amr.corp.intel.com (HELO [10.251.149.179]) ([10.251.149.179])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2019 08:20:25 -0700
Subject: Re: [alsa-devel] [RFC PATCH 02/40] soundwire: cadence_master: add
 debugfs register dump
To:     Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-3-pierre-louis.bossart@linux.intel.com>
 <20190805075509.GA22437@buildpc-HP-Z230>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <37002145-b8dc-ac30-d857-00b277ef4bac@linux.intel.com>
Date:   Mon, 5 Aug 2019 10:20:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805075509.GA22437@buildpc-HP-Z230>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
>> +			     size_t count, loff_t *ppos)
>> +{
>> +	struct sdw_cdns *cdns = file->private_data;
>> +	char *buf;
>> +	ssize_t ret;
>> +	int i, j;
>> +
>> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
>> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
>> +	for (i = 0; i < 8; i++) /* 8 MCP registers */
>> +		ret += cdns_sprintf(cdns, buf, ret, i * 4);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nStatus & Intr Registers\n");
>> +	for (i = 0; i < 13; i++) /* 13 Status & Intr registers */
>> +		ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_STAT + i * 4);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nSSP & Clk ctrl Registers\n");
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nDPn B0 Registers\n");
>> +	for (i = 0; i < 7; i++) {
>> +		ret += scnprintf(buf + ret, RD_BUF - ret,
>> +				 "\nDP-%d\n", i);
>> +		for (j = 0; j < 6; j++)
>> +			ret += cdns_sprintf(cdns, buf, ret,
>> +					CDNS_DPN_B0_CONFIG(i) + j * 4);
>> +	}
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nDPn B1 Registers\n");
>> +	for (i = 0; i < 7; i++) {
>> +		ret += scnprintf(buf + ret, RD_BUF - ret,
>> +				 "\nDP-%d\n", i);
>> +
>> +		for (j = 0; j < 6; j++)
>> +			ret += cdns_sprintf(cdns, buf, ret,
>> +					CDNS_DPN_B1_CONFIG(i) + j * 4);
>> +	}
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nDPn Control Registers\n");
>> +	for (i = 0; i < 7; i++)
>> +		ret += cdns_sprintf(cdns, buf, ret,
>> +				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nPDIn Config Registers\n");
>> +	for (i = 0; i < 7; i++)
> 
> please use macros for all the hardcodings.

yes, I completely changed that part in the upcoming update by using 
register start/stop for all loops, it makes the code more consistent and 
easier to change (SoundWire 1.2 registers will need to be added)

