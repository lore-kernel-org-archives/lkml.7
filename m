Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86437C43630
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E3221D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PzfhRmxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392493AbfIYTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:48:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33839 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbfIYTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:48:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so5975525otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+2OKUfqw9V+eaDFB+P0UAy5luWT6sUT4VIfCQuUKoE=;
        b=PzfhRmxGvfcgdzRMXKka51SFc8xms7T1mFK/1GAOf6Adf1K/bF7WMKLvfNsMvwTwKU
         4KU1nHOjwkI1oL+weIVmtfqNrq28RwrOEwepoqxVo4Udw29lu52Tgv/YN4YIuv7PDvmH
         IyIWmfnXH+9PdxBWdMWrdwTCV5ua5P5ZTYTTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+2OKUfqw9V+eaDFB+P0UAy5luWT6sUT4VIfCQuUKoE=;
        b=r2PS6nIq0ycQmOqkzs848/3YOeJUJWxMrNKbv6tLevixQWPgwZW/JClwXdQ+On2OB8
         lIGSYnPsBPC2eQFtTVEfJJU5X9GZ/a2lopTsD7kWI89c4pI3fE3SalL7IuaQ08Ypsuxn
         IL/WGpYeVsNx0Chxq1YgA3KUf4CPueUQbi21LqyhPVrbuB5FrkNNToGzTCEtSXL2On2b
         TsVUMqfdODsjQkU92sPj2BnKkIE7oX6i7hXHjD7SxejS2Fl17tn2jJkBMuw53WH8uty/
         89WoB3XpYlRlKJH9tldBjhilZLB6L280sNzzNJFgNKtPLqQgQHPhwMTWChhu9vl0XVOn
         eV8A==
X-Gm-Message-State: APjAAAXXpbqXzbBAzKb65PlYgXuu0fSrV+wl4RAoU/7mWzPjBMVZE77y
        ajCtBL36x8UhrShn4qXKR/E2xuBNSUzKs1UHq0YFoNwj1Xc=
X-Google-Smtp-Source: APXvYqxm+YIbGKtXftN4Q/JlPalGEQxuRhBGL0nPr6KIPXNGH4y9WiL5t5qJuG1WAT4bEySzNpwDixq3ggKdrtFq9fs=
X-Received: by 2002:a9d:404:: with SMTP id 4mr166775otc.204.1569440935127;
 Wed, 25 Sep 2019 12:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <1569439345.3084.5.camel@suse.com>
In-Reply-To: <1569439345.3084.5.camel@suse.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 25 Sep 2019 21:48:44 +0200
Message-ID: <CAKMK7uHicakgeTEUhK63R4yKh+HMHCmy11L_o5PCSJoLG65BYg@mail.gmail.com>
Subject: Re: 4f5368b5541a902f6596558b05f5c21a9770dd32 causes regression
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sndirsch@suse.com, tzimmermann@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 9:37 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Hi,
>
> I am seeing a hard lockup during boot with this patch.
> I am using only the laptop's internal display.
> The last message I see is:

Should be fixed with

commit e0f32f78e51b9989ee89f608fd0dd10e9c230652 (tag:
drm-misc-next-fixes-2019-09-18)
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Sep 17 14:09:35 2019 +0200

    drm/kms: Duct-tape for mode object lifetime checks

which undoes any side-effect of the patch you're pointing at. I am
rather surprised though that this results in a hard-lookup for you,
did you confirm the bisect by reverting that commit on top of latest
upstream?

Cheers, Daniel

