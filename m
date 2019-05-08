Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E2BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36446216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfEHQv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:51:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:19407 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfEHQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:51:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 09:51:25 -0700
X-ExtLoop1: 1
Received: from mayalewx-mobl1.amr.corp.intel.com (HELO [10.255.230.159]) ([10.255.230.159])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2019 09:51:24 -0700
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
 <20190506151953.GA13178@kroah.com> <20190506162208.GI3845@vkoul-mobl.Dlink>
 <be72bbb1-b51f-8201-fdff-958836ed94d1@linux.intel.com>
 <20190507051959.GC16052@vkoul-mobl>
 <fde9c4cd-518b-cb67-5b05-1608c9d029e4@linux.intel.com>
 <20190508074009.GU16052@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9b61fd6f-69a1-ff70-a652-b45654f5dd96@linux.intel.com>
Date:   Wed, 8 May 2019 11:51:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508074009.GU16052@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Vinod, the question was not for dp0 and dpN, it's fine to have
>>>> subdirectories there, but rather why we need separate devices for the master
>>>> and slave properties.
>>>
>>> Slave does not have a separate device. IIRC the properties for Slave are
>>> in /sys/bus/soundwire/device/<slave>/...
>>
>> I am not sure this is correct
>>
>> ACPI defines the slaves devices under
>> /sys/bus/acpi/PRP0001, e.g.
> 
> Yes the bus will create 'soundwire slave' device type (In acpi case
> created from ACPI walk) and we do link the ACPI as the firmware node.
> This is 'not' created for properties but for soundwire representation of
> slave devices. This is the one code driver attaches to.
>   
>> /sys/bus/acpi/devices/PRP00001:00/device:17# ls
> 
> Yes this would the companion ACPI device

I see, I must admit I missed this part.

I guess it's not technically broken but was is really necessary though 
to use this notion of companion ACPI device? For the controller it makes 
sense, that's how to match ACPI and PCI, but since Soundwire slaves are 
not fully enumerable, precisely why we need all these _DSD properties, 
couldn't we just use ACPI devices directly?
