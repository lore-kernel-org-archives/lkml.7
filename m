Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B2C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812462084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfGHI0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:26:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35216 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:26:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so8232161ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=H9Jhir71IPIyzQGq+vtRBmdG8XRrnz6d01HWPy/tDXY=;
        b=bVmFwMFE71OX2qrdS1VnIm9/kkZhAfPZOIGOrpOMqk3GybFUH0gHRxBopPOLzxcHdD
         98ZxfYivR+cvk618lP7G9gZM9TYrvteCyBf2cf52UAHryRb+ul7eKqIRQ3jaThSOQeMZ
         E6dnPy14YUDGVhCI1jCzY/zRElCEGJw9m0Rf30sRI/a0DG23QNeuaNO6hDqvvkoiTG4P
         /uJzRdEDpxbC0HF9RiK4rbp3RzCJOk3Xi4ilxKIcoVVCWY2EjAbZXRLkSLDoQngzBUK2
         qxQpLx7ISI/1RK0WyyfDAXY2D1neHAZtTtgHVkCDunYnaabjo36i93VupPSKFlWysbEB
         nLsA==
X-Gm-Message-State: APjAAAWdqRtubFSuBCMYkUeLNUKqfeg2WAlR0f19su1WxoOx/hyf46TZ
        v+TxkSYdoBV5hPIwZ9+5AlVNTw==
X-Google-Smtp-Source: APXvYqxXI/Ygue1Ac50jCKVSmx6Cuo5Nc2NT6pzqbq/Iw8sN98mexSHmndyMkZYR9vs57B/cyO2EhQ==
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr9586901ljg.168.1562574394354;
        Mon, 08 Jul 2019 01:26:34 -0700 (PDT)
Received: from localhost ([134.17.27.127])
        by smtp.gmail.com with ESMTPSA id b27sm1558817ljb.11.2019.07.08.01.26.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 01:26:33 -0700 (PDT)
Date:   Mon, 08 Jul 2019 01:26:33 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Jul 2019 01:23:27 PDT (-0700)
Subject:     Re: [PATCH 16/17] riscv: clear the instruction cache and all registers when booting
In-Reply-To: <78919862d11f6d56446f8fffd8a1a8c601ea5c32.camel@wdc.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>, linux-mm@kvack.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-3f43f4b8-473d-429d-9a09-12d3542e33bc@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jul 2019 14:26:18 PDT (-0700), Atish Patra wrote:
> On Mon, 2019-06-24 at 07:43 +0200, Christoph Hellwig wrote:
>> When we get booted we want a clear slate without any leaks from
>> previous
>> supervisors or the firmware.  Flush the instruction cache and then
>> clear
>> all registers to known good values.  This is really important for the
>> upcoming nommu support that runs on M-mode, but can't really harm
>> when
>> running in S-mode either.
> 
> That means it should be done for S-mode as well. Right ?
> I see the reset code is enabled only for M-mode only.
> 
>>   Vaguely based on the concepts from opensbi.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  arch/riscv/kernel/head.S | 85
>> ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>> 
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index a4c170e41a34..74feb17737b4 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -11,6 +11,7 @@
>>  #include <asm/thread_info.h>
>>  #include <asm/page.h>
>>  #include <asm/csr.h>
>> +#include <asm/hwcap.h>
>>  
>>  __INIT
>>  ENTRY(_start)
>> @@ -19,6 +20,12 @@ ENTRY(_start)
>>  	csrw CSR_XIP, zero
>>  
>>  #ifdef CONFIG_M_MODE
>> +	/* flush the instruction cache */
>> +	fence.i
>> +
>> +	/* Reset all registers except ra, a0, a1 */
>> +	call reset_regs
>> +
>>  	/*
>>  	 * The hartid in a0 is expected later on, and we have no
>> firmware
>>  	 * to hand it to us.
>> @@ -168,6 +175,84 @@ relocate:
>>  	j .Lsecondary_park
>>  END(_start)
>>  
>> +#ifdef CONFIG_M_MODE
>> +ENTRY(reset_regs)
>> +	li	sp, 0
>> +	li	gp, 0
>> +	li	tp, 0
>> +	li	t0, 0
>> +	li	t1, 0
>> +	li	t2, 0
>> +	li	s0, 0
>> +	li	s1, 0
>> +	li	a2, 0
>> +	li	a3, 0
>> +	li	a4, 0
>> +	li	a5, 0
>> +	li	a6, 0
>> +	li	a7, 0
>> +	li	s2, 0
>> +	li	s3, 0
>> +	li	s4, 0
>> +	li	s5, 0
>> +	li	s6, 0
>> +	li	s7, 0
>> +	li	s8, 0
>> +	li	s9, 0
>> +	li	s10, 0
>> +	li	s11, 0
>> +	li	t3, 0
>> +	li	t4, 0
>> +	li	t5, 0
>> +	li	t6, 0
>> +	csrw	sscratch, 0
>> +
>> +#ifdef CONFIG_FPU
>> +	csrr	t0, misa
>> +	andi	t0, t0, (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D)
>> +	bnez	t0, .Lreset_regs_done
>> +
>> +	li	t1, SR_FS
>> +	csrs	sstatus, t1

You need to check that the write stuck and branch around the FP instructions.
Specifically, CONFIG_FPU means there may be an FPU, not there's definately an
FPU.  You should also turn the FPU back off after zeroing the state.

>> +	fmv.s.x	f0, zero
>> +	fmv.s.x	f1, zero
>> +	fmv.s.x	f2, zero
>> +	fmv.s.x	f3, zero
>> +	fmv.s.x	f4, zero
>> +	fmv.s.x	f5, zero
>> +	fmv.s.x	f6, zero
>> +	fmv.s.x	f7, zero
>> +	fmv.s.x	f8, zero
>> +	fmv.s.x	f9, zero
>> +	fmv.s.x	f10, zero
>> +	fmv.s.x	f11, zero
>> +	fmv.s.x	f12, zero
>> +	fmv.s.x	f13, zero
>> +	fmv.s.x	f14, zero
>> +	fmv.s.x	f15, zero
>> +	fmv.s.x	f16, zero
>> +	fmv.s.x	f17, zero
>> +	fmv.s.x	f18, zero
>> +	fmv.s.x	f19, zero
>> +	fmv.s.x	f20, zero
>> +	fmv.s.x	f21, zero
>> +	fmv.s.x	f22, zero
>> +	fmv.s.x	f23, zero
>> +	fmv.s.x	f24, zero
>> +	fmv.s.x	f25, zero
>> +	fmv.s.x	f26, zero
>> +	fmv.s.x	f27, zero
>> +	fmv.s.x	f28, zero
>> +	fmv.s.x	f29, zero
>> +	fmv.s.x	f30, zero
>> +	fmv.s.x	f31, zero
>> +	csrw	fcsr, 0
>> +#endif /* CONFIG_FPU */
>> +.Lreset_regs_done:
>> +	ret
>> +END(reset_regs)
>> +#endif /* CONFIG_M_MODE */
>> +
>>  __PAGE_ALIGNED_BSS
>>  	/* Empty zero page */
>>  	.balign PAGE_SIZE
> 
> -- 
> Regards,
> Atish
