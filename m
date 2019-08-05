Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E9C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6178206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfHEL4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:56:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfHEL4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:56:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so59051308wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TY4SwjXmEN9gc5bLylSn4Hg0/dB7NKueAsPGd6xGBoQ=;
        b=QB/BSZwdzuDkotLcFHtMEhOnmdWeZoV95B8M+SQMDirOTrzFWg6e8TJYUAGZh62Nld
         vG6BW3ehzIDr76Zq4QD7IXMA8PxsU81riK7ixXdm4ALLyZ8f5dnMPK9WQI7MnA3OOt+i
         M8SqsWH9i9rwzBCA8PYp9bL90gRdsPlX8/RQd1JYk23rNG87BriVKUK97MoUDLd3eDz4
         N4qshsk2Pr0C9gFLSJjY0Y9eg69UGZFgWd0l/dlqYvE1etBo21sZKE1LybCS/YVhdv2e
         q0cJW0OVTQ7ra6t/2JUVUX9uzk4W9R3I5tEEijMMB0f2mOfqFaL/WUMs2CfZU5+BTTJk
         XdFA==
X-Gm-Message-State: APjAAAUhpLnzXfsxi9z/xHSY66R2/7ZvHO3sCrvOmpUpXqDAg7pLnToi
        9jHYkNSuDxpiRn8mmSYYPdyvrJTxK3k=
X-Google-Smtp-Source: APXvYqyiW6VU1XQOFEG2eUsh/f6zKNWC3klkjjD7J05dOiekrtpHuIxq6IVPBKdC0E3ZEqXFzkJjhg==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr107334032wrt.278.1565006195708;
        Mon, 05 Aug 2019 04:56:35 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
        by smtp.gmail.com with ESMTPSA id v15sm77198646wrt.25.2019.08.05.04.56.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:56:35 -0700 (PDT)
Subject: Re: [RFC PATCH v2 07/19] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Anup Patel <Anup.Patel@wdc.com>,
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
 <edbed85f-f7ad-a240-1bef-75729b527a69@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8563b869-1ab4-d0f1-afad-9cd864b6019a@redhat.com>
Date:   Mon, 5 Aug 2019 13:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <edbed85f-f7ad-a240-1bef-75729b527a69@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/19 13:37, Christian Borntraeger wrote:
> While have ONE_REG will certainly work, have you considered the sync_reg scheme
> (registers as part of kvm_run structure)
> This will speed up the exit to QEMU as you do not have to do multiple ioctls
> (each imposing a systemcall overhead) for one exit. 
> 
> Ideally you should not exit too often into qemu, but for those cases sync_regs
> is faster than ONE_REG.

At least in theory, RISC-V should never have exits to QEMU that need
accessing the registers.  (The same is true for x86; Google implemented
sync_regs because they moved the instruction emulator to userspace in
their fork).

Paolo

