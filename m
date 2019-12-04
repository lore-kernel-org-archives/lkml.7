Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7829BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865920661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOkMzCMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLDGyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:54:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35557 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfLDGyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:54:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id v23so6185637qkg.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 22:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPK31KT4fxLwD0F1AZDz2V/fu+xIHdUgpNu7HrMjbFw=;
        b=BOkMzCMzR5sKMnF42GmwGVTEJc+LOb23dsZlRHel6sRqIWvouhTx3uSjuj56W+eI6i
         WKFjyajdaq7/klhycZJpOZ1C5uY21UsOGiG3SpNpVOEnp0+cjCk+LYKRMS3fgkriAub8
         nlHDa2FMR8/XmMhwk20tOkMU7HMQ5vmevU7ui4yNMQ51MSLv6jRXrtVe2iukGrm6XIBU
         vGbD2kLuak4JrxMh1o/1pLHbGaeWJKVG7AbvqgJWVtMDRZkN1JqlAgO8mU4Ox2Exa1tC
         Mj5rKh2JP3pCY5Jxm8w4XU444Krqs9wk1QO+o+2WiulmzqgHnVKwfLTC/2Na+ibHlTMY
         OeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPK31KT4fxLwD0F1AZDz2V/fu+xIHdUgpNu7HrMjbFw=;
        b=sdwLBcUWQTpjtTi9RKCDbiAYGDRIin35/SDkfUwHJJl9BMdR6ZMaXkxiZ6PoHYdtq/
         i8TLlY2uv2LyGFVLnvEXjxqS1t0N0QqZGFSymhPc8HLMvttIvyQDC07bIDn3ADl9xmRa
         6GsyjekGtme8vaFID1Zxf2l8l8GKeotqFcVauMUSrT21UNagvKbIac/222bfO8NVnhV5
         Gryzau8WZaOPlNPNlZ7i32npg+uj7K60pmnlHmpGqWKg5UaVvp2tSeWjn6PfRpr7vEX3
         HcF07HOJ+GmjSXsLcF6IJL0b5/CHuMOX2+4dIj62kjudMSJSLpnI69Ao4AJuiryBO2NY
         4hhw==
X-Gm-Message-State: APjAAAWRUGSOXFr2sIb4kbQhvCUPTzWp6YItlclOCO5xvi7hNR4SzTlw
        mCmCKS8a+FwIe5mIZMHoC0OnWfx9OtRoSv42OLbAfQ==
X-Google-Smtp-Source: APXvYqyKONKPMM3S6T9nyyBFpC5NnDRt2Bm9tOCUttMMCINdvVilsB2+tf+V3DS0oKZWvWvW5H/afsAEiU8hht6KyQ0=
X-Received: by 2002:a37:9d12:: with SMTP id g18mr1356251qke.43.1575442445437;
 Tue, 03 Dec 2019 22:54:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dd04830598d50133@google.com> <0000000000009574da0598d7ccfa@google.com>
In-Reply-To: <0000000000009574da0598d7ccfa@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Dec 2019 07:53:54 +0100
Message-ID: <CACT4Y+aEzDb2r=wjAD=qWyE=_JCfH8pzdoWCdLQsCmWmahLhaw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tty_open
To:     syzbot <syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com>
Cc:     Gleb Natapov <gleb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gwshan@linux.vnet.ibm.com, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jslaby@suse.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Russell Currey <ruscur@russell.cc>, stewart@linux.vnet.ibm.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 3:45 AM syzbot
<syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
> Author: Russell Currey <ruscur@russell.cc>
> Date:   Mon Feb 8 04:08:20 2016 +0000
>
>      powerpc/powernv: Remove support for p5ioc2
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e5fc32e00000
> start commit:   76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e5fc32e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e5fc32e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
> dashboard link: https://syzkaller.appspot.com/bug?extid=9af6d43c1beabec8fd05
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d15061e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b69aeae00000
>
> Reported-by: syzbot+9af6d43c1beabec8fd05@syzkaller.appspotmail.com
> Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

This should have been detected as "does not affect binary", but there
is something I don't understand/missing:
This is bisected to 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
and it has this parent:
$ git log -n 1 --format="%P" 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95
But the parent was never tested during bisection... how is this possible?
Mentioned this here:
https://github.com/google/syzkaller/issues/1271#issuecomment-561504032
