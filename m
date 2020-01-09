Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,WEIRD_PORT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB84C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31F206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CF29A5OZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgAIJ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:29:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41876 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgAIJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:29:37 -0500
Received: by mail-qv1-f68.google.com with SMTP id x1so2662110qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htGEPzh2cvAg6/SqoSQkw2b0L7SR3bZlTMACQb3VVDc=;
        b=CF29A5OZttbLoIKGXoB7I3DCk4mt1HLnFYxw/ucF+wQ1+6kKCDaZV3YtdjWTpVibek
         iQMzTU+7FD+icgHt3c0ssmi2QzYxwcXXKbYyPc+1DBjf8pEjhbl7W6nPvBZEsMsj5yoj
         Aw6Hs2mTckfrsf021cwOyW/q5VkojRDMsZsyoyHODNxwNL6AJU4VmM5h+MXJ/Xi8QQ9s
         6hsdcOK3wmW+GDVsqEITNmQvoz1knU3eVyjpY/D2doEKrNTdNfrBXNZHsm0+Ul1GUX4R
         qbV8fc/tVUVZ9qKP+MnyYKLbLi2NcYAvdNJlTIBMBPhqbO/KkAUnONCUt46XwdwPgFbJ
         E4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htGEPzh2cvAg6/SqoSQkw2b0L7SR3bZlTMACQb3VVDc=;
        b=HRBoAArwZN4ssO5RbqvPLIUcAmwLUSPoSNYztnkSjSuT7zmPT4DS1CvDS0tc7ydZpz
         E9fbFwvkCpcrodER9nICX4iM9h1JXOadtozhkWIIRqtKb8j0Ft0SefJcPX4uPzY2Zcke
         GW57uY3zdz5WZui1EUzZ0+aJtNh0KdNzdB7pzSTXIPHQmugW8kdkXIKi80k6zjpw5/pw
         qfDyUfHfmLa2bVd9MEnLjhFutdGBS+N9B6nPTcqzbjs6iwSoL2+DFGD1t3aU96DH8vNm
         gxvStLLXcnDqWvftMUpnblwEFvrebrUhfvOu7QWtEhwDgJ1xXU05eFQIy6Qk1+37Z8V2
         znTw==
X-Gm-Message-State: APjAAAWwth+e/Q9RlZDYChOYHd2kz1FP6wzD0W1IBAgfXdxEp/M2Alq5
        ut3zKrQWFoMAy/ax9L4wuPBUkgw5iIvDtOpul4Nivw==
X-Google-Smtp-Source: APXvYqzap8l7wYZegCXgMVixomdo3lUj9OoQhfyhx2UDFoOAfq+am8NlHLq0X41rml13WxX6CecoI5gj//0iinTIXEk=
X-Received: by 2002:ad4:5a53:: with SMTP id ej19mr8036254qvb.34.1578562175261;
 Thu, 09 Jan 2020 01:29:35 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036decf0598c8762e@google.com> <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com> <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net> <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
 <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com> <CACT4Y+bURugCpLm5TG37-7voFEeEoXo_Gb=3sy75_RELZotXHw@mail.gmail.com>
 <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
In-Reply-To: <CACT4Y+avizeUd=nY2w1B_LbEC1cP5prBfpnANYaxhgS_fcL6ag@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jan 2020 10:29:23 +0100
Message-ID: <CACT4Y+Z3GCncV3G1=36NmDRX_XOZsdoRJ3UshZoornbSRSN28w@mail.gmail.com>
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

