Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B0E2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfHER5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:57:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:26659 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfHER5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 10:57:06 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="257789036"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.108]) ([10.24.14.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 05 Aug 2019 10:57:07 -0700
Subject: Re: [PATCH V2 01/10] x86/CPU: Expose if cache is inclusive of lower
 level caches
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <6c78593207224014d6a9d43698a3d1a0b3ccf2b6.1564504901.git.reinette.chatre@intel.com>
 <20190802180352.GE30661@zn.tnic>
 <e532ab90-196c-8b58-215a-f56f5e409512@intel.com>
 <20190803094423.GA2100@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
Date:   Mon, 5 Aug 2019 10:57:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190803094423.GA2100@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/3/2019 2:44 AM, Borislav Petkov wrote:
> On Fri, Aug 02, 2019 at 01:11:13PM -0700, Reinette Chatre wrote:
>> This patch only makes it possible to determine whether cache is
>> inclusive for some x86 platforms while all platforms of all
>> architectures are given visibility into this new "inclusive" cache
>> information field within the global "struct cacheinfo".
> 
> And this begs the question: do the other architectures even need that
> thing exposed? As it is now, this is x86-only so I'm wondering whether
> adding all that machinery to the generic struct cacheinfo is even needed
> at this point.

I do not know if more users would appear in the future but the goal of
this patch is to make this information available to resctrl. Since there
are a few ways to do so I really appreciate your guidance on how to do
this right. I'd be happy to make needed changes.

> TBH, I'd do it differently: read CPUID at init time and cache the
> information whether the cache is inclusive locally and be done with it.
> It is going to be a single system-wide bit anyway as I'd strongly assume
> cache settings like inclusivity should be the same across the whole
> system.

I've been digesting your comment and tried a few options but I have been
unable to come up with something that fulfill all your suggestions -
specifically the "single system-wide bit" one. These areas of code are
unfamiliar to me so I am not confident what I came up with for other
suggestions are the right way either.

So far it seems I can do the following:
Introduce a new bitfield into struct cpuinfo_x86. There is one existing
bitfield in this structure ("initialized") so we could add a new one
("x86_cache_l3_inclusive"?) just before it. With this information
included in this struct it becomes available via the global
boot_cpu_data, this seems to address the "system-wide bit" but this
struct is also maintained for all other CPUs on the system so may not be
what you had in mind (not a "single system-wide bit")?

If proceeding with inclusion into struct cpuinfo_x86 this new bitfield
can be initialized within init_intel_cacheinfo(). There are a few cache
properties within cpuinfo_x86 and they are initialized in a variety of
paths. init_intel_cacheinfo() is initialized via init_intel() and it
already has the needed CPUID information available making initialization
here straight forward. Alternatively there is also identify_cpu() that
also initializes many cache properties ... but would need some more code
to obtain needed values.

Finally, if the above is done, the resctrl code could just refer to this
new property directly as obtained from boot_cpu_data.x86_cache_l3_inclusive

What do you think?

> 
> When the other arches do need it, we can extract that info "up" into the
> generic layer.

Reinette

