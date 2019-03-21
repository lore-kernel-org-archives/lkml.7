Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D4821874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfCUSTC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:19:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40295 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUSTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:19:01 -0400
Received: from [IPv6:2607:fb90:3258:198e:38c6:f38f:7326:f16d] ([IPv6:2607:fb90:3258:198e:38c6:f38f:7326:f16d])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2LII9Nu235972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 21 Mar 2019 11:18:10 -0700
Date:   Thu, 21 Mar 2019 11:18:05 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <aac45ef8-0196-b1c4-67ce-26dd0da6d641@redhat.com>
References: <20190318153840.906404905@infradead.org> <20190318155139.963285969@infradead.org> <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com> <20190318173657.GV6058@hirez.programming.kicks-ass.net> <20190318175135.GE6521@hirez.programming.kicks-ass.net> <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com> <aac45ef8-0196-b1c4-67ce-26dd0da6d641@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
To:     Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   hpa@zytor.com
Message-ID: <33D32634-51DC-426D-BE4A-F78B862760D5@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 21, 2019 10:25:05 AM PDT, Denys Vlasenko <dvlasenk@redhat.com> wrote:
>On 3/18/19 7:10 PM, Linus Torvalds wrote:
>> On Mon, Mar 18, 2019 at 10:51 AM Peter Zijlstra
><peterz@infradead.org> wrote:
>>>
>>> How about I do a patch that schedules EFLAGS for both 32bit and
>64bit,
>>> mark this for backporting to infinity.
>>>
>>> And then at the end, after the objtool-ac bits land, I do a patch
>>> removing the EFLAGS scheduling for x86_64.
>> 
>> Sounds sane to me.
>> 
>> And we can make it AC-conditional if it's actually shown to be
>visible
>> from a performance standpoint.
>> 
>> But iirc pushf/popf isn't really that expensive - in fact I think
>it's
>> pretty cheap when system flags don't change.
>
>I did not see evidence of this. In my testing,
>POPF is always ~20 cycles, even if popped flags are identical to
>current
>state of flags.

I think you will find that if you change system flags it is much slower.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
