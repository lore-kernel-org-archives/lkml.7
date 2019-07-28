Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D174FC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 20:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905F6206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564344148;
	bh=J3pyCTdwZI8d2cYlRg84f2KI4ONVJOrIdMf89808GT8=;
	h=From:Date:Subject:To:List-ID:From;
	b=BLOwIgraHXFFG168rAZSpjUiMd0n+OoaAtBuZfZuZrPGDeCCJKINkpx8LEDMbT9UN
	 i72bLUABxMkPTVNlieoiV5sFn6utosbd9lZC+ad5BrDoxoxsWRpWWaIFJiHmJNbLWC
	 k2lMC2Lkv7Sbp5i00FlnHDeyCRYzkiDuBZimtYpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfG1UC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 16:02:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40283 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 16:02:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so22835544lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tft7fp8NOgCpbSMbfF0OC44INAFOllI0VvhqUClrmhA=;
        b=OhI8fc73j/SGXeR7S7OUjwDbiibU3Y2kubcQnJPSk90kmy6DGhNpRRYD+9kV699C4y
         PEWZAthXiCfQF/Jld79wlobIF8Wyz8BTOv7FPK/7mNIuD5VkMP7ngKV5+ZMzUXAQFNoS
         7ALG8vvQtpqpVLHkgMWlWnb/I6HiM4qb5m3lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tft7fp8NOgCpbSMbfF0OC44INAFOllI0VvhqUClrmhA=;
        b=N5opuFz/MAGGZVziHYaUZBzX33YaiFAaSiCtmuUsYhg1O0LH/2b9DDQ8u/OZivt81C
         p0IU79DQLekMLuvGTAUKdd29pHJr18sXNWAqL/uzNen+0mcTEuNKMdNBG4G9J7h4KPJs
         bFgKFSjOJZQK4TREkEYPklqxkpoYFy4kKtKOrxYo4N6qj7S3xVNbDgCj1++bdgXLqLnq
         qUmChzxBpdofNxLU5oq4SiEsO6aPzkwokqtBfD15CK8sN/Q4Wt68uEX104NA5y5hHLqH
         30HlF94oprqNepBDW2uaFRvFU2s3k/v/zLvsRx2onuUqFwq6eXQk2QU0g0zmhGhXVFZA
         NA/w==
X-Gm-Message-State: APjAAAUO2nps81/MjXiCCZq9iH5pjFx8NAvw/ooLx+jT0uMP9Z7Lmq7x
        h53KFDMOOq8dFkx2rgeU2gIYFSN7wVc=
X-Google-Smtp-Source: APXvYqzj/B86qb7mcJSXlQaJ2nfSfXYVrpblAGCGAXBhpJT4ODeYB4cjDMqTi0KOPcy8aQYrfnIBmQ==
X-Received: by 2002:a2e:94cb:: with SMTP id r11mr13037341ljh.212.1564344142566;
        Sun, 28 Jul 2019 13:02:22 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q4sm14003030lje.99.2019.07.28.13.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:02:21 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id m8so22835476lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 13:02:21 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr25743627ljg.52.1564344141392;
 Sun, 28 Jul 2019 13:02:21 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jul 2019 13:02:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiKRJprQDJqJzdcjdaGs73UtVPTM2+jOHWdMgu5Sp2HQ@mail.gmail.com>
Message-ID: <CAHk-=wiiKRJprQDJqJzdcjdaGs73UtVPTM2+jOHWdMgu5Sp2HQ@mail.gmail.com>
Subject: Linux 5.3-rc2
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. I reasonably large rc2 to go with a fairly large merge window.

There are fixes all over, I don't think there's much of a pattern
here. The three areas that do stand out are Documentation (more rst
conversions), arch updates (mainly because of the netx arm platform
removal) and misc driver fixes (gpu, iommu, net, nvdimm, sound ..).

But there's a smattering of fixes all over (core kernel, netfilter,
filesystems, you name it). I don't think anything stands out as
particularly damning.

