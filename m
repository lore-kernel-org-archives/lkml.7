Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40B92081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCGRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:17:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGRRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:17:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6604381DFC;
        Thu,  7 Mar 2019 17:17:13 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A00BB5C28C;
        Thu,  7 Mar 2019 17:17:11 +0000 (UTC)
Date:   Thu, 7 Mar 2019 11:17:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
Message-ID: <20190307171709.dap5hfeof4yo3nsc@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307120317.GD32477@hirez.programming.kicks-ass.net>
 <20190307125526.GB32534@hirez.programming.kicks-ass.net>
 <20190307131312.GC32534@hirez.programming.kicks-ass.net>
 <20190307164705.qbu4ytdfdmsighas@treble>
 <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfvwn1L7BduXA02rZdDnKGb8ebzm4C--QcfVF+gjHAvQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Mar 2019 17:17:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:00:49AM -0800, Linus Torvalds wrote:
> On Thu, Mar 7, 2019 at 8:47 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > This "fixes" it, and also seems to help -Os make much code:
> 
> Yeah, considering that this __trace_if() macro from hell is doing an
> 'if()' on the result of that inner thing, it makes sense to *not*  use
> that "looks simpler and shorter" array sequence, but depend on the
> compiler then noticing that the conditionals are the same and joining
> the two branches together.
> 
> The compiler has to do much more work to either generate the actual
> dynamic array thing, or notice that the _index_ of the array matches
> the _conditional_ on the branch, and undo that thing.

Yeah, agreed.  Now it doesn't have to do the funky xor thing to convert
the conditional to an int.

> But that macro really is the macro from hell regardless.
> 
> Do people really use CONFIG_PROFILE_ALL_BRANCHES?

IIRC, Steven runs it once a year or so...

-- 
Josh
