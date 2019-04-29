Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA35C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C8020675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfD2Oj3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfD2Oj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:39:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744E520656;
        Mon, 29 Apr 2019 14:39:27 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:39:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
Message-ID: <20190429103925.6233e45f@gandalf.local.home>
In-Reply-To: <20190429143037.3qu5fzdo6g26rsmf@pathway.suse.cz>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
        <20190426130204.23a5a05c@gandalf.local.home>
        <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
        <20190429091320.019e726b@gandalf.local.home>
        <20190429143037.3qu5fzdo6g26rsmf@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added Joe ]

On Mon, 29 Apr 2019 16:30:37 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2019-04-29 09:13:20, Steven Rostedt wrote:
> > On Mon, 29 Apr 2019 13:08:01 +0200
> > Petr Mladek <pmladek@suse.com> wrote:
> >   
> > > > Looks like commit "vsprintf: Do not check address of well-known
> > > > strings" removed the: "static noinline_for_stack"
> > > > 
> > > > Does pointer_string() need that still?    
> > > 
> > > Heh, it was removed by mistake and well hidden in the diff.
> > > 
> > > I have pushed Yue's fix into printk.git, branch
> > > for-5.2-vsprintf-hardening
> > > 
> > > Thanks for the patch.  
> > 
> > But doesn't it still need the "noinline_for_stack", that doesn't look
> > like it changed.  
> 
> Good question. I have just double checked it. And pointer_string() with
> "noinline_for_stack" does not make any difference in the stack
> usage here.
> 
> 
> I actually played with this before:
> 
> "noinline_for_stack" is a black magic added by
> the commit cf3b429b03e827c7180 ("vsprintf.c: use noinline_for_stack").

From what I understand, "noinline_for_stack" is just noinline and the
"for_stack" part is just to document that the noinline is used for
stack purposes. If the compiler doesn't inline the function without the
noinline, then it wont make any difference.

The point was to not inline the function because it can be used in
stack critical areas, and that it's better to do the call than to
increase the stack.

Although the commit you posted is back in 2010, and compilers and I
think even our stack size has changed since then. This may not be a
critical issue today, and just making it static and letting the
compiler decide might be the right solution.

Let's add Yue's patch as is for now, and perhaps revisit this as a
separate thread.

-- Steve

> 
> It is evidently useful in some cases. But I somehow doubt
> that it really makes things better when used everywhere.
> Therefore I have got a bit relaxed and omitted it in most
> newly added functions that did not affect the results.
> 
> They are the same before and after the patchset:
> 
> pmladek@pathway:/prace/kernel/linux-printk> objdump -d lib/vsprintf.o | perl scripts/checkstack.pl
> 0x00000e12 symbol_string [vsprintf.o]:                  248
> 0x00000e6d symbol_string [vsprintf.o]:                  248
> 0x000012fb ip6_addr_string_sa [vsprintf.o]:             112
> 0x00001415 ip6_addr_string_sa [vsprintf.o]:             112
> 0x000028c6 resource_string.isra.9 [vsprintf.o]:         104
> 0x00002964 resource_string.isra.9 [vsprintf.o]:         104
> 
> 
> Would you like to fix this clearly, for example, rebase and
> put both "static noinline_for_stack" back or add yet
> another commit or?
> 
> IMHO, it is not too important. Anyway, I am open for any
> advice. I do not want to create more mess.
> 
> Best Regards,
> Petr

