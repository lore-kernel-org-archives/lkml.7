Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF78C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0B42082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687059;
	bh=m4y7ji2wWRK8ea/mMyBcnLJ6QJvebMI62jv8MdTE0GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e13HtHqhx1kfJLEhk5W/NBLGjmWcwXR52+3XM0LeT3rTeoqprDm094rpXoKkrVPRZ
	 N13+4HYZ6esvxyTmqfZPlheVvmC9A5YKDFEIGVqQUdAj8xNly56KN/fD5A7kcUEAbo
	 rKeJDT44xqCwAgd5qRaL2vc8BQcKJNa1P/YTqT2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfCDIK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:10:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44340 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfCDIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:10:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id j3so2514229pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KfOFdOucD1U97CCxvS8TuzZdQ4PD/e84qcQFlpBStSQ=;
        b=uDFuyLc/jJuEQsJtJDTI7zemEl9I/eG6UYZalJfhLuSQ5DshGdoeq466b6LWoJMECx
         BYqdpzIYsFfwOfrRH8eH+y+124e30VvYzxDQojReh73i6lUmzo2w8UQcQV8nWAsJ4uWL
         bHyi1BsMT/ifzLDiQLNRDGzhW6L6kdSuibU0nf7nseiccjUgouqmLvMnFFp9p5+5EKlG
         fp/p9MP5o7xr2VSGqOOb/7kM3sUTcMpm3nYXMNaEzA8OIaizqefA6jPR2XKz74pm1Xk0
         GLiPR9wj9HHWzOdQa6cNOcMJeRS8xU+3uzr49h8OHLw9TXkfxmctm25HPeKNbMyBNbsC
         FhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfOFdOucD1U97CCxvS8TuzZdQ4PD/e84qcQFlpBStSQ=;
        b=Wr1LytE7pnuKs62UADrmBgqWpokTLjrhNvcyjHq3m8GKOw3bcw0+Kd9+STLY9CAavH
         5fXiE3HyC+vYQ4fmo+4X3rw+QjdilShOhkkO629OlZ+inl9Nz5QZrDvEqzE+q7A7QXoY
         77OR2MbF2RK7B6T4h6g/QJA+j8EpBvF6qkMnfQy7W4wyYSV1ND8UQmDRQ8I+PEGODPnK
         6FE/2m4iYpOEbUsgN9W7iNES9TrvLk48L5hpqAUFv7Py/sjShqUABt9C/N4PNRxOPJrB
         awJIAWkZMub0OqQY+O/fRwf/Yg6+O+AecqdQY/pFLmvGckiYSW15TSt7p5ZpDUHWovLW
         AvqQ==
X-Gm-Message-State: APjAAAWaTqh/Ga8TmNtfXXxS5aMrZLu8BXFyUkD2fXad6R4AwyMuPtAQ
        WBsFYyOZcIz0/uqCXn8HREbieFn/
X-Google-Smtp-Source: APXvYqwDFsAjTcs9vGSPjkraJqsPLoeJOoYCdCY4mIoCIxcD8rMUhxhyncf+EZhVgw8gmijRKTGsLw==
X-Received: by 2002:a65:624a:: with SMTP id q10mr17706122pgv.377.1551687056257;
        Mon, 04 Mar 2019 00:10:56 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id d86sm12105717pfm.18.2019.03.04.00.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 00:10:55 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:10:48 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        peterz@infradead.org, riel@surriel.com, mhocko@suse.com,
        ying.huang@intel.com, jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, aarcange@redhat.com,
        raquini@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
Message-ID: <20190304081048.GA98096@google.com>
References: <20190302185144.GD31083@redhat.com>
 <5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3fdf19e2a5be460a384b936f5b56e13733f1b8.1551595137.git.jstancek@redhat.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
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
Reviewed-by: Minchan Kim <minchan@kernel.org>

Isn't it -stable material?

