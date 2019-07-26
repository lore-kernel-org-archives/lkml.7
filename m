Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB165C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE7122ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfGZNdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:33:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:48738 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfGZNdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:33:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 06:33:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322039842"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 06:33:06 -0700
Subject: Re: [alsa-devel] [RFC PATCH 09/40] soundwire: cadence_master: fix
 usage of CONFIG_UPDATE
To:     Bard liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
 <3aa182a9-4b8e-96dd-e8f8-f2f5a90401cb@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f3468f5b-3e0a-ee4a-7e7a-734ed23fbdfa@linux.intel.com>
Date:   Fri, 26 Jul 2019 08:33:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3aa182a9-4b8e-96dd-e8f8-f2f5a90401cb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns 
>> *cdns)
>>    */
>>   int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>   {
>> -    int ret;
>> -
>>       _cdns_enable_interrupt(cdns);
>> -    ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
>> -                 CDNS_MCP_CONFIG_UPDATE_BIT);
>> -    if (ret < 0)
>> -        dev_err(cdns->dev, "Config update timedout\n");
>> -    return ret;
> Should we add cdns_update_config() here?

indeed, this would be a good improvement. The code works because we 
added the exit_reset() sequence which does call cdns_update_config(), 
but better make this function self-contained. When we enable the 
clock-stop mode we will not do this reset sequence.
