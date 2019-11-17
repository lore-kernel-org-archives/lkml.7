Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6558C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA9E2071E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574033319;
	bh=ruk5umjWTAhfHtcFPXGWHbAM2NAve7DAXeWTRjSiYRY=;
	h=From:Date:Subject:To:List-ID:From;
	b=L12pVXGBNxPF/nE7uieViouAkkNRmPB4sf0GLGRoK1UUPezeFJ5+SOTC73Ws3x3LW
	 6xcvuNNq6wE2rF1RoSEHZZ9Tc2i16MjQIUt6Qdw/oBxf6sctZ+Z/sngMlW+d7yPztL
	 ey+S16lytGuqNGzmMVKWieUcXQGJgDxA48wV+5mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfKQX2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 18:28:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40349 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfKQX2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 18:28:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so16722916ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 15:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=tyf24f2zrcL1EEhUP6e3qc4e1nn68Cb7BHg/S1ou3TE=;
        b=Y0E04/BwuVq0AwvnvjFj503fQZIVWz3Dk8RJ5wbsU8YewZMkz0YXjSEhzyaPf7DefS
         59G9WELr8jGLvyauHE7LnvAp+g3bBQ9LQRIfT/9ABCi7b61AMzNOg1fQHtDm+2N5b4UG
         6ZUYUfJ8wKn4zgdFrfpCKeWWCiykLxYedRb78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tyf24f2zrcL1EEhUP6e3qc4e1nn68Cb7BHg/S1ou3TE=;
        b=NKsoaV6Zc/il8j6KwwBn/ZJmQ6uE70U87it/1qUKqzA1W+AiH0/F+PtaSPq8nym4G4
         gB7ZAxvirQ7EIhzCiZ8laL0E9nvizPv/bLbk1Q4hIP8og0makgY6FVVqj4LxEK13YXYS
         TOaTXwNSeVjRSI+bfoYtCkdZcGfdeSeAbV/8VWZXKVCiBoDnCTih3zZP4y/3vcv7CYp8
         epPY+uYMX4uUoWlUSeNiS8TRk4znRrI8UYhqHBjGT6+cSuP2LwQ+tDP39FZmVoR0YWGz
         wRkOO+cCWvhpCc1JLIv9nY4YEkf60UYGQB5+DfpyaWGjqvRi8MG5Yhbj4j2GzW6PKpK4
         5c/Q==
X-Gm-Message-State: APjAAAWuB0xSPOAvLGOmXY0eTzEoYaPzsJ6uruJmYodB0exQZXiOJYt+
        C3PDJxYClSiHfmb/nZZzud41ZZbmGAU=
X-Google-Smtp-Source: APXvYqyfc2xzP7Cm5YhACr2W6O0Z5VDEkxtLZNR9dxLc3zX7RPVgODQC+imGIkCmsPdpuHxJx9uUhw==
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr19211919ljk.203.1574033314256;
        Sun, 17 Nov 2019 15:28:34 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id s23sm7672414ljm.20.2019.11.17.15.28.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 15:28:33 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id z188so12208093lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 15:28:33 -0800 (PST)
X-Received: by 2002:ac2:558e:: with SMTP id v14mr3807986lfg.79.1574033312632;
 Sun, 17 Nov 2019 15:28:32 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Nov 2019 15:28:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyR4Np_n5O6=rbf1GVNdr_zUd1WAC_GJDnc_hUhHqwWg@mail.gmail.com>
Message-ID: <CAHk-=wiyR4Np_n5O6=rbf1GVNdr_zUd1WAC_GJDnc_hUhHqwWg@mail.gmail.com>
Subject: Linux 5.4-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not entirely sure we need an rc8, because last week was pretty
calm despite the Intel hw workarounds landing. So I considered just
making a final 5.4 and be done with it, but decided that there's no
real downside to just doing the rc8 after having a release cycle that
took a while to calm down.

But it *has* calmed down, and I expect the upcoming week to be quiet
too (knock wood).

In fact, considering that the week after that is Thanksgiving week in
the US, I'm hoping that most of the pull requests I get next week
aren't fixes for 5.4, but people sending me early pull requests for
when the merge window for 5.5 opens. That way those proactive
developers can then sit back and relax during that turkey-filled
feast...

