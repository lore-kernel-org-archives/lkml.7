Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8268C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B998720840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfCGSw4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:52:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34325 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCGSw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:52:56 -0500
Received: from [IPv6:2607:fb90:3224:d3ed:dc53:8bcb:85c6:5b5b] ([IPv6:2607:fb90:3224:d3ed:dc53:8bcb:85c6:5b5b])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x27Iq2dH2300868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Mar 2019 10:52:03 -0800
Date:   Thu, 07 Mar 2019 10:51:59 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190307184813.GL32477@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org> <20190307115200.697533978@infradead.org> <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com> <20190307174135.GJ32477@hirez.programming.kicks-ass.net> <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com> <20190307184813.GL32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   hpa@zytor.com
Message-ID: <B03AE722-4BAF-4BD1-9A7D-3DD790A7F306@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2019 10:48:13 AM PST, Peter Zijlstra <peterz@infradead.org> wrote:
>On Thu, Mar 07, 2019 at 09:54:14AM -0800, Linus Torvalds wrote:
>> On Thu, Mar 7, 2019 at 9:41 AM Peter Zijlstra <peterz@infradead.org>
>wrote:
>> > >
>> > > What's the call site that made you go "just add __memset() to the
>list"?
>> >
>> > __asan_{,un}poinson_stack_memory()
>> >   kasan_{,un}poison_shadow()
>> >     __memset()
>> 
>> Ugh. I think I almost just agree with your decision to just let that
>> memset go unchecked.
>> 
>> I'm not saying it's right, but it doesn't seem to be a fight worth
>fighting.
>
>One think I could do; is add a filter to each function and only allow
>__memset from the kasan code, and not from anywhere else.
>
>Another thing I need to look at is why objtool only found memset_orig
>(from __memset) but not memset_erms, which if I read the code right, is
>a possible alternative there.
>
>> Because AC vs KASAN in general ends up smelling like "not a fight
>> worth fighting" to me. You've done a herculean job, but..
>
>I know,.. I've been so close to doing that so many times, but it
>seems like defeat, esp. since I'm so close now :-)

___memset_kasan()?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
