Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DBBC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBD6206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="SF9vd87t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfJKDqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:46:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33299 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJKDqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:46:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so3821571pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 20:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ORx0rqQt8UStlqtrKikOMAgWlRFsyx371vf3MywmV+c=;
        b=SF9vd87tfpQN9MRLOHU/So02An3CEdvQdRQDQi1Adg3Qc2EvV7T24iv84Z/SEQKFN/
         rIXjFuwUBXuS7OkQlm52i8xQiB3W51V6KMKwdedVitP47f4SLBTE0YS9HaXSrlCyIjRG
         zjwMVI2GjwUElmDBLuRKDchHp9RUwhPsth6z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ORx0rqQt8UStlqtrKikOMAgWlRFsyx371vf3MywmV+c=;
        b=JjSYWbk2bBzORrSKQAlbq8fuQtkwhvW1ji5IiKKR4heQlqmPr/4Rq7gwbOZIsX9O3p
         oPvZRC7U4Cb0GNOLgvBklJtVjzyhInuxSBcCdhgE0WyP23XuVCY5UjvdXtKHpQgvPIHQ
         PSZqMRcUngqOu6zfPmvqn1eGnvIlT5LSJkdwtHGtv6g2BifL2cN1/067Jo1RPXJ/2/ng
         fsavEM0CE5D2wn89Vjwy72w1uG4/DICVjOtqsFrWnvRD62swdocPFdcf5/rQUyc8VDBO
         PFKLo9wyTNk2IeK3oYwPElJB0al8wlMn+ecDVKP3xjEfXWQq877OwgrEVljNCmK8hqoG
         w6ag==
X-Gm-Message-State: APjAAAUphygPNf+5odiLGuWIcQ08ZID08Msa9OFtpM7sWdbPAjUl5rH3
        +CZyFA0090ApZTf6X2OiMlRjng==
X-Google-Smtp-Source: APXvYqweceiIUd625HK5ZsT4cwm1g3O9FX7BuFJBPMva85c7gfSryrboYwxmQT/DDcXLF2HyJIuLDw==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr12781851plo.265.1570765565945;
        Thu, 10 Oct 2019 20:46:05 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id w189sm7985769pfw.101.2019.10.10.20.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 20:46:04 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>
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
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
In-Reply-To: <CANpmjNPh656M2-1J6v5AO1eDL-SShjZwa-wvGOfEdKbKCh-ZJw@mail.gmail.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com> <8736gc4j1g.fsf@dja-thinkpad.axtens.net> <CANpmjNPh656M2-1J6v5AO1eDL-SShjZwa-wvGOfEdKbKCh-ZJw@mail.gmail.com>
Date:   Fri, 11 Oct 2019 14:45:59 +1100
Message-ID: <87v9swt05k.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:

> Hi Daniel,
>
> On Tue, 1 Oct 2019 at 16:50, Daniel Axtens <dja@axtens.net> wrote:
>>
>> Hi Marco,
>>
>> > We would like to share a new data-race detector for the Linux kernel:
>> > Kernel Concurrency Sanitizer (KCSAN) --
>> > https://github.com/google/ktsan/wiki/KCSAN  (Details:
>> > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
>>
>> This builds and begins to boot on powerpc, which is fantastic.
>>
>> I'm seeing a lot of reports for locks are changed while being watched by
>> kcsan, so many that it floods the console and stalls the boot.
>>
>> I think, if I've understood correctly, that this is because powerpc
>> doesn't use the queued lock implementation for its spinlock but rather
>> its own assembler locking code. This means the writes aren't
>> instrumented by the compiler, while some reads are. (see
>> __arch_spin_trylock in e.g. arch/powerpc/include/asm/spinlock.h)
>>
>> Would the correct way to deal with this be for the powerpc code to call
>> out to __tsan_readN/__tsan_writeN before invoking the assembler that
>> reads and writes the lock?
>
> This should not be the issue, because with KCSAN, not instrumenting
> something does not lead to false positives. If two accesses are
> involved in a race, and neither of them are instrumented, KCSAN will
> not report a race; if however, 1 of them is instrumented (and the
> uninstrumented access is a write), KCSAN will infer a race due to the
> data value changed ("race at unknown origin").
>
> Rather, if there is spinlock code causing data-races, then there are 2 options:
> 1) Actually missing READ_ONCE/WRITE_ONCE somewhere.
> 2) You need to disable instrumentation for an entire function with
> __no_sanitize_thread or __no_kcsan_or_inline (for inline functions).
> This should only be needed for arch-specific code (e.g. see the
> changes we made to arch/x86).

