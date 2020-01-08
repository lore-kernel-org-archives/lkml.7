Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5FC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FBE20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8vkeIDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgAHE2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:28:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34853 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgAHE2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:28:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so1579058qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 20:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xEV35H5Dqh41nbBjC6LA8lExynOf4q0m1QB9fZIFwvk=;
        b=s8vkeIDI2rOecpyi7+Ip3HulBQ+kANoSWFRES8MK1a7xTWNjOzlkG8oGeouqqDfnbI
         DoYYpd7nRYjFGpO+CeUmAEiUpEsrVxRER8/H6PWcFRxZqlk6bBfs30Ri50kKgSgXXz12
         PMpHKQG9OxS1XvFY8L8Odpej1lDYPu6CtjKKOnKieiRHe9AsfiFyvD0TEO2GrYgFJk6N
         /Mc9quOhKbD3sZhYT0fTn0VgwhmB5M4OJZh9lcGO5g9UP7bW3I9/vBhPYGUfcei3aQVq
         8+BeFl8cqtKDmiAv4PmniU07Np3aXm6ca1iQSwJZl6WqKEkKG6qYCN3WbuuzPFbtmxK+
         BHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xEV35H5Dqh41nbBjC6LA8lExynOf4q0m1QB9fZIFwvk=;
        b=nBRzeGYYQijuMflsOMzYs+EWII1dz+A0NXzRBpTyB6osu8WvJRjMjQtZzkanadBYQf
         CCXc0ke79VIFS2A+68hAqYYedHv07B+MLsRvazj3LNosOAFBVRKh38gOG647y0u9qpoG
         OhW2iCfzcWZLtc1gB8+yIMozhPvVigMXMTcFepKiM1vMR8LuqmnxjL+u+sQrTsiYtabS
         M/1LeP3+ZN6X8JIiG75wLSKjnaBVvzkhyNPOxF5q85FgkdMS82mh1t4/2nV86EuoMQ7P
         nJN26KbIGNo/QOg04ANui8sWnshH0pEfJ8a/5ufBq2tigRlynDidaf5SAuFWU71S8FGO
         1IhA==
X-Gm-Message-State: APjAAAWAHOhA3DEdBXnN+dh89yyDNJTWdO1oiJBlGVsJ0vN41+SltcDq
        9ZgecPOd23EIENu6viz22i8TOAh6sLqY1lcpN0RpvQ==
X-Google-Smtp-Source: APXvYqyuzmNREIqaW9hmkH89akTPf52o3SCVDabybUtt1K86CDsp5CNd18lQ+eAjfbUeFISDCl7H0tZtyMT8aEkmjk0=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr2533227qkg.43.1578457722834;
 Tue, 07 Jan 2020 20:28:42 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f04e43059b1ee697@google.com> <20200107205302.45yb2rkekz3nat6v@linutronix.de>
In-Reply-To: <20200107205302.45yb2rkekz3nat6v@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Jan 2020 05:28:31 +0100
Message-ID: <CACT4Y+ax6URhDKBREy6XLx=nKFLGSmt87Z-oU3E1D8SAJwBcrg@mail.gmail.com>
Subject: Re: WARNING in switch_fpu_return
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>,
        alexander.deucher@amd.com, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, nicholas.kazlauskas@amd.com,
        Rik van Riel <riel@surriel.com>, sunpeng.li@amd.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>, zhan.liu@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 9:53 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-01-01 18:25:09 [-0800], syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org=
/pu..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17a4ce15e00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ded9d6727093=
40e35
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Df2ca20d4aa140=
8b0385a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > userspace arch: i386
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10cc8971e=
00000
>
> So I tried to reproduce this. syz-prog2c made .c out of the above link.
> It starts with:
> |int main(void)
> | {
> |   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);

Hi Sebastian,

If you want to generate a C repro for 386 arch, you need to add
-arch=3D386 flag to syz-prog2c (then it hopefully should use mmap2).
But FWIW syzbot wasn't able to reproduce it with a C program,
otherwise it would have been provided it. But that may be for various
reasons.

> and segfaults on execution. The problem is that for for 32bit-x86 this
> should be __NR_mmap2 instead. This fixed the mmap() calls however the
> openat() still failed=E2=80=A6 Nothing bad happened in the end since all =
the
> syscalls failed "early".
> As a 64bit binary, it is a different story:
> - On a Intel box the KVM_RUN ioctl() worked and did not return (CTRL-C
>   ended the ioctl() without an error/warning)
> - On a AMD box the KVM_RUN ioctl() triggered a reboot of the kvm guest.
>
> > The bug was bisected to:
> >
> > commit 92e6475ae0a0383b012eb21c1aaf0e5456b1a3d9
> > Author: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Date:   Wed Jul 3 14:02:39 2019 +0000
> >
> >     drm/amd/display: Set enabled to false at start of audio disable
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15614e3e=
e00000
>
> This commit changes a file which is not compiled by the config provided.

I've added a reference here:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018

But I don't know what's the reason for non-deterministic builds yet.
Anyhow it _did_ affect the vmlinux.

> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13614e3ee00=
000
>
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com
> > Fixes: 92e6475ae0a0 ("drm/amd/display: Set enabled to false at start of
> > audio disable")
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 2862 at arch/x86/include/asm/fpu/internal.h:539
> > __fpregs_load_activate arch/x86/include/asm/fpu/internal.h:539 [inline]
> > WARNING: CPU: 0 PID: 2862 at arch/x86/include/asm/fpu/internal.h:539
> > switch_fpu_return+0x437/0x4f0 arch/x86/kernel/fpu/core.c:343
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 2862 Comm: kworker/0:3 Not tainted 5.5.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: events async_pf_execute
> > Call Trace:
> =E2=80=A6
> > ff e8 9d 8d 4a 00 0f 0b e9 18 fd ff ff e8 91 8d
> > RSP: 0018:ffffc90007ecfa80 EFLAGS: 00010293
> > RAX: ffff88809f60e0c0 RBX: ffff88809f60e0c0 RCX: ffffffff812a9ccf
> > RDX: 0000000000000000 RSI: ffffffff812aa047 RDI: 0000000000000005
> > RBP: ffffc90007ecfb10 R08: ffff88809f60e0c0 R09: ffffed1013ec1c19
> > R10: ffffed1013ec1c18 R11: ffff88809f60e0c7 R12: 1ffff92000fd9f51
> > R13: ffff88809f60f5c0 R14: 0000000000200000 R15: ffffc90007ecfae8
> >  kvm_arch_vcpu_load+0x66e/0x950 arch/x86/kvm/x86.c:3463
> >  vcpu_load+0x43/0x90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:201
> >  kvm_unload_vcpu_mmu arch/x86/kvm/x86.c:9543 [inline]
> >  kvm_free_vcpus arch/x86/kvm/x86.c:9558 [inline]
> >  kvm_arch_destroy_vm+0x184/0x5f0 arch/x86/kvm/x86.c:9663
> >  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:816 [inline]
> >  kvm_put_kvm+0x5a5/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:837
> >  async_pf_execute+0x3bf/0x800 arch/x86/kvm/../../../virt/kvm/async_pf.c=
:101
> >  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
> >  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
> >  kthread+0x361/0x430 kernel/kthread.c:255
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
>
> As part of kvm_arch_vcpu_load() switch_fpu_return() is invoked which
> triggers the warning. The problem is that a workqueue should have
> TIF_NEED_FPU_LOAD set. I have no idea how that one got set since it
> should not be set for kernel threads.
>
> Sebastian
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20200107205302.45yb2rkekz3nat6v%40linutronix.de.