Shortlog appended for people who want to get an overview of the details.

             Linus

---

Akinobu Mita (1):
      block: fix sysfs module parameters directory path in comment

Al Viro (1):
      fix the struct mount leak in umount_tree()

Alex Deucher (1):
      drm/amdgpu/smu: move fan rpm query into the asic specific code

Alexander Usyskin (1):
      mei: me: add mule creek canyon (EHL) device ids

Alexey Budankov (1):
      perf session: Fix loading of compressed data split across adjacent re=
cords

Alvin Lee (3):
      drm/amd/display: Disable Audio on reinitialize hardware
      drm/amd/display: Wait for flip to complete
      drm/amd/display: Only enable audio if speaker allocation exists

Andi Kleen (3):
      perf script: Fix --max-blocks man page description
      perf script: Improve man page description of metrics
      perf script: Fix off by one in brstackinsn IPC computation

Andrea Arcangeli (1):
      powerpc: fix off by one in max_zone_pfn initialization for ZONE_DMA

Andrew Lunn (1):
      net: phy: sfp: hwmon: Fix scaling of RX power

Anshuman Khandual (1):
      arm64: mm: Drop pte_huge()

Anson Huang (1):
      arm64: dts: imx8mm: Correct SAI3 RXC/TXFS pin's mux option #1

Arnaldo Carvalho de Melo (3):
      perf probe: Set pev->nargs to zero after freeing pev->args entries
      perf probe: Avoid calling freeing routine multiple times for same poi=
nter
      perf build: Do not use -Wshadow on gcc < 4.8

Arnd Bergmann (9):
      habanalabs: use %pad for printing a dma_addr_t
      netfilter: bridge: make NF_TABLES_BRIDGE tristate
      scsi: fdomain: fix building pcmcia front-end
      drbd: dynamically allocate shash descriptor
      ARM: davinci: fix sleep.S build error on ARMv4
      ARM: dts: bcm: bcm47094: add missing #cells for mdio-bus-mux
      locking/lockdep: Hide unused 'class' variable
      locking/lockdep: Clean up #ifdef checks
      structleak: disable STRUCTLEAK_BYREF in combination with KASAN_STACK

Arseny Solokha (1):
      eeprom: make older eeprom drivers select NVMEM_SYSFS

Benjamin Poirier (1):
      be2net: Synchronize be_update_queues with dev_watchdog

Bj=C3=B6rn Gerhart (1):
      hwmon: (nct6775) Fix register address and added missed tolerance
for nct6106

Brian King (1):
      bnx2x: Prevent load reordering in tx completion processing

Brian Masney (1):
      drm/msm: correct NULL pointer dereference in context_init

Brian Norris (1):
      mac80211: don't warn about CW params when not using them

Cao jin (1):
      x86/irq/64: Update stale comment

Charles Keepax (4):
      ALSA: compress: Fix regression on compressed capture streams
      ALSA: compress: Prevent bypasses of set_params
      ALSA: compress: Don't allow paritial drain operations on capture stre=
ams
      ALSA: compress: Be more restrictive about when a drain is allowed

Chris Wilson (1):
      iommu/iova: Remove stale cached32_node

Christian Hesse (1):
      netfilter: nf_tables: fix module autoload for redir

Christoph Hellwig (3):
      scsi: core: fix the dma_max_mapping_size call
      Documentation: move Documentation/virtual to Documentation/virt
      block: fix max segment size handling in blk_queue_virt_boundary

Christophe JAILLET (6):
      tipc: Fix a typo
      net: hns3: typo in the name of a constant
      chelsio: Fix a typo in a function name
      ALSA: line6: Fix a typo
      s390/hypfs: fix a typo in the name of a function
      scsi: fcoe: fix a typo

Colin Ian King (1):
      scsi: megaraid_sas: fix spelling mistake "megarid_sas" -> "megaraid_s=
as"

Cong Wang (1):
      perf stat: Always separate stalled cycles per insn

Cornelia Huck (1):
      Documentation: fix vfio-ccw doc

