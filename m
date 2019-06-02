Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F2C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB7D241CB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559509531;
	bh=0yMN/BKZmIe/bLQH65WJhiFej1MHFQTqqb/6p+VwkEo=;
	h=From:Date:Subject:To:List-ID:From;
	b=k5IAXO+gxNc5hY1JzWDlRQZ3IvEcP+DIddStqcN9adKwlDJOafgr19gzd33RRvy8i
	 J8i6NOFnt2b+/DSJ8GjIEJ6KgYRkSSz21jhF5mOhG6st0J2N24Ov6GRyeRDxuWW4Rw
	 9f7uuHghnPlpWmGuKno1uYevv5GOnE1Zm8C6xPbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFBVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 17:05:30 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:40701 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFBVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 17:05:30 -0400
Received: by mail-io1-f42.google.com with SMTP id n5so12650015ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Vjr6Sen/uQcHHfvV3FJPubYwvsmUjv7J9/HZlHAksfE=;
        b=PSeqLfBuMNQlK8vNvStFCDuBWsL+zOc5LT0ztzN2Mc/hFVdpavfvOEumsFyYVEO7g+
         No4Qe51Y9J8Vvepu//9LpnfvsfHG8+NDSYdqDhh1rMLhtPvVDgfoI3n9oCNBby3Q1ggH
         pH/0wCmGYj8i0rOhXhf64Os+qpwZnfMn6icJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Vjr6Sen/uQcHHfvV3FJPubYwvsmUjv7J9/HZlHAksfE=;
        b=KZXtULw8ZkcAxVs2pATDgc0X4XzZVzJT6SRn1O0euXHOd5hfgVzhRYAl7oGr9+wn8l
         yHcrg4XOmORV+mFc8MkcB+HBIEqWjCV91jDaMp8GjsFzhbZGvdt8jN0GqzwlQ6qKQ77O
         4bKz7yyAcT8PVRAhC96Uja4eKVNuH+8zFzWAG2tkNhSg+44GjmH/iWHO5NVDDawLat7T
         zXjws/HvqJfhPTEiFFYP5aOZLy49HP/HcIANyJQmfjUWhoPY+4fTplPK5OB7OahMT1cW
         4E/R1QD4hTdenvoZvboysMpbH8wZB2MQauuWpVOCgp5ppH9peUV6cOPkVQ6xqE4lBozg
         ENfw==
X-Gm-Message-State: APjAAAWA6gIOXNW+JZuCIP+AVyVasqVRzTtpDwvmISVQp37a9pxglfxO
        BcWcDo6+ojIPhl4J/XKyB0LI+FYVbQ0=
X-Google-Smtp-Source: APXvYqz+4t7VojZE6GKbqqoJvTyCEmpcWFDe0wK3A6PGksYda+hSBzJvf6TXbKir0tXLdHw/Gr1Stg==
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr13794284iop.111.1559509521236;
        Sun, 02 Jun 2019 14:05:21 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id m189sm5548905itm.21.2019.06.02.14.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 14:05:20 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i10so2737130iol.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 14:05:20 -0700 (PDT)
X-Received: by 2002:a6b:cd86:: with SMTP id d128mr4251146iog.234.1559509520196;
 Sun, 02 Jun 2019 14:05:20 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Jun 2019 14:05:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1evGTxx-aSNHO+m5xSa1sc6fQe7Y8fH=_ruGcwMyfyA@mail.gmail.com>
Message-ID: <CAHk-=wg1evGTxx-aSNHO+m5xSa1sc6fQe7Y8fH=_ruGcwMyfyA@mail.gmail.com>
Subject: Linux 5.2-rc3
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Fairly calm week, and rc3 is almost exactly the same size as rc2
was.  Which is a bit unusual - usually rc2 is calm, and then rc3 is
when people have started finding problems and we get a more active
week.

But far be it for me to complain about a calm rc week, so I won't.

Nothing particularly stands out. Yes, the continued SPDX work does
kind of result in a constant background hum of license comment
cleanups if you look at the patch itself, but it obviously has no code
impact (outside of one buggy conversion that was fixed, but caused a
build failure before that ;)

Anyway, even ignoring the SPDX changes, there's just a lot of small
fixes spread all over, not anything that looks particularly scary or
worrisome. Maybe next week is when the other shoe drops, but maybe
this will just be a nice calm release. That would be lovely.

                  Linus

