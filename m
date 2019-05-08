Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D096C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F04208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfEHQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:25:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:39707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfEHQZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:25:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 09:20:13 -0700
X-ExtLoop1: 1
Received: from mayalewx-mobl1.amr.corp.intel.com (HELO [10.255.230.159]) ([10.255.230.159])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2019 09:20:10 -0700
Subject: Re: [PATCH 1/8] soundwire: intel: filter SoundWire controller device
 search
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
 <20190507122651.GO16052@vkoul-mobl>
 <47fd3ca6-6910-f101-9b63-f653cd1443f9@linux.intel.com>
 <20190508050853.GT16052@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a6b3f1d1-c815-3c6b-7f35-ac5cc98960b2@linux.intel.com>
Date:   Wed, 8 May 2019 11:20:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508050853.GT16052@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +	/*
>>>> +	 * On some Intel platforms, multiple children of the HDAS
>>>> +	 * device can be found, but only one of them is the SoundWire
>>>> +	 * controller. The SNDW device is always exposed with
>>>> +	 * Name(_ADR, 0x40000000) so filter accordingly
>>>> +	 */
>>>> +	if (adr != 0x40000000)
>>>
>>> I do not recall if 4 corresponds to the links you have or soundwire
>>> device type, is this number documented somewhere is HDA specs?
>>
>> I thought it was a magic number, but I did check and for once it's
>> documented and the values match the spec :-)
>> I see in the ACPI docs bits 31..28 set to 4 indicate a SoundWire Link Type
>> and bits 3..0 indicate the SoundWire controller instance, the rest is
>> reserved to zero.
> 
> So in that case we should mask with bits 31..28 and match, who knows you
> may have multiple controller instances in future

yes, I was planning on only using the link type.

> I had a vague recollection that this was documented in the spec, glad
> that in turned out to be the case.
> 
> Btw was the update to HDA spec made public?

Not that I know of. The previous NHLT public doc has actually 
disappeared from the Intel site and I can't find it any longer, so 
currently the amount of public documentation is trending to zero :-(

> 
>>> Also it might good to create a define for this
>>
>> I will respin this one to add the documentation above, and only filter on
>> the 4 ms-bits. Thanks for forcing me to RTFM :-)
> 
