Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF8AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8020B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564970247;
	bh=aD2rg30smHlYqigqM285ZXB85TIP9NDMiZcLJJHI4+E=;
	h=From:Date:Subject:To:List-ID:From;
	b=Q7hH53/NGn7tbgZlyEt6I1gM3Ben2L91ad74g+d9wN2w6RMHYPuBxJulbEeffWHZo
	 2nPvob5yODObaJ1QoDAtlIOO2XISsmOF8R8rXJimwxSnkMoF0dnvyR43gb8bRxf3BU
	 jrg2hOUSV6UFLs/44nrSN+Zknyin6D1Wi+Uk4kos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfHEBy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 21:54:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34534 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfHEBy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 21:54:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so77829542ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CjRe205cvbegyoptkNbsi6BnG6E2yHoTDg1BHRHEyoY=;
        b=ah8lFTdfmNg9fQt8dTUtRFUutsZ3IJjlFkBhzfkLQ6g0hgEeO1LHWkb7EmpfyJdHD/
         hZMHZt+j0Z3h1vR1XcZvt3hoW6wOqW7RZ/pJWDXcvCDLo1Qo5kyKkJIahHpUTPHK/zAC
         1lsUuCFbnCtRUdWMLARmmn1nyLZHblQxCodqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CjRe205cvbegyoptkNbsi6BnG6E2yHoTDg1BHRHEyoY=;
        b=WJNw/P7IH2dm6vynd+0n3aUC7GbNcc1kw+d3LSkGU1F4AYtJ9Utd1xxKGEc2AeSaSJ
         g5wVs8F1PuLDwWnJXrPEQ3VNXEnQ/LJMeF/CVdLKh47fM7A7YAvssB1DGR2RRvV8AuWk
         cBcV6mdyhzPybUlad9NMmcMbSV+LsDs/Lpoy/YAN96RbI/QQAK/DOMEbR55cdm1gjz8G
         xUSJv+p2BC3ftqLAM+l6Gp/lcjcpiQ8sM9FVlr1OEvsV65OKHT6ZtvQWp1xz+n+hhQKx
         sSVpsvA4C0WWX9igILUgCN+pVYXqcxGAmZLIV4G7Y2IowJIneXfTvLKo/2M0Q1QWfCqR
         MEqw==
X-Gm-Message-State: APjAAAXvN1YhvuRLVFq5C01V3q3o3FGabXHvkcWB2uhY7zs+6bhpHMT3
        mr6p2j9Ee8t+s4gC1DpVlyNN5y01W8Q=
X-Google-Smtp-Source: APXvYqxSpidB6fRWXUihEiJHTRDIRyYkXQTksKI3IreQ4ipsTSUrF/eQC/gFOnAPpeR7yNPfj2A3Jg==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr66116400ljk.152.1564970095284;
        Sun, 04 Aug 2019 18:54:55 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b6sm15864826lfa.54.2019.08.04.18.54.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 18:54:54 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i21so77819805ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 18:54:54 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr79126145ljj.156.1564970093673;
 Sun, 04 Aug 2019 18:54:53 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 18:54:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW+q32YcUL62XWjAme8giZDo-=kmB9=f_JEgyEgV7eaA@mail.gmail.com>
Message-ID: <CAHk-=wiW+q32YcUL62XWjAme8giZDo-=kmB9=f_JEgyEgV7eaA@mail.gmail.com>
Subject: Linux 5.3-rc3
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting. Last Sunday, rc2 was fairly large to match the biggish
merge window, but this last week has actually been quite calm, and rc3
is actually smaller than usual, and smaller than rc2 was. Usually it's
the other way around: rc2 is small while people take a breather after
the merge window, and then rc3 is when thing grow.

