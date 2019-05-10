Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC96C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F33217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEJR5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:57:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:18909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfEJR5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:57:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 10:57:12 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 10 May 2019 10:57:12 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id CC36C580482;
        Fri, 10 May 2019 10:57:11 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Fix build error with
 CONFIG_SND_SOC_SOF_NOCODEC=m
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, rdunlap@infradead.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
References: <20190510023657.8960-1-yuehaibing@huawei.com>
 <s5h7eayn5or.wl-tiwai@suse.de>
 <73c6dd27-895a-adba-a4ef-2992266fcc48@linux.intel.com>
 <s5hlfzempf0.wl-tiwai@suse.de>
 <1e7e1908-a813-6c9b-5b88-122864d3a372@linux.intel.com>
 <s5hbm0amnpl.wl-tiwai@suse.de> <s5h8svemn0u.wl-tiwai@suse.de>
 <00aa3055-0b97-3ac4-f588-3665bfcb5811@linux.intel.com>
 <s5h1s16memr.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <75c3efb7-8057-0d4c-a53d-45f4527d90a1@linux.intel.com>
Date:   Fri, 10 May 2019 12:56:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5h1s16memr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Yes, that would work.  OTOH, I see no merit to build an extra module
>>>> for nocodec.  nocodec.c can be built together with sof-core stuff.
>>
>> the module has its benefits. Today nocodec includes all possible DAIs,
>> I wanted to add module parameters to restrict things a bit for
>> tests/debug. It'll be e.g. very helpful for SoundWire to avoid
>> exposing the SSP DAIs.
>>
>> Also nocodec is incompatible with hdaudio/hdmi support at the moment,
>> we had all sorts of issues with suspend/resume.
> 
> Well, in the case of SOF, the core code calls directly
> soc_nocodec_setup(), hence it's rather a direct link.  So it makes
> little sense to make the nocodec code split from sof-core, unless the
> nocodec code is used / linked by components other than SOF.  I doubt
> the possibility because the current DAI is clearly only for SOF...
> 
> The module option can be still be there; it'll be applied just to
> sof-core instead of sof-nocodec.

I see your point and this SOF core/nocodec dependency is a conceptual 
miss on our side. Thanks for bringing our attention on this.

The core is really supposed to be about the DSP side of things. It 
shouldn't be burdened with machine driver stuff, but it unfortunately is 
at two levels.

Initially the nocodec code was handled at the soc-acpi-dev or 
soc-pci-dev level, and it's still there that the FORCE_CODEC mode is 
handled, along with the calls to check the codec ACPI IDs. Now when we 
enabled the HDaudio case, we somehow ended-up moving parts of the 
nocodec support in the SOF core to simplify our life but created a 
dependency that wasn't intentional at all. we collectively missed it 
while we were struggling with nocodec/hdaudio compatibility.

The second issue is that we create a platform_device for the machine 
driver in the SOF core. This is a shortcut that we took and that works 
for Intel, but for DeviceTree-based platforms this will have to change.

So long story short, I'd rather have a simple Kconfig fix to avoid 
compilation issues for now and revisit all the machine driver support, 
e.g. when the i.MX patches show up, than strengthen a dependency that we 
introduced by accident rather than by design.