Anyway, looking at the rc8 diffs, the bulk of it is for the intel hw
issues, both on the CPU side (TSX Async Abort, and the iTLB multihit
thing), and on the GPU side (GPU hang and invalid accesses). None of
the patches are big, and honestly, shouldn't affect anybody.

The other noticeable thing in the diffs is the removal of the vboxsf
filesystem. It will get resubmitted properly later, there was nothing
obviously wrong with it technically, it just ended up in the wrong
location and submitted at the wrong time. We'll get it done properly
probably during 5.5.

Outside of those two areas, there's some kvm fixes, and some minor
core networking, VM and VFS fixes. And various random small things.

Nothing really looks all that worrisome from a release standpoint, and
as mentioned I was toying with just skipping this rc entirely. But
better safe than sorry.

Please do go give the tires a final few kicks before the expected 5.4
release next weekend.

Thanks,

                Linus

---

Al Viro (7):
      autofs: fix a leak in autofs_expire_indirect()
      cgroup: don't put ERR_PTR() into fc->root
      exportfs_decode_fh(): negative pinned may become positive
without the parent locked
      audit_get_nd(): don't unlock parent too early
      ecryptfs: fix unlink and rmdir in face of underlying fs modifications
      ecryptfs_lookup_interpose(): lower_dentry->d_inode is not stable
      ecryptfs_lookup_interpose(): lower_dentry->d_parent is not stable either

Aleksander Morgado (1):
      net: usb: qmi_wwan: add support for Foxconn T77W968 LTE modules

Alexander Shishkin (4):
      perf/aux: Fix the aux_output group inheritance fix
      perf/core: Reattach a misplaced comment
      perf/aux: Disallow aux_output for kernel events
      perf/core: Consistently fail fork on allocation failures

Andrea Mayer (2):
      seg6: fix srh pointer in get_srh()
      seg6: fix skb transport_header after decap_and_validate()

Andrew Duggan (3):
      Input: synaptics-rmi4 - disable the relative position IRQ in the
F12 driver
      Input: synaptics-rmi4 - do not consume more data than we have (F11, F12)
      Input: synaptics-rmi4 - remove unused result_bits mask

Arnd Bergmann (1):
      ntp/y2038: Remove incorrect time_t truncation

Aya Levin (1):
      devlink: Add method for time-stamp on reporter's dump

Ben Dooks (Codethink) (1):
      perf/core: Fix missing static inline on perf_cgroup_switch()

Ben Hutchings (1):
      drm/i915/cmdparser: Fix jump whitelist clearing

Chenyi Qiang (1):
      KVM: X86: Fix initialization of MSR lists

Chiou, Cooper (1):
      ALSA: hda: Add Cometlake-S PCI ID

Chuhong Yuan (4):
      rsxx: add missed destroy_workqueue calls in remove
      Input: synaptics-rmi4 - destroy F54 poller workqueue when removing
      net: ep93xx_eth: fix mismatch of request_mem_region in remove
      net: gemini: add missed free_netdev

Corentin Labbe (1):
      net: ethernet: dwmac-sun8i: Use the correct function in exit path

Dag Moxnes (1):
      rds: ib: update WR sizes when bringing up connection

Damien Le Moal (1):
      scsi: sd_zbc: Fix sd_zbc_complete()

Dan Carpenter (1):
      net: cdc_ncm: Signedness bug in cdc_ncm_set_dgram_size()

David Hildenbrand (1):
      mm/memory_hotplug: fix try_offline_node()

David Howells (1):
      afs: Fix race in commit bulk status fetch

Eric Auger (1):
      iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and QI_DEV_EIOTLB_PFSID macros

Eric Biggers (1):
      fs/namespace.c: fix use-after-free of mount in mnt_warn_timestamp_expiry()

Eugen Hristev (1):
      mmc: sdhci-of-at91: fix quirk2 overwrite

Filipe Manana (1):
      Btrfs: fix log context list corruption after rename exchange operation

Florian Fainelli (1):
      MAINTAINERS: Remove Kevin as maintainer of BMIPS generic platforms

Gomez Iglesias, Antonio (1):
      Documentation: Add ITLB_MULTIHIT documentation

