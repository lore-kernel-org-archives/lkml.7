Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20794C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A3D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfG3JgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:36:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35159 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbfG3Jf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:35:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so64993833wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfBe8BIZguRGaVcqxBIUd21ri7wgmIbA7EXh3G0N3Hw=;
        b=n5PnWtJDftzfZKQfifvnWJZj9bq1w4qzITwF/RpkWVxxMhlDc4zTxJ5YrfQZ6iWlFD
         MZ+t1HlAgJztRmj8JWUgqTCKMVLQFcuQeVijvaKiHvaLh1KbJPn3Poh5qSOQ+lNQ1bqN
         uwWCnbXB/q1xRyxSx4nTCE9l7lRqFIL+aF60E47XVqVktSPn3LvrZicfiAYPR3R8+Lbk
         Cq59m5sZHMd/HIE77b7fitw1QwG+8KUp1yOlrD3guTy6KFnluhXWgZpltPzNY3e1gOXg
         kS63D4wy1dCSaSgwIywR98EUEiUf0qScpztJkKJlqsn11Q4RS7ZVFvywsgYfpeF1S9iQ
         zVDw==
X-Gm-Message-State: APjAAAXLh8Cvr5+s2ltxWkklKLlnsZcy5wyY+DORSrCQPFNA/1qVXv9t
        lVAp73uiMYPtNmGkj6E/gLczSbWVGkc=
X-Google-Smtp-Source: APXvYqwq3Hft9cpeFWfJQOdIrZK1BvEf6TQWeB6zhzE98jxFZtCFfEZfO6QPRJKZp8CB+tTOovDs0w==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr45610035wru.43.1564479356485;
        Tue, 30 Jul 2019 02:35:56 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id v204sm67712311wma.20.2019.07.30.02.35.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:35:55 -0700 (PDT)
Subject: Re: [RFC PATCH 06/16] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
From:   Paolo Bonzini <pbonzini@redhat.com>
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
 <20190729115544.17895-7-anup.patel@wdc.com>
 <3caa5b31-f5ed-98cd-2bdf-88d8cb837919@redhat.com>
Message-ID: <536673cd-3b84-4e56-6042-de73a536653f@redhat.com>
Date:   Tue, 30 Jul 2019 11:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3caa5b31-f5ed-98cd-2bdf-88d8cb837919@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 10:43, Paolo Bonzini wrote:
> On 29/07/19 13:56, Anup Patel wrote:
>> The PC register represents program counter whereas the MODE
>> register represent VCPU privilege mode (i.e. S/U-mode).
>>
> Is there any reason to include this pseudo-register instead of allowing
> SSTATUS access directly in this patch (and perhaps also SEPC)?

Nevermind, I was confused - the current MODE is indeed not accessible as
a "real" CSR in RISC-V.

Still, I would prefer all the VS CSRs to be accessible via the get/set
reg ioctls.

Paolo
