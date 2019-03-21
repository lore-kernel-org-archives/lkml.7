Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B660218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfCUSXJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:23:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42855 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUSXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:23:06 -0400
Received: from [IPv6:2607:fb90:3258:198e:38c6:f38f:7326:f16d] ([IPv6:2607:fb90:3258:198e:38c6:f38f:7326:f16d])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2LIMORg236852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 21 Mar 2019 11:22:26 -0700
Date:   Thu, 21 Mar 2019 11:22:22 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net> <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net> <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net> <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com> <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
From:   hpa@zytor.com
Message-ID: <452B5054-91CC-48EE-A500-C251223B8F2D@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 21, 2019 11:18:53 AM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Thu, Mar 21, 2019 at 11:05 AM Andy Lutomirski <luto@amacapital.net>
>wrote:
>>
>> In the long run, I think the right solution is to rewrite even more
>of
>> this mess in C.  We really ought to be able to put the IRQ flag
>> tracing and the context tracking into C code.
>
>Tangentially about this long run thing - can we start discussing just
>dropping PV mode entirely in the long run? Or even not-so-long run?
>
>What are the pressing advantages of paravirt these days? Because I can
>point to a lot of pressing _disadvantages_, and not all of them are
>about more complex code as shown by this patch...
>
>             Linus

God only knows how nice that would be (for things that aren't naturally driverized.) Last I heard, which was quite a while ago, the big problem was that the Amazon cloud runs Xen in PV mode...
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
