Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563E320679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfG3JZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:25:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfG3JZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:25:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so61735854wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUzWE80r0+/Jm/PmpREfM87NZ7CTSmB2MTbi4J4MfgQ=;
        b=PuXhGz1AOtpwKKLSZiu+2IMiBkH/W7zkmwsEzkN1CPFRhn5XQGQTd6njXGOR8ejBhK
         KBZ2hColLms/QzT74ihO/HkVRS+cSANziseIZZNk/2M3fcf+Di48ABnYmsvwWbajNued
         OVFG4VT7cX9s30ELaimT92Um1WF3AIxw4Xd5SjeIuExZQch51dhVXGcTTcpIbpOLzOwv
         LaTjRnUVrjSoCQ/OGizMfvaqUxf8liN6P2jedL0lY6+ipyoyoRIUL87zMpzAXheEWTVc
         LxwK7Y4LB9ptFTd4uIGfRiEt/w7k/M/x81E0VxTv5LEqck3vMIkgLeHqY/4s9XZX2c2h
         k0KQ==
X-Gm-Message-State: APjAAAWS7eNv+jINUMf5HBqMcG0px7GtaExQ8/xpolMaQM0ItY30wlah
        aSUoYd5JBQOrGR4nDBJNBQIPHQvy/u0=
X-Google-Smtp-Source: APXvYqz+F0XEhEJWXPXqrEBWvnNsKyL98ooHfR6J44rQZTpHYL5dhBASE4lu+y3QS4SD34KieOnK3Q==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr124398481wrl.344.1564478727541;
        Tue, 30 Jul 2019 02:25:27 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o7sm34682654wru.58.2019.07.30.02.25.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:25:27 -0700 (PDT)
Subject: Re: [RFC PATCH 03/16] RISC-V: Add initial skeletal KVM support
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
 <20190729115544.17895-4-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1157450-258b-91c1-72cb-867c96f929d8@redhat.com>
Date:   Tue, 30 Jul 2019 11:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729115544.17895-4-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 13:56, Anup Patel wrote:
> +void kvm_riscv_halt_guest(struct kvm *kvm)
> +{
> +	int i;
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm)
> +		vcpu->arch.pause = true;
> +	kvm_make_all_cpus_request(kvm, KVM_REQ_SLEEP);
> +}
> +
> +void kvm_riscv_resume_guest(struct kvm *kvm)
> +{
> +	int i;
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		vcpu->arch.pause = false;
> +		swake_up_one(kvm_arch_vcpu_wq(vcpu));
> +	}

Are these unused?  (Perhaps I'm just blind :))

Paolo
