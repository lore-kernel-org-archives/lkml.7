Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B345DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92043204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfEIS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfEIS5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:57:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 398D0C0601F2;
        Thu,  9 May 2019 18:57:08 +0000 (UTC)
Received: from treble (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3D5460FE6;
        Thu,  9 May 2019 18:57:03 +0000 (UTC)
Date:   Thu, 9 May 2019 13:57:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20190509185701.hocym3zlc4x4pmx5@treble>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
 <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
 <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
 <20190509090058.6554dc81@gandalf.local.home>
 <CAHk-=wiLMXDO-_NGjgtoHxp9TRpcnykHPNWOHfXfWd9GmCu1Uw@mail.gmail.com>
 <20190509142902.08a32f20@gandalf.local.home>
 <20190509184531.jhinxi2x2pdfaefb@treble>
 <20190509184715.6y2uzlld4irlm3tw@treble>
 <3998ab5d-225b-0680-5edf-60b4068e3e59@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3998ab5d-225b-0680-5edf-60b4068e3e59@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 09 May 2019 18:57:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:48:43AM -0700, Randy Dunlap wrote:
> On 5/9/19 11:47 AM, Josh Poimboeuf wrote:
> > On Thu, May 09, 2019 at 01:45:31PM -0500, Josh Poimboeuf wrote:
> >> On Thu, May 09, 2019 at 02:29:02PM -0400, Steven Rostedt wrote:
> >>> On Thu, 9 May 2019 09:51:59 -0700
> >>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >>>
> >>>> On Thu, May 9, 2019 at 6:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >>>>>
> >>>>> This patch works. Can I get your Signed-off-by for it?  
> >>>>
> >>>> Yes. Please write some kind of comprehensible commit log for it, but
> >>>
> >>> How's this:
> >>>
> >>> "Peter Zijlstra noticed that with CONFIG_PROFILE_ALL_BRANCHES, the "if"
> >>> macro converts the conditional to an array index.  This can cause GCC
> >>> to create horrible code.  When there are nested ifs, the generated code
> >>> uses register values to encode branching decisions.
> >>>
> >>> Josh Poimboeuf found that replacing the define "if" macro from using
> >>> the condition as an array index and incrementing the branch statics
> >>> with an if statement itself, reduced the asm complexity and shrinks the
> >>> generated code quite a bit.
> >>>
> >>> But this can be simplified even further by replacing the internal if
> >>> statement with a ternary operator.
> >>>
> >>> Reported-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >>
> >> Actually, my original fix already went in:
> >>
> >>   37686b1353cf ("tracing: Improve "if" macro code generation")
> >>
> >> But it introduced a regression:
> >>
> >>   https://lkml.kernel.org/r/201905040509.iqQ2CrOU%lkp@intel.com
> >>
> >> which Linus' patch fixes for some reason.
> > 
> > /me curses URL encoding
> > 
> > https://lkml.kernel.org/r/201905040509.iqQ2CrOU%25lkp@intel.com
> > 
> 
> Still fails for me.

Sorry, another URL fail.  It wasn't on lkml.  I should actually try
clicking my own links.

https://lists.01.org/pipermail/kbuild-all/2019-May/060554.html

-- 
Josh
