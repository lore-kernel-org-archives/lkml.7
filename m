Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E61C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AC520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfDHQgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDHQge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 880B7859FB;
        Mon,  8 Apr 2019 16:36:34 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E65591A7D1;
        Mon,  8 Apr 2019 16:36:33 +0000 (UTC)
Date:   Mon, 8 Apr 2019 11:36:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard pages
Message-ID: <20190408163632.zssld3xhrcekfi77@treble>
References: <20190405150658.237064784@linutronix.de>
 <20190405150930.967389183@linutronix.de>
 <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com>
 <alpine.DEB.2.21.1904080043390.1840@nanos.tec.linutronix.de>
 <CALCETrXyfEu5MHCDp+OiRdHcYQ1tMNhTMSxcAhWkOx_8r2rxsA@mail.gmail.com>
 <alpine.DEB.2.21.1904080839480.1840@nanos.tec.linutronix.de>
 <CALCETrX_Pyo-H8H2feZz1+hiz_E99ZqVBqb+xvZfZ+gvFGL5gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrX_Pyo-H8H2feZz1+hiz_E99ZqVBqb+xvZfZ+gvFGL5gw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Apr 2019 16:36:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 09:18:00AM -0700, Andy Lutomirski wrote:
> On Sun, Apr 7, 2019 at 11:46 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sun, 7 Apr 2019, Andy Lutomirski wrote:
> > > On Sun, Apr 7, 2019 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > Actually we have: save_stack_trace()
> > > >
> > >
> > > Like I did here:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=WIP.x86/stackguards
> >
> > Kinda, but what that code wants is to skip any entry before 'caller'. So we
> > either add something like save_stack_trace_from() which is trivial on x86
> > because unwind_start() already has an argument to hand in the start of
> > stack or we filter out the entries up to 'caller' in that code.
> >
> >
> 
> Whoops!
> 
> I could add a save_stack_trace_from() or I could add a "caller"
> argument to struct stack_trace.  Any preference as to which looks
> better?  The latter seems a little nicer to me.

The current official way to do that is to use the stack_trace "skip"
field.  That's a hack though because it relies on inlining decisions.

It would be nicer if the skip interface were pointer-based like your
suggestion.

-- 
Josh
