Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F2C49ED4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53E8218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567976388;
	bh=sXsFudfpvAXUcZO5Z6olX5lW4RF+k6AEB+VRjVPoPqU=;
	h=From:Date:Subject:To:List-ID:From;
	b=FrmI4ckmRKhy/xl7DMXHe9w/komUMqTzgO2EtJCBrVyF+gFrV2qBU8vUZjR0i1Ha8
	 MEItMGlC+EMxdVRpDQnp/53FjzOZEMMCwG5w5BT/RPq0sYvj4tTRhWENs4Y767eYXZ
	 JoK/gHSwrxiPu27MrFRDg8uQ43Wpd8dKGvva5mQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfIHU7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 16:59:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39219 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfIHU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:59:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id l11so8880273lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=PnUSsFWkQ4AhcDNsi+GnSWmekWCxiQYKBDvdCQqMkdU=;
        b=Q3cI4NQBh+DCpLJiM7BxZsIaxUVVazNNi95e8rGg4PjK8O8rjBp92bBt57fKnwQ8G9
         099HHmTpy1jraiFKAfnimXhcw+NBZBNrAm7KMzAcSOQ80Ssd4VUUfM5rDI+V673ZIaun
         FHDmQP7xsqzILlT/+VSXKNTl+DoTSGo3lUWNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PnUSsFWkQ4AhcDNsi+GnSWmekWCxiQYKBDvdCQqMkdU=;
        b=scW0z80MRvytsi2omXeZzhqYzDsz+efbPRXuI3nlW57xFbrOhc0rIwCGNGaQtSMBmH
         PGCVVX/4jX6KUckYakXxQ7M9MEoTzNot/CFLOo03zsHjpDQPEXzp/JZS5DxIHVNS/TIs
         EIV4kQJ/iQHIowBmSMEgX0tOZvcyLH9NenKXdZ/LAPV+6HAQyqyotkil3aZrBDW9YMAi
         VSijWWj1m5bUkrVB/l17p56uBI5OjeGK6uVNzKy2BlmP2OZPcm9HqnJUG21P9/pOa7ed
         aGGxmqGfwO7nB0v3ODDZqoiuPkCfKRe3/x5KTg9UC49cTdM3w05CtGE+j39GweeJaqo/
         q4eA==
X-Gm-Message-State: APjAAAUW54lQgiMO5d5r4EEf2VGCW9Esd+PJjqqXOwskRdF7l6JBd7Za
        aU6HXI4icnYQH9QmZFxM3OwsVZ2q2/8=
X-Google-Smtp-Source: APXvYqzax8gtJwb+JtC0Yd3iY3DLP3MYJrbmLwU4pKNxbhK9w1NeMQTODBFzg0gf98ZVBHrrKoQQ8Q==
X-Received: by 2002:ac2:520d:: with SMTP id a13mr14565274lfl.101.1567976384594;
        Sun, 08 Sep 2019 13:59:44 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id t82sm2451830lff.58.2019.09.08.13.59.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2019 13:59:43 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j16so10732090ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 13:59:43 -0700 (PDT)
X-Received: by 2002:a05:651c:103c:: with SMTP id w28mr2410344ljm.90.1567976383173;
 Sun, 08 Sep 2019 13:59:43 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Sep 2019 13:59:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
Message-ID: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
Subject: Linux 5.3-rc8
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we probably didn't strictly need an rc8 this release, but with LPC
and the KS conference travel this upcoming week it just makes
everything easier.

And partly because of the extra week, we then had a few fixes that
maybe otherwise would have been delayed and marked for stable. The
most notable one (but hopefully not very noticeable) is fixing race
conditions in configfs. That won't affect very many people, with
configfs not all that widely used, but Christoph and Al both felt it
needed to be fixed.

Other than that, it really is a very small rc (and hopefully the final
week will be smaller still). In fact, the configfs fix along with a
vhost revert is about half of the patch. The rest is various small
things: a few sound fixes, some drm fixes, and a few other random
fixes. Even in the drm case, the selftest addition is bigger than the
core code patches.

The appended shortlog is short enough that it's easy enough to scroll
through if you are interested in the details.

              Linus

---

Al Viro (4):
      configfs: stash the data we need into configfs_buffer at open time
      configfs_register_group() shouldn't be (and isn't) called in
rmdirable parts
      configfs: new object reprsenting tree fragments
      configfs: provide exclusion between IO and removals

Andrew Cooper (1):
      Documentation/process: Volunteer as the ambassador for Xen

Baolin Wang (1):
      dmaengine: sprd: Fix the DMA link-list configuration

