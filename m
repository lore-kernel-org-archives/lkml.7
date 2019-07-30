Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C65420693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfG3OCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:02:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34276 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfG3OCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:02:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so65951870wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9EuouZv6KkAfnXeYgN1dDIcC6u4TgIuceUgUlR6uEAU=;
        b=o24DdnahCk5rNUu6hAPBD6N/AzUSPSGgKfw9ekav/9534QWChmyfcxWRLi89WvNL6h
         dUjvYyOsiIV4sDQHCBLvuqNwPEEjMPwy9RzIec5ui7J2QuPEU1wepJ5GeEW/9SqUduVJ
         Nktj9IcvuXG89oKfpzbXQkpuN0og3vxYpBSkPgHymlNKAMqq+T5KaS4i0NrZ2OfSMftG
         RngeoRvV3q5yvJYcoWJlU6QOp14xOd06EAVXegDw3S/ErJOj6ax/wAY3D6KHdYKxsWlb
         Kk9naqbJT8HFeo+QOuOjMNrZ644o1pP+P4Rwv85iyJtUFC0Pcp2A5XJeut8PA9xneH8V
         h4gQ==
X-Gm-Message-State: APjAAAXalIYfseV5zu6NRFzGovyX+sYGoYVpTT5m/bZBsvR9OlR970+j
        sv254bnsgOwDLJx5PS6dn865/8EelGk=
X-Google-Smtp-Source: APXvYqz444q5M6LOXoHcyZ0+5NhLAV2GC/dilLeCMRigSflzkicbG33/VTK0UCpeR27ntA61CsOd8w==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr32991874wrv.40.1564495330668;
        Tue, 30 Jul 2019 07:02:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id j17sm107585902wrb.35.2019.07.30.07.02.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 07:02:09 -0700 (PDT)
Subject: Re: [RFC PATCH 00/16] KVM RISC-V Support
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
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <72e9f668-f496-3fca-a1a8-a3c3122a3fd9@redhat.com>
 <CAAhSdy3Z6d2phRGo20eNWfa4onFwFtsOUPM+OCD465y0tvQ5wg@mail.gmail.com>
 <965cffdb-86e2-b422-9c23-345c7100fd88@redhat.com>
 <CAAhSdy0Sy9YV5ymdFk0URLY4GvOkWaWOpC_Dju+1ada_yc=Pmw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c430df93-836a-3cd4-eac1-493833e79ca9@redhat.com>
Date:   Tue, 30 Jul 2019 16:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0Sy9YV5ymdFk0URLY4GvOkWaWOpC_Dju+1ada_yc=Pmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 15:50, Anup Patel wrote:
>> BTW, since IPIs are handled in the SBI I wouldn't bother with in-kernel
>> PLIC emulation unless you can demonstrate performance improvements (for
>> example due to irqfd).  In fact, it may be more interesting to add
> 
> I thought VHOST requires irqfd and we would certainly endup providing
> in-kernel PLIC emulation to support VHOST.

vhost only needs an eventfd, userspace can poll the eventfd and inject
the irq as usual with KVM_INTERRUPT.  Of course that can be slower, but
you can benchmark it and see if it's indeed a good reason for in-kernel
PLIC.

>> plumbing for userspace handling of selected SBI calls (in addition to
>> get/putchar, sbi_system_reset and sbi_hart_down look like good
>> candidates in SBI v0.2).
> 
> The get/putchar SBI v0.1 calls won't be encouraged going forward because
> we already have earlycon implmentation in-place and Guest kernel can directly
> write to UART registers for earlyprints.

> If we still wanted to implement get/putchar calls then we would need a RISC-V
> specific exit reason in KVM. We have tried to avoid RISC-V specific IOCTLs
> or exit reason in this series.

Sounds good.

Paolo

>>
>>> We were thinking to keep KVM RISC-V disabled by default (i.e. keep it
>>> experimental) until we have validated it on some FPGA or real HW. For now,
>>> users can explicitly enable it and play-around on QEMU emulation. I hope
>>> this is fine with most people ?
>>
>> That's certainly okay with me.
>>
> 
> Thanks,
> Anup
> 

