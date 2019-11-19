Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA710C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970C420718
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKSKbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:31:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:33454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSKbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:31:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33846B19C;
        Tue, 19 Nov 2019 10:31:47 +0000 (UTC)
Message-ID: <1574159504.28617.5.camel@suse.de>
Subject: Re: INFO: task hung in wdm_flush
From:   Oliver Neukum <oneukum@suse.de>
To:     =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, baijiaju1990@gmail.com,
        bigeasy@linutronix.de, colin.king@canonical.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuehaibing@huawei.com
Date:   Tue, 19 Nov 2019 11:31:44 +0100
In-Reply-To: <8736ek9qir.fsf@miraculix.mork.no>
References: <0000000000003313f0058fea8435@google.com>
         <8736ek9qir.fsf@miraculix.mork.no>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 19.11.2019, 10:14 +0100 schrieb Bjørn Mork:
> syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com> writes:
> 
> > INFO: task syz-executor121:1726 blocked for more than 143 seconds.
> >       Not tainted 5.3.0-rc2+ #25
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > syz-executor121 D28520  1726   1724 0x80004006
> > Call Trace:
> >  schedule+0x9a/0x250 kernel/sched/core.c:3944
> >  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
> >  filp_close+0xb4/0x160 fs/open.c:1166
> >  close_files fs/file.c:388 [inline]
> >  put_files_struct fs/file.c:416 [inline]
> >  put_files_struct+0x1d8/0x2e0 fs/file.c:413
> >  exit_files+0x7e/0xa0 fs/file.c:445
> >  do_exit+0x8bc/0x2c50 kernel/exit.c:873
> >  do_group_exit+0x125/0x340 kernel/exit.c:982
> >  get_signal+0x466/0x23d0 kernel/signal.c:2728
> >  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
> >  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
> >  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
> >  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
> >  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x401520
> > Code: 6e 65 54 61 62 6c 65 00 67 65 74 63 6f 6e 00 5f 69 6e 69 74 00
> > 69 73 5f 73 65 6c 69 6e 75 78 5f 65 6e 61 62 6c 65 64 00 73 65 <63> 75
> > 72 69 74 79 5f 67 65 74 65 6e 66 6f 72 63 65 00 67 65 74 5f
> > RSP: 002b:00007ffd59c75df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> > RAX: 0000000000000004 RBX: 0000000000000000 RCX: 0000000000401520
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffd59c75e10
> > RBP: 00000000006cc018 R08: 0000000000000000 R09: 000000000000000f
> > R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000402540
> > R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000
> 
> 
> Thanks to Eric for reminiding me of this one.  I did look briefly at it
> before, and meant to revisit it for a more thorough analysis.  And
> forgot, of corse...
> 
> Anyway, I believe this is not a bug.
> 
> wdm_flush will wait forever for the IN_USE flag to be cleared or the

Damn. Too obvious. So you think we simply have pending output that does
just not complete?

> DISCONNECTING flag to be set. The only way you can avoid this is by
> creating a device that works normally up to a point and then completely
> ignores all messages,

Devices may crash. I don't think we can ignore that case.

>  but without resetting or disconnecting. It is
> obviously possible to create such a device. But I think the current
> error handling is more than sufficient, unless you show me some way to
> abuse this or reproduce the issue with a real device.

Malicious devices are real. Potentially at least.
But you are right, we need not bend over to handle them well, but we
ought to be able to handle them.

	Regards
		Oliver

