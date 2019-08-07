Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FCBC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36D92184E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FGcfSyAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfHGXPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:15:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43701 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfHGXPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:15:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id j11so10718886otp.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=y5EH+uVVZi4pQVkeOf2HQsE+Jig/HWZWR6VmtoAY/1Y=;
        b=FGcfSyAeEFjqXYP2MrFafKVs59mKd5RhDN781c4BKDO2f/tstYFQWAk7ef9lbMC+VX
         n4iCrqINcgklwLrmdjb2Cos54LCdLCcyb7QcM7kuc8FOxBB3fRXTx6Oywwp9h6VWvx1H
         gmRm/yoxs4FAtigFdXUo+yrEGTaUIp6IprhAyYiqEWxZT0n2ymRbF1OSRkd4X0bN1mKN
         Q8lLzK9JQR5AiUsmP3QEDgPcCBrvfMvbWslxDAR9f2LPqkx8z6WvrM0fJwwLD+66SBoo
         r0DkKXC5icFFRcmDxjgHcNqpTjePFGswpj/5G8T1q2ISUiq2aRrWHMGxmYmNFhmRVtu2
         FbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=y5EH+uVVZi4pQVkeOf2HQsE+Jig/HWZWR6VmtoAY/1Y=;
        b=KTZFR1AJsF82VuLrx1lW90faM2Kf+jNMhUMJMKgohMecirHYYz83j5g8Pf8uJGg3Q+
         D/A3vXO8nuEwtNd/owt0P7nVH2NDjpjh0U7bsxSiwa+pyPkbtnRY5UF8yfSV92wEcLFz
         rX2fq+INFzNRunEiuZx1iBcKgvLLF9pk1jC9FEo4HqY5kOQ4m/IBkQc+idNCMGwgQk50
         vLC3b6xLrO7CrbO+zfd0o6jTKp98mWsPKZvO6DH5fDtGu8SFz2aZpAdIMDonU5AjllBU
         ccmwbrSUbvl+ASaWzApkQ0he2SZmzjEmTgXYquuWOPEKooNih+rN+uUKkQ2ner68uRLm
         iZGA==
X-Gm-Message-State: APjAAAV/2t9Xcx3UYcrxO4yx3bJuMRSfSvCSB7EYIsoTUZ2Eg/JjRYoX
        T0PdUFxCAI30ZxICFKlo2+lqBw==
X-Google-Smtp-Source: APXvYqybsW+ELbkjOgVjKbuZyZcQ6XTGYZ1w7r83yiScAbSQwX+IQI76DhcZQtcniQZcwYt7DLwiYg==
X-Received: by 2002:a5d:94d0:: with SMTP id y16mr10862099ior.123.1565219754480;
        Wed, 07 Aug 2019 16:15:54 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id j23sm74215587ioo.6.2019.08.07.16.15.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 16:15:54 -0700 (PDT)
Date:   Wed, 7 Aug 2019 16:15:53 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/20] KVM RISC-V Support
In-Reply-To: <4a991aa3-154a-40b2-a37d-9ee4a4c7a2ca@redhat.com>
Message-ID: <alpine.DEB.2.21.9999.1908071606560.13971@viisi.sifive.com>
References: <20190807122726.81544-1-anup.patel@wdc.com> <4a991aa3-154a-40b2-a37d-9ee4a4c7a2ca@redhat.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2019, Paolo Bonzini wrote:

> On 07/08/19 14:27, Anup Patel wrote:
> > This series adds initial KVM RISC-V support. Currently, we are able to boot
> > RISC-V 64bit Linux Guests with multiple VCPUs.
> 
> Looks good to me!  Still need an Acked-by from arch/riscv folks if I
> have to merge it, otherwise they can take care of the initial merge.

Since almost all of the patches touch arch/riscv files, we'll plan to 
merge them through the RISC-V tree.  Care to ack patch one, and send tags 
for any other patches as you think might be appropriate?

At the moment we're focused on dealing with a TLB flush-related critical 
stability bug in RISC-V kernel land.  Once that gets cleared up, we'll 
start pulling stuff in for the merge window.

Thanks for the speedy review,


- Paul
