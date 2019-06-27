Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F3C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C4E2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKmIubhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfF0CeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:34:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38121 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfF0CeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:34:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so4006394wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CcacmaxmL1e/YUUwPn2/wCbF38blh9cZxR5BRaiAOkI=;
        b=jKmIubhVDIfFApIxOe9pM/pfN0PZqYkXfwKI6MGZ8hrr/vpEWsVa4hYyz7ZWLtiTDx
         aIJgymwVq/v7456FA+yDFAwHGiAco+XJSvHC0gS8ASj3Y9mFf5Na3PylaY0p+HqNQ7SI
         dG0cQ6jmQVuxefZhBOxYv1DATzBf2vBB7zHwjwvyK8tBmc+WnriuTf4F9fOHSyQ41YGw
         7tdUJWVq2pVvNR+8/KU6ms43Dp3cieqhLS3CmrTqYuYdItchcza3eLXb+OO2x2ACIlLG
         zGyyEm4rIQPlJFTgSvk/tnK228GrXB9CpBnJsZ12VQgWUE0KBLgSxeINBj1c28b6rLpb
         OUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CcacmaxmL1e/YUUwPn2/wCbF38blh9cZxR5BRaiAOkI=;
        b=X6kkqICiGXt3rY33RDUqEU1tvhjFLUjNsIDvzJBJERQw8G1JC5ZT6TrHIs4siLwyGB
         LgD3FDOC9v+n5GWgAx52rMX1NLVmWT0I4bwcRFfW0XHZjZ91tHjgVKNwhs0PS1afuDzD
         YHNpgSb6yA9sC4zaE2SQy9fmCjaFZBeqC3ZsT7rsHjifcsuqoG2TXrHoMPunucP+LD89
         7qbNecTqNVQqWdx1trOByhwJEovl1GyWzLUPnuaJBEfY5Og8r6kn8Ol3afSFrxMfsVP0
         VlJotmDp5STXIa9YToLi3rN3vTo8JC53jnJ6UFbLDRJ6hPOUtPGPlWPf4o1Svxt7peIS
         fAeg==
X-Gm-Message-State: APjAAAXgqqBqUjzQ9fpy/A9cPrmF1dxYPsw3HKA2+T3KYU/jgravapeP
        Pxr7e31dEkzDQIZ5Fb2JGnWlE5qUTXn04TxTnnfzHLX7
X-Google-Smtp-Source: APXvYqwMRiafQvrjqlI7/a5sHNioLXnrXrQDo349zEx85JdANElWG18u5IY56cgdoshkdp0HBBvFXCtDc6OEZtBmIlA=
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr1105934wmi.122.1561602842670;
 Wed, 26 Jun 2019 19:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACEmhk6g3cJki52+ZUfEwDpYcFtW3nox3u-749JSE7kxMQEvUg@mail.gmail.com>