---

Alan Stern (3):
      USB: Fix slab-out-of-bounds write in usb_get_bos_descriptor
      media: usb: siano: Fix general protection fault in smsusb
      media: usb: siano: Fix false-positive "uninitialized variable" warnin=
g

Alex Xu (Hello71) (1):
      crypto: ux500 - fix license comment syntax error

Alexandre Belloni (2):
      selftests/harness: Allow test to configure timeout
      selftests: rtc: rtctest: specify timeouts

Amelie Delaunay (1):
      pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO is not defined

Amit Cohen (1):
      mlxsw: spectrum: Prevent force of 56G

Andreas Oetken (1):
      hsr: fix don't prune the master node from the node_db

Andrew Morton (1):
      mm/vmalloc.c: fix typo in comment

Andrey Smirnov (1):
      xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()

Andy Duan (1):
      net: fec: fix the clk mismatch in failed_reset path

Andy Shevchenko (1):
      pinctrl: intel: Use GENMASK() consistently

Anju T Sudhakar (1):
      powerpc/powernv: Return for invalid IMC domain

Antoine Tenart (1):
      net: mvpp2: fix bad MVPP2_TXQ_SCHED_TOKEN_CNTR_REG queue value

Ard Biesheuvel (2):
      x86/boot: Provide KASAN compatible aliases for string routines
      arm64/module: revert to unsigned interpretation of ABS16/32 relocatio=
ns

Arnaldo Carvalho de Melo (8):
      tools include UAPI: Update copy of files related to new fspick,
fsmount, fsconfig, fsopen, move_mount and open_tree syscalls
      tools arch x86: Sync asm/cpufeatures.h with the with the kernel
      tools headers UAPI: Sync linux/sched.h with the kernel
      tools headers UAPI: Sync linux/fs.h with the kernel
      tools headers UAPI: Sync drm/i915_drm.h with the kernel
      tools headers UAPI: Sync drm/drm.h with the kernel
      perf test vmlinux-kallsyms: Ignore aliases to _etext when
searching on kallsyms
      tools headers UAPI: Sync kvm.h headers with the kernel sources

Ayman Bagabas (1):
      ALSA: hda/realtek - Enable micmute LED for Huawei laptops

Bard Liao (1):
      ALSA: hda - Force polling mode on CNL for fixing codec communication

Bart Van Assche (8):
      block/partitions/ldm: Convert a kernel-doc header into a
non-kernel-doc header
      block: Convert blk_invalidate_devt() header into a non-kernel-doc hea=
der
      block: Fix throtl_pending_timer_fn() kernel-doc header
      block: Fix blk_mq_*_map_queues() kernel-doc headers
      block: Fix rq_qos_wait() kernel-doc header
      block: Fix bsg_setup_queue() kernel-doc header
      blk-mq: Fix spelling in a source code comment
      blk-mq: Document the blk_mq_hw_queue_to_node() arguments

Benjamin Coddington (1):
      Revert "lockd: Show pid of lockd for remote locks"

Biao Huang (3):
      net: stmmac: update rx tail pointer register to fix rx dma hang issue=
.
      net: stmmac: fix csr_clk can't be zero issue
      net: stmmac: dwmac-mediatek: modify csr_clk value to fix mdio
read/write fail

Carsten Schmid (1):
      usb: xhci: avoid null pointer deref when bos field is NULL

Catalin Marinas (1):
      arm64: Fix the arm64_personality() syscall wrapper redirection

Chengguang Xu (1):
      staging: erofs: set sb->s_root to NULL when failing from __getname()

Chris Down (1):
      mm, memcg: consider subtrees in memory.events

Christian Borntraeger (1):
      kvm: fix compile on s390 part 2

Chunfeng Yun (1):
      usb: mtu3: fix up undefined reference to usb_debug_root

Claudiu Beznea (1):
      net: macb: save/restore the remaining registers and features

Claudiu Manoil (1):
      ocelot: Dont allocate another multicast list, use __dev_mc_sync

Colin Ian King (1):
      cifs: fix memory leak of pneg_inbuf on -EOPNOTSUPP ioctl case

C=C3=A9dric Le Goater (7):
      KVM: PPC: Book3S HV: XIVE: Clear file mapping when device is released
      KVM: PPC: Book3S HV: XIVE: Do not test the EQ flag validity when rese=