C=C3=A9dric Le Goater (1):
      KVM: PPC: Book3S HV: XIVE: fix rollback when kvmppc_xive_create fails

Dale Zhao (1):
      drm/amd/display: handle active dongle port type is DP++ or DP case

Dan Carpenter (1):
      usb/hcd: Fix a NULL vs IS_ERR() bug in usb_hcd_setup_local_mem()

Dan Williams (7):
      drivers/base: Introduce kill_device()
      libnvdimm/bus: Prevent duplicate device_unregister() calls
      libnvdimm/region: Register badblocks before namespaces
      libnvdimm/bus: Prepare the nd_ioctl() path to be re-entrant
      libnvdimm/bus: Stop holding nvdimm_bus_list_mutex over __nd_ioctl()
      libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA deadlock
      driver-core, libnvdimm: Let device subsystems add local lockdep cover=
age

Daniel Vetter (1):
      vt: Grab console_lock around con_is_bound in show_bind

Dave Martin (4):
      arm64: stacktrace: Constify stacktrace.h functions
      arm64: stacktrace: Factor out backtrace initialisation
      arm64/sve: Factor out FPSIMD to SVE state conversion
      arm64/sve: Fix a couple of magic numbers for the Z-reg count

Derek Lai (2):
      drm/amd/display: Read max down spread
      drm/amd/display: allocate 4 ddc engines for RV2

Ding Xiang (2):
      ata: libahci_platform: remove redundant dev_err message
      ALSA: ac97: Fix double free of ac97_codec_device

Dmitry Osipenko (1):
      drm/modes: Don't apply cmdline's rotation if it wasn't specified

Dmitry Safonov (2):
      iommu/vt-d: Don't queue_iova() if there is no flush queue
      iommu/vt-d: Check if domain->pgd was allocated

Dmytro Laktyushkin (2):
      drm/amd/display: fix dsc disable
      drm/amd/display: Set default block_size, even in unexpected cases

Eiichi Tsukata (1):
      x86/stacktrace: Prevent access_ok() warnings in arch_stack_walk_user(=
)

Eric Auger (1):
      dma-mapping: use dma_get_mask in dma_addressing_limited

Eric Dumazet (1):
      tcp: be more careful in tcp_fragment()

Eric Yang (2):
      drm/amd/display: put back front end initialization sequence
      drm/amd/display: do not read link setting if edp not connected

Evan Quan (1):
      drm/amd/powerplay: report bootup clock as max supported on dpm disabl=
ed

Fabio Estevam (1):
      ARM: dts: imx7ulp: Fix usb-phy unit address format

Farhan Ali (6):
      vfio-ccw: Fix misleading comment when setting orb.cmd.c64
      vfio-ccw: Fix memory leak and don't call cp_free in cp_init
      vfio-ccw: Set pa_nr to 0 if memory allocation fails for pa_iova_pfn
      vfio-ccw: Don't call cp_free if we are processing a channel program
      vfio-ccw: Update documentation for csch/hsch
      MAINTAINERS: vfio-ccw: Remove myself as the maintainer

Fatemeh Darbehani (1):
      drm/amd/display: Change min_h_sync_width from 8 to 4

Federico Vaga (3):
      doc:it_IT: align translation to mainline
      doc:it_IT: rephrase statement
      doc:it_IT: translations in process/

Fernando Fernandez Mancera (2):
      netfilter: synproxy: fix erroneous tcp mss option
      netfilter: synproxy: fix rst sequence number mismatch

Florian Westphal (3):
      netfilter: nfnetlink: avoid deadlock due to synchronous request_modul=
e
      netfilter: conntrack: always store window size un-scaled
      netfilter: nf_tables: don't fail when updating base chain policy

Frederick Lawler (3):
      cxgb4: Prefer pcie_capability_read_word()
      igc: Prefer pcie_capability_read_word()
      qed: Prefer pcie_capability_read_word()

Fuqian Huang (1):
      drm/ttm: use the same attributes when freeing d_page->vaddr

