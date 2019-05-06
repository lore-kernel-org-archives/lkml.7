Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5848A205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEFQyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:54:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:29193 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEFQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:54:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 09:54:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="171358620"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2019 09:54:13 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id 5F620580238;
        Mon,  6 May 2019 09:54:12 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 5/7] soundwire: add debugfs support
To:     Vinod Koul <vkoul@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-6-pierre-louis.bossart@linux.intel.com>
 <20190504070301.GD9770@kroah.com>
 <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
 <20190506163810.GK3845@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f1b632e7-e62d-bbd4-e160-36009ee57249@linux.intel.com>
Date:   Mon, 6 May 2019 11:54:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506163810.GK3845@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 11:38 AM, Vinod Koul wrote:
> On 06-05-19, 09:48, Pierre-Louis Bossart wrote:
> 
>>>> +struct dentry *sdw_bus_debugfs_get_root(struct sdw_bus_debugfs *d)
>>>> +{
>>>> +	if (d)
>>>> +		return d->fs;
>>>> +	return NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(sdw_bus_debugfs_get_root);
>>>
>>> _GPL()?
>>
>> Oops, that's a big miss. will fix, thanks for spotting this.
> 
> Not really. The Soundwire code is dual licensed. Many of the soundwire
> symbols are indeed exported as EXPORT_SYMBOL. But I agree this one is
> 'linux' specific so can be made _GPL.
> 
> Pierre, does Intel still care about this being dual licensed or not?

Debugfs was never in scope for the dual-licensed parts, we've already 
agreed for SOF to move to _GPL.

> 
>>
>>>
>>> But why is this exported at all?  No one calls this function.
>>
>> I will have to check.
> 
> It is used by codec driver which are not upstream yet. So my suggestion
> would be NOT to export this and only do so when we have users for it
> That would be true for other APIs exported out as well.

It'll just make the first codec driver patchset more complicated but fine.
