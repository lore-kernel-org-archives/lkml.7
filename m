Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095F22087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfHBPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:23:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:16598 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfHBPX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:23:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 08:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,338,1559545200"; 
   d="scan'208";a="175611575"
Received: from vivekcha-mobl1.amr.corp.intel.com (HELO [10.251.131.115]) ([10.251.131.115])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2019 08:23:53 -0700
Subject: Re: [RFC PATCH 12/40] soundwire: cadence_master: revisit interrupt
 settings
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-13-pierre-louis.bossart@linux.intel.com>
 <20190802121016.GN12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a46474c5-8f6b-fa03-8d5e-704c028667aa@linux.intel.com>
Date:   Fri, 2 Aug 2019 10:23:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802121016.GN12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -761,10 +769,21 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>   	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>>   		    CDNS_MCP_SLAVE_INTMASK1_MASK);
>>   
>> +	/* enable detection of slave state changes */
>>   	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
>> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
>> -		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> -		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
>> +		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>> +
>> +	/* enable detection of bus issues */
>> +	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> +		CDNS_MCP_INT_PARITY;
>> +
>> +	/* no detection of port interrupts for now */
>> +
>> +	/* enable detection of RX fifo level */
>> +	mask |= CDNS_MCP_INT_RX_WL;
>> +
>> +	/* now enable all of the above */
> 
> I think this comment seems is at wrong line..?
> 
>> +	mask |= CDNS_MCP_INT_IRQ;
>>   
>>   	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);

No it's at the right place.

This flag gates all others, if its value is zero then the value of all 
other bits is irrelevant.

that's what I meant by 'all of the above'.