Guangbin Huang (1):
      net: hns3: add compatible handling for MAC VLAN switch parameter
configuration

Guillaume Nault (1):
      ipmr: Fix skb headroom in ipmr_get_route().

Guillem Jover (1):
      aio: Fix io_pgetevents() struct __compat_aio_sigset layout

Hans de Goede (1):
      i2c: acpi: Force bus speed to 400KHz if a Silead touchscreen is present

Henry Lin (1):
      ALSA: usb-audio: not submit urb for stopped endpoint

Herbert Xu (1):
      Revert "hwrng: core - Freeze khwrng thread during suspend"

Ido Schimmel (1):
      selftests: mlxsw: Adjust test to recent changes

Ilie Halip (1):
      scripts/tools-support-relr.sh: un-quote variables

Ilya Dryomov (1):
      rbd: silence bogus uninitialized warning in rbd_object_map_update_finish()

Imre Deak (1):
      drm/i915/gen8+: Add RC6 CTX corruption WA

Ioana Ciornei (1):
      dpaa2-eth: free already allocated channels on probe defer

Jacob Keller (6):
      net: reject PTP periodic output requests with unsupported flags
      mv88e6xxx: reject unsupported external timestamp flags
      dp83640: reject unsupported external timestamp flags
      igb: reject unsupported external timestamp flags
      mlx5: reject unsupported external timestamp flags
      renesas: reject unsupported external timestamp flags

James Erwin (1):
      IB/hfi1: Ensure full Gen3 speed in a Gen4 system

Jani Nikula (1):
      drm/i915: update rawclk also on resume

Jeff Layton (2):
      ceph: take the inode lock before acquiring cap refs
      ceph: increment/decrement dio counter on async requests

Jens Axboe (2):
      io_uring: make timeout sequence == 0 mean no sequence
      io_uring: ensure registered buffer import returns the IO length

Jiri Pirko (2):
      devlink: disallow reload operation during device cleanup
      mlxsw: core: Enable devlink reload only on probe

Jiufei Xue (1):
      iocost: check active_list of all the ancestors in iocg_activate()

Joao Martins (3):
      KVM: VMX: Consider PID.PIR to determine if vCPU has pending interrupts
      KVM: VMX: Do not change PID.NDST when loading a blocked vCPU
      KVM: VMX: Introduce pi_is_pir_empty() helper

Jon Bloomfield (10):
      drm/i915: Rename gen7 cmdparser tables
      drm/i915: Disable Secure Batches for gen6+
      drm/i915: Remove Master tables from cmdparser
      drm/i915: Add support for mandatory cmdparsing
      drm/i915: Support ro ppgtt mapped cmdparser shadow buffers
      drm/i915: Allow parsing of unsized batches
      drm/i915: Add gen9 BCS cmdparsing
      drm/i915/cmdparser: Use explicit goto for error paths
      drm/i915/cmdparser: Add support for backward jumps
      drm/i915/cmdparser: Ignore Length operands during command matching

Josh Poimboeuf (1):
      x86/speculation/taa: Fix printing of TAA_MSG_SMT on IBRS_ALL CPUs

Jouni Hogander (2):
      slip: Fix memory leak in slip_open error path
      slcan: Fix memory leak in error path

Junaid Shahid (2):
      kvm: Add helper function for creating VM worker threads
      kvm: x86: mmu: Recovery of shattered NX large pages

Junichi Nomura (1):
      block: check bi_size overflow before merge

Kai Vehmanen (1):
      ALSA: hda: hdmi - fix pin setup on Tigerlake

Kai-Heng Feng (1):
      x86/quirks: Disable HPET on Intel Coffe Lake platforms

Kaike Wan (3):
      IB/hfi1: Ensure r_tid_ack is valid before building TID RDMA ACK packet
      IB/hfi1: Calculate flow weight based on QP MTU for TID RDMA
      IB/hfi1: TID RDMA WRITE should not return IB_WC_RNR_RETRY_EXC_ERR

Lasse Collin (1):
      lib/xz: fix XZ_DYNALLOC to avoid useless memory reallocations

Laura Abbott (1):
      mm: slub: really fix slab walking for init_on_free

