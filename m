Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A88C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11896206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfG3Lrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:47:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42368 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfG3Lrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:47:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so15518747wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=URLGMXYUvPFwf9Ds8JQxcBHzIr6dahYGzK+VoJD8QhE=;
        b=TuXew9/1KLfobqYcZtM97gUP/Spwjt2LkcIqe1QEtZ5e3npTkBjUzEroeiJjADd9jh
         7sAFXnWTL2YI3Pk6aod2zpkjgajr4RumKSrSHvHVe8f1n9w93X9A9l96XAMXWsZ1JvgH
         wvOiIWOTZrbnacP42dZ9Cz48a4B5kPG+xEWPbgsXTw+u9+KpUDyDaS3HZtrhY3R/8CVs
         Ey2RWJachFuNWAYtneqM9iUq+hZ87udx8kRjG3J5KJICbNv1avMlHzbFoASH5Yd/apbh
         mrDsM8+va1yFwu5yPY/7vRzYUbklLn+uBPrFpCyBilFgtG1chgF9wNrzo3aqg5IXuv44
         uv6Q==
X-Gm-Message-State: APjAAAWg5KMKq0RuQ6PWqV9D7X057auI389iwtcXbyAFmkgpmfTZL5lL
        ubqje2iSu5K18Q7xwoF8XASZzaAaoC4=
X-Google-Smtp-Source: APXvYqwaB3fvd7fbhIEykGUUPwA19XqyBzPVtdZ9LEL3jMPxSoL5kvVaSAXhjUtKnKuuDk+TdhmILw==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr54665638wru.305.1564487271786;
        Tue, 30 Jul 2019 04:47:51 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b8sm83186767wmh.46.2019.07.30.04.47.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:47:50 -0700 (PDT)
Subject: Re: [RFC PATCH 04/16] RISC-V: KVM: Implement VCPU create, init and
 destroy functions
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
 <20190729115544.17895-5-anup.patel@wdc.com>
 <ade614ae-fcfe-35f2-0519-1df71d035bcd@redhat.com>
 <2de10efc-56f8-ff47-ed69-7e471a099c80@redhat.com>
 <CAAhSdy0OH9h-R=2NxhhPs6jmFPNgZVSwFtCjtJrf++htu82ifA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <00ec47ef-6c03-ec27-3894-7afd4757ee61@redhat.com>
Date:   Tue, 30 Jul 2019 13:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0OH9h-R=2NxhhPs6jmFPNgZVSwFtCjtJrf++htu82ifA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 13:45, Anup Patel wrote:
>> so:
>>
>> 1) indeed we need SP2V=SPV=1 when entering guest mode
>>
>> 2) sstatus.SPP contains the guest mode
>>
>> 3) SP2P doesn't really matter for KVM since it never goes to VS-mode
>> from an interrupt handler, so if my reasoning is correct I'd leave it
>> clear, but I guess it's up to you whether to set it or not.
> Yes, SP2P does not matter but we set it to 1 here so that from Guest
> perspective it seems we were in S-mode previously.

But the guest never reads sstatus.SPP, it always reads, vsstatus.SPP
doesn't it?  In any case it doesn't matter.

Paolo
