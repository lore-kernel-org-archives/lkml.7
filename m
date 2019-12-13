Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE82C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE2324679
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLMWQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:16:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:47588 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfLMWQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:16:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 14:16:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="239424458"
Received: from dmjacob-mobl2.amr.corp.intel.com (HELO [10.252.129.36]) ([10.252.129.36])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2019 14:16:10 -0800
Subject: Re: [alsa-devel] [PATCH v4 06/15] soundwire: add support for
 sdw_slave_type
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-7-pierre-louis.bossart@linux.intel.com>
 <20191213072127.GD1750354@kroah.com>
 <41d1fcbc-47b7-bbee-5b55-759cbb5f5a7b@linux.intel.com>
 <20191213161218.GC2653074@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c7d25b39-b8bf-46f1-96c2-8e52aa858dff@linux.intel.com>
Date:   Fri, 13 Dec 2019 16:14:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213161218.GC2653074@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/19 10:12 AM, Greg KH wrote:
> On Fri, Dec 13, 2019 at 09:05:37AM -0600, Pierre-Louis Bossart wrote:
>> On 12/13/19 1:21 AM, Greg KH wrote:
>>> On Thu, Dec 12, 2019 at 11:04:00PM -0600, Pierre-Louis Bossart wrote:
>>>> Currently the bus does not have any explicit support for master
>>>> devices.
>>>>
>>>> First add explicit support for sdw_slave_type and error checks if this type
>>>> is not set.
>>>>
>>>> In follow-up patches we can add support for the sdw_md_type (md==Master
>>>> Device), following the Grey Bus example.
>>>
>>> How are you using greybus as an example of "master devices"?  All you
>>> are doing here is setting the type of the existing devices, right?
>>
>> I took your advice to look at GreyBus and used the 'gb host device' as the
>> model to implement the 'sdw master' add/startup/remove interfaces we needed.
>>
>> so yes in this patch we just add a type for the slave, the interesting part
>> is in the next patches.
> 
> Is that what a "master" device really is?  A host controller, like a USB
> host controller?  Or something else?
> 
> I thought things were a bit more complex for this type of topology.

The "Master Device" is similar to a USB host controller, but with a much 
lower complexity. It can also be viewed as similar to an 
HDaudio/AC97/SLIMbus  controller which handles a serial link with 
interleaved command/data, but with lower latency to e.g. support 1-bit 
oversampled PDM data typically used by digital microphones (or amplifiers).

The Master device provides the clock for the bus, handles clock 
stop/restart sequences in and out of idle state, and it issues commands 
which contain a sync pattern. The Master device will also typically have 
audio 'ports'.

The 'Slave Devices' are similar to USB/SLIMbus devices, they look for a 
sync pattern and when synchronized will respond to status/write/read 
commands. They cannot send commands on their own but can signal in-band 
interrupts. The bus is multi-drop and typically single-level (no 
hubs/bridges so far).

Unfortunately there is no host controller interface so we need a 
vendor-specific driver for each Master device implementation. The Master 
IP is typically part of the audio controller, so in the Intel 
implementation it's represented as an ACPI-enumerated child device of 
the PCI audio controller.

The patches in this series provide a means for the SOF/HDaudio driver to 
check the ACPI DSDT tables and detect if SoundWire links are enabled, 
allocate all necessary resources and start the hardware operation once 
all the power rail dependencies are handled.

Here are a couple of publicly-available pointers:

https://mipi.org/sites/default/files/Audio_Spec_Brief_20141007.pdf
https://mipi.org/sites/default/files/MIPI-SoundWire-webinar-20150121-final.pdf