In-Reply-To: <CACEmhk6g3cJki52+ZUfEwDpYcFtW3nox3u-749JSE7kxMQEvUg@mail.gmail.com>
From:   Jake M <mjake0527@gmail.com>
Date:   Thu, 27 Jun 2019 10:33:51 +0800
Message-ID: <CACEmhk5=MUaKSGzAXr+S4TT7kAF5NsP7HaAHsooVeDsokKgOYg@mail.gmail.com>
Subject: Re: WARNING: kernel stack regs at 0000000068363d2a in telegraf:23122
 has bad 'bp' value 000000007b842ec4
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 at 12:49, Jake M <mjake0527@gmail.com> wrote:
>
> Hi,
>
> The box has crashed twice this week both times related to telegraf, we
> are running ZFS and attached is the kernel config.
>
> Any ideas?
>
> Description: Ubuntu 18.04.2 LTS
> Release: 18.04
> Codename: bionic
> Kernel: 4.18.0-1016-aws
>
> ZFS
> filename:       /lib/modules/4.18.0-1016-aws/updates/dkms/zfs.ko
> version:        0.7.13-1
> license:        CDDL
> author:         OpenZFS on Linux
> description:    ZFS
> alias:          devname:zfs
> alias:          char-major-10-249
> srcversion:     CD1489EAB5842683DC3584F
> depends:        spl,znvpair,zcommon,zunicode,zavl,icp
> retpoline:      Y
> name:           zfs
> vermagic:       4.18.0-1016-aws SMP mod_unload
>
>
> [2311488.107255] PANIC: double fault, error_code: 0x0
> [2311488.109565] CPU: 36 PID: 23122 Comm: telegraf Kdump: loaded
> Tainted: P           OE     4.18.0-1016-aws #18~18.04.1-Ubuntu
> [2311488.109566] Hardware name: Amazon EC2 r5d.12xlarge/, BIOS 1.0 10/16/2017
> [2311488.109573] RIP: 0010:do_async_page_fault+0x5/0x80
> [2311488.109574] Code: 8d b5 78 ff ff ff 48 8d 78 10 e8 96 e6 06 00 eb
> cb e8 1f 16 02 00 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00 00 <55> 48 89 e5 53 65 8b 05 2f 70 1b 57 85 c0 74 37 65 8b 05 e4
> 6f 1b
> [2311488.109602] RSP: 0018:fffffe0000637000 EFLAGS: 00010087
> [2311488.109604] RAX: 00000000a9800a27 RBX: 0000000000000000 RCX:
> ffffffffa9800a27
> [2311488.109605] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> fffffe0000637008
> [2311488.109606] RBP: fffffe0000637009 R08: 0000000000000000 R09:
> 0000000000000000
> [2311488.109607] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [2311488.109608] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [2311488.109610] FS:  00007fa0097fa700(0000) GS:ffff9ef8fb500000(0000)
> knlGS:0000000000000000
> [2311488.109611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [2311488.109612] CR2: fffffe0000636ff8 CR3: 00000056c3de4003 CR4:
> 00000000007606e0
> [2311488.109616] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [2311488.109617] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [2311488.109617] PKRU: 55555554
> [2311488.109618] Call Trace:
> [2311488.109620] Kernel panic - not syncing: Machine halted.
> [2311488.112028] CPU: 36 PID: 23122 Comm: telegraf Kdump: loaded
> Tainted: P           OE     4.18.0-1016-aws #18~18.04.1-Ubuntu
> [2311488.116715] Hardware name: Amazon EC2 r5d.12xlarge/, BIOS 1.0 10/16/2017
> [2311488.119698] Call Trace:
> [2311488.120932]  <#DF>
> [2311488.122003]  dump_stack+0x63/0x85
> [2311488.123641]  panic+0xe4/0x244
> [2311488.125077]  ? async_page_fault+0x1e/0x30
> [2311488.126957]  df_debug+0x2d/0x30
> [2311488.128487]  do_double_fault+0xa1/0x140
> [2311488.130258]  double_fault+0x1e/0x30
> [2311488.131911] RIP: 0010:do_async_page_fault+0x5/0x80
> [2311488.134226] Code: 8d b5 78 ff ff ff 48 8d 78 10 e8 96 e6 06 00 eb
> cb e8 1f 16 02 00 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> 44 00 00 <55> 48 89 e5 53 65 8b 05 2f 70 1b 57 85 c0 74 37 65 8b 05 e4
> 6f 1b
> [2311488.142318] RSP: 0018:fffffe0000637000 EFLAGS: 00010087
> [2311488.144786] RAX: 00000000a9800a27 RBX: 0000000000000000 RCX:
> ffffffffa9800a27
> [2311488.148112] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> fffffe0000637008
> [2311488.152820] RBP: fffffe0000637009 R08: 0000000000000000 R09:
> 0000000000000000
> [2311488.158990] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [2311488.164822] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [2311488.170684]  ? native_iret+0x7/0x7
> [2311488.173652] WARNING: kernel stack regs at 0000000068363d2a in
> telegraf:23122 has bad 'bp' value 000000007b842ec4
> [2311488.173653] unwind stack type:5 next_sp:000000008e5f46ef
> mask:0x20 graph_idx:0
> [2311488.173655] 000000007876cc6b: fffffe0000637e50 (0xfffffe0000637e50)
> [2311488.173657] 0000000076b771fd: ffffffffa8e32793
> (show_trace_log_lvl+0x223/0x3d0)
> [2311488.173660] 000000007707741a: ffffffffa9e97f70 (.LC0+0x530/0x710)
> [2311488.173661] 00000000116bf189: ffffffffa9e980a2 (.LC0+0x662/0x710)
> [2311488.173662] 00000000369b663b: ffff9ef718653c00 (0xffff9ef718653c00)
> [2311488.173663] 00000000f2b9e90d: ffffffffa9800a27 (native_iret+0x7/0x7)
> [2311488.173664] 0000000080f01fd0: 0000000000000000 ...
> [2311488.173664] 0000000006e868c6: 0000000000000020 (0x20)
> [2311488.173665] 00000000467d8117: 0000000000000005 (0x5)
> [2311488.173666] 00000000614fb3b0: fffffe0000637000 (0xfffffe0000637000)
> [2311488.173666] 00000000ce075175: fffffe0000638000 (0xfffffe0000638000)
> [2311488.173667] 00000000f6499015: fffffe0000637000 (0xfffffe0000637000)
> [2311488.173668] 00000000049718e3: 0000000000000005 (0x5)
> [2311488.173668] 00000000381d5adf: fffffe0000637000 (0xfffffe0000637000)
> [2311488.173669] 00000000b719e857: fffffe0000638000 (0xfffffe0000638000)
> [2311488.173669] 00000000d98e04b3: fffffe0000637000 (0xfffffe0000637000)
> [2311488.173670] 00000000b73751f2: 0000000000000020 (0x20)
> [2311488.173671] 00000000c1803216: ffff9ef718653c00 (0xffff9ef718653c00)
> [2311488.173671] 000000005a3cf788: 0000010100000000 (0x10100000000)
> [2311488.173672] 0000000007b64ed7: 0000000000000000 ...
> [2311488.173672] 0000000009d1d5db: fffffe0000637d68 (0xfffffe0000637d68)
> [2311488.173675] 00000000e406678a: ffffffffa8e6d085
> (do_async_page_fault+0x5/0x80)
> [2311488.173675] 000000005c5c1c56: fffffe0000637f58 (0xfffffe0000637f58)
> [2311488.173676] 0000000085febed7: 7d74493d0e5c7e00 (0x7d74493d0e5c7e00)
> [2311488.173676] 000000005e33596d: 0000000000000086 (0x86)
> [2311488.173677] 000000008cba48f1: 0000000000000000 ...
> [2311488.173677] 000000005d67e7dc: fffffe0000637f18 (0xfffffe0000637f18)
> [2311488.173678] 0000000018e5f25d: 00000056c3de4003 (0x56c3de4003)
> [2311488.173678] 000000001d614f09: 0000000000000000 ...
> [2311488.173679] 000000002fdcb7e7: fffffe0000637e60 (0xfffffe0000637e60)
> [2311488.173680] 0000000039750c75: ffffffffa8e32974 (show_stack+0x34/0x50)
> [2311488.173681] 000000006007bd6d: fffffe0000637e80 (0xfffffe0000637e80)
> [2311488.173683] 00000000cc918138: ffffffffa977329e (dump_stack+0x63/0x85)
> [2311488.173684] 0000000085744678: fffffe0000637f00 (0xfffffe0000637f00)
> [2311488.173685] 00000000fe18536c: ffffffffa9ea5422 (.LC0+0x1b2/0x460)
> [2311488.173686] 000000006771ae0a: fffffe0000637f08 (0xfffffe0000637f08)
> [2311488.173688] 000000006c9cf5ba: ffffffffa8e8eb00 (panic+0xe4/0x244)
> [2311488.173689] 00000000e638e3e1: ffff9ef700000008 (0xffff9ef700000008)
> [2311488.173690] 00000000c98ad3ca: fffffe0000637f18 (0xfffffe0000637f18)
> [2311488.173690] 00000000b1340d7a: fffffe0000637eb0 (0xfffffe0000637eb0)
> [2311488.173691] 00000000a4519e0c: 7d74493d0e5c7e00 (0x7d74493d0e5c7e00)
> [2311488.173692] 0000000089fc5351: ffffffffa98010be (async_page_fault+0x1e/0x30)
> [2311488.173693] 000000002e312d25: fffffe0000637e48 (0xfffffe0000637e48)
> [2311488.173693] 00000000e196c719: fffffe0000632000 (0xfffffe0000632000)
> [2311488.173694] 00000000a305c4b8: 0000000000000004 (0x4)
> [2311488.173695] 000000000185ec0d: 0000000000015ba0 (0x15ba0)
> [2311488.173695] 00000000ce241026: 0000000000000004 (0x4)
> [2311488.173696] 00000000c80f9f42: fffffe0000637f58 (0xfffffe0000637f58)
> [2311488.173696] 000000009abeada7: 0000000000000000 ...
> [2311488.173698] 0000000007fdbbd8: ffffffffa9c04f58 (ds.4711+0x2/0x2)
> [2311488.173699] 0000000093e9aced: 00000056c3de4003 (0x56c3de4003)
> [2311488.173699] 000000000e8ee0e7: fffffe0000637f20 (0xfffffe0000637f20)
> [2311488.173700] 00000000a3e660e0: ffffffffa8e6987d (df_debug+0x2d/0x30)
> [2311488.173701] 000000006f6b547c: fffffe0000637f58 (0xfffffe0000637f58)
> [2311488.173702] 000000007768b6d3: fffffe0000637f48 (0xfffffe0000637f48)
> [2311488.173703] 000000001a031e41: ffffffffa8e2f2e1 (do_double_fault+0xa1/0x140)
> [2311488.173704] 000000008ae2ed69: 0000000000000001 (0x1)
> [2311488.173704] 00000000e1c42ebd: 0000000000000000 ...
> [2311488.173705] 00000000771c60dc: fffffe0000637f59 (0xfffffe0000637f59)
> [2311488.173706] 000000001c388f18: ffffffffa9800c4e (double_fault+0x1e/0x30)
> [2311488.173706] 0000000068363d2a: 0000000000000000 ...
> [2311488.173707] 000000006bb2e642: fffffe0000637009 (0xfffffe0000637009)
> [2311488.173707] 00000000ed5081db: 0000000000000000 ...
> [2311488.173708] 0000000079766182: 00000000a9800a27 (0xa9800a27)
> [2311488.173709] 00000000d7e8925c: ffffffffa9800a27 (native_iret+0x7/0x7)
> [2311488.173709] 00000000758c3901: 0000000000000000 ...
> [2311488.173710] 00000000c8cacbb5: fffffe0000637008 (0xfffffe0000637008)
> [2311488.173711] 000000001b02ff67: ffffffffffffffff (0xffffffffffffffff)
> [2311488.173712] 000000003f3101ae: ffffffffa8e6d085
> (do_async_page_fault+0x5/0x80)
> [2311488.173713] 0000000021ccdc1a: 0000000000000010 (0x10)
> [2311488.173713] 000000000f682887: 0000000000010087 (0x10087)
> [2311488.173714] 00000000d7b19537: fffffe0000637000 (0xfffffe0000637000)
> [2311488.173714] 000000001b695c3e: 0000000000000018 (0x18)
> [2311488.173715]  </#DF>


Updates from canonical

1)
We know there's an exception loop, which leads to a stack overflow in
a kernel exception stack, reaching a non-writeable page -- when the
exception happens again, the processor attempts to write that
exception's stack frame in a non-writable memory area (in the process
of calling the exception handler), and it fails, thus a double fault.

