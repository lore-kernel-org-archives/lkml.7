Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL,WEIRD_PORT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB4C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D126206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogAjVnYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgAIRXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:23:34 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34867 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbgAIRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:23:34 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so3294331qvi.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ol7Z89x1q9Bk2b0iHrV1d110XANTLcaOuCwuCwl9eDw=;
        b=ogAjVnYKtmVk3FNIqQ31To1Kr+lj4RKmFatFzz5fyocmOSXI1QhZDskCluiiLgYNu+
         Kh6zvMFxhlHu5JT2p+D98bnGMt/IDLiP6jpAAoiSqSbtTy1OvunjrvzH5voknPMktDJz
         H++6T43JWzSN6aqYMw3GO9PF3tH2tHDqisjtFE0+6xFIgKTkKg+8Avz7v3YZ3BScLQ8/
         yaWr/xtx7xsZIKA2/fdPsYWU1SbQglVizCAFaXgTRyMew07cRxBXNH9DpHkp4yf7HgV6
         /uPA+jc1JjzVHBzmONtGxikRbWN/Q/2m4UMWb3x2hI5L2KmiQf7rxXe2l7K6/Qmq6WrW
         d9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ol7Z89x1q9Bk2b0iHrV1d110XANTLcaOuCwuCwl9eDw=;
        b=JFrfguxNcrelM6cBnWGMdHeLSPXeQ613mOhzLI4i3crGmVX2vqEfuaXLKN1fD6urP/
         SW1z5x6oett/LdPAN4zpAa1DYq388ZCVo+H7MPF9Zqi1Nns3Sj8T+3BSAGvrU+hvc1oH
         qPEBy/m2Xlh61EBWN5ap4faI+sZk+F750P3eA9gKpFgeUBo5xTu+lq2+jOHnt3r40nQO
         An6B+WUcYnbRK9R3waJN4cRuLMD2in0gjROTlAJwbIlkoyJOggTVtf9D4Az+2aLGRSYN
         1ehQ5i2jJwkKetAuPtDAjC/L2bYw4Vzi8xKxuqgUlZzA1guHl9Cjtelm975raWGdRz0N
         k2Ow==
X-Gm-Message-State: APjAAAVP/VBW2xsEH1Ea+9zV4otQLd45athU9jXPtndlcbmS4UcYj1es
        Wc+lls06tutC7ya0pMIX0X/Eg7dGCsJNAJLEUPzRXQ==
X-Google-Smtp-Source: APXvYqyUr3SDKGxgkWYYsRb3ucKioS9zoS2+queQtyo4aBxGfXY6FnGrKIeAcocj96w00L6MBCKOw1Y3kJMm5PKqWNU=
X-Received: by 2002:ad4:5a53:: with SMTP id ej19mr9842934qvb.34.1578590612698;
 Thu, 09 Jan 2020 09:23:32 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com> <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
 <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
 <CACT4Y+Z3GCncV3G1=36NmDRX_XOZsdoRJ3UshZoornbSRSN28w@mail.gmail.com>
 <CACT4Y+ZyVi=ow+VXA9PaWEVE8qKj8_AKzeFsNdsmiSR9iL3FOw@mail.gmail.com>
 <CACT4Y+axj5M4p=mZkFb1MyBw0MK1c6nWb-fKQcYSnYB8n1Cb8Q@mail.gmail.com>
 <CAG_fn=XddhnhqwFfzavcNJSYVprapH560okDL+mYmJ4OWGxWLA@mail.gmail.com> <CAKwvOdmYM+sfn3pNOxZm51K40MjyniEmBvwQJVxshq=FMaW_=Q@mail.gmail.com>
In-Reply-To: <CAKwvOdmYM+sfn3pNOxZm51K40MjyniEmBvwQJVxshq=FMaW_=Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jan 2020 18:23:20 +0100
Message-ID: <CACT4Y+apeR4GJdS3SwNZLAuGeojj0jKvc-s5jA=VBECnRFmunQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Axtens <dja@axtens.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

On Thu, Jan 9, 2020 at 6:17 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > > > > On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
> > > > > > > > > On 2020/01/08 15:20, Dmitry Vyukov wrote:
> > > > > > > > >> I temporarily re-enabled smack instance and it produced another 50
> > > > > > > > >> stalls all over the kernel, and now keeps spewing a dozen every hour.
> > > > > > > >
> > > > > > > > Do I have to be using clang to test this? I'm setting up to work on this,
> > > > > > > > and don't want to waste time using my current tool chain if the problem
> > > > > > > > is clang specific.
> > > > > > >
> > > > > > > Humm, interesting. Initially I was going to say that most likely it's
> > > > > > > not clang-related. Bug smack instance is actually the only one that
> > > > > > > uses clang as well (except for KMSAN of course). So maybe it's indeed
> > > > > > > clang-related rather than smack-related. Let me try to build a kernel
> > > > > > > with clang.
> > > > > >
> > > > > > +clang-built-linux, glider
> > > > > >
> > > > > > [clang-built linux is severe broken since early Dec]
>
> Is there automated reporting? Consider adding our mailing list for
> Clang specific failures.
> clang-built-linux <clang-built-linux@googlegroups.com>
> Our CI looks green, but there's a very long tail of combinations of
> configs that we don't have coverage of, so bug reports are
> appreciated:
> https://github.com/ClangBuiltLinux/linux/issues

