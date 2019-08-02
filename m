Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAB2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F565205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbfHBJT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:19:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34531 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfHBJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:19:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so76448694wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rryOV1whaDt5qbcW76oYyWTCHfociKUQe7uUrG+FL04=;
        b=cAABzNIs+SyBwn205V12uXKyjKhzgHksrLrAN51TegQeO0rW2727G1AnFs+1uWKRg1
         88h15zPAoKx3U4e05fCsHezg1GlJJj9yQ3gT4srQgwaDpDa1jqFn3gxWWPVuQNl1w6f+
         GMrK1amHEWumuRjbioZo7DHo+sZl+VHL45uJDwU2smmyN/GV5wOQv0Biih9HX3DsA/jr
         1BoBHoYnznFwJjKazvdEvtkIMljIoFED+uo0HNslENkbC/6VwKT4+Hk69+5jmJZuzOku
         iZuXJrMqYxy//law4I8Qlho6qriF9kW7PAq7OeDxkIfqjSbtMpbuVmzAubDa5Fyh8k6n
         +PZg==
X-Gm-Message-State: APjAAAUMgXVMsOVerFyduNrlhg/rB/YL2/qESZntfHWTSPpaX1EwL9AA
        92ro9VjtV8stFGo9kaliltQv+ZwNxis=
X-Google-Smtp-Source: APXvYqza/LpvBZeOyX5mCSYBuS884KevJyp6R0c0GnF4OO2UtCcL/e+zxFkWcQbl0keeDPdzL8UUmg==
X-Received: by 2002:a5d:5510:: with SMTP id b16mr109465347wrv.267.1564737566565;
        Fri, 02 Aug 2019 02:19:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id v4sm75315899wmg.22.2019.08.02.02.19.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 02:19:26 -0700 (PDT)
Subject: Re: [RFC PATCH v2 11/19] RISC-V: KVM: Implement VMID allocator
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
References: <20190802074620.115029-1-anup.patel@wdc.com>
 <20190802074620.115029-12-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ef688903-ff49-ffeb-1f95-ef995942d5dc@redhat.com>
Date:   Fri, 2 Aug 2019 11:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074620.115029-12-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 09:48, Anup Patel wrote:
> +struct kvm_vmid {
> +	unsigned long vmid_version;
> +	unsigned long vmid;
> +};
> +

Please document that both fields are written under vmid_lock, and read
outside it.

> +		/*
> +		 * On SMP we know no other CPUs can use this CPU's or
> +		 * each other's VMID after forced exit returns since the
> +		 * vmid_lock blocks them from re-entry to the guest.
> +		 */
> +		force_exit_and_guest_tlb_flush(cpu_all_mask);

Please use kvm_flush_remote_tlbs(kvm) instead.  All you need to do to
support it is check for KVM_REQ_TLB_FLUSH and handle it by calling
__kvm_riscv_hfence_gvma_all.  Also, since your spinlock is global you
probably should release it around the call to kvm_flush_remote_tlbs.
(Think of an implementation that has a very small number of VMID bits).

> +	if (unlikely(vmid_next == 0)) {
> +		WRITE_ONCE(vmid_version, READ_ONCE(vmid_version) + 1);
> +		vmid_next = 1;
> +		/*
> +		 * On SMP we know no other CPUs can use this CPU's or
> +		 * each other's VMID after forced exit returns since the
> +		 * vmid_lock blocks them from re-entry to the guest.
> +		 */
> +		force_exit_and_guest_tlb_flush(cpu_all_mask);
> +	}
> +
> +	vmid->vmid = vmid_next;
> +	vmid_next++;
> +	vmid_next &= (1 << vmid_bits) - 1;
> +
> +	/* Ensure VMID next update is completed */
> +	smp_wmb();

This barrier is not necessary.  Writes to vmid->vmid need not be ordered
with writes to vmid->vmid_version, because the accesses happen in
completely different places.

(As a rule of thumb, each smp_wmb() should have a matching smp_rmb()
somewhere, and this one doesn't).

Paolo

> +	WRITE_ONCE(vmid->vmid_version, READ_ONCE(vmid_version));
> +
