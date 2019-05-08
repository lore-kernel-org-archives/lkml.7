Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4595821530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfEHREc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:04:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:30024 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfEHREa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:04:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:04:29 -0700
X-ExtLoop1: 1
Received: from mayalewx-mobl1.amr.corp.intel.com (HELO [10.255.230.159]) ([10.255.230.159])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2019 10:04:27 -0700
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add Cometlake PCI IDs
To:     Evan Green <evgreen@chromium.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Yu Zhao <yuzhao@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Jenny TC <jenny.tc@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-3-evgreen@chromium.org>
 <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
 <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6fd9ca2b-dcf6-801f-209e-11eba59203fe@linux.intel.com>
Date:   Wed, 8 May 2019 12:04:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/19 11:51 AM, Evan Green wrote:
> On Tue, May 7, 2019 at 3:31 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> On 5/7/19 4:53 PM, Evan Green wrote:
>>> Add PCI IDs for Intel CometLake platforms, which from a software
>>> point of view are extremely similar to Cannonlake platforms.
>>
>> Humm, I have mixed feelings here.
>>
>> Yes the hardware is nearly identical, with the exception of one detail
>> that's not visible to the kernel, but there is no support for DMICs with
>> the Skylake driver w/ HDaudio, and Chrome platforms are only going with
>> SOF, so is it wise to add these two CometLake platforms to the default
>> SND_SOC_INTEL_SKYLAKE selector, which is used by a number of distributions?
>>
>> I don't mind if we add those PCI IDs and people use this driver if they
>> wish to, but it may be time for an explicit opt-in? The
>> SND_SOC_INTEL_SKYLAKE definition should even be pruned to mean SKL, APL,
>> KBL and GLK, and we can add DMI-based quirks for e.g. the Up2 board and
>> GLK Chromebooks which work with SOF.
> 
> I don't have the context here, so feel free to ignore me. But it seems
> like such a tiny amount of extra bits to add to make Cometlake work,
> and then there's no hassle for the distributions when Cometlake
> devices start showing up in the wild. So while things are more or less
> the same, why not continue piggypacking off the default?
> Or are you saying that the lack of DMIC support means the default
> should be to use a different driver?

Yes, it's the latter case, SOF will be the only driver supporting DMICs 
on CometLake, so it'd be better to avoid creating a conflict with SOF or 
enabling a configuration by default which is known to have restrictions. 
It's fine to add the CML IDs, but better avoid adding CML under the 
SKYLAKE all-you-can-eat selector.
