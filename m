Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE9C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D4F2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbfKGKAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:00:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47027 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbfKGKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:00:34 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSeaa-0002nO-I8; Thu, 07 Nov 2019 11:00:28 +0100
Date:   Thu, 7 Nov 2019 11:00:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Willy Tarreau <w@1wt.eu>
cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
In-Reply-To: <20191107091704.GA15536@1wt.eu>
Message-ID: <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com> <20191107082541.GF30739@gmail.com> <20191107091704.GA15536@1wt.eu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Willy Tarreau wrote:
> On Thu, Nov 07, 2019 at 09:25:41AM +0100, Ingo Molnar wrote:
> > I.e. the model I'm suggesting is that if a task uses ioperm() or iopl() 
> > then it should have a bitmap from that point on until exit(), even if 
> > it's all zeroes or all ones. Most applications that are using those 
> > primitives really need it all the time and are using just a few ioports, 
> > so all the tracking doesn't help much anyway.
> 
> I'd go even further, considering that any task having called ioperm()
> or iopl() once is granted access to all 64k ports for life: if the task
> was granted access to any port, it will be able to request access for any
> other port anyway. And we cannot claim that finely filtering accesses
> brings any particular reliability in my opinion, considering that it's
> generally possible to make the system really sick by starting to play
> with most I/O ports. So for me that becomes a matter of trusted vs not
> trusted task. Then we can simply have two pages of 0xFF to describe
> their I/O access bitmap.
> 
> > On a related note, another simplification would be that in principle we 
> > could also use just a single bitmap and emulate iopl() as an ioperm(all) 
> > or ioperm(none) calls. Yeah, it's not fully ABI compatible for mixed 
> > ioperm()/iopl() uses, but is that ABI actually being relied on in 
> > practice?
> 
> You mean you'd have a unified map for all tasks ? In this case I think
> it's simpler and equivalent to simply ignore the values in the calls
> and grant full perms to the 64k ports range after the calls were
> validated. I could be totally wrong and missing something obvious
> though.

Changing ioperm(single port, port range) to be ioperm(all) is going to
break a bunch of test cases which actually check whether the permission is
restricted to a single I/O port or the requested port range.

Thanks,

	tglx
