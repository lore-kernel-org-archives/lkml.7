Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2CC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B5E20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfCCNzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:55:17 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33676 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:55:17 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h0Ra2-0000rx-Ro; Sun, 03 Mar 2019 13:55:02 +0000
Date:   Sun, 3 Mar 2019 13:55:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+503d4cc169fcec1cb18c@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, jbaron@akamai.com, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, hch@lst.de
Subject: Re: KASAN: use-after-free Read in unix_dgram_poll
Message-ID: <20190303135502.GP2217@ZenIV.linux.org.uk>
References: <000000000000f39c7b05832e0219@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f39c7b05832e0219@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 02:22:04AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7d762d69145a afs: Fix manually set volume location server ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=131d832ac00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b76ec970784287c
> dashboard link: https://syzkaller.appspot.com/bug?extid=503d4cc169fcec1cb18c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11934262c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+503d4cc169fcec1cb18c@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in unix_dgram_poll+0x5e1/0x690
> net/unix/af_unix.c:2695
> Read of size 4 at addr ffff88809292aae0 by task syz-executor.1/18946
> 
> CPU: 0 PID: 18946 Comm: syz-executor.1 Not tainted 5.0.0-rc8+ #88
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
>  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
>  unix_dgram_poll+0x5e1/0x690 net/unix/af_unix.c:2695
>  sock_poll+0x291/0x340 net/socket.c:1127
>  vfs_poll include/linux/poll.h:86 [inline]
>  aio_poll fs/aio.c:1766 [inline]
>  __io_submit_one fs/aio.c:1876 [inline]
>  io_submit_one+0xe3e/0x1cf0 fs/aio.c:1909
>  __do_sys_io_submit fs/aio.c:1954 [inline]
>  __se_sys_io_submit fs/aio.c:1924 [inline]
>  __x64_sys_io_submit+0x1bd/0x580 fs/aio.c:1924
>  ? 0xffffffff81000000
>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Apparently, a call of ->poll() overlapping with call of ->release()
(if not outright happening after it).  Which should never happen...

Maybe unrelated to this bug, but...  What's to prevent a wakeup
that happens just after we'd been added to a waitqueue by ->poll()
triggering aio_poll_wake(), which gets to aio_poll_complete()
with its fput() *before* we'd reached the end of ->poll() instance?

I wonder if adding
	get_file(req->file);  // make sure that early completion is safe
right after
        req->file = fget(iocb->aio_fildes);
        if (unlikely(!req->file))
                return -EBADF;
paired with
	fput(req->file);
right after out: in aio_poll() is needed...  Am I missing something
obvious here?  Christoph?
