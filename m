Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BDAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218222087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2iz096Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfCHOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:50:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oF3X6/dWlRmR8btgpPxWOilGntqkDZ4RhhvDrq+rIzs=; b=2iz096Sny7my5Y1n+cKcsT+yp
        mECeb5qmKWP8FMS/xX0WI/4v4D5OU6l0T2QwFmrg727Kxaa6o8ojRKpNvgUCBjRUc+9q5p3/aS7a7
        Mo1NPRT+Lo+CY9N2i3uvHDlUv7o6MPF7mVTVW85f1CYM5+ERMpTDezXTntnU5X5QwGWTH4KU4RCvI
        KqnB/6aHUSPwTETZStOUuMVx3xttBh625fyva6c+lfz5p86xwkxMQbXPTRZMjOSPwY6+sS/DUETlb
        pnUsHuiHYEK59EUB6yVh10nWx4wk0qZijZteMAkpT3JBbbiFRZNcwDZWhaUT4JprUpmpCJWo10SxL
        77oWrvtuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2GpW-0007ga-0y; Fri, 08 Mar 2019 14:50:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C69B20298BA7; Fri,  8 Mar 2019 15:50:31 +0100 (CET)
Date:   Fri, 8 Mar 2019 15:50:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/percpu semantics and fixes
Message-ID: <20190308145031.GY32494@hirez.programming.kicks-ass.net>
References: <20190227101252.413192716@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <20190227101252.413192716@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2019 at 11:12:52AM +0100, Peter Zijlstra wrote:

> This is a collection of x86/percpu changes that I had pending and got reminded
> of by Linus' comment yesterday about __this_cpu_xchg().
> 
> This tidies up the x86/percpu primitives and fixes a bunch of 'fallout'.

(Sorry; this is going to have _wide_ output)

OK, so what I did is I build 4 kernels (O=defconfig-build{,1,2,3}) with
resp that many patches of this series applied.

When I look at just the vmlinux size output:

$ size defconfig-build*/vmlinux
text    data     bss     dec     hex filename
19540631        5040164 1871944 26452739        193a303 defconfig-build/vmlinux
19540635        5040164 1871944 26452743        193a307 defconfig-build1/vmlinux
19540685        5040164 1871944 26452793        193a339 defconfig-build2/vmlinux
19540685        5040164 1871944 26452793        193a339 defconfig-build3/vmlinux

Things appear to get slightly larger; however when I look in more
detail using my (newly written compare script, find attached), I get
things like:

$ ./compare.sh defconfig-build defconfig-build1
arch/x86/mm/fault.o                                     12850      12818   -32
kernel/power/process.o                                   3586       3706   +120
kernel/locking/rtmutex.o                                 1687       1671   -16
kernel/sched/core.o                                      7127       7181   +54
kernel/time/tick-sched.o                                 8941       8837   -104
kernel/exit.o                                             310        385   +75
kernel/softirq.o                                         1217       1199   -18
kernel/workqueue.o                                       3240       3288   +48
net/ipv6/tcp_ipv6.o                                     25434      25345   -89
net/ipv4/tcp_ipv4.o                                       301        305   +4
                                             total    4768226    4768268   +42

When we look at just tick-sched.o:

$ ./compare.sh defconfig-build defconfig-build1 kernel/time/tick-sched.o
can_stop_idle_tick.isra.14                                146        139   -7

we see a totally different number ?!

