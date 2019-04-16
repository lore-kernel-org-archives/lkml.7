Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD620656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfBT2kKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfDPPSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:18:11 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33356 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPPSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:18:11 -0400
Received: by mail-yb1-f195.google.com with SMTP id i10so7887150ybk.0;
        Tue, 16 Apr 2019 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fgo1Yv46PkD8nU9lBpKxuLN2AtY5LeZK0r1vAHlU+Qo=;
        b=hfBT2kKBJIFlyUVZa/bTZaEmmgV6Hb3kOKU4zWmPFERS5Bifqr4UiE29w3Gawg9jm5
         SfyPF3HUXW0ho1aTUvQ6TF5axUm2KKTM0h6vN9vSsWOhNuc6FGVQAIITSlWpOBHLJ8LU
         3QHeu1wiJ9oWWBczbPhlKlaS2RjuyaUpOSDUvvM4ZhERdzMvOVp/LH5gyfY985gm1h9P
         V8BOtWcpxMHhmC44jgIk7VQuxhkAoVqJbh+olsWdgjnxfT0CQE+7erjPBtyGDKZ5OxoH
         s9zVS0eKn1akr7gy15UAqbmHDQ2TSofZO96e7LEs1cHD0QkIMrMqKrXWTjs0ZiK7x3G0
         fc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fgo1Yv46PkD8nU9lBpKxuLN2AtY5LeZK0r1vAHlU+Qo=;
        b=no4jKzfyL2LXV63ECwmhWnWhqFNf74WsKzgrEi32f65QXbItpE1KqqDEb4P+02OW1P
         AGHUjQXCN60qtMn/PF94lkuB+l9gwaBn1YP6XmMmKD0pbcbAM6IDLEAFY0n9DvecHZQV
         v1qnbx0MtZTpE2bOxfbwH1wG34UWn+jL8f5X4DtS2muqvJXI2pRcmCQXlNlUFkV0DVRU
         5rAlnd/SfYRfjPa5vGnBlWPj1ho6+ekXRpdv7FKdAkZh2zG3gj4kMCTOf/YxKAZs3ZO8
         L1JTSD4vL5ZBuIeS7W/m7HIQrg2bk6g/EXU3of47uq4qhQE1+qQAb51EIQJBqoVSmiRo
         b4YA==
X-Gm-Message-State: APjAAAUvrjlmwKgQeUUzNjAujfdbz0ARsXxF8DpS+lQg8FEzsySFOe88
        h7tr0i9Y1eESDuxHEW5FjPLCCrWjqGQ=
X-Google-Smtp-Source: APXvYqy6Af4VijgWKNL0rg8HrlT2UaVqvRH0EbIDqAvZSckVnq7Ggs4y7VDvFOiJ6INKFJY/NApFQw==
X-Received: by 2002:a25:1102:: with SMTP id 2mr7600362ybr.456.1555427889616;
        Tue, 16 Apr 2019 08:18:09 -0700 (PDT)
Received: from nishad ([2406:7400:54:eb3:d9be:857a:cd1e:eb7f])
        by smtp.gmail.com with ESMTPSA id v184sm18518928ywa.2.2019.04.16.08.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:18:08 -0700 (PDT)
Date:   Tue, 16 Apr 2019 20:47:57 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] ARCH: Use the correct style for SPDX License
 Identifier