Oh well. One reason is probably that there was no networking fix pull
this past week, so the changes are mostly driver fixes (gpu is most
noticeable, but there's other stuff in there too - rdma, scsi, xen)
with the usual arch updates (mainly arm64 and s390 this time around)
and then a random smattering all over (example: tooling header files
got re-synced with the main kernel header files. Very interesting, I
know).

But there really isn't a ton of changes, and most of the changes are
pretty small.

Go out and test. And if you just want to see what changed, read the
shortlog below. It really is not all that exciting, I feel.

                Linus

---

Al Viro (1):
      Unbreak mount_capable()

Alex Deucher (1):
      drm/amdgpu/powerplay: use proper revision id for navi

Alexander Potapenko (1):
      lib/test_meminit.c: use GFP_ATOMIC in RCU critical section

Anders Roxell (3):
      irqchip/gic-v3: Mark expected switch fall-through
      arm64: smp: Mark expected switch fall-through
      arm64: module: Mark expected switch fall-through

Andreas Gruenbacher (1):
      gfs2: Inode dirtying fix

Andreas Koop (1):
      mmc: mmc_spi: Enable stable writes

Andrii Nakryiko (1):
      libbpf: fix missing __WORDSIZE definition

Aneesh Kumar K.V (1):
      powerpc/nvdimm: Pick nearby online node if the device node is not onl=
ine

Arnaldo Carvalho de Melo (8):
      tools include UAPI: Sync x86's syscalls_64.tbl and generic
unistd.h to pick up clone3 and pidfd_open
      tools headers UAPI: Update tools's copy of kvm.h headers
      tools headers UAPI: Update tools's copy of mman.h headers
      tools headers UAPI: Update tools's copy of drm.h headers
      tools perf beauty: Fix usbdevfs_ioctl table generator to handle _IOC(=
)
      tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new i=
octl
      tools headers UAPI: Sync sched.h with the kernel
      tools headers UAPI: Sync if_link.h with the kernel

Arnd Bergmann (5):
      xen: avoid link error on ARM
      drm/exynos: add CONFIG_MMU dependency
      kasan: remove clang version check for KASAN_STACK
      ubsan: build ubsan.c more conservatively
      page flags: prioritize kasan bits over last-cpuid

Asmaa Mnebhi (1):
      Fix uninitialized variable in ipmb_dev_int.c

Baolin Wang (1):
      mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()

Bartosz Golaszewski (1):
      gpio: don't WARN() on NULL descs if gpiolib is disabled

Bernard Metzler (1):
      Do not dereference 'siw_crypto_shash' before checking

Brian Masney (1):
      drm/msm: add support for per-CRTC max_vblank_count on mdp5

Changbin Du (1):
      fgraph: Remove redundant ftrace_graph_notrace_addr() test

Chris Down (1):
      cgroup: kselftest: relax fs_spec checks

Chris Packham (1):
      gpiolib: Preserve desc->flags when setting state

Chris Wilson (9):
      drm/i915: Keep rings pinned while the context is active
      drm/i915/gtt: Defer the free for alloc error paths
      drm/i915/gtt: Mark the freed page table entries with scratch
      drm/i915/userptr: Acquire the page lock around set_page_dirty()
      drm/i915: Lock the engine while dumping the active request
      drm/i915: Lift intel_engines_resume() to callers
      drm/i915: Add a wakeref getter for iff the wakeref is already active
      drm/i915: Only recover active engines
      Revert "drm/vgem: fix cache synchronization on arm/arm64"

Christian Brauner (2):
      pidfd: remove obsolete comments from test
      exit: make setting exit_state consistent

Christian K=C3=B6nig (1):
      drm/amdgpu: fix error handling in amdgpu_cs_process_fence_dep

Christoph Hellwig (7):
      dma-mapping: check pfn validity in dma_common_{mmap,get_sgtable}
      arm: use swiotlb for bounce buffering on LPAE configs
      mm/hmm: always return EBUSY for invalid ranges in
hmm_range_{fault,snapshot}
      mm/hmm: move hmm_vma_range_done and hmm_vma_fault to nouveau
      nouveau: remove the block parameter to nouveau_range_fault
      nouveau: unlock mmap_sem on all errors from nouveau_range_fault
      memremap: move from kernel/ to mm/

Christophe Leroy (1):
      powerpc/kasan: fix early boot failure on PPC32

Chuhong Yuan (1):
      IB/mlx5: Replace kfree with kvfree

Chunyan Zhang (1):
      clk: sprd: Select REGMAP_MMIO to avoid compile errors

Codrin Ciubotariu (1):
      clk: at91: generated: Truncate divisor to GENERATED_MAX_DIV + 1

Colin Ian King (3):
      selftests/x86: fix spelling mistake "FAILT" -> "FAIL"
      drm/exynos: remove redundant assignment to pointer 'node'
      drm/exynos: fix missing decrement of retry counter

Colin Xu (1):
      drm/i915/gvt: Adding ppgtt to GVT GEM context after shadow pdps settl=
ed.

Damien Le Moal (1):
      block: Fix __blkdev_direct_IO() for bio fragments

Darrick J. Wong (1):
      xfs: fix stack contents leakage in the v1 inumber ioctls

David Hildenbrand (1):
      drivers/acpi/scan.c: document why we don't need the device_hotplug_lo=
ck

Denis Efremov (1):
      MAINTAINERS: floppy: take over maintainership

Dhinakaran Pandiyan (1):
      drm/i915/vbt: Fix VBT parsing for the PSR section

Don Brace (2):
      scsi: hpsa: correct scsi command status issue after reset
      scsi: hpsa: remove printing internal cdb on tag collision

Douglas Anderson (1):
      mmc: dw_mmc: Fix occasional hang after tuning on eMMC

Enrico Weigelt (1):
      platform/x86: pcengines-apuv2: use KEY_RESTART for front button

Eric Biggers (3):
      f2fs: use generic checking and prep function for FS_IOC_SETFLAGS
      f2fs: use generic checking function for FS_IOC_FSSETXATTR
      f2fs: remove redundant check from f2fs_setflags_common()

Evan Quan (7):
      drm/amd/powerplay: fix null pointer dereference around dpm state rela=
tes
      drm/amd/powerplay: enable SW SMU reset functionality
      drm/amd/powerplay: add new sensor type for VCN powergate status
      drm/amd/powerplay: support VCN powergate status retrieval on Raven
      drm/amd/powerplay: support VCN powergate status retrieval for SW SMU
      drm/amd/powerplay: correct Navi10 VCN powergate control (v2)
      drm/amd/powerplay: correct UVD/VCE/VCN power status retrieval

Filipe Manana (3):
      Btrfs: fix incremental send failure after deduplication
      Btrfs: fix race leading to fs corruption after transaction abort
      Btrfs: fix deadlock between fiemap and transaction commits

Fuqian Huang (1):
      drm/exynos: using dev_get_drvdata directly

Gal Pressman (1):
      RDMA/restrack: Track driver QP types in resource tracker

Geert Uytterhoeven (2):
      clk: renesas: cpg-mssr: Fix reset control race condition
      MAINTAINERS: Add Geert as Renesas SoC Co-Maintainer

Gustavo A. R. Silva (3):
      ataflop: Mark expected switch fall-through
      IB/hfi1: Fix Spectre v1 vulnerability
      i2c: s3c2410: Mark expected switch fall-through

Guy Levi (1):
      IB/mlx5: Fix MR registration flow to use UMR properly

Hannes Reinecke (3):
      scsi: libfc: Whitespace cleanup in libfc.h
      scsi: fcoe: Embed fc_rport_priv in fcoe_rport structure
      scsi: fcoe: pass in fcoe_rport structure instead of fc_rport_priv

Heiko Carstens (3):
      s390: update configs
      s390/mm: add fallthrough annotations
      s390/tape: add fallthrough annotations

Helge Deller (4):
      parisc: Mark expected switch fall-throughs in fault.c
      parisc: Fix fall-through warnings in fpudispatch.c
      parisc: Fix build of compressed kernel even with debug enabled
      parisc: Strip debug info from kernel before creating compressed vmlin=
uz

Hillf Danton (1):
      ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check

Icenowy Zheng (1):
      f2fs: use EINVAL for superblock with invalid magic

Imre Deak (1):
      drm/i915: Fix the TBT AUX power well enabling

Jack Morgenstein (1):
      IB/mad: Fix use-after-free in ib mad completion handling

Jackie Liu (1):
      io_uring: fix KASAN use after free in io_sq_wq_submit_work

Jaegeuk Kim (1):
      f2fs: fix to read source block before invalidating it

James Bottomley (1):
      parisc: Add archclean Makefile target

Jan Kara (3):
      dax: Fix missed wakeup in put_unlocked_entry()
      loop: Fix mount(2) failure due to race with LOOP_SET_FD
      mm: migrate: fix reference check race between __find_get_block()
and migration

Jason Gunthorpe (2):
      RDMA/devices: Do not deadlock during client removal
      RDMA/devices: Remove the lock around remove_client_context

Jean Delvare (3):
      platform/x86: pcengines-apuv2: Fix softdep statement
      eeprom: at24: make spd world-readable again
      mtd: hyperbus: Add hardware dependency to AM654 driver

Jean-Philippe Brucker (1):
      iommu/virtio: Update to most recent specification

Jeffrey Hugo (1):
      drm: msm: Fix add_gpu_components

Jia-Ju Bai (2):
      scsi: qla2xxx: Fix possible fcport null-pointer dereferences
      xfs: Fix possible null-pointer dereferences in
xchk_da_btree_block_check_sibling()

Joe Lawrence (1):
      selftests/livepatch: add test skip handling

Joe Perches (1):
      mmc: meson-mx-sdio: Fix misuse of GENMASK macro

Joel Fernandes (Google) (1):
      pidfd: Add warning if exit_state is 0 during notification

John Fleck (1):
      IB/hfi1: Check for error on call to alloc_rsm_map_table

Jordan Crouse (1):
      drm/msm: Annotate intentional switch statement fall throughs

Juergen Gross (3):
      xen/swiotlb: fix condition for calling xen_destroy_contiguous_region(=
)
      xen/swiotlb: simplify range_straddles_page_boundary()
      xen/swiotlb: remember having called xen_create_contiguous_region()

Julian Wiedmann (1):
      s390: clean up qdio.h

Julien Thierry (1):
      arm64: Lower priority mask for GIC_PRIO_IRQON

Kaike Wan (3):
      IB/hfi1: Unreserve a flushed OPFN request
      IB/hfi1: Field not zero-ed when allocating TID flow memory
      IB/hfi1: Drop all TID RDMA READ RESP packets after r_next_psn

Kees Cook (1):
      libata: zpodd: Fix small read overflow in zpodd_get_mech_type()

Kenneth Graunke (1):
      drm/i915: Disable SAMPLER_STATE prefetching on all Gen11 steppings.

Kent Russell (1):
      drm/amdkfd: Fix byte align on VegaM

Kevin Wang (2):
      drm/amd/powerplay: add callback function of get_thermal_temperature_r=
ange
      drm/amd/powerplay: fix temperature granularity error in smu11

Laura Abbott (1):
      mm: slub: Fix slab walking for init_on_free

Leon Romanovsky (1):
      RDMA/mlx5: Release locks during notifier unregister

Linus Torvalds (1):
      Linux 5.3-rc3

Lionel Landwerlin (6):
      drm/i915/perf: fix ICL perf register offsets
      drm/i915: fix whitelist selftests with readonly registers
      drm/i915: whitelist PS_(DEPTH|INVOCATION)_COUNT
      drm/i915/icl: whitelist PS_(DEPTH|INVOCATION)_COUNT
      drm/i915/perf: ensure we keep a reference on the driver
      drm/i915/perf: add missing delay for OA muxes configuration

Lubomir Rintel (1):
      Platform: OLPC: add SPI MODULE_DEVICE_TABLE

Lucas Stach (1):
      irqchip/irq-imx-gpcv2: Forward irq type to parent

Lyude Paul (1):
      drm/nouveau: Only release VCPI slots on mode changes

M. Vefa Bicakci (1):
      kconfig: Clear "written" flag to avoid data loss

Mao Han (1):
      riscv: Fix perf record without libelf support

Mao Wenan (1):
      RDMA/siw: Remove set but not used variables 'rv'

Marco Felsch (1):
      mtd: rawnand: micron: handle on-die "ECC-off" devices correctly

Masahiro Yamada (9):
      kbuild: detect missing "WITH Linux-syscall-note" for uapi headers
      kbuild: initialize CLANG_FLAGS correctly in the top Makefile
      tracing: Fix header include guards in trace event headers
      parisc: rename default_defconfig to defconfig
      kbuild: modpost: include .*.cmd files only when targets exist
      kbuild: modpost: handle KBUILD_EXTRA_SYMBOLS only for external module=
s
      kbuild: modpost: remove unnecessary dependency for __modpost
      kbuild: modpost: do not parse unnecessary rules for vmlinux modpost
      lib/raid6: fix unnecessary rebuild of vpermxor*.c

Masami Hiramatsu (4):
      arm64: unwind: Prohibit probing on return_address()
      arm64: Remove unneeded rcu_read_lock from debug handlers
      arm64: kprobes: Recover pstate.D in single-step exception handler
      arm64: Make debug exception handlers visible from RCU

Masanari Iida (2):
      selftests: kmod: Fix typo in kmod.sh
      selftests: mlxsw: Fix typo in qos_mc_aware.sh

Mattias Jacobsson (1):
      platform/x86: wmi: add missing struct parameter description

Mauro Carvalho Chehab (1):
      kernel/signal.c: fix a kernel-doc markup

Max Filippov (1):
      xtensa: fix build for cores with coprocessors

Mel Gorman (1):
      mm: compaction: avoid 100% CPU usage during compaction when a
task is killed

Micah Morton (1):
      Add entry in MAINTAINERS file for SafeSetID LSM

Michael Ellerman (2):
      powerpc: Wire up clone3 syscall
      powerpc/spe: Mark expected switch fall-throughs

Michael S. Tsirkin (2):
      balloon: fix up comments
      vhost: disable metadata prefetch optimization

Michael Wu (1):
      gpiolib: fix incorrect IRQ requesting of an active-low lineevent

Michal Kalderon (1):
      RDMA/qedr: Fix the hca_type and hca_rev returned in device attributes

Micha=C5=82 Miros=C5=82aw (2):
      i2c: at91: disable TXRDY interrupt after sending data
      i2c: at91: fix clk_offset for sama5d2

Mika Kuoppala (1):
      drm/i915: Fix memleak in runtime wakeref tracking

Mike Snitzer (1):
      dm table: fix various whitespace issues with recent DAX code

Milan Broz (1):
      tpm: Fix null pointer dereference on chip register error path

Miquel Raynal (1):
      ata: libahci: do not complain in case of deferred probe

Moni Shoua (1):
      IB/mlx5: Prevent concurrent MR updates during invalidation

Munehisa Kamata (1):
      nbd: replace kill_bdev() with __invalidate_device() again

Nayna Jain (1):
      tpm: tpm_ibm_vtpm: Fix unallocated banks

Nianyao Tang (1):
      irqchip/gic-v3-its: Free unused vpt_page when alloc vpe table fail

Nicolin Chen (2):
      dma-contiguous: do not overwrite align in dma_alloc_contiguous()
      dma-contiguous: page-align the size in dma_free_contiguous()

Nishka Dasgupta (1):
      irqchip/irq-mbigen: Add of_node_put() before return

Numfor Mbiziwo-Tiapo (1):
      perf header: Fix use of unitialized value warning

Ondrej Mosnacek (1):
      selinux: fix memory leak in policydb_init()

Pankaj Gupta (1):
      dm table: fix dax_dev NULL dereference in device_synchronous()

Parav Pandit (2):
      IB/core: Fix querying total rdma stats
      IB/counters: Always initialize the port counter object

Paul Walmsley (2):
      riscv: dts: fu540-c000: drop "timebase-frequency"
      riscv: defconfig: align RV64 defconfig to the output of "make
savedefconfig"

Paul Wise (1):
      coredump: split pipe command whitespace before expanding template

Qian Cai (4):
      arm64/efi: fix variable 'si' set but not used
      arm64/mm: fix variable 'pud' set but not used
      arm64/mm: fix variable 'tag' set but not used
      asm-generic: fix -Wtype-limits compiler warnings

Rafael J. Wysocki (1):
      ACPI: PM: Fix regression in acpi_device_set_power()

Rajneesh Bhardwaj (1):
      platform/x86: intel_pmc_core: Add ICL-NNPI support to PMC Core

Ralph Campbell (1):
      mm/migrate.c: initialize pud_entry in migrate_vma()

Rayagonda Kokatanur (1):
      i2c: iproc: Fix i2c master read more than 63 bytes

Rob Clark (2):
      drm/vgem: fix cache synchronization on arm/arm64
      drm/msm: Use the correct dma_sync calls in msm_gem

Samuel Thibault (1):
      ALSA: hda: Fix 1-minute detection delay when i915 module is not avail=
able

Santosh Sivaraj (1):
      powerpc/kvm: Fall through switch case explicitly

Selvin Xavier (1):
      RDMA/bnxt_re: Honor vlan_id in GID entry comparison

Souptick Joarder (1):
      xen/gntdev.c: Replace vm_map_pages() with vm_map_pages_zero()

Stefan Haberland (1):
      s390/dasd: fix endless loop after read unit address configuration

Stephen Boyd (1):
      kbuild: Check for unknown options with cc-option usage in
Kconfig and clang

Stephen Rothwell (1):
      drivers/macintosh/smu.c: Mark expected switch fall-through

Suganath Prabu (1):
      scsi: mpt3sas: Use 63-bit DMA addressing on SAS35 HBA

Sven Schnelle (1):
      parisc: fix race condition in patching code

Sylwester Nawrocki (1):
      clk: Add missing documentation of devm_clk_bulk_get_optional() argume=
nt

Thomas Gleixner (6):
      lib/vdso/32: Remove inconsistent NULL pointer checks
      lib/vdso: Move fallback invocation to the callers
      lib/vdso/32: Provide legacy syscall fallbacks
      x86/vdso/32: Use 32bit syscall fallback
      arm64: compat: vdso: Use legacy syscalls as fallback
      drm/i810: Use CONFIG_PREEMPTION

Thomas Zimmermann (4):
      drm/client: Support unmapping of DRM client buffers
      drm/fb-helper: Map DRM client buffer only when required
      drm/fb-helper: Instanciate shadow FB if configured in device's mode_c=
onfig
      drm/bochs: Use shadow buffer for bochs framebuffer console

Tony Luck (1):
      IB/core: Add mitigation for Spectre V1

Tvrtko Ursulin (1):
      drm/i915: Fix GEN8_MCR_SELECTOR programming

Vasily Gorbik (8):
      s390/boot: add missing declarations and includes
      s390/lib: add missing include
      s390/perf: make cf_diag_csd static
      s390/kexec: add missing include to machine_kexec_reloc.c
      s390/mm: make gmap_test_and_clear_dirty_pmd static
      s390/3215: add switch fall through comment for -Wimplicit-fallthrough
      vfio-ccw: make vfio_ccw_async_region_ops static
      s390/zcrypt: adjust switch fall through comments for
-Wimplicit-fallthrough

Vignesh Raghavendra (1):
      mtd: hyperbus: Kconfig: Fix HBMC_AM654 dependencies

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Fix various tracepoints for gen2
      drm/i915: Deal with machines that expose less than three QGV points
      drm/i915: Make sure cdclk is high enough for DP audio on VLV/CHV

Vince Weaver (2):
      perf header: Fix divide by zero error if f_header.attr_size=3D=3D0
      perf tools: Fix perf.data documentation units for memory size

Vincenzo Frascino (1):
      arm64: vdso: Fix Makefile regression

Vladis Dronov (1):
      Bluetooth: hci_uart: check for missing tty operations

Wang Xiayang (1):
      drm/amdgpu: fix a potential information leaking bug

Wei Wang (1):
      mm/balloon_compaction: avoid duplicate page removal

Wei Yongjun (2):
      RDMA/siw: Fix error return code in siw_init_module()
      RDMA/hns: Fix error return code in hns_roce_v1_rsv_lp_qp()

Weitao Hou (1):
      mm/memory_hotplug.c: remove unneeded return for void function

Weiyi Lu (1):
      clk: mediatek: mt8183: Register 13MHz clock earlier for clocksource

Wen Yang (1):
      irqchip/renesas-rza1: Fix an use-after-free in rza1_irqc_probe()

Will Deacon (4):
      arm64: compat: Allow single-byte watchpoints on all addresses
      drivers/perf: arm_pmu: Fix failure path in PM notifier
      arm64: hw_breakpoint: Fix warnings about implicit fallthrough
      arm64: cpufeature: Fix feature comparison for CTR_EL0.{CWG,ERG}

Xi Wang (1):
      RDMA/hns: Fix sg offset non-zero issue

Xiaolin Zhang (2):
      drm/i915/gvt: fix incorrect cache entry for guest page mapping
      drm/i915/gvt: grab runtime pm first for forcewake use

Xiong Zhang (3):
      drm/i915/gvt: Warning for invalid ggtt access
      drm/i915/gvt: Don't use ggtt_validdate_range() with size=3D0
      drm/i915/gvt: Checking workload's gma earlier

Yang Shi (2):
      Revert "kmemleak: allow to coexist with fault injection"
      mm: vmscan: check if mem cgroup is disabled or not before
calling memcg slab shrinker

Yishai Hadas (5):
      IB/mlx5: Fix unreg_umr to ignore the mkey state
      IB/mlx5: Use direct mkey destroy command upon UMR unreg failure
      IB/mlx5: Move MRs to a kernel PD when freeing them to the MR cache
      IB/mlx5: Fix clean_mr() to work in the expected order
      IB/mlx5: Fix RSS Toeplitz setup to be aligned with the HW specificati=
on

YueHaibing (5):
      xen/pciback: remove set but not used variable 'old_state'
      RDMA/hns: Fix build error
      drm/bridge: lvds-encoder: Fix build error while CONFIG_DRM_KMS_HELPER=
=3Dm
      drm/bridge: tc358764: Fix build error
      ocfs2: remove set but not used variable 'last_hash'

Yuki Tsunashima (1):
      ALSA: pcm: fix lost wakeup event scenarios in snd_pcm_drain

Zhenyu Wang (1):
      drm/i915/gvt: remove duplicate include of trace.h