Thanks, that was what I needed. I can now get it to boot Ubuntu on
ppc64le. Still hitting a lot of things, but we'll poke and prod it a bit
internally and let you know how we get on!

Regards,
Daniel

>
> Note: you can explicitly add instrumentation to uninstrumented
> accesses with the API in <linux/kcsan-checks.h>, but this shouldn't be
> the issue here.
>
> It would be good to symbolize the stack-traces, as otherwise it's hard
> to say exactly what needs to be done.
>
> Best,
> -- Marco
>
>> Regards,
>> Daniel
>>
>>
>> [   24.612864] ==================================================================
>> [   24.614188] BUG: KCSAN: racing read in __spin_yield+0xa8/0x180
>> [   24.614669]
>> [   24.614799] race at unknown origin, with read to 0xc00000003fff9d00 of 4 bytes by task 449 on cpu 11:
>> [   24.616024]  __spin_yield+0xa8/0x180
>> [   24.616377]  _raw_spin_lock_irqsave+0x1a8/0x1b0
>> [   24.616850]  release_pages+0x3a0/0x880
>> [   24.617203]  free_pages_and_swap_cache+0x13c/0x220
>> [   24.622548]  tlb_flush_mmu+0x210/0x2f0
>> [   24.622979]  tlb_finish_mmu+0x12c/0x240
>> [   24.623286]  exit_mmap+0x138/0x2c0
>> [   24.623779]  mmput+0xe0/0x330
>> [   24.624504]  do_exit+0x65c/0x1050
>> [   24.624835]  do_group_exit+0xb4/0x210
>> [   24.625458]  __wake_up_parent+0x0/0x80
>> [   24.625985]  system_call+0x5c/0x70
>> [   24.626415]
>> [   24.626651] Reported by Kernel Concurrency Sanitizer on:
>> [   24.628329] CPU: 11 PID: 449 Comm: systemd-bless-b Not tainted 5.3.0-00007-gad29ff6c190d-dirty #9
>> [   24.629508] ==================================================================
>>
>> [   24.672860] ==================================================================
>> [   24.675901] BUG: KCSAN: data-race in _raw_spin_lock_irqsave+0x13c/0x1b0 and _raw_spin_unlock_irqrestore+0x94/0x100
>> [   24.680847]
>> [   24.682743] write to 0xc0000001ffeefe00 of 4 bytes by task 455 on cpu 5:
>> [   24.683402]  _raw_spin_unlock_irqrestore+0x94/0x100
>> [   24.684593]  release_pages+0x250/0x880
>> [   24.685148]  free_pages_and_swap_cache+0x13c/0x220
>> [   24.686068]  tlb_flush_mmu+0x210/0x2f0
>> [   24.690190]  tlb_finish_mmu+0x12c/0x240
>> [   24.691082]  exit_mmap+0x138/0x2c0
>> [   24.693216]  mmput+0xe0/0x330
>> [   24.693597]  do_exit+0x65c/0x1050
>> [   24.694170]  do_group_exit+0xb4/0x210
>> [   24.694658]  __wake_up_parent+0x0/0x80
>> [   24.696230]  system_call+0x5c/0x70
>> [   24.700414]
>> [   24.712991] read to 0xc0000001ffeefe00 of 4 bytes by task 454 on cpu 20:
>> [   24.714419]  _raw_spin_lock_irqsave+0x13c/0x1b0
>> [   24.715018]  pagevec_lru_move_fn+0xfc/0x1d0
>> [   24.715527]  __lru_cache_add+0x124/0x1a0
>> [   24.716072]  lru_cache_add+0x30/0x50
>> [   24.716411]  add_to_page_cache_lru+0x134/0x250
>> [   24.717938]  mpage_readpages+0x220/0x3f0
>> [   24.719737]  blkdev_readpages+0x50/0x80
>> [   24.721891]  read_pages+0xb4/0x340
>> [   24.722834]  __do_page_cache_readahead+0x318/0x350
>> [   24.723290]  force_page_cache_readahead+0x150/0x280
>> [   24.724391]  page_cache_sync_readahead+0xe4/0x110
>> [   24.725087]  generic_file_buffered_read+0xa20/0xdf0
>> [   24.727003]  generic_file_read_iter+0x220/0x310
>> [   24.728906]
>> [   24.730044] Reported by Kernel Concurrency Sanitizer on:
>> [   24.732185] CPU: 20 PID: 454 Comm: systemd-gpt-aut Not tainted 5.3.0-00007-gad29ff6c190d-dirty #9
>> [   24.734317] ==================================================================
>>
>>
>> >
>> > Thanks,
>> > -- Marco
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/8736gc4j1g.fsf%40dja-thinkpad.axtens.net.
