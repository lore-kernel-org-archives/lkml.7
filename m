Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F48C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CC82075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfHFQ4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:56:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:21567 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732048AbfHFQ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:56:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 09:55:59 -0700
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="325687415"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.91]) ([10.24.14.91])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 06 Aug 2019 09:55:59 -0700
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
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <151002be-33e6-20d6-7699-bc9be7e51f33@intel.com>
Date:   Tue, 6 Aug 2019 09:55:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806155716.GE25897@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/6/2019 8:57 AM, Borislav Petkov wrote:
> On Mon, Aug 05, 2019 at 10:57:04AM -0700, Reinette Chatre wrote:
>> What do you think?
> 
> Actually, I was thinking about something a lot simpler: something
> along the lines of adding the CPUID check in a helper function which
> rdt_pseudo_lock_init() calls. If the cache is not inclusive - and my
> guess is it would suffice to check any cache but I'd prefer you correct
> me on that - you simply return error and rdt_pseudo_lock_init() returns
> early without doing any futher init.
> 
> How does that sound?

I am a bit cautious about this. When I started this work I initially
added a helper function to resctrl that calls CPUID to determine if the
cache is inclusive. At that time I became aware of a discussion
motivating against scattered CPUID calls and motivating for one instance
of CPUID information:
http://lkml.kernel.org/r/alpine.DEB.2.21.1906162141301.1760@nanos.tec.linutronix.de

My interpretation of the above resulted in a move away from calling
CPUID in resctrl to the patch you are reviewing now.

I do indeed prefer a simple approach and would change to what you
suggest if you find it to be best.

To answer your question about checking any cache: this seems to be
different between L2 and L3. On the Atom systems where L2 pseudo-locking
works well the L2 cache is not inclusive. We are also working on
supporting cache pseudo-locking on L3 cache that is not inclusive.

I could add the single CPUID check during rdt_pseudo_lock_init(),
checking on any CPU should work. I think it would be simpler (reasons
below) to initialize that single system-wide setting in
rdt_pseudo_lock_init() and keep the result locally in the pseudo-locking
code, that can be referred to when the user requests the pseudo-locked
region.

Simpler for two reasons:
* Prevent future platform specific code within rdt_pseudo_lock_init()
trying to pick when L3 is allowed to be inclusive or not.
* rdt_pseudo_lock_init() does not currently make decision whether
platform supports pseudo-locking - this is currently done when user
requests a pseudo-lock region. rdt_pseudo_lock_init() does
initialization of things that should not fail and for which resctrl's
mount should not proceed if it fails. A platform not supporting
pseudo-locking should not prevent resctrl from being mounted and used
for cache allocation.

Thank you very much

Reinette
