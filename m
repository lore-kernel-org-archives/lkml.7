Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D1FC742C7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738321019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562945873;
	bh=PH6b4FwrGMrv9z9RDpSOpBcty9ihP8OMeR1bpqd6mEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kA8eGGcLQEV5S4otK4y9hh0C623wSc3bWlpcDQYaMPsEQVWYD9LHh5NypOaCuWkih
	 re8qzGuSTRhUlPFkEqgKy7huVepQh1VaEFHweo7Nfyqj9uPoGCQ40Q5t/0aG2RV7wd
	 fjcph4/XKIA4QRKu0dqYG1U6XhloxG8MTAb6M6co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGLPhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGLPhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:37:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4FE20863;
        Fri, 12 Jul 2019 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562945871;
        bh=PH6b4FwrGMrv9z9RDpSOpBcty9ihP8OMeR1bpqd6mEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfVv4bKTgQPalAa/KFu4nQKKiH4mCnoSoMFyKsNqliy3LLQDTJPIj40hBDqZeGt79
         Hg2rWJ6NfHY/NlcQFCm24ZJxIIPnN3W9JMZb7fhb5/V5r/Q83HQGp00w7bsTT6SjUq
         fZjcvHBaq+IBbFJbKdu0JABrC1NjuLD9si4ga00Q=
Date:   Fri, 12 Jul 2019 16:37:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v2 2/2] arm64/vdso: fix flip/flop vdso build bug
Message-ID: <20190712153746.5dwwptgrle3z25m7@willie-the-truck>
References: <20190712101556.17833-1-naohiro.aota@wdc.com>
 <20190712101556.17833-2-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712101556.17833-2-naohiro.aota@wdc.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 07:15:56PM +0900, Naohiro Aota wrote:
> Running "make" on an already compiled kernel tree will rebuild the kernel
> even without any modifications:
> 
> $ make ARCH=arm64 CROSS_COMPILE=/usr/bin/aarch64-unknown-linux-gnu-
> arch/arm64/Makefile:58: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
>   VDSOSYM include/generated/vdso-offsets.h
>   CHK     include/generated/compile.h
>   CC      arch/arm64/kernel/signal.o
>   CC      arch/arm64/kernel/vdso.o
>   CC      arch/arm64/kernel/signal32.o
>   LD      arch/arm64/kernel/vdso/vdso.so.dbg
>   OBJCOPY arch/arm64/kernel/vdso/vdso.so
>   AS      arch/arm64/kernel/vdso/vdso.o
>   AR      arch/arm64/kernel/vdso/built-in.a
>   AR      arch/arm64/kernel/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
> 
> This is the same bug fixed in commit 92a4728608a8 ("x86/boot: Fix
> if_changed build flip/flop bug"). We cannot use two "if_changed" in one
> target. Fix this build bug by merging two commands into one function.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  arch/arm64/kernel/vdso/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks. I've merged in Vincenzo's compat change too, so I'll send this at
-rc1 for arm64.

Will