Gautham R. Shenoy (1):
      powerpc/xive: Fix loop exit-condition in xive_find_target_in_mask()

Guido G=C3=BCnther (1):
      docs: phy: Drop duplicate 'be made'

Gustavo A. R. Silva (13):
      perf/x86/intel: Mark expected switch fall-throughs
      firewire: mark expected switch fall-throughs
      can: mark expected switch fall-throughs
      afs: yfsclient: Mark expected switch fall-throughs
      afs: fsclient: Mark expected switch fall-throughs
      mtd: onenand_base: Mark expected switch fall-through
      perf/x86/intel: Mark expected switch fall-throughs
      drm/amdkfd: Fix missing break in switch statement
      drm/amdgpu/gfx10: Fix missing break in switch statement
      drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through warning
      drm/amd/display: Mark expected switch fall-throughs
      drm/i915: Mark expected switch fall-throughs
      Makefile: Globally enable fall-through warning

Haiyang Zhang (1):
      hv_netvsc: Fix extra rcu_read_unlock in netvsc_recv_callback()

Halil Pasic (2):
      s390/dma: provide proper ARCH_ZONE_DMA_BITS value
      virtio/s390: fix race on airq_areas[]

Hannes Reinecke (1):
      scsi: scsi_dh_alua: always use a 2 second delay before retrying RTPG

Hans Verkuil (2):
      media: v4l2-subdev: fix regression in check_pad()
      media: videodev2.h: change V4L2_PIX_FMT_BGRA444 define: fourcc
was already in use

Hans de Goede (1):
      x86/sysfb_efi: Add quirks for some devices with swapped width and hei=
ght

Harmanprit Tatla (1):
      drm/amd/display: No audio endpoint for Dell MST display

Hawking Zhang (4):
      drm/amdgpu: do not create ras debugfs/sysfs node for ASICs that
don't have ras ability
      drm/amdgpu: disable GFX RAS by default
      drm/amdgpu: only allow error injection to UMC IP block
      drm/amdgpu: drop ras self test

Heiko Carstens (1):
      kbuild: enable arch/s390/include/uapi/asm/zcrypt.h for uapi header te=
st

Helge Deller (1):
      parisc: Flush ITLB in flush_tlb_all_local() only on split TLB machine=
s

Hridya Valsaraju (1):
      binder: prevent transactions to context manager from its own process.

Hui Wang (1):
      ALSA: hda - Add a conexant codec entry to let mute led work

Ilya Bakoulin (1):
      drm/amd/display: Check for valid stream_encode

James Morse (1):
      arm64: entry: SP Alignment Fault doesn't write to FAR_EL1

Jan Kiszka (2):
      KVM: nVMX: Clear pending KVM_REQ_GET_VMCS12_PAGES when leaving nested
      KVM: nVMX: Set cached_vmcs12 and cached_shadow_vmcs12 NULL after free

Jan Stancek (1):
      locking/rwsem: Add missing ACQUIRE to read_slowpath exit when
queue is empty

Jann Horn (2):
      sched/fair: Don't free p->numa_faults with concurrent readers
      sched/fair: Use RCU accessors consistently for ->numa_group

Jean-Philippe Brucker (1):
      MAINTAINERS: Update my email address

Jens Axboe (4):
      blk-mq: allow REQ_NOWAIT to return an error inline
      block: properly handle IOCB_NOWAIT for async O_DIRECT IO
      io_uring: don't use iov_iter_advance() for fixed buffers
      io_uring: ensure ->list is initialized for poll commands

Jeremy Cline (1):
      docs/vm: transhuge: fix typo in madvise reference

Jeremy Sowden (1):
      kbuild: add net/netfilter/nf_tables_offload.h to header-test blacklis=
t.

Jiri Olsa (2):
      perf tools: Fix proper buffer size for feature processing
      perf stat: Fix segfault for event group in repeat mode

