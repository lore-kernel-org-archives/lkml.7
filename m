Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED43C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703762177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 05:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LUiqLFZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEJFJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 01:09:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40894 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfEJFJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 01:09:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id j12so3222630eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 22:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=7YFWjWc0QaKZ+lncrvFggQa6DhwySB46TZnxGvXwKNI=;
        b=LUiqLFZ+kuuOAwT60WQRPrffJZEVRDoLuUfkR/l+D1w82Nw0wznq0WZeTSN4/dvCPk
         csS0zRiUVUITJ5ZSIyGOpqMl5GIUXR7yQeDZPNbJnr71R5StKq2KaOpJSdUyfva+0KLh
         j6CB3oXpDVurI6/ABOlf8bUh/u1ti9K9Cqp7HmrHyE4/5OiljegzYW+2glinTBw6waZa
         9bdSpbDjcDRXoViXy/zd5eIogSOYz0UiGBsiIhjMDXTU0trvHLKif9IbUBmwsIULC2CY
         OBsMEnj84ZcVj/TFbpMCY9634pj7wlQ76LzE3RwEaP8LIsmh6yQAr0AAXtYagD616Nuc
         zi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=7YFWjWc0QaKZ+lncrvFggQa6DhwySB46TZnxGvXwKNI=;
        b=a2PsxgaZHoMte5X9kxJzAORFTsmvOB65s/2mIFF+1SpuRLw3sOsOGwEAc32IS7dOme
         y5w3bzbIJbzNTUwX5KHPmLd/9nGGJbB3+TSLEart9uGkclliIz8Be/bFIKf7Ip+8BBpr
         yWE04i3wkBmjjZnjCA3Ti1hqj2KG3exVieyG/Wa8RPhzrNLEbYB4YoiSGhDr/6BSDWGo
         sWaITgz2YOD3kwGT+fxOPnMLv9Wdzt+PfXCMugMMgt6CI7pU7HxI1Ye72uqqhsnGHKqv
         bekcWTstU2aJC9eKSCGvBxF3vbxNsHq5gQtVWrsi8jbQLjEuV892/U9WHtraFhiNGUPQ
         utKg==
X-Gm-Message-State: APjAAAVM53Ffe4QYX16FBe0DHDMBRUIEx04rqmjSTQyaVqpOC93jV3lu
        phGNUfbtkacIeBEgIJhxh9uz5Q==
X-Google-Smtp-Source: APXvYqy5kBDj6mSeEA4DEasqTz+yCqU+ZwePS/n45Fo3bWBMmP1lzp5qR9yBwzpVwUoL59HaamUUNg==
X-Received: by 2002:aa7:c402:: with SMTP id j2mr8579354edq.165.1557464970507;
        Thu, 09 May 2019 22:09:30 -0700 (PDT)
Received: from HUAWEI-nova-2-351a175292c.fritz.box ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z32sm1129335edz.85.2019.05.09.22.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 22:09:29 -0700 (PDT)
Date:   Fri, 10 May 2019 07:09:23 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <00000000000062436a05887e2f72@google.com>
References: <00000000000062436a05887e2f72@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: WARNING: locking bug in copy_process
To:     syzbot <syzbot+3286e58549edc479faae@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, arnd@arndb.de, arunks@codeaurora.org,
        cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, jannh@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, luto@kernel.org, mhocko@suse.com,
        mingo@kernel.org, mtk.manpages@gmail.com, namit@vmware.com,
        oleg@redhat.com, peterz@infradead.org, riel@surriel.com,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, wad@chromium.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <DD57141D-7B37-44BB-9A73-2118F5E8AD0D@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 10, 2019 3:07:05 AM GMT+02:00, syzbot <syzbot+3286e58549edc479faae@s=
