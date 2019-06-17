Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D9C31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BE22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfFQDJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:09:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35340 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfFQDJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:09:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so3467925plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 20:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oUh6hfLSAJw1NhYrQppNGg6oKv5nxfUTJWLmGY+P1as=;
        b=U5L6Wlos7LggIg1TVyreoxJiIq3d0mjUjaVdRwFpNI4Dh9OS2keNYwYEmv9kXSm/LJ
         JLdw0EEODa8FCVDj0k8b5DfgKJTgkShimjPFAcuFyZ8b8RqrQH3FdeUhRX2e6QLxv+1O
         B4PjRallQM92DHH0CZVu69rf7RhvooMN5Sr2jLAtRiwWpW2S2HxrdMNVeuoxIlECoaXt
         eCTLGZSIGvvbbo7ryENuykI+B+WhbtBSeEa9hy6zYWcn4YZXsKsD0x+RdhXhLcSYUhHa
         JNzTgJJ+tMahVOT4In2BuUfv4C+fIzMyButuYckDR8df1xSwGwKiPW5O9mNXJjbq7s1I
         EgrA==
X-Gm-Message-State: APjAAAWan8ml7rmHf9td7BCmgt1oe5F9RGaUc+6T88ReO3t2akTYeDOL
        UwSNvhh4bT9IBeq0pG2v+P8cQA==
X-Google-Smtp-Source: APXvYqyz7axLzPrBHaIfjrC0NzlkNQ6sUaPo3U0hNhjMZH+KhaZs43iAQFTwcnTHm4QfLzA1fMH9YQ==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4mr12630512plt.152.1560740969406;
        Sun, 16 Jun 2019 20:09:29 -0700 (PDT)
Received: from localhost ([14.215.134.187])
        by smtp.gmail.com with ESMTPSA id q7sm11042023pfb.32.2019.06.16.20.09.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 20:09:28 -0700 (PDT)
Date:   Sun, 16 Jun 2019 20:09:28 -0700 (PDT)
X-Google-Original-Date: Sun, 16 Jun 2019 20:08:25 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Break load reservations during switch_to
In-Reply-To: <20190616175405.GF61734@hippo.sing.id.au>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     joel@sing.id.au
Message-ID: <mhng-778da899-6dc7-4b10-825d-85284990534b@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2019 10:54:06 PDT (-0700), joel@sing.id.au wrote:
> On 19-06-07 15:22:22, Palmer Dabbelt wrote:
>> The comment describes why in detail.  This was found because QEMU never
>> gives up load reservations, the issue is unlikely to manifest on real
>> hardware.
>
> Makes sense, however it obviously will not help until qemu actually
> clears load reservations on SC (or otherwise handles the interleaved
> SC case).

Ya, I wasn't paying close enough attention.  I think this should do it

    diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
    index f6dbbc065e15..001a68ced005 100644
    --- a/target/riscv/insn_trans/trans_rva.inc.c
    +++ b/target/riscv/insn_trans/trans_rva.inc.c
    @@ -69,6 +69,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
         gen_set_gpr(a->rd, dat);
    
         gen_set_label(l2);
    +    tcg_gen_movi_tl(load_res, -1);
         tcg_temp_free(dat);
         tcg_temp_free(src1);
         tcg_temp_free(src2);

I'll send the patch out to the QEMU mailing list.

> See comment inline.
>
>> Thanks to Carlos Eduardo for finding the bug!
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>> Changes since v1 <20190605231735.26581-1-palmer@sifive.com>:
>>
>> * REG_SC is now defined as a helper macro, for any code that wants to SC
>>   a register-sized value.
>> * The explicit #ifdef to check that TASK_THREAD_RA_RA is 0 has been
>>   removed.  Instead we rely on the assembler to catch non-zero SC
>>   offsets.  I've tested this does actually work.
>>
>>  arch/riscv/include/asm/asm.h |  1 +
>>  arch/riscv/kernel/entry.S    | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index 5ad4cb622bed..946b671f996c 100644
>> --- a/arch/riscv/include/asm/asm.h
>> +++ b/arch/riscv/include/asm/asm.h
>> @@ -30,6 +30,7 @@
>>
>>  #define REG_L		__REG_SEL(ld, lw)
>>  #define REG_S		__REG_SEL(sd, sw)
>> +#define REG_SC		__REG_SEL(sc.w, sc.d)
>
> The instructions appear to be inverted here (i.e. "sc.d, sc.w").

Thanks, I'll send a v3.

>>  #define SZREG		__REG_SEL(8, 4)
>>  #define LGREG		__REG_SEL(3, 2)
>>
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 1c1ecc238cfa..af685782af17 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -330,6 +330,17 @@ ENTRY(__switch_to)
>>  	add   a3, a0, a4
>>  	add   a4, a1, a4
>>  	REG_S ra,  TASK_THREAD_RA_RA(a3)
>> +	/*
>> +	 * The Linux ABI allows programs to depend on load reservations being
>> +	 * broken on context switches, but the ISA doesn't require that the
>> +	 * hardware ever breaks a load reservation.  The only way to break a
>> +	 * load reservation is with a store conditional, so we emit one here.
>> +	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
>> +	 * know this will always fail, but just to be on the safe side this
>> +	 * writes the same value that was unconditionally written by the
>> +	 * previous instruction.
>> +	 */
>> +	REG_SC x0, ra, TASK_THREAD_RA_RA(a3)
>>  	REG_S sp,  TASK_THREAD_SP_RA(a3)
>>  	REG_S s0,  TASK_THREAD_S0_RA(a3)
>>  	REG_S s1,  TASK_THREAD_S1_RA(a3)
>> --
>> 2.21.0
>>
