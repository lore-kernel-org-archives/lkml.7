Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52496C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03421721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfJHCaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:30:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:50967 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfJHCaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 22:30:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 19:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="192457101"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 19:30:09 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micha=c5=82_Wajdeczko?= <michal.wajdeczko@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
 hot re-plug
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
 <52fbfac9-c879-4b45-dd74-fafe62c2432b@linux.intel.com>
 <2674326.ZPvzKFr69O@jkrzyszt-desk.ger.corp.intel.com>
 <7739498.9tyZrNxj5X@jkrzyszt-desk.ger.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0131be21-0ae3-ac1e-6ee3-c256e3d2a38f@linux.intel.com>
Date:   Tue, 8 Oct 2019 10:27:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7739498.9tyZrNxj5X@jkrzyszt-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/19 11:01 PM, Janusz Krzysztofik wrote:
> Hi Baolu,
> 
> On Tuesday, September 3, 2019 9:41:23 AM CEST Janusz Krzysztofik wrote:
>> Hi Baolu,
>>
>> On Tuesday, September 3, 2019 3:29:40 AM CEST Lu Baolu wrote:
>>> Hi Janusz,
>>>
>>> On 9/2/19 4:37 PM, Janusz Krzysztofik wrote:
>>>>> I am not saying that keeping data is not acceptable. I just want to
>>>>> check whether there are any other solutions.
>>>> Then reverting 458b7c8e0dde and applying this patch still resolves the
>> issue
>>>> for me.  No errors appear when mappings are unmapped on device close after
>> the
>>>> device has been removed, and domain info preserved on device removal is
>>>> successfully reused on device re-plug.
>>>
>>> This patch doesn't look good to me although I agree that keeping data is
>>> acceptable.
> 
> Any progress with that?  Which mailing list should I watch for updates?\

We had a holiday last week. I will go ahead with reproducing it locally.
Feel free to let me know if you have any new proposal.

Best regards,
Baolu

> 
> Thanks,
> Janusz
> 
>>> It updates dev->archdata.iommu, but leaves the hardware
>>> context/pasid table unchanged. This might cause problems somewhere.
>>>
>>>>
>>>> Is there anything else I can do to help?
>>>
>>> Can you please tell me how to reproduce the problem?
>>
>> The most simple way to reproduce the issue, assuming there are no non-Intel
>> graphics adapters installed, is to run the following shell commands:
>>
>> #!/bin/sh
>> # load i915 module
>> modprobe i915
>> # open an i915 device and keep it open in background
>> cat /dev/dri/card0 >/dev/null &
>> sleep 2
>> # simulate device unplug
>> echo 1 >/sys/class/drm/card0/device/remove
>> # make the background process close the device on exit
>> kill $!
>>
>> Thanks,
>> Janusz
>>
>>
>>> Keeping the per
>>> device domain info while device is unplugged is a bit dangerous because
>>> info->dev might be a wild pointer. We need to work out a clean fix.
>>>
>>>>
>>>> Thanks,
>>>> Janusz
>>>>
>>>
>>> Best regards,
>>> Baolu
>>>
>>
>>
>>
>>
>>
> 
> 
> 
> 
> 
