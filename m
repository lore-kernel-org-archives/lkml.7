Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82285C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6162921922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389208AbfHGUJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:09:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388554AbfHGUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:09:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id k2so6743061wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 13:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B4SZgwl/qCV8DOS3DiN8urgpbd3u1AoDxbn9aPznbyk=;
        b=Z7iyyVifhSUw9PwLfbgae2n6sDM/js7zvpXlv4eoYpETtCzfPQ+/VdrBytiRwqjCPJ
         2TzbbCjcLPy2ixdYmtk0UWQEVvyuDIwRQk6GI+nCQTxH6wWJ+AqVGEax6Tt1wmW3qjcQ
         hHEbBmNFBsya1b/aLoMQAFDvrGHbUpvNyo/6HpVzHsa/+wSRLcC0hfqfHnvCMWretNwQ
         P0VlzZL4HcIlHFJk0B9H2kKIQs0g434q6V/MvYE0wP9hcrKxcwFSqZKBsP2u/n4dSkgd
         AMEh7BDaqe0JhwmDymmfCYQArLq5xanqxndud8MUPP7Dr8c5E3TnvQWQA04BVUwwM1B+
         K+pg==
X-Gm-Message-State: APjAAAXvaABd9B2JRjZO6UAW7pgPT9tVyYkVl5SI2L+2T0YEToDEqfWo
        40Lqe4waG1jsSxdLRGId65dJACmzXhdjjg==
X-Google-Smtp-Source: APXvYqzBRo3CYTFQe4giwdi6nAFwuh8jFzMIZ5ZJD0e+DuwaiLHg0MDSZlCf/S35yeXMs+6d7TEGlw==
X-Received: by 2002:adf:8183:: with SMTP id 3mr12621646wra.181.1565208544995;
        Wed, 07 Aug 2019 13:09:04 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o11sm63655wmh.37.2019.08.07.13.09.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 13:09:04 -0700 (PDT)
Subject: Re: [PATCH v4 00/20] KVM RISC-V Support
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
References: <20190807122726.81544-1-anup.patel@wdc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4a991aa3-154a-40b2-a37d-9ee4a4c7a2ca@redhat.com>
Date:   Wed, 7 Aug 2019 22:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807122726.81544-1-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/19 14:27, Anup Patel wrote:
> This series adds initial KVM RISC-V support. Currently, we are able to boot
> RISC-V 64bit Linux Guests with multiple VCPUs.

Looks good to me!  Still need an Acked-by from arch/riscv folks if I
have to merge it, otherwise they can take care of the initial merge.

Paolo

> Few key aspects of KVM RISC-V added by this series are:
> 1. Minimal possible KVM world-switch which touches only GPRs and few CSRs.
> 2. Full Guest/VM switch is done via vcpu_get/vcpu_put infrastructure.
> 3. KVM ONE_REG interface for VCPU register access from user-space.
> 4. PLIC emulation is done in user-space. In-kernel PLIC emulation, will
>    be added in future.
> 5. Timer and IPI emuation is done in-kernel.
> 6. MMU notifiers supported.
> 7. FP lazy save/restore supported.
> 8. SBI v0.1 emulation for KVM Guest available.
> 
> Here's a brief TODO list which we will work upon after this series:
> 1. Handle trap from unpriv access in reading Guest instruction
> 2. Handle trap from unpriv access in SBI v0.1 emulation
> 3. Implement recursive stage2 page table programing
> 4. SBI v0.2 emulation in-kernel
> 5. SBI v0.2 hart hotplug emulation in-kernel
> 6. In-kernel PLIC emulation
> 7. ..... and more .....
> 
> This series can be found in riscv_kvm_v4 branch at:
> https//github.com/avpatel/linux.git
> 
> Our work-in-progress KVMTOOL RISC-V port can be found in riscv_v1 branch at:
> https//github.com/avpatel/kvmtool.git
> 
> We need OpenSBI with RISC-V hypervisor extension support which can be
> found in hyp_ext_changes_v1 branch at:
> https://github.com/riscv/opensbi.git
> 
> The QEMU RISC-V hypervisor emulation is done by Alistair and is available
> in riscv-hyp-work.next branch at:
> https://github.com/alistair23/qemu.git
> 
> To play around with KVM RISC-V, here are few reference commands:
> 1) To cross-compile KVMTOOL:
>    $ make lkvm-static
> 2) To launch RISC-V Host Linux:
>    $ qemu-system-riscv64 -monitor null -cpu rv64,h=true -M virt \
>    -m 512M -display none -serial mon:stdio \
>    -kernel opensbi/build/platform/qemu/virt/firmware/fw_jump.elf \
>    -device loader,file=build-riscv64/arch/riscv/boot/Image,addr=0x80200000 \
>    -initrd ./rootfs_kvm_riscv64.img \
>    -append "root=/dev/ram rw console=ttyS0 earlycon=sbi"
> 3) To launch RISC-V Guest Linux with 9P rootfs:
>    $ ./apps/lkvm-static run -m 128 -c2 --console serial \
>    -p "console=ttyS0 earlycon=uart8250,mmio,0x3f8" -k ./apps/Image --debug
> 4) To launch RISC-V Guest Linux with initrd:
>    $ ./apps/lkvm-static run -m 128 -c2 --console serial \
>    -p "console=ttyS0 earlycon=uart8250,mmio,0x3f8" -k ./apps/Image \
>    -i ./apps/rootfs.img --debug
> 
> Changes since v3:
> - Moved patch for ISA bitmap from KVM prep series to this series
> - Make vsip_shadow as run-time percpu variable instead of compile-time
> - Flush Guest TLBs on all Host CPUs whenever we run-out of VMIDs

