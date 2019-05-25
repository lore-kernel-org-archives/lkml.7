Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADC7C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0201B21880
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfEYAOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:14:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49737 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfEYAOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:14:39 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4P0EN5p000988;
        Sat, 25 May 2019 09:14:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Sat, 25 May 2019 09:14:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4P0EDOW000831
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 25 May 2019 09:14:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joe Perches <joe@perches.com>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <df46bdfa-d149-4823-d6b8-e350275cd8f0@i-love.sakura.ne.jp>
Date:   Sat, 25 May 2019 09:14:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi35ezFsFuHHJ-MbrUAUj0ohQJM4iHHw8n1vyqXMYbVcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/25 2:17, Linus Torvalds wrote:
> A config option or two that help syzbot doesn't sound like a bad idea to me.

Thanks for suggestion. I think that #ifdef'ing

  static bool suppress_message_printing(int level)
  {
  	return (level >= console_loglevel && !ignore_loglevel);
  }

is simpler. If the cause of unexpected change of console loglevel
turns out to be syz_execute_func(), we will want a config option
which controls suppress_message_printing() for syzbot. That option
would also be used for guarding printk("WARNING:" ...) users.

Well, syzbot does not want to use ignore_loglevel kernel command
line option because that option would generate too much output...

  https://lkml.kernel.org/r/CACT4Y+ay7nuT-7y2JARozV1s0VisuLdN6VT+w9OsEDs1PeBRoA@mail.gmail.com



On 2019/05/25 2:55, Linus Torvalds wrote:
> On Fri, May 24, 2019 at 10:41 AM Joe Perches <joe@perches.com> wrote:
> >
> > That could also help eliminate unnecessary pr_<foo> output
> > from object code.
> 
> Indeed. The small-config people might like it (if they haven't already
> given up..)

Do you mean doing e.g.

  #define pr_debug(fmt, ...) no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)

depending on the minimal console loglevel kernel config option? Then, OK.
But callers using e.g. printk(KERN_DEBUG ...) and printk(KERN_SOH "%u" ...)
will remain unfiltered...

