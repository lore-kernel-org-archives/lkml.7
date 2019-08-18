Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B9C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48B121852
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566165124;
	bh=GnjWh3KmKLZ1z6HWhWe+iIPv7PXjbJT5zoPdfz8vxoE=;
	h=From:Date:Subject:To:List-ID:From;
	b=zXLXuQ4xIwMePUqnV5Z8HhysQfq03jMGSRembp2bBdWVVeRowuIJda7slmSzSibbq
	 E5M9qnjLucIpJhcVaTXwcAhK9BTXD53WgllJRZ9IdfT9RR7M12tZ2X2rN6Hy+4u9Wu
	 oQsEH1CDCmSkjX78oA8RsdscFTDYtWLaLphjHmjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfHRVwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 17:52:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45888 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfHRVwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 17:52:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id a30so7501662lfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=e3pO8XBGoGTZNzGLfzW86h31IA/13pYFDGtVShIr290=;
        b=cR/PQfxMGwHNEG6vK6XOoh0WBakMekscpG6Ye2kobRdWEbf6ZIZFla9NaZG4LIu8sw
         nCOpdj86HRT1Bqadn6WGor5A3J5elVUHNYltI12HqtZD5iBXzX0bw7ObaXrTm0tF0AUr
         Ih0oO2i92sy+R1QoBjptuR4aplQWuaEmgW2YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=e3pO8XBGoGTZNzGLfzW86h31IA/13pYFDGtVShIr290=;
        b=iaL/dmCxS/ZpjgijXiNLvzJPqz1mD6R7Ty5Av9cobIUaTvkxLpjFni0zJgzzrKExLK
         /s49QCtBdCwj1G1U6/OWM9jjRLbkocjrrrEq9xV4fdVc4PJXHGi+4wFYHMb7Sv8+FoM1
         YFRwNJuLbhJuBtcZTyYZbXfOneXXnu+/0U/MNKQ8K2uWMhCi9sC3YPtlY4iyWlZ9SlTk
         +ndvDduLP7aehi1CCl7Ivlq6PjB2kNHT0tIsBefvV6XN5OJNFFmlJ8Or2MtIBG2JAaCW
         Vuareb2mgDFF++jD65lhXyM6u+DnSTdoG1B30g4xDRHbCf27qdvT4f6VVsezG05rte/4
         NJ7g==
X-Gm-Message-State: APjAAAVBxyl4KcEOooC9gjZVdMZVhLmNwQxu7tWurcVqZbWVXhxbJLn8
        r2rcG5vj1vkOVHxGou/TpYpmu+FvyQ0=
X-Google-Smtp-Source: APXvYqwHTNx0UWGw+aZJ/ZJN4eX5iTMpQcXItQ7clnfVjSYRa5q1gnwoTZEzZIwo4gdwIwvbEo02Ag==
X-Received: by 2002:a19:a83:: with SMTP id 125mr10860873lfk.150.1566165119948;
        Sun, 18 Aug 2019 14:51:59 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i5sm2019296lji.74.2019.08.18.14.51.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2019 14:51:59 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j17so7536071lfp.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 14:51:59 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr10666287lfq.134.1566165118796;
 Sun, 18 Aug 2019 14:51:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Aug 2019 14:51:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiO5-puMa30fCwtgze57MH2JOzedVcEVotEviYmmQNihQ@mail.gmail.com>
Message-ID: <CAHk-=wiO5-puMa30fCwtgze57MH2JOzedVcEVotEviYmmQNihQ@mail.gmail.com>
Subject: Linux 5.3-rc5
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another -rc.

It's been calm, and nothing here stands out, except perhaps some of
the VM noise where we un-reverted some changes wrt node-local vs
hugepage allocations.

The rest is the usual driver fixes (usb, sound, nvme, habanalabs,
rdma..) some arch updates (arm64 and x86) along with some filesystem
fixes (afs and btrfs).

But all of it is really quite small.

Shortlog appended in case you care about the details,

                 Linus

---

Adrian Vladu (3):
      tools: hv: fixed Python pep8/flake8 warnings for lsvmbus
      tools: hv: fix KVP and VSS daemons exit code
      tools: hv: fix typos in toolchain

Alan Stern (1):
      USB: core: Fix races in character device registration and deregistrai=
