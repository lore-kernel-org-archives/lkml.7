Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92734C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564C620693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfDOIod convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:44:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:5085 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfDOIoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:44:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 01:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="131454824"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by orsmga007.jf.intel.com with ESMTP; 15 Apr 2019 01:44:28 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.30]) with mapi id 14.03.0415.000;
 Mon, 15 Apr 2019 09:44:27 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1A=
Date:   Mon, 15 Apr 2019 08:44:26 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
In-Reply-To: <20190415072535.GA51449@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWVjMWVmZDUtZmRlMy00ODRhLWI2MjMtY2I4YjBkZmM2ZWQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieUNqTEJ0TStwTVdUNFh5aWRaOFpvTW1qYk9Sa3FZZXpqVW1NQjVyR01SSldrWnhiUTRSVE9hcXN4NExDZFg0MSJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, 

Thank you for your feedback! See my comments below. 

> * Elena Reshetova <elena.reshetova@intel.com> wrote:
> 
> > This is an example of produced assembly code for gcc x86_64:
> >
> > ...
> >   add_random_stack_offset();
> > 0xffffffff810022e9 callq  0xffffffff81459570 <prandom_u32>
> > 0xffffffff810022ee movzbl %al,%eax
> > 0xffffffff810022f1 add    $0x16,%rax
> > 0xffffffff810022f5 and    $0x1f8,%eax
> > 0xffffffff810022fa sub    %rax,%rsp
> > 0xffffffff810022fd lea    0xf(%rsp),%rax
> > 0xffffffff81002302 and    $0xfffffffffffffff0,%rax
> > ...
> 
> Hm, that all to prandom_u32() then does:
> 
> ffffffff8146cd70 <prandom_u32>:
> ffffffff8146cd70:       48 c7 c7 10 e3 01 00    mov    $0x1e310,%rdi
> ffffffff8146cd77:       65 48 03 3d d9 23 ba    add    %gs:0x7eba23d9(%rip),%rdi        #
> f158 <this_cpu_off>
> ffffffff8146cd7e:       7e
> ffffffff8146cd7f:       e8 6c ff ff ff          callq  ffffffff8146ccf0 <prandom_u32_state>
> ffffffff8146cd84:       c3                      retq
> 
> which then does:
> 
> ffffffff8146ccf0 <prandom_u32_state>:
> ffffffff8146ccf0:       8b 0f                   mov    (%rdi),%ecx
> ffffffff8146ccf2:       8b 47 04                mov    0x4(%rdi),%eax
> ffffffff8146ccf5:       44 8b 47 08             mov    0x8(%rdi),%r8d
> ffffffff8146ccf9:       89 ca                   mov    %ecx,%edx
> ffffffff8146ccfb:       8d 34 85 00 00 00 00    lea    0x0(,%rax,4),%esi
> ffffffff8146cd02:       c1 e2 06                shl    $0x6,%edx
> ffffffff8146cd05:       31 f0                   xor    %esi,%eax
> ffffffff8146cd07:       83 e6 e0                and    $0xffffffe0,%esi
> ffffffff8146cd0a:       31 ca                   xor    %ecx,%edx
> ffffffff8146cd0c:       c1 e1 12                shl    $0x12,%ecx
> ffffffff8146cd0f:       81 e1 00 00 f8 ff       and    $0xfff80000,%ecx
> ffffffff8146cd15:       c1 ea 0d                shr    $0xd,%edx
> ffffffff8146cd18:       31 ca                   xor    %ecx,%edx
> ffffffff8146cd1a:       89 c1                   mov    %eax,%ecx
> ffffffff8146cd1c:       44 89 c0                mov    %r8d,%eax
> ffffffff8146cd1f:       c1 e0 0d                shl    $0xd,%eax
> ffffffff8146cd22:       c1 e9 1b                shr    $0x1b,%ecx
> ffffffff8146cd25:       89 17                   mov    %edx,(%rdi)
> ffffffff8146cd27:       44 31 c0                xor    %r8d,%eax
> ffffffff8146cd2a:       41 c1 e0 07             shl    $0x7,%r8d
> ffffffff8146cd2e:       31 f1                   xor    %esi,%ecx
> ffffffff8146cd30:       c1 e8 15                shr    $0x15,%eax
> ffffffff8146cd33:       41 81 e0 00 f8 ff ff    and    $0xfffff800,%r8d
> ffffffff8146cd3a:       89 4f 04                mov    %ecx,0x4(%rdi)
> ffffffff8146cd3d:       41 31 c0                xor    %eax,%r8d
> ffffffff8146cd40:       8b 47 0c                mov    0xc(%rdi),%eax
> ffffffff8146cd43:       44 89 47 08             mov    %r8d,0x8(%rdi)
> ffffffff8146cd47:       8d 34 c5 00 00 00 00    lea    0x0(,%rax,8),%esi
> ffffffff8146cd4e:       31 c6                   xor    %eax,%esi
> ffffffff8146cd50:       c1 e0 0d                shl    $0xd,%eax
> ffffffff8146cd53:       25 00 00 f0 ff          and    $0xfff00000,%eax
> ffffffff8146cd58:       c1 ee 0c                shr    $0xc,%esi
> ffffffff8146cd5b:       31 c6                   xor    %eax,%esi
> ffffffff8146cd5d:       89 d0                   mov    %edx,%eax
> ffffffff8146cd5f:       31 c8                   xor    %ecx,%eax
> ffffffff8146cd61:       89 77 0c                mov    %esi,0xc(%rdi)
> ffffffff8146cd64:       44 31 c0                xor    %r8d,%eax
> ffffffff8146cd67:       31 f0                   xor    %esi,%eax
> ffffffff8146cd69:       c3                      retq
> 
> and just to recover ~5 bits of randomness:

