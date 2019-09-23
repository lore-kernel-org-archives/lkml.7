Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F54C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01FB20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437097AbfIWNdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20927 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404581AbfIWNdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:33:18 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8144A89AC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:33:18 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f11so4847462wrt.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 06:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GE7K8CVGK2heIgLytQmrMIe2pNB3wHn4Xngpgn9CRvo=;
        b=uL96rh4H6p9N2yEcTkrZD25R3MBHNn0MfuvZu1iqJfORkc1sKeAW5cZaFasWsg7Cph
         PQINS/+wHWUvp+RZTP9mMlewdPqpgGa+xVavtu4Kz2CgKlaaTmqjM5VSXb4bZjIngcWo
         xFgce/SzqYkB5wjLPkMeuNJtIOjOb8QBSojc94WGFZ6edsxlRXtpQBEQ/7x6J0fAgKnR
         He7br63TCkWGi9VG0zgBN6V1SgOxjPEFSGXI2yDbUUXHX0bDHb/zggKvC5/nIpPwOK+h
         EpEe9C0DCWMCyXP4TRtsi9gVRb6m3lhYAhFQOVvmvCyZe4sBAk24FnAMaJr5XTTdnCqx
         CDeg==
X-Gm-Message-State: APjAAAX6XUw44TKpe51j/CRMTfl2tWoFqp2eXIauxE8DmoTZGaGCrr/i
        IF+rq2M/YASUNKUefL1CEI1x35D3NrKEK/tNjqWy12rJ3inSU4L8b30wYgzzL0vBHSv+H/nZPdz
        xVRpa21xNsMe0aC7X1jaW3TRf
X-Received: by 2002:a5d:65c3:: with SMTP id e3mr20529809wrw.211.1569245597060;
        Mon, 23 Sep 2019 06:33:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxn4cbY0hPCR2low1rLV+Gp6UtBZciARRAa8mBy7/FkikwZtI3kLUypi3t8SYdNoH1H62vBPw==
X-Received: by 2002:a5d:65c3:: with SMTP id e3mr20529781wrw.211.1569245596767;
        Mon, 23 Sep 2019 06:33:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id y186sm26462628wmd.26.2019.09.23.06.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 06:33:16 -0700 (PDT)
Subject: Re: [PATCH v7 10/21] RISC-V: KVM: Handle MMIO exits for VCPU
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190904161245.111924-1-anup.patel@wdc.com>
 <20190904161245.111924-12-anup.patel@wdc.com>
 <8c44ac8a-3fdc-b9dd-1815-06e86cb73047@redhat.com>
 <CAAhSdy1-1yxMnjzppmUBxtSOAuwWaPtNZwW+QH1O7LAnEVP8pg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <45fc3ee5-0f68-4e94-cfb3-0727ca52628f@redhat.com>
Date:   Mon, 23 Sep 2019 15:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy1-1yxMnjzppmUBxtSOAuwWaPtNZwW+QH1O7LAnEVP8pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 15:09, Anup Patel wrote:
>>> +#ifndef CONFIG_RISCV_ISA_C
>>> +                     "li %[tilen], 4\n"
>>> +#else
>>> +                     "li %[tilen], 2\n"
>>> +#endif
>>
>> Can you use an assembler directive to force using a non-compressed
>> format for ld and lw?  This would get rid of tilen, which is costing 6
>> bytes (if I did the RVC math right) in order to save two. :)
> 
> I tried looking for it but could not find any assembler directive
> to selectively turn-off instruction compression.

".option norvc"?

Paolo