$ ./compare.sh defconfig-build defconfig-build1 kernel/time/tick-sched.o can_stop_idle_tick.isra.14
0000 0000000000000680 <can_stop_idle_tick.isra.14>:                                                     | 0000 0000000000000680 <can_stop_idle_tick.isra.14>:
0000  680:      53                      push   %rbx                                                     | 0000  680:    53                      push   %rbx
0001  681:      89 f8                   mov    %edi,%eax                                                | 0001  681:    89 f8                   mov    %edi,%eax
0003  683:      48 0f a3 05 00 00 00    bt     %rax,0x0(%rip)        # 68b <can_stop_id                 | 0003  683:    48 0f a3 05 00 00 00    bt     %rax,0x0(%rip)        # 68b <can_stop_id
000a  68a:      00                                                                                      | 000a  68a:    00
0007                    687: R_X86_64_PC32      __cpu_online_mask-0x4                                   | 0007                  687: R_X86_64_PC32      __cpu_online_mask-0x4
000b  68b:      0f 92 c3                setb   %bl                                                      | 000b  68b:    0f 92 c3                setb   %bl
000e  68e:      73 67                   jae    6f7 <can_stop_idle_tick.isra.14+0x77>                    \ 000e  68e:    73 48                   jae    6d8 <can_stop_idle_tick.isra.14+0x58>
0010  690:      8b 06                   mov    (%rsi),%eax                                              | 0010  690:    8b 06                   mov    (%rsi),%eax
0012  692:      85 c0                   test   %eax,%eax                                                | 0012  692:    85 c0                   test   %eax,%eax
0014  694:      74 21                   je     6b7 <can_stop_idle_tick.isra.14+0x37>                    | 0014  694:    74 21                   je     6b7 <can_stop_idle_tick.isra.14+0x37>
0016  696:      65 48 8b 04 25 00 00    mov    %gs:0x0,%rax                                             | 0016  696:    65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
001d  69d:      00 00                                                                                   | 001d  69d:    00 00
001b                    69b: R_X86_64_32S       current_task                                            | 001b                  69b: R_X86_64_32S       current_task
001f  69f:      48 8b 00                mov    (%rax),%rax                                              | 001f  69f:    48 8b 00                mov    (%rax),%rax
0022  6a2:      a8 08                   test   $0x8,%al                                                 | 0022  6a2:    a8 08                   test   $0x8,%al
0024  6a4:      75 11                   jne    6b7 <can_stop_idle_tick.isra.14+0x37>                    | 0024  6a4:    75 11                   jne    6b7 <can_stop_idle_tick.isra.14+0x37>
0026  6a6:      65 66 8b 05 00 00 00    mov    %gs:0x0(%rip),%ax        # 6ae <can_stop                 \ 0026  6a6:    65 66 8b 35 00 00 00    mov    %gs:0x0(%rip),%si        # 6ae <can_stop
002d  6ad:      00                                                                                      | 002d  6ad:    00
002a                    6aa: R_X86_64_PC32      irq_stat-0x4                                            | 002a                  6aa: R_X86_64_PC32      irq_stat-0x4
002e  6ae:      66 85 c0                test   %ax,%ax                                                  \ 002e  6ae:    66 85 f6                test   %si,%si
0031  6b1:      75 0a                   jne    6bd <can_stop_idle_tick.isra.14+0x3d>                    | 0031  6b1:    75 0a                   jne    6bd <can_stop_idle_tick.isra.14+0x3d>
0033  6b3:      89 d8                   mov    %ebx,%eax                                                | 0033  6b3:    89 d8                   mov    %ebx,%eax
0035  6b5:      5b                      pop    %rbx                                                     | 0035  6b5:    5b                      pop    %rbx
0036  6b6:      c3                      retq                                                            | 0036  6b6:    c3                      retq
0037  6b7:      31 db                   xor    %ebx,%ebx                                                | 0037  6b7:    31 db                   xor    %ebx,%ebx
0039  6b9:      89 d8                   mov    %ebx,%eax                                                | 0039  6b9:    89 d8                   mov    %ebx,%eax
003b  6bb:      5b                      pop    %rbx                                                     | 003b  6bb:    5b                      pop    %rbx
003c  6bc:      c3                      retq                                                            | 003c  6bc:    c3                      retq
003d  6bd:      31 db                   xor    %ebx,%ebx                                                | 003d  6bd:    31 db                   xor    %ebx,%ebx
003f  6bf:      83 3d 00 00 00 00 09    cmpl   $0x9,0x0(%rip)        # 6c6 <can_stop_id                 | 003f  6bf:    83 3d 00 00 00 00 09    cmpl   $0x9,0x0(%rip)        # 6c6 <can_stop_id
0041                    6c1: R_X86_64_PC32      .bss-0x5                                                | 0041                  6c1: R_X86_64_PC32      .bss-0x5
0046  6c6:      7f eb                   jg     6b3 <can_stop_idle_tick.isra.14+0x33>                    | 0046  6c6:    7f eb                   jg     6b3 <can_stop_idle_tick.isra.14+0x33>
0048  6c8:      65 66 8b 05 00 00 00    mov    %gs:0x0(%rip),%ax        # 6d0 <can_stop                 \ 0048  6c8:    0f b7 f6                movzwl %si,%esi
004f  6cf:      00                                                                                      \ 004b  6cb:    f7 c6 ff fd 00 00       test   $0xfdff,%esi
004c                    6cc: R_X86_64_PC32      irq_stat-0x4                                            \ 0051  6d1:    74 e0                   je     6b3 <can_stop_idle_tick.isra.14+0x33>
0050  6d0:      a9 ff fd 00 00          test   $0xfdff,%eax                                             \ 0053  6d3:    e9 00 00 00 00          jmpq   6d8 <can_stop_idle_tick.isra.14+0x58>
0055  6d5:      74 dc                   je     6b3 <can_stop_idle_tick.isra.14+0x33>                    \ 0054                  6d4: R_X86_64_PC32      .text.unlikely-0x4
0057  6d7:      65 66 8b 35 00 00 00    mov    %gs:0x0(%rip),%si        # 6df <can_stop                 \ 0058  6d8:    3b 3d 00 00 00 00       cmp    0x0(%rip),%edi        # 6de <can_stop_id
005e  6de:      00                                                                                      \ 005a                  6da: R_X86_64_PC32      tick_do_timer_cpu-0x4
005b                    6db: R_X86_64_PC32      irq_stat-0x4                                            \ 005e  6de:    75 0a                   jne    6ea <can_stop_idle_tick.isra.14+0x6a>
005f  6df:      48 c7 c7 00 00 00 00    mov    $0x0,%rdi                                                \ 0060  6e0:    c7 05 00 00 00 00 ff    movl   $0xffffffff,0x0(%rip)        # 6ea <can_
0062                    6e2: R_X86_64_32S       .rodata.str1.8                                          \ 0067  6e7:    ff ff ff
0066  6e6:      0f b7 f6                movzwl %si,%esi                                                 \ 0062                  6e2: R_X86_64_PC32      tick_do_timer_cpu-0x8
0069  6e9:      e8 00 00 00 00          callq  6ee <can_stop_idle_tick.isra.14+0x6e>                    \ 006a  6ea:    48 c7 02 00 00 00 00    movq   $0x0,(%rdx)
006a                    6ea: R_X86_64_PLT32     printk-0x4                                              \ 0071  6f1:    eb c0                   jmp    6b3 <can_stop_idle_tick.isra.14+0x33>
006e  6ee:      83 05 00 00 00 00 01    addl   $0x1,0x0(%rip)        # 6f5 <can_stop_id                 \ 0073  6f3:    66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
0070                    6f0: R_X86_64_PC32      .bss-0x5                                                \ 007a  6fa:    00 00 00 00
0075  6f5:      eb bc                   jmp    6b3 <can_stop_idle_tick.isra.14+0x33>                    \ 007e  6fe:    66 90                   xchg   %ax,%ax
0077  6f7:      3b 3d 00 00 00 00       cmp    0x0(%rip),%edi        # 6fd <can_stop_id                 \ fffffffffffff980
0079                    6f9: R_X86_64_PC32      tick_do_timer_cpu-0x4                                   \ 0000 0000000000000000 <can_stop_idle_tick.isra.14.cold.23>:
007d  6fd:      75 0a                   jne    709 <can_stop_idle_tick.isra.14+0x89>                    \ 0000    0:    48 c7 c7 00 00 00 00    mov    $0x0,%rdi
007f  6ff:      c7 05 00 00 00 00 ff    movl   $0xffffffff,0x0(%rip)        # 709 <can_                 \ 0003                  3: R_X86_64_32S .rodata.str1.8
0086  706:      ff ff ff                                                                                \ 0007    7:    e8 00 00 00 00          callq  c <can_stop_idle_tick.isra.14.cold.23+0x
0081                    701: R_X86_64_PC32      tick_do_timer_cpu-0x8                                   \ 0008                  8: R_X86_64_PLT32       printk-0x4
0089  709:      48 c7 02 00 00 00 00    movq   $0x0,(%rdx)                                              \ 000c    c:    83 05 00 00 00 00 01    addl   $0x1,0x0(%rip)        # 13 <can_stop_idl
0090  710:      eb a1                   jmp    6b3 <can_stop_idle_tick.isra.14+0x33>                    \ 000e                  e: R_X86_64_PC32        .bss-0x5
0092  712:      66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)                                \ 0013   13:    e9 00 00 00 00          jmpq   18 <__setup_setup_tick_nohz>
0099  719:      00 00 00 00                                                                             \ 0014                  14: R_X86_64_PC32       .text+0x6af
009d  71d:      0f 1f 00                nopl   (%rax)                                                   \

