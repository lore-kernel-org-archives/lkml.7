Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42EC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DF82067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgrs6iYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgAIIu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:50:26 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44711 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAIIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:50:25 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so2616443qvg.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wloqhRoEICQ+k5+VnPqK5Heg13aiPvech9Fyx9hUKYs=;
        b=sgrs6iYbSodbyCgULyUl+1/bfBjdKlzd2fMgFQnFg4u0F7Lkrl9+F4ge6qZUQ1RAs1
         r1nLB8snyzT1IW2FxgJ6uFpDVwUONTq9R4zLvF8pQNUXLnXBqtkBHRCf7YQHWgXMKY8+
         Zeb8Wc7XYHCmN5mowNHDSiJpMHYqpcbBWkSyPAIl3gg3aORjkTLLqHrS9x685/ZtF8BT
         31NsNBSAfyO0F2jXViW1QWdFqrAO6DpEmqtVIkeowmoRjPbaudexYgyCuiOQnTHbiZWd
         DbV48PhWZtxqO9Vlxe5448IW9oestTVypzZO6ew24weG7axDkB6LTRBcaES2CAfkSWD1
         ihpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wloqhRoEICQ+k5+VnPqK5Heg13aiPvech9Fyx9hUKYs=;
        b=rTv2RuFLaZyejmIcGfMzHwIf1Y/ziCfXzQPOp2PZqFBDHHOgyevIca7mIEDjz1AdKx
         ua6OG198v3qVFmgVKxKjBlSkUZANhq+uFdT6eWdRypsKmauc7zhj42aubYvhE1M4nk3E
         U8VLkOJsyr51b1EtCSf0Ckn2AK5geKgKhcxb66R63DqyLRa81I8vlZRy1AmYppfREOnE
         MrJ0UGeAwbY6XWTECh6m2NZ1k17s3BGMbjCNuX8KcRadPzxkr1iCAbMNlmF8V8A696t5
         8lG/pZ0nbpzYlnaRZg0fl15p1WOfzdcnxRKHQKQeDWa0QnWRyQq/K6yt5Q8NXpUv+Jjg
         P3dA==
X-Gm-Message-State: APjAAAXHShz94xc6WUNhJ3nQWrU8ZxNCf3EzWKOJ4RrOiFU4xEqQRmAf
        1eIop2pszo21pBIU1wsHgxQYFuu7vt/W5ojqXOUH5g==
X-Google-Smtp-Source: APXvYqxlaasH3wah/44boniAGnInXKdsP+A6/JY1Fc4PKVzY32l8BPLX4SHihM5+35Fk0GI5xBBg4bqUEmgyz7gZcbs=
X-Received: by 2002:ad4:4810:: with SMTP id g16mr7563219qvy.22.1578559824505;
 Thu, 09 Jan 2020 00:50:24 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com> <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
In-Reply-To: <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jan 2020 09:50:12 +0100
Message-ID: <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexander Potapenko <glider@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 9:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 8, 2020 at 6:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
> > > On 2020/01/08 15:20, Dmitry Vyukov wrote:
> > >> I temporarily re-enabled smack instance and it produced another 50
> > >> stalls all over the kernel, and now keeps spewing a dozen every hour.
> >
> > Do I have to be using clang to test this? I'm setting up to work on this,
> > and don't want to waste time using my current tool chain if the problem
> > is clang specific.
>
> Humm, interesting. Initially I was going to say that most likely it's
> not clang-related. Bug smack instance is actually the only one that
> uses clang as well (except for KMSAN of course). So maybe it's indeed
> clang-related rather than smack-related. Let me try to build a kernel
> with clang.

+clang-built-linux, glider

[clang-built linux is severe broken since early Dec]

Building kernel with clang I can immediately reproduce this locally:

