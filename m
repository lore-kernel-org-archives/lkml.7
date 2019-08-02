Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A251C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220632187F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404198AbfHBIaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:30:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfHBIaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:30:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so76340990wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MjSLRhTHy/z+LM8sRLnyEruabbpzZhCsOii1dxVU9Y=;
        b=SUifxYEa7EV1FZnh/CbwjTsf3V9F4jCxKT5U+YyPuYr26jiQgcLRkDb4aU6c05c2jC
         YXzDSj5HpSZRmVdzOl6GjcQXX5y8EsIUsGON6aH7i5fBA0X1yXYmNW4OweZbqGCqY8Im
         Hug4pvAyz9gNAwBknouFPA0MGbv5+3uRJcgkNEUjcF5mxhOrn1U9QJ0n85ndm3XaVJqr
         qv+bhjyAZ+4zg+kgQjXps5yOP0dzmbvU4j/4oWmA3bKXg3wVJ3GyapPeckV7vGIwSUZI
         W3nER1De2WyL8Xyh5TBPjhXAis+7cskSFlZMbzsNphvzfIMTOUc+YlvWHVViwpKWacV4
         /M8w==
X-Gm-Message-State: APjAAAXgrq5cJMjdNv4UicggS1H2H4NtDks7VRySbpVXYG8l+EnCMWhr
        lLTxHCoa8vR+qt0ZUK/v1WdfuqNvxag=
X-Google-Smtp-Source: APXvYqxQ8H0EwfjmiYP1/SUacCSArAMVaY+7Hsw2aimu6rkqpcHBrjydXWxpNn5htwW5YM1MsKxGqQ==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr117116586wrm.322.1564734611723;
        Fri, 02 Aug 2019 01:30:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id b8sm99851723wmh.46.2019.08.02.01.30.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 01:30:11 -0700 (PDT)
Subject: Re: [RFC PATCH v2 08/19] RISC-V: KVM: Implement VCPU world-switch
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
 <20190802074620.115029-9-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <72d8efbf-ec62-ab1e-68bf-e0c5f0bc256e@redhat.com>
Date:   Fri, 2 Aug 2019 10:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074620.115029-9-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 09:47, Anup Patel wrote:
> +	/* Save Host SSTATUS, HSTATUS, SCRATCH and STVEC */
> +	csrr	t0, CSR_SSTATUS
> +	REG_S	t0, (KVM_ARCH_HOST_SSTATUS)(a0)
> +	csrr	t1, CSR_HSTATUS
> +	REG_S	t1, (KVM_ARCH_HOST_HSTATUS)(a0)
> +	csrr	t2, CSR_SSCRATCH
> +	REG_S	t2, (KVM_ARCH_HOST_SSCRATCH)(a0)
> +	csrr	t3, CSR_STVEC
> +	REG_S	t3, (KVM_ARCH_HOST_STVEC)(a0)
> +

A possible optimization: if these cannot change while Linux runs (I am
thinking especially of STVEC and HSTATUS, but perhaps SSCRATCH can be
saved on kvm_arch_vcpu_load too) you can avoid the csrr and store.

Paolo
