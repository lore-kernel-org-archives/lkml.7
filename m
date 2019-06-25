Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CFDC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7520883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfFYJxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:53:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56737 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbfFYJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:53:47 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5P9qhph083468;
        Tue, 25 Jun 2019 18:52:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Tue, 25 Jun 2019 18:52:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5P9qcbs083454
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 25 Jun 2019 18:52:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: possible deadlock in console_trylock_spinning
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
References: <0000000000007b0e26058c2215d3@google.com>
Cc:     syzbot <syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8999365f-9de0-c850-087e-be9a7eb04547@i-love.sakura.ne.jp>
Date:   Tue, 25 Jun 2019 18:52:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0000000000007b0e26058c2215d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/25 17:55, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit e80b18599a39a625bc8b2e39ba3004a62f78805a
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Fri Apr 12 11:04:54 2019 +0000
> 
>     tomoyo: Add a kernel config option for fuzzing testing.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=156e43cea00000
> start commit:   abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=176e43cea00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=136e43cea00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
> dashboard link: https://syzkaller.appspot.com/bug?extid=fc1da0f1a577d15b64fc
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1357add6a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1611ac89a00000
> 
> Reported-by: syzbot+fc1da0f1a577d15b64fc@syzkaller.appspotmail.com
> Fixes: e80b18599a39 ("tomoyo: Add a kernel config option for fuzzing testing.")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

This is not a TOMOYO's problem because that commit simply confused inject_fault(4)
by adding memory allocation from TOMOYO's hook. Anyway, this bug should be sent to
printk() people.

