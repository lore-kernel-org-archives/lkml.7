Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236BAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EF221773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391362AbfEXRlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:41:02 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:47426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbfEXRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:41:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8BD81181D3377;
        Fri, 24 May 2019 17:41:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven15_5ff195265d71a
X-Filterd-Recvd-Size: 2257
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 May 2019 17:40:59 +0000 (UTC)
Message-ID: <bc58c62d67f60678c980539fb3259683ea8bd21d.camel@perches.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 24 May 2019 10:40:56 -0700
In-Reply-To: <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
         <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 10:17 -0700, Linus Torvalds wrote:
> > This patch is intended for testing on linux-next.git only, and
> > will be removed after we found what is wrong.
> 
> Honestly, wouldn't it be much better to try to come up with a patch
> that might be acceptable in general.
> 
> For example, how about a config option that just hardcodes
> console_loglevel as a compile-time constant, and where you can't
> change it at all? There are not that many paths that set the console
> log-level, and the few that do could be made to use
> 
>     set_console_log_level(x);
> 
> instead of
> 
>     console_loglevel = x;
> 
> like they do.
> 
> We already have a number of loglevel config options, adding another
> that says "fix log levels at compile time" doesn't sound too bad, and
> I suspect a patch that introduces that set_console_log_level() kind of
> model and just makes "console_loglevel" a constant #define wouldn't be
> too ugly.
> 
> A config option or two that help syzbot doesn't sound like a bad idea to me.
> 
> Hmm?

That could also help eliminate unnecessary pr_<foo> output
from object code.