syzbot does automatic reporting, but it does not automatically
classify bugs as clang-specific.
FTR, this combination is clang+KASAN+VMAP_STACK (relatively recent
changes, and that's what triggered the infinite loop). But note that
the kernel booted, you can ssh and do some basic things.

> > > > > >
> > > > > > Building kernel with clang I can immediately reproduce this locally:
> > > > > >
> > > > > > $ syz-manager
> > > > > > 2020/01/09 09:27:15 loading corpus...
> > > > > > 2020/01/09 09:27:17 serving http on http://0.0.0.0:50001
> > > > > > 2020/01/09 09:27:17 serving rpc on tcp://[::]:45851
> > > > > > 2020/01/09 09:27:17 booting test machines...
> > > > > > 2020/01/09 09:27:17 wait for the connection from test machine...
> > > > > > 2020/01/09 09:29:23 machine check:
> > > > > > 2020/01/09 09:29:23 syscalls                : 2961/3195
> > > > > > 2020/01/09 09:29:23 code coverage           : enabled
> > > > > > 2020/01/09 09:29:23 comparison tracing      : enabled
> > > > > > 2020/01/09 09:29:23 extra coverage          : enabled
> > > > > > 2020/01/09 09:29:23 setuid sandbox          : enabled
> > > > > > 2020/01/09 09:29:23 namespace sandbox       : enabled
> > > > > > 2020/01/09 09:29:23 Android sandbox         : /sys/fs/selinux/policy
> > > > > > does not exist
> > > > > > 2020/01/09 09:29:23 fault injection         : enabled
> > > > > > 2020/01/09 09:29:23 leak checking           : CONFIG_DEBUG_KMEMLEAK is
> > > > > > not enabled
> > > > > > 2020/01/09 09:29:23 net packet injection    : enabled
> > > > > > 2020/01/09 09:29:23 net device setup        : enabled
> > > > > > 2020/01/09 09:29:23 concurrency sanitizer   : /sys/kernel/debug/kcsan
> > > > > > does not exist
> > > > > > 2020/01/09 09:29:23 devlink PCI setup       : PCI device 0000:00:10.0
> > > > > > is not available
> > > > > > 2020/01/09 09:29:27 corpus                  : 50226 (0 deleted)
> > > > > > 2020/01/09 09:29:27 VMs 20, executed 0, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:29:37 VMs 20, executed 45, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:29:47 VMs 20, executed 74, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:29:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:30:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:30:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:30:27 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:30:37 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:30:47 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:30:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:31:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:31:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:31:26 vm-10: crash: INFO: rcu detected stall in do_idle
> > > > > > 2020/01/09 09:31:27 VMs 13, executed 80, cover 0, crashes 0, repro 0
> > > > > > 2020/01/09 09:31:28 vm-1: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:31:29 vm-4: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:31:31 vm-0: crash: INFO: rcu detected stall in sys_getsockopt
> > > > > > 2020/01/09 09:31:33 vm-18: crash: INFO: rcu detected stall in sys_clone3
> > > > > > 2020/01/09 09:31:35 vm-3: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:31:36 vm-8: crash: INFO: rcu detected stall in do_idle
> > > > > > 2020/01/09 09:31:37 VMs 7, executed 80, cover 0, crashes 6, repro 0
> > > > > > 2020/01/09 09:31:38 vm-19: crash: INFO: rcu detected stall in schedule_tail
> > > > > > 2020/01/09 09:31:40 vm-6: crash: INFO: rcu detected stall in schedule_tail
> > > > > > 2020/01/09 09:31:42 vm-2: crash: INFO: rcu detected stall in schedule_tail
> > > > > > 2020/01/09 09:31:44 vm-12: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:31:46 vm-15: crash: INFO: rcu detected stall in sys_nanosleep
> > > > > > 2020/01/09 09:31:47 VMs 1, executed 80, cover 0, crashes 11, repro 0
> > > > > > 2020/01/09 09:31:48 vm-16: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:31:50 vm-9: crash: INFO: rcu detected stall in schedule
> > > > > > 2020/01/09 09:31:52 vm-13: crash: INFO: rcu detected stall in schedule_tail
> > > > > > 2020/01/09 09:31:54 vm-11: crash: INFO: rcu detected stall in schedule_tail
> > > > > > 2020/01/09 09:31:56 vm-17: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:31:57 VMs 0, executed 80, cover 0, crashes 16, repro 0
> > > > > > 2020/01/09 09:31:58 vm-7: crash: INFO: rcu detected stall in sys_futex
> > > > > > 2020/01/09 09:32:00 vm-5: crash: INFO: rcu detected stall in dput
> > > > > > 2020/01/09 09:32:02 vm-14: crash: INFO: rcu detected stall in sys_nanosleep
> > > > > >
> > > > > >
> > > > > > Then I switched LSM to selinux and I _still_ can reproduce this. So,
> > > > > > Casey, you may relax, this is not smack-specific :)
> > > > > >
> > > > > > Then I disabled CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK and it
> > > > > > started working normally.
> > > > > >
> > > > > > So this is somehow related to both clang and KASAN/VMAP_STACK.
> > > > > >
> > > > > > The clang I used is:
> > > > > > https://storage.googleapis.com/syzkaller/clang-kmsan-362913.tar.gz
> > > > > > (the one we use on syzbot).
> > > > >
> > > > >
> > > > > Clustering hangs, they all happen within very limited section of the code:
> > > > >
> > > > >       1  free_thread_stack+0x124/0x590 kernel/fork.c:284
> > > > >       5  free_thread_stack+0x12e/0x590 kernel/fork.c:280
> > > > >      39  free_thread_stack+0x12e/0x590 kernel/fork.c:284
> > > > >       6  free_thread_stack+0x133/0x590 kernel/fork.c:280
> > > > >       5  free_thread_stack+0x13d/0x590 kernel/fork.c:280
> > > > >       2  free_thread_stack+0x141/0x590 kernel/fork.c:280
> > > > >       6  free_thread_stack+0x14c/0x590 kernel/fork.c:280
> > > > >       9  free_thread_stack+0x151/0x590 kernel/fork.c:280
> > > > >       3  free_thread_stack+0x15b/0x590 kernel/fork.c:280
> > > > >      67  free_thread_stack+0x168/0x590 kernel/fork.c:280
> > > > >       6  free_thread_stack+0x16d/0x590 kernel/fork.c:284
> > > > >       2  free_thread_stack+0x177/0x590 kernel/fork.c:284
> > > > >       1  free_thread_stack+0x182/0x590 kernel/fork.c:284
> > > > >       1  free_thread_stack+0x186/0x590 kernel/fork.c:284
> > > > >      16  free_thread_stack+0x18b/0x590 kernel/fork.c:284
> > > > >       4  free_thread_stack+0x195/0x590 kernel/fork.c:284
> > > > >
> > > > > Here is disass of the function:
> > > > > https://gist.githubusercontent.com/dvyukov/a283d1aaf2ef7874001d56525279ccbd/raw/ac2478bff6472bc473f57f91a75f827cd72bb6bf/gistfile1.txt
> > > > >
> > > > > But if I am not mistaken, the function only ever jumps down. So how
> > > > > can it loop?...
> > > >
> > > >
> > > > This is a miscompilation related to static branches.
> > > >
> > > > objdump shows:
> > > >
> > > > ffffffff814878f8: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
> > > >  ./arch/x86/include/asm/jump_label.h:25
> > > > asm_volatile_goto("1:"
> > > >
> > > > However, the actual instruction in memory at the time is:
> > > >
> > > >    0xffffffff814878f8 <+408>: jmpq   0xffffffff8148787f <free_thread_stack+287>
> > > >
> > > > Which jumps to a wrong location in free_thread_stack and makes it loop.
> > > >
> > > > The static branch is this:
> > > >
> > > > static inline bool memcg_kmem_enabled(void)
> > > > {
> > > >   return static_branch_unlikely(&memcg_kmem_enabled_key);
> > > > }
> > > >
> > > > static inline void memcg_kmem_uncharge(struct page *page, int order)
> > > > {
> > > >   if (memcg_kmem_enabled())
> > > >     __memcg_kmem_uncharge(page, order);
> > > > }
> > > >
> > > > I suspect it may have something to do with loop unrolling. It may jump
> > > > to the right location, but in the wrong unrolled iteration.
>
> I disabled loop unrolling and loop unswitching in LLVM when the loop
> contained asm goto in:
> https://github.com/llvm/llvm-project/commit/c4f245b40aad7e8627b37a8bf1bdcdbcd541e665
> I have a fix for loop unrolling in:
> https://reviews.llvm.org/D64101
> that I should dust off. I haven't looked into loop unswitching yet.

c4f245b40aad7e8627b37a8bf1bdcdbcd541e665 is in the range between the
broken compiler and the newer compiler that seems to work, so I would
assume that that commit fixes this.
We will get the final stamp from syzbot hopefully by tomorrow.