yzkaller=2Eappspotmail=2Ecom> wrote:
>Hello,
>
>syzbot found the following crash on:
>
>HEAD commit:    a2d635de Merge tag 'drm-next-2019-05-09' of
>git://anongit=2E=2E=2E
>git tree:       upstream
>console output:
>https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D12b36dd0a00000
>kernel config:=20
>https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D2ef407aed78c3758
>dashboard link:
>https://syzkaller=2Eappspot=2Ecom/bug?extid=3D3286e58549edc479faae
>compiler:       gcc (GCC) 9=2E0=2E0 20181231 (experimental)
>userspace arch: i386
>syz repro:    =20
>https://syzkaller=2Eappspot=2Ecom/x/repro=2Esyz?x=3D12d85ec8a00000
>C reproducer: =20
>https://syzkaller=2Eappspot=2Ecom/x/repro=2Ec?x=3D11df8778a00000
>
>The bug was bisected to:
>
>commit b3e5838252665ee4cfa76b82bdf1198dca81e5be
>Author: Christian Brauner <christian@brauner=2Eio>
>Date:   Wed Mar 27 12:04:15 2019 +0000
>
>     clone: add CLONE_PIDFD
>
>bisection log:=20
>https://syzkaller=2Eappspot=2Ecom/x/bisect=2Etxt?x=3D14fe77b4a00000
>final crash:  =20
>https://syzkaller=2Eappspot=2Ecom/x/report=2Etxt?x=3D16fe77b4a00000
>console output:
>https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D12fe77b4a00000
>
>IMPORTANT: if you fix the bug, please add the following tag to the
>commit:
>Reported-by: syzbot+3286e58549edc479faae@syzkaller=2Eappspotmail=2Ecom
>Fixes: b3e583825266 ("clone: add CLONE_PIDFD")
>
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat=2ES:139
>RIP: 0023:0xf7fec849
>Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90
>90 =20
>90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3
>90 =20
>90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
>RSP: 002b:00000000ffed5a8c EFLAGS: 00000246 ORIG_RAX: 0000000000000078
>RAX: ffffffffffffffda RBX: 0000000000003ffc RCX: 0000000000000000
>RDX: 00000000200005c0 RSI: 0000000000000000 RDI: 0000000000000000
>RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>------------[ cut here ]------------
>DEBUG_LOCKS_WARN_ON(depth <=3D 0)
>WARNING: CPU: 1 PID: 7744 at kernel/locking/lockdep=2Ec:4052
>__lock_release =20
>kernel/locking/lockdep=2Ec:4052 [inline]
>WARNING: CPU: 1 PID: 7744 at kernel/locking/lockdep=2Ec:4052 =20
>lock_release+0x667/0xa00 kernel/locking/lockdep=2Ec:4321
>Kernel panic - not syncing: panic_on_warn set =2E=2E=2E
>CPU: 1 PID: 7744 Comm: syz-executor007 Not tainted 5=2E1=2E0+ #4
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>=20
>Google 01/01/2011
>Call Trace:
>  __dump_stack lib/dump_stack=2Ec:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack=2Ec:113
>  panic+0x2cb/0x65c kernel/panic=2Ec:214
>  __warn=2Ecold+0x20/0x45 kernel/panic=2Ec:566
>  report_bug+0x263/0x2b0 lib/bug=2Ec:186
>  fixup_bug arch/x86/kernel/traps=2Ec:179 [inline]
>  fixup_bug arch/x86/kernel/traps=2Ec:174 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps=2Ec:272
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps=2Ec:291
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64=2ES:972
>RIP: 0010:__lock_release kernel/locking/lockdep=2Ec:4052 [inline]
>RIP: 0010:lock_release+0x667/0xa00 kernel/locking/lockdep=2Ec:4321
>Code: 0f 85 a0 03 00 00 8b 35 77 66 08 08 85 f6 75 23 48 c7 c6 a0 55 6b
>87 =20
>48 c7 c7 40 25 6b 87 4c 89 85 70 ff ff ff e8 b7 a9 eb ff <0f> 0b 4c 8b
>85 =20
>70 ff ff ff 4c 89 ea 4c 89 e6 4c 89 c7 e8 52 63 ff
>RSP: 0018:ffff888094117b48 EFLAGS: 00010086
>RAX: 0000000000000000 RBX: 1ffff11012822f6f RCX: 0000000000000000
>RDX: 0000000000000000 RSI: ffffffff815af236 RDI: ffffed1012822f5b
>RBP: ffff888094117c00 R08: ffff888092bfc400 R09: fffffbfff113301d
>R10: fffffbfff113301c R11: ffffffff889980e3 R12: ffffffff8a451df8
>R13: ffffffff8142e71f R14: ffffffff8a44cc80 R15: ffff888094117bd8
>  percpu_up_read=2Econstprop=2E0+0xcb/0x110 include/linux/percpu-rwsem=2E=
h:92
> cgroup_threadgroup_change_end include/linux/cgroup-defs=2Eh:712 [inline]
>  copy_process=2Epart=2E0+0x47ff/0x6710 kernel/fork=2Ec:2222
>  copy_process kernel/fork=2Ec:1772 [inline]
>  _do_fork+0x25d/0xfd0 kernel/fork=2Ec:2338
>  __do_compat_sys_x86_clone arch/x86/ia32/sys_ia32=2Ec:240 [inline]
>  __se_compat_sys_x86_clone arch/x86/ia32/sys_ia32=2Ec:236 [inline]
>  __ia32_compat_sys_x86_clone+0xbc/0x140 arch/x86/ia32/sys_ia32=2Ec:236
>  do_syscall_32_irqs_on arch/x86/entry/common=2Ec:334 [inline]
>  do_fast_syscall_32+0x281/0xd54 arch/x86/entry/common=2Ec:405
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat=2ES:139
>RIP: 0023:0xf7fec849
>Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90
>90 =20
>90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3
>90 =20
>90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
>RSP: 002b:00000000ffed5a8c EFLAGS: 00000246 ORIG_RAX: 0000000000000078
>RAX: ffffffffffffffda RBX: 0000000000003ffc RCX: 0000000000000000
>RDX: 00000000200005c0 RSI: 0000000000000000 RDI: 0000000000000000
>RBP: 0000000000000012 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>Kernel Offset: disabled
>Rebooting in 86400 seconds=2E=2E
>
>
>---
>This bug is generated by a bot=2E It may contain errors=2E
>See https://goo=2Egl/tpsmEJ for more information about syzbot=2E
>syzbot engineers can be reached at syzkaller@googlegroups=2Ecom=2E
>
>syzbot will keep track of this bug report=2E See:
>https://goo=2Egl/tpsmEJ#status for how to communicate with syzbot=2E
>For information about bisection process see:
>https://goo=2Egl/tpsmEJ#bisection
>syzbot can test patches for this bug, for details see:
>https://goo=2Egl/tpsmEJ#testing-patches

I think I know how this comes about=2E
I'll send a patch later today=2E

Christian
