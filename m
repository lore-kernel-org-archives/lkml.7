Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C16C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8782173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404606AbfHBJDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:03:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46783 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404594AbfHBJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:03:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so76347733wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bwx8/3+omec7zmijOtKif9DQxXapLJoupah+QfmoXjM=;
        b=g8FcP7JknYEE1sKM2vKWm8K7gy6qq+XCKyGs7BwLM8+t461q4pRXZrhMwdqrInQ9ws
         w6wvLn51kNbVft1bSTxy6zAzBxrqzvndOHdQlWVbnm/PXxQqZQfaprpkWSsu+fz4Pwhr
         z3J+nTydkqx7kKNYa04NKPqK6lIbhYqhbgvMuz/QqZsfxz/ps18J00cX+EqTFkB14Oh4
         UDSkEmuj0Hm77lhZQ05V6DC6vglpB63hAP26vnm1bOd1p8eBCyfPzjFsCFNclmGfQDV1
         /Zy0QbT969/sStbd2iisxnHAo8i3vN/Nc9fEqVvfXlQx5JkEIdE1eFFvBg11RvqyXkKw
         YvHQ==
X-Gm-Message-State: APjAAAXefOW8EcBRm031QXye9yyZV6JOZj0gobThg+n+qMee2YF19g1Q
        YwelppH5tHsscFvxm9wf2ochwPz/9zI=
X-Google-Smtp-Source: APXvYqzL/HKYIOOtRRO6u1IKHQOTKAtJRMqcFBTlwICbd/6fS4zdHbTSm6by+RvwTllnE7+5D6q80Q==
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr36191018wrt.182.1564736625330;
        Fri, 02 Aug 2019 02:03:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id c30sm140911490wrb.15.2019.08.02.02.03.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 02:03:44 -0700 (PDT)
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
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
 <20190802074620.115029-8-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <03f60f3a-bb50-9210-8352-da16cca322b9@redhat.com>
Date:   Fri, 2 Aug 2019 11:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074620.115029-8-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 09:47, Anup Patel wrote:
> +	if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
> +		kvm_riscv_vcpu_flush_interrupts(vcpu, false);

Not updating the vsip CSR here can cause an interrupt to be lost, if the
next call to kvm_riscv_vcpu_flush_interrupts finds a zero mask.

You could add a new field vcpu->vsip_shadow that is updated every time
CSR_VSIP is written (including kvm_arch_vcpu_load) with a function like

void kvm_riscv_update_vsip(struct kvm_vcpu *vcpu)
{
	if (vcpu->vsip_shadow != vcpu->arch.guest_csr.vsip) {
		csr_write(CSR_VSIP, vcpu->arch.guest_csr.vsip);
		vcpu->vsip_shadow = vcpu->arch.guest_csr.vsip;
	}
}

And just call this unconditionally from kvm_vcpu_ioctl_run.  The cost is
just a memory load per VS-mode entry, it should hardly be measurable.

Paolo