tting
      KVM: PPC: Book3S HV: XIVE: Fix the enforced limit on the vCPU identif=
ier
      KVM: PPC: Book3S HV: XIVE: Introduce a new mutex for the XIVE device
      KVM: PPC: Book3S HV: XIVE: Do not clear IRQ data of passthrough inter=
rupts
      KVM: PPC: Book3S HV: XIVE: Take the srcu read lock when accessing mem=
slots
      KVM: PPC: Book3S HV: XIVE: Fix page offset when clearing ESB pages

Dan Carpenter (6):
      staging: kpc2000: double unlock in error handling in kpc_dma_transfer=
()
      Staging: vc04_services: Fix a couple error codes
      staging: vc04_services: prevent integer overflow in create_pagelist()
      staging: wilc1000: Fix some double unlock bugs in wilc_wlan_cleanup()
      mISDN: Fix indenting in dsp_cmx.c
      mISDN: make sure device name is NUL terminated

David Ahern (1):
      ipv6: Fix redirect with VRF

David Rientjes (1):
      arch/parisc/configs/c8000_defconfig: remove obsoleted
CONFIG_DEBUG_SLAB_LEAK

Dennis Zhou (1):
      btrfs: correct zstd workspace manager lock to use spin_lock_bh()

Dmitry Bogdanov (2):
      net: aquantia: check rx csum for all packets in LRO session
      net: aquantia: fix LRO with FCS error

Eduardo Valentin (1):
      Revert "drivers: thermal: tsens: Add new operation to check if a
sensor is enabled"

Eric Dumazet (4):
      ipv4/igmp: fix another memory leak in igmpv3_del_delrec()
      ipv4/igmp: fix build error if !CONFIG_IP_MULTICAST
      llc: fix skb leak in llc_build_and_send_ui_pkt()
      net-gro: fix use-after-free read in napi_gro_frags()

Eric W. Biederman (1):
      signal/arm64: Use force_sig not force_sig_fault for SIGKILL

Fabiano Rosas (1):
      scripts/gdb: fix invocation when CONFIG_COMMON_CLK is not set

Fabio Estevam (1):
      xhci: Use %zu for printing size_t type

Filipe Manana (5):
      Btrfs: incremental send, fix file corruption when no-holes
feature is enabled
      Btrfs: incremental send, fix emission of invalid clone operations
      Btrfs: fix fsync not persisting changed attributes of a directory
      Btrfs: fix wrong ctime and mtime of a directory after log replay
      Btrfs: fix race updating log root item during fsync

Flora Cui (1):
      drm/amdgpu: reserve stollen vram for raven series

Florian Fainelli (1):
      Documentation: net-sysfs: Remove duplicate PHY device documentation

Florian Westphal (7):
      netfilter: nf_tables: fix oops during rule dump
      netfilter: nat: fix udp checksum corruption
      netfilter: nf_flow_table: ignore DF bit setting
      netfilter: nft_flow_offload: set liberal tracking mode for tcp
      netfilter: nft_flow_offload: don't offload when sequence numbers
need adjustment
      netfilter: nft_flow_offload: IPCB is only valid for ipv4 family
      selftests: netfilter: add flowtable test script

Frank van der Linden (1):
      x86/CPU/AMD: Don't force the CPB cap when running under a hypervisor

Geert Uytterhoeven (1):
      ALSA: fireface: Use ULL suffixes for 64-bit constants

Gen Zhang (4):
      efi/x86/Add missing error handling to old_memmap 1:1 mapping code
      ipv6_sockglue: Fix a missing-check bug in ip6_ra_control()
      ip_sockglue: Fix missing-check bug in ip_ra_control()
      dfs_cache: fix a wrong use of kfree in flush_cache_ent()

Geordan Neukum (1):
      staging: kpc2000: Add dependency on MFD_CORE to kconfig symbol 'KPC20=
00'

George G. Davis (1):
      serial: sh-sci: disable DMA for uart_console

Gerd Hoffmann (1):
      drm/qxl: drop WARN_ONCE()

Greg Kroah-Hartman (1):
      treewide: Add SPDX license identifier - Kbuild

Grzegorz Halat (1):
      vt/fbcon: deinitialize resources in visual_init() after failed
memory allocation

Harald Freudenberger (3):
      s390/zcrypt: Fix wrong dispatching for control domain CPRBs
      s390/crypto: fix gcm-aes-s390 selftest failures
      s390/crypto: fix possible sleep during spinlock aquired

