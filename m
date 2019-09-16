Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5206C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C04D206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfIPSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:14:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:15860 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfIPSOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:14:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 11:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="361605341"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO [10.254.104.227]) ([10.254.104.227])
  by orsmga005.jf.intel.com with ESMTP; 16 Sep 2019 11:14:12 -0700
Subject: Re: [alsa-devel] [PATCH 1/6] soundwire: fix startup sequence for
 Intel/Cadence
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
 <20190813213227.5163-2-pierre-louis.bossart@linux.intel.com>
 <20190904071108.GI2672@vkoul-mobl>
 <dc16e4d8-1d95-542c-869e-bdefc37d059b@linux.intel.com>
Message-ID: <4734e29e-859d-745b-5cc6-ce70ca6e6c99@linux.intel.com>
Date:   Mon, 16 Sep 2019 13:14:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc16e4d8-1d95-542c-869e-bdefc37d059b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> @@ -1043,8 +1043,6 @@ static int intel_probe(struct platform_device 
>>> *pdev)
>>>       if (ret)
>>>           goto err_init;
>>> -    ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>>> -
>>>       /* Read the PDI config and initialize cadence PDI */
>>>       intel_pdi_init(sdw, &config);
>>>       ret = sdw_cdns_pdi_init(&sdw->cdns, config);
>>> @@ -1062,6 +1060,18 @@ static int intel_probe(struct platform_device 
>>> *pdev)
>>>           goto err_init;
>>>       }
>>> +    ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>>> +    if (ret < 0) {
>>> +        dev_err(sdw->cdns.dev, "cannot enable interrupts\n");
>>> +        goto err_init;
>>> +    }
>>> +
>>> +    ret = sdw_cdns_exit_reset(&sdw->cdns);
>>> +    if (ret < 0) {
>>> +        dev_err(sdw->cdns.dev, "unable to exit bus reset sequence\n");
>>> +        goto err_init;
>>
>> Don't you want to disable interrupts at least... before you return
>> error? err_init does bus cleanup and not controller one
> 
> yes good point, let me look at this.

The existing code has no interrupt disable sequence.

I will add this improved error handling in a follow-up patch, after the 
capability to disable interrupts is added.
