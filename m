Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B5C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8415B206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfIWLMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:12:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfIWLMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:12:23 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC40389AC4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:12:22 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id f11so4667763wrt.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxD2Y3WBGHkLvQqCAXXWzhnVRm7+WSVZkhBdGyUy/Zg=;
        b=Ov0/ub5PLhPIQsZZRGUBlqarggm8QVIG3n/Ew8U8wQh144n3oSFoQ7KWsST7jiczbd
         RxcKoSWjFXVWouHANEUAsecDtQyMTQ0PVGClZGTxcrWDXNfsnbpl9qJy8oDBFz8CQxIR
         CzqAhtXhOF6NdwJoZgYtmoHx3Wk8P9rvRFIpFloAImkVPuO2Oic/2oYLQA6O0SI0KCH4
         XDEy0KSkKfTbol9nRBqOtt3AMdsGL3jMWEXK52L3Rc15s/6XV74BzHplt/cfFvcKg+7l
         GasrJIKltEf9QIdSnoxIr8n2Yen9O4YxZuyq8ASgAl1so3xb/B5aGpFdg3caT6RJsrtL
         WxVA==
X-Gm-Message-State: APjAAAWs+LltjTWjZf+ZTNuX9emsCBTERtAaQixSlQG4SodaW3RZ/HXF
        9LOTiCYMJyVC+MSnTgt8JCEgdAxtw+rv1iIjc7X7Bg7ZmdHPXhDJddOpL33uw3THRhQneTtL6bY
        n6lTfNDyPFpTv0IfR6U1nBWsJ
X-Received: by 2002:adf:cc87:: with SMTP id p7mr20853219wrj.43.1569237141151;
        Mon, 23 Sep 2019 04:12:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMW44zhOI1DG3DXgqsJqxbWPiZJb1HLWTJc4XK+mxiK6jX2sDL9nFCMUqBJJ1EN+ViAcwPtQ==
X-Received: by 2002:adf:cc87:: with SMTP id p7mr20853197wrj.43.1569237140829;
        Mon, 23 Sep 2019 04:12:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id s12sm14065554wrn.90.2019.09.23.04.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 04:12:20 -0700 (PDT)
Subject: Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
To:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190904161245.111924-1-anup.patel@wdc.com>
 <20190904161245.111924-12-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c44ac8a-3fdc-b9dd-1815-06e86cb73047@redhat.com>
Date:   Mon, 23 Sep 2019 13:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904161245.111924-12-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/19 18:15, Anup Patel wrote:
> +	unsigned long guest_sstatus =
> +			vcpu->arch.guest_context.sstatus | SR_MXR;
> +	unsigned long guest_hstatus =
> +			vcpu->arch.guest_context.hstatus | HSTATUS_SPRV;
> +	unsigned long guest_vsstatus, old_stvec, tmp;
> +
> +	guest_sstatus = csr_swap(CSR_SSTATUS, guest_sstatus);
> +	old_stvec = csr_swap(CSR_STVEC, (ulong)&__kvm_riscv_unpriv_trap);
> +
> +	if (read_insn) {
> +		guest_vsstatus = csr_read_set(CSR_VSSTATUS, SR_MXR);

Is this needed?  IIUC SSTATUS.MXR encompasses a wider set of permissions:

  The HS-level MXR bit makes any executable page readable.  {\tt
  vsstatus}.MXR makes readable those pages marked executable at the VS
  translation level, but only if readable at the guest-physical
  translation level.

So it should be enough to set SSTATUS.MXR=1 I think.  But you also
shouldn't set SSTATUS.MXR=1 in the !read_insn case.

Also, you can drop the irq save/restore (which is already a save/restore
of SSTATUS) since you already write 0 to SSTATUS.SIE in your csr_swap.
Perhaps add a BUG_ON(guest_sstatus & SR_SIE) before the csr_swap?

> +		asm volatile ("\n"
> +			"csrrw %[hstatus], " STR(CSR_HSTATUS) ", %[hstatus]\n"
> +			"li %[tilen], 4\n"
> +			"li %[tscause], 0\n"
> +			"lhu %[val], (%[addr])\n"
> +			"andi %[tmp], %[val], 3\n"
> +			"addi %[tmp], %[tmp], -3\n"
> +			"bne %[tmp], zero, 2f\n"
> +			"lhu %[tmp], 2(%[addr])\n"
> +			"sll %[tmp], %[tmp], 16\n"
> +			"add %[val], %[val], %[tmp]\n"
> +			"2: csrw " STR(CSR_HSTATUS) ", %[hstatus]"
> +		: [hstatus] "+&r"(guest_hstatus), [val] "=&r" (val),
> +		  [tmp] "=&r" (tmp), [tilen] "+&r" (tilen),
> +		  [tscause] "+&r" (tscause)
> +		: [addr] "r" (addr));
> +		csr_write(CSR_VSSTATUS, guest_vsstatus);

> 
> +#ifndef CONFIG_RISCV_ISA_C
> +			"li %[tilen], 4\n"
> +#else
> +			"li %[tilen], 2\n"
> +#endif

Can you use an assembler directive to force using a non-compressed
format for ld and lw?  This would get rid of tilen, which is costing 6
bytes (if I did the RVC math right) in order to save two. :)

Paolo

> +			"li %[tscause], 0\n"
> +#ifdef CONFIG_64BIT
> +			"ld %[val], (%[addr])\n"
> +#else
> +			"lw %[val], (%[addr])\n"
> +#endif
