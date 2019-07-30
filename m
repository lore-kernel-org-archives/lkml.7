Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ACEC41514
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688942087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfG3L0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:26:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54900 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfG3L0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:26:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so56754043wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 04:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zRulNL5qCAi/81YynxGrimpN6FxyJ33F7yQYkhCyZlk=;
        b=OYvbI1zTY58lGpUwpA1FJYmgNGlcs9wGpyol5GSVeyqPzfF0ivihPsGoCR9dTYr2Li
         VRVJhFa7bDiPzrOw3fJ0XXHjwYJhQQgp1WDZsYQK+3I5lQtJM5jt6gksAvJwTRTl32D5
         CsHfNcIHAlTHxHI2qzbNjkFLBcfUJAfM06ugwECwPZ0qe6t1I/lKKnty0O+/+QgTbb5x
         +Ybknd6N4jGrjacSb+DcWv4yzs1SahM7XpXi1sTtvxC9Lp0vnWHYaKBP6tsFeCzpW+Wo
         1FVENZoeCtJN9rR8xgeTdpyK7AHcVAwcQFux6Lx4T3q8k6ZMs7C1fBejFMwyBvTsjqwS
         25Sw==
X-Gm-Message-State: APjAAAWeVDRpRuERKNg18qc4CDWoFyRxoFMV9+axku+35AqC241pnSWb
        svHHezd8cm/MxgtXmG7CrFWOiPK2gIQ=
X-Google-Smtp-Source: APXvYqxo5UHLG3tyCvJ9QKdkC6ZVQFG9DiXwMjRxFm5zOjg0AFUbgZKXZO3dtvVP5tdG02WNBFwMlQ==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr103306392wmg.5.1564486001151;
        Tue, 30 Jul 2019 04:26:41 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 4sm146590471wro.78.2019.07.30.04.26.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 04:26:40 -0700 (PDT)
Subject: Re: [RFC PATCH 13/16] RISC-V: KVM: Add timer functionality
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
 <20190729115544.17895-14-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abedb067-b91f-8821-9bce-d27f6c4efdee@redhat.com>
Date:   Tue, 30 Jul 2019 13:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-14-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:57, Anup Patel wrote:
> +	if (delta_ns > VCPU_TIMER_PROGRAM_THRESHOLD_NS) {
> +		hrtimer_start(&t->hrt, ktime_add_ns(ktime_get(), delta_ns),

I think the guest would prefer if you saved the time before enabling
interrupts on the host, and use that here instead of ktime_get().
Otherwise the timer could be delayed arbitrarily by host interrupts.

(Because the RISC-V SBI timer is relative only---which is
unfortunate---guests will already pay a latency price due to the extra
cost of the SBI call compared to a bare metal implementation.  Sooner or
later you may want to implement something like x86's heuristic to
advance the timer deadline by a few hundred nanoseconds; perhaps add a
TODO now).

Paolo

> +				HRTIMER_MODE_ABS);
> +		t->is_set = true;
> +	} else
> +		kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_S_TIMER);
> +
