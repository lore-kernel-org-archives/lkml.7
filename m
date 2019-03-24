Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FF6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCFB20811
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553462796;
	bh=dX4LH5W1aGDnMzyQbsedaq50dwhg8Abj2qayuEtNEu4=;
	h=From:Date:Subject:To:List-ID:From;
	b=mYM7Dj2xUlqCkRwK5t9abveRJ2k8fsUvtUT6WiAGF5W1rV7qvNk5oayGPeOlx18TB
	 PiuI4oiufQhjP5ljjYwfo3FBbWJjFzGsFhTU+gpRQuLTrXnG73plbpFKQfAobHUTSd
	 M4cM/IVYhaeh2jwMHVW1f66hdXFX6rIAX59I2Xdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfCXV0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:26:34 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34907 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:26:33 -0400
Received: by mail-lj1-f170.google.com with SMTP id t13so6056487lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nFY5nkDtZOxrM0ECB+AoKOmhznrgqhRnU1M3WPQctBo=;
        b=FD1VeqvYVnvRqz5ELXP06iSsJKCHZSwj3PyfKSca9qibUlqz5ILldt8aTO2pXb8/fN
         +qqFlEt2LjTkf99YX3O+4AR8hUHrA1rcjbG964y/2E7jAsa66KsruTUxYxOeA4nvbJ53
         ZRnZ+gEcr2ChqQQxtuwtGCAy93JS/g5b/36HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nFY5nkDtZOxrM0ECB+AoKOmhznrgqhRnU1M3WPQctBo=;
        b=QN1dDJ9EWB0xCjKTRbaPLwOvXYtag735Do7Mbphu7mI+N1zDQIV8zrr8G9cpDT0/I7
         f+dQnlWCfVWW3irPf7oKNsX8od9aq5lHHsQXMNgxHEznGbjCa1NeXV95Hm4rzwO3fYqb
         /KhdPJqBdqJH34kzkh4tGEZfuQJVWcg1uIFROiCqB4ENi1eZMLVXRkCcs/qaKaWMG4E9
         VAVs8+JsfjUUY2+Ua6u0oVXTXYWilc3RY6iOYVlRHZ14z9Xf4xeGHP4fNdap8deJUJZt
         ktGRNYcO6QWjIZRjqhAMNeDRr2jfgRRgqta1kmVh3GqaB328C3GdKv4TmlTMQOVoHndO
         CBWg==
X-Gm-Message-State: APjAAAUNqp+OB7fKocvh3GSqqykzIA7itbQOTF9XcK4G9srvgfY7cYaS
        TXsvdxoq7cgtw65ggFrmBmNJCEsm7dQ=
X-Google-Smtp-Source: APXvYqw5Z/DLkwLpB9P9JFv4O3YYXEeewOfC30cHfPR63uN4Jj0Of4tAQTP86/LxtFM03hOoup5D9g==
X-Received: by 2002:a2e:8719:: with SMTP id m25mr11589500lji.50.1553462787492;
        Sun, 24 Mar 2019 14:26:27 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n6sm3296245lfl.9.2019.03.24.14.26.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 14:26:26 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id l7so6060234ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:26:26 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr4804548lja.125.1553462785632;
 Sun, 24 Mar 2019 14:26:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Mar 2019 14:26:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
Message-ID: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
Subject: Linux 5.1-rc2
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, we're a week away from the merge window close, and here's rc2.
Things look fairly normal, but honestly, rc2 is usually too early to
tell.  People haven't necessarily had time to notice problems yet.
Which is just another way of saying "please test harder".

Nothing particularly stands out. Yes, we had some fixes for the new
io_ring code for issues that were discussed when merging it. Other
than that, worth noting is that the bulk of the patches are for
tooling, not the core kernel. In fact, about two thirds of the patch
is just for the tools/ subdirectory, most of it due to some late perf
tool updates. The people involved promise they're done.

Ignoring the tools thing, the rest is just spread all over, and it's
all pretty small. It's _roughly_ evenly split between arch updates,
drivers and filesystem code, but that's partially because of the
aforementioned io_ring thing (making the filesystem side pop a bit).
But there's minor noise elsewhere too. Most of the arch/ code is a
late ARC update. But none of it really is all that large or worrisome.

Shortlog appended for a flavor of the details (and you'll see the perf
dominance there)

Go test,

                    Linus

---

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Adrian Hunter (1):
      perf probe: Fix getting the kernel map

Alexander Shiyan (2):
      mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"
      clocksource/drivers/clps711x: Remove board support

Alexey Brodkin (1):
      ARC: DTB: [scripted] fix node name and address spelling

Andi Kleen (22):
      perf script: Support insn output for normal samples
      perf report: Support output in nanoseconds
      perf time-utils: Add utility function to print time stamps in nanosec=
