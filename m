Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEEC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CD42146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDCCsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:48:06 -0400
Received: from ozlabs.org ([203.11.71.1]:36643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfDCCsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:48:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Yr984hzQz9sPB;
        Wed,  3 Apr 2019 13:47:56 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
In-Reply-To: <20190325144737.703921-1-arnd@arndb.de>
References: <20190325143521.34928-1-arnd@arndb.de> <20190325144737.703921-1-arnd@arndb.de>
Date:   Wed, 03 Apr 2019 13:47:50 +1100
Message-ID: <87tvff24a1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index b18abb0c3dae..00f5a63c8d9a 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -505,3 +505,7 @@
>  421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
>  422	32	futex_time64			sys_futex			sys_futex
>  423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
> +424	common	pidfd_send_signal		sys_pidfd_send_signal
> +425	common	io_uring_setup			sys_io_uring_setup
> +426	common	io_uring_enter			sys_io_uring_enter
> +427	common	io_uring_register		sys_io_uring_register

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Lightly tested.

The pidfd_test selftest passes.

Ran the io_uring example from fio, which prints lots of:

IOPS=209952, IOS/call=32/32, inflight=117 (117), Cachehit=0.00%
IOPS=209952, IOS/call=32/32, inflight=116 (116), Cachehit=0.00%
IOPS=209920, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=209952, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=209920, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=209952, IOS/call=32/32, inflight=115 (115), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=114 (114), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=113 (113), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=113 (113), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=113 (113), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=112 (112), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=110 (110), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=105 (105), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=104 (104), Cachehit=0.00%
IOPS=210080, IOS/call=32/32, inflight=102 (102), Cachehit=0.00%
IOPS=210112, IOS/call=32/32, inflight=100 (100), Cachehit=0.00%
IOPS=210080, IOS/call=32/32, inflight=97 (97), Cachehit=0.00%
IOPS=210112, IOS/call=32/32, inflight=97 (97), Cachehit=0.00%
IOPS=210112, IOS/call=32/31, inflight=126 (126), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=126 (126), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=125 (125), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=119 (119), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=117 (117), Cachehit=0.00%
IOPS=210016, IOS/call=32/32, inflight=114 (114), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=111 (111), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=108 (108), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=107 (107), Cachehit=0.00%
IOPS=210048, IOS/call=32/32, inflight=105 (105), Cachehit=0.00%

Which is good I think?


cheers
