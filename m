Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F09C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC402080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfD3Img (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:42:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfD3Img (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:42:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97F30ABC3;
        Tue, 30 Apr 2019 08:42:34 +0000 (UTC)
Date:   Tue, 30 Apr 2019 10:42:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Yue Haibing <yuehaibing@huawei.com>,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        geert+renesas@glider.be, me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
Message-ID: <20190430084231.y5fm5zvjdcwyzt7t@pathway.suse.cz>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
 <20190426130204.23a5a05c@gandalf.local.home>
 <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
 <20190429091320.019e726b@gandalf.local.home>
 <20190429143037.3qu5fzdo6g26rsmf@pathway.suse.cz>
 <20190429103925.6233e45f@gandalf.local.home>
 <3078981761ff2a37354221eb79a1c24e43c30896.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3078981761ff2a37354221eb79a1c24e43c30896.camel@perches.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-04-29 09:42:30, Joe Perches wrote:
> On Mon, 2019-04-29 at 10:39 -0400, Steven Rostedt wrote:
> > [ added Joe ]
> > > Good question. I have just double checked it. And pointer_string() with
> > > "noinline_for_stack" does not make any difference in the stack
> > > usage here.
> > > 
> > > I actually played with this before:
> > > 
> > > "noinline_for_stack" is a black magic added by
> > > the commit cf3b429b03e827c7180 ("vsprintf.c: use noinline_for_stack").
> > 
> > From what I understand, "noinline_for_stack" is just noinline and the
> > "for_stack" part is just to document that the noinline is used for
> > stack purposes. If the compiler doesn't inline the function without the
> > noinline, then it wont make any difference.
> > 
> > The point was to not inline the function because it can be used in
> > stack critical areas, and that it's better to do the call than to
> > increase the stack.
> 
> It was added because of %pV is recursive and recursive
> functions can eat
> a lot of stack.
> 
> Using noinline_for_stack was just a bit more self-documenting.
> 
> I do still think it's a useful notation.

I understand the problem and noinline_for_stack improved some
paths definitely.

On the other hand, the call instruction uses the stack as well.
Note that many of the annotated functions have 5 parameters.

I believe that some of the annotated functions might get inlined
with a lower stack usage in the caller than what is needed
by the call.

The problem is that it depends on the used compiler, optimization,
and architecture. I personally do not want to invest much time
into optimizing this unless people report real life problems.

Best Regards,
Petr