>
> kvm: disabled by BIOS
>
>         Regards
>                 Oliver
>
> devices are:
>
> 00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers [8086:1910] (rev 07)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information: Len=10 <?>
>         Kernel driver in use: skl_uncore
>
> 00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 120
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00003000-00003fff [size=4K]
>         Memory behind bridge: dc000000-dc0fffff [size=1M]
>         Prefetchable memory behind bridge: 0000000040000000-000000004fffffff [size=256M]
>         Capabilities: [88] Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Capabilities: [80] Power Management version 3
>         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [a0] Express Root Port (Slot+), MSI 00
>         Capabilities: [100] Virtual Channel
>         Capabilities: [140] Root Complex Link
>         Capabilities: [d94] #19
>         Kernel driver in use: pcieport
>
> 00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 530 [8086:191b] (rev 06) (prog-if 00 [VGA controller])
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0, IRQ 130
>         Memory at db000000 (64-bit, non-prefetchable) [size=16M]
>         Memory at 50000000 (64-bit, prefetchable) [size=256M]
>         I/O ports at 6000 [size=64]
>         [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>         Capabilities: [40] Vendor Specific Information: Len=0c <?>
>         Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [d0] Power Management version 2
>         Capabilities: [100] Process Address Space ID (PASID)
>         Capabilities: [200] Address Translation Service (ATS)
>         Capabilities: [300] Page Request Interface (PRI)
>         Kernel driver in use: i915
>         Kernel modules: i915
>
> 00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller [8086:a12f] (rev 31) (prog-if 30 [XHCI])
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, medium devsel, latency 0, IRQ 125
>         Memory at dc320000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [70] Power Management version 2
>         Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>         Kernel driver in use: xhci_hcd
>         Kernel modules: xhci_pci
>
> 00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-H Thermal subsystem [8086:a131] (rev 31)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: fast devsel, IRQ 18
>         Memory at dc34a000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>         Kernel driver in use: intel_pch_thermal
>         Kernel modules: intel_pch_thermal
>
> 00:16.0 Communication controller [0780]: Intel Corporation Sunrise Point-H CSME HECI #1 [8086:a13a] (rev 31)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0, IRQ 126
>         Memory at dc34b000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Kernel driver in use: mei_me
>         Kernel modules: mei_me
>
> 00:17.0 SATA controller [0106]: Intel Corporation Sunrise Point-H SATA controller [AHCI mode] [8086:a102] (rev 31) (prog-if 01 [AHCI 1.0])
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 124
>         Memory at dc348000 (32-bit, non-prefetchable) [size=8K]
>         Memory at dc34e000 (32-bit, non-prefetchable) [size=256]
>         I/O ports at 6080 [size=8]
>         I/O ports at 6088 [size=4]
>         I/O ports at 6040 [size=32]
>         Memory at dc34c000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [70] Power Management version 3
>         Capabilities: [a8] SATA HBA v1.0
>         Kernel driver in use: ahci
>         Kernel modules: ahci
>
> 00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #1 [8086:a110] (rev f1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 121
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: None
>         Memory behind bridge: dc100000-dc1fffff [size=1M]
>         Prefetchable memory behind bridge: None
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Capabilities: [a0] Power Management version 3
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Access Control Services
>         Capabilities: [200] L1 PM Substates
>         Kernel driver in use: pcieport
>
> 00:1c.1 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #2 [8086:a111] (rev f1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 122
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         I/O behind bridge: 00004000-00005fff [size=8K]
>         Memory behind bridge: dc200000-dc2fffff [size=1M]
>         Prefetchable memory behind bridge: 000000003e900000-000000003eafffff [size=2M]
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Capabilities: [a0] Power Management version 3
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Access Control Services
>         Capabilities: [200] L1 PM Substates
>         Capabilities: [220] #19
>         Kernel driver in use: pcieport
>
> 00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #5 [8086:a114] (rev f1) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 123
>         Bus: primary=00, secondary=04, subordinate=6e, sec-latency=0
>         I/O behind bridge: 00007000-00007fff [size=4K]
>         Memory behind bridge: ac000000-da0fffff [size=737M]
>         Prefetchable memory behind bridge: 0000000060000000-00000000a9ffffff [size=1184M]
>         Capabilities: [40] Express Root Port (Slot+), MSI 00
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [90] Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Capabilities: [a0] Power Management version 3
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Access Control Services
>         Capabilities: [220] #19
>         Kernel driver in use: pcieport
>
> 00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-H LPC Controller [8086:a150] (rev 31)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0
>
> 00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-H PMC [8086:a121] (rev 31)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: fast devsel
>         Memory at dc340000 (32-bit, non-prefetchable) [disabled] [size=16K]
>
> 00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-H HD Audio [8086:a170] (rev 31) (prog-if 80)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 64, IRQ 132
>         Memory at dc344000 (64-bit, non-prefetchable) [size=16K]
>         Memory at dc330000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd_hda_intel
>
> 00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-H SMBus [8086:a123] (rev 31)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: medium devsel, IRQ 16
>         Memory at dc34d000 (64-bit, non-prefetchable) [size=256]
>         I/O ports at efa0 [size=32]
>         Kernel driver in use: i801_smbus
>         Kernel modules: i2c_i801
>
> 00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2) I219-LM [8086:15b7] (rev 31)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0, IRQ 127
>         Memory at dc300000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [c8] Power Management version 3
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [e0] PCI Advanced Features
>         Kernel driver in use: e1000e
>         Kernel modules: e1000e
>
> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Venus XTX [Radeon HD 8890M / R9 M275X/M375X] [1002:6820] (rev 83) (prog-if 00 [VGA controller])
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0, IRQ 131
>         Memory at 40000000 (64-bit, prefetchable) [size=256M]
>         Memory at dc000000 (64-bit, non-prefetchable) [size=256K]
>         I/O ports at 3000 [size=256]
>         Expansion ROM at dc060000 [disabled] [size=128K]
>         Capabilities: [48] Vendor Specific Information: Len=08 <?>
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>         Capabilities: [150] Advanced Error Reporting
>         Capabilities: [270] #19
>         Kernel driver in use: radeon
>         Kernel modules: radeon, amdgpu
>
> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: bus master, fast devsel, latency 0, IRQ 129
>         Memory at dc040000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [48] Vendor Specific Information: Len=08 <?>
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
>         Capabilities: [150] Advanced Error Reporting
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd_hda_intel
>
> 02:00.0 Network controller [0280]: Intel Corporation Wireless 8260 [8086:24f3] (rev 2a)
>         Subsystem: Intel Corporation Dual Band Wireless-AC 8260 [8086:0010]
>         Flags: bus master, fast devsel, latency 0, IRQ 128
>         Memory at dc100000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [c8] Power Management version 3
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [40] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Device Serial Number 34-13-e8-ff-ff-36-80-58
>         Capabilities: [14c] Latency Tolerance Reporting
>         Capabilities: [154] L1 PM Substates
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
>
> 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader [10ec:525a] (rev 01)
>         Subsystem: Hewlett-Packard Company Device [103c:80d5]
>         Flags: fast devsel, IRQ 255
>         Memory at dc200000 (32-bit, non-prefetchable) [disabled] [size=4K]
>         Capabilities: [80] Power Management version 3
>         Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [b0] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [148] Device Serial Number 00-00-00-01-00-4c-e0-00
>         Capabilities: [158] Latency Tolerance Reporting
>         Capabilities: [160] L1 PM Substates



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