Ben Skeggs (1):
      drm/nouveau/sec2/gp102: add missing MODULE_FIRMWAREs

Benjamin Tissoires (1):
      Input: elan_i2c - remove Lenovo Legion Y7000 PnpID

Christophe Leroy (1):
      powerpc/64e: Drop stale call to smp_processor_id() which hangs SMP startup

Dan Carpenter (1):
      drm/vmwgfx: Fix double free in vmw_recv_msg()

David Jander (2):
      gpio: pca953x: correct type of reg_direction
      gpio: pca953x: use pca953x_read_regs instead of regmap_bulk_read

Fabrizio Castro (1):
      arm64: dts: renesas: hihope-common: Fix eMMC status

Geert Uytterhoeven (1):
      arm64: dts: renesas: r8a77995: draak: Fix backlight regulator name

Gustavo Romero (2):
      powerpc/tm: Fix FP/VMX unavailable exceptions inside a transaction
      powerpc/tm: Fix restoring FP/VMX facility incorrectly on interrupts

Hillf Danton (1):
      keys: Fix missing null pointer check in request_key_auth_describe()

Hui Wang (1):
      ALSA: hda/realtek - Fix the problem of two front mics on a ThinkCentre

Ingo Molnar (1):
      sched/core: Fix uclamp ABI bug, clean up and robustify
sched_read_attr() ABI logic and code

Jacob Pan (1):
      iommu/vt-d: Remove global page flush support

James Smart (1):
      scsi: lpfc: Raise config max for lpfc_fcp_mq_threshold variable

Jan Kaisrlik (1):
      Revert "mmc: core: do not retry CMD6 in __mmc_switch()"

Jeff Moyer (1):
      libnvdimm/pfn: Fix namespace creation on misaligned addresses

Jian-Hong Pan (1):
      ALSA: hda/realtek - Enable internal speaker & headset mic of ASUS UX431FL

Joerg Roedel (1):
      iommu/amd: Fix race in increase_address_space()

John S. Gruber (1):
      x86/boot: Preserve boot_params.secure_boot from sanitizing

Kees Cook (1):
      Documentation/process: Add Google contact for embargoed hardware issues

Laurent Pinchart (1):
      drm/ingenic: Hardcode panel type to DPI

Lee Jones (1):
      soc: qcom: geni: Provide parameter error checking

Liangyan (1):
      sched/fair: Don't assign runtime for throttled cfs_rq

Linus Torvalds (2):
      Revert "x86/apic: Include the LDR when clearing out APIC registers"
      Linux 5.3-rc8

Lu Baolu (1):
      Revert "iommu/vt-d: Avoid duplicated pci dma alias consideration"

Maxime Ripard (4):
      drm/modes: Add a switch to differentiate free standing options
      drm/modes: Fix the command line parser to take force options into account
      drm/modes: Introduce a whitelist for the named modes
      drm/selftests: modes: Add more unit tests for the cmdline parser

Michael S. Tsirkin (1):
      Revert "vhost: access vq metadata through kernel virtual address"

Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

Nadav Amit (1):
      mm/balloon_compaction: suppress allocation warnings

Nick Desaulniers (1):
      include/linux/compiler.h: fix Oops for Clang-compiled kernels

Peter Zijlstra (1):
      x86/uaccess: Don't leak the AC flags into __get_user() argument evaluation

Sam Bazley (1):
      ALSA: hda/realtek - Add quirk for HP Pavilion 15

Sasha Levin (1):
      Documentation/process/embargoed-hardware-issues: Microsoft ambassador

Stuart Hayes (1):
      iommu/amd: Flush old domains in kdump kernel

Takashi Iwai (2):
      ALSA: hda - Fix potential endless loop at applying quirks
      ALSA: hda/realtek - Fix overridden device-specific initialization

Tianyu Lan (1):
      x86/hyper-v: Fix overflow bug in fill_gva_list()

Tiwei Bie (2):
      vhost/test: fix build for vhost test
      vhost/test: fix build for vhost test

Trilok Soni (1):
      Documentation/process: Add Qualcomm process ambassador for
hardware security issues

Trond Myklebust (1):
      NFS: Fix inode fileid checks in attribute revalidation code

Wenwen Wang (2):
      dmaengine: ti: dma-crossbar: Fix a memory leak bug
      dmaengine: ti: omap-dma: Add cleanup in omap_dma_probe()

Yoshihiro Shimoda (1):
      dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped

Yunsheng Lin (1):
      vhost: Remove unnecessary variable

jiang (1):
      virtio-net: lower min ring num_free for efficiency