Harry Wentland (1):
      drm/amd/display: Don't load DMCU for Raven 1 (v2)

Heiko Carstens (2):
      MAINTAINERS: Farewell Martin Schwidefsky
      MAINTAINERS: add Vasily Gorbik and Christian Borntraeger for s390

Heiner Kallweit (1):
      r8169: fix MAC address being lost in PCI D3

Henry Lin (1):
      xhci: update bounce buffer with correct sg num

Hui Wang (1):
      ALSA: hda/realtek - Improve the headset mic for Acer Aspire laptops

Igor Russkikh (1):
      net: aquantia: tx clean budget logic error

Ioana Ciornei (1):
      net: dsa: tag_8021q: Change order of rx_vid setup

Ioana Radulescu (3):
      dpaa2-eth: Fix potential spectre issue
      dpaa2-eth: Use PTR_ERR_OR_ZERO where appropriate
      dpaa2-eth: Make constant 64-bit long

Jagdish Motwani (1):
      netfilter: nf_queue: fix reinject verdict handling

Jakub Kicinski (11):
      Documentation: net: move device drivers docs to a submenu
      Documentation: tls: RSTify the ktls documentation
      Documentation: add TLS offload documentation
      net/tls: avoid NULL-deref on resync during device removal
      net/tls: fix state removal with feature flags off
      net/tls: don't ignore netdev notifications if no TLS features
      net/tls: fix lowat calculation if some data came from previous record
      selftests/tls: test for lowat overshoot with multiple records
      net/tls: fix no wakeup on partial reads
      selftests/tls: add test for sleeping even though there is data
      net: don't clear sock->sk early to avoid trouble in strparser

Jan Kara (2):
      loop: Don't change loop device under exclusive opener
      block: Don't revalidate bdev of hidden gendisk

Jarod Wilson (1):
      bonding/802.3ad: fix slave link initialization transition states

Jason Yan (2):
      scsi: libsas: only clear phy->in_shutdown after shutdown event done
      scsi: libsas: delete sas port if expander discover failed

Jeffrin Jose T (1):
      selftests: netfilter: missing error check when setting up veth interf=
ace

Jes Sorensen (1):
      blk-mq: Fix memory leak in error handling

Jia-Ju Bai (1):
      usb: xhci: Fix a potential null pointer dereference in
xhci_debugfs_create_endpoint()

Jiri Olsa (1):
      perf machine: Read also the end of the kernel

Jiri Pirko (1):
      mlxsw: spectrum_acl: Avoid warning after identical rules insertion

Jiri Slaby (1):
      memcg: make it work on sparse non-0-node systems

Jisheng Zhang (2):
      net: stmmac: fix reset gpio free missing
      net: mvneta: Fix err code path of probe

Joe Burmeister (1):
      tty: max310x: Fix external crystal register setup

Joe Lawrence (1):
      stacktrace: Unbreak stack_trace_save_tsk_reliable()

John Pittman (1):
      block: print offending values when cloned rq limits are exceeded

Jonathan Corbet (8):
      doc: Cope with Sphinx logging deprecations
      doc: Cope with the deprecation of AutoReporter
      docs: fix numaperf.rst and add it to the doc tree
      lib/list_sort: fix kerneldoc build error
      docs: fix multiple doc build warnings in enumeration.rst
      docs: Fix conf.py for Sphinx 2.0
      drm/i915: Maintain consistent documentation subsection ordering
      include/linux/generic-radix-tree.h: fix kerneldoc comment

Jorge Ramirez-Ortiz (1):
      tty: serial: msm_serial: Fix XON/XOFF

Kai-Heng Feng (1):
      pinctrl: intel: Clear interrupt status in mask/unmask callback

Kailang Yang (2):
      ALSA: hda/realtek - Check headset type by unplug and resume
      ALSA: hda/realtek - Set default power save node to 0

Kees Cook (2):
      gcc-plugins: Fix build failures under Darwin host
      net: tulip: de4x5: Drop redundant MODULE_DEVICE_TABLE()

Kefeng Wang (1):
      kernel/fork.c: make max_threads symbol static

Lianbo Jiang (1):
      scsi: smartpqi: properly set both the DMA mask and the coherent DMA m=
ask

Linus Torvalds (1):
      Linux 5.2-rc3

