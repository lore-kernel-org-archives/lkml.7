Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83281C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5250B2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfKGJSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:18:41 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:14587 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfKGJSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:18:40 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xA79H4gv015592;
        Thu, 7 Nov 2019 10:17:04 +0100
Date:   Thu, 7 Nov 2019 10:17:04 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
Message-ID: <20191107091704.GA15536@1wt.eu>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.241007755@linutronix.de>
 <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com>
 <20191107082541.GF30739@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107082541.GF30739@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 09:25:41AM +0100, Ingo Molnar wrote:
> I.e. the model I'm suggesting is that if a task uses ioperm() or iopl() 
> then it should have a bitmap from that point on until exit(), even if 
> it's all zeroes or all ones. Most applications that are using those 
> primitives really need it all the time and are using just a few ioports, 
> so all the tracking doesn't help much anyway.

I'd go even further, considering that any task having called ioperm()
or iopl() once is granted access to all 64k ports for life: if the task
was granted access to any port, it will be able to request access for any
other port anyway. And we cannot claim that finely filtering accesses
brings any particular reliability in my opinion, considering that it's
generally possible to make the system really sick by starting to play
with most I/O ports. So for me that becomes a matter of trusted vs not
trusted task. Then we can simply have two pages of 0xFF to describe
their I/O access bitmap.

> On a related note, another simplification would be that in principle we 
> could also use just a single bitmap and emulate iopl() as an ioperm(all) 
> or ioperm(none) calls. Yeah, it's not fully ABI compatible for mixed 
> ioperm()/iopl() uses, but is that ABI actually being relied on in 
> practice?

You mean you'd have a unified map for all tasks ? In this case I think
it's simpler and equivalent to simply ignore the values in the calls
and grant full perms to the 64k ports range after the calls were
validated. I could be totally wrong and missing something obvious
though.

Regards,
Willy
