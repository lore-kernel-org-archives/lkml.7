Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A8AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74373206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfLPRIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:08:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:42270 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbfLPRIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:08:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 09:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="247105417"
Received: from andresma-mobl.amr.corp.intel.com (HELO [10.252.132.232]) ([10.252.132.232])
  by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2019 09:07:59 -0800
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial definitions
 for sdw_master_device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
 <20728848-e0ae-01f6-1c45-c8eef6a6a1f4@linux.intel.com>
 <20191214082742.GA3318534@kroah.com>
 <e9d77c58-e0bd-010c-bbc8-b54c82f065fd@linux.intel.com>
 <20191216162517.GA2258618@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8dfb12c-2394-3dfe-571d-dcc5fadb8dc2@linux.intel.com>
Date:   Mon, 16 Dec 2019 11:07:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216162517.GA2258618@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>>>> index 76a5c52b12b4..5bad8422887e 100644
>>>> --- a/drivers/soundwire/Makefile
>>>> +++ b/drivers/soundwire/Makefile
>>>> @@ -7,9 +7,11 @@ ccflags-y += -DDEBUG
>>>>    #Bus Objs
>>>>    soundwire-bus-objs := bus_type.o bus.o master.o slave.o mipi_disco.o
>>>> stream.o
>>>>    obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>>>> +ccflags-$(CONFIG_SOUNDWIRE) += -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE
>>>>
>>>>    soundwire-generic-allocation-objs := generic_bandwidth_allocation.o
>>>>    obj-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
>>>> soundwire-generic-allocation.o
>>>> +ccflags-$(CONFIG_SOUNDWIRE_GENERIC_ALLOCATION) +=
>>>> -DDEFAULT_SYMBOL_NAMESPACE=SDW_CORE
>>>
>>> Don't use ccflags, just use the correct MODULE_EXPORT_NS() tag instead.
>>
>> The documentation [1] states
>>
>> "
>> Defining namespaces for all symbols of a subsystem can be very verbose and
>> may become hard to maintain. Therefore a default define
>> (DEFAULT_SYMBOL_NAMESPACE) is been provided, that, if set, will become the
>> default for all EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL() macro expansions
>> that do not specify a namespace.
>> "
>>
>> If the ccflags option is not supported or no longer desired, it'd be worth
>> updating the documentation for dummies like me. I took the wording as a hint
>> to avoid using MODULE_EXPORT_NS.
> 
> It's supported, and works just fine.  It's just that you really don't
> have a ton of exports, right?  What's wrong with manually marking them?

I don't see a MODULE_EXPORT_NS so we'd have to change every single 
EXPORT_SYMBOL to EXPORT_SYMBOL_NS.

If we are talking about adding the namespaces just about the top-level 
functions used by Intel, yes we have less than 10 and since they were 
renamed it's no big deal.

But if we want to use this namespace for lower-level components of the 
SoundWire code, we have 17 exports in cadence_master.c and more than 27 
for the core parts. With the Makefile changes shared last week you'd 
have 3 changes, I find it more manageable but it's true that the 
information would be split with the IMPORT_NS in the code and the 
namespace definition in the Makefile.


>>> And "SDW_CORE" is odd, "SOUNDWIRE" instead?
>>
>> 'sdw' is the prefix used everywhere for SoundWire symbols.
> 
> Ok, I guess that ship has sailed :(

we can still use SOUNDWIRE for the namespaces, that'd be fine. you're 
right to call us on acronyms, it's a bad habit.
