Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70C6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD122075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfD2Qmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:42:36 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:41947 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728520AbfD2Qmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:42:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0722318224D9E;
        Mon, 29 Apr 2019 16:42:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: card60_1622dbbbc1d5d
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350 (unknown [213.83.164.10])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Apr 2019 16:42:31 +0000 (UTC)
Message-ID: <3078981761ff2a37354221eb79a1c24e43c30896.camel@perches.com>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 29 Apr 2019 09:42:30 -0700
In-Reply-To: <20190429103925.6233e45f@gandalf.local.home>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
         <20190426130204.23a5a05c@gandalf.local.home>
         <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
         <20190429091320.019e726b@gandalf.local.home>
         <20190429143037.3qu5fzdo6g26rsmf@pathway.suse.cz>
         <20190429103925.6233e45f@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-29 at 10:39 -0400, Steven Rostedt wrote:
> [ added Joe ]
> > Good question. I have just double checked it. And pointer_string() with
> > "noinline_for_stack" does not make any difference in the stack
> > usage here.
> > 
> > I actually played with this before:
> > 
> > "noinline_for_stack" is a black magic added by
> > the commit cf3b429b03e827c7180 ("vsprintf.c: use noinline_for_stack").
> 
> From what I understand, "noinline_for_stack" is just noinline and the
> "for_stack" part is just to document that the noinline is used for
> stack purposes. If the compiler doesn't inline the function without the
> noinline, then it wont make any difference.
> 
> The point was to not inline the function because it can be used in
> stack critical areas, and that it's better to do the call than to
> increase the stack.

It was added because of %pV is recursive and recursive
functions can eat
a lot of stack.

Using noinline_for_stack was just a bit more self-documenting.

I do still think it's a useful notation.