onds
      perf report: Parse time quantum
      perf report: Use less for scripts output
      perf script: Filter COMM/FORK/.. events by CPU
      perf report: Support time sort key
      perf report: Support running scripts for current time range
      perf report: Support builtin perf script in scripts menu
      perf report: Implement browsing of individual samples
      perf tools: Add some new tips describing the new options
      perf script: Add array bound checking to list_scripts
      perf ui browser: Fix ui popup argv browser for many entries
      perf tools report: Add custom scripts to script menu
      perf list: Filter metrics too
      perf record: Allow to limit number of reported perf.data files
      perf record: Clarify help for --switch-output
      perf report: Show all sort keys in help output
      perf report: Indicate JITed code better in report
      perf script: Support relative time
      perf stat: Fix --no-scale
      perf stat: Improve scaling

Andrzej Hajda (1):
      drm/exynos/mixer: fix MIXER shadow registry synchronisation code

Andy Shevchenko (6):
      auxdisplay: hd44780: Fix memory leak on ->remove()
      auxdisplay: charlcd: Move to_priv() to charlcd namespace
      auxdisplay: charlcd: Introduce charlcd_free() helper
      auxdisplay: panel: Convert to use charlcd_free()
      auxdisplay: hd44780: Convert to use charlcd_free()
      ACPI / utils: Drop reference in test for device presence

Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Arnaldo Carvalho de Melo (5):
      perf tools: Update x86's syscall_64.tbl, no change in tools/perf beha=
viour
      tools headers uapi: Sync copy of asm-generic/unistd.h with the
kernel sources
      tools headers uapi: Update linux/in.h copy
      tools lib bpf: Fix the build by adding a missing stdarg.h include
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (3):
      irqchip/imx-irqsteer: Fix of_property_read_u32() error handling
      mmc: pxamci: fix enum type confusion
      mmc: davinci: remove extraneous __init annotation

Atish Patra (1):
      clocksource/drivers/riscv: Fix clocksource mask

Aya Levin (1):
      IB/mlx5: Fix mapping of link-mode to IB width and speed

Bart Van Assche (6):
      scsi: core: Also call destroy_rcu_head() for passthrough requests
      scsi: core: Avoid that a kernel warning appears during system resume
      block: Unexport blk_mq_add_to_requeue_list()
      blk-iolatency: #include "blk.h"
      blkcg: Fix kernel-doc warnings
      workqueue: Only unregister a registered lockdep key

Ben Hutchings (1):
      powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations

Borislav Petkov (1):
      x86/microcode: Announce reload operation's completion

Changbin Du (15):
      perf tools: Add doc about how to build perf with Asan and UBSan
      perf list: Don't forget to drop the reference to the allocated thread=
_map
      perf tools: Fix errors under optimization level '-Og'
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Delete the evlist before perf_session, fixing
heap-use-after-free issue
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf map: Remove map from 'names' tree in __maps__remove()
      perf maps: Purge all maps from the 'names' tree
      perf top: Fix global-buffer-overflow issue
      perf tests: Fix a memory leak of cpu_map object in the
openat_syscall_event_on_all_cpus test
      perf tests: Fix memory leak by expr__find_other() in test__expr()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Chris Wilson (2):
      drm/i915: Fix off-by-one in reporting hanging process
      drm/i915: Sanity check mmap length against object size

Christian K=C3=B6nig (2):
      drm/amdgpu: revert "cleanup setting bulk_movable"
      drm/amdgpu: fix invalid use of change_bit

Christophe Leroy (1):
      powerpc/6xx: fix setup and use of SPRN_SPRG_PGDIR for hash32

Colin Ian King (2):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition
and declaration
      x86/lib: Fix indentation issue, remove extra tab

Corentin Labbe (1):
      arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Dan Carpenter (1):
      drm/nouveau/dmem: Fix a NULL vs IS_ERR() check

Daniel Drake (1):
      mmc: alcor: fix DMA reads

Darrick J. Wong (1):
      ext4: prohibit fstrim in norecovery mode

Dave Airlie (1):
      drm/udl: use drm_gem_object_put_unlocked.

David Arcari (1):
      tools/power turbostat: return the exit status of a command

Deepak Rawat (1):
      drm/vmwgfx: Return 0 when gmrid::get_node runs out of ID's

Dongli Zhang (2):
      loop: access lo_backing_file only when the loop device is Lo_bound
      blk-mq: remove unused 'nr_expired' from blk_mq_hw_ctx

Enrico Weigelt, metux IT consult (1):
      arch: arc: Kconfig: pedantic formatting

