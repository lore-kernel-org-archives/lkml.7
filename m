Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD09C49EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6F320869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbfKEJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:49:33 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfKEJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:49:32 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MIdW9-1ifzot1d2b-00EZnF; Tue, 05 Nov 2019 10:49:30 +0100
Received: by mail-qt1-f178.google.com with SMTP id y10so21686113qto.3;
        Tue, 05 Nov 2019 01:49:30 -0800 (PST)
X-Gm-Message-State: APjAAAX5p8P40NOt8QqDGEKe3E6nJDegIQ+l1SsF0Rr4Ive1Abp4HpYc
        GdBo1YEnNaQoqQPdn/zER2dTNe+TD3IfRAuBEIk=
X-Google-Smtp-Source: APXvYqytk+YB723AlNICh0uVf4aP5i8XhgFrqWRnmq2L7GwuzVAxLKqOc22bK/LZTeykspfSzf0ix8jfskNYoVoVBiQ=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr26382158qvi.222.1572947369108;
 Tue, 05 Nov 2019 01:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20191105022928.517526-1-farnasirim@gmail.com> <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911051033050.17054@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Nov 2019 10:49:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0wyw=CwhiU34t1zBiSesf+HGBLeaV+=JVko_TjnvATHQ@mail.gmail.com>
Message-ID: <CAK8P3a0wyw=CwhiU34t1zBiSesf+HGBLeaV+=JVko_TjnvATHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] syscalls: Fix references to filenames containing
 syscall defs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mohammad Nasirifar <far.nasiri.m@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mohammad Nasirifar <farnasirim@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QOfOLv/wLwxEQEaF/X9MWNmB1DyCznud2OQ3THP6bAu6BBa60/c
 cDd750ixWXDTXPTtRdTyufI2s0MpRHzJEOvlvIfWC4/dycKY4WzLF7YDXYVrxv8M2TWlzSc
 74HCr0aciyCS4p8x5dOEVKwybwO2Wy5TiL853dDTu01xtOnPK42+kAwZtg3s/JXN3nv5aFl
 6/5WMJ/6STqxkTsT5fmpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dIZOkZD2JWU=:WidfBCXffH/su35/Y5hSA8
 npF/Nh9OupAcaij6tos8lEpr12kT1le+68SSTY5bHz2Xc6V7Wwe/08swyoBXzwn0C/5a9942+
 LZMmeQKRjy5R0sd1BTSzQ4zvfq6E+X+TaFV2HgaKuV07FdcLoUPR0J/zk6pjerNyo+IIrkvKK
 SaR50GA5EHotsDqEbNrX7/MfGEOjqWEVSgjuW3MF/WebGAu8qSnEbmbuMZ8cRpK2fjl+KmIE0
 N+k55qMsiJeL/cPD5PPZsMj6rgUwZHeYxmSZcWrX2JtcAAHT7FUpYXwknArbe8unZoe7PTA5E
 cmtXYa4B4Q+ZeAY6NBUWoBvTJMv4Ijvy9e42nEwu+CT8an5YLvzXFn8WyO8Oc48HtNUETRgOU
 UXl/MSnf4DzOJuG0Fr29ZFOyjQsxiS1ennfDnVosvJWvkfcjnte4KfCNbORWN/Ond4s4kkWFs
 2x+HpPkPUk9k5Rs5B9gFOnhA659oMlwZ3+zG7fG/XpMdfbJS/GDkzOknFL+OLAbAayFwnqelT
 RsbwmMjhajD4se/wjIRZkBd6I/mzBb7MRwjmZ1JUklZyUNzYmijJJH2uMG/reTXVja1bzW71i
 IMT2nfED5yL7HLQwHO7zRZLBgrBgB7KzkE8I3MBvnnmlHzEJcH5uT6YP4xURK/g8LQcRNcCN5
 KIauWswKQP5RJUYD7GpNTap0UE0H4eTLT4/yuuPXDUpORh9tdzMZaTcC06ywjuliKqEANenEd
 0X0F/1BahJO/QVKJX+nFX6x6F0HPNg1bUArm8XOxhvsw4Gst079Y1M7znbC53i0ElR4yR6Mri
 tIYATTsc6LjuGc5i5259zYExsA5EB/+962804CxM+asLmzX2i0QMDDrFh3Zj5vMPOBMJM99Mn
 jBuXUjKbgIYs6ht3v+zA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 10:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 4 Nov 2019, Mohammad Nasirifar wrote:
> > Fix stale references to files containing syscall definitions in
> > 'include/linux/syscalls.h' and 'include/uapi/asm-generic/unistd.h',
> > pointing to 'kernel/itimer.c', 'kernel/hrtimer.c', and 'kernel/time.c'.
> > They are now under 'kernel/time'.
> >
> > Also definitions of 'getpid', 'getppid', 'getuid', 'geteuid', 'getgid',
> > 'getegid', 'gettid', and 'sysinfo' are now in 'kernel/sys.c'.
>
> Can we please remove these file references completely. They are going to be
> stale sooner than later again and they really do not provide any value.

+1

Good idea!

In the long run, I'd prefer to have a parsable format that can be used to
generate both the header file and the stubs that we currently provide
using SYSCALL_DEFINEx(), but before that I'd like the remaining two
unistd.h files to be converted to syscall.tbl format (Nitesh is still working
on that).

      Arnd