Message-ID: <cover.1555427418.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in the Hardware Architecture subsystem. For C header files
Documentation/process/license-rules.rst mandates C-like comments
(opposed to C source files where C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46
and making some manual changes.

Changes in v3:
 - Split the patch by architecture so that the repective maintainers
   can pick it up.
Changes in v2:
 - Added a note in the patch description.

Nishad Kamdar (5):
  arm64: Use the correct style for SPDX License Identifier
  nds32: Use the correct style for SPDX License Identifier
  powerpc: Use the correct style for SPDX License Identifier
  sh: Use the correct style for SPDX License Identifier
  x86: Use the correct style for SPDX License Identifier

 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h     | 2 +-
 arch/arm64/include/asm/pointer_auth.h             | 2 +-
 arch/arm64/include/asm/sdei.h                     | 2 +-
 arch/arm64/include/asm/vmap_stack.h               | 2 +-
 arch/nds32/include/asm/assembler.h                | 2 +-
 arch/nds32/include/asm/barrier.h                  | 2 +-
 arch/nds32/include/asm/bitfield.h                 | 2 +-
 arch/nds32/include/asm/cache.h                    | 2 +-
 arch/nds32/include/asm/cache_info.h               | 2 +-
 arch/nds32/include/asm/cacheflush.h               | 2 +-
 arch/nds32/include/asm/current.h                  | 2 +-
 arch/nds32/include/asm/delay.h                    | 2 +-
 arch/nds32/include/asm/elf.h                      | 2 +-
 arch/nds32/include/asm/fixmap.h                   | 2 +-
 arch/nds32/include/asm/futex.h                    | 2 +-
 arch/nds32/include/asm/highmem.h                  | 2 +-
 arch/nds32/include/asm/io.h                       | 2 +-
 arch/nds32/include/asm/irqflags.h                 | 2 +-
 arch/nds32/include/asm/l2_cache.h                 | 2 +-
 arch/nds32/include/asm/linkage.h                  | 2 +-
 arch/nds32/include/asm/memory.h                   | 2 +-
 arch/nds32/include/asm/mmu.h                      | 2 +-
 arch/nds32/include/asm/mmu_context.h              | 2 +-
 arch/nds32/include/asm/module.h                   | 2 +-
 arch/nds32/include/asm/nds32.h                    | 2 +-
 arch/nds32/include/asm/page.h                     | 2 +-
 arch/nds32/include/asm/pgalloc.h                  | 2 +-
 arch/nds32/include/asm/pgtable.h                  | 2 +-
 arch/nds32/include/asm/proc-fns.h                 | 2 +-
 arch/nds32/include/asm/processor.h                | 2 +-
 arch/nds32/include/asm/ptrace.h                   | 2 +-
 arch/nds32/include/asm/shmparam.h                 | 2 +-
 arch/nds32/include/asm/string.h                   | 2 +-
 arch/nds32/include/asm/swab.h                     | 2 +-
 arch/nds32/include/asm/syscall.h                  | 2 +-
 arch/nds32/include/asm/syscalls.h                 | 2 +-
 arch/nds32/include/asm/thread_info.h              | 2 +-
 arch/nds32/include/asm/tlb.h                      | 2 +-
 arch/nds32/include/asm/tlbflush.h                 | 2 +-
 arch/nds32/include/asm/uaccess.h                  | 2 +-
 arch/nds32/include/asm/unistd.h                   | 2 +-
 arch/nds32/include/asm/vdso.h                     | 2 +-
 arch/nds32/include/asm/vdso_datapage.h            | 2 +-
 arch/nds32/include/asm/vdso_timer_info.h          | 2 +-
 arch/nds32/include/uapi/asm/auxvec.h              | 2 +-
 arch/nds32/include/uapi/asm/byteorder.h           | 2 +-
 arch/nds32/include/uapi/asm/cachectl.h            | 2 +-
 arch/nds32/include/uapi/asm/param.h               | 2 +-
 arch/nds32/include/uapi/asm/ptrace.h              | 2 +-
 arch/nds32/include/uapi/asm/sigcontext.h          | 2 +-
 arch/nds32/include/uapi/asm/unistd.h              | 2 +-
 arch/powerpc/include/asm/pnv-ocxl.h               | 2 +-
 arch/sh/drivers/pci/pci-sh5.h                     | 4 ++--
 arch/sh/drivers/pci/pci-sh7751.h                  | 4 ++--
 arch/sh/drivers/pci/pci-sh7780.h                  | 4 ++--
 arch/sh/drivers/pci/pcie-sh7786.h                 | 4 ++--
 arch/sh/include/asm/addrspace.h                   | 4 ++--
 arch/sh/include/asm/bl_bit_64.h                   | 4 ++--
 arch/sh/include/asm/cache_insns_64.h              | 4 ++--
 arch/sh/include/asm/device.h                      | 4 ++--
 arch/sh/include/asm/dma-register.h                | 4 ++--
 arch/sh/include/asm/dma.h                         | 4 ++--
 arch/sh/include/asm/dwarf.h                       | 4 ++--
 arch/sh/include/asm/fixmap.h                      | 4 ++--
 arch/sh/include/asm/flat.h                        | 4 ++--
 arch/sh/include/asm/freq.h                        | 4 ++--
 arch/sh/include/asm/gpio.h                        | 4 ++--
 arch/sh/include/asm/machvec.h                     | 4 ++--
 arch/sh/include/asm/pgtable.h                     | 4 ++--
 arch/sh/include/asm/sfp-machine.h                 | 4 ++--
 arch/sh/include/asm/shmparam.h                    | 4 ++--
 arch/sh/include/asm/siu.h                         | 4 ++--
 arch/sh/include/asm/spinlock-cas.h                | 4 ++--
 arch/sh/include/asm/spinlock-llsc.h               | 4 ++--
 arch/sh/include/asm/spinlock.h                    | 4 ++--
 arch/sh/include/asm/switch_to.h                   | 4 ++--
 arch/sh/include/asm/switch_to_64.h                | 4 ++--
 arch/sh/include/asm/tlb_64.h                      | 4 ++--
 arch/sh/include/asm/traps_64.h                    | 4 ++--
 arch/sh/include/asm/watchdog.h                    | 4 ++--
 arch/sh/include/cpu-common/cpu/addrspace.h        | 4 ++--
 arch/sh/include/cpu-common/cpu/mmu_context.h      | 4 ++--
 arch/sh/include/cpu-common/cpu/pfc.h              | 4 ++--
 arch/sh/include/cpu-sh2/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh2/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh2/cpu/watchdog.h            | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/cache.h              | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/freq.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/dma-register.h        | 4 ++--
 arch/sh/include/cpu-sh3/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh3/cpu/gpio.h                | 4 ++--
 arch/sh/include/cpu-sh3/cpu/mmu_context.h         | 4 ++--
 arch/sh/include/cpu-sh3/cpu/watchdog.h            | 4 ++--
 arch/sh/include/cpu-sh4/cpu/addrspace.h           | 4 ++--
 arch/sh/include/cpu-sh4/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh4/cpu/dma-register.h        | 4 ++--
 arch/sh/include/cpu-sh4/cpu/fpu.h                 | 4 ++--
 arch/sh/include/cpu-sh4/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh4/cpu/mmu_context.h         | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sh7786.h              | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sq.h                  | 4 ++--
 arch/sh/include/cpu-sh4/cpu/watchdog.h            | 4 ++--
 arch/sh/include/mach-common/mach/hp6xx.h          | 4 ++--
 arch/sh/include/mach-common/mach/magicpanelr2.h   | 4 ++--
 arch/sh/include/mach-common/mach/mangle-port.h    | 4 ++--
 arch/sh/include/mach-common/mach/microdev.h       | 4 ++--
 arch/sh/include/mach-common/mach/secureedge5410.h | 4 ++--
 arch/sh/include/mach-dreamcast/mach/dma.h         | 4 ++--
 arch/sh/include/mach-dreamcast/mach/pci.h         | 4 ++--
 arch/sh/include/mach-dreamcast/mach/sysasic.h     | 4 ++--
 arch/sh/include/mach-se/mach/se7721.h             | 4 ++--
 arch/x86/include/asm/cpu_entry_area.h             | 2 +-
 arch/x86/include/asm/pti.h                        | 2 +-
 arch/x86/kernel/process.h                         | 2 +-
 115 files changed, 175 insertions(+), 175 deletions(-)

-- 
2.17.1