Eugeniy Paltsev (5):
      ARC: [plat-hsdk]: Add reset controller handle to manage USB reset
      ARC: [plat-hsdk]: Enable AXI DW DMAC support
      ARCv2: lib: introduce memcpy optimized for unaligned access
      ARCv2: Add explcit unaligned access support (and ability to disable t=
oo)
      ARC: u-boot args: check that magic number is correct

Fabien Dessenne (2):
      irqchip/stm32: Don't clear rising/falling config registers at init
      irqchip/stm32: Don't set rising configuration registers at init

Fabrizio Castro (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774c0 support

Feng Tang (1):
      i40iw: Avoid panic when handling the inetdev event

Guenter Roeck (1):
      platform/chrome: cros_ec_debugfs: cancel/schedule logging work
only if supported

Gustavo A. R. Silva (1):
      genirq: Mark expected switch case fall-through

Hanjun Guo (2):
      arm64: Add MIDR encoding for HiSilicon Taishan CPUs
      arm64: kpti: Whitelist HiSilicon Taishan v110 CPUs

Himanshu Madhani (1):
      scsi: qla2xxx: Fix NULL pointer crash due to stale CPUID

Hui Wang (2):
      ALSA: hda - Don't trigger jackpoll_work in azx_resume
      ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Ilya Dryomov (3):
      rbd: set io_min, io_opt and discard_granularity to alloc_size
      libceph: wait for latest osdmap in ceph_monc_blacklist_add()
      rbd: drop wait_for_latest_osdmap()

Ingo Molnar (1):
      x86/cpufeature: Fix various quality problems in the
<asm/cpu_device_hd.h> header

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jan Kara (4):
      ext4: avoid panic during forced reboot
      udf: Fix crash on IO error during truncate
      udf: Propagate errors from udf_truncate_extents()
      fanotify: Allow copying of file handle to userspace

Jaroslav Kysela (1):
      ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist

Jason Yan (1):
      ext4: remove useless ext4_pin_inode()

Jens Axboe (11):
      io_uring: use regular request ref counts
      io_uring: make io_read/write return an integer
      io_uring: add prepped flag
      io_uring: fix fget/fput handling
      io_uring: fix poll races
      paride/pf: cleanup queues when detection fails
      paride/pcd: cleanup queues when detection fails
      io_uring: retry bulk slab allocs as single allocs
      io_uring: mark me as the maintainer
      iov_iter: add ITER_BVEC_FLAG_NO_REF flag
      block: add BIO_NO_PAGE_REF flag

Jiada Wang (1):
      PM / Domains: Avoid a potential deadlock

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Jiri Olsa (6):
      perf data: Support having perf.data stored as a directory
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir() function
      perf data: Make perf_data__size() work over directory
      perf header: Add DIR_FORMAT feature to describe directory data
      perf session: Add process callback to reader object

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Josh Poimboeuf (1):
      objtool: Move objtool_file struct off the stack

J=C3=A9r=C3=B4me Glisse (1):
      drm/nouveau/dmem: empty chunk do not have a buffer object
associated with them.

Kairui Song (1):
      x86/gart: Exclude GART aperture from kcore

Kangjie Lu (3):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region
      x86/hyperv: Prevent potential NULL pointer dereference

Kishon Vijay Abraham I (1):
      mmc: sdhci-omap: Set caps2 to indicate no physical write protect pin

Konstantin Khlebnikov (1):
      sched/core: Fix buffer overflow in cgroup2 property cpu.max

Linus Torvalds (1):
      Linux 5.1-rc2

Long Li (2):
      CIFS: Fix an issue with re-sending wdata when transport returning -EA=
GAIN
      CIFS: Fix an issue with re-sending rdata when transport returning -EA=
GAIN

Lu Baolu (2):
      iommu/vt-d: Check capability before disabling protected memory
      iommu/vt-d: Save the right domain ID used by hardware

Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Lukas Czerner (3):
      ext4: fix data corruption caused by unaligned direct AIO
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Luo Jiaxing (1):
      scsi: hisi_sas: Add softreset in hisi_sas_I_T_nexus_reset()

Mamatha Inamdar (1):
      perf vendor events: Remove P8 HW events which are not supported

Mans Rullgard (3):
      auxdisplay: deconfuse configuration
      auxdisplay: charlcd: simplify init message display
      auxdisplay: charlcd: make backlight initial state configurable

Marc Zyngier (1):
      irqchip/gic: Drop support for secondary GIC in non-DT systems

Marek Szyprowski (1):
      thermal: samsung: Fix incorrect check after code merge

Mark Rutland (1):
      arm64: apply workaround on A64FX v1r0

Martin Li=C5=A1ka (1):
      perf vendor events amd: perf PMU events for AMD Family 17h

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()

Matteo Croce (1):
      x86/mm: Don't leak kernel addresses

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (2):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors
      x86/cpu/cyrix: Remove {get,set}Cx86_old macros used for Cyrix process=
ors

Matthias Kaehlcke (1):
      arm64: remove obsolete selection of MULTI_IRQ_HANDLER

Maurizio Lombardi (1):
      scsi: iscsi: flush running unbind operations when removing a session

Michael Ellerman (2):
      powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
      powerpc/security: Fix spectre_v2 reporting

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in
hw_breakpoint_arch_parse() return an error

Nick Crews (1):
      platform/chrome: Fix locking pattern in wilco_ec_mailbox()

Nick Desaulniers (1):
      x86/boot: Restrict header scope to make Clang happy

Ondrej Mosnacek (1):
      selinux: fix NULL dereference in policydb_destroy()

Paul Burton (1):
      MIPS: Remove custom MIPS32 __kernel_fsid_t type

Paulo Alcantara (SUSE) (1):
      cifs: Fix slab-out-of-bounds when tracing SMB tcon

Peter Xu (1):
      genirq: Fix typo in comment of IRQD_MOVE_PCNTXT

Peter Zijlstra (1):
      sched/cpufreq: Fix 32-bit math overflow

Petr =C5=A0tetiar (1):
      mips: bcm47xx: Enable USB power on Netgear WNDR3400v2

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      thermal: mtk: Allocate enough space for mtk_thermal.

Quinn Tran (1):
      scsi: qla2xxx: Fix FC-AL connection target discovery

Rasmus Villemoes (1):
      irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

Robert Richter (1):
      iommu/iova: Fix tracking of recently failed iova address

Ronnie Sahlberg (1):
      cifs: allow guest mounts to work for smb3.11

Shaokun Zhang (1):
      thermal: cpu_cooling: Remove unused cur_freq variable

Shenghui Wang (1):
      sbitmap: trivial - update comment for sbitmap_deferred_clear_bit

Song Liu (19):
      perf record: Replace option --bpf-event with --no-bpf-event
      tools lib bpf: Introduce bpf_program__get_prog_info_linear()
      bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()
      perf bpf: Synthesize bpf events with bpf_program__get_prog_info_linea=
r()
      perf bpf: Make synthesize_bpf_events() receive perf_session
pointer instead of perf_tool
      perf bpf: Save bpf_prog_info in a rbtree in perf_env
      perf bpf: Save bpf_prog_info information as headers to perf.data
      perf bpf: Save BTF in a rbtree in perf_env
      perf bpf: Save BTF information as headers to perf.data
      perf top: Add option --no-bpf-event
      perf feature detection: Add -lopcodes to feature-libbfd
      perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
      perf bpf: Process PERF_BPF_EVENT_PROG_LOAD for annotation
      perf build: Check what binutils's 'disassembler()' signature to use
      perf annotate: Enable annotation of BPF programs
      perf evlist: Introduce side band thread
      perf tools: Save bpf_prog_info and BTF of new BPF programs
      perf bpf: Extract logic to create program names from
perf_event__synthesize_one_bpf_prog()
      perf bpf: Show more BPF program info in print_bpf_prog_info()

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Steve French (3):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND
      SMB3: Fix SMB3.1.1 guest mounts to Samba
      cifs: update internal module version number

Takashi Sakamoto (1):
      ALSA: firewire-motu: use 'version' field of unit directory to
identify model

Thomas Preston (1):
      drm/i915/bios: assume eDP is present on port A when there is no VBT

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Tony Jones (4):
      perf script python: Add Python3 support to exported-sql-viewer.py
      perf script python: Add Python3 support to export-to-postgresql.py
      perf script python: Add Python3 support to export-to-sqlite.py
      perf script python: Add printdate function to SQL exporters

Tyrel Datwyler (2):
      scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
      scsi: ibmvscsi: Fix empty event pool access during host removal

Valdis Kletnieks (4):
      x86/mm/pti: Make local symbols static
      genirq/devres: Remove excess parameter from kernel doc
      time/jiffies: Make refined_jiffies static
      watchdog/core: Make variables static

Valentin Schneider (3):
      sched/fair: Comment some nohz_balancer_kick() kick conditions
      sched/fair: Tune down misfit NOHZ kicks
      sched/fair: Skip LLC NOHZ logic for asymmetric systems

Vineet Gupta (5):
      ARC: perf: bpok condition only exists for ARCompact
      ARCv2: boot log: refurbish HS core/release identification
      ARC: boot log: cut down on verbosity
      ARC: unaligned: relax the check for gcc supporting -mno-unaligned-acc=
ess
      ARCv2: spinlock: remove the extra smp_mb before lock, after unlock

William Cohen (1):
      arm64/stacktrace: Export save_stack_trace_regs()

Wolfram Sang (1):
      mmc: renesas_sdhi: limit block count to 16 bit for old revisions

Xiaoli Feng (1):
      cifs: fix that return -EINVAL when do dedupe operationAditya Pakki (1=
):
      x86/hpet: Prevent potential NULL pointer dereference

Adrian Hunter (1):
      perf probe: Fix getting the kernel map

Alexander Shiyan (2):
      mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"
      clocksource/drivers/clps711x: Remove board support

Alexey Brodkin (1):
      ARC: DTB: [scripted] fix node name and address spelling

Andi Kleen (22):
      perf script: Support insn output for normal samples
      perf report: Support output in nanoseconds
      perf time-utils: Add utility function to print time stamps in nanosec=
onds
      perf report: Parse time quantum
      perf report: Use less for scripts output
      perf script: Filter COMM/FORK/.. events by CPU
      perf report: Support time sort key
      perf report: Support running scripts for current time range
      perf report: Support builtin perf script in scripts menu
      perf report: Implement browsing of individual samples
      perf tools: Add some new tips describing the new options
      perf script: Add array bound checking to list_scripts
      perf ui browser: Fix ui popup argv browser for many entries
      perf tools report: Add custom scripts to script menu
      perf list: Filter metrics too
      perf record: Allow to limit number of reported perf.data files
      perf record: Clarify help for --switch-output
      perf report: Show all sort keys in help output
      perf report: Indicate JITed code better in report
      perf script: Support relative time
      perf stat: Fix --no-scale
      perf stat: Improve scaling

Andrzej Hajda (1):
      drm/exynos/mixer: fix MIXER shadow registry synchronisation code

Andy Shevchenko (6):
      auxdisplay: hd44780: Fix memory leak on ->remove()
      auxdisplay: charlcd: Move to_priv() to charlcd namespace
      auxdisplay: charlcd: Introduce charlcd_free() helper
      auxdisplay: panel: Convert to use charlcd_free()
      auxdisplay: hd44780: Convert to use charlcd_free()
      ACPI / utils: Drop reference in test for device presence

Archer Yan (1):
      MIPS: Fix kernel crash for R6 in jump label branch function

Arnaldo Carvalho de Melo (5):
      perf tools: Update x86's syscall_64.tbl, no change in tools/perf beha=
viour
      tools headers uapi: Sync copy of asm-generic/unistd.h with the
kernel sources
      tools headers uapi: Update linux/in.h copy
      tools lib bpf: Fix the build by adding a missing stdarg.h include
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (3):
      irqchip/imx-irqsteer: Fix of_property_read_u32() error handling
      mmc: pxamci: fix enum type confusion
      mmc: davinci: remove extraneous __init annotation

Atish Patra (1):
      clocksource/drivers/riscv: Fix clocksource mask

Aya Levin (1):
      IB/mlx5: Fix mapping of link-mode to IB width and speed

Bart Van Assche (6):
      scsi: core: Also call destroy_rcu_head() for passthrough requests
      scsi: core: Avoid that a kernel warning appears during system resume
      block: Unexport blk_mq_add_to_requeue_list()
      blk-iolatency: #include "blk.h"
      blkcg: Fix kernel-doc warnings
      workqueue: Only unregister a registered lockdep key

Ben Hutchings (1):
      powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations

Borislav Petkov (1):
      x86/microcode: Announce reload operation's completion

Changbin Du (15):
      perf tools: Add doc about how to build perf with Asan and UBSan
      perf list: Don't forget to drop the reference to the allocated thread=
_map
      perf tools: Fix errors under optimization level '-Og'
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Delete the evlist before perf_session, fixing
heap-use-after-free issue
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf map: Remove map from 'names' tree in __maps__remove()
      perf maps: Purge all maps from the 'names' tree
      perf top: Fix global-buffer-overflow issue
      perf tests: Fix a memory leak of cpu_map object in the
openat_syscall_event_on_all_cpus test
      perf tests: Fix memory leak by expr__find_other() in test__expr()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Chen Jie (1):
      futex: Ensure that futex address is aligned in handle_futex_death()

Chris Wilson (2):
      drm/i915: Fix off-by-one in reporting hanging process
      drm/i915: Sanity check mmap length against object size

Christian K=C3=B6nig (2):
      drm/amdgpu: revert "cleanup setting bulk_movable"
      drm/amdgpu: fix invalid use of change_bit

Christophe Leroy (1):
      powerpc/6xx: fix setup and use of SPRN_SPRG_PGDIR for hash32

Colin Ian King (2):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition
and declaration
      x86/lib: Fix indentation issue, remove extra tab

Corentin Labbe (1):
      arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Dan Carpenter (1):
      drm/nouveau/dmem: Fix a NULL vs IS_ERR() check

Daniel Drake (1):
      mmc: alcor: fix DMA reads

Darrick J. Wong (1):
      ext4: prohibit fstrim in norecovery mode

Dave Airlie (1):
      drm/udl: use drm_gem_object_put_unlocked.

David Arcari (1):
      tools/power turbostat: return the exit status of a command

Deepak Rawat (1):
      drm/vmwgfx: Return 0 when gmrid::get_node runs out of ID's

Dongli Zhang (2):
      loop: access lo_backing_file only when the loop device is Lo_bound
      blk-mq: remove unused 'nr_expired' from blk_mq_hw_ctx

Enrico Weigelt, metux IT consult (1):
      arch: arc: Kconfig: pedantic formatting

Eugeniy Paltsev (5):
      ARC: [plat-hsdk]: Add reset controller handle to manage USB reset
      ARC: [plat-hsdk]: Enable AXI DW DMAC support
      ARCv2: lib: introduce memcpy optimized for unaligned access
      ARCv2: Add explcit unaligned access support (and ability to disable t=
oo)
      ARC: u-boot args: check that magic number is correct

Fabien Dessenne (2):
      irqchip/stm32: Don't clear rising/falling config registers at init
      irqchip/stm32: Don't set rising configuration registers at init

Fabrizio Castro (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774c0 support

Feng Tang (1):
      i40iw: Avoid panic when handling the inetdev event

Guenter Roeck (1):
      platform/chrome: cros_ec_debugfs: cancel/schedule logging work
only if supported

Gustavo A. R. Silva (1):
      genirq: Mark expected switch case fall-through

Hanjun Guo (2):
      arm64: Add MIDR encoding for HiSilicon Taishan CPUs
      arm64: kpti: Whitelist HiSilicon Taishan v110 CPUs

Himanshu Madhani (1):
      scsi: qla2xxx: Fix NULL pointer crash due to stale CPUID

Hui Wang (2):
      ALSA: hda - Don't trigger jackpoll_work in azx_resume
      ALSA: hda - Enforces runtime_resume after S3 and S4 for each codec

Ilya Dryomov (3):
      rbd: set io_min, io_opt and discard_granularity to alloc_size
      libceph: wait for latest osdmap in ceph_monc_blacklist_add()
      rbd: drop wait_for_latest_osdmap()

Ingo Molnar (1):
      x86/cpufeature: Fix various quality problems in the
<asm/cpu_device_hd.h> header

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jan Kara (4):
      ext4: avoid panic during forced reboot
      udf: Fix crash on IO error during truncate
      udf: Propagate errors from udf_truncate_extents()
      fanotify: Allow copying of file handle to userspace

Jaroslav Kysela (1):
      ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist

Jason Yan (1):
      ext4: remove useless ext4_pin_inode()

Jens Axboe (11):
      io_uring: use regular request ref counts
      io_uring: make io_read/write return an integer
      io_uring: add prepped flag
      io_uring: fix fget/fput handling
      io_uring: fix poll races
      paride/pf: cleanup queues when detection fails
      paride/pcd: cleanup queues when detection fails
      io_uring: retry bulk slab allocs as single allocs
      io_uring: mark me as the maintainer
      iov_iter: add ITER_BVEC_FLAG_NO_REF flag
      block: add BIO_NO_PAGE_REF flag

Jiada Wang (1):
      PM / Domains: Avoid a potential deadlock

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Jiri Olsa (6):
      perf data: Support having perf.data stored as a directory
      perf data: Don't store auxtrace index for directory data file
      perf data: Add perf_data__update_dir() function
      perf data: Make perf_data__size() work over directory
      perf header: Add DIR_FORMAT feature to describe directory data
      perf session: Add process callback to reader object

Jiufei Xue (1):
      ext4: fix NULL pointer dereference while journal is aborted

Josh Poimboeuf (1):
      objtool: Move objtool_file struct off the stack

J=C3=A9r=C3=B4me Glisse (1):
      drm/nouveau/dmem: empty chunk do not have a buffer object
associated with them.

Kairui Song (1):
      x86/gart: Exclude GART aperture from kcore

Kangjie Lu (3):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region
      x86/hyperv: Prevent potential NULL pointer dereference

Kishon Vijay Abraham I (1):
      mmc: sdhci-omap: Set caps2 to indicate no physical write protect pin

Konstantin Khlebnikov (1):
      sched/core: Fix buffer overflow in cgroup2 property cpu.max

Linus Torvalds (1):
      Linux 5.1-rc2

Long Li (2):
      CIFS: Fix an issue with re-sending wdata when transport returning -EA=
GAIN
      CIFS: Fix an issue with re-sending rdata when transport returning -EA=
GAIN

Lu Baolu (2):
      iommu/vt-d: Check capability before disabling protected memory
      iommu/vt-d: Save the right domain ID used by hardware

Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Lukas Czerner (3):
      ext4: fix data corruption caused by unaligned direct AIO
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Luo Jiaxing (1):
      scsi: hisi_sas: Add softreset in hisi_sas_I_T_nexus_reset()

Mamatha Inamdar (1):
      perf vendor events: Remove P8 HW events which are not supported

Mans Rullgard (3):
      auxdisplay: deconfuse configuration
      auxdisplay: charlcd: simplify init message display
      auxdisplay: charlcd: make backlight initial state configurable

Marc Zyngier (1):
      irqchip/gic: Drop support for secondary GIC in non-DT systems

Marek Szyprowski (1):
      thermal: samsung: Fix incorrect check after code merge

Mark Rutland (1):
      arm64: apply workaround on A64FX v1r0

Martin Li=C5=A1ka (1):
      perf vendor events amd: perf PMU events for AMD Family 17h

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()

Matteo Croce (1):
      x86/mm: Don't leak kernel addresses

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (2):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors
      x86/cpu/cyrix: Remove {get,set}Cx86_old macros used for Cyrix process=
ors

Matthias Kaehlcke (1):
      arm64: remove obsolete selection of MULTI_IRQ_HANDLER

Maurizio Lombardi (1):
      scsi: iscsi: flush running unbind operations when removing a session

Michael Ellerman (2):
      powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038
      powerpc/security: Fix spectre_v2 reporting

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in
hw_breakpoint_arch_parse() return an error

Nick Crews (1):
      platform/chrome: Fix locking pattern in wilco_ec_mailbox()

Nick Desaulniers (1):
      x86/boot: Restrict header scope to make Clang happy

Ondrej Mosnacek (1):
      selinux: fix NULL dereference in policydb_destroy()

Paul Burton (1):
      MIPS: Remove custom MIPS32 __kernel_fsid_t type

Paulo Alcantara (SUSE) (1):
      cifs: Fix slab-out-of-bounds when tracing SMB tcon

Peter Xu (1):
      genirq: Fix typo in comment of IRQD_MOVE_PCNTXT

Peter Zijlstra (1):
      sched/cpufreq: Fix 32-bit math overflow

Petr =C5=A0tetiar (1):
      mips: bcm47xx: Enable USB power on Netgear WNDR3400v2

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      thermal: mtk: Allocate enough space for mtk_thermal.

Quinn Tran (1):
      scsi: qla2xxx: Fix FC-AL connection target discovery

Rasmus Villemoes (1):
      irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

Robert Richter (1):
      iommu/iova: Fix tracking of recently failed iova address

Ronnie Sahlberg (1):
      cifs: allow guest mounts to work for smb3.11

Shaokun Zhang (1):
      thermal: cpu_cooling: Remove unused cur_freq variable

Shenghui Wang (1):
      sbitmap: trivial - update comment for sbitmap_deferred_clear_bit

Song Liu (19):
      perf record: Replace option --bpf-event with --no-bpf-event
      tools lib bpf: Introduce bpf_program__get_prog_info_linear()
      bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()
      perf bpf: Synthesize bpf events with bpf_program__get_prog_info_linea=
r()
      perf bpf: Make synthesize_bpf_events() receive perf_session
pointer instead of perf_tool
      perf bpf: Save bpf_prog_info in a rbtree in perf_env
      perf bpf: Save bpf_prog_info information as headers to perf.data
      perf bpf: Save BTF in a rbtree in perf_env
      perf bpf: Save BTF information as headers to perf.data
      perf top: Add option --no-bpf-event
      perf feature detection: Add -lopcodes to feature-libbfd
      perf symbols: Introduce DSO_BINARY_TYPE__BPF_PROG_INFO
      perf bpf: Process PERF_BPF_EVENT_PROG_LOAD for annotation
      perf build: Check what binutils's 'disassembler()' signature to use
      perf annotate: Enable annotation of BPF programs
      perf evlist: Introduce side band thread
      perf tools: Save bpf_prog_info and BTF of new BPF programs
      perf bpf: Extract logic to create program names from
perf_event__synthesize_one_bpf_prog()
      perf bpf: Show more BPF program info in print_bpf_prog_info()

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Steve French (3):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND
      SMB3: Fix SMB3.1.1 guest mounts to Samba
      cifs: update internal module version number

Takashi Sakamoto (1):
      ALSA: firewire-motu: use 'version' field of unit directory to
identify model

Thomas Preston (1):
      drm/i915/bios: assume eDP is present on port A when there is no VBT

Thomas Zimmermann (1):
      drm/vmwgfx: Don't double-free the mode stored in par->set_mode

Tony Jones (4):
      perf script python: Add Python3 support to exported-sql-viewer.py
      perf script python: Add Python3 support to export-to-postgresql.py
      perf script python: Add Python3 support to export-to-sqlite.py
      perf script python: Add printdate function to SQL exporters

Tyrel Datwyler (2):
      scsi: ibmvscsi: Protect ibmvscsi_head from concurrent modificaiton
      scsi: ibmvscsi: Fix empty event pool access during host removal

Valdis Kletnieks (4):
      x86/mm/pti: Make local symbols static
      genirq/devres: Remove excess parameter from kernel doc
      time/jiffies: Make refined_jiffies static
      watchdog/core: Make variables static

Valentin Schneider (3):
      sched/fair: Comment some nohz_balancer_kick() kick conditions
      sched/fair: Tune down misfit NOHZ kicks
      sched/fair: Skip LLC NOHZ logic for asymmetric systems

Vineet Gupta (5):
      ARC: perf: bpok condition only exists for ARCompact
      ARCv2: boot log: refurbish HS core/release identification
      ARC: boot log: cut down on verbosity
      ARC: unaligned: relax the check for gcc supporting -mno-unaligned-acc=
ess
      ARCv2: spinlock: remove the extra smp_mb before lock, after unlock

William Cohen (1):
      arm64/stacktrace: Export save_stack_trace_regs()

Wolfram Sang (1):
      mmc: renesas_sdhi: limit block count to 16 bit for old revisions

Xiaoli Feng (1):
      cifs: fix that return -EINVAL when do dedupe operation

Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqacti=
on.

Yishai Hadas (2):
      net/mlx5: Fix DCT creation bad flow
      IB/mlx5: Use mlx5 core to create/destroy a DEVX DCT

YueHaibing (10):
      drivers: base: swnode: Make two functions static
      irqchip/brcmstb-l2: Make two init functions static
      irqchip/mmp: Make mmp_irq_domain_ops static
      irqchip/irq-mvebu-sei: Make mvebu_sei_ap806_caps static
      drm/nouveau/dmem: remove set but not used variable 'drm'
      drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
      clocksource/drivers/clps711x: Make clps711x_clksrc_init() static
      clocksource/drivers/tcb_clksrc: Make tc_clksrc_suspend/resume() stati=
c
      clocksource/drivers/timer-ti-dm: Make
omap_dm_timer_set_load_start() static
      clocksource/drivers/mips-gic-timer: Make gic_compare_irqaction static

Yufen Yu (2):
      blk-mq: use blk_mq_sched_mark_restart_hctx to set RESTART
      block: add BLK_MQ_POLL_CLASSIC for hybrid poll and return EINVAL
for unexpected value

Zhang Rui (1):
      thermal/intel_powerclamp: fix truncated kthread name

ZhangXiaoxu (1):
      inotify: Fix fsnotify_mark refcount leak in
inotify_update_existing_watch()

zhangyi (F) (2):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()
      ext4: cleanup bh release code in ext4_ind_remove_space()


Yasha Cherikovsky (1):
      MIPS: Ensure ELF appended dtb is relocated

Yifeng Li (1):
      mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqacti=
on.

Yishai Hadas (2):
      net/mlx5: Fix DCT creation bad flow
      IB/mlx5: Use mlx5 core to create/destroy a DEVX DCT

YueHaibing (10):
      drivers: base: swnode: Make two functions static
      irqchip/brcmstb-l2: Make two init functions static
      irqchip/mmp: Make mmp_irq_domain_ops static
      irqchip/irq-mvebu-sei: Make mvebu_sei_ap806_caps static
      drm/nouveau/dmem: remove set but not used variable 'drm'
      drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
      clocksource/drivers/clps711x: Make clps711x_clksrc_init() static
      clocksource/drivers/tcb_clksrc: Make tc_clksrc_suspend/resume() stati=
c
      clocksource/drivers/timer-ti-dm: Make
omap_dm_timer_set_load_start() static
      clocksource/drivers/mips-gic-timer: Make gic_compare_irqaction static

Yufen Yu (2):
      blk-mq: use blk_mq_sched_mark_restart_hctx to set RESTART
      block: add BLK_MQ_POLL_CLASSIC for hybrid poll and return EINVAL
for unexpected value

Zhang Rui (1):
      thermal/intel_powerclamp: fix truncated kthread name

ZhangXiaoxu (1):
      inotify: Fix fsnotify_mark refcount leak in
inotify_update_existing_watch()

zhangyi (F) (2):
      ext4: brelse all indirect buffer in ext4_ind_remove_space()
      ext4: cleanup bh release code in ext4_ind_remove_space()
