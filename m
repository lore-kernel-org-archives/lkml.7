Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB8C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8111820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfHEHOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:14:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38980 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfHEHOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:14:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so30069592wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 00:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xXNzFDoqWDF3bFjncF2L5fOVNU1OQ5j5piUBIWBmL0I=;
        b=efnObHL20oxxcYmlpLMKAVwYQCVkpxZZAT05Xs7eEHZ3YfQ4nHJnZJf3U5+g7Y/5jh
         +s4q5onnaxGJ+SILKl/tc1l6W/PfIaa0RiMyFIkp13r92L08y4KEB/QT0hABNNC3aPlH
         IzrHCTG+pW5iVhJVmB/WDZo7IHVReb9hkUa8DFfBxDekSqZjbSzgVsog5RHp85JU9QhL
         5DhZG9kb6U51JSHklhIDyFdHk2I4yKNnsh1X4SzQD6jxou5rTTPmoUGfPb6dbliNYcQC
         hO1hh64CbP/E6kKTCNZD+XPMeHAtN1j8vPWShB5dKrnIpSgjuQN6mdAtjTuKCHSsWR4j
         dLVg==
X-Gm-Message-State: APjAAAXvWwPmk9hOrMxugteFTHGDTr5abH7cpY2TwirX6+IgYxkJ9AYf
        Rx/RqTvs4+bzBNNMEP+BET2uvy+S7mk=
X-Google-Smtp-Source: APXvYqx5xT03XMyZCDbDAzBfRBcUMD25ISn8anlFxox0BiwSgKaltwaTiYWfWbosNFrA3zbrZE2mOg==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr42305386wrn.215.1564989285989;
        Mon, 05 Aug 2019 00:14:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id g11sm79705061wrq.92.2019.08.05.00.14.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 00:14:45 -0700 (PDT)
Subject: Re: [RFC PATCH v2 10/19] RISC-V: KVM: Handle WFI exits for VCPU
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
 <20190802074620.115029-11-anup.patel@wdc.com>
 <5b966171-4d11-237d-5a43-dc881efb7d0a@redhat.com>
 <CAAhSdy0BVqagYTTnaG2hwsxxM51ZZ2QpJbZtQ21v__8UaXCOWA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <458f6b85-cdb2-5e6b-6730-4875f0e4cdba@redhat.com>
Date:   Mon, 5 Aug 2019 09:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0BVqagYTTnaG2hwsxxM51ZZ2QpJbZtQ21v__8UaXCOWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 09:12, Anup Patel wrote:
> On Fri, Aug 2, 2019 at 2:33 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 02/08/19 09:47, Anup Patel wrote:
>>> +             if (!kvm_riscv_vcpu_has_interrupt(vcpu)) {
>>
>> This can be kvm_arch_vcpu_runnable instead, since kvm_vcpu_block will
>> check it anyway before sleeping.
> 
> I think we can skip this check here because kvm_vcpu_block() is
> checking it anyway. Agree ??

Yes, but it's quite a bit faster to do this outside the call.  There's a
bunch of setup before kvm_vcpu_block reaches that point, and it includes
mfences too once you add srcu_read_unlock/lock here.

Paolo