on

Aleix Roca Nonell (1):
      io_uring: fix manual setup of iov_iter for fixed buffers

Alex Deucher (1):
      drm/amd/display: use kvmalloc for dc_state (v2)

Alistair Francis (2):
      riscv: rv32_defconfig: Update the defconfig
      riscv: defconfig: Update the defconfig

Anders Roxell (1):
      iommu/arm-smmu: Mark expected switch fall-through

Andrea Arcangeli (2):
      Revert "Revert "mm, thp: consolidate THP gfp handling into
alloc_hugepage_direct_gfpmask""
      Revert "mm, thp: restore node-local hugepage allocations"

Andr=C3=A9 Draszik (1):
      usb: chipidea: imx: fix EPROBE_DEFER support during driver probe

Anthony Iliopoulos (1):
      nvme-multipath: revalidate nvme_ns_head gendisk in nvme_validate_ns

Arnd Bergmann (4):
      dmaengine: dw-edma: fix unnecessary stack usage
      dmaengine: dw-edma: fix __iomem type confusion
      dmaengine: dw-edma: fix endianess confusion
      dmaengine: ste_dma40: fix unneeded variable warning

Ben Segal (3):
      habanalabs: fix endianness handling for packets from user
      habanalabs: fix completion queue handling when host is BE
      habanalabs: fix device IRQ unmasking for BE host

Benjamin Herrenschmidt (2):
      usb: gadget: composite: Clear "suspended" on reset/disconnect
      usb: gadget: mass_storage: Fix races between fsg_disable and fsg_set_=
alt

Bernard Metzler (1):
      RDMA/siw: Change CQ flags from 64->32 bits

Bob Ham (1):
      USB: serial: option: add the BroadMobi BM818 card

Borislav Petkov (1):
      x86/apic/32: Fix yet another implicit fallthrough warning

Catalin Marinas (1):
      mm: kmemleak: disable early logging in case of error

Christian K=C3=B6nig (1):
      drm/scheduler: use job count instead of peek

Christoph Hellwig (4):
      dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
      dma-mapping: fix page attributes for dma_mmap_*
      usb: don't create dma pools for HCDs with a localmem_pool
      usb: add a hcd_uses_dma helper

Dan Carpenter (4):
      IB/mlx5: Check the correct variable in error handling code
      drm/i915: Use after free in error path in intel_vgpu_create_workload(=
)
      RDMA/siw: Fix a memory leak in siw_init_cpulist()
      RDMA/core: Fix error code in stat_get_doit_qp()

Darrick J. Wong (2):
      xfs: remove more ondisk directory corruption asserts
      xfs: don't crash on null attr fork xfs_bmapi_read

David Howells (4):
      afs: Fix the CB.ProbeUuid service handler to reply correctly
      afs: Fix off-by-one in afs_rename() expected data version calculation
      afs: Only update d_fsdata if different in afs_d_revalidate()
      afs: Fix missing dentry data version updating

Denis Efremov (1):
      MAINTAINERS: iomap: Remove fs/iomap.c record

Fabio Estevam (1):
      Revert "i2c: imx: improve the error handling in i2c_imx_dma_request()=
"

Fenghua Yu (1):
      x86/umwait: Fix error handling in umwait_init()

Filipe Manana (1):
      Btrfs: fix sysfs warning and missing raid sysfs directories

Gustavo A. R. Silva (2):
      sh: kernel: disassemble: Mark expected switch fall-throughs
      sh: kernel: hw_breakpoint: Fix missing break in switch statement

Hans Ulli Kroll (1):
      usb: host: fotg2: restart hcd after port reset

Hans Verkuil (1):
      omap-dma/omap_vout_vrfb: fix off-by-one fi value

Hans de Goede (1):
      efi-stub: Fix get_efi_config_table on mixed-mode setups

Henry Burns (2):
      mm/z3fold.c: fix z3fold_destroy_pool() ordering
      mm/z3fold.c: fix z3fold_destroy_pool() race condition

Hui Peng (2):
      ALSA: usb-audio: Fix an OOB bug in parse_audio_mixer_unit
      ALSA: usb-audio: Fix a stack buffer overflow bug in check_input_term

Hui Wang (2):
      ALSA: hda - Let all conexant codec enter D3 when rebooting
      ALSA: hda - Add a generic reboot_notify

