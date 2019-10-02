Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1FDC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969A206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f24UR+aS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfJBTnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:43:13 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34048 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJBTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:43:13 -0400
Received: by mail-ot1-f41.google.com with SMTP id m19so258243otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOyld7LsE/8SoNryaMxnr2dK1DwxpSS1XhCCKoKRX5s=;
        b=f24UR+aSzpMXeLqx0osZgzhE2tzHMXUFTCMFxRFU1lWRGdRdkttFtk+Hplm1lvkGDs
         lP6XWbx4cQ6Dx270OuKiROXQgn7743kPGyer7PHnJ/y3mWYycOyEsDzIBAwB+XuKmioX
         5oe1f92A0OihuKyBJrfgn0vc3w6iU+j0nQawjZE6nNieXM+ZbykaL5eOPV87i5QTJmtW
         AL62Ow9gNIen0knALnU/LvLEimugHrYmjnkXRllko9gb5wlvFWADemWfCLhUPAFZZ5s7
         Me+WYBitYQhzphb06KZmg1BfifJpac/h2Zav2UBEXImbN2FrJes47j62EVkC3XqHA24B
         RCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOyld7LsE/8SoNryaMxnr2dK1DwxpSS1XhCCKoKRX5s=;
        b=ltVnIg2lelxe5LisZHWZWzFjBpUiQbBu8D7z3u5MtPXPuaZhXoj4vz9kJ7f7ny8Tty
         MyrVDEfPP6QOpCW6BDJnHD2OVhRFgBp8OF7xjn4iU7hEMYX3oqMt9z+nexx8qVqoqZpF
         4jPfKieW9Jul32CjEn1TGkyvV6BXulcoMSWwJGd6d5agVnPedQ9SpSOECY3j+H/aq18/
         /PuGKViSrnT0arZI/ztOczmO7k0N7KSW+15rghktDBhUqukbLEEYn7QApbczePFmRpBK
         0ZpkMJJSKG74nfb3+IihRweKWFDt9GJj0bCRRNB9Vvii7kZRB373t1DXb069/mc7LDeA
         VSaQ==
X-Gm-Message-State: APjAAAUiuBz8UI0lugLcZOnkJjTFNkin2ntPNgR8vxr9yqK+mjh6SFRs
        jcOUqessHTeTAqimRj6XDrlhvHOYqpxZmLUI4p44WA==
X-Google-Smtp-Source: APXvYqzhQ6DikHL001BsnS/U4E3D7wcZrj8YSoDYojXlK9wHmEiGeUV00vj6OuDsE6Vr6TLoQALWtSFZb+D2woGc9V0=
X-Received: by 2002:a05:6830:101:: with SMTP id i1mr4042375otp.233.1570045390142;
 Wed, 02 Oct 2019 12:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <8736gc4j1g.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <8736gc4j1g.fsf@dja-thinkpad.axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Oct 2019 21:42:58 +0200
Message-ID: <CANpmjNPh656M2-1J6v5AO1eDL-SShjZwa-wvGOfEdKbKCh-ZJw@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, 1 Oct 2019 at 16:50, Daniel Axtens <dja@axtens.net> wrote:
>
> Hi Marco,
>
> > We would like to share a new data-race detector for the Linux kernel:
> > Kernel Concurrency Sanitizer (KCSAN) --
> > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
>
> This builds and begins to boot on powerpc, which is fantastic.
>
> I'm seeing a lot of reports for locks are changed while being watched by
> kcsan, so many that it floods the console and stalls the boot.
>
> I think, if I've understood correctly, that this is because powerpc
> doesn't use the queued lock implementation for its spinlock but rather
> its own assembler locking code. This means the writes aren't
> instrumented by the compiler, while some reads are. (see
> __arch_spin_trylock in e.g. arch/powerpc/include/asm/spinlock.h)
>
> Would the correct way to deal with this be for the powerpc code to call
> out to __tsan_readN/__tsan_writeN before invoking the assembler that
> reads and writes the lock?

This should not be the issue, because with KCSAN, not instrumenting
something does not lead to false positives. If two accesses are
involved in a race, and neither of them are instrumented, KCSAN will
not report a race; if however, 1 of them is instrumented (and the
uninstrumented access is a write), KCSAN will infer a race due to the
data value changed ("race at unknown origin").

Rather, if there is spinlock code causing data-races, then there are 2 options:
1) Actually missing READ_ONCE/WRITE_ONCE somewhere.
2) You need to disable instrumentation for an entire function with
__no_sanitize_thread or __no_kcsan_or_inline (for inline functions).
This should only be needed for arch-specific code (e.g. see the
changes we made to arch/x86).

