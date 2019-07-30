Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CE9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64DF206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbfG3KRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:17:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45960 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732501AbfG3KRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:17:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so65102101wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0BfXKRiEVxvU8bBbaJFcml0F4XwqkulSy5LoM8k5vnU=;
        b=LXyvagj2jP9Wvz09p53/7iu5e/99WQvws+3HEOtwy87TPk8EKa0IXN2rpZypawuiJy
         4093+4OlrOCb0FfkpAiosyp492kzTPGpnObXJZ8YPofzlMXPc7hbt2XInnmqSFykcTG4
         9jImwyr687xfOAqhHUxPrA9Gs6EE8E+uvXxR0Vm5IMBuPKxPSCu8YFluKizUch80FDbP
         kDbeTDA9msSs/MuZ0X7k8N6FBojqbuz+1nzRjxoF0TYV5PveeyAEweGkql0MJQPcyuB5
         0iJAZwAqbbDStlq//sDy1IGjVYJgQpSPM9GZ6lL7qts626jGmW5zIRtxiEhWeQpvP/mY
         h7IA==
X-Gm-Message-State: APjAAAWXD/HsuppDHPgDU1a4SAX3Ydb1Dax31LlyJlcd+elWkUIVg65E
        2madwznQEU1qRR3YB9AR1pKoi5mRfEU=
X-Google-Smtp-Source: APXvYqy6/dowCLGeT9RriCZ015qAZZF2PPTjzlMgI9dPdoZanSSBKVmGsIjx7EURe6YAtK3Npnanuw==
X-Received: by 2002:a5d:4041:: with SMTP id w1mr115756381wrp.199.1564481819511;
        Tue, 30 Jul 2019 03:16:59 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id s15sm46966792wrw.21.2019.07.30.03.16.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 03:16:58 -0700 (PDT)
Subject: Re: [RFC PATCH 04/16] RISC-V: KVM: Implement VCPU create, init and
 destroy functions
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
 <20190729115544.17895-5-anup.patel@wdc.com>
 <ade614ae-fcfe-35f2-0519-1df71d035bcd@redhat.com>
Message-ID: <2de10efc-56f8-ff47-ed69-7e471a099c80@redhat.com>
Date:   Tue, 30 Jul 2019 12:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ade614ae-fcfe-35f2-0519-1df71d035bcd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 10:48, Paolo Bonzini wrote:
> On 29/07/19 13:56, Anup Patel wrote:
>> +	cntx->hstatus |= HSTATUS_SP2V;
>> +	cntx->hstatus |= HSTATUS_SP2P;
> IIUC, cntx->hstatus's SP2P bit contains the guest's sstatus.SPP bit?

Nevermind, that was also a bit confused.  The guest's sstatus.SPP is in
vsstatus.  The pseudocode for V-mode switch is

SRET:
  V = hstatus.SPV (1)
  MODE = sstatus.SPP
  hstatus.SPV = hstatus.SP2V
  sstatus.SPP = hstatus.SP2P
  hstatus.SP2V = 0
  hstatus.SP2P = 0
  ...

trap:
  hstatus.SP2V = hstatus.SPV
  hstatus.SP2P = sstatus.SPP
  hstatus.SPV = V (1)
  sstatus.SPP = MODE
  V = 0
  MODE = 1

so:

1) indeed we need SP2V=SPV=1 when entering guest mode

2) sstatus.SPP contains the guest mode

3) SP2P doesn't really matter for KVM since it never goes to VS-mode
from an interrupt handler, so if my reasoning is correct I'd leave it
clear, but I guess it's up to you whether to set it or not.

Paolo

> I suggest adding a comment here, and again providing a ONE_REG interface
> to sstatus so that the ABI is final before RISC-V KVM is merged.
> 
> What happens if the guest executes SRET?  Is that EXC_SYSCALL in hedeleg?
> 
> (BTW the name of SP2V and SP2P is horrible, I think HPV/HPP or HSPV/HSPP
> would have been clearer, but that's not your fault).

