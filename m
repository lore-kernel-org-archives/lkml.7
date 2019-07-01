Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8B0C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6DE206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UZI7933+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfGAOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:50:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38352 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGAOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:50:23 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so29445236ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32BiaEJGsuJx0m9YwhU75QHnhvLcQMif5khswsN0yaw=;
        b=UZI7933+UPxzhbXr0ioPXp34wE1gOlkdLNLG/Fo90Hw4P8MxTEwjgqiaotaQOaX1Hc
         6g51NJXorp8+YREaai1YaoqL+qFX5Adl1Iy18tN5w+abrf4KXZP51ScTIDCI6dhwGJJH
         zKHAXYYMSMOkvXWt85jg+swXM3D6agOVSHScsFEPw7yKulhXmpoUtjgnayuIQXBbxMxm
         8X6B9i12ZYLb9kxjYfhyjikDEJ+lwr+vrjgcZenRJiyOKYpCiPxpRUQ+fNV5mpV4GkeG
         e/LZ9fT6VyLsgiDfhIV99K3fJCKhnwtz6i8aD91SDIbgQotQjJ8DwAcjLr4mj+m+Ae47
         J28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32BiaEJGsuJx0m9YwhU75QHnhvLcQMif5khswsN0yaw=;
        b=aYm5INakuOtDgcgPeR6QzcFfVh4nAxIPnXrPzT9OUg1COlPTuzkgzSvZIsHUo+m+ik
         1L9vfPt4x8LwF6jrGR41cQCL8YyUPb8GYdk4EDxndNNT3IxnfpqharAn/qWeNqD0vxuZ
         8yoaqAPzCh4ezm3DAM0YBo7KDLH+4s7YxApLp3tDjSR4eogvHHgjBG1igcD1DiwL7s0J
         o65HwCh/CY4zTRPggKfAvAOPcQB1kK43Y0HxdlBG0rGeACM0nIB0TJCcTgWvibwTp31i
         uwpe7OGyhK2EStsUGwPIukRmRE828de6Kh8pM1dtV5RCm1dj+uKL2nYKyRy5FLvu9r1X
         321Q==
X-Gm-Message-State: APjAAAV867Y2oRuV4gCHFe62VsGm4xseTD6apgf0ss581CpDhmsoRSGN
        bNG23KimdAlOKT2AedzxAnF3mQ==
X-Google-Smtp-Source: APXvYqxiS2P3eieRwds62YvuvWTLfDrc1y4M5yVwgRrK0V0G5G40nntFsnOywoDyuuol3a0JosKnDQ==
X-Received: by 2002:a02:1087:: with SMTP id 129mr30757059jay.131.1561992622191;
        Mon, 01 Jul 2019 07:50:22 -0700 (PDT)
Received: from brauner.io ([208.54.80.252])
        by smtp.gmail.com with ESMTPSA id b6sm9161956iok.71.2019.07.01.07.50.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:50:21 -0700 (PDT)
Date:   Mon, 1 Jul 2019 16:50:12 +0200
From:   Christian Brauner <christian@brauner.io>
To:     syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com,
        viro@zeniv.linux.org.uk, jannh@google.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        gregkh@linuxfoundation.org, guro@fb.com, ktsanaktsidis@zendesk.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com, rppt@linux.vnet.ibm.com,
        scuttimmy@gmail.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willy@infradead.org, yuehaibing@huawei.com
Subject: Re: [PATCH] fork: return proper negative error code
Message-ID: <20190701145011.tzwsndwzj5y5fc6s@brauner.io>
References: <000000000000e0dc0d058c9e7142@google.com>
 <20190701144808.6804-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701144808.6804-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:48:08PM +0200, Christian Brauner wrote:
> Make sure to return a proper negative error code from copy_process()
> when anon_inode_getfile() fails with CLONE_PIDFD.
> Otherwise _do_fork() will not detect an error and get_task_pid() will
> operator on a nonsensical pointer:
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
> R13: 00007ffc15fbb0ff R14: 00007ff07e47e9c0 R15: 0000000000000000
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7990 Comm: syz-executor290 Not tainted 5.2.0-rc6+ #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
> RIP: 0010:get_task_pid+0xe1/0x210 kernel/pid.c:372
> Code: 89 ff e8 62 27 5f 00 49 8b 07 44 89 f1 4c 8d bc c8 90 01 00 00 eb 0c
> e8 0d fe 25 00 49 81 c7 38 05 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74
> 08 4c 89 ff e8 31 27 5f 00 4d 8b 37 e8 f9 47 12 00
> RSP: 0018:ffff88808a4a7d78 EFLAGS: 00010203
> RAX: 00000000000000a7 RBX: dffffc0000000000 RCX: ffff888088180600
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88808a4a7d90 R08: ffffffff814fb3a8 R09: ffffed1015d66bf8
> R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: 0000000000041ffc
> R13: 1ffff11011494fbc R14: 0000000000000000 R15: 000000000000053d
> FS:  00007ff07e47e700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004b5100 CR3: 0000000094df2000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   _do_fork+0x1b9/0x5f0 kernel/fork.c:2360
>   __do_sys_clone kernel/fork.c:2454 [inline]
>   __se_sys_clone kernel/fork.c:2448 [inline]
>   __x64_sys_clone+0xc1/0xd0 kernel/fork.c:2448
>   do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Link: https://lore.kernel.org/lkml/000000000000e0dc0d058c9e7142@google.com
> Reported-and-tested-by: syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com
> Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
> Cc: Jann Horn <jannh@google.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner <christian@brauner.io>

syzkaller has verified that this fixes the bug. The patch is sitting in
my fixes branch. I'm sending a PR for this in a little bit to get this
out of the way.

Thanks!
Christian
