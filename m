Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BB921904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jne7BXuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391912AbfDXRfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391874AbfDXRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so16702895ede.2;
        Wed, 24 Apr 2019 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhpoHmH9PcYpTjBCsGg1mfwgw+1CbGnmdprEyZaStxA=;
        b=jne7BXujXzAXTl3apOZxrfu6xC7HbjkZHCBjPNkQxYQ1ZGNa4cunDdfN6HOqWCXLhi
         XlROIYZfUHxV2U56KNSJXZovZ7bmCGRVM+IcWssvy/rEEdg/caovKcjEtS1GAzaMpsuH
         8xtuT2x6SUVueeiF9Sp3Y31vyc+AB5YNQ2Zv8AVpfqL7QCiBXmU/sWELiRBaneS1qxC7
         MN8ID/1KijEdvFeXsczyoPW2uDkSmejJ2GEFUI2nzb9onCpavxHeAMdazepSg9VehwCS
         7PUed78S13Vijd89aZEZrf0T9G+7LvMI1CyPR9aYM5Vx6U52FdWIzbnf/KzV1gJTssxF
         EYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhpoHmH9PcYpTjBCsGg1mfwgw+1CbGnmdprEyZaStxA=;
        b=XsDUa816dWKvfqU03Q1pJgtUM5PNaCzMGwoNQylLbHbugKLEmcWpWLeGzRtNrccGVk
         2Zgm8Ydy1Lj+VDbnh/Lc2fq+Mjvv4McYsJU6CflAHYVWuzyBYsjhlQjycPZFZErcyKIl
         xdSFuuIQzvOBBev+dEo697smETCBTbijDkw2WjlQh+nd64wSKax9Bxw85/QBk6sKT++P
         9CyY8ATPPwbREhZWzQZeHauZpT3hnMCN4Zyf//icPl69tyHYqsUIxXxJ5Y2EMiElqeNN
         me5HaJmkGw/6q+xFi15vDFINoNcEPHOZe9dxRlfL+FnLt7XHLOUgR0er4GRJkCBCF195
         xkXQ==
X-Gm-Message-State: APjAAAXHBelI2tBuokYyaBCm6lnV7ahFGuSjNrctE7ai2l017szqf2kY
        OBjBARrid0jppxdXnMKTe0k=
X-Google-Smtp-Source: APXvYqyxZgZCAvraPT6EJp2RWAEwdu3e9Jp6ngThgUqfCvFMv+NsacHWaLM/xuQKyVOmhgJ9fgT3yw==
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr12568856eja.58.1556127323368;
        Wed, 24 Apr 2019 10:35:23 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id i41sm4003372ede.36.2019.04.24.10.35.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 10:35:22 -0700 (PDT)
Date:   Wed, 24 Apr 2019 10:35:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3.18 055/104] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190424173520.GA13727@archlinux-i9>
References: <20190424170839.996641496@linuxfoundation.org>
 <20190424170902.623665551@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190424170902.623665551@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

