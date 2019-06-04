Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C00207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFDSVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFDSV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:21:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31F5A30BC576;
        Tue,  4 Jun 2019 18:21:24 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 041AB5C207;
        Tue,  4 Jun 2019 18:21:21 +0000 (UTC)
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net>
 <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
 <20190604181426.GH3419@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
Date:   Tue, 4 Jun 2019 14:21:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604181426.GH3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 04 Jun 2019 18:21:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 2:14 PM, Peter Zijlstra wrote:
>> I worked on this owner merging patch mainly to alleviate the need to use
>> cmpxchg for reader lock. cmpxchg_double() is certainly one possible
>> solution though it won't work on older CPUs. We can have a config option
>> to use cmpxchg_double as it may increase the size of other structures
>> that embedded rwsem and impose additional alignment constraint.
> cmpxchg8b was introduced with the Pentium (for PAE IIRC, it enabled
> atomic 64bit PTEs, but Linux never used it for that) and every Intel/AMD
> thereafter has had it. AFAIK there's no x86_64 chip without cmpxchg16b.

Thank for the clarification. I actually didn't check when cmpxch8b was
introduced. I know it is a bit slower than regular cmpxchg. So we may
still need to do some performance analysis to see how it compares with
my current approach.

Cheers,
Longman

