Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E865C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488832339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfHVJ7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:59:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64853 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHVJ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:59:39 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7M9xQtM011138;
        Thu, 22 Aug 2019 18:59:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Thu, 22 Aug 2019 18:59:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7M9xPOa011134;
        Thu, 22 Aug 2019 18:59:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x7M9xP8r011133;
        Thu, 22 Aug 2019 18:59:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
MIME-Version: 1.0
Date:   Thu, 22 Aug 2019 18:59:25 +0900
References: <20190820222403.GB8120@kroah.com> 
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa wrote:
> Greg Kroah-Hartman wrote:
> > Oh, nice!  This shouldn't break anything that is assuming that the read
> > will complete before a signal is delivered, right?
> >
> > I know userspace handling of "short" reads is almost always not there...
> 
> Since this check will give up upon SIGKILL, userspace won't be able to see
> the return value from read(). Thus, returning 0 upon SIGKILL will be safe. ;-)
> Maybe we also want to add cond_resched()...
> 
> By the way, do we want similar check on write_mem() side?
> If aborting "write to /dev/mem" upon SIGKILL (results in partial write) is
> unexpected, we might want to ignore SIGKILL for write_mem() case.
> But copying data from killed threads (especially when killed by OOM killer
> and userspace memory is reclaimed by OOM reaper before write_mem() returns)
> would be after all unexpected. Then, it might be preferable to check SIGKILL
> on write_mem() side...
> 

Ha, ha. syzbot reported the same problem using write_mem().
https://syzkaller.appspot.com/text?tag=CrashLog&x=1018055a600000
We want fatal_signal_pending() check on both sides.

By the way, write_mem() worries me whether there is possibility of replacing
kernel code/data with user-defined memory data supplied from userspace.
If write_mem() were by chance replaced with code that does

   while (1);

we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
Ditto for replacing local variables with unexpected values...
