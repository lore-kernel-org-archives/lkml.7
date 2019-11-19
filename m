Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D312DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F44D222D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Z2V4IzLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKSJPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:15:01 -0500
Received: from canardo.mork.no ([148.122.252.1]:40709 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSJPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:15:00 -0500
Received: from miraculix.mork.no ([IPv6:2a02:2121:282:91e0:68e2:39ff:fe1c:1a78])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xAJ9EfqN031998
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Nov 2019 10:14:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1574154883; bh=W/iD+37O0a6xKjmvtovzeY97MvBcoGXb9njQd/Owbs4=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Z2V4IzLA92Y6M8B2eWRooxypSlve13zy+VLMjn1zeZhFI3iVy0CtefpOr/8AbyJ/9
         4VDkpSLM+cyzpK3y42GpA/pq9/rU9wnfPl13XHlNEA9xvu2qVd0ZCyYEPbsf4gd9BW
         7KsgaJs/14hgMOsLbgqf8wK0gDheiYl47IiOGVu8=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iWzam-00075R-JB; Tue, 19 Nov 2019 10:14:36 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, baijiaju1990@gmail.com,
        bigeasy@linutronix.de, colin.king@canonical.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuehaibing@huawei.com
Subject: Re: INFO: task hung in wdm_flush
Organization: m
References: <0000000000003313f0058fea8435@google.com>
Date:   Tue, 19 Nov 2019 10:14:36 +0100
In-Reply-To: <0000000000003313f0058fea8435@google.com> (syzbot's message of
        "Mon, 12 Aug 2019 05:18:06 -0700")
Message-ID: <8736ek9qir.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com> writes:

> INFO: task syz-executor121:1726 blocked for more than 143 seconds.
>       Not tainted 5.3.0-rc2+ #25
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-executor121 D28520  1726   1724 0x80004006
> Call Trace:
>  schedule+0x9a/0x250 kernel/sched/core.c:3944
>  wdm_flush+0x20c/0x370 drivers/usb/class/cdc-wdm.c:590
>  filp_close+0xb4/0x160 fs/open.c:1166
>  close_files fs/file.c:388 [inline]
>  put_files_struct fs/file.c:416 [inline]
>  put_files_struct+0x1d8/0x2e0 fs/file.c:413
>  exit_files+0x7e/0xa0 fs/file.c:445
>  do_exit+0x8bc/0x2c50 kernel/exit.c:873
>  do_group_exit+0x125/0x340 kernel/exit.c:982
>  get_signal+0x466/0x23d0 kernel/signal.c:2728
>  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
>  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
>  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
>  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x401520
> Code: 6e 65 54 61 62 6c 65 00 67 65 74 63 6f 6e 00 5f 69 6e 69 74 00
> 69 73 5f 73 65 6c 69 6e 75 78 5f 65 6e 61 62 6c 65 64 00 73 65 <63> 75
> 72 69 74 79 5f 67 65 74 65 6e 66 6f 72 63 65 00 67 65 74 5f
> RSP: 002b:00007ffd59c75df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: 0000000000000004 RBX: 0000000000000000 RCX: 0000000000401520
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 00007ffd59c75e10
> RBP: 00000000006cc018 R08: 0000000000000000 R09: 000000000000000f
> R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000402540
> R13: 00000000004025d0 R14: 0000000000000000 R15: 0000000000000000


Thanks to Eric for reminiding me of this one.  I did look briefly at it
before, and meant to revisit it for a more thorough analysis.  And
forgot, of corse...

Anyway, I believe this is not a bug.

wdm_flush will wait forever for the IN_USE flag to be cleared or the
DISCONNECTING flag to be set. The only way you can avoid this is by
creating a device that works normally up to a point and then completely
ignores all messages, but without resetting or disconnecting. It is
obviously possible to create such a device. But I think the current
error handling is more than sufficient, unless you show me some way to
abuse this or reproduce the issue with a real device.

Just disconnect the malfunctioning device and throw it away.


Bj=C3=B8rn
