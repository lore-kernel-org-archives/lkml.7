Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC8C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B242F217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfEVTGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:06:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfEVTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:06:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so1796669pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=O4Lgy1HcDOlUdiimGp2mC8htfWd2dmb5LrsCRVE8Lzs=;
        b=buERZgBAOS+4EGJVVPwlp2VK+PfJBjjrj0+4AbSuY8QsqcC4yVAENdMO3YjkpX2UPk
         8ogT11CkKzmc835M3xrS79j8o4p/ZbvEDa411unVVKBfOcAHDa07hW3DPgsMMdQJtI7d
         rn0FVcwpmsW8RW4I5MCep6SZcoqRI4dUNq9hSeOsY8kqLB5dE+YCUutXSJzTsl43+Q6P
         55geTEyPF3U2MY70fWqt+tp4g68HPfdVsbidFz8Lrk1Lj+5R6TjUvjPCSE4DwT3hQc38
         rUZggXfQKAziSOtc0RhBqfO5D2PXHlEzx8WnkBHwCnDWZC8USTiR/Stqr1KMEIBVYF1C
         eTqw==
X-Gm-Message-State: APjAAAWSiyzluVKNEkYLY/p7n1/qG9CG0U6fH5IfB7a2iYS2jmmX9wC1
        f/1GEJ32GTtMGD73MfWnL8rB63xs/7u7oQ==
X-Google-Smtp-Source: APXvYqx3m27s+HcebvdxF5BSCwSO57+wNPviNkWwWa2QOpfHVB/hCT5TN1uBIIvmgbIo6CL6lv7v7A==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr97781058pfu.4.1558551990575;
        Wed, 22 May 2019 12:06:30 -0700 (PDT)
Received: from localhost (70-35-37-12.static.wiline.com. [70.35.37.12])
        by smtp.gmail.com with ESMTPSA id q4sm29383798pgb.39.2019.05.22.12.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 12:06:29 -0700 (PDT)
Date:   Wed, 22 May 2019 12:06:29 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 11:59:30 PDT (-0700)
Subject:     Re: [PATCH 11/18] locking/atomic: riscv: fix atomic64_sub_if_positive() offset argument
In-Reply-To: <20190522132250.26499-12-mark.rutland@arm.com>
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
Message-ID: <mhng-07aca7a6-5b81-401d-9f0a-438fcd9aef43@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 06:22:43 PDT (-0700), mark.rutland@arm.com wrote:
> Presently the riscv implementation of atomic64_sub_if_positive() takes
> a 32-bit offset value rather than a 64-bit offset value as it should do.
> Thus, if called with a 64-bit offset, the value will be unexpectedly
> truncated to 32 bits.
>
> Fix this by taking the offset as a long rather than an int.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/riscv/include/asm/atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 93826771b616..c9e18289d65c 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -336,7 +336,7 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
>  #define atomic_dec_if_positive(v)	atomic_sub_if_positive(v, 1)
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline long atomic64_sub_if_positive(atomic64_t *v, int offset)
> +static __always_inline long atomic64_sub_if_positive(atomic64_t *v, long offset)
>  {
>         long prev, rc;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