And we see that GCC created a .cold. subfunction because the first patch
removed the volatile from __this_cpu_read() and could thus move it.


Similarly the second patch; which removes volatile from
smp_processor_id():

$ ./compare.sh defconfig-build1 defconfig-build2
arch/x86/events/amd/ibs.o                                 667        757   +90
arch/x86/kernel/cpu/mce/core.o                           2677       2696   +19
arch/x86/kernel/cpu/mce/therm_throt.o                     508        527   +19
arch/x86/kernel/cpu/mtrr/generic.o                       9523       9203   -320
arch/x86/kernel/acpi/sleep.o                             3152       3088   -64
arch/x86/kernel/nmi.o                                     338        562   +224
arch/x86/kernel/process.o                                1554       1586   +32
arch/x86/kernel/tsc_sync.o                               5591       5377   -214
kernel/irq/spurious.o                                    5835       5771   -64
kernel/irq/cpuhotplug.o                                  2253       2189   -64
kernel/time/clocksource.o                                 480        593   +113
                                             total    4768268    4768039   -229

we get smaller total executable sections; and even when there is growth:

$ ./compare.sh defconfig-build1 defconfig-build2 arch/x86/events/amd/ibs.o setup_APIC_ibs
0000 0000000000000420 <setup_APIC_ibs>:                                                                 | 0000 0000000000000420 <setup_APIC_ibs>:
0000  420:      53                      push   %rbx                                                     | 0000  420:    53                      push   %rbx
0001  421:      b9 3a 10 01 c0          mov    $0xc001103a,%ecx                                         | 0001  421:    b9 3a 10 01 c0          mov    $0xc001103a,%ecx
0006  426:      0f 32                   rdmsr                                                           | 0006  426:    0f 32                   rdmsr
0008  428:      48 c1 e2 20             shl    $0x20,%rdx                                               | 0008  428:    48 c1 e2 20             shl    $0x20,%rdx
000c  42c:      48 89 d3                mov    %rdx,%rbx                                                | 000c  42c:    48 89 d3                mov    %rdx,%rbx
000f  42f:      48 09 c3                or     %rax,%rbx                                                | 000f  42f:    48 09 c3                or     %rax,%rbx
0012  432:      0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)                                         | 0012  432:    0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
0017  437:      f6 c7 01                test   $0x1,%bh                                                 | 0017  437:    f6 c7 01                test   $0x1,%bh
001a  43a:      74 2a                   je     466 <setup_APIC_ibs+0x46>                                \ 001a  43a:    0f 84 00 00 00 00       je     440 <setup_APIC_ibs+0x20>
001c  43c:      89 df                   mov    %ebx,%edi                                                \ 001c                  43c: R_X86_64_PC32      .text.unlikely-0x4
001e  43e:      31 c9                   xor    %ecx,%ecx                                                \ 0020  440:    89 df                   mov    %ebx,%edi
0020  440:      31 f6                   xor    %esi,%esi                                                \ 0022  442:    31 c9                   xor    %ecx,%ecx
0022  442:      ba 04 00 00 00          mov    $0x4,%edx                                                \ 0024  444:    31 f6                   xor    %esi,%esi
0027  447:      83 e7 0f                and    $0xf,%edi                                                \ 0026  446:    ba 04 00 00 00          mov    $0x4,%edx
002a  44a:      e8 00 00 00 00          callq  44f <setup_APIC_ibs+0x2f>                                \ 002b  44b:    83 e7 0f                and    $0xf,%edi
002b                    44b: R_X86_64_PLT32     setup_APIC_eilvt-0x4                                    \ 002e  44e:    e8 00 00 00 00          callq  453 <setup_APIC_ibs+0x33>
002f  44f:      85 c0                   test   %eax,%eax                                                \ 002f                  44f: R_X86_64_PLT32     setup_APIC_eilvt-0x4
0031  451:      75 13                   jne    466 <setup_APIC_ibs+0x46>                                \ 0033  453:    85 c0                   test   %eax,%eax
0033  453:      5b                      pop    %rbx                                                     \ 0035  455:    0f 85 00 00 00 00       jne    45b <setup_APIC_ibs+0x3b>
0034  454:      c3                      retq                                                            \ 0037                  457: R_X86_64_PC32      .text.unlikely-0x4
0035  455:      31 d2                   xor    %edx,%edx                                                \ 003b  45b:    5b                      pop    %rbx
0037  457:      48 89 de                mov    %rbx,%rsi                                                \ 003c  45c:    c3                      retq
003a  45a:      bf 3a 10 01 c0          mov    $0xc001103a,%edi                                         \ 003d  45d:    31 d2                   xor    %edx,%edx
003f  45f:      e8 00 00 00 00          callq  464 <setup_APIC_ibs+0x44>                                \ 003f  45f:    48 89 de                mov    %rbx,%rsi
0040                    460: R_X86_64_PLT32     do_trace_read_msr-0x4                                   \ 0042  462:    bf 3a 10 01 c0          mov    $0xc001103a,%edi
0044  464:      eb d1                   jmp    437 <setup_APIC_ibs+0x17>                                \ 0047  467:    e8 00 00 00 00          callq  46c <setup_APIC_ibs+0x4c>
0046  466:      65 8b 35 00 00 00 00    mov    %gs:0x0(%rip),%esi        # 46d <setup_A                 \ 0048                  468: R_X86_64_PLT32     do_trace_read_msr-0x4
0049                    469: R_X86_64_PC32      cpu_number-0x4                                          \ 004c  46c:    eb c9                   jmp    437 <setup_APIC_ibs+0x17>
004d  46d:      48 c7 c7 00 00 00 00    mov    $0x0,%rdi                                                \ 004e  46e:    66 90                   xchg   %ax,%ax
0050                    470: R_X86_64_32S       .rodata.str1.8                                          \ fffffffffffffbe0
0054  474:      5b                      pop    %rbx                                                     \ 0000 0000000000000000 <setup_APIC_ibs.cold.9>:
0055  475:      e9 00 00 00 00          jmpq   47a <setup_APIC_ibs+0x5a>                                \ 0000    0:    48 c7 c7 00 00 00 00    mov    $0x0,%rdi
0056                    476: R_X86_64_PLT32     printk-0x4                                              \ 0003                  3: R_X86_64_32S .rodata.str1.8
005a  47a:      66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)                                         \ 0007    7:    5b                      pop    %rbx
fffffffffffffbe0                                                                                        \ 0008    8:    65 8b 35 00 00 00 00    mov    %gs:0x0(%rip),%esi        # f <setup_API
                                                                                                        \ 000b                  b: R_X86_64_PC32        cpu_number-0x4
                                                                                                        \ 000f    f:    e9 00 00 00 00          jmpq   14 <force_ibs_eilvt_setup.cold.10>
                                                                                                        \ 0010                  10: R_X86_64_PLT32      printk-0x4
                                                                                                        \ 0000

