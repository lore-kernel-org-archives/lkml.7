Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3852DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140B3208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfG3Jed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:34:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40605 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfG3Jec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:34:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so64970075wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CokP5DJZX8fcTdu2V8k9QUz5XnfVM2mfkMJryb9GY0Y=;
        b=XTwK7D/+c8mg8XpP0H/JItKhuFt1h4F9KmvTxviF40P0lW4BjAfG7FHRlSA5+WtDJB
         sb2nH6x7DxfDTZVK9sRvt8gnbHph2xt4STebc4zvYtamHjLSd6G2gL/4BUZ2ZWNbUPWu
         lXo8hC/RREcPObLG89bSeL/3D8ohZHWGD8Py3XeiWss35p17ZY4R42s9KPWpt7wo4UAN
         UHq5+cg9GiILUSH+Ofx1aHFzvJUuj/ak9du0qXs3mKRIJAvdEe6TiRWF5zzuuB9ZMQ3V
         wIVP49gEOdK+qD3RHNANibuHOfcHHCO3TS83YTY7tGU3zQS8jB61M1Gjh3a1VlwfD3+0
         Ej2Q==
X-Gm-Message-State: APjAAAWkF1jNygHDs27+Tue9X3GDOsD+q500ugZg9416XxHF50rIc93U
        5g+dEST37kyrPNQBOjexT2lH5n8AjbQ=
X-Google-Smtp-Source: APXvYqzBErq4zKQr1w1EtdBj7vtFUGW/B8UZMe8PqrMcUaUa6/Cp+PqL1mP0K4OpT6sybWId8GYeHg==
X-Received: by 2002:adf:e444:: with SMTP id t4mr25964034wrm.262.1564479270468;
        Tue, 30 Jul 2019 02:34:30 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id j16sm6519552wrp.62.2019.07.30.02.34.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:34:29 -0700 (PDT)
Subject: Re: [RFC PATCH 07/16] RISC-V: KVM: Implement VCPU world-switch
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
 <20190729115544.17895-8-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbb1b995-be2f-96a5-9890-63e1941e7f3c@redhat.com>
Date:   Tue, 30 Jul 2019 11:34:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-8-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:57, Anup Patel wrote:
>  void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
> -	/* TODO: */
> +	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
> +
> +	csr_write(CSR_HIDELEG, csr->hideleg);
> +	csr_write(CSR_HEDELEG, csr->hedeleg);

Writing HIDELEG and HEDELEG here seems either wrong or inefficient to me.

I don't remember the spec well enough, but there are two cases:

1) either they only matter while the guest runs and then you can set
them in kvm_arch_hardware_enable.  KVM common code takes care of doing
this on all CPUs for you.

2) or they also matter while the host runs and then you need to set them
in vcpu_switch.S.

Paolo
