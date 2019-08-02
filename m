Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C4C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985F20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfHBIRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:17:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36411 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfHBIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:17:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so76303584wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=APOXhup+sZGXS5d0UC7uGeTiWB/G8v81K64OFOYtTQY=;
        b=imgQeg8WKX5elrpnBo5+Jyc+J2wa2D6bHcCGZPczcMLi+Si978q+Pm1oJdvXaBN/sG
         Go4EDCHwDom1dD+oVVrjxltqgt0kK8H538G0OI7Vd9pQTJ6sD0PusF/sXoxcudd9uGCy
         aoeQXIrToTU0H4VSLwVAzplkSD3IIZtxj2rHA1SLZkSGR3rpi/ywh0Gp2z/kObf9bIzJ
         J9Kt8q+xI2+PuYhAAPnpOTDbZaT2KYOQPeTxC+YuiKcwTj4FjiP7qnkJWgVQ+F/30pzK
         AKnYXDf+a2x4cQO8yWCw16eBnmeiFoQOy52NodztMx3OO42O+C/Gb+r1RamZqGUFdM2d
         okQA==
X-Gm-Message-State: APjAAAU9mbrJ8TwNkRMx3SjThoW4j9algHPhR5QWX12e7SIAG7CN/Cei
        uQvaAnZUSJ5gQW3RAPngCoDSAf1UL7M=
X-Google-Smtp-Source: APXvYqxouFvTCxPN5ary3LSNHZng7Fu6r6547Mi/qZeNJXWg0W3zH8U/xLY5N3dAloNhdOrtFxV+kg==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr7547509wrp.202.1564733864909;
        Fri, 02 Aug 2019 01:17:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id p18sm75207312wrm.16.2019.08.02.01.17.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 01:17:44 -0700 (PDT)
Subject: Re: [RFC PATCH v2 06/19] RISC-V: KVM: Implement VCPU interrupts and
 requests handling
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
 <20190802074620.115029-7-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <98eaa917-8270-ecdc-2420-491ed1c903d8@redhat.com>
Date:   Fri, 2 Aug 2019 10:17:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802074620.115029-7-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/19 09:47, Anup Patel wrote:
> +	/* VCPU interrupts */
> +	unsigned long irqs_pending;
> +	unsigned long irqs_pending_mask;
> +

This deserves a comment on the locking policy (none for producer,
vcpu_lock for consumers).

Paolo
