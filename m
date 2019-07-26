Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D356CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81952189F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfGZR0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 13:26:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:40444 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfGZR0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:26:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 10:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="198461381"
Received: from andawes-mobl.amr.corp.intel.com (HELO [10.251.145.66]) ([10.251.145.66])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2019 10:26:14 -0700
Subject: Re: [alsa-devel] [RFC PATCH 36/40] soundwire: intel: disable
 interrupts on suspend
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
 <20190726155520.GL16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e456112b-27a4-d897-6690-3177dd5a8b56@linux.intel.com>
Date:   Fri, 26 Jul 2019 12:26:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726155520.GL16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>>   {
>>   	u32 mask;
>>   
>> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
>> -		    CDNS_MCP_SLAVE_INTMASK0_MASK);
>> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>> -		    CDNS_MCP_SLAVE_INTMASK1_MASK);
>> +	if (state) {
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
>> +			    CDNS_MCP_SLAVE_INTMASK0_MASK);
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>> +			    CDNS_MCP_SLAVE_INTMASK1_MASK);
>>   
>> -	/* enable detection of slave state changes */
>> -	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
>> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>> +		/* enable detection of slave state changes */
>> +		mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
>> +			CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>>   
>> -	/* enable detection of bus issues */
>> -	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> -		CDNS_MCP_INT_PARITY;
>> +		/* enable detection of bus issues */
>> +		mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> +			CDNS_MCP_INT_PARITY;
>>   
>> -	/* no detection of port interrupts for now */
>> +		/* no detection of port interrupts for now */
>>   
>> -	/* enable detection of RX fifo level */
>> -	mask |= CDNS_MCP_INT_RX_WL;
>> +		/* enable detection of RX fifo level */
>> +		mask |= CDNS_MCP_INT_RX_WL;
>>   
>> -	/* now enable all of the above */
>> -	mask |= CDNS_MCP_INT_IRQ;
>> +		/* now enable all of the above */
>> +		mask |= CDNS_MCP_INT_IRQ;
>>   
>> -	if (interrupt_mask) /* parameter override */
>> -		mask = interrupt_mask;
>> +		if (interrupt_mask) /* parameter override */
>> +			mask = interrupt_mask;
>> +	} else {
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, 0);
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, 0);
>> +		mask = 0;
>> +	}
> 
> Looks like this should be two functions? Especially since "state" is always a constant
> when it is called. If there is still a lot of common code below, maybe make it a helper
> function.

Yes, the code is a bit ugly. I could initialize all the masks to zero, 
have the if(state) block and write the masks.
