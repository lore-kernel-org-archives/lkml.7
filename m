Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F13C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1ED218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfGZOLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:11:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:25327 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbfGZOLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:11:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322049670"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:11:04 -0700
Subject: Re: [alsa-devel] [RFC PATCH 16/40] soundwire: cadence_master: improve
 startup sequence with link hw_reset
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-17-pierre-louis.bossart@linux.intel.com>
 <20190726072234.GD16003@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c91d6e9d-7ad9-64e2-6ed1-3c0be0b6833d@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:11:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726072234.GD16003@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int do_reset(struct sdw_cdns *cdns)
>> +{
>> +	int ret;
>> +
>> +	/* program maximum length reset to be safe */
>> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
>> +		     CDNS_MCP_CONTROL_RST_DELAY,
>> +		     CDNS_MCP_CONTROL_RST_DELAY);
>> +
>> +	/* use hardware generated reset */
>> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
>> +		     CDNS_MCP_CONTROL_HW_RST,
>> +		     CDNS_MCP_CONTROL_HW_RST);
>> +
>> +	/* enable bus operations with clock and data */
>> +	cdns_updatel(cdns, CDNS_MCP_CONFIG,
>> +		     CDNS_MCP_CONFIG_OP,
>> +		     CDNS_MCP_CONFIG_OP_NORMAL);
>> +
>> +	/* commit changes */
>> +	ret = cdns_update_config(cdns);
>> +
>> +	return ret;
> 
> +	return cdns_update_config(cdns);
> 
> and remove the "ret" variable.

Yes, it's the same issue as previously reported. will fix.