Note: you can explicitly add instrumentation to uninstrumented
accesses with the API in <linux/kcsan-checks.h>, but this shouldn't be
the issue here.

It would be good to symbolize the stack-traces, as otherwise it's hard
to say exactly what needs to be done.

Best,
-- Marco

> Regards,
> Daniel
>
>
> [   24.612864] ==================================================================
> [   24.614188] BUG: KCSAN: racing read in __spin_yield+0xa8/0x180
> [   24.614669]
> [   24.614799] race at unknown origin, with read to 0xc00000003fff9d00 of 4 bytes by task 449 on cpu 11:
> [   24.616024]  __spin_yield+0xa8/0x180
> [   24.616377]  _raw_spin_lock_irqsave+0x1a8/0x1b0
> [   24.616850]  release_pages+0x3a0/0x880
> [   24.617203]  free_pages_and_swap_cache+0x13c/0x220
> [   24.622548]  tlb_flush_mmu+0x210/0x2f0
> [   24.622979]  tlb_finish_mmu+0x12c/0x240
> [   24.623286]  exit_mmap+0x138/0x2c0
> [   24.623779]  mmput+0xe0/0x330
> [   24.624504]  do_exit+0x65c/0x1050
> [   24.624835]  do_group_exit+0xb4/0x210
> [   24.625458]  __wake_up_parent+0x0/0x80
> [   24.625985]  system_call+0x5c/0x70
> [   24.626415]
> [   24.626651] Reported by Kernel Concurrency Sanitizer on:
> [   24.628329] CPU: 11 PID: 449 Comm: systemd-bless-b Not tainted 5.3.0-00007-gad29ff6c190d-dirty #9
> [   24.629508] ==================================================================
>
> [   24.672860] ==================================================================
> [   24.675901] BUG: KCSAN: data-race in _raw_spin_lock_irqsave+0x13c/0x1b0 and _raw_spin_unlock_irqrestore+0x94/0x100
> [   24.680847]
> [   24.682743] write to 0xc0000001ffeefe00 of 4 bytes by task 455 on cpu 5:
> [   24.683402]  _raw_spin_unlock_irqrestore+0x94/0x100
> [   24.684593]  release_pages+0x250/0x880
> [   24.685148]  free_pages_and_swap_cache+0x13c/0x220
> [   24.686068]  tlb_flush_mmu+0x210/0x2f0
> [   24.690190]  tlb_finish_mmu+0x12c/0x240
> [   24.691082]  exit_mmap+0x138/0x2c0
> [   24.693216]  mmput+0xe0/0x330
> [   24.693597]  do_exit+0x65c/0x1050
> [   24.694170]  do_group_exit+0xb4/0x210
> [   24.694658]  __wake_up_parent+0x0/0x80
> [   24.696230]  system_call+0x5c/0x70
> [   24.700414]
> [   24.712991] read to 0xc0000001ffeefe00 of 4 bytes by task 454 on cpu 20:
> [   24.714419]  _raw_spin_lock_irqsave+0x13c/0x1b0
> [   24.715018]  pagevec_lru_move_fn+0xfc/0x1d0
> [   24.715527]  __lru_cache_add+0x124/0x1a0
> [   24.716072]  lru_cache_add+0x30/0x50
> [   24.716411]  add_to_page_cache_lru+0x134/0x250
> [   24.717938]  mpage_readpages+0x220/0x3f0
> [   24.719737]  blkdev_readpages+0x50/0x80
> [   24.721891]  read_pages+0xb4/0x340
> [   24.722834]  __do_page_cache_readahead+0x318/0x350
> [   24.723290]  force_page_cache_readahead+0x150/0x280
> [   24.724391]  page_cache_sync_readahead+0xe4/0x110
> [   24.725087]  generic_file_buffered_read+0xa20/0xdf0
> [   24.727003]  generic_file_read_iter+0x220/0x310
> [   24.728906]
> [   24.730044] Reported by Kernel Concurrency Sanitizer on:
> [   24.732185] CPU: 20 PID: 454 Comm: systemd-gpt-aut Not tainted 5.3.0-00007-gad29ff6c190d-dirty #9
> [   24.734317] ==================================================================
>
>
> >
> > Thanks,
> > -- Marco
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/8736gc4j1g.fsf%40dja-thinkpad.axtens.net.
