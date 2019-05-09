Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4790CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E8221848
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfEISpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfEISpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:45:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14F547DCC1;
        Thu,  9 May 2019 18:45:36 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B130F4A3;
        Thu,  9 May 2019 18:45:33 +0000 (UTC)
Date:   Thu, 9 May 2019 13:45:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
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
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190509184531.jhinxi2x2pdfaefb@treble>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
 <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <20190509090058.6554dc81@gandalf.local.home>
 <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
 <20190509142902.08a32f20@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509142902.08a32f20@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 09 May 2019 18:45:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 02:29:02PM -0400, Steven Rostedt wrote:
> On Thu, 9 May 2019 09:51:59 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, May 9, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > This patch works. Can I get your Signed-off-by for it?  
> > 
> > Yes. Please write some kind of comprehensible commit log for it, but
> 
> How's this:
> 
> "Peter Zijlstra noticed that with CONFIG_PROFILE_ALL_BRANCHES, the "if"
> macro converts the conditional to an array index.  This can cause GCC
> to create horrible code.  When there are nested ifs, the generated code
> uses register values to encode branching decisions.
> 
> Josh Poimboeuf found that replacing the define "if" macro from using
> the condition as an array index and incrementing the branch statics
> with an if statement itself, reduced the asm complexity and shrinks the
> generated code quite a bit.
> 
> But this can be simplified even further by replacing the internal if
> statement with a ternary operator.
> 
> Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>

Actually, my original fix already went in:

  37686b1353cf ("tracing: Improve "if" macro code generation")

But it introduced a regression:

  https://lkml.kernel.org/r/201905040509.iqQ2CrOU%lkp@intel.com

which Linus' patch fixes for some reason.

-- 
Josh