Linus Torvalds (2):
      Remove VirtualBox guest shared folders filesystem
      Linux 5.4-rc8

Liran Alon (1):
      KVM: VMX: Fix comment to specify PID.ON instead of PIR.ON

Lu Baolu (1):
      MAINTAINERS: Update for INTEL IOMMU (VT-d) entry

Luc Van Oostenryck (1):
      kbuild: tell sparse about the $ARCH

Lucas Stach (2):
      Input: synaptics-rmi4 - fix video buffer size
      Input: synaptics-rmi4 - clear IRQ enables for F54

Lyude Paul (1):
      Input: synaptics - enable RMI mode for X1 Extreme 2nd Generation

Marc Zyngier (2):
      KVM: Forbid /dev/kvm being opened by a compat task when
CONFIG_KVM_COMPAT=n
      KVM: Add a comment describing the /dev/kvm no_compat handling

Martin Wilck (1):
      scsi: qla2xxx: fix NPIV tear down process

Masahiro Yamada (1):
      sparc: vdso: fix build error of vdso32

Matt Bennett (1):
      tipc: add back tipc prefix to log messages

Matt Roper (2):
      Revert "drm/i915/ehl: Update MOCS table for EHL"
      drm/i915/tgl: MOCS table update

Michael Schmitz (1):
      scsi: core: Handle drivers which set sg_tablesize to zero

Michal Hocko (1):
      x86/tsx: Add config options to set tsx=on|off|auto

Mordechay Goodstein (1):
      iwlwifi: pcie: don't consider IV len in A-MSDU

Nishad Kamdar (2):
      octeontx2-af: Use the correct style for SPDX License Identifier
      net: stmmac: Use the correct style for SPDX License Identifier

Oleg Nesterov (1):
      cgroup: freezer: call cgroup_enter_frozen() with preemption
disabled in ptrace_stop()

Oleksij Rempel (9):
      can: af_can: export can_sock_destruct()
      can: j1939: move j1939_priv_put() into sk_destruct callback
      can: j1939: main: j1939_ndev_to_priv(): avoid crash if can_ml_priv is NULL
      can: j1939: socket: rework socket locking for j1939_sk_release()
and j1939_sk_sendmsg()
      can: j1939: transport: make sure the aborted session will be
deactivated only once
      can: j1939: make sure socket is held as long as session exists
      can: j1939: transport: j1939_cancel_active_session(): use
hrtimer_try_to_cancel() instead of hrtimer_cancel()
      can: j1939: j1939_can_recv(): add priv refcounting
      can: j1939: warn if resources are still linked on destroy

Oliver Neukum (2):
      Input: ff-memless - kill timer in destroy()
      ax88172a: fix information leak on short answers

Pan Bian (2):
      drm/i915/gvt: fix dropping obj reference twice
      Input: cyttsp4_core - fix use after free bug

Paolo Bonzini (4):
      kvm: mmu: ITLB_MULTIHIT mitigation
      KVM: Fix NULL-ptr deref after kvm_create_vm fails
      KVM: fix placement of refcount initialization
      kvm: x86: disable shattered huge page recovery for PREEMPT_RT.

Paolo Valente (1):
      block, bfq: deschedule empty bfq_queues not referred by any process

Pavel Begunkov (1):
      io_uring: Fix getting file for timeout

Pawan Gupta (9):
      x86/msr: Add the IA32_TSX_CTRL MSR
      x86/cpu: Add a helper function x86_read_arch_cap_msr()
      x86/cpu: Add a "tsx=" cmdline option with TSX disabled by default
      x86/speculation/taa: Add mitigation for TSX Async Abort
      x86/speculation/taa: Add sysfs reporting for TSX Async Abort
      kvm/x86: Export MDS_NO=0 to guests when TSX is enabled
      x86/tsx: Add "auto" option to the tsx= cmdline parameter
      x86/speculation/taa: Add documentation for TSX Async Abort
      x86/cpu: Add Tremont to the cpu vulnerability whitelist

Peter Zijlstra (2):
      sched/core: Avoid spurious lock dependencies
      perf/core: Disallow uncore-cgroup events

Qais Yousef (1):
      sched/uclamp: Fix incorrect condition

