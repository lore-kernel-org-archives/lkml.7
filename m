Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD174205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfHBJOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:14:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42812 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfHBJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:14:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so26491015wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qip0/4niVe3t0eqLUXzaEsnThAuuUjr0Sl7TEveH/lY=;
        b=AiTFJaiI6tqKi/1a34acbIQ3Pwed0GseI1IJ9RnokukPk2PjBDqQkoq8kzPfczs1m0
         BX2gNR/M5XBcu7E772nljsvImhDuKVausmo5BxDE4TNYoQDX1/DPclSusaAuMAb1ymyp
         1gdqBCs5JWwfIE5KJGhKbbITaoakTNFQ8JhNkUlh0fs1J8VmwuiM2sR6l7DdYOz72v0Z
         R4TO4UPrq6XmB+Fmq85pkhqSgKf69TgvsCeE2bUkI7Ob8q8Pcj4wrvhdb8ezJ0cpCcXd
         DMFfdlVRZZGnKWgR9n8441KGnNkhl53CwzNBfHjhDkdvrtmQoY+fsBttZHpIAJQx3WFT
         B6pw==
X-Gm-Message-State: APjAAAXg0Yr1l9boalLMWgmB84SYRE8XeFrl5lMPldioY4Sr4YsyzHQq
        OT0UMNi3KOpD9VeqXK+Hq2kDJmi2JhA=
X-Google-Smtp-Source: APXvYqzBUUchxm6j0ktdj9jreOdHWCW7hMz3Yz24xUQA2HVmbvwbX1hgS8nU0BDDul8xNizaVm6PxQ==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr1884801wrn.31.1564737282526;
        Fri, 02 Aug 2019 02:14:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id y6sm62931619wrp.12.2019.08.02.02.14.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 02:14:42 -0700 (PDT)
Subject: Re: [RFC PATCH v2 12/19] RISC-V: KVM: Implement stage2 page table
 programming
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
 <20190802074620.115029-13-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <949b75ef-5ec6-cdfd-5d5d-5695f35bd20c@redhat.com>
Date:   Fri, 2 Aug 2019 11:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074620.115029-13-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 09:48, Anup Patel wrote:
> +	hgatp |= (k->vmid.vmid << HGATP_VMID_SHIFT) & HGATP_VMID_MASK;

This should use READ_ONCE.

Paolo

> +	hgatp |= (k->pgd_phys >> PAGE_SHIFT) & HGATP_PPN;