Ian Abbott (2):
      staging: comedi: dt3000: Fix signed integer overflow 'divider * base'
      staging: comedi: dt3000: Fix rounding up of timer divisor

Isaac J. Manjarres (1):
      mm/usercopy: use memory range to be accessed for wraparound check

Jackie Liu (1):
      io_uring: fix an issue when IOSQE_IO_LINK is inserted into defer list

Jacopo Mondi (1):
      iio: adc: max9611: Fix temperature reading in probe

James Smart (1):
      scsi: lpfc: Fix crash when cpu count is 1 and null irq affinity mask

Jens Axboe (1):
      block: remove REQ_NOWAIT_INLINE

Jia-Ju Bai (2):
      fs: afs: Fix a possible null-pointer dereference in afs_put_read()
      dmaengine: stm32-mdma: Fix a possible null-pointer dereference
in stm32_mdma_irq_handler()

John Hubbard (1):
      x86/boot: Save fields explicitly, zero out everything else

Keith Busch (1):
      nvme-pci: Fix async probe remove race

Kuppuswamy Sathyanarayanan (1):
      mm/vmalloc.c: fix percpu free VM area search criteria

Lan Tianyu (1):
      MAINTAINERS: Fix Hyperv vIOMMU driver file name

Linus Torvalds (1):
      Linux 5.3-rc5

Logan Gunthorpe (4):
      nvmet: Fix use-after-free bug when a port is removed
      nvmet-loop: Flush nvme_delete_wq when removing the port
      nvmet-file: fix nvmet_file_flush() always returning an error
      nvme-core: Fix extra device_put() call on error path

Lu Baolu (4):
      iommu/vt-d: Detach domain when move device out of group
      iommu/vt-d: Correctly check format of page table in debugfs
      iommu/vt-d: Detach domain before using a private one
      iommu/vt-d: Fix possible use-after-free of private domain

Lubomir Rintel (1):
      of: irq: fix a trivial typo in a doc comment

Lucas Stach (1):
      dma-direct: don't truncate dma_required_mask to bus addressing
capabilities

Lyude Paul (1):
      drm/nouveau: Only recalculate PBN/VCPI on mode/connector changes

Mans Rullgard (1):
      auxdisplay: charlcd: add help text for backlight initial state

Marc Dionne (1):
      afs: Fix loop index mixup in afs_deliver_vl_get_entry_by_name_u()

Mark Zhang (1):
      RDMA/counter: Prevent QP counter binding if counters unsupported

Masahiro Yamada (2):
      auxdisplay: charlcd: move charlcd.h to drivers/auxdisplay
      auxdisplay: charlcd: add include guard to charlcd.h

Masanari Iida (1):
      auxdisplay: Fix a typo in cfag12864b-example.c

Matthias Maennich (1):
      coccinelle: api/atomic_as_refcounter: add SPDX License Identifier

Max Filippov (1):
      xtensa: add missing isync to the cpu_reset TLB code

Mel Gorman (1):
      mm, vmscan: do not special-case slab reclaim when watermarks are boos=
ted

Mike Kravetz (1):
      hugetlbfs: fix hugetlb page migration/fault race causing SIGBUS

Miles Chen (1):
      mm/memcontrol.c: fix use after free in mem_cgroup_iter()

NeilBrown (1):
      seq_file: fix problem when seeking mid-record

Nishad Kamdar (4):
      intel_th: Use the correct style for SPDX License Identifier
      i2c: stm32: Use the correct style for SPDX License Identifier
      i2c: stm32: Use the correct style for SPDX License Identifier
      tools: hv: Use the correct style for SPDX License Identifier

Nishka Dasgupta (1):
      of: resolver: Add of_node_put() before return and break

Nuno S=C3=A1 (1):
      iio: frequency: adf4371: Fix output frequency setting

Oded Gabbay (1):
      habanalabs: fix endianness handling for internal QMAN submission

Oleksij Rempel (1):
      MAINTAINERS: i2c-imx: take over maintainership

Oliver Neukum (2):
      usb: cdc-acm: make sure a refcount is taken early enough
      USB: CDC: fix sanity checks in CDC union parser