$ syz-manager
2020/01/09 09:27:15 loading corpus...
2020/01/09 09:27:17 serving http on http://0.0.0.0:50001
2020/01/09 09:27:17 serving rpc on tcp://[::]:45851
2020/01/09 09:27:17 booting test machines...
2020/01/09 09:27:17 wait for the connection from test machine...
2020/01/09 09:29:23 machine check:
2020/01/09 09:29:23 syscalls                : 2961/3195
2020/01/09 09:29:23 code coverage           : enabled
2020/01/09 09:29:23 comparison tracing      : enabled
2020/01/09 09:29:23 extra coverage          : enabled
2020/01/09 09:29:23 setuid sandbox          : enabled
2020/01/09 09:29:23 namespace sandbox       : enabled
2020/01/09 09:29:23 Android sandbox         : /sys/fs/selinux/policy
does not exist
2020/01/09 09:29:23 fault injection         : enabled
2020/01/09 09:29:23 leak checking           : CONFIG_DEBUG_KMEMLEAK is
not enabled
2020/01/09 09:29:23 net packet injection    : enabled
2020/01/09 09:29:23 net device setup        : enabled
2020/01/09 09:29:23 concurrency sanitizer   : /sys/kernel/debug/kcsan
does not exist
2020/01/09 09:29:23 devlink PCI setup       : PCI device 0000:00:10.0
is not available
2020/01/09 09:29:27 corpus                  : 50226 (0 deleted)
2020/01/09 09:29:27 VMs 20, executed 0, cover 0, crashes 0, repro 0
2020/01/09 09:29:37 VMs 20, executed 45, cover 0, crashes 0, repro 0
2020/01/09 09:29:47 VMs 20, executed 74, cover 0, crashes 0, repro 0
2020/01/09 09:29:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:30:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:30:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:30:27 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:30:37 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:30:47 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:30:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:31:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:31:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:31:26 vm-10: crash: INFO: rcu detected stall in do_idle
2020/01/09 09:31:27 VMs 13, executed 80, cover 0, crashes 0, repro 0
2020/01/09 09:31:28 vm-1: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:31:29 vm-4: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:31:31 vm-0: crash: INFO: rcu detected stall in sys_getsockopt
2020/01/09 09:31:33 vm-18: crash: INFO: rcu detected stall in sys_clone3
2020/01/09 09:31:35 vm-3: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:31:36 vm-8: crash: INFO: rcu detected stall in do_idle
2020/01/09 09:31:37 VMs 7, executed 80, cover 0, crashes 6, repro 0
2020/01/09 09:31:38 vm-19: crash: INFO: rcu detected stall in schedule_tail
2020/01/09 09:31:40 vm-6: crash: INFO: rcu detected stall in schedule_tail
2020/01/09 09:31:42 vm-2: crash: INFO: rcu detected stall in schedule_tail
2020/01/09 09:31:44 vm-12: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:31:46 vm-15: crash: INFO: rcu detected stall in sys_nanosleep
2020/01/09 09:31:47 VMs 1, executed 80, cover 0, crashes 11, repro 0
2020/01/09 09:31:48 vm-16: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:31:50 vm-9: crash: INFO: rcu detected stall in schedule
2020/01/09 09:31:52 vm-13: crash: INFO: rcu detected stall in schedule_tail
2020/01/09 09:31:54 vm-11: crash: INFO: rcu detected stall in schedule_tail
2020/01/09 09:31:56 vm-17: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:31:57 VMs 0, executed 80, cover 0, crashes 16, repro 0
2020/01/09 09:31:58 vm-7: crash: INFO: rcu detected stall in sys_futex
2020/01/09 09:32:00 vm-5: crash: INFO: rcu detected stall in dput
2020/01/09 09:32:02 vm-14: crash: INFO: rcu detected stall in sys_nanosleep


Then I switched LSM to selinux and I _still_ can reproduce this. So,
Casey, you may relax, this is not smack-specific :)

Then I disabled CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK and it
started working normally.

So this is somehow related to both clang and KASAN/VMAP_STACK.

The clang I used is:
https://storage.googleapis.com/syzkaller/clang-kmsan-362913.tar.gz
(the one we use on syzbot).
