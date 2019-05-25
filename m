Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF8CC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E1720863
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEYA4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:56:36 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:32786 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbfEYA4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:56:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 468474430;
        Sat, 25 May 2019 00:56:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: need28_735f329e4561a
X-Filterd-Recvd-Size: 2467
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 May 2019 00:56:32 +0000 (UTC)
Message-ID: <6b56ca73a5686513fc4ce9d3e07e402cfeeac544.camel@perches.com>
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 24 May 2019 17:56:31 -0700
In-Reply-To: <df46bdfa-d149-4823-d6b8-e350275cd8f0@i-love.sakura.ne.jp>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
         <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
         <df46bdfa-d149-4823-d6b8-e350275cd8f0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-25 at 09:14 +0900, Tetsuo Handa wrote:
> On 2019/05/25 2:17, Linus Torvalds wrote:
> > A config option or two that help syzbot doesn't sound like a bad idea to me.
> 
> Thanks for suggestion. I think that #ifdef'ing
> 
>   static bool suppress_message_printing(int level)
>   {
>   	return (level >= console_loglevel && !ignore_loglevel);
>   }
> 
> is simpler.
[]
> On 2019/05/25 2:55, Linus Torvalds wrote:
> > On Fri, May 24, 2019 at 10:41 AM Joe Perches <joe@perches.com> wrote:
> > > That could also help eliminate unnecessary pr_<foo> output
> > > from object code.
> > 
> > Indeed. The small-config people might like it (if they haven't already
> > given up..)
> 
> Do you mean doing e.g.
> 
>   #define pr_debug(fmt, ...) no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> 
> depending on the minimal console loglevel kernel config option? Then, OK.

Yes.

Perhaps something like the below (or an equivalent generic wrapper)

#define pr_info(fmt, ...) \
do { \
	if (CONFIG_STATIC_CONSOLE_LEVEL >= LOGLEVEL_INFO) \
		printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__); \
	else \
		no_printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__); \
} while (0)

for each pr_<level>, dev_<level> and netdev_<level>


