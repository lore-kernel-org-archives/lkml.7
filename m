Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556F6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D8F20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEOJIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:08:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfEOJIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09FF6341;
        Wed, 15 May 2019 02:08:46 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7370C3F703;
        Wed, 15 May 2019 02:08:43 -0700 (PDT)
Subject: Re: [PATCH v7 10/13] selftests/resctrl: Add vendor detection
 mechanism
To:     =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <1549767042-95827-11-git-send-email-fenghua.yu@intel.com>
 <20190510183909.65732a67@donnerap.cambridge.arm.com>
 <5cc3b562-6e48-f64c-06dd-b1ee1059e33e@arm.com>
 <676ca766-fcd0-6b47-2961-92ef21ecf32e@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f40850cf-5e16-3e99-5ee4-bc4538b5c06d@arm.com>
Date:   Wed, 15 May 2019 10:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <676ca766-fcd0-6b47-2961-92ef21ecf32e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

On 14/05/2019 20:40, André Przywara wrote:
> On 14/05/2019 18:20, James Morse wrote:
>> On 10/05/2019 18:39, Andre Przywara wrote:
>>> On Sat,  9 Feb 2019 18:50:39 -0800
>>> Fenghua Yu <fenghua.yu@intel.com> wrote:
>>>> From: Babu Moger <babu.moger@amd.com>
>>>>
>>>> RESCTRL feature is supported both on Intel and AMD now. Some features
>>>> are implemented differently. Add vendor detection mechanism. Use the vendor
>>>> check where there are differences.
>>>
>>> I don't think vendor detection is the right approach. The Linux userland
>>> interface should be even architecture agnostic, not to speak of different
>>> vendors.
>>>
>>> But even if we need this for some reason ...

>> What do we need it for? Surely it indicates something is wrong with the kernel interface
>> if you need to know which flavour of CPU this is.
> 
> As you mentioned, we should not need it. I just couldn't find a better
> way (yet) to differentiate between L3 cache ID and physical package ID
> (see patch 11/13). So this is a kludge for now to not break this
> particular code.

[0]? That's broken. It needs to take the 'cache/index?/id' field, and not hard-code '3',
search each 'cache/index?/level' instead.


Documentation/x86/resctrl_ui.rst's "Cache IDs" section says:
| On current generation systems there is one L3 cache per socket and L2
| caches are generally just shared by the hyperthreads on a core, but this
| isn't an architectural requirement.
[...]
| So instead of using "socket" or "core" to define the set of logical cpus
| sharing a resource we use a "Cache ID"
[...]
| To find the ID for each logical CPU look in
| /sys/devices/system/cpu/cpu*/cache/index*/id

arch/x86/kernel/cpu/restrl/core.c:domain_add_cpu() pulls the domain-id out of struct
cacheinfo:
|	int id = get_cache_id(cpu, r->cache_level);

drivers/base/cacheinfo.c has some macro-foliage that exports this same field via sysfs,
and arch/x86/kernel/cpu/restrl/ctrlmondata.c:parse_line() matches that id against the
value user-space provides in the schemata.

(we've got some horrible code for arm64 to make this work without 'cache id' as a hardware
property!)

On x86 these numbers are of the order 0,1,2, so its very likely physical_package_id and
cache_id alias, and you get away with it.


> Out of curiosity: Is there any userland tool meant to control the
> resources? I guess poking around in sysfs is not how admins are expected
> to use this?

I've come across:
https://github.com/intel/intel-cmt-cat/

but I've never even cloned it. The rdtset man page has:
| With --iface-os (-I) parameter, rdtset uses resctrl filesystem (/sys/fs/resctrl)
| instead of accessing MSRs directly.


> This tool would surely run into the same problems, which somewhat tell
> me that the interface is not really right.

At the moment its not as-documented or as the kernel is using those numbers.

I assume this is something that changed in resctrl when it was merged, and this selftest
tool just needs updating.


Thanks,

James

[0] https://lkml.org/lkml/2019/2/9/384