It is because of cold subfunction creation; with a reduction in side of
the regular path.

The third build included patches 3 and 4 (because they don't much
overlap); and give some meagre savings:

$ ./compare.sh defconfig-build2 defconfig-build3 arch/x86/kernel/irq.o
do_IRQ                                                    195        187   -8
smp_x86_platform_ipi                                      234        222   -12
smp_kvm_posted_intr_ipi                                    74         66   -8
smp_kvm_posted_intr_wakeup_ipi                             86         78   -8
smp_kvm_posted_intr_nested_ipi                             74         66   -8
$ ./compare.sh defconfig-build2 defconfig-build3 arch/x86/mm/tlb.o
flush_tlb_func_common.constprop.13                        728        719   -9
switch_mm_irqs_off                                       1528       1524   -4



Now, I realize you particularly hate the tlb patch; and I'll see if I
can get these same savings with a few less __ added.

But in general, I think these patches are worth it. esp. since I've
already done them :-)

--9Iq5ULCa7nGtWwZS
Content-Type: application/x-sh
Content-Disposition: attachment; filename="compare.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Asrc=3D$1; shift=0Adst=3D$1; shift=0Aobj=3D$1; shift=0Asym=
=3D$1; shift=0A=0Aif [ -n "$sym" ] ; then=0A=0A	readarray A < <(objdump -dr=
 $src/$obj | awk "/>:\$/ { P=3D0; } /$sym(.cold.[[:digit:]]*)*>:\$/ { P=3D1=
; O=3Dstrtonum(\"0x\" \$1); } { if (P) { o=3Dstrtonum(\"0x\" \$1); printf(\=
"%04x \", o-O); print \$0; } }");=0A	readarray B < <(objdump -dr $dst/$obj =
| awk "/>:\$/ { P=3D0; } /$sym(.cold.[[:digit:]]*)*>:\$/ { P=3D1; O=3Dstrto=
num(\"0x\" \$1); } { if (P) { o=3Dstrtonum(\"0x\" \$1); printf(\"%04x \", o=
-O); print \$0; } }");=0A=0A	for ((i=3D0; i<${#A[*]} || i<${#B[*]}; i++));=
=0A	do=0A		if [ "${A[$i]}" =3D "${B[$i]}" ] ; then=0A			sep=3D"|"=0A		else=
=0A			sep=3D"\\"=0A		fi=0A		printf "%-80.80s%c%s %-80.80s\n" "${A[$i]%%[[:s=
pace:]]}" $'\x1d' $sep "${B[$i]%%[[:space:]]}" ;=0A=0A	done | column -t -s$=
'\x1d'=0A	exit;=0Afi=0A=0Aif [ -n "$obj" ] ; then=0A=0A	readelf -Ws $src/$o=
bj | grep -v "\.cold\." | awk '/DEFAULT/ { if ($3 > 0) { print $8 } }' | wh=
ile read sym ;=0A	do=0A		s1=3D$(readelf -Ws $src/$obj | awk "/\<$sym\>/ { s=
+=3D\$3 } END { print s }");=0A		s2=3D$(readelf -Ws $dst/$obj | awk "/\<$sy=
m\>/ { s+=3D\$3 } END { print s }");=0A		if [ "$s1" -ne "$s2" ] ;=0A		then=
=0A			printf "%-50s %10d %10d   %+d\n" $sym $s1 $s2 $(($s2-$s1));=0A		fi;=
=0A	done;=0A	exit;=0Afi=0A=0Afind ${src}/ -name \*.o | grep -v -e piggy\.o =
-e \.tmp_ -e vmlinux\.o | ( while read file ;=0Ado=0A	file=3D${file#${src}/=
};=0A	s1=3D$(readelf -WS $src/$file | grep "AX" | awk '{ s+=3Dstrtonum("0x"=
$6) } END { print s }');=0A	s2=3D$(readelf -WS $dst/$file | grep "AX" | awk=
 '{ s+=3Dstrtonum("0x"$6) } END { print s }');=0A	let S1+=3Ds1;=0A	let S2+=
=3Ds2;=0A	if [ "$s1" -ne "$s2" ] ;=0A	then=0A		diff=3D$(($s2-$s1));=0A		let=
 D+=3Ddiff;=0A		printf "%-50s %10d %10d   %+d\n" $file $s1 $s2 $diff;=0A	fi=
;=0Adone ; printf "%50s %10d %10d   %+d\n" "total" $S1 $S2 $D )=0A=0A
--9Iq5ULCa7nGtWwZS--
