Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038BC2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NA215k6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfD2OY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:24:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32819 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2OY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:24:28 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so9144720iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJheX2gw+9KMrJD2xBE5MCttlIms+dpl+ImUL85n0mw=;
        b=NA215k6SpOJvLtagI77HQNE9qs8K8nioFQqCx1CzdauBGhj9bN1KzSxBUDWZzASXBN
         9MrwmhRf2lpiJAaL7Ogp/LvObfqYBQPulsVQEjAO0dmMhhXNe1/rygHMwsgmwCCIF/e3
         gTflmBTUQ4VG+hYyJ0Br7aQn9Z7xs2eO6wNWkBeP23Nh46PFCpoRS7SB1YsmRvHF3Q3H
         2hOTzEDZ1AIbI2WoowpCTY10VDOATUdwTiX4VyBIYxvp1ChhJI2Jjwc4+rO17q7aW/bL
         acI5csorMnWCssc/BNNLosrxKAIfY9VoJppDxJsibYuVeYQejt00ch6VTh8/DX1+mbuu
         Oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJheX2gw+9KMrJD2xBE5MCttlIms+dpl+ImUL85n0mw=;
        b=XtXq9hGwQcQMeVpV0g561Az+fJMBVrBW2N0QmMQnCP24ya/baUfw+PCFKtHlz4POOH
         XAYpcZ5AAj62Gp+i/CVTUHXoMNycRlUSKoFVLkVJGvBo2i/xt9JdLStjiC+qxft2yq7x
         Uzv1RaeBf7k0kVgZ73hza65O0TrGlLnEfC3Gmt79spjl8ZQyik74FUXL9tPbGzdjwrAk
         bgjF6UBpKXP0+QQOxo/9hzk/PxfmCWTYaqOF27kgIo/k33NifvJLFQnYceLiIBUJsrxm
         VdkCCh0e2z6iAPOLYQwBqhZK5p93kbPZNJjEP++GYhKK3uPh2vlecSbvRsYNmytaBM9L
         RNtg==
X-Gm-Message-State: APjAAAXouHRjd23t+edXkj5AQPJlpY7ulWZv0Bm91ZnpEX7/77gfou/h
        f4Q3QFXoEL8286I49szPbHkvqy2GeWY5RRk6R8kLZQ==
X-Google-Smtp-Source: APXvYqwOspDkpm5R6isboDLipJtFx1vTsDGgFM3K1RslPuNGWI4NokFis05BAMCRfBLAs/m/gydh0ceZ2ro1AFvtIao=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr14985659ioc.271.1556547866987;
 Mon, 29 Apr 2019 07:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <0f7b6576-b8be-4143-91ce-1984945d93ca@googlegroups.com>
