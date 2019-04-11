Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFAFC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2D217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jlAnuO3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDKDqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:46:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uKfRStAyrP58fhGtk2XSLwMywPdjGRfGVFF6P6t+7cs=; b=jlAnuO3f3hip6CyPfh3KqSSD9y
        hicJm6QXXI55iLK2eLLFkRUkBZv5Q6zpXTy6KwYQ3vfUr49qcq3T4W9+ivpJrAbZlJN7sIhBjgwuc
        UVy21ln9uhd9DhLrJyLQN5VT2iHbJTb+Kapd8BZmnbw9E6DpjbCLXd1sWB/00FkaZsMPKww1XRkJ2
        hKOOaHUZOE0ruZS5bSMBPaAzDqe2c6qxEIVC87xa3qaHPB34zM9gcEOc8rKw1J+QJJCvJTzFXFMwP
        Q/tr8DHYtUvu7/naeO9J8BJ0PAqGNZj/cxDX9WnAEr1ORe6eIJG1JNdVnVhOIyZuSi64GiOFnaHSV
        mc/aAfBA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEQdY-0006Ue-9z; Thu, 11 Apr 2019 03:44:28 +0000
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Sinan Kaya <okaya@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
References: <20190410224213.20651-1-okaya@kernel.org>
 <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
 <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
 <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
 <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf16f27b-4c76-8577-ac0e-9b4238aee89e@infradead.org>
Date:   Wed, 10 Apr 2019 20:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 8:02 PM, Josh Triplett wrote:
> On April 10, 2019 4:24:18 PM PDT, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Apr 10, 2019 at 4:22 PM Josh Triplett <josh@joshtriplett.org>
>> wrote:
>>>
>>> On April 10, 2019 3:58:55 PM PDT, Kees Cook <keescook@chromium.org>
>> wrote:
>>>> On Wed, Apr 10, 2019 at 3:42 PM Sinan Kaya <okaya@kernel.org> wrote:
>>>>>
>>>>> We can't seem to have a kernel with CONFIG_EXPERT set but
>>>>> CONFIG_DEBUG_KERNEL unset these days.
>>>>>
>>>>> While some of the features under the CONFIG_EXPERT require
>>>>> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>>>>>
>>>>> It looks like CONFIG_KALLSYMS_ALL is the only feature that
>>>>> requires CONFIG_DEBUG_KERNEL.
>>>>>
>>>>> Select CONFIG_EXPERT when CONFIG_DEBUG is chosen but you can
>>>>
>>>> Typo: CONFIG_DEBUG_KERNEL
>>>>
>>>>> still choose CONFIG_EXPERT without CONFIG_DEBUG.
>>>>
>>>> same.
>>>>
>>>>>
>>>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>>>>
>>>> But with those fixed, looks good to me. Adding Josh (and others) to
>> CC
>>>> since he originally added the linkage to EXPERT in commit
>>>> f505c553dbe2.
>>>
>>> CONFIG_DEBUG_KERNEL shouldn't affect code generation in any way; it
>> should only make more options appear in kconfig. I originally added
>> this to ensure that features you might want to *disable* aren't hidden,
>> as part of the tinification effort.
>>>
>>> What specific problem does having CONFIG_DEBUG_KERNEL enabled cause
>> for you? I'd still prefer to have a single switch for "don't hide
>> things I might want to disable", rather than several.
>>
>> See earlier in the thread: code generation depends on
>> CONFIG_DEBUG_KERNEL now unfortunately.
> 
> Then let's fix *that*, and get checkpatch to help enforce it in the future. EXPERT doesn't affect code generation, and neither should this.
> 

checkpatch is not an enforcer.  It takes maintainers to do that.


-- 
~Randy
