Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396BAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1534020856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfHELHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:07:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38773 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHELHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:07:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so83971180wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbcOsE9b8vLYsdBbVt92rvn4fVfUC3MaKB8N6ShV3KU=;
        b=WRcUAOBFlybhKmHvXXM2CzVA/vAY5HvybKac+diMpX48EKw3Tj9JFYfaV//G7XUjcw
         2bAx35KaDZ1hr7uNbdzWn1jSGllqe7o/zjVwmw89e1Rf9VDKU4eaXTLsreJjDTzyNSk2
         0uVKY2OAMY/QfEiEdWyAhR0jm0rWret21mLPNkZjhgdr9B8LdBUfEjDMzXwmelvjKOrC
         xLP3RKy+Cove1P4u57u/IL5Ai7xq7xNPrQwtp2Ofzu9VeBbPpphyZ/TvPV3odgpdgFMW
         c4Hin+zBMk3R7u/OeTr/vgY9svDj0EUgnD6MxPcms+2LAom2PtJXCqWXVKral4j910K7
         Wbnw==
X-Gm-Message-State: APjAAAV770HHbYMdgYDTStyQ9SumJ8jptjbLOI/3r+ZPoNfQHUkDT/Gm
        hoASN9Qm28RoGlh6Db7cG0fOutVPGDI=
X-Google-Smtp-Source: APXvYqwY2TBupRh8lLMErANvtlHmxHCz+tcgLZffCnKnX9W2SmLjysi6ybgwKxpN5XbDXgTAKzNV8Q==
X-Received: by 2002:adf:e541:: with SMTP id z1mr68507743wrm.48.1565003268629;
        Mon, 05 Aug 2019 04:07:48 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
        by smtp.gmail.com with ESMTPSA id a8sm70719207wma.31.2019.08.05.04.07.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:07:48 -0700 (PDT)
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
 <eb964565-10e1-bd44-c37c-774bf2f58049@redhat.com>
 <CAAhSdy1Voxuq=70Qkf__57MwE+DWEVayxLwu09Evnko=2kcweQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <faa951a8-249e-b751-02e0-9a71879dff9f@redhat.com>
Date:   Mon, 5 Aug 2019 13:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy1Voxuq=70Qkf__57MwE+DWEVayxLwu09Evnko=2kcweQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 13:00, Anup Patel wrote:
>>> I think we can do this at start of kvm_riscv_vcpu_flush_interrupts() as well.
>> Did you mean at the end?  (That is, after modifying
>> vcpu->arch.guest_csr.vsip based on mask and val).  With the above switch
>> to percpu, the only write of CSR_VSIP and vsip_shadow should be in
>> kvm_riscv_vcpu_flush_interrupts, which in turn is only called from
>> kvm_vcpu_ioctl_run.
> Yes, I meant at the end of kvm_riscv_vcpu_flush_interrupts() but I am
> fine having separate kvm_riscv_update_vsip() function as well.

At end is certainly fine for me.

Paolo