In-Reply-To: <0f7b6576-b8be-4143-91ce-1984945d93ca@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 29 Apr 2019 16:24:15 +0200
Message-ID: <CACT4Y+bNjbhW2vEGA_M_FwDEhXe5ntR7b1rHMe3xf5pz0Oth+A@mail.gmail.com>
Subject: Re: How to debug these general protection fault: 0000 [#1] SMP KASAN
 PTI issues ?
To:     JohnD Oracle <johndonoracle@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000b0b28c0587ac0ae0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b0b28c0587ac0ae0
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 26, 2019 at 8:40 PM JohnD Oracle <johndonoracle@gmail.com> wrote:
>
> Hi
>
>
>  I am seeing a number of miss leading information in these reports , and I don't have an adequate understanding how KASAN
> works in order to know to debug it.
>
> For instance;
>
> Lets look at this event :
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
>  general protection fault: 0000 [#1] SMP KASAN PTI
>
> CPU: 0 PID: 2823 Comm: test2 Not tainted 4.14.35.jpd-ksan.01.-syzkaller #22
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>  task: ffff88805ac89780 task.stack: ffff888054920000
> RIP: 0010:vhost_vsock_dev_release+0x10f/0x450 [vhost_vsock]
> RSP: 0018:ffff888054927be8 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 727574616e676973 RCX: 1ffff1100a924f76
> RDX: 0e4eae8c2dcced2e RSI: ffff88805a4a0500 RDI: ffff88807e5e8bb8
> RBP: ffff888054927c38 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffed100a924f3d R11: ffff8880549279ef R12: ffff88807e5e0000
> R13: 00686769685f7265 R14: ffff88807e5e8bc0 R15: ffffffffc04e2a30
> FS:  0000000000000000(0000) GS:ffff88805e400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe5af16c6c8 CR3: 0000000003a0e000 CR4: 00000000000006f0
> Call Trace:
>  ? ima_file_free+0xb6/0x316
>  ? vhost_vsock_dev_open+0x2d0/0x2d0 [vhost_vsock]
> __fput+0x25d/0x775
>   ____fput+0x1a/0x1d
>  task_work_run+0x12e/0x18f
>  do_exit+0x6ee/0x2a5e
>
> Issue number 1 :
>
> The static trace shows vhost_vsock_dev_open() ;   but in reality , we are in a system EXIT call closing open file descriptors because the RIP is:
>
> RIP: 0010:vhost_vsock_dev_release+0x10f
>
> Ok ;  So the stack is dirty with old information, but using GDB, I set a breakpoint at ksan die exception handler that generates the kernel trace message
> that include vhost_vsock_dev_open() :
>
>
> #0  kasan_die_handler (self=0xffffffff83aa8420 <kasan_die_notifier>, val=0x9, data=0xffff888054927a60) at arch/x86/mm/kasan_init_64.c:245
> #1  0xffffffff8120363e in notifier_call_chain (nl=<optimized out>, val=<optimized out>, v=<optimized out>, nr_to_call=0xfffffffb,
>     nr_calls=0x0 <irq_stack_union>) at kernel/notifier.c:93
> #2  0xffffffff81203d2b in __atomic_notifier_call_chain (nr_calls=<optimized out>, nr_to_call=<optimized out>, v=<optimized out>,
>     val=<optimized out>, nh=<optimized out>) at kernel/notifier.c:183
> #3  atomic_notifier_call_chain (v=<optimized out>, val=<optimized out>, nh=<optimized out>) at kernel/notifier.c:193
> #4  notify_die (val=<optimized out>, str=<optimized out>, regs=<optimized out>, err=0x0, trap=0xd, sig=0xb) at kernel/notifier.c:549
> #5  0xffffffff8108997f in do_general_protection (regs=0xffff888054927b38, error_code=0x0) at arch/x86/kernel/traps.c:558
> #6  0xffffffff82e037bc in general_protection () at arch/x86/entry/entry_64.S:1275
> #7  0xffffffffc04e2a30 in vhost_vsock_dev_open (inode=<optimized out>, file=0x0 <irq_stack_union>) at drivers/vhost/vsock.c:526
>
> What am I suppose to believe ?  Are we calling vsock_open()  from the exit  or  vsock_dev_release()   ?
>
>
> What really gets confusing is what the dis-assembling shows around the gdb exception "
>
>   #7  0xffffffffc04e2a30 in vhost_vsock_dev_open (inode=<optimized out>, file=0x0 <irq_stack_union>) at drivers/vhost/vsock.c:526
>
>
> Lets look at   failing instructions around  at vsock_open()  0xffffffffc04e2a30 :
>
>    0xffffffffc04e2a19 <vhost_vsock_dev_open+697>:    callq  0xffffffff816a94c0 <__asan_report_store8_noabort>
>    0xffffffffc04e2a1e <vhost_vsock_dev_open+702>:    jmpq   0xffffffffc04e2848 <vhost_vsock_dev_open+232>
>    0xffffffffc04e2a23 <vhost_vsock_dev_open+707>:    mov    %r12,%rdi
>    0xffffffffc04e2a26 <vhost_vsock_dev_open+710>:    callq  0xffffffff816a94c0 <__asan_report_store8_noabort>
>    0xffffffffc04e2a2b <vhost_vsock_dev_open+715>:    jmpq   0xffffffffc04e286f <vhost_vsock_dev_open+271>
>   0xffffffffc04e2a30 <vhost_vsock_dev_release>:    nopl   0x0(%rax,%rax,1)           <<<<<<<<<<  FAILING  ADDRESS
>
>   How can I be getting a fault on a 5 byte NOP instruction : nopl   0x0(%rax,%rax,1)
>
>   ax is 0xdffffc0000000000;  so it should be a   move register ax to ax.
>
>  I have no idea what the inserted functions :  asan_report_store8_noabort()  are;  They don't appear in the kernel source that I can find.
>
> Lets look at  the RIP from ksan die() :
>
>
> 353    void die(const char *str, struct pt_regs *regs, long err)
> 354    {
> 355        unsigned long flags = oops_begin();
> 356        int sig = SIGSEGV;
> 357
> 358        if (__die(str, regs, err))
> (gdb) p *regs
> $1 = {
>   r15 = 0xffffffffc04e2a30,
>   r14 = 0xffff888053a38bc0,
>   r13 = 0x483a750000002825,
>   r12 = 0xffff888053a30000,
>   bp = 0xffff888056347c38,
>   bx = 0x415c415d5b48c483,
>   r11 = 0xffff8880563479ef,
>   r10 = 0xffffed100ac68f3d,
>   r9 = 0x0,
>   r8 = 0x0,
>   ax = 0xdffffc0000000000,
>   cx = 0x1ffff1100ac68f76,
>   dx = 0x82b882bab691890,
>   si = 0xffff88807eef5b40,
>   di = 0xffff888053a38bb8,
>   orig_ax = 0xffffffffffffffff,
>   ip = 0xffffffffc04e2b3f,
>   cs = 0x10,
>   flags = 0x10206,
>   sp = 0xffff888056347be8,
>   ss = 0x18
> }
>
> the regs.ip  ==   0xffffffffc04e2b3f
>    0xffffffffc04e2b3f <vhost_vsock_dev_release+271>:    cmpb   $0x0,(%rdx,%rax,1)
>    0xffffffffc04e2b43 <vhost_vsock_dev_release+275>:    jne    0xffffffffc04e2e50 <vhost_vsock_dev_release+1056>
> (gdb)
>
>
>
> (gdb) x/2i 0xffffffffc04e2b3f
>    0xffffffffc04e2b3f <vhost_vsock_dev_release+271>:    cmpb   $0x0,(%rdx,%rax,1)
>    0xffffffffc04e2b43 <vhost_vsock_dev_release+275>:    jne    0xffffffffc04e2e50 <vhost_vsock_dev_release+1056>
>
>
> I can believe getting a fault doing a cmpb   (dx,ax )
>
> Is this a complex instruction comparing *dx to *ax ?  the the register contents ?
>
>
> ax =
>
> (gdb) x/2b 0xdffffc0000000000
> 0xdffffc0000000000:    Cannot access memory at address 0xdffffc0000000000
>
> dx =
>
> (gdb) x/2b 0x82b882bab691890
> 0x82b882bab691890:    Cannot access memory at address 0x82b882bab691890
>
>
> Debugging suggestions welcome !
>
> JD
>
> ===
>
>
> Attached is the test case.
your info,

Hi JohnD,

Are you debugging some syzbot-reported bug? Which one? It's useful to
keep this in the same email thread as the report in somebody else will
look at it later (or maybe debugging the same at the same time).
syzkaller-bugs@ is generally not read by anyone and is only CCed in
syzbot reports. We should direct people to syzkaller@ mailing list
everywhere.

Looking at the info, it seems that the crash happens in
vhost_vsock_dev_release and gdb improperly unwinds kernel (maybe you
need a latest gdb or something).
__fput generally calls callbacks that close/release/destroy something.
And it seems that vhost_vsock_dev_release perfectly matches this
definition.
Also "cmpb   $0x0,(%rdx,%rax,1)" looks like KASAN shadow check and is
the instruction where NULL derefs usually caught.
This instruction does "if (*(byte*)(rax + rdx) == 0)". Perhaps you
better turn off CONFIG_KASAN to make debugging simpler. Since it's not
KASAN-detected crash, there is no point enabling KASAN.

--000000000000b0b28c0587ac0ae0
Content-Type: text/x-csrc; charset="US-ASCII"; name="test2.c"
Content-Disposition: attachment; filename="test2.c"
Content-Transfer-Encoding: base64
Content-ID: <f_jv2fp56a0>
X-Attachment-Id: f_jv2fp56a0

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQ0KDQojZGVmaW5lIF9HTlVfU09VUkNFDQoNCiNpbmNsdWRlIDxlbmRpYW4uaD4N
CiNpbmNsdWRlIDxlcnJuby5oPg0KI2luY2x1ZGUgPGZjbnRsLmg+DQojaW5jbHVkZSA8c2NoZWQu
aD4NCiNpbmNsdWRlIDxzdGRhcmcuaD4NCiNpbmNsdWRlIDxzdGRib29sLmg+DQojaW5jbHVkZSA8
c3RkaW50Lmg+DQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNpbmNs
dWRlIDxzdHJpbmcuaD4NCiNpbmNsdWRlIDxzeXMvbW91bnQuaD4NCiNpbmNsdWRlIDxzeXMvcHJj
dGwuaD4NCiNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4NCiNpbmNsdWRlIDxzeXMvc3RhdC5oPg0K
I2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+DQojaW5jbHVkZSA8c3lzL3RpbWUuaD4NCiNpbmNsdWRl
IDxzeXMvdHlwZXMuaD4NCiNpbmNsdWRlIDxzeXMvd2FpdC5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5o
Pg0KDQpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIgKiBmaWxlLA0KICAgICAgICBj
b25zdCBjaGFyICogd2hhdCwgLi4uKSB7DQogICAgICAgIGNoYXIgYnVmWzEwMjRdOw0KICAgICAg
ICB2YV9saXN0IGFyZ3M7DQogICAgICAgIHZhX3N0YXJ0KGFyZ3MsIHdoYXQpOw0KICAgICAgICB2
c25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgd2hhdCwgYXJncyk7DQogICAgICAgIHZhX2VuZChh
cmdzKTsNCiAgICAgICAgYnVmW3NpemVvZihidWYpIC0gMV0gPSAwOw0KICAgICAgICBpbnQgbGVu
ID0gc3RybGVuKGJ1Zik7DQogICAgICAgIGludCBmZCA9IG9wZW4oZmlsZSwgT19XUk9OTFkgfCBP
X0NMT0VYRUMpOw0KICAgICAgICBpZiAoZmQgPT0gLTEpDQogICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KICAgICAgICBpZiAod3JpdGUoZmQsIGJ1ZiwgbGVuKSAhPSBsZW4pIHsNCiAgICAg
ICAgICAgICAgICBpbnQgZXJyID0gZXJybm87DQogICAgICAgICAgICAgICAgY2xvc2UoZmQpOw0K
ICAgICAgICAgICAgICAgIGVycm5vID0gZXJyOw0KICAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCiAgICAgICAgfQ0KICAgICAgICBjbG9zZShmZCk7DQogICAgICAgIHJldHVybiB0cnVlOw0K
fQ0KDQpzdGF0aWMgdm9pZCBzZXR1cF9jb21tb24oKSB7DQogICAgICAgIGlmIChtb3VudCgwLCAi
L3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25zIiwgImZ1c2VjdGwiLCAwLCAwKSkge30NCn0NCg0Kc3Rh
dGljIHZvaWQgbG9vcCgpOw0KDQpzdGF0aWMgdm9pZCBzYW5kYm94X2NvbW1vbigpIHsNCiAgICAg
ICAgcHJjdGwoUFJfU0VUX1BERUFUSFNJRywgU0lHS0lMTCwgMCwgMCwgMCk7DQogICAgICAgIHNl
dHBncnAoKTsNCiAgICAgICAgc2V0c2lkKCk7DQogICAgICAgIHN0cnVjdCBybGltaXQgcmxpbTsN
CiAgICAgICAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAoMjAwIDw8IDIwKTsNCiAg
ICAgICAgc2V0cmxpbWl0KFJMSU1JVF9BUywgJiBybGltKTsNCiAgICAgICAgcmxpbS5ybGltX2N1
ciA9IHJsaW0ucmxpbV9tYXggPSAzMiA8PCAyMDsNCiAgICAgICAgc2V0cmxpbWl0KFJMSU1JVF9N
RU1MT0NLLCAmIHJsaW0pOw0KICAgICAgICBybGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9
IDEzNiA8PCAyMDsNCiAgICAgICAgc2V0cmxpbWl0KFJMSU1JVF9GU0laRSwgJiBybGltKTsNCiAg
ICAgICAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAxIDw8IDIwOw0KICAgICAgICBz
ZXRybGltaXQoUkxJTUlUX1NUQUNLLCAmIHJsaW0pOw0KICAgICAgICBybGltLnJsaW1fY3VyID0g
cmxpbS5ybGltX21heCA9IDA7DQogICAgICAgIHNldHJsaW1pdChSTElNSVRfQ09SRSwgJiBybGlt
KTsNCiAgICAgICAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAyNTY7DQogICAgICAg
IHNldHJsaW1pdChSTElNSVRfTk9GSUxFLCAmIHJsaW0pOw0KICAgICAgICBpZiAodW5zaGFyZShD
TE9ORV9ORVdOUykpIHt9DQogICAgICAgIGlmICh1bnNoYXJlKENMT05FX05FV0lQQykpIHt9DQog
ICAgICAgIGlmICh1bnNoYXJlKDB4MDIwMDAwMDApKSB7fQ0KICAgICAgICBpZiAodW5zaGFyZShD
TE9ORV9ORVdVVFMpKSB7fQ0KICAgICAgICBpZiAodW5zaGFyZShDTE9ORV9TWVNWU0VNKSkge30N
CiAgICAgICAgdHlwZWRlZiBzdHJ1Y3Qgew0KICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKiBu
YW1lOw0KICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKiB2YWx1ZTsNCiAgICAgICAgfQ0KICAg
ICAgICBzeXNjdGxfdDsNCiAgICAgICAgc3RhdGljDQogICAgICAgIGNvbnN0IHN5c2N0bF90IHN5
c2N0bHNbXSA9IHsNCiAgICAgICAgICAgICAgICB7DQogICAgICAgICAgICAgICAgICAgICAgICAi
L3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIjE2Nzc3
MjE2Ig0KICAgICAgICAgICAgICAgIH0sDQogICAgICAgICAgICAgICAgew0KICAgICAgICAgICAg
ICAgICAgICAgICAgIi9wcm9jL3N5cy9rZXJuZWwvc2htYWxsIiwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICI1MzY4NzA5MTIiDQogICAgICAgICAgICAgICAgfSwNCiAgICAgICAgICAgICAgICB7
DQogICAgICAgICAgICAgICAgICAgICAgICAiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tbmkiLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgIjEwMjQiDQogICAgICAgICAgICAgICAgfSwNCiAgICAgICAg
ICAgICAgICB7DQogICAgICAgICAgICAgICAgICAgICAgICAiL3Byb2Mvc3lzL2tlcm5lbC9tc2dt
YXgiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIjgxOTIiDQogICAgICAgICAgICAgICAgfSwN
CiAgICAgICAgICAgICAgICB7DQogICAgICAgICAgICAgICAgICAgICAgICAiL3Byb2Mvc3lzL2tl
cm5lbC9tc2dtbmkiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIjEwMjQiDQogICAgICAgICAg
ICAgICAgfSwNCiAgICAgICAgICAgICAgICB7DQogICAgICAgICAgICAgICAgICAgICAgICAiL3By
b2Mvc3lzL2tlcm5lbC9tc2dtbmIiLA0KICAgICAgICAgICAgICAgICAgICAgICAgIjEwMjQiDQog
ICAgICAgICAgICAgICAgfSwNCiAgICAgICAgICAgICAgICB7DQogICAgICAgICAgICAgICAgICAg
ICAgICAiL3Byb2Mvc3lzL2tlcm5lbC9zZW0iLA0KICAgICAgICAgICAgICAgICAgICAgICAgIjEw
MjQgMTA0ODU3NiA1MDAgMTAyNCINCiAgICAgICAgICAgICAgICB9LA0KICAgICAgICB9Ow0KICAg
ICAgICB1bnNpZ25lZCBpOw0KCXJldHVybjsNCiAgICAgICAgZm9yIChpID0gMDsgaSA8IHNpemVv
ZihzeXNjdGxzKSAvIHNpemVvZihzeXNjdGxzWzBdKTsgaSsrKQ0KICAgICAgICAgICAgICAgIHdy
aXRlX2ZpbGUoc3lzY3Rsc1tpXS5uYW1lLCBzeXNjdGxzW2ldLnZhbHVlKTsNCn0NCg0KaW50IHdh
aXRfZm9yX2xvb3AoaW50IHBpZCkgew0KICAgICAgICBpZiAocGlkIDwgMCkNCiAgICAgICAgICAg
ICAgICBleGl0KDEpOw0KICAgICAgICBpbnQgc3RhdHVzID0gMDsNCiAgICAgICAgd2hpbGUgKHdh
aXRwaWQoLTEsICYgc3RhdHVzLCBfX1dBTEwpICE9IHBpZCkge30NCglwcmludGYoImNoaWxkIGRv
bmVcbiIpOyANCg0KICAgICAgICByZXR1cm4gV0VYSVRTVEFUVVMoc3RhdHVzKTsNCn0NCg0Kc3Rh
dGljIGludCBkb19zYW5kYm94X25vbmUodm9pZCkgew0KICAgICAgICAvL2lmICh1bnNoYXJlKENM
T05FX05FV1BJRCkpIHt9DQogICAgICAgIGludCBwaWQgPSBmb3JrKCk7DQogICAgICAgIGlmIChw
aWQgIT0gMCkNCiAgICAgICAgICAgICAgICByZXR1cm4gd2FpdF9mb3JfbG9vcChwaWQpOw0KCQkv
L3BhdXNlKCk7DQoJLy8gY2hpbGQgY29udGludWVzIGhlcmUNCg0KICAgICAgICBzZXR1cF9jb21t
b24oKTsNCiAgICAgICAgc2FuZGJveF9jb21tb24oKTsNCi8vICAgICAgICBpZiAodW5zaGFyZShD
TE9ORV9ORVdORVQpKSB7fQ0KICAgICAgICBsb29wKCk7DQoJcHJpbnRmKCJjaGlsZCBleGl0aW5n
IFxuIik7IA0KICAgICAgICBleGl0KDEpOw0KfQ0KDQp2b2lkIGxvb3Aodm9pZCkgew0KICAgICAg
ICBtZW1jcHkoKHZvaWQgKiApIDB4MjAwMDAwMDAsICIvZGV2L3Zob3N0LXZzb2NrXDAwMCIsIDE3
KTsNCiAgICAgICAgc3lzY2FsbChfX05SX29wZW5hdCwgMHhmZmZmZmZmZmZmZmZmZjljLCAweDIw
MDAwMDAwLCAyLCAwKTsNCiAgICAgICAgc3lzY2FsbChfX05SX2R1cDIsIC0xLCAtMSk7DQoNCn0N
CmludCBtYWluKHZvaWQpIHsNCiAgICAgICAgc3lzY2FsbChfX05SX21tYXAsIDB4MjAwMDAwMDAs
IDB4MTAwMDAwMCwgMywgMHgzMiwgLTEsIDApOw0KICAgICAgICBkb19zYW5kYm94X25vbmUoKTsN
CiAgICAgICAgcmV0dXJuIDA7DQp9DQoNCg0K
--000000000000b0b28c0587ac0ae0--