Lucas Stach (1):
      drm/etnaviv: lock MMU while dumping core

Madalin Bucur (1):
      dpaa_eth: use only online CPU portals

Masahiro Yamada (3):
      s390: add unreachable() to dump_fault_info() to fix -Wmaybe-uninitial=
ized
      s390: mark __cpacf_check_opcode() and cpacf_query_func() as
__always_inline
      treewide: fix typos of SPDX-License-Identifier

Masahisa Kojima (1):
      i2c: synquacer: fix synquacer_i2c_doxfer() return value

Masami Hiramatsu (2):
      selftests/ftrace: Make a script checkbashisms clean
      selftests/ftrace: Add checkbashisms meta-testcase

Mathias Nyman (1):
      xhci: Fix immediate data transfer if buffer is already DMA mapped

Mauro Carvalho Chehab (2):
      scripts/sphinx-pre-install: make it handle Sphinx versions
      media: smsusb: better handle optional alignment

Max Filippov (1):
      staging: kpc2000: fix build error on xtensa

Max Uvarov (4):
      net: phy: dp83867: fix speed 10 in sgmii mode
      net: phy: dp83867: increase SGMII autoneg timer duration
      net: phy: dp83867: do not call config_init twice
      net: phy: dp83867: Set up RGMII TX delay

Maxim Mikityanskiy (1):
      Validate required parameters in inet6_validate_link_af

Maxime Chevallier (3):
      net: mvpp2: cls: Fix leaked ethtool_rx_flow_rule
      net: ethtool: Document get_rxfh_context and set_rxfh_context ethtool =
ops
      ethtool: Check for vlan etype or vlan tci when parsing flow_rule

Maximilian Luz (1):
      USB: Add LPM quirk for Surface Dock GigE adapter

Michael Chan (3):
      bnxt_en: Fix aggregation buffer leak under OOM condition.
      bnxt_en: Fix possible BUG() condition when calling pci_disable_msix()=
.
      bnxt_en: Reduce memory usage when running in kdump kernel.

Michal Koutn=C3=BD (2):
      prctl_set_mm: refactor checks from validate_prctl_map
      prctl_set_mm: downgrade mmap_sem to read lock

Mike Rapoport (1):
      mm/gup: continue VM_FAULT_RETRY processing even for pre-faults

Ming Lei (2):
      block: move blk_exit_queue into __blk_release_queue
      block: don't protect generic_make_request_checks with blk_queue_enter

Murphy Zhou (1):
      fs/cifs/smb2pdu.c: fix buffer free in SMB2_ioctl_free

Namhyung Kim (2):
      perf namespace: Protect reading thread's namespace
      perf session: Add missing swap ops for namespace events

Nathan Chancellor (1):
      kasan: initialize tag to 0xff in __kasan_kmalloc

Nikita Danilov (1):
      net: aquantia: tcp checksum 0xffff being handled incorrectly

Nikolay Borisov (1):
      btrfs: Ensure replaced device doesn't have pending chunk allocation

Oliver Neukum (5):
      USB: sisusbvga: fix oops in error path of sisusb_probe
      USB: rio500: refuse more than one device at a time
      USB: rio500: fix memory leak in close after disconnect
      USB: rio500: simplify locking
      USB: rio500: update Documentation

Parav Pandit (3):
      net/mlx5: Avoid double free of root ns in the error flow path
      net/mlx5: Avoid double free in fs init error unwinding path
      net/mlx5: Allocate root ns memory using kzalloc to match kfree

Paul Mackerras (5):
      KVM: PPC: Book3S HV: Avoid touching arch.mmu_ready in XIVE
release functions
      KVM: PPC: Book3S HV: Use new mutex to synchronize MMU setup
      KVM: PPC: Book3S: Use new mutex to synchronize access to rtas token l=
ist
      KVM: PPC: Book3S HV: Don't take kvm->lock around kvm_for_each_vcpu
      KVM: PPC: Book3S HV: Fix lockdep warning when entering guest on POWER=
9

Paul Walmsley (1):
      clk: sifive: restrict Kconfig scope for the FU540 PRCI driver

Pavel Begunkov (1):
      io_uring: Fix __io_uring_register() false success

Pavel Machek (1):
      leds: avoid flush_work in atomic context

Peng Fan (1):
      clk: imx: imx8mm: fix int pll clk gate

