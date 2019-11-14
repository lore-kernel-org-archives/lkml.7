Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EEC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3052071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTg3pn67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNMmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 07:42:23 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36765 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKNMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:42:22 -0500
Received: by mail-qv1-f68.google.com with SMTP id cv8so2097773qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 04:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSvNU69eXGIrS0rn+BnGRZAf/NJLIPfUZKhpOQfyRVI=;
        b=MTg3pn67VrOJ54TOnSYm4mciISbb0YOv4z8w8Xq+bCP3JTb56dxh1LGU9TLFiq/Sxq
         M+P/Tf0JPkQJ5Ig6OxTzREhmVBPbY9IhyjiAMprsZ/G9DR9jKUPisCVqyS+keQNh9fRy
         kVr9BC5ABgt6lt0k89I3LD+VdfYtMXToG9DjRSsNPg5DuQ4Is96yvyn0EFgR2/4Tj09z
         ibq6JhgHUpovTO8bQ5jpI+30YElELG2dPRn/Q0xkgiA0nKyMLri8vIUTSU+XsdUhnpHz
         nSwG1lyqpu2xvYtSm79g06VXncSWJwvW0hiX0EZ9IGDYBZ2JgxEZlcN2TrSLvUjjy/md
         QLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSvNU69eXGIrS0rn+BnGRZAf/NJLIPfUZKhpOQfyRVI=;
        b=LiaUCv4JXeGeuKClgEUNjK8/qiQTd01g4C4R2rRa4A/Ca3t5nl/rCCTxZUjhoV2qnb
         MdC30J1sYXb27rudPk15uA1sRI3Md5rima/4p+TNVyc3RSvOzWKXrEBZwQ01tEZ4hoXS
         mbtV9ZhYLm96XW4x6dEJONVqbkzG94RaTHbfPef2U/rYgTK1U33Z/pXkpgwe10/9zF06
         GAUaEVnNMU28s7uKAjpMizKo0oRNsvWRRC6zdtFN+x+5faewXcjnVHaDyvhyfrg+w8c4
         GQa1sdzjdkMYJWd58+9CaxeWkBmCpcvDfyH0NlKSUu9n7SB5KOq+EdQjLDzSUBhXOfS2
         8i6A==
X-Gm-Message-State: APjAAAVMQTGFtC9KWs9RyQkq4OPxHmMoTSj7SagmoaPQWyHIIifk7Tqv
        2odMZ6YdZNXvs9WRiL+8A/fd0jc56IORcP3x5iqMrA==
X-Google-Smtp-Source: APXvYqy0BBr5tAnVQrI7gR4TaJgTqGVHcY3E0f9NgZTPYoK/s5f/kj6bdG0QISO9MApg6nPckIMRL+CPEby/KHJWxEk=
X-Received: by 2002:a0c:c125:: with SMTP id f34mr7666929qvh.22.1573735339703;
 Thu, 14 Nov 2019 04:42:19 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ce85705974c50e5@google.com> <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 14 Nov 2019 13:42:07 +0100
Message-ID: <CACT4Y+aBLAWOQn4Mosd2Ymvmpbg9E2Lk7PhuziiL8fzM7LT-6g@mail.gmail.com>
Subject: Re: linux-next boot error: general protection fault in __x64_sys_settimeofday
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, sboyd@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 14 Nov 2019, syzbot wrote:
>
> From the full console output:
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> RIP: 0010:__x64_sys_settimeofday+0x170/0x320
>
> Code: 85 50 ff ff ff 85 c0 0f 85 50 01 00 00 e8 b8 cd 10 00 48 8b 85 48 ff ff ff 48 c1 e8 03 48 89 c2 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f 85 8a 01 00 00 49 8b 74 24 08 bf 40 42 0f 00 48 89
>
>       80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>
> RSP: 0018:ffff888093d0fe58 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 1ffff110127a1fcd RCX: ffffffff8162e915
> RDX: 00000fff820fb94b RSI: ffffffff8162e928 RDI: 0000000000000005
>
> i.e.
>
>      *(0x00000fff820fb94b + 0xdffffc0000000000 * 1) == 0
>
>      *(0xe0000bff820fb94b) == 0
>
> So base == 0x00000fff820fb94b and index == 0xdffffc0000000000 and scale =
> 1. As scale is 1, base and index might be swapped, but that still does not
> make any sense.
>
> 0xdffffc0000000000 is explicitely loaded into RAX according to the
> disassembly, but I can't find the corresponding source as this is in the
> middle of the function prologue and looks KASAN related.
>
> RBP: ffff888093d0ff10 R08: ffff8880a8904380 R09: ffff8880a8904c18
> R10: fffffbfff1390d30 R11: ffffffff89c86987 R12: 00007ffc107dca50
> R13: ffff888093d0fee8 R14: 00007ffc107dca10 R15: 0000000000087a85
> FS:  00007f614c01b700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4440cdf000 CR3: 00000000a5236000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ? do_sys_settimeofday64+0x250/0x250
>  ? trace_hardirqs_on_thunk+0x1a/0x1c
>  ? do_syscall_64+0x26/0x760
>  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  ? do_syscall_64+0x26/0x760
>  ? lockdep_hardirqs_on+0x421/0x5e0
>  ? trace_hardirqs_on+0x67/0x240
>  do_syscall_64+0xfa/0x760
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The below is the user code which triggered that:
>
> RIP: 0033:0x7f614bb16047
>
> Code: ff ff 73 05 48 83 c4 08 c3 48 8b 0d eb 7d 2e 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb e6 90 90 90 90 90 b8 a4 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 7d 2e 00 31 d2 48 29 c2 64
>
>   23:   b8 a4 00 00 00          mov    $0xa4,%eax
>   28:   0f 05                   syscall
>   2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
>   30:   73 01                   jae    0x33
>   32:   c3                      retq
>
> RSP: 002b:00007ffc107dc978 EFLAGS: 00000206 ORIG_RAX: 00000000000000a4
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f614bb16047
> RDX: 000000005dcd1ee0 RSI: 00007ffc107dca10 RDI: 00007ffc107dca50
> RBP: 0000000000000000 R08: 00007ffc107e6080 R09: 0000000000000eca
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> So RAX is obviously the syscall number and the arguments are in RDI (tv()
> and RSI (tz), which both look like legit user space addresses.
>
> As this is deep in the function prologue compiler/KASAN people might want
> to have a look at that.

Looks like a plain user memory access:

SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
struct timezone __user *, tz)
{
....
if (tv->tv_usec > USEC_PER_SEC)  // <==== HERE
return -EINVAL;

Urgently need +Jann's patch to better explain these things!
