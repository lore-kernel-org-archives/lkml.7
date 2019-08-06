Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8838C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D912075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfHFSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:19:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:60069 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFSTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:19:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:13:24 -0700
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="325711406"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.91]) ([10.24.14.91])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 06 Aug 2019 11:13:24 -0700
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
 <122b005a-46b1-2b1e-45a8-7f92a5dba2d9@intel.com>
 <20190806155716.GE25897@zn.tnic>
 <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
 <20190806173300.GF25897@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <d0c04521-ec1a-3468-595c-6929f25f37ff@intel.com>
Date:   Tue, 6 Aug 2019 11:13:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806173300.GF25897@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/6/2019 10:33 AM, Borislav Petkov wrote:
> On Tue, Aug 06, 2019 at 09:55:56AM -0700, Reinette Chatre wrote:
>> I am a bit cautious about this. When I started this work I initially
>> added a helper function to resctrl that calls CPUID to determine if the
>> cache is inclusive. At that time I became aware of a discussion
>> motivating against scattered CPUID calls and motivating for one instance
>> of CPUID information:
>> http://lkml.kernel.org/r/alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de
> 
> Ah, there's that. That's still somewhat a work/discussion in progress
> thing. Let me discuss it with tglx.
> 
>> To answer your question about checking any cache: this seems to be
> 
> I meant the CPUID on any CPU and thus any cache - i.e., all L3s on the
> system should be inclusive and identical in that respect. Can't work
> otherwise, I'd strongly presume.

This is my understanding, yes. While this patch supports knowing whether
each L3 is inclusive or not, I expect this information to be the same
for all L3 instances as will be supported by a single query in
rdt_pseudo_lock_init(). This definitely is the case on the platforms we
are enabling in this round.

>> different between L2 and L3. On the Atom systems where L2 pseudo-locking
>> works well the L2 cache is not inclusive. We are also working on
>> supporting cache pseudo-locking on L3 cache that is not inclusive.
> 
> Hmm, so why are you enforcing the inclusivity now:
> 
> +       if (p->r->cache_level == 3 &&
> +           !get_cache_inclusive(plr->cpu, p->r->cache_level)) {
> +               rdt_last_cmd_puts("L3 cache not inclusive\n");
> 
> but then will remove this requirement in the future? Why are we even
> looking at cache inclusivity then and not make pseudo-locking work
> regardless of that cache property?

Some platforms being enabled in this round have SKUs with inclusive
cache and also SKUs with non-inclusive cache. The non-inclusive cache
SKUs do not support cache pseudo-locking and cannot be made to support
cache pseudo-locking with software changes. Needing to know if cache is
inclusive or not will thus remain a requirement to distinguish between
these different SKUs. Supporting cache pseudo-locking on platforms with
non inclusive cache will require new hardware features.
> Because if we're going to go and model this cache inclusivity property
> properly in struct cpuinfo_x86 or struct cacheinfo or wherever, and do
> that for all cache levels because apparently we're going to need that;
> but then later it turns out we won't need it after all, why are we even
> bothering?
> 
> Or am I missing some aspect?

Reinette