On Wed, Apr 24, 2019 at 07:09:12PM +0200, Greg Kroah-Hartman wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> commit 045afc24124d80c6998d9c770844c67912083506 upstream.
> 
> Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
> explicitly set the return value on the non-faulting path and instead
> leaves it holding the result of the underlying atomic operation. This
> means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
> value will be reported as having failed. Regrettably, I wrote the buggy
> code back in 2011 and it was upstreamed as part of the initial arm64
> support in 2012.
> 
> The reasons we appear to get away with this are:
> 
>   1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
>      exercised by futex() test applications
> 
>   2. If the result of the atomic operation is zero, the system call
>      behaves correctly
> 
>   3. Prior to version 2.25, the only operation used by GLIBC set the
>      futex to zero, and therefore worked as expected. From 2.25 onwards,
>      FUTEX_WAKE_OP is not used by GLIBC at all.
> 
> Fix the implementation by ensuring that the return value is either 0
> to indicate that the atomic operation completed successfully, or -EFAULT
> if we encountered a fault when accessing the user mapping.
> 
> Cc: <stable@kernel.org>
> Fixes: 6170a97460db ("arm64: Atomic operations")
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/arm64/include/asm/futex.h |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/arch/arm64/include/asm/futex.h
> +++ b/arch/arm64/include/asm/futex.h
> @@ -26,8 +26,8 @@
>  	asm volatile(							\
>  "1:	ldxr	%w1, %2\n"						\
>  	insn "\n"							\
> -"2:	stlxr	%w3, %w0, %2\n"						\
> -"	cbnz	%w3, 1b\n"						\
> +"2:	stlxr	%w0, %w3, %2\n"						\
> +"	cbnz	%w0, 1b\n"						\
>  "	dmb	ish\n"							\
>  "3:\n"									\
>  "	.pushsection .fixup,\"ax\"\n"					\
> @@ -50,7 +50,7 @@ futex_atomic_op_inuser(unsigned int enco
>  	int cmp = (encoded_op >> 24) & 15;
>  	int oparg = (int)(encoded_op << 8) >> 20;
>  	int cmparg = (int)(encoded_op << 20) >> 20;
> -	int oldval = 0, ret, tmp;
> +	int oldval, ret, tmp;

Please ensure the follow up fix gets queued up for 3.18 as well
(backport attached).

Thanks,
Nathan

>  
>  	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
>  		oparg = 1U << (oparg & 0x1f);
> @@ -62,23 +62,23 @@ futex_atomic_op_inuser(unsigned int enco
>  
>  	switch (op) {
>  	case FUTEX_OP_SET:
> -		__futex_atomic_op("mov	%w0, %w4",
> +		__futex_atomic_op("mov	%w3, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	case FUTEX_OP_ADD:
> -		__futex_atomic_op("add	%w0, %w1, %w4",
> +		__futex_atomic_op("add	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	case FUTEX_OP_OR:
> -		__futex_atomic_op("orr	%w0, %w1, %w4",
> +		__futex_atomic_op("orr	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	case FUTEX_OP_ANDN:
> -		__futex_atomic_op("and	%w0, %w1, %w4",
> +		__futex_atomic_op("and	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, ~oparg);
>  		break;
>  	case FUTEX_OP_XOR:
> -		__futex_atomic_op("eor	%w0, %w1, %w4",
> +		__futex_atomic_op("eor	%w3, %w1, %w4",
>  				  ret, oldval, uaddr, tmp, oparg);
>  		break;
>  	default:
> 
> 

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-arm64-futex-Restore-oldval-initialization-to-work-ar.patch"

From 334d683655a0a4a68792ab1de6b20f4b559b0fcd Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 17 Apr 2019 00:21:21 -0700
Subject: [PATCH] arm64: futex: Restore oldval initialization to work around
 buggy compilers

commit ff8acf929014b7f87315588e0daf8597c8aa9d1c upstream.

Commit 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with
non-zero result value") removed oldval's zero initialization in
arch_futex_atomic_op_inuser because it is not necessary. Unfortunately,
Android's arm64 GCC 4.9.4 [1] does not agree:

../kernel/futex.c: In function 'do_futex':
../kernel/futex.c:1658:17: warning: 'oldval' may be used uninitialized
in this function [-Wmaybe-uninitialized]
   return oldval == cmparg;
                 ^
In file included from ../kernel/futex.c:73:0:
../arch/arm64/include/asm/futex.h:53:6: note: 'oldval' was declared here
  int oldval, ret, tmp;
      ^

GCC fails to follow that when ret is non-zero, futex_atomic_op_inuser
returns right away, avoiding the uninitialized use that it claims.
Restoring the zero initialization works around this issue.

[1]: https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/

Cc: stable@vger.kernel.org
Fixes: 045afc24124d ("arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/futex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 66bc1ef344f9..f7fda38d7183 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -50,7 +50,7 @@ futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (int)(encoded_op << 8) >> 20;
 	int cmparg = (int)(encoded_op << 20) >> 20;
-	int oldval, ret, tmp;
+	int oldval = 0, ret, tmp;
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1U << (oparg & 0x1f);
-- 
2.21.0


--GvXjxJ+pjyke8COw--
