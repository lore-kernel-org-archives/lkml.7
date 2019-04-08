Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2F520880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDHQpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:45:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53414 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:45:02 -0400
Received: from p5492ee6e.dip0.t-ipconnect.de ([84.146.238.110] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hDXOB-0002vn-Eu; Mon, 08 Apr 2019 18:44:55 +0200
Date:   Mon, 8 Apr 2019 18:44:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 28/29] x86/irq/64: Remap the IRQ stack with guard
 pages
In-Reply-To: <CALCETrX_Pyo-H8H2feZz1+hiz_E99ZqVBqb+xvZfZ+gvFGL5gw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904081841400.2352@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150930.967389183@linutronix.de> <CALCETrWF_YgQODJ=Rpm2MnhFxJXCfoo4H792hUQni0GS9on7og@mail.gmail.com> <alpine.DEB.2.21.1904080043390.1840@nanos.tec.linutronix.de>
 <CALCETrXyfEu5MHCDp+OiRdHcYQ1tMNhTMSxcAhWkOx_8r2rxsA@mail.gmail.com> <alpine.DEB.2.21.1904080839480.1840@nanos.tec.linutronix.de> <CALCETrX_Pyo-H8H2feZz1+hiz_E99ZqVBqb+xvZfZ+gvFGL5gw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Andy Lutomirski wrote:
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
> Whoops!
> 
> I could add a save_stack_trace_from() or I could add a "caller"
> argument to struct stack_trace.  Any preference as to which looks
> better?  The latter seems a little nicer to me.

The whole interface with struct stack_trace sucks. Why is skip and max
entries in that struct and not an argument? I went through all the call
sites and it just makes me shudder. That terminate trace with ULONG_MAX is
another horrible hack which is then undone on several callsites
again. Before we add more hacky stuff to it, lets cleanup that whole mess
first.

Thanks,

	tglx



