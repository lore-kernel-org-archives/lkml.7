Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D78C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C7C205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfG2UIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:08:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33054 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfG2UId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so43764208wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6rsC8apArHKEVoNHEE6WG1aGK7OUBEY0mfmbG+EETjA=;
        b=H1azFqjdQbGzYylgI0HfhobbrDa1fXZCrhjr/xbfTQ3GrM1HfJth4ol7CblK/OvV1B
         5l1UXrq/AgWYduSIlH2K9B72Ha25v3cvYXeLm6duV10AAN4l/tDOboj+J2Oxm55xUHyi
         ucL1i0gFBbnYxgAbD5XiJniwDjv4JTevpZWPSFiBiRolvikpClTAfiZ1ucxc7poBnpbu
         8+XPgwSCxg28cqdeXpOJd0uQX9H9N5Px1qRZrVOWtrulaUvwdTd64RngQP16UAUqkVAG
         wA+XmyS8EzRlyb9nLWZrn0HhTs78XyCh0wCnAYcFynCw0nf3HRKOQO7bviijwVUfznhW
         aORg==
X-Gm-Message-State: APjAAAWFmx/zqKStmmShFsEj0A9OO4DPsukGPFs4OtuNjBn6AiclOXe1
        mbElpTQKwgg8Bs7Il/p6wfZLAnExIeU=
X-Google-Smtp-Source: APXvYqxyEEo5XtUOjp1CdVRP84iqaQNMR2dGcZMgh/1fmCKwlmEs/P5oV9wEcoLLXuWQbjicsjgaWQ==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr101100699wmg.152.1564430911427;
        Mon, 29 Jul 2019 13:08:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id j33sm131236463wre.42.2019.07.29.13.08.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:30 -0700 (PDT)
Subject: Re: [RFC PATCH 15/16] RISC-V: KVM: Add SBI v0.1 support
To:     Atish Patra <Atish.Patra@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <20190729115544.17895-16-anup.patel@wdc.com>
 <b461c82f-960a-306e-b76b-f2c329cabf21@redhat.com>
 <0e19ff14a51e210af91c4b0f2e649b8f5e140ce1.camel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b6c884cc-e156-d125-b3a2-c8a843de34c2@redhat.com>
Date:   Mon, 29 Jul 2019 22:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0e19ff14a51e210af91c4b0f2e649b8f5e140ce1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 21:51, Atish Patra wrote:
> On Mon, 2019-07-29 at 21:40 +0200, Paolo Bonzini wrote:
>> On 29/07/19 13:57, Anup Patel wrote:
>>> +	csr_write(CSR_HSTATUS, vcpu->arch.guest_context.hstatus |
>>> HSTATUS_SPRV);
>>> +	csr_write(CSR_SSTATUS, vcpu->arch.guest_context.sstatus);
>>> +	val = *addr;
>>
>> What happens if this load faults?
>>
> 
> It should redirect the trap back to VS mode. Currently, it is not
> implemented. It is on the TO-DO list for future iteration of the
> series.

Ok, please add TODO comments for the more important tasks like this one
(and/or post a somewhat complete list in reply to 00/16).

Thanks!

Paolo

