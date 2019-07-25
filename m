Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA9C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7369021951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hRRa7+Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfGYRXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:23:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39084 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbfGYRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:23:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so37008356qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i32w2wAVyyehf6wB6Jc3nUiW8Nc61mU3JB3Ii260K3Q=;
        b=hRRa7+Hiq0zE4C78OsxpkAoMIJKzhBqZ4cwAv2BA7VorrW62k4JHhQbuMxYU7J8Eo2
         vUMVYGx1bih9zqUYlT3Ix+cg+FqFyOffi3DEC+9itXAT36G3GXOPQpqLLOytDUwAn04m
         bNtbRaxs8SzEzlIRlAmyOwXj+T6L+wNuUdIVNRkRF2vPnSdYGweDlFcqYpTJ+DuBuwtT
         0xRKF9fYO0uCBHgsTQRHMmLAL4N+KF4d9Omp5R2i7ODpfrjhg2qc7QAiYCBHtTENCJMG
         riSyr2v3CfO9VDGkYzXsQUyBzuBzi59UP+QFfBXdvkFzeU21d472IqGTlbAGvnQIsMwA
         N2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i32w2wAVyyehf6wB6Jc3nUiW8Nc61mU3JB3Ii260K3Q=;
        b=cVQcCl2Mb5NCFrtXp6QAGNU/bCrnmbJcLrFdURuz6YL3mCkunnIuVuBguSqo0JCuzF
         knh7Wj0UAmVobrVMcrP9xq0FJigWlmZQ4jvOtqTcAsKwuIXTpazfRsH5RxDmosGLWBGe
         t8PPncLIqpqdV1Jrw6pn9ARttl8IwtbUNnmmE0fiayJs0Pt5oqp+S7Rw+M/7TtLzuh3T
         eTavdv0uSpw+MyuWy5OuA6rEaai+QmzH2Tzy34zOc5T5xWFhvUjYhJpnilvc66tA0bzm
         miItMJY4/CRc9sT8O+BN22BJ9S2VamoXk3Ti7Cq0nTEDhL1aLtU8cAAL6OJxVR/kE0EM
         Pa5A==
X-Gm-Message-State: APjAAAWOfPNbwNB4RdTl2gM/Dd84f8Bpjb4cNhVfIaPkLaMnphNBETcA
        EWXAyXQwdU3/GPLYsOWjhqkXRQ==
X-Google-Smtp-Source: APXvYqzaX4YBlLyhu1Gab74yJ59I7pm34XggZrLh93dbhUN7fVqo2PZdbgWKSgoDG9BGUW1w5b7ViQ==
X-Received: by 2002:a37:6248:: with SMTP id w69mr59614762qkb.225.1564075382818;
        Thu, 25 Jul 2019 10:23:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e1sm24786827qtb.52.2019.07.25.10.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:23:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqhSH-0001da-Va; Thu, 25 Jul 2019 14:23:01 -0300
Date:   Thu, 25 Jul 2019 14:23:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190725172301.GA6225@ziepe.ca>
References: <20190712085212.3901785-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712085212.3901785-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:51:23AM +0200, Arnd Bergmann wrote:
> The new siw driver fails to build on i386 with
> 
> drivers/infiniband/sw/siw/siw_qp.c:1025:3: error: invalid output size for constraint '+q'
>                 smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
>                 ^
> include/asm-generic/barrier.h:141:35: note: expanded from macro 'smp_store_mb'
>  #define smp_store_mb(var, value)  __smp_store_mb(var, value)
>                                   ^
> arch/x86/include/asm/barrier.h:65:47: note: expanded from macro '__smp_store_mb'
>  #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
>                                               ^
> include/asm-generic/atomic-instrumented.h:1648:2: note: expanded from macro 'xchg'
>         arch_xchg(__ai_ptr, __VA_ARGS__);                               \
>         ^
> arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro 'arch_xchg'
>  #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
>                                 ^
> arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro '__xchg_op'
>                                       : "+q" (__ret), "+m" (*(ptr))     \
>                                               ^
> drivers/infiniband/sw/siw/siw_qp.o: In function `siw_sqe_complete':
> siw_qp.c:(.text+0x1450): undefined reference to `__xchg_wrong_size'
> drivers/infiniband/sw/siw/siw_qp.o: In function `siw_rqe_complete':
> siw_qp.c:(.text+0x15b0): undefined reference to `__xchg_wrong_size'
> drivers/infiniband/sw/siw/siw_verbs.o: In function `siw_req_notify_cq':
> siw_verbs.c:(.text+0x18ff): undefined reference to `__xchg_wrong_size'
> 
> Since smp_store_mb() has to be an atomic store, but the architecture
> can only do this on 32-bit quantities or smaller, but 'cq->notify'
> is a 64-bit word.
> 
> Apparently the smp_store_mb() is paired with a READ_ONCE() here, which
> seems like an odd choice because there is only a barrier on the writer
> side and not the reader, and READ_ONCE() is already not atomic on
> quantities larger than a CPU register.
> 
> I suspect it is sufficient to use the (possibly nonatomic) WRITE_ONCE()
> and an SMP memory barrier here. If it does need to be atomic as well
> as 64-bit quantities, using an atomic64_set_release()/atomic64_read_acquire()
> may be a better choice.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/sw/siw/siw_qp.c    | 4 +++-
>  drivers/infiniband/sw/siw/siw_verbs.c | 5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)

Bernard, please send at patch for whatever solution we settled on
against 5.3-rc1

Thanks,
Jason
