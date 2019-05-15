Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C3FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5317420862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwkIwhec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEOKYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:24:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33127 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:24:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so2628501qtf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VF1vS3G86+JyyviSBTnGeyRAdDK6321ns1o68qnsEFU=;
        b=lwkIwhecfWX/tDLKzc8VdqHJkJpbhOhTyKZcxaWBPha90AwOblRBCJoPTfoYsG5asR
         x7kYV+1i+iu7NEpCGYVNy1oGD3lOX9UBqIIvq2GJspyjXE3SCLBfzH6kJ18ezT1amnpn
         3dbjuaAnNJyV02GfuY1N3LfQsOySeH3+Cjr3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VF1vS3G86+JyyviSBTnGeyRAdDK6321ns1o68qnsEFU=;
        b=jjBWhryHqAAyHpt/T5VRXRMqatDD+V8n+/VxELFEJdT2nCyEq9FJSJB5uH2ofjVMac
         f+coNZf9tmKXmXge/RHRj4Yjtr+ZO15S0Fx2no3Fx2zIZiNJMF/2IQTYA1B5MRNC0rzT
         tYD62WZWSeB8UDcZOqW1zTTF2ZVJ767+ZuTVHH34VSQca0+mvx3HeprkRiopnErC3DOP
         JcZaxAyRirFS9yxq/BbU0nHAcvRvfS3hAYaMPWh4NVnbnbepER4Mx3RePVcB7rvcPhy+
         excm8f6hCxpgoODgtS0Y6fIYNouctUuYGhIGxmxt0NiiQnzxL0KMJCEbjWsMdqDU1P87
         m76A==
X-Gm-Message-State: APjAAAVgIqUAekMP0gGc25NcCutjABt3mJLtu89d0Y9ULv7dBea9yaA9
        Iaw6mGQRXf/yc1+BjRYhw/zRhYBJv6NyWJ/mEWZt8A==
X-Google-Smtp-Source: APXvYqwJ3aw2EBWvbMfqY6pmIypZyyJaGuIQTDf+at1oH9RsnMy+pwkcQe7c5MAIBPn6XcOgFBmXDJQI5LsaEmxJs8M=
X-Received: by 2002:ad4:534b:: with SMTP id v11mr32936859qvs.31.1557915868951;
 Wed, 15 May 2019 03:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190513003819.356-1-hsinyi@chromium.org> <20190513003819.356-2-hsinyi@chromium.org>
 <20190513085853.GB9271@rapoport-lnx> <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
 <20190514154223.GA11115@rapoport-lnx>
In-Reply-To: <20190514154223.GA11115@rapoport-lnx>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 15 May 2019 18:24:03 +0800
Message-ID: <CAJMQK-gMa81kHaTS1kwTcOy+Avt5GsmNcagfscdLdmzS31Tobw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] amr64: map FDT as RW for early_init_dt_scan()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:42 PM Mike Rapoport <rppt@linux.ibm.com> wrote:

> I'm not sure if early console is available at the time kaslr_early_init()
> is called, but if yes, running with memblock=debug may shed some light.
>
> > I didn't trace the real reason causing this. But in this case, maybe
> > don't call memblock_reserve() in kaslr?
>
> My concern that this uncovered a real bug which might hit us later.
>
Hi Mike,
Thanks for the hint. I tried on my device but seems that earlycon
happens after the warning call trace, so can't more information.

Since on my device kaslr will be runned, I tried call
memblock_reserve() in kaslr and not in
setup_machine_fdt()#fixmap_remap_fdt, but got following warning

[    0.000000] memblock_remove:
[0x0001000000000000-0x0000fffffffffffe] arm64_memblock_init+0x28/0x224
[    0.000000] memblock_remove:
[0x0000004040000000-0x000000403ffffffe] arm64_memblock_init+0x64/0x224
[    0.000000] memblock_reserve:
[0x0000000040080000-0x00000000413c3fff]
arm64_memblock_init+0x188/0x224
[    0.000000] WARNING: CPU: 0 PID: 0 at
/mnt/host/source/src/third_party/kernel/v4.19/mm/memblock.c:583
memblock_add_range+0x1bc/0x1c8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.38 #222
[    0.000000] Hardware name: MediaTek kukui rev2 board (DT)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : memblock_add_range+0x1bc/0x1c8
[    0.000000] lr : memblock_add_range+0x30/0x1c8
[    0.000000] sp : ffffffab68603ea0
[    0.000000] x29: ffffffab68603ef0 x28: 0000000040954324
[    0.000000] x27: 0000000040080000 x26: 0000000000080000
[    0.000000] x25: 0000000080127e4b x24: ffffffab68716000
[    0.000000] x23: ffffffab680b5000 x22: 0000000001344000
[    0.000000] x21: 0000000040080000 x20: 0000000000000000
[    0.000000] x19: ffffffab6864bf00 x18: 00000000fffffc94
[    0.000000] x17: 000000000000003c x16: ffffffab67d49064
[    0.000000] x15: 0000000000000006 x14: 626d656d5f34366d
[    0.000000] x13: 7261205d66666633 x12: 0000000000000000
[    0.000000] x11: 0000000000000000 x10: ffffffffffffffff
[    0.000000] x9 : 0000000000011547 x8 : ffffffab68765690
[    0.000000] x7 : 696e695f6b636f6c x6 : ffffffab6875dd41
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : ffffffab678a24a0 x2 : 0000000001344000
[    0.000000] x1 : 0000000040080000 x0 : ffffffab6864bf00
[    0.000000] Call trace:
[    0.000000]  memblock_add_range+0x1bc/0x1c8
[    0.000000]  memblock_reserve+0x60/0xac
[    0.000000]  arm64_memblock_init+0x188/0x224
[    0.000000]  setup_arch+0x138/0x19c
[    0.000000]  start_kernel+0x68/0x380
[    0.000000] random: get_random_bytes called from
print_oops_end_marker+0x3c/0x58 with crng_init=0
[    0.000000] ---[ end trace ea99802b425f7adf ]---
[    0.000000] memblock_reserve:
[0x000000005f800000-0x000000005f811536]
early_init_dt_reserve_memory_arch+0x38/0x48
[    0.000000] memblock_reserve:
[0x00000000ffe00000-0x00000000ffffffff]
early_init_dt_reserve_memory_arch+0x38/0x48

So I guess we just can't call memblock_reserve() in kaslr?
