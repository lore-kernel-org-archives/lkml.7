Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F35621773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404570AbfHBJD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:03:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54130 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbfHBJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:03:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so67202855wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJhjj3mBwgft1ytEPPkTSsGclIEbwHaqa5f1BjqWwHE=;
        b=EMe8yzVqA7LTVm0H9PLg5fVB2Q7CYI+b6TW3EwaJebhMyOoPPnLYey2zDhISHl15of
         A851k4Mjg6K0hdKTjYl/tvGApqussL8aYWP8V5bJNN9m8RNZ7ar2BFR06dbTWUTUHt9Q
         NqR0UmhiMsY9NHChI5cV6B+Fj4+hfPs5e46cpGmoMAuTG64BRcfQNwbbB5uGwwsn9kOE
         FKh3VlaJeGSGZyzppsKOhqLMLwWAS5SdkL/Bp0sa7Xs0vEoyhe3kODXVRyjHTwUKW1Dl
         TSi7+hRfCb7AFXTJQ/x6S2+djqhMWFo9Xlr1N2J0bxoxjEJMz/AGsQxNRXC0Azp+zauh
         O8Jg==
X-Gm-Message-State: APjAAAWYLWkt4ygsIigVT3YdkZtaISG1cinHccFpCz4B0bn8NfNZ8wVP
        GUok1alfMuJfRtXj+y2i02B/4HvOfWI=
X-Google-Smtp-Source: APXvYqwsIb5IBIb6EjqofR+ghzM+7hHKpee/wh5qbODjTO4IntyFDdqwrWHi5Cj5QkR8IwdGqC0VFw==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr3454407wma.80.1564736606068;
        Fri, 02 Aug 2019 02:03:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id z5sm53295288wmf.48.2019.08.02.02.03.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 02:03:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2 10/19] RISC-V: KVM: Handle WFI exits for VCPU
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
 <20190802074620.115029-11-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5b966171-4d11-237d-5a43-dc881efb7d0a@redhat.com>
Date:   Fri, 2 Aug 2019 11:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074620.115029-11-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 09:47, Anup Patel wrote:
> +		if (!kvm_riscv_vcpu_has_interrupt(vcpu)) {

This can be kvm_arch_vcpu_runnable instead, since kvm_vcpu_block will
check it anyway before sleeping.

Paolo

> +			kvm_vcpu_block(vcpu);
> +			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> +		}

