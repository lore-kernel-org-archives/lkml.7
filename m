Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A1C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009792063F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHSFq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:46:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:54355 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSFq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:46:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2019 22:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="378084095"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2019 22:46:24 -0700
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, devel@driverdev.osuosl.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <20190816063925.GB18980@zn.tnic>
 <78897bb2-e6eb-cac2-7166-eccb7cd5c959@intel.com>
 <20190819052505.GA915@kroah.com>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <291ffa06-731d-d4d1-44f9-32d119303ae4@intel.com>
Date:   Mon, 19 Aug 2019 13:39:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190819052505.GA915@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月19日 13:25, Greg KH wrote:
> On Mon, Aug 19, 2019 at 09:44:25AM +0800, Zhao, Yakui wrote:
>>
>>
>> On 2019年08月16日 14:39, Borislav Petkov wrote:
>>> On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
>>>> The first three patches are the changes under x86/acrn, which adds the
>>>> required APIs for the driver and reports the X2APIC caps.
>>>> The remaining patches add the ACRN driver module, which accepts the ioctl
>>>> from user-space and then communicate with the low-level ACRN hypervisor
>>>> by using hypercall.
>>>
>>> I have a problem with that: you're adding interfaces to arch/x86/ and
>>> its users go into staging. Why? Why not directly put the driver where
>>> it belongs, clean it up properly and submit it like everything else is
>>> submitted?
>>
>> Thanks for your reply and the concern.
>>
>> After taking a look at several driver examples(gma500, android), it seems
>> that they are firstly added into drivers/staging/XXX and then moved to
>> drivers/XXX after the driver becomes mature.
>> So we refer to this method to upstream ACRN driver part.
> 
> Those two examples are probably the worst examples to ever look at :)
> 
> The code quality of those submissions was horrible, gma500 took a very
> long time to clean up and there are parts of the android code that are
> still in staging to this day.
> 
>> If the new driver can also be added by skipping the staging approach,
>> we will refine it and then submit it in normal process.
> 
> That is the normal process, staging should not be needed at all for any
> code.  It is a fall-back for when the company involved has no idea of
> how to upstream their code, which should NOT be the case here.

Thanks for your explanation.

OK. We will submit it in normal process.

> 
> thanks,
> 
> greg k-h
> 
