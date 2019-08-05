Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972CB217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfHEHKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:10:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42682 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfHEHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:10:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so33329437wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 00:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZevUiv8uwSdDDjAx9KzB+mkgl2A2MlBAMqJYEcYxJb4=;
        b=VNkFjk2VA4yKzW2hyeg0goQYjSulpLwjv34xgLelHkORELoJMe0IcUALiS2QYAJajA
         rhZhDuKTuBYv48wzkQ0tlXrNTwzQyul0i59ev5o38kKnVJXUCGNHr1V/J9DO/Akpu9b6
         q3GqlS6vCVe7NHJfjf8gD0yJD3v3PUxTqDVvntUqMGQZAsmxGO3CgLUy3a/MDxrlmUyf
         HOS+nNGcs5HZ7Qt47lSDpFo/MWW9Ilc6JaKzHbZn3uAJDb7N+ilpzrzbfJ7G+CGC9jgY
         EmaaR4Hl0Qqw9f2sF0wKE5hR+K932FDFDudZIluk1d1jwJAWKPuoau/E41zdbgUOyg04
         XNng==
X-Gm-Message-State: APjAAAWp0tyGGXQBh39CqyNkNrEh3DaW4qcWzy5qVBkzmuFOx61x5emN
        j6iMwuN0wWUIwuLvTCtyJwNVTSmtKs4=
X-Google-Smtp-Source: APXvYqz4JZD0IeqwiFL5mBQ4rS9FPy4QrJF8r1CcIFwbr3gterh7TeHwGfJ0MlgqppwBX5w6DpgFdg==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr38385884wrx.80.1564989033079;
        Mon, 05 Aug 2019 00:10:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id t185sm74525739wma.11.2019.08.05.00.10.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 00:10:32 -0700 (PDT)
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
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
 <20190802074620.115029-8-anup.patel@wdc.com>
 <03f60f3a-bb50-9210-8352-da16cca322b9@redhat.com>
 <CAAhSdy3hdWfUCUEK-idoTzgB2hKeAd3FzsHEH1DK_BTC_KGdJw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <eb964565-10e1-bd44-c37c-774bf2f58049@redhat.com>
Date:   Mon, 5 Aug 2019 09:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy3hdWfUCUEK-idoTzgB2hKeAd3FzsHEH1DK_BTC_KGdJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 08:55, Anup Patel wrote:
> On Fri, Aug 2, 2019 at 2:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 02/08/19 09:47, Anup Patel wrote:
>>> +     if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
>>> +             kvm_riscv_vcpu_flush_interrupts(vcpu, false);
>>
>> Not updating the vsip CSR here can cause an interrupt to be lost, if the
>> next call to kvm_riscv_vcpu_flush_interrupts finds a zero mask.
> 
> Thanks for catching this issue. I will address it in v3.
> 
> If we think more on similar lines then we also need to handle the case
> where Guest VCPU had pending interrupts and we suddenly stopped it
> for Guest migration. In this case, we would eventually use SET_ONE_REG
> ioctl on destination Host which should set vsip_shadow instead of vsip so
> that we force update HW after resuming Guest VCPU on destination host.

I think it's simpler than that.

vcpu->vsip_shadow is just the current value of CSR_VSIP so that you do
not need to update it unconditionally on every vmentry.  That is,
kvm_vcpu_arch_load should do

	csr_write(CSR_VSIP, vcpu->arch.guest_csr.vsip);
	vcpu->vsip_shadow = vcpu->arch.guest_csr.vsip;

while every other write can go through kvm_riscv_update_vsip.  But
vsip_shadow is completely disconnected from SET_ONE_REG; SET_ONE_REG can
just write vcpu->arch.guest_csr.vsip and clear irqs_pending_mask, the
next entry will write CSR_VSIP and vsip_shadow if needed.

In fact, instead of placing it in kvm_vcpu, vsip_shadow could be a
percpu variable; on hardware_enable you write 0 to both vsip_shadow and
CSR_VSIP, and then kvm_arch_vcpu_load does not have to touch CSR_VSIP at
all (only kvm_riscv_vcpu_flush_interrupts).  I think this makes the
purpose of vsip_shadow even clearer, so I highly suggest doing that.

>> You could add a new field vcpu->vsip_shadow that is updated every time
>> CSR_VSIP is written (including kvm_arch_vcpu_load) with a function like
>>
>> void kvm_riscv_update_vsip(struct kvm_vcpu *vcpu)
>> {
>>         if (vcpu->vsip_shadow != vcpu->arch.guest_csr.vsip) {
>>                 csr_write(CSR_VSIP, vcpu->arch.guest_csr.vsip);
>>                 vcpu->vsip_shadow = vcpu->arch.guest_csr.vsip;
>>         }
>> }
>>
>> And just call this unconditionally from kvm_vcpu_ioctl_run.  The cost is
>> just a memory load per VS-mode entry, it should hardly be measurable.
> 
> I think we can do this at start of kvm_riscv_vcpu_flush_interrupts() as well.

Did you mean at the end?  (That is, after modifying
vcpu->arch.guest_csr.vsip based on mask and val).  With the above switch
to percpu, the only write of CSR_VSIP and vsip_shadow should be in
kvm_riscv_vcpu_flush_interrupts, which in turn is only called from
kvm_vcpu_ioctl_run.

Thanks,

Paolo
