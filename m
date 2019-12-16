Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C2A21775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLPUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:19:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45668 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727016AbfLPUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:19:20 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBGKIYFr018829
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 15:18:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BD9E2420821; Mon, 16 Dec 2019 15:18:34 -0500 (EST)
Date:   Mon, 16 Dec 2019 15:18:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191216201834.GA785904@mit.edu>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20191216114636.GB1515069@kroah.com>
 <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce36371b-0ca6-5819-2604-65627ce58fc8@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:35:00AM +0900, Tetsuo Handa wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 1ef6f75d92f1..9a2f95a78fef 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1198,6 +1198,14 @@ MODULE_PARM_DESC(ignore_loglevel,
> >>  
> >>  static bool suppress_message_printing(int level)
> >>  {
> >> +#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
> >> +	/*
> >> +	 * Changing console_loglevel causes "no output". But ignoring
> >> +	 * console_loglevel is easier than preventing change of
> >> +	 * console_loglevel.
> >> +	 */
> >> +	return (level >= CONSOLE_LOGLEVEL_DEFAULT && !ignore_loglevel);
> >> +#endif
> > 
> > I don't understand the need for this change at all.
> 
> this case was too hard to blacklist, as explained at
> https://lore.kernel.org/lkml/4d1a4b51-999b-63c6-5ce3-a704013cecb6@i-love.sakura.ne.jp/ .
> syz_execute_func() can find deeper bug by executing arbitrary binary code, but
> we cannot blacklist specific syscalls/arguments for syz_execute_func() testcases.
> Unless we guard on the kernel side, we won't be able to re-enable syz_execute_func()
> testcases.

I looked at the reference, but I didn't see the explanation in the
above link about why it was "too hard to blacklist".  In fact, it
looks like a bit earlier in the thread, Dmitry stated that adding this
find of blacklist "is not hard"?

https://lore.kernel.org/lkml/CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com/

I suspect that adding whack-a-mole in the kernel is going to be just
as hard/annoying as adding it in Syzkaller....  The question is under
which rug are we proposing to hide the dirt?   :-)

      	      	 	      	       - Ted
