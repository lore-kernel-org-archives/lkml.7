Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8660C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83136207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437078AbfITCSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:18:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:26559 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437065AbfITCSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:18:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 19:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; 
   d="scan'208";a="194565338"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2019 19:18:39 -0700
Date:   Fri, 20 Sep 2019 10:18:21 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: fix return value of p[um]dp_set_access_flags
Message-ID: <20190920021821.GA8472@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190919082549.3895-1-richardw.yang@linux.intel.com>
 <307c9866-c037-5d87-709f-840bdb577283@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307c9866-c037-5d87-709f-840bdb577283@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 10:25:05AM -0700, Dave Hansen wrote:
>On 9/19/19 1:25 AM, Wei Yang wrote:
>> Function p[um]dp_set_access_flags is used with update_mmu_cache_p[um]d
>> and the return value from p[um]dp_set_access_flags indicates whether it
>> is necessary to do the cache update.
>
>If this change is correct, why was it not applied to
>ptep_set_access_flags()?  That function has the same form.
>

Thanks, you are right, I missed this point.

>BTW, I rather dislike the 'dirty' variable name.  It seems to be
>indicating whether the fault was a write fault or not and whether we
>*expect* the dirty bit to be set in 'entry'.
>

I found some comments for ptep_set_access_flags in OLD code, which says

/*
 * We only update the dirty/accessed state if we set
 * the dirty bit by hand in the kernel, since the hardware
 * will do the accessed bit for us, and we don't want to
 * race with other CPU's that might be updating the dirty
 * bit at the same time.
 */

I guess this is reason for the naming. Looks currently we use this value in
some other way.

>> From current code logic, only when changed && dirty, related page table
>> entry would be updated. It is not necessary to update cache when the
>> real page table entry is not changed.
>
>This logic doesn't really hold up, though.
>
>If we are only writing accessed and/or dirty bits, then we *never* need
>to flush.  The flush might avoid a stale TLB entry causing an extra page
>walk by the hardware, but it's probably not ever worth the cost of the
>flush.
>
>Unless there's something weird happening with paravirt, I can't ever see
>a good reason to flush the TLB when just setting accessed/dirty bits on
>bare-metal.
>
>This seems like a place where a debugging check to validate that only
>accessed/dirty bits are only being set would be a good idea.

The function update_mmu_cache_pmd is not for x86, IMHO, since it is empty on
x86.

I took a look into the definition on powerpc, which is defined in
arch/powerpc/mm/book3s64/pgtable.c, which preload the content of this HPTE. So
the cache update here is not TLB flush on x86.

And then I compare the definition of ptep_set_access_flags on x86 and powerpc.
On powerpc, which is defined in arch/powerpc/mm/pgtable.c, update the pte
without checking *dirty*. This logic make sense to me. So I am confused with
why on x86 we need to check both *changed* and *dirty*. 

Then I searched the history, and found commit 8dab5241d06bf may explain
something.

The commit log says:

    This patch reworks ptep_set_access_flags() semantics, implementations and
    callers so that it's now responsible for returning whether an update is
    necessary or not (basically whether the PTE actually changed).

If my understanding is correct, the return value should indicate whether the
PTE actually changed.

But the change introduced in commit 8dab5241d06bf is not doing the exact
thing on x86. Since we only change PTE only both *dirty* and *change*, just
return *changed* seems not match the semantics. 

Last but not least, since update_mmu_cache_pmd is empty, even return value is
not correct, it doesn't break anything.

Hope my understanding is correct.

-- 
Wei Yang
Help you, Help me
