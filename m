Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E0CC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5185C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="l/VKjl5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfCDITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:19:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33228 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:19:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id z23so2854083lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WmNWNx1ySeryfAiTC7nsxWTTEIzxK5H5BDemAWXAwzo=;
        b=l/VKjl5b23njYyAzEe09qekKA+RlAwEsIYnGsfJn3nNoGpnfcYbol39NQJj7XC9/JU
         JtVDDmbrjadDfawxx2TfqKSTDXfHkwAW8LDG2JGzjoyofIjLTKWGsO7xS8VCqQeQf3iD
         O8WR/kKsYi9HbIr4qLrDxAiXTAAXNXeqw3avrUYKujwT6b1Xwh+pyup/nS6mpla6vKOa
         tXLqPekRpOmVAV60LJckMDfUyipTz9rR7rWzTDnLmFqxFyHq6dHhxeDpnoRLJsTB/4af
         5Be7BlyE+BWCJlcStNCIAmvrR8WDSwFto/QisIW7qQ1WyqlVHodhMC2IegOqe8/VFvg2
         7DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmNWNx1ySeryfAiTC7nsxWTTEIzxK5H5BDemAWXAwzo=;
        b=MbgIFXluMJBNN5/o0FJPLwrnU6ZRQH4gg4SMqPY6Dh2SXb+Nn2hj6i5z9K1eXPlnKl
         nvMcc6Fy357wkQ7V/8Ek/yxHWxliCalh73A+wD7ZSsAggp0nPS7oKu14w5Oh7PPeXUtp
         u8R3BWhWEiN5vY+bB/GOIC9c115ZfSaMJGc3JQQ7v0sdl9hLfXeToWh35VP5LJZWXE95
         jyHcEWCKH7FzwzHsa+YNQoAMEo2Ol6HyX1KLThY5v/zzI0XCm/pDWEPATMIbImfWmdCe
         5u6P+xYbcT/+DjoujvLfIEYBa18iDM1c8jXLrVuLw/mF/LE0/1zI/6MJk5Gq5NELRuIz
         hK/Q==
X-Gm-Message-State: APjAAAXrNJsrOeX2WQC8fqlY5lx9q0+19TNpH+YYC8PtsZhwLs5tY3Ix
        yH8f186kNYhhrs3FlKc3k+zqhbLqJZtEfQ==
X-Google-Smtp-Source: APXvYqw/IVd57815JEYjo5mbLCVARTCNsm8OSH2lJnZkM1s5xEfunSdzCKm0b22DHcHpWA/wjGpcMg==
X-Received: by 2002:a19:ca46:: with SMTP id h6mr8042457lfj.142.1551687561118;
        Mon, 04 Mar 2019 00:19:21 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-159-97-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.97.159])
        by smtp.gmail.com with ESMTPSA id d26sm1389830ljc.15.2019.03.04.00.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:19:20 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 441613007CD; Mon,  4 Mar 2019 11:19:19 +0300 (+03)
Date:   Mon, 4 Mar 2019 11:19:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying.huang@intel.com, jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, aarcange@redhat.com,
        raquini@redhat.com, rientjes@google.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
Message-ID: <20190304081918.rrhyhyze237bpkqf@kshutemo-mobl1>
References: <20190302185144.GD31083@redhat.com>
 <5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 08:28:04AM +0100, Jan Stancek wrote:
> LTP testcase mtest06 [1] can trigger a crash on s390x running 5.0.0-rc8.
> This is a stress test, where one thread mmaps/writes/munmaps memory area
> and other thread is trying to read from it:
> 
>   CPU: 0 PID: 2611 Comm: mmap1 Not tainted 5.0.0-rc8+ #51
>   Hardware name: IBM 2964 N63 400 (z/VM 6.4.0)
>   Krnl PSW : 0404e00180000000 00000000001ac8d8 (__lock_acquire+0x7/0x7a8)
>   Call Trace:
>   ([<0000000000000000>]           (null))
>    [<00000000001adae4>] lock_acquire+0xec/0x258
>    [<000000000080d1ac>] _raw_spin_lock_bh+0x5c/0x98
>    [<000000000012a780>] page_table_free+0x48/0x1a8
>    [<00000000002f6e54>] do_fault+0xdc/0x670
>    [<00000000002fadae>] __handle_mm_fault+0x416/0x5f0
>    [<00000000002fb138>] handle_mm_fault+0x1b0/0x320
>    [<00000000001248cc>] do_dat_exception+0x19c/0x2c8
>    [<000000000080e5ee>] pgm_check_handler+0x19e/0x200
> 
> page_table_free() is called with NULL mm parameter, but because
> "0" is a valid address on s390 (see S390_lowcore), it keeps
> going until it eventually crashes in lockdep's lock_acquire.
> This crash is reproducible at least since 4.14.
> 
> Problem is that "vmf->vma" used in do_fault() can become stale.
> Because mmap_sem may be released, other threads can come in,
> call munmap() and cause "vma" be returned to kmem cache, and
> get zeroed/re-initialized and re-used:
> 
> handle_mm_fault                           |
>   __handle_mm_fault                       |
>     do_fault                              |
>       vma = vmf->vma                      |
>       do_read_fault                       |
>         __do_fault                        |
>           vma->vm_ops->fault(vmf);        |
>             mmap_sem is released          |
>                                           |
>                                           | do_munmap()
>                                           |   remove_vma_list()
>                                           |     remove_vma()
>                                           |       vm_area_free()
>                                           |         # vma is released
>                                           | ...
>                                           | # same vma is allocated
>                                           | # from kmem cache
>                                           | do_mmap()
>                                           |   vm_area_alloc()
>                                           |     memset(vma, 0, ...)
>                                           |
>       pte_free(vma->vm_mm, ...);          |
>         page_table_free                   |
>           spin_lock_bh(&mm->context.lock);|
>             <crash>                       |
> 
> Cache mm_struct to avoid using potentially stale "vma".
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/mtest06/mmap1.c
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
