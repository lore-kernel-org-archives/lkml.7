Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E620BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75542070B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGZO5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:57:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:21416 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfGZO5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322058385"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:57:06 -0700
Subject: Re: [alsa-devel] [RFC PATCH 33/40] soundwire: intel: Add basic power
 management support
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-34-pierre-louis.bossart@linux.intel.com>
 <0e439b41-503d-7ffb-827f-422d63e439eb@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <41f71476-4205-7982-9422-5d00e55c24d3@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:57:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0e439b41-503d-7ffb-827f-422d63e439eb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 5:50 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> +static int intel_resume(struct device *dev)
>> +{
>> +    struct sdw_intel *sdw;
>> +    int ret;
>> +
>> +    sdw = dev_get_drvdata(dev);
>> +
>> +    ret = intel_init(sdw);
>> +    if (ret) {
>> +        dev_err(dev, "%s failed: %d", __func__, ret);
>> +        return ret;
>> +    }
>> +
>> +    sdw_cdns_enable_interrupt(&sdw->cdns);
>> +
>> +    return ret;
>> +}
>> +
>> +#endif
> 
> Suggestion: the local declaration + initialization via dev_get_drvdata() 
> are usually combined.

yes, will do.

> 
> Given the upstream declaration of _enable_interrupt, it does return 
> error code/ success. Given current flow, if function gets to 
> _enable_interrupt call, ret is already set to 0. Returning 
> sdw_cds_enable_interrupt() directly would both simplify the definition 
> and prevent status loss.

sounds good, will do, thanks!
