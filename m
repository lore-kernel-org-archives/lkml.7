Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC9AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EF320821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfEVUun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfEVUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CA2D307D963;
        Wed, 22 May 2019 20:50:36 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51AB5648B3;
        Wed, 22 May 2019 20:50:31 +0000 (UTC)
Subject: Re: [PATCH] locking/lock_events: Use this_cpu_add() when necessary
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190522153953.30341-1-longman@redhat.com>
 <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <65f36604-898d-2649-5a41-078ccdc08dc4@redhat.com>
Date:   Wed, 22 May 2019 16:50:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjit1=wf-JxUebS4_9WUCKbnfGPt0QF13-LijmumMEB-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 22 May 2019 20:50:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 3:54 PM, Linus Torvalds wrote:
> On Wed, May 22, 2019 at 8:40 AM Waiman Long <longman@redhat.com> wrote:
>> +#if defined(CONFIG_PREEMPT) && \
>> +   (defined(CONFIG_DEBUG_PREEMPT) || !defined(CONFIG_X86))
>> +#define lockevent_percpu_inc(x)                this_cpu_inc(x)
>> +#define lockevent_percpu_add(x, v)     this_cpu_add(x, v)
> Why that CONFIG_X86 special case?
>
> On x86, the regular non-underscore versionm is perfectly fine, and the
> underscore is no faster or simpler.

The condition is to use non-underscore version only when

1) It is a preempt kernel; AND
2) It either have CONFIG_DEBUG_PREEMPT on, OR it is a non-x86 system.


> So just make it be
>
>    #if defined(CONFIG_PREEMPT)
>      .. non-underscore versions..
>    #else
>      .. underscore versions ..
>    #endif
>
> and realize that x86 simply doesn't _care_. On x86, it will be one
> single instruction regardless.
>
> Non-x86 may prefer the underscore versions for the non-preempt case.

I was thinking of doing that originally, but then change it so x86
preempt kernel will also use the underscore version as long as
CONFIG_DEBUG_PREEMPT is not set.

I can change it back if that makes it less confusing.

Cheers,
Longman

