Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2593C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9EE2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfHZIa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:30:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:46936 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfHZIa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:30:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="379573481"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2019 01:30:26 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micha=c5=82_Wajdeczko?= <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
 hot re-plug
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
 <00f1a3a7-7ff6-e9a0-d9de-a177af6fd64b@linux.intel.com>
 <7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <790a4a20-7517-fe54-177d-850b9beeb88e@linux.intel.com>
Date:   Mon, 26 Aug 2019 16:29:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On 8/26/19 4:15 PM, Janusz Krzysztofik wrote:
> Hi Lu,
> 
> On Friday, August 23, 2019 3:51:11 AM CEST Lu Baolu wrote:
>> Hi,
>>
>> On 8/22/19 10:29 PM, Janusz Krzysztofik wrote:
>>> When a perfectly working i915 device is hot unplugged (via sysfs) and
>>> hot re-plugged again, its dev->archdata.iommu field is not populated
>>> again with an IOMMU pointer.  As a result, the device probe fails on
>>> DMA mapping error during scratch page setup.
>>>
>>> It looks like that happens because devices are not detached from their
>>> MMUIO bus before they are removed on device unplug.  Then, when an
>>> already registered device/IOMMU association is identified by the
>>> reinstantiated device's bus and function IDs on IOMMU bus re-attach
>>> attempt, the device's archdata is not populated with IOMMU information
>>> and the bad happens.
>>>
>>> I'm not sure if this is a proper fix but it works for me so at least it
>>> confirms correctness of my analysis results, I believe.  So far I
>>> haven't been able to identify a good place where the possibly missing
>>> IOMMU bus detach on device unplug operation could be added.
>>
>> Which kernel version are you testing with? Does it contain below commit?
>>
>> commit 458b7c8e0dde12d140e3472b80919cbb9ae793f4
>> Author: Lu Baolu <baolu.lu@linux.intel.com>
>> Date:   Thu Aug 1 11:14:58 2019 +0800
> 
> I was using an internal branch based on drm-tip which didn't contain this
> commit yet.  Fortunately it has been already merged into drm-tip over last
> weekend and has effectively fixed the issue.

Thanks for testing this.

Best regards,
Lu Baolu
