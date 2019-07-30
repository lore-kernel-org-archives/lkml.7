Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1810C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1D620693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfG3LUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:20:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35674 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbfG3LUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:20:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so56262311wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dU6DC0DBnzponZWFwxW0e6zjqYJ2z/TxlXP6MPH2kzU=;
        b=FFcy+rmohstzMPjtzox2o/afkG7ToGKr4ncAWHzA7+tfxGdd7XsLsMho/2yutF0atF
         xE+vQNPBby+v5ySBHnPVgiFb8eyHMDiEdhCRG04r/6LkNFs4fRxPbPh0kXFJbzVqR+s6
         rW9M8rLR3qEsKNC7VhAlqRO/C3e0+llW5YdxoySxKESU3DEh8Xh9oBoHf4dVU3HMWHho
         KhvwA+hV7gU6BjVwEI5AiIfIcdaa5hzbvAK0NQIorGY22EQsA4boRdVkUX5SQeZoNKLh
         UaWQOh3J9fuWJOekHO4lw24qhz7+aRKO+Ir1HoV2E49+DZRr2yd9UJ7zX85Epehm1WUE
         RpVA==
X-Gm-Message-State: APjAAAVc4j26muTJC4zNqNMUi5l2XQvUX0XWhCBKkewF6gPGwpfwFy7u
        NrYvPjLqAVcEB2aI3vNCYiptjGIBr0Y=
X-Google-Smtp-Source: APXvYqxGPEGFqFhh+SybAHgvqyZjBla5wxFfR6C1Wpq433TyWcQ3KrXJLcUDIP/E7F7OQac0mNBfoA==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr107521wmg.135.1564485615636;
        Tue, 30 Jul 2019 04:20:15 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 18sm54002868wmg.43.2019.07.30.04.20.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:20:15 -0700 (PDT)
Subject: Re: [RFC PATCH 08/16] RISC-V: KVM: Handle MMIO exits for VCPU
To:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <20190729115544.17895-9-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05d41219-6c0c-8851-dab6-24f9c76aed57@redhat.com>
Date:   Tue, 30 Jul 2019 13:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-9-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:57, Anup Patel wrote:
> +static ulong get_insn(struct kvm_vcpu *vcpu)
> +{
> +	ulong __sepc = vcpu->arch.guest_context.sepc;
> +	ulong __hstatus, __sstatus, __vsstatus;
> +#ifdef CONFIG_RISCV_ISA_C
> +	ulong rvc_mask = 3, tmp;
> +#endif
> +	ulong flags, val;
> +
> +	local_irq_save(flags);
> +
> +	__vsstatus = csr_read(CSR_VSSTATUS);
> +	__sstatus = csr_read(CSR_SSTATUS);
> +	__hstatus = csr_read(CSR_HSTATUS);
> +
> +	csr_write(CSR_VSSTATUS, __vsstatus | SR_MXR);
> +	csr_write(CSR_SSTATUS, vcpu->arch.guest_context.sstatus | SR_MXR);
> +	csr_write(CSR_HSTATUS, vcpu->arch.guest_context.hstatus | HSTATUS_SPRV);
> +
> +#ifndef CONFIG_RISCV_ISA_C
> +	asm ("\n"
> +#ifdef CONFIG_64BIT
> +		STR(LWU) " %[insn], (%[addr])\n"
> +#else
> +		STR(LW) " %[insn], (%[addr])\n"
> +#endif
> +		: [insn] "=&r" (val) : [addr] "r" (__sepc));
> +#else
> +	asm ("and %[tmp], %[addr], 2\n"
> +		"bnez %[tmp], 1f\n"
> +#ifdef CONFIG_64BIT
> +		STR(LWU) " %[insn], (%[addr])\n"
> +#else
> +		STR(LW) " %[insn], (%[addr])\n"
> +#endif
> +		"and %[tmp], %[insn], %[rvc_mask]\n"
> +		"beq %[tmp], %[rvc_mask], 2f\n"
> +		"sll %[insn], %[insn], %[xlen_minus_16]\n"
> +		"srl %[insn], %[insn], %[xlen_minus_16]\n"
> +		"j 2f\n"
> +		"1:\n"
> +		"lhu %[insn], (%[addr])\n"
> +		"and %[tmp], %[insn], %[rvc_mask]\n"
> +		"bne %[tmp], %[rvc_mask], 2f\n"
> +		"lhu %[tmp], 2(%[addr])\n"
> +		"sll %[tmp], %[tmp], 16\n"
> +		"add %[insn], %[insn], %[tmp]\n"
> +		"2:"
> +	: [vsstatus] "+&r" (__vsstatus), [insn] "=&r" (val),
> +	  [tmp] "=&r" (tmp)
> +	: [addr] "r" (__sepc), [rvc_mask] "r" (rvc_mask),
> +	  [xlen_minus_16] "i" (__riscv_xlen - 16));
> +#endif
> +
> +	csr_write(CSR_HSTATUS, __hstatus);
> +	csr_write(CSR_SSTATUS, __sstatus);
> +	csr_write(CSR_VSSTATUS, __vsstatus);
> +
> +	local_irq_restore(flags);
> +
> +	return val;
> +}
> +

This also needs fixups for exceptions, because the guest can race
against the host and modify its page tables concurrently with the
vmexit.  (How effective this is, of course, depends on how the TLB is
implemented in hardware, but you need to do the safe thing anyway).

Paolo