Yes, I agree this is a lot of assembly code and that's why initially I had the
whole thing implemented in asm to control what is being produced, 
but that had its own issues...  

> 
> > As a result of the above gcc-produce code this patch introduces
> > a bit more than 5 bits of randomness after pt_regs location on
> > the thread stack (33 different offsets are generated
> > randomly for x86_64 and 47 for i386).
> > The amount of randomness can be adjusted based on how much of the
> > stack space we wish/can trade for security.
> 
> Note that the reduction in bits is mostly due to:
> 
> > +#define add_random_stack_offset() do {               \
> > +     size_t offset = ((size_t)prandom_u32()) % 256;   \
> > +     char *ptr = __builtin_alloca(offset);            \
> > +     asm volatile("":"=m"(*ptr));                     \
> 
> So if we are really sticking this into the syscall path, could we please
> be a bit more smart about it? Note how we are already masking off bits in
> prandom_u32_state():
> 
> ffffffff8146cd53:       25 00 00 f0 ff          and    $0xfff00000,%eax
> 
> and then we mask *again*, in a rather stupid way:
> 
> > 0xffffffff810022ee movzbl %al,%eax
> > 0xffffffff810022f1 add    $0x16,%rax
> > 0xffffffff810022f5 and    $0x1f8,%eax
> > 0xffffffff810022fa sub    %rax,%rsp
> > 0xffffffff810022fd lea    0xf(%rsp),%rax
> > 0xffffffff81002302 and    $0xfffffffffffffff0,%rax
> 
> What I'd suggest is:
> 
> 1)
> 
> Put the PRNG state not into a per-cpu area which has to be recovered, but
> put it somewhere convenient, already accessibe easily at that point in
> the syscall path - such as struct thread_info? (But don't take my word
> for it - if task_struct is a better place then use that.)
> 
> This avoids the whole percpu redirection.

Hm... but this wouldn't this mean that one can easily probe for PRNG state 
from task or thread_info struct and as a result predict the next randomization
offset for that task? My understanding is that current prandom state that is below
prandom_u32() is shared between tasks and reseeded often enough (every 60 sec),
which makes it hard to predict the next generated random number and the place where
it will get used.  If we now introduce per-task PRNG, how do we manage its state sanely
and securely? It is already per-task, so clear who is the user of it, then state is stored
in task/thread_info, so we know exactly where to probe (if we are able to via arbitrary read or
some other read), and then it is with high odds is used for stack randomization only, so
we can predict all future stack offsets. 

> 
> 2)
> 
> Then also please make a private version of that function which is inlined
> into the straight execution path: this code is going to be executed for
> every single syscall, so inlining is 1000% justified.
> 
> 3)
> 
> Have a really good look at the generated assembly code and justify every
> single instruction, and try to eliminate it. Maybe even take a look at
> whether there's any simpler PRNG that is better suited: if we have per
> thread_info random state then there will be no cross-task leakage of the
> "secret" and we can actually weaken the PRNG.

Not sure about this, see the above. Unless we go back to the original way of just
using rdtsc like I had in the original patch:

pushq %rax
xorq  %rax, %rax
rdtsc
andq  $0xFF0, %rax

And then call this from do_syscall code paths and use alloca for doing the actual offset. 
It would seem to me that it is better to do it this way for security vs. storing the PRNG state in
task/threat_info structs. 

> 
> 4)
> 
> But before you tweak the patch, a more fundamental question:
> 
> Does the stack offset have to be per *syscall execution* randomized?
> Which threats does this protect against that a simpler per task syscall
> random offset wouldn't protect against?

We *really* need it per syscall. If you take a look on the recent stack attacks
[1],[2],[3],[4], they all do some initial probing on syscalls first to discover stack addresses
or leftover data on the stack (or pre-populate stack with some attacker-controlled data), 
and then in the following syscall execute the actual attack (leak data, use
pre-populated data for execution, etc.). If the offset stays the same during 
task life time, it can be easily recovered during this initial probing phase, and
then nothing changes for the attacker. 

[1] Kernel Exploitation Via Uninitialized Stack, 2011
https://www.defcon.org/images/defcon-19/dc-19-presentations/Cook/DEFCON-19-Cook-Kernel-Exploitation.pdf
[2] Stackjacking, 2011, https://jon.oberheide.org/files/stackjacking-infiltrate11.pdf
[3] The Stack is Back, 2012, https://jon.oberheide.org/files/infiltrate12-thestackisback.pdf
[4] Exploiting Recursion in the Linux Kernel, 2016,
https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-kernel_20.html
 
> It would be far, far more performant to just add a fork() time randomized
> kernel stack offset (and that can be a *real* random offset, not PRNG) to
> syscalls. We could even make that an overall default setting if it's fast
> enough, which I think it could be made.
> 
> > Performance (x86_64 measuments only):
> >
> > 1) lmbench: ./lat_syscall -N 1000000 null
> >     base:                                        Simple syscall: 0.1774 microseconds
> >     random_offset (prandom_u32() every syscall): Simple syscall: 0.1822
> microseconds
> >
> > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> >     base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
> >     random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s =
> 166.26 nsec / loop
> 
> Was this measured with CONFIG_PAGE_TABLE_ISOLATION turned off? By the
> time such patches get to real Linux users we'll likely see modern
> processors with Meltdown fixed.

No the above numbers are with CONFIG_PAGE_TABLE_ISOLATION=y for x86_64,
 I will test with CONFIG_PAGE_TABLE_ISOLATION turned off from now on also. 

Best Regards,
Elena.
