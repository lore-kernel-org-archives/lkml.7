Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D58C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E279207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfFDRGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:06:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfFDRGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7E3281E0A;
        Tue,  4 Jun 2019 17:06:14 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF20C1001DFD;
        Tue,  4 Jun 2019 17:06:11 +0000 (UTC)
Subject: Re: [PATCH v8 17/19] locking/rwsem: Merge owner into count on x86-64
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
 <20190520205918.22251-18-longman@redhat.com>
 <20190604094537.GK3402@hirez.programming.kicks-ass.net>
 <d03f319a-790c-3084-2908-76f44d3f41f5@redhat.com>
 <20190604170218.GE3419@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <28a6c7b5-c40e-1c89-03e2-688c1135f3b5@redhat.com>
Date:   Tue, 4 Jun 2019 13:06:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604170218.GE3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 04 Jun 2019 17:06:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 1:02 PM, Peter Zijlstra wrote:
> On Tue, Jun 04, 2019 at 11:47:21AM -0400, Waiman Long wrote:
>> On 6/4/19 5:45 AM, Peter Zijlstra wrote:
>>> On Mon, May 20, 2019 at 04:59:16PM -0400, Waiman Long wrote:
>>>> With separate count and owner, there are timing windows where the two
>>>> values are inconsistent. That can cause problem when trying to figure
>>>> out the exact state of the rwsem. For instance, a RT task will stop
>>>> optimistic spinning if the lock is acquired by a writer but the owner
>>>> field isn't set yet. That can be solved by combining the count and
>>>> owner together in a single atomic value.
>>> I just realized we can use cmpxchg_double() here (where available of
>>> course).
>> Does the 2 doubles need to be 128-bit aligned to use cmpxchg_double()? I
>> don't think we can guarantee that unless we explicitly set this alignment.
> It does :/ and yes, we'd need to play games with __align(2*sizeof(long))
> and such.

So do you want this as an option now as it will be x86 specific? Or we
can do that as a follow-up if we want to.

Cheers,
Longman

