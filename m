Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BAF21900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfCURZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCURZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D41EF309E975;
        Thu, 21 Mar 2019 17:25:11 +0000 (UTC)
Received: from [10.43.17.111] (unknown [10.43.17.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B26085D9C5;
        Thu, 21 Mar 2019 17:25:06 +0000 (UTC)
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
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
References: <20190318153840.906404905@infradead.org>
 <20190318155139.963285969@infradead.org>
 <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
 <20190318173657.GV6058@hirez.programming.kicks-ass.net>
 <20190318175135.GE6521@hirez.programming.kicks-ass.net>
 <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <aac45ef8-0196-b1c4-67ce-26dd0da6d641@redhat.com>
Date:   Thu, 21 Mar 2019 18:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Mar 2019 17:25:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 7:10 PM, Linus Torvalds wrote:
> On Mon, Mar 18, 2019 at 10:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> How about I do a patch that schedules EFLAGS for both 32bit and 64bit,
>> mark this for backporting to infinity.
>>
>> And then at the end, after the objtool-ac bits land, I do a patch
>> removing the EFLAGS scheduling for x86_64.
> 
> Sounds sane to me.
> 
> And we can make it AC-conditional if it's actually shown to be visible
> from a performance standpoint.
> 
> But iirc pushf/popf isn't really that expensive - in fact I think it's
> pretty cheap when system flags don't change.

I did not see evidence of this. In my testing,
POPF is always ~20 cycles, even if popped flags are identical to current
state of flags.