2)
Summary from progress so far. It's similarly to the previous
investigation on a double fault.
The exception loop is the page fault handler (in this case,
do_async_page_fault) hitting a page fault itself,
when accessing a per-CPU variable -- these are addressed via the GS
register in Linux kernel,
and the GS-based instruction faults.

Looking at the kdump raw stack for the userspace task reveals that
exception loop,
and shows it stops when crossing a page boundary in the stack --
likely a page fault now to allocate an unused stack page.

Finding a valid stack pointer address and using it to dump the stack
gets us a regular userspace/exception stack.
The stack starts on a futex() FUTEX_WAIT call from telegraf, which
seems normal, but derailed into that exception loop in page table/mm
related functions down that path.

That code is exercised quite frequently, so the question is why this
time it triggered the loop (i.e., apparently messed up GS).

Looking back at the raw stack trace reveals a scheduler assembly call
that's not shown in the regular stack trace, exactly between the point
where the syscall/futex/mm path was still behaving correctly and when
the mm function triggered the first exception of the loop.

3)
* This indeed looks like a messed GS value.

I could reproduce the exception loop in qemu-kvm, checking it with gdb,
with a custom kernel module that sets GS to zero and triggers a page
fault right away.

That triggers the async_page_fault() handler, it calls do_async_page_fault(),
which at the same instruction seen this case, triggers a page fault
due to invalid GS.
(and this repeats indefinitely).
An exception error code of 0 is also observed (same value in kdump and gdb).

It didn't get a stack overflow report nor anything printed in the console,
but it might be due to hypervisor differences.

The value for GS is reported as non-null in the double_fault messages,
however the exception entry path can also swap the value, so maybe
it got re-swapped after being incorrectly swapped, thus printed correctly.

* Question is why GS is incorrectly swapped.

The kernel has a few points that swap the GS value between userspace/kernelspace
if required (it detects whether entry points comes from userspace or
kernelspace),
and those should align and balance perfectly between entry/exit
to/from kernelspace,
otherwise afterwards either userspace (if it uses GS) or kernelspace
(it does) calculates wrong addresses.

The suspicion is there's a particular, rare turn of events that is
leading to this incorrect swap GS.