Joerg Roedel (5):
      x86/mm: Check for pfn instead of page in vmalloc_sync_one()
      x86/mm: Sync also unmappings in vmalloc_sync_all()
      mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()
      Revert "iommu/vt-d: Consolidate domain_init() to avoid duplication"
      iommu/iova: Fix compilation error with !CONFIG_IOMMU_IOVA

Johannes Berg (2):
      wireless: fix nl80211 vendor commands
      nl80211: fix VENDOR_CMD_RAW_DATA

Johannes Thumshirn (2):
      btrfs: free checksum hash on in close_ctree
      btrfs: don't leak extent_map in btrfs_get_io_geometry()

John Crispin (1):
      nl80211: fix NL80211_HE_MAX_CAPABILITY_LEN

Josef Bacik (5):
      wait: add wq_has_single_sleeper helper
      rq-qos: fix missed wake-ups in rq_qos_throttle
      rq-qos: don't reset has_sleepers on spurious wakeups
      rq-qos: set ourself TASK_UNINTERRUPTIBLE after we schedule
      rq-qos: use a mb for got_token

Joseph Greathouse (1):
      drm/amdgpu: Default disable GDS for compute VMIDs

Julian Parkin (2):
      drm/amd/display: Poll for GPUVM context ready (v2)
      drm/amd/display: Fix dc_create failure handling and 666 color depths

Julian Wiedmann (2):
      s390/qdio: add sanity checks to the fast-requeue path
      s390/qdio: restrict QAOB usage to IQD unicast queues

Julien Thierry (1):
      MAINTAINERS: Update my email address

Jun Lei (4):
      drm/amd/display: initialize p_state to proper value
      drm/amd/display: fix up HUBBUB hw programming for VM
      drm/amd/display: cap DCFCLK hardmin to 507 for NV10
      drm/amd/display: swap system aperture high/low

Junxiao Bi (1):
      scsi: megaraid_sas: fix panic on loading firmware crashdump

Kai-Heng Feng (1):
      ALSA: line6: Fix wrong altsetting for LINE6_PODHD500_1

Kan Liang (1):
      perf/x86/intel: Fix SLOTS PEBS event constraint

Kefeng Wang (1):
      hpet: Fix division by zero in hpet_time_div()

Kevin Wang (2):
      drm/amd/powerplay: change sysfs pp_dpm_xxx format for navi10
      drm/amd/powerplay: custom peak clock freq for navi10

Laura Garcia Liebana (1):
      netfilter: nft_hash: fix symhash with modulus one

Lei YU (1):
      hwmon: (occ) Fix division by zero issue

Leo Liu (1):
      drm/amdgpu: use VCN firmware offset for cache window

Leonard Crestez (1):
      perf/core: Fix creating kernel counters for PMUs that override event-=
>cpu

Linus Torvalds (2):
      access: avoid the RCU grace period for the temporary subjective
credentials
      Linux 5.3-rc2

Linus Walleij (4):
      ARM: Delete netx a second time
      ARM: defconfig: u8500: Refresh defconfig
      ARM: defconfig: u8500: Add new drivers
      tty: serial: netx: Delete driver

Logan Gunthorpe (1):
      nvme: fix memory leak caused by incorrect subsystem free

Lorenzo Bianconi (1):
      mac80211: fix possible memory leak in ieee80211_assign_beacon

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id()

Lu Baolu (1):
      iommu/vt-d: Avoid duplicated pci dma alias consideration

Lucas Stach (4):
      arm64: dts: imx8mq: fix SAI compatible
      Revert "usb: usb251xb: Add US lanes inversion dts-bindings"
      Revert "usb: usb251xb: Add US port lanes inversion property"
      usb: usb251xb: Reallow swap-dx-lanes to apply to the upstream port

Marc Zyngier (2):
      MAINTAINERS: Update my email address to @kernel.org
      arm64: Force SSBS on context switch

Marcos Paulo de Souza (1):
      block: blk-mq: Remove blk_mq_sched_started_request and started_reques=
t

Marcus Folkesson (1):
      docs: driver-api: generic-counter: fix file path to ABI doc

Mark Rutland (1):
      arm64: stacktrace: Better handle corrupted stacks

