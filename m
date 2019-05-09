Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819CBC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C08217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEIS3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfEIS3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:29:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B94DE217D9;
        Thu,  9 May 2019 18:29:03 +0000 (UTC)
Date:   Thu, 9 May 2019 14:29:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190509142902.08a32f20@gandalf.local.home>
In-Reply-To: <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
        <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
        <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
        <20190509090058.6554dc81@gandalf.local.home>
        <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 09:51:59 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, May 9, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > This patch works. Can I get your Signed-off-by for it?  
> 
> Yes. Please write some kind of comprehensible commit log for it, but

How's this:

"Peter Zijlstra noticed that with CONFIG_PROFILE_ALL_BRANCHES, the "if"
macro converts the conditional to an array index.  This can cause GCC
to create horrible code.  When there are nested ifs, the generated code
uses register values to encode branching decisions.

Josh Poimboeuf found that replacing the define "if" macro from using
the condition as an array index and incrementing the branch statics
with an if statement itself, reduced the asm complexity and shrinks the
generated code quite a bit.

But this can be simplified even further by replacing the internal if
statement with a ternary operator.

Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
"

> 
>    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

-- Steve

> 
> for the patch itself.
> 