Ralph Campbell (2):
      mm/debug.c: __dump_page() prints an extra line
      mm/debug.c: PageAnon() is true for PageKsm() pages

Richard Cochran (7):
      ptp: Validate requests to enable time stamping of external signals.
      ptp: Introduce strict checking of external time stamp options.
      mv88e6xxx: Reject requests to enable time stamping on both edges.
      dp83640: Reject requests to enable time stamping on both edges.
      igb: Reject requests that fail to enable time stamping on both edges.
      mlx5: Reject requests to enable time stamping on both edges.
      ptp: Extend the test program to check the external time stamp flags.

Roman Gushchin (2):
      mm: memcg: switch to css_tryget() in get_mem_cgroup_from_mm()
      mm: hugetlb: switch to css_tryget() in hugetlb_cgroup_charge_cgroup()

Salil Mehta (1):
      net: hns3: cleanup of stray struct hns3_link_mode_mapping

Sean Christopherson (2):
      KVM: MMU: Do not treat ZONE_DEVICE pages as being reserved
      KVM: x86/mmu: Take slots_lock when using kvm_mmu_zap_all_fast()

Sirong Wang (1):
      RDMA/hns: Correct the value of HNS_ROCE_HEM_CHUNK_LEN

Song Liu (1):
      mm,thp: recheck each page before collapsing file THP

Steffen Klassert (1):
      xfrm: Fix memleak on xfrm state destroy

Stephan Gerhold (1):
      NFC: nxp-nci: Fix NULL pointer dereference after I2C communication error

Takashi Iwai (3):
      ALSA: usb-audio: Fix missing error check at mixer resolution test
      ALSA: usb-audio: Fix incorrect NULL check in create_yamaha_midi_quirk()
      ALSA: usb-audio: Fix incorrect size check for processing/extension units

Thomas Bogendoerfer (1):
      MIPS: SGI-IP27: fix exception handler replication

Tony Lu (1):
      tcp: remove redundant new line from tcp_event_sk_skb

Tyler Hicks (1):
      cpu/speculation: Uninline and export CPU mitigations helpers

Ulrich Hecht (1):
      ravb: implement MTU change while device is up

Uma Shankar (1):
      drm/i915: Lower RM timeout to avoid DSI hard hangs

Ursula Braun (2):
      net/smc: fix refcount non-blocking connect() -part 2
      net/smc: fix fastopen for non-blocking connect()

Vinayak Menon (1):
      mm/page_io.c: do not free shared swap slots

Vincent Guittot (1):
      sched/pelt: Fix update of blocked PELT ordering

Vineela Tummalapalli (1):
      x86/bugs: Add ITLB_MULTIHIT bug infrastructure

Vitaly Kuznetsov (1):
      selftests: kvm: fix build with glibc >= 2.30

Vladimir Oltean (1):
      net: dsa: tag_8021q: Fix dsa_8021q_restore_pvid for an absent pvid

Wen Yang (1):
      i2c: core: fix use after free in of_i2c_notify

Wenpeng Liang (1):
      RDMA/hns: Correct the value of srq_desc_size

Xiaochen Shen (1):
      x86/resctrl: Fix potential lockdep warning

Xiaodong Xu (1):
      xfrm: release device reference for invalid state

Xiaojie Yuan (1):
      drm/amdgpu: fix null pointer deref in firmware header printing

Xiaoyao Li (1):
      KVM: X86: Reset the three MSR list number variables to 0 in
kvm_init_msr_list()

Yang Shi (1):
      mm: mempolicy: fix the wrong return value and potential pages
leak of mbind

Yonglong Liu (1):
      net: hns3: fix ETS bandwidth validation bug

YueHaibing (1):
      mdio_bus: Fix PTR_ERR applied after initialization to constant

Yunhao Tian (1):
      drm/sun4i: tcon: Set min division of TCON0_DCLK to 1.

Yunsheng Lin (1):
      net: hns3: reallocate SSU' buffer size when pfc_en changes

paulhsia (1):
      ALSA: pcm: Fix stream lock usage in snd_pcm_period_elapsed()

zhong jiang (1):
      mm: fix trying to reclaim unevictable lru page when calling
madvise_pageout