On Thu, Jan 9, 2020 at 9:50 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Jan 9, 2020 at 9:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Jan 8, 2020 at 6:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >
> > > On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
> > > > On 2020/01/08 15:20, Dmitry Vyukov wrote:
> > > >> I temporarily re-enabled smack instance and it produced another 50
> > > >> stalls all over the kernel, and now keeps spewing a dozen every hour.
> > >
> > > Do I have to be using clang to test this? I'm setting up to work on this,
> > > and don't want to waste time using my current tool chain if the problem
> > > is clang specific.
> >
> > Humm, interesting. Initially I was going to say that most likely it's
> > not clang-related. Bug smack instance is actually the only one that
> > uses clang as well (except for KMSAN of course). So maybe it's indeed
> > clang-related rather than smack-related. Let me try to build a kernel
> > with clang.
>
> +clang-built-linux, glider
>
> [clang-built linux is severe broken since early Dec]
>
> Building kernel with clang I can immediately reproduce this locally:
>
> $ syz-manager
> 2020/01/09 09:27:15 loading corpus...
> 2020/01/09 09:27:17 serving http on http://0.0.0.0:50001
> 2020/01/09 09:27:17 serving rpc on tcp://[::]:45851
> 2020/01/09 09:27:17 booting test machines...
> 2020/01/09 09:27:17 wait for the connection from test machine...
> 2020/01/09 09:29:23 machine check:
> 2020/01/09 09:29:23 syscalls                : 2961/3195
> 2020/01/09 09:29:23 code coverage           : enabled
> 2020/01/09 09:29:23 comparison tracing      : enabled
> 2020/01/09 09:29:23 extra coverage          : enabled
> 2020/01/09 09:29:23 setuid sandbox          : enabled
> 2020/01/09 09:29:23 namespace sandbox       : enabled
> 2020/01/09 09:29:23 Android sandbox         : /sys/fs/selinux/policy
> does not exist
> 2020/01/09 09:29:23 fault injection         : enabled
> 2020/01/09 09:29:23 leak checking           : CONFIG_DEBUG_KMEMLEAK is
> not enabled
> 2020/01/09 09:29:23 net packet injection    : enabled
> 2020/01/09 09:29:23 net device setup        : enabled
> 2020/01/09 09:29:23 concurrency sanitizer   : /sys/kernel/debug/kcsan
> does not exist
> 2020/01/09 09:29:23 devlink PCI setup       : PCI device 0000:00:10.0
> is not available
> 2020/01/09 09:29:27 corpus                  : 50226 (0 deleted)
> 2020/01/09 09:29:27 VMs 20, executed 0, cover 0, crashes 0, repro 0
> 2020/01/09 09:29:37 VMs 20, executed 45, cover 0, crashes 0, repro 0
> 2020/01/09 09:29:47 VMs 20, executed 74, cover 0, crashes 0, repro 0
> 2020/01/09 09:29:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:27 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:37 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:47 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:30:57 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:07 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:17 VMs 20, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:26 vm-10: crash: INFO: rcu detected stall in do_idle
> 2020/01/09 09:31:27 VMs 13, executed 80, cover 0, crashes 0, repro 0
> 2020/01/09 09:31:28 vm-1: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:29 vm-4: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:31 vm-0: crash: INFO: rcu detected stall in sys_getsockopt
> 2020/01/09 09:31:33 vm-18: crash: INFO: rcu detected stall in sys_clone3
> 2020/01/09 09:31:35 vm-3: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:36 vm-8: crash: INFO: rcu detected stall in do_idle
> 2020/01/09 09:31:37 VMs 7, executed 80, cover 0, crashes 6, repro 0
> 2020/01/09 09:31:38 vm-19: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:40 vm-6: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:42 vm-2: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:44 vm-12: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:46 vm-15: crash: INFO: rcu detected stall in sys_nanosleep
> 2020/01/09 09:31:47 VMs 1, executed 80, cover 0, crashes 11, repro 0
> 2020/01/09 09:31:48 vm-16: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:50 vm-9: crash: INFO: rcu detected stall in schedule
> 2020/01/09 09:31:52 vm-13: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:54 vm-11: crash: INFO: rcu detected stall in schedule_tail
> 2020/01/09 09:31:56 vm-17: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:31:57 VMs 0, executed 80, cover 0, crashes 16, repro 0
> 2020/01/09 09:31:58 vm-7: crash: INFO: rcu detected stall in sys_futex
> 2020/01/09 09:32:00 vm-5: crash: INFO: rcu detected stall in dput
> 2020/01/09 09:32:02 vm-14: crash: INFO: rcu detected stall in sys_nanosleep
>
>
> Then I switched LSM to selinux and I _still_ can reproduce this. So,
> Casey, you may relax, this is not smack-specific :)
>
> Then I disabled CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK and it
> started working normally.
>
> So this is somehow related to both clang and KASAN/VMAP_STACK.
>
> The clang I used is:
> https://storage.googleapis.com/syzkaller/clang-kmsan-362913.tar.gz
> (the one we use on syzbot).


Clustering hangs, they all happen within very limited section of the code:

      1  free_thread_stack+0x124/0x590 kernel/fork.c:284
      5  free_thread_stack+0x12e/0x590 kernel/fork.c:280
     39  free_thread_stack+0x12e/0x590 kernel/fork.c:284
      6  free_thread_stack+0x133/0x590 kernel/fork.c:280
      5  free_thread_stack+0x13d/0x590 kernel/fork.c:280
      2  free_thread_stack+0x141/0x590 kernel/fork.c:280
      6  free_thread_stack+0x14c/0x590 kernel/fork.c:280
      9  free_thread_stack+0x151/0x590 kernel/fork.c:280
      3  free_thread_stack+0x15b/0x590 kernel/fork.c:280
     67  free_thread_stack+0x168/0x590 kernel/fork.c:280
      6  free_thread_stack+0x16d/0x590 kernel/fork.c:284
      2  free_thread_stack+0x177/0x590 kernel/fork.c:284
      1  free_thread_stack+0x182/0x590 kernel/fork.c:284
      1  free_thread_stack+0x186/0x590 kernel/fork.c:284
     16  free_thread_stack+0x18b/0x590 kernel/fork.c:284
      4  free_thread_stack+0x195/0x590 kernel/fork.c:284

Here is disass of the function:
https://gist.githubusercontent.com/dvyukov/a283d1aaf2ef7874001d56525279ccbd/raw/ac2478bff6472bc473f57f91a75f827cd72bb6bf/gistfile1.txt

But if I am not mistaken, the function only ever jumps down. So how
can it loop?...