Peter Zijlstra (3):
      perf/ring_buffer: Add ordering to rb->nest increment
      perf/ring-buffer: Always use {READ,WRITE}_ONCE() for rb->user_page da=
ta
      perf/ring-buffer: Use regular variables for nesting

Petr Vorel (1):
      ima: fix wrong signed policy requirement when not appraising

Phil Sutter (1):
      netfilter: nft_fib: Fix existence check support

Philipp Zabel (1):
      drm/imx: ipuv3-plane: fix atomic update status query for non-plus i.M=
X6Q

Qian Cai (1):
      drivers/iommu/intel-iommu.c: fix variable 'iommu' set but not used

Qu Wenruo (2):
      btrfs: reloc: Also queue orphan reloc tree for cleanup to avoid BUG_O=
N()
      btrfs: qgroup: Check bg while resuming relocation to avoid NULL
pointer dereference

Rafael J. Wysocki (3):
      ACPI/PCI: PM: Add missing wakeup.flags.valid checks
      ACPI: PM: Call pm_set_suspend_via_firmware() during hibernation
      PCI: PM: Avoid possible suspend-to-idle issue

Raju Rangoju (1):
      cxgb4: offload VLAN flows regardless of VLAN ethtype

Randy Dunlap (4):
      gpio: fix gpio-adp5588 build errors
      ia64: fix build errors by exporting paddr_to_nid()
      mm: fix Documentation/vm/hmm.rst Sphinx warnings
      lib/sort.c: fix kernel-doc notation warnings

Rasmus Villemoes (1):
      net: dsa: mv88e6xxx: fix handling of upper half of STATS_TYPE_PORT

Ravi Bangoria (1):
      powerpc/perf: Fix MMCRA corruption by bhrb_filter

Rob Bradford (1):
      efi: Allow the number of EFI configuration tables entries to be zero

Roberto Bergantinos Corpas (1):
      CIFS: cifs_read_allocate_pages: don't iterate through whole page
array on ENOMEM

Roberto Sassu (2):
      evm: check hash algorithm passed to init_desc()
      ima: show rules with IMA_INMASK correctly

Ross Lagerwall (1):
      xenbus: Avoid deadlock during suspend due to open transactions

Ruslan Babayev (1):
      iio: dac: ds4422/ds4424 fix chip verification

Russell King (2):
      net: phylink: ensure consistent phy interface mode
      net: phy: marvell10g: report if the PHY fails to boot firmware

Saeed Mahameed (2):
      net/mlx5: Fix error handling in mlx5_load()
      net/mlx5e: Disable rxhash when CQE compress is enabled

Sahitya Tummala (1):
      configfs: Fix use-after-free when accessing sd->s_dentry

Sami Tolvanen (3):
      arm64: fix syscall_fn_t type
      arm64: use the correct function type in SYSCALL_DEFINE0
      arm64: use the correct function type for __arm64_sys_ni_syscall

Sascha Hauer (1):
      serial: imx: remove log spamming error message

Scott Wood (1):
      x86/ima: Check EFI_RUNTIME_SERVICES before using

Sean Nyekjaer (1):
      iio: adc: ti-ads8688: fix timestamp is not updated in buffer

Sean Tranchetti (1):
      udp: Avoid post-GRO UDP checksum recalculation

Sebastian Andrzej Siewior (1):
      arch/arm/boot/compressed/decompress.c: fix build error due to lz4 cha=
nges

Sebastian Ott (2):
      s390/pci: fix struct definition for set PCI function
      s390/pci: fix assignment of bus resources

Shawn Landden (1):
      perf data: Fix 'strncat may truncate' build failure with recent gcc

Shuah Khan (2):
      usbip: usbip_host: fix BUG: sleeping function called from invalid con=
text
      usbip: usbip_host: fix stub_dev lock context imbalance regression

Stefano Brivio (1):
      selftests: pmtu: Fix encapsulating device in pmtu_vti6_link_change_mt=
u

Steffen Maier (2):
      scsi: zfcp: fix missing zfcp_port reference put on -EBUSY from port_r=
emove
      scsi: zfcp: fix to prevent port_remove with pure auto scan LUNs
(only sdevs)

Stephane Eranian (1):
      perf/x86/intel/ds: Fix EVENT vs. UEVENT PEBS constraints

Stephen Hemminger (2):
      netvsc: unshare skb in VF rx handler
      net: core: support XDP generic on stacked devices.

