Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0746C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B166C2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbfHBI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:59:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39975 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfHBI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:59:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so65612605wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JgbbmoU8mRwQDt1oX8O7FGI/YFBQIrkxghclZVXxh9E=;
        b=MsRNW8goS0rD0UMxxxHoJAeLTzPo2ZgY6+yCKnkI+80WuU2yMmhCnrkofcLMqY4Eew
         qV63A3oPxc0DGYvhqbhVnlz07gRi/dg981aaHd6xmDeFwtIvusGQcDoRVmhXs6UzlHB4
         DdUJV8wFsnJwyL+1msFASYVjcMqhTqRNd0J2jSYStR+Pmj2MmXdQNaI2XMbr25Pi+Ob6
         kpXIcLHpXoL0HnaJ9JtmaEO9hOGe4RsB9++53rdBQeIyYAbAElDAPJFRN+ucXO4y8Azu
         rqcHBk475UdV9zDXy7m3nann/1TgIGFr37OAZrLxb0ocxmVVqsg3DGTS1eCnjQa7Rw1T
         ipMg==
X-Gm-Message-State: APjAAAU6QJgrGLe79gCeFTATezMFcjwL1mJ4Q5pn/jS93CKRrgux4Ohp
        AUdHFv62CVOLsIxsNNtVaMilhlDVnJM=
X-Google-Smtp-Source: APXvYqxJwRjyVgdn+EYXPUb8lVj+sHz60T4z7O9Y/MtbR/5gy1f516YgcK5v2luTrVMoSW/i85kDyA==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr3410562wma.68.1564736377101;
        Fri, 02 Aug 2019 01:59:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id f1sm50649557wml.28.2019.08.02.01.59.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 01:59:36 -0700 (PDT)
Subject: Re: [RFC PATCH v2 08/19] RISC-V: KVM: Implement VCPU world-switch
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190802074620.115029-1-anup.patel@wdc.com>
 <20190802074620.115029-9-anup.patel@wdc.com>
 <72d8efbf-ec62-ab1e-68bf-e0c5f0bc256e@redhat.com>
 <CAAhSdy2_ZsnT7gSKb624r9wzuJSx+1TnKxgW6srtqvXV1Ri9Aw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f9dee99d-f536-e351-f637-b5098d53be22@redhat.com>
Date:   Fri, 2 Aug 2019 10:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2_ZsnT7gSKb624r9wzuJSx+1TnKxgW6srtqvXV1Ri9Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 10:43, Anup Patel wrote:
>> A possible optimization: if these cannot change while Linux runs (I am
>> thinking especially of STVEC and HSTATUS, but perhaps SSCRATCH can be
>> saved on kvm_arch_vcpu_load too) you can avoid the csrr and store.
> Actual exception vector of Host Linux is different so we switch STVEC
> every time.
> 
> HSTATUS.SPV is set whenever we come back from Guest world so
> while we are in in-kernel run loop with interrupts enabled we can get
> external interrupt and HSTATUS.SPV bit can affect SRET of interrupt
> handler. To handle this we switch HSTATUS every time.
> 
> The world switch code uses SSCRATCH to save vcpu->arch pointer
> which is later used on return path. Now, I did not want to restrict Host
> Linux from using SSCRATCH for some other purpose hence we
> switch SSCRATCH every time.

Right, I'm not saying not to save these registers.  I'm saying not to
read the host value on every world switch, instead load it in
hardware_enable (if it's the same for all physical CPUs) or
kvm_arch_vcpu_load (if it's different for every physical CPU).

IIUC Linux does not use SSCRATCH while in the kernel (it must be zero
while handling an exception, but handle_exception takes care of that).
I think it's okay if you make this assumption, but if you don't want to
make it, you can still save it in kvm_arch_vcpu_load rather than here
since you "own" the thread while in KVM_RUN.

Paolo
