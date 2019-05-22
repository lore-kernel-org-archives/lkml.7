Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A250220862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfEVTGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:06:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfEVTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:06:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so1526067plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IiQBFDiIpDTK4vEtHw7UORzyjym9e09eBd3i/tm/yiU=;
        b=ernmZSme74BtpT+RiZi8YfThU39jSuSAVfszL6CuI00tGRhP4nbbgGU0CwfwpLkHMx
         2vZXe6I67BW3s/wLOliWu7J12lJ7GgGjFVOVrDkAJ57EGMG6Sct+yMYGkOiTfMNGdEHg
         JWzgyYMwQDGer6RGJtvtL7JZb1Nc7ehY0p5049QbaaplqQBCzkhmqnRyMlJi+JU+ftF9
         H8Oc8+QkT6fLX41LdrhhcH57qojSYXPw8ZCEty6l12ZuasOnqt7Bovok5K7UUgOkyzLW
         DNKjHs51hQ3DVYkyZWHhULS3Kv3uJSJ/VI7tPi3yY+Pj8SmUFwtzs8db1e7gCsve+mOA
         m0Aw==
X-Gm-Message-State: APjAAAVMz1lEUUDqId0tck3mSRMmZoqMTHuVBQKpOKAZyTjqnaNcZwSx
        vUYfHhjKmlmID40Z8vfKTgQophfMDiLlrw==
X-Google-Smtp-Source: APXvYqwKBz/RPFre7Nl+gugncac+cMbC2sf8e2KPiVzG3bEGBrdkEIU1QMb1JtBNvFhsL40yLZIt3A==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr76329800plb.139.1558551991937;
        Wed, 22 May 2019 12:06:31 -0700 (PDT)
Received: from localhost (70-35-37-12.static.wiline.com. [70.35.37.12])
        by smtp.gmail.com with ESMTPSA id v16sm11421710pfc.26.2019.05.22.12.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 12:06:31 -0700 (PDT)
Date:   Wed, 22 May 2019 12:06:31 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 12:06:12 PDT (-0700)
Subject:     Re: [PATCH 12/18] locking/atomic: riscv: use s64 for atomic64
In-Reply-To: <20190522132250.26499-13-mark.rutland@arm.com>
CC:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Will Deacon <will.deacon@arm.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, bp@alien8.de,
        catalin.marinas@arm.com, davem@davemloft.net, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, herbert@gondor.apana.org.au,
        ink@jurassic.park.msu.ru, jhogan@kernel.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@kernel.org,
        mpe@ellerman.id.au, paul.burton@mips.com, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, stable@vger.kernel.org,
        tglx@linutronix.de, tony.luck@intel.com, vgupta@synopsys.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     mark.rutland@arm.com
Message-ID: <mhng-678bd8a3-987b-4564-9885-1a764d1725b8@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 06:22:44 PDT (-0700), mark.rutland@arm.com wrote:
> As a step towards making the atomic64 API use consistent types treewide,
> let's have the s390 atomic64 implementation use s64 as the underlying

and apparently the RISC-V one as well? :)