Marta Rybczynska (1):
      nvme: fix multipath crash when ANA is deactivated

Martijn Coenen (1):
      binder: Set end of SG buffer area properly.

Masahiro Yamada (7):
      s390: use __u{16,32,64} instead of uint{16,32,64}_t in uapi header
      treewide: add "WITH Linux-syscall-note" to SPDX tag of uapi headers
      treewide: remove SPDX "WITH Linux-syscall-note" from
kernel-space headers again
      iomap: fix Invalid License ID
      kbuild: remove unused objectify macro
      gen_compile_commands: lower the entry count threshold
      kbuild: remove unused single-used-m

Masanari Iida (1):
      ktest: Fix some typos in config-bisect.pl

Mathias Nyman (1):
      xhci: Fix crash if scatter gather is used with Immediate Data
Transfer (IDT).

Matt Mullins (1):
      x86/entry/32: Pass cr2 to do_async_page_fault()

Mauro Carvalho Chehab (15):
      docs: powerpc: convert docs to ReST and rename to *.rst
      docs: power: add it to to the main documentation index
      docs: fix broken doc references due to renames
      docs: pdf: add all Documentation/*/index.rst to PDF output
      docs: conf.py: add CJK package needed by translations
      docs: conf.py: only use CJK if the font is available
      scripts/sphinx-pre-install: fix script for RHEL/CentOS
      scripts/sphinx-pre-install: don't use LaTeX with CentOS 7
      scripts/sphinx-pre-install: fix latexmk dependencies
      scripts/sphinx-pre-install: cleanup Gentoo checks
      scripts/sphinx-pre-install: seek for Noto CJK fonts for pdf output
      docs: load_config.py: avoid needing a conf.py just due to LaTeX docs
      docs: remove extra conf.py files
      docs: virtual: add it to the documentation body
      docs: load_config.py: ensure subdirs end with "/"

Mauro Rossi (1):
      firmware: fix build errors in paged buffer handling code

Maxime Ripard (2):
      dt-bindings: nvmem: Add YAML schemas for the generic NVMEM bindings
      dt-bindings: nvmem: SID: Fix the examples node names

Miaohe Lin (1):
      netfilter: Fix rpfilter dropping vrf packets by mistake

Michael Neuling (1):
      powerpc/tm: Fix oops on sigreturn on systems without TM

Misha Nasledov (1):
      nvme: ignore subnqn for ADATA SX6000LNP

Murton Liu (1):
      drm/amd/display: Clock does not lower in Updateplanes

Nadav Amit (1):
      vmw_balloon: Remove Julien from the maintainers list

Naohiro Aota (2):
      arm64: vdso: fix flip/flop vdso build bug
      btrfs: fix extent_state leak in btrfs_lock_and_flush_ordered_range

Navid Emamdoost (1):
      allocate_flower_entry: should check for null deref

Nicholas Kazlauskas (2):
      drm/amd/display: Copy max_clks_by_state after dce_clk_mgr_construct
      drm/amd/display: Set enabled to false at start of audio disable

Nikola Cornij (1):
      drm/amd/display: Set one 4:2:0-related PPS field as recommended
by DSC spec

Nikolay Borisov (1):
      btrfs: Fix deadlock caused by missing memory barrier

Oded Gabbay (1):
      habanalabs: don't reset device when getting VRHOT

Ondrej Mosnacek (1):
      selinux: check sidtab limit before adding a new entry

Pablo Neira Ayuso (6):
      netfilter: nft_meta: skip EAGAIN if nft_meta_bridge is not a module
      netfilter: bridge: NF_CONNTRACK_BRIDGE does not depend on NF_TABLES_B=
RIDGE
      net: openvswitch: rename flow_stats to sw_flow_stats
      net: flow_offload: remove netns parameter from flow_block_cb_alloc()
      net: flow_offload: rename tc_setup_cb_t to flow_setup_cb_t
      net: flow_offload: add flow_block structure and use it

Palmer Dabbelt (1):
      MAINTAINERS: Add Paul as a RISC-V maintainer

Paolo Bonzini (1):
      Revert "kvm: x86: Use task structs fpu field for user"

Paolo Valente (1):
      block, bfq: check also in-flight I/O in dispatch plugging

Paul Walmsley (1):
      riscv: enable sys_clone3 syscall for rv64

Peter Kosyh (1):
      vrf: make sure skb->data contains ip header to make routing

Peter Zijlstra (4):
      objtool: Improve UACCESS coverage
      lcoking/rwsem: Add missing ACQUIRE to read_slowpath sleep loop
      tty/ldsem, locking/rwsem: Add missing ACQUIRE to read_failed sleep lo=
op
      locking/rwsem: Add ACQUIRE comments

Phil Sutter (1):
      netfilter: nf_tables: Support auto-loading for inet nat

Phong Tran (1):
      usb: wusbcore: fix unbalanced get/put cluster_id

Qian Cai (1):
      drm: silence variable 'conn' set but not used

Qu Wenruo (1):
      btrfs: inode: Don't compress if NODATASUM or NODATACOW set

Rafael J. Wysocki (1):
      int340X/processor_thermal_device: Fix proc_thermal_rapl_remove()

Rob Clark (1):
      drm/msm: stop abusing dma_map/unmap for cache

Rob Herring (2):
      dt-bindings: clk: allwinner,sun4i-a10-ccu: Correct path in $id
      dt-bindings: Fix more $id value mismatches filenames

Robert Karszniewicz (1):
      hwmon: (k8temp) documentation: update URL of datasheet

Ryan Kennedy (2):
      usb: pci-quirks: Correct AMD PLL quirk detection
      usb: pci-quirks: Minor cleanup for AMD PLL quirk

Sai Praneeth Prakhya (1):
      iommu/vt-d: Print pasid table entries MSB to LSB in debugfs

Samson Tam (1):
      drm/amd/display: skip retrain in
dc_link_set_preferred_link_settings() if using passive dongle

Sebastian Andrzej Siewior (1):
      locking/mutex: Test for initialized mutex

Shawn Anastasio (1):
      powerpc/dma: Fix invalid DMA mmap behavior

Shubhashree Dhar (1):
      drm/msm/dpu: Correct dpu encoder spinlock initialization

SivapiriyanKumarasamy (1):
      drm/amd/display: Wait for backlight programming completion in
set backlight level

Suraj Jitindar Singh (4):
      powerpc/mm: Limit rma_size to 1TB when running without HV mode
      KVM: PPC: Book3S HV: Always save guest pmu for guest capable of nesti=
ng
      powerpc/pmu: Set pmcregs_in_use in paca when running as LPAR
      KVM: PPC: Book3S HV: Save and restore guest visible PSSCR bits on pse=
ries

Suren Baghdasaryan (1):
      pidfd: fix a poll race when setting exit_state

Suthikulpanit, Suravee (1):
      iommu/amd: Add support for X2APIC IOMMU interrupts

Suzuki K Poulose (1):
      MAINTAINERS: Fix spelling mistake in my name

Sven Schnelle (1):
      parisc: add kprobe_fault_handler()

S=C3=A9bastien Szymanski (1):
      ARM: dts: imx6ul: fix clock frequency property name of I2C buses

Tai Man (2):
      drm/amd/display: use encoder's engine id to find matched free audio d=
evice
      drm/amd/display: Increase size of audios array

Takashi Iwai (4):
      ALSA: hda - Optimize resume for codecs without jack detection
      ALSA: pcm: Fix refcount_inc() on zero usage
      firmware: Fix missing inline
      ALSA: hda - Fix intermittent CORB/RIRB stall on Intel chips

Talel Shenhar (1):
      dt-bindings: interrupt-controller: al-fic: remove redundant binding

Tejun Heo (1):
      blkcg: allow blkcg_policy->pd_stat() to print non-debug info too

Thierry Reding (1):
      of: Fix typo in kerneldoc

Thomas Gleixner (2):
      sched/rt, Kconfig: Unbreak def/oldconfig with CONFIG_PREEMPT=3Dy
      x86/hpet: Undo the early counter is counting check

Thomas Tai (1):
      iscsi_ibft: make ISCSI_IBFT dependson ACPI instead of ISCSI_IBFT_FIND

Thomas Voegtle (1):
      r8169: fix RTL8168g PHY init

Toru Komatsu (1):
      .gitignore: Add compilation database file

Tyrel Datwyler (1):
      scsi: ibmvfc: fix WARN_ON during event pool release

Vaibhav Jain (3):
      powerpc/pseries: Update SCM hcall op-codes in hvcall.h
      powerpc/papr_scm: Update drc_pmem_unbind() to use H_SCM_UNBIND_ALL
      powerpc/papr_scm: Force a scm-unbind if initial scm-bind fails

Varun Prakash (1):
      scsi: target: cxgbit: add support for IEEE_8021QAZ_APP_SEL_STREAM sel=
ector

Vasily Averin (2):
      connector: remove redundant input callback from cn_dev
      futex: Cleanup generic SMP variant of arch_futex_atomic_op_inuser()

Vasily Gorbik (5):
      s390: enable detection of kernel version from bzImage
      s390: wire up clone3 system call
      s390/bitops: make test functions return bool
      s390/kasan: add bitops instrumentation
      s390/mm: use shared variables for sysctl range check

Vincenzo Frascino (2):
      arm64: vdso: Fix population of AT_SYSINFO_EHDR for compat vdso
      arm64: vdso: Cleanup Makefiles

Vlad Buslov (1):
      net: sched: verify that q!=3DNULL before setting q->flags

Waiman Long (1):
      locking/rwsem: Don't call owner_on_cpu() on read-owner

Wanpeng Li (3):
      KVM: X86: Fix fpu state crash in kvm guest
      KVM: X86: Dynamically allocate user_fpu
      KVM: X86: Boost queue head vCPU to mitigate lock waiter preemption

Wei Yongjun (1):
      bcache: fix possible memory leak in bch_cached_dev_run()

Wen Yang (1):
      cpufreq/pasemi: fix use-after-free in pas_cpufreq_cpu_init()

Wenjing Liu (1):
      drm/amd/display: wait for the whole frame after global unlock

Wenwen Wang (1):
      test_firmware: fix a memory leak bug

Wesley Terpstra (1):
      riscv: include generic support for MSI irqdomains

Yash Shah (1):
      riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver

Yonatan Goldschmidt (1):
      netfilter: Update obsolete comments referring to ip_conntrack

Yoshihiro Shimoda (1):
      usb-storage: Add a limitation for blk_queue_max_hw_sectors()

YueHaibing (3):
      btrfs: Fix build error while LIBCRC32C is module
      scsi: megaraid_sas: Make some functions static
      fpga-manager: altera-ps-spi: Fix build error

Yunying Sun (1):
      perf/x86/intel: Fix invalid Bit 13 for Icelake MSR_OFFCORE_RSP_x regi=
ster

Zhan Liu (1):
      drm/amd/display: drop ASSERT() if eDP panel is not connected

Zhang Rui (1):
      powercap: Invoke powercap_init() and rapl_init() earlier

Zhengyuan Liu (4):
      io_uring: fix the sequence comparison in io_sequence_defer
      io_uring: fix counter inc/dec mismatch in async_list
      io_uring: add a memory barrier before atomic_read
      io_uring: track io length in async_list based on bytes

Zhenzhong Duan (2):
      x86/speculation/mds: Apply more accurate check on hypervisor platform
      perf/x86: Apply more accurate check on hypervisor platform

Zi Yu Liao (1):
      drm/amd/display: fix DMCU hang when going into Modern Standby

xiao ruizhu (1):
      netfilter: nf_conntrack_sip: fix expectation clash

yangerkun (1):
      Revert "nvme-pci: don't create a read hctx mapping without read queue=
s"
