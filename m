Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECDDC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465E20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEGOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:43:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:34606 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfEGOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:43:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 07:43:16 -0700
X-ExtLoop1: 1
Received: from asakoono-mobl.gar.corp.intel.com (HELO [10.251.159.132]) ([10.251.159.132])
  by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 07:43:15 -0700
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <47fd3ca6-6910-f101-9b63-f653cd1443f9@linux.intel.com>
Date:   Tue, 7 May 2019 09:43:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507122651.GO16052@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/19 7:26 AM, Vinod Koul wrote:
> On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
>> The convention is that the SoundWire controller device is a child of
>> the HDAudio controller. However there can be more than one child
>> exposed in the DSDT table, and the current namespace walk returns the
>> last device.
>>
>> Add a filter and terminate early when a valid _ADR is provided,
>> otherwise keep iterating to find the next child.
> 
> So what are the other devices in DSDT here..

this is what I see:

Scope (HDAS)
         {
             Device (IDA)
             {
                 Name (_ADR, 0x00020001)  // _ADR: Address
             }
         }

I thought this was nonsense but your question triggered me to look into 
the Intel SST ACPI specs (not public I am afraid but shared with the OS 
who shall not be named).
Using the same source of information as below, I *believe* this is 
HDaudio related, bits 31..16 mean HDaudio with codec SDI 2, and NodeId 1 
for the function group. This would make sense as I believe there are two 
codecs on the board that can be pin-strapped to boot either in HDaudio 
or SoundWire mode- but this is a conjecture only.

At any rate, we need a hardware rework and mutual exclusion between 
HDaudio and SoundWire, so we have to ignore this one when SoundWire is 
enabled.

>> +
>> +	/*
>> +	 * On some Intel platforms, multiple children of the HDAS
>> +	 * device can be found, but only one of them is the SoundWire
>> +	 * controller. The SNDW device is always exposed with
>> +	 * Name(_ADR, 0x40000000) so filter accordingly
>> +	 */
>> +	if (adr != 0x40000000)
> 
> I do not recall if 4 corresponds to the links you have or soundwire
> device type, is this number documented somewhere is HDA specs?

I thought it was a magic number, but I did check and for once it's 
documented and the values match the spec :-)
I see in the ACPI docs bits 31..28 set to 4 indicate a SoundWire Link 
Type and bits 3..0 indicate the SoundWire controller instance, the rest 
is reserved to zero.

> 
> Also it might good to create a define for this

I will respin this one to add the documentation above, and only filter 
on the 4 ms-bits. Thanks for forcing me to RTFM :-)