> type for atomic64_t, rather than long, matching the generated headers.
>
> As atomic64_read() depends on the generic defintion of atomic64_t, this
> still returns long on 64-bit. This will be converted in a subsequent
> patch.
>
> Otherwise, there should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/riscv/include/asm/atomic.h | 44 +++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index c9e18289d65c..bffebc57357d 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -42,11 +42,11 @@ static __always_inline void atomic_set(atomic_t *v, int i)
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC64_INIT(i) { (i) }
> -static __always_inline long atomic64_read(const atomic64_t *v)
> +static __always_inline s64 atomic64_read(const atomic64_t *v)
>  {
>  	return READ_ONCE(v->counter);
>  }
> -static __always_inline void atomic64_set(atomic64_t *v, long i)
> +static __always_inline void atomic64_set(atomic64_t *v, s64 i)
>  {
>  	WRITE_ONCE(v->counter, i);
>  }
> @@ -70,11 +70,11 @@ void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
>
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC_OPS(op, asm_op, I)					\
> -        ATOMIC_OP (op, asm_op, I, w,  int,   )
> +        ATOMIC_OP (op, asm_op, I, w, int,   )
>  #else
>  #define ATOMIC_OPS(op, asm_op, I)					\
> -        ATOMIC_OP (op, asm_op, I, w,  int,   )				\
> -        ATOMIC_OP (op, asm_op, I, d, long, 64)
> +        ATOMIC_OP (op, asm_op, I, w, int,   )				\
> +        ATOMIC_OP (op, asm_op, I, d, s64, 64)
>  #endif
>
>  ATOMIC_OPS(add, add,  i)
> @@ -131,14 +131,14 @@ c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
>
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC_OPS(op, asm_op, c_op, I)					\
> -        ATOMIC_FETCH_OP( op, asm_op,       I, w,  int,   )		\
> -        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w,  int,   )
> +        ATOMIC_FETCH_OP( op, asm_op,       I, w, int,   )		\
> +        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w, int,   )
>  #else
>  #define ATOMIC_OPS(op, asm_op, c_op, I)					\
> -        ATOMIC_FETCH_OP( op, asm_op,       I, w,  int,   )		\
> -        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w,  int,   )		\
> -        ATOMIC_FETCH_OP( op, asm_op,       I, d, long, 64)		\
> -        ATOMIC_OP_RETURN(op, asm_op, c_op, I, d, long, 64)
> +        ATOMIC_FETCH_OP( op, asm_op,       I, w, int,   )		\
> +        ATOMIC_OP_RETURN(op, asm_op, c_op, I, w, int,   )		\
> +        ATOMIC_FETCH_OP( op, asm_op,       I, d, s64, 64)		\
> +        ATOMIC_OP_RETURN(op, asm_op, c_op, I, d, s64, 64)
>  #endif
>
>  ATOMIC_OPS(add, add, +,  i)
> @@ -170,11 +170,11 @@ ATOMIC_OPS(sub, add, +, -i)
>
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC_OPS(op, asm_op, I)					\
> -        ATOMIC_FETCH_OP(op, asm_op, I, w,  int,   )
> +        ATOMIC_FETCH_OP(op, asm_op, I, w, int,   )
>  #else
>  #define ATOMIC_OPS(op, asm_op, I)					\
> -        ATOMIC_FETCH_OP(op, asm_op, I, w,  int,   )			\
> -        ATOMIC_FETCH_OP(op, asm_op, I, d, long, 64)
> +        ATOMIC_FETCH_OP(op, asm_op, I, w, int,   )			\
> +        ATOMIC_FETCH_OP(op, asm_op, I, d, s64, 64)
>  #endif
>
>  ATOMIC_OPS(and, and, i)
> @@ -223,9 +223,10 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  #define atomic_fetch_add_unless atomic_fetch_add_unless
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
> +static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>  {
> -       long prev, rc;
> +       s64 prev;
> +       long rc;
>
>  	__asm__ __volatile__ (
>  		"0:	lr.d     %[p],  %[c]\n"
> @@ -294,11 +295,11 @@ c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
>
>  #ifdef CONFIG_GENERIC_ATOMIC64
>  #define ATOMIC_OPS()							\
> -	ATOMIC_OP( int,   , 4)
> +	ATOMIC_OP(int,   , 4)
>  #else
>  #define ATOMIC_OPS()							\
> -	ATOMIC_OP( int,   , 4)						\
> -	ATOMIC_OP(long, 64, 8)
> +	ATOMIC_OP(int,   , 4)						\
> +	ATOMIC_OP(s64, 64, 8)
>  #endif
>
>  ATOMIC_OPS()
> @@ -336,9 +337,10 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
>  #define atomic_dec_if_positive(v)	atomic_sub_if_positive(v, 1)
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline long atomic64_sub_if_positive(atomic64_t *v, long offset)
> +static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
>  {
> -       long prev, rc;
> +       s64 prev;
> +       long rc;
>
>  	__asm__ __volatile__ (
>  		"0:	lr.d     %[p],  %[c]\n"

Reviwed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
