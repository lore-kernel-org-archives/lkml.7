Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A4C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146282133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7ipmsq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfEMLPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:15:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42927 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbfEMLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:14:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id j53so14122647qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZfFsSLpKN7HyaM6v93FCUf+4/Rm0naSo5dp2W2IoAs=;
        b=P7ipmsq9G0+9OQ54tSFpZgx4uejZvqKec5RS4a3yX+3drQ7fHtnDqSGIIgcnEEtqk7
         JkP2QLEsEoGnD0hS/v+0AtmraeSEhBrD6jM+/soz3CKbv0M54wMXOYJGVOld0lzQuNdh
         q0lc45XDBoD1Pt+YWPhZ7I4v05Ywg6KPt8S5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZfFsSLpKN7HyaM6v93FCUf+4/Rm0naSo5dp2W2IoAs=;
        b=RRfW6KS1Bn6yQsorVLuzU75nPbFvA4aaShIzEzYgHw01vglFzdaVSf+ihPGtyiwpp1
         fvWjvn14CbiiCdUkDkmMNuSVQgzKy5YIpXfAXWAMXvfp83DFhX2f7H3bQnSbhxGcDC9m
         7EzB0EosB0WxWKgBGZk7zxYxZKE82uHIGGnH+ocYDeIfSUHmk7VqXgLsiVYBNxuDzDDi
         Mc3nuhpPcXkU6ngLf3KPdITsHUzue7SF0Cq3l426PmfERQcfuMHaOV2K/D5g8fDkveVl
         P2ZfkGCZxSwVgOhwWaSSI1dMFT4ZxlBSKc0rtVh0FC7M1hy+B5QOU2/0FtuuQsrxCTmj
         0JVg==
X-Gm-Message-State: APjAAAXbc3+Lm+OvKDGLPjVLnZH/j8QaSXPLg2N0MZc8Ps/26Cr7D/a6
        Bsg3NVB1go989cWDY3yxZtp4Hhlg4TQBe+dVlTWDHA==
X-Google-Smtp-Source: APXvYqyBfY131U29dBbU/X4gXO3dZg+CiqpFSNzlD1lAHQ8Z1Q1egpybgdc6YHf9RPbXTaQ8EFaZSNZK9NLwjWHnaJY=
X-Received: by 2002:ac8:22d3:: with SMTP id g19mr1436241qta.236.1557746098383;
 Mon, 13 May 2019 04:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190513003819.356-1-hsinyi@chromium.org> <20190513003819.356-2-hsinyi@chromium.org>
 <20190513085853.GB9271@rapoport-lnx>
In-Reply-To: <20190513085853.GB9271@rapoport-lnx>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 13 May 2019 19:14:32 +0800
Message-ID: <CAJMQK-hKrU2J0_uGe3eO_JTNwM=HRkXbDx2u45izcdD7wqwGeQ@mail.gmail.com>
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

On Mon, May 13, 2019 at 4:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:

>
> This makes the fdt mapped without the call to meblock_reserve(fdt) which
> makes the fdt memory available for memblock allocations.
>
> Chances that is will be actually allocated are small, but you know, things
> happen.
>
> IMHO, instead of calling directly __fixmap_remap_fdt() it would be better
> to add pgprot parameter to fixmap_remap_fdt(). Then here and in kaslr.c it
> can be called with PAGE_KERNEL and below with PAGE_KERNEL_RO.
>
> There is no problem to call memblock_reserve() for the same area twice,
> it's essentially a NOP.
>
Thanks for the suggestion. Will update fixmap_remap_fdt() in next patch.

However, I tested on some arm64 platform, if we also call
memblock_reserve() in kaslr.c, would cause warning[1] when
memblock_reserve() is called again in setup_machine_fdt(). The warning
comes from https://elixir.bootlin.com/linux/latest/source/mm/memblock.c#L601
```
if (type->regions[0].size == 0) {
  WARN_ON(type->cnt != 1 || type->total_size);
  ...
```

Call memblock_reserve() multiple times after setup_machine_fdt()
doesn't have such warning though.

I didn't trace the real reason causing this. But in this case, maybe
don't call memblock_reserve() in kaslr?

[1]
[    0.000000] WARNING: CPU: 0 PID: 0 at
/mnt/host/source/src/third_party/kernel/v4.19/mm/memblock.c:583
memblock_add_range+0x1bc/0x1c8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.38 #125
[    0.000000] pstate: 600001c5 (nZCv dAIF -PAN -UAO)
[    0.000000] pc : memblock_add_range+0x1bc/0x1c8
[    0.000000] lr : memblock_add_range+0x30/0x1c8
[    0.000000] sp : ffffff9b5e203e80
[    0.000000] x29: ffffff9b5e203ed0 x28: 0000000040959324
[    0.000000] x27: 0000000040080000 x26: 0000000000080000
[    0.000000] x25: 0000000080127e4b x24: 0000000000000000
[    0.000000] x23: 0000001b55000000 x22: 000000000001152b
[    0.000000] x21: 000000005f800000 x20: 0000000000000000
[    0.000000] x19: ffffff9b5e24bf00 x18: 00000000ffffffb8
[    0.000000] x17: 000000000000003c x16: ffffffbefea00000
[    0.000000] x15: ffffffbefea00000 x14: ffffff9b5e3c17d8
[    0.000000] x13: 00e8000000000713 x12: 0000000000000000
[    0.000000] x11: ffffffbefea00000 x10: 00e800005f800710
[    0.000000] x9 : 000000000001152b x8 : ffffff9b5e365690
[    0.000000] x7 : 6f20646573616228 x6 : 0000000000000002
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : 0000000000200000 x2 : 000000000001152b
[    0.000000] x1 : 000000005f800000 x0 : ffffff9b5e24bf00
[    0.000000] Call trace:
[    0.000000]  memblock_add_range+0x1bc/0x1c8
[    0.000000]  memblock_reserve+0x60/0xac
[    0.000000]  fixmap_remap_fdt+0x4c/0x78
[    0.000000]  setup_machine_fdt+0x64/0xfc
[    0.000000]  setup_arch+0x68/0x1e0
[    0.000000]  start_kernel+0x68/0x380