Paul Walmsley (1):
      riscv: fix flush_tlb_range() end address for flush_tlb_page()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: fix gfx9 soft recovery

Pierre-Louis Bossart (3):
      soundwire: cadence_master: fix register definition for SLAVE_STATE
      soundwire: cadence_master: fix definitions for INTSTAT0/1
      soundwire: fix regmap dependencies and align with other serial links

Qian Cai (1):
      include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not us=
ed

Qu Wenruo (1):
      btrfs: trim: Check the range passed into to prevent overflow

Rafael J. Wysocki (2):
      PCI/ASPM: Add pcie_aspm_enabled()
      nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled

Ralph Campbell (3):
      mm: document zone device struct page field usage
      mm/hmm: fix ZONE_DEVICE anon page mapping reuse
      mm/hmm: fix bad subpage pointer in try_to_unmap_one

Randy Dunlap (1):
      misc: xilinx-sdfec: fix dependency and build error

Rob Herring (2):
      dt-bindings: Fix generated example files getting added to schemas
      dt-bindings: pinctrl: stm32: Fix 'st,syscfg' schema

Roberto Sassu (1):
      KEYS: trusted: allow module init if TPM is inactive or deactivated

Robin Murphy (2):
      iommu/dma: Handle MSI mappings separately
      iommu/dma: Handle SG length overflow better

Rogan Dawes (1):
      USB: serial: option: add D-Link DWM-222 device ID

Roman Gushchin (1):
      mm: workingset: fix vmstat counters for shadow nodes

Sagi Grimberg (3):
      nvme: fix a possible deadlock when passthru commands sent to a
multipath device
      nvme-rdma: fix possible use-after-free in connect error flow
      nvme: fix controller removal race with scan work

Sven Van Asbroeck (1):
      dt-bindings: fec: explicitly mark deprecated properties

Takashi Iwai (2):
      ALSA: hda - Apply workaround for another AMD chip 1022:1487
      ALSA: hda/realtek - Add quirk for HP Envy x360

Tetsuo Handa (1):
      fs: xfs: xfs_log: Don't use KM_MAYFAIL at xfs_log_reserve().

Thomas Gleixner (1):
      x86/fpu/math-emu: Address fallthrough warnings

Thomas Huth (1):
      kernel/configs: Replace GPL boilerplate code with SPDX identifier

Tomer Tayar (2):
      habanalabs: Avoid double free in error flow
      habanalabs: fix DRAM usage accounting on context tear down

Tony Lindgren (1):
      USB: serial: option: Add Motorola modem UARTs

Tony Luck (1):
      MAINTAINERS, x86/CPU: Tony Luck will maintain asm/intel-family.h

Tudor Ambarus (1):
      mtd: spi-nor: Fix the disabling of write protection at init

Vincent Chen (2):
      riscv: Correct the initialized flow of FP register
      riscv: Make __fstate_clean() work correctly.

Viresh Kumar (2):
      cpufreq: dev_pm_qos_update_request() can return 1 on success
      cpufreq: schedutil: Don't skip freq update when limits change

Wenwen Wang (2):
      ALSA: hda - Fix a memory leak bug
      xen/blkback: fix memory leaks

Will Deacon (2):
      arm64: cpufeature: Don't treat granule sizes as strict
      arm64: ftrace: Ensure module ftrace trampoline is coherent with I-sid=
e

Wolfram Sang (2):
      i2c: rcar: avoid race when unregistering slave client
      i2c: emev2: avoid race when unregistering slave client

Y.C. Chen (1):
      drm/ast: Fixed reboot test may cause system hanged

Yang Shi (2):
      mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE*
and MPOL_MF_STRICT were specified
      mm: mempolicy: handle vma with unmovable pages mapped correctly in mb=
ind

Yishai Hadas (2):
      IB/mlx5: Fix implicit MR release flow
      IB/mlx5: Fix use-after-free error while accessing ev_file pointer

Yoshiaki Okamoto (1):
      USB: serial: option: Add support for ZTE MF871A

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: Fix sysfs interface of "role"

YueHaibing (1):
      dmaengine: tegra210-adma: Fix unused function warnings

zhengbin (2):
      auxdisplay: panel: need to delete scan_timer when misc_register
fails in panel_attach
      blk-mq: move cancel of requeue_work to the front of blk_exit_queue