Steve Moskovchenko (1):
      iio: imu: mpu6050: Fix FIFO layout for ICM20602

Suraj Jitindar Singh (1):
      KVM: PPC: Book3S HV: Restore SPRG3 in kvmhv_p9_guest_entry()

Suzuki K Poulose (1):
      mm, compaction: make sure we isolate a valid PFN

Takashi Iwai (1):
      ALSA: line6: Assure canceling delayed work at disconnection

Thiago Jung Bauermann (1):
      powerpc/kexec: Fix loading of kernel + initramfs with kexec_file_load=
()

Thierry Reding (1):
      net: stmmac: Do not output error on deferred probe

Thomas Gleixner (81):
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 126
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 127
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 128
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 129
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 130
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 131
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 132
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 133
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 135
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 136
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 137
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 138
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 139
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 140
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 142
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 143
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 144
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 145
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 147
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 148
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 149
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 150
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 151
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 152
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 153
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 154
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 155
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 156
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 157
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 158
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 159
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 160
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 161
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 162
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 164
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 165
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 166
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 167
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 170
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 171
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 172
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 173
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 174
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 175
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 176
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 177
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 178
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 179
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 180
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 182
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 183
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 185
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 188
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 190
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 191
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 193
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 194
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 195
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 197
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 198
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 199
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 200
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 201
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 203
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 206
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 207
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 209
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 210
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 211
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 213
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 214
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 215
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 216
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 217
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 218
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 220
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 221
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 222
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 223
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 224
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 225

Thomas Huth (1):
      KVM: s390: Do not report unusabled IDs via KVM_CAP_MAX_VCPU_ID

Thomas Richter (1):
      perf record: Fix s390 missing module symbol and warning for non-root =
users

Tim Collier (1):
      staging: wlan-ng: fix adapter initialization failure

Tobin C. Harding (1):
      ocfs2: fix error path kobject memory leak

Tomas Bortoli (1):
      tracing: Avoid memory leak in predicate_parse()

Tomer Maimon (1):
      iio: adc: modify NPCM ADC read reference voltage

Tony Lindgren (1):
      clk: ti: clkctrl: Fix clkdm_clk handling

Vadim Pasternak (1):
      i2c: mlxcpld: Fix wrong initialization order in probe

Varun Prakash (1):
      scsi: libcxgbi: add a check for NULL pointer in cxgbi_check_route()

Vasundhara Volam (1):
      bnxt_en: Device serial number is supported only for PFs.

Vincent Stehl=C3=A9 (1):
      iio: adc: ads124: avoid buffer overflow

Vincenzo Frascino (1):
      spdxcheck.py: fix directory structures

Vishal Kulkarni (1):
      cxgb4: Revert "cxgb4: Remove SGE_HOST_PAGE_SIZE dependency on page si=
ze"

Vitaly Chikunov (1):
      perf arm64: Fix mksyscalltbl when system kernel headers are
ahead of the kernel

Vitaly Wool (1):
      z3fold: fix sheduling while atomic

Vlad Buslov (1):
      net: sched: don't use tc_action->order during action dump

Vladimir Oltean (1):
      net: dsa: tag_8021q: Create a stable binary format

Willem de Bruijn (1):
      net: correct zerocopy refcnt with udp MSG_MORE

Wolfram Sang (2):
      MAINTAINERS: add DT bindings to i2c drivers
      MAINTAINERS: add I2C DT bindings to ARM platforms

Yabin Cui (1):
      perf/ring_buffer: Fix exposing a temporarily decreased data_head

Yingjoe Chen (1):
      i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr

Yoshihiro Shimoda (1):
      net: sh_eth: fix mdio access in sh_eth_close() for R-Car Gen2
and RZ/A1 SoCs

Young Xiao (1):
      ipv4: tcp_input: fix stack out of bounds when parsing TCP options.

YueHaibing (4):
      staging: kpc2000: Fix build error without CONFIG_UIO
      ipvs: Fix use-after-free in ip_vs_in
      xen/pvcalls: Remove set but not used variable
      scsi: scsi_dh_alua: Fix possible null-ptr-deref

Zhenliang Wei (1):
      kernel/signal.c: trace_signal_deliver when signal_group_exit

wenxu (1):
      net/mlx5e: restrict the real_dev of vlan device is the same as
uplink device
