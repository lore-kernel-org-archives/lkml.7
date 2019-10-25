Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5CCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9002720684
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C5PVodu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfJYXKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:10:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34242 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYXKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:10:47 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so4261812ion.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Nw2n9QTFh5kHjw8cqYYhuXZ+PymsFnyOpi7WiO2JCuo=;
        b=C5PVodu/0MW6W82UHHNT1HEG10+OYbI9GS0eNEymZeA/7BqJWFvlAA+UABDMo1KlR7
         KhrSi65xovCBcBeJjja/4QdhiHUONlY1lP5QkiN5o2J5GQJLPXD1Oj8JVraZcMrbAQLv
         wu4tYpl70lY6bVa7lvDZWBovLJFZXAWMu+lz218bMd5r2muD8k7oU6RF4Ygne7oUa/hE
         /OTFHWPbXIDiGNKGAfEGzW/G6C/rLKsx5BqsoUAUA4yCcwN6oB4M6Brf8BPXkuzPaMa8
         wgjcMQIqLnZEygzWAlhI/9oc3jcADO8k2c3cJHeawEqzK+d58qwFyAGx4sN/tXklxQ+1
         qlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Nw2n9QTFh5kHjw8cqYYhuXZ+PymsFnyOpi7WiO2JCuo=;
        b=gCGAix13ppNYGLJwvY/qURAPvT3b9kPVi5z0Az9Fl9APW37HYTxfKg4O18ByWIz4UA
         jN5yGMKtkGr35cdTvGM2wrxAPSfntFL5XpY1INIfhX8R8k8pOWDBm60C2GCEs23Nliln
         vq+MBn8isfUfl/mLRnXJRN3XNvHsNiLkrlAADvNbh4bFkmrLJQK52Ukq4oe2WhbHa8mq
         FGoNjGfkzYCoNVyO/TjJ/Zt+Kl6mJq7M6S3Naznyusv3pPJAtQUgaQp8XvgtYG9pMqZ8
         h3GL2uOGtPPLEDn8UHNYlTPclb4j2ehstNBgQqdl6cTydkzHmtgSQGT0TWk4OTj0zuIP
         AdHg==
X-Gm-Message-State: APjAAAXBCNvM70dppdIogTHNsfH9x7BzTRA+Orn/0j6hB+zGRzUGodrA
        dUAVMO3nMFHQUSsz9WgbMcdGLw==
X-Google-Smtp-Source: APXvYqz9QtjxasedL+eeZEZOfOFKJkfn7+/rp0EGhSA9G0+osf8i+y4YZrwICvDdaAfSp7dhwzACWA==
X-Received: by 2002:a5d:9dce:: with SMTP id 14mr2147247ioo.166.1572045045576;
        Fri, 25 Oct 2019 16:10:45 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id j22sm375958iok.42.2019.10.25.16.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 16:10:44 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:10:42 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/22] KVM RISC-V Support
In-Reply-To: <20191016160649.24622-1-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1910251609500.12828@viisi.sifive.com>
References: <20191016160649.24622-1-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Wed, 16 Oct 2019, Anup Patel wrote:

> This series adds initial KVM RISC-V support. Currently, we are able to boot
> RISC-V 64bit Linux Guests with multiple VCPUs.
> 
> Few key aspects of KVM RISC-V added by this series are:
> 1. Minimal possible KVM world-switch which touches only GPRs and few CSRs.
> 2. Full Guest/VM switch is done via vcpu_get/vcpu_put infrastructure.
> 3. KVM ONE_REG interface for VCPU register access from user-space.
> 4. PLIC emulation is done in user-space.
> 5. Timer and IPI emuation is done in-kernel.
> 6. MMU notifiers supported.
> 7. FP lazy save/restore supported.
> 8. SBI v0.1 emulation for KVM Guest available.
> 9. Forward unhandled SBI calls to KVM userspace.
> 10. Hugepage support for Guest/VM

Several patches in this series cause 'checkpatch.pl --strict' to flag 
issues.  When you respin this series, could you fix those, please?


thanks,

- Paul
