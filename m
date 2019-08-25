Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53241C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26CB2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566760233;
	bh=7q5NehUv3SiL11n8xXXqeqgXedEYQNP5rpoWapcZNus=;
	h=From:Date:Subject:To:List-ID:From;
	b=yCXWQS9KBNcEIcqfRoobtM76kbZTV3X2N3s3rzSfw4V/7CcjhZWyWRj8UEI8z0wxl
	 ZwueEYBbERp2brhCnueXjN4LWi79dX0k3c3EIyLAuM+sFNesAMqaP+mymQYsB5KM2V
	 taaTSfxOt/xxtFF1Ffc3GbsbHZ3b+9W0dGQ77yBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfHYTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:10:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34248 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfHYTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:10:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id z21so2150193lfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zsGsGUneooKDdUmPeifPiIBX//vOSOLn1roljEMox+4=;
        b=H7UJPiRzzGWMdnLTMAQptULLPASPaC/dt77aM6PtA2QoQ1riH/TWNynfBFLrDEoVCF
         kMpSrl6E/RSQLQYAuMQKkCNRcdvSZcIEqn153j9RK5KEIY6uPZFrIGKH9JzET30H5qNW
         eKbADIj8eTtDfmg13T/8bg939Ln5QHuOh3ISw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zsGsGUneooKDdUmPeifPiIBX//vOSOLn1roljEMox+4=;
        b=e9mpkarXekG/twvZKIlXt2B1x9mBWHFwIIkqD0Kuz0CxSp/hRHaTml3I1dbs+Qwyib
         kPYfpZJMTq6mBUdX9ZwgcYR9mX9YTbU6NQcFX/usc8ApBhmwRwWhLtmt9O3xyKPMTNby
         8/jgCmb/VKTnajzFc69iQrhONRhg8QbjDTQIVCAbwC5+Wd85oKG8B034g3UWqpZeGn0I
         P121xJJZPonmePc/K2NyNPnt840hB+b4cSdU9aWkY/P/ECSBKinwOAAv71dEGaSsH7eG
         z0zeKoQUxg2j70+FsVa6OtWCKLTRK/C5CIuyrV6UsCIoJfel5Q1geBz0fCbQLvgQEhfI
         IT1g==
X-Gm-Message-State: APjAAAVmI0UPuCpDXbXg7U1Uux9J7PyZ1XBTrNAfYIGyoPvXHHergCsf
        b65n054cX6vTrdsyTklN9jfqkTirn7o=
X-Google-Smtp-Source: APXvYqylWZewruzJzziX0KLB7FEMFrg/z1lj+DesQ6X7TifpRmbrO3vvcW4SyqMo3panguFDCHYp8Q==
X-Received: by 2002:ac2:4351:: with SMTP id o17mr8813145lfl.21.1566760227246;
        Sun, 25 Aug 2019 12:10:27 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x3sm328250lfe.48.2019.08.25.12.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 12:10:26 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id n19so10618846lfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:10:26 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr8561996lfb.29.1566760226055;
 Sun, 25 Aug 2019 12:10:26 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 12:10:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAKCTq+t5YnG6HzrF62=rr9H=q3LqokEP0_bQRHLwYNw@mail.gmail.com>
Message-ID: <CAHk-=wgAKCTq+t5YnG6HzrF62=rr9H=q3LqokEP0_bQRHLwYNw@mail.gmail.com>
Subject: Linux 5.3-rc6
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody out there using Linux -

I=E2=80=99m doing a (free) operating system (more than just a hobby) for 48=
6
AT clones and a lot of other hardware. This has been brewing for the
last 28 years, and is still not done. I=E2=80=99d like any feedback on any
bugs introduced this release (or older bugs too, for that matter).

                   Linus

PS. Yes, it's 28 years today since that original announcement
paraphrased above.  The shortlog below is obviously just for the last
week, though.

Nothing particularly surprising from the last week - most of the patch
is drivers, with networking and rdma being most noticeable, but
there's various other things in there too. I wish it was smaller than
it is, but it's not _huge_.

Bit if things don't calm down during the upcoming week, though, I may
have to do an rc8.

---

Aaron Armstrong Skomra (2):
      HID: wacom: add back changes dropped in merge commit
      HID: wacom: correct misreported EKR ring values

Adrian Hunter (1):
      scsi: ufs: Fix NULL pointer dereference in ufshcd_config_vreg_hpm()

Alex Deucher (2):
      drm/amdgpu/gfx9: update pg_flags after determining if gfx off is poss=
ible
      drm/amdgpu/powerplay: silence a warning in smu_v11_0_setup_pptable

Alexandre Courbot (2):
      drm/mediatek: use correct device to import PRIME buffers
      drm/mediatek: set DMA max segment size

Alexei Starovoitov (2):
      bpf: fix x64 JIT code generation for jmp to 1st insn
      selftests/bpf: tests for jmp to 1st insn

Anders Roxell (1):
      selftests: net: tcp_fastopen_backup_key.sh: fix shellcheck issue

Andre Przywara (1):
      KVM: arm/arm64: VGIC: Properly initialise private IRQ affinity

Andrea Righi (1):
      kprobes: Fix potential deadlock in kprobe_optimizer()

Andreas Kemnade (1):
      gpio: of: fix Freescale SPI CS quirk handling

Andrew Jones (1):
      KVM: arm/arm64: Only skip MMIO insn once

Andrey Ryabinin (1):
      mm/kasan: fix false positive invalid-free reports with
CONFIG_KASAN_SW_TAGS=3Dy

Andrii Nakryiko (2):
      libbpf: fix erroneous multi-closing of BTF FD
      libbpf: set BTF FD for prog only when there is supported .BTF.ext dat=
a

Andr=C3=A9 Draszik (1):
      net: phy: at803x: stop switching phy delay config needlessly

Anton Eidelman (1):
      nvme-multipath: fix possible I/O hang when paths are updated

Aya Levin (3):
      net/mlx5e: Fix false negative indication on tx reporter CQE recovery
      net/mlx5e: Fix error flow of CQE recovery on tx reporter
      net/mlx5e: Remove redundant check in CQE recovery flow of tx reporter

Balakrishna Godavarthi (1):
      Bluetooth: btqca: Reset download type to default

Bartosz Golaszewski (1):
      gpiolib: never report open-drain/source lines as 'input' to user-spac=
e

Benjamin Tissoires (3):
      Revert "HID: logitech-hidpp: add USB PID for a few more supported mic=
e"
      HID: logitech-hidpp: remove support for the G700 over USB
      HID: cp2112: prevent sleeping function called from invalid context

Bernard Metzler (3):
      RDMA/siw: Fix potential NULL de-ref
      RDMA/siw: Fix SGL mapping issues
      RDMA/siw: Fix 64/32bit pointer inconsistency

Bill Kuzeja (1):
      scsi: qla2xxx: Fix gnl.l memory leak on adapter init failure

Bjorn Helgaas (1):
      Documentation PCI: Fix pciebus-howto.rst filename typo

Bryan Gurney (1):
      dm dust: use dust block size for badblocklist index

Chen-Yu Tsai (1):
      net: dsa: Check existence of .port_mdb_add callback before calling it

Chris Packham (1):
      tipc: initialise addr_trail_end when setting node addresses

Christoph Hellwig (4):
      xfs: fall back to native ioctls for unhandled compat ones
      xfs: compat_ioctl: use compat_ptr()
      arm: select the dma-noncoherent symbols for all swiotlb builds
      dma-direct: fix zone selection after an unaddressable CMA allocation

Claire Chang (1):
      Bluetooth: btqca: release_firmware after qca_inject_cmd_complete_even=
t

Dan Carpenter (1):
      dm zoned: fix potential NULL dereference in dmz_do_reclaim()

Daniel Borkmann (2):
      sock: make cookie generation global instead of per netns
      bpf: sync bpf.h to tools infrastructure

Darrick J. Wong (3):
      vfs: fix page locking deadlocks when deduping files
      xfs: fix reflink source file racing with directio writes
      xfs: fix missing ILOCK unlock when xfs_setattr_nonsize fails due to E=
DQUOT

Dave Airlie (1):
      drm/mediatek: include dma-mapping header

David Ahern (2):
      netdevsim: Restore per-network namespace accounting for fib entries
      netlink: Fix nlmsg_parse as a wrapper for strict message parsing

David Howells (7):
      rxrpc: Fix local endpoint refcounting
      rxrpc: Don't bother generating maxSkew in the ACK packet
      rxrpc: Fix local refcounting
      rxrpc: Fix local endpoint replacement
      rxrpc: Fix read-after-free in rxrpc_queue_local()
      keys: Fix description size
      afs: Fix leak in afs_lookup_cell_rcu()

David Rientjes (1):
      mm, page_alloc: move_freepages should not examine struct page of
reserved memory

Denis Efremov (2):
      MAINTAINERS: PHY LIBRARY: Update files in the record
      MAINTAINERS: r8169: Update path to the driver

Dexuan Cui (4):
      hv_netvsc: Fix a warning of suspicious RCU usage
      Drivers: hv: vmbus: Remove the unused "tsc_page" from struct hv_conte=
xt
      Input: hyperv-keyboard: Use in-place iterator API in the channel call=
back
      Drivers: hv: vmbus: Fix virt_to_hvpfn() for X86_PAE

Dinh Nguyen (1):
      clk: socfpga: stratix10: fix rate caclulationg for cnt_clks

Dirk Morris (1):
      netfilter: conntrack: Use consistent ct id hash calculation

Dmitry Fomichev (7):
      scsi: target: tcmu: avoid use-after-free after command timeout
      dm kcopyd: always complete failed jobs
      dm zoned: improve error handling in reclaim
      dm zoned: improve error handling in i/o map code
      dm zoned: properly handle backing device failure
      dm zoned: add SPDX license identifiers
      dm zoned: fix a few typos

Eran Ben Elisha (1):
      net/mlx5e: Fix compatibility issue with ethtool flash device

Eric Dumazet (1):
      net/packet: fix race in tpacket_snd()

Eric W. Biederman (1):
      signal: Allow cifs and drbd to receive their terminating signals

Erqi Chen (1):
      ceph: clear page dirty before invalidate page

Even Xu (1):
      HID: intel-ish-hid: ipc: add EHL device id

Fabian Henneke (1):
      Bluetooth: hidp: Let hidp_send_message return number of queued bytes

Florian Westphal (2):
      selftests: netfilter: extend flowtable test script for ipsec
      netfilter: nf_flow_table: fix offload for flows that are subject to x=
frm

Fuqian Huang (1):
      net: tundra: tsi108: use spin_lock_irqsave instead of
spin_lock_irq in IRQ context

Guilherme G. Piccoli (1):
      nvme: Fix cntlid validation when not using NVMEoF

Guillaume Nault (1):
      inet: frags: re-introduce skb coalescing for local delivery

Gustavo A. R. Silva (10):
      dmaengine: fsldma: Mark expected switch fall-through
      ARM: riscpc: Mark expected switch fall-through
      drm/sun4i: sun6i_mipi_dsi: Mark expected switch fall-through
      drm/sun4i: tcon: Mark expected switch fall-through
      mtd: sa1100: Mark expected switch fall-through
      watchdog: wdt285: Mark expected switch fall-through
      power: supply: ab8500_charger: Mark expected switch fall-through
      MIPS: Octeon: Mark expected switch fall-through
      scsi: libsas: sas_discover: Mark expected switch fall-through
      video: fbdev: acornfb: Mark expected switch fall-through

Harish Bandi (1):
      Bluetooth: hci_qca: Send VS pre shutdown command.

He Zhe (2):
      nfsd4: Fix kernel crash when reading proc file reply_cache_stats
      modules: page-align module section allocations only for arches
supporting strict module rwx

Heiner Kallweit (1):
      net: phy: consider AN_RESTART status when reading link status

Henry Burns (3):
      mm/z3fold.c: fix race between migration and destruction
      mm/zsmalloc.c: migration can leave pages in ZS_EMPTY indefinitely
      mm/zsmalloc.c: fix race condition in zs_destroy_pool

Huy Nguyen (2):
      net/mlx5: Support inner header match criteria for non decap flow acti=
on
      net/mlx5e: Only support tx/rx pause setting for port owner

Hyungwoo Yang (1):
      platform/chrome: cros_ec_ishtp: fix crash during suspend

Ido Kalir (1):
      IB/core: Fix NULL pointer dereference when bind QP to counter

Ilya Dryomov (1):
      libceph: fix PG split vs OSD (re)connect race

Imre Deak (1):
      drm/i915: Fix HW readout for crtc_clock in HDMI mode

Ira Weiny (1):
      fs/xfs: Fix return code of xfs_break_leased_layouts()

Ivan Khoronzhuk (1):
      net: sched: sch_taprio: fix memleak in error path for sched list pars=
e

J. Bruce Fields (2):
      nfsd: use i_wrlock instead of rcu for nfsdfs i_private
      nfsd: initialize i_private before d_add

Jacopo Mondi (1):
      drm: rcar_lvds: Fix dual link mode operations

Jakub Kicinski (4):
      net/tls: prevent skb_orphan() from leaking TLS plain text with offloa=
d
      tools: bpftool: fix error message (prog -> object)
      tools: bpftool: add error message on pin failure
      net/tls: swap sk_write_space on close

James Smart (1):
      scsi: lpfc: Mitigate high memory pre-allocation by SCSI-MQ

Jason Gerecke (1):
      HID: wacom: Correct distance scale for 2nd-gen Intuos devices

Jason Gunthorpe (1):
      RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB

Jason Xing (1):
      psi: get poll_work to run when calling poll syscall next time

Jeff Layton (1):
      ceph: don't try fill file_lock on unsuccessful GETFILELOCK reply

Jens Axboe (3):
      io_uring: fix potential hang with polled IO
      io_uring: don't enter poll loop if we have CQEs pending
      io_uring: add need_resched() check in inner poll loop

Jessica Yu (1):
      modules: always page-align module section allocations

Johannes Berg (1):
      um: fix time travel mode

John Fastabend (1):
      net: tls, fix sk_write_space NULL write when tx disabled

John Hubbard (1):
      x86/boot: Fix boot regression caused by bootparam sanitizing

Jonathan Neusch=C3=A4fer (1):
      net: nps_enet: Fix function names in doc comments

Julian Wiedmann (1):
      s390/qeth: serialize cmd reply with concurrent timeout

Kaike Wan (5):
      IB/hfi1: Drop stale TID RDMA packets
      IB/hfi1: Unsafe PSN checking for TID RDMA READ Resp packet
      IB/hfi1: Add additional checks when handling TID RDMA READ RESP packe=
t
      IB/hfi1: Add additional checks when handling TID RDMA WRITE DATA pack=
et
      IB/hfi1: Drop stale TID RDMA packets that cause TIDErr

Kenneth Feng (1):
      drm/amd/amdgpu: disable MMHUB PG for navi10

Kevin Wang (2):
      drm/amd/powerplay: fix variable type errors in smu_v11_0_setup_pptabl=
e
      drm/amd/powerplay: remove duplicate macro
smu_get_uclk_dpm_states in amdgpu_smu.h

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Fix boot on machines with broken E820 table

Leon Romanovsky (2):
      RDMA/counters: Properly implement PID checks
      RDMA/restrack: Rewrite PID namespace check to be reliable

Linus Torvalds (1):
      Linux 5.3-rc6

Linus Walleij (1):
      gpio: Fix irqchip initialization order

Liu Song (1):
      ubifs: Limit the number of pages in shrink_liability

Lowry Li (Arm Technology China) (2):
      drm/komeda: Initialize and enable output polling on Komeda
      drm/komeda: Adds internal bpp computing for arm afbc only format YU08=
 YU10

Luis Henriques (4):
      libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
      ceph: fix buffer free while holding i_ceph_lock in __ceph_setxattr()
      ceph: fix buffer free while holding i_ceph_lock in
__ceph_build_xattrs_blob()
      ceph: fix buffer free while holding i_ceph_lock in fill_inode()

Lyude Paul (2):
      PCI: Reset both NVIDIA GPU and HDA in ThinkPad P50 workaround
      drm/nouveau: Don't retry infinitely when receiving no data on i2c ove=
r AUX

Manish Chopra (1):
      bnx2x: Fix VF's VLAN reconfiguration in reload.

Marc Dionne (1):
      afs: Fix possible oops in afs_lookup trace event

Marcel Holtmann (1):
      Bluetooth: Add debug setting for changing minimum encryption key size

Marek Szyprowski (1):
      clk: samsung: exynos542x: Move MSCL subsystem clocks to its sub-CMU

Mario Limonciello (1):
      nvme: Add quirk for LiteON CL1 devices running FW 22301111

Martin Blumenstingl (1):
      clk: Fix potential NULL dereference in clk_fetch_parent_index()

Masahiro Yamada (1):
      jffs2: Remove C++ style comments from uapi header

Matthias Kaehlcke (2):
      Bluetooth: btqca: Add a short delay before downloading the NVM
      Bluetooth: btqca: Use correct byte format for opcode of injected comm=
and

Maxim Mikityanskiy (2):
      net/mlx5e: Use flow keys dissector to parse packets for ARFS
      net/mlx5e: Fix a race with XSKICOSQ in XSK wakeup flow

Miaohe Lin (1):
      KVM: x86: svm: remove redundant assignment of var new_entry

Michael Chan (2):
      bnxt_en: Fix VNIC clearing logic for 57500 chips.
      bnxt_en: Improve RX doorbell sequence.

Michael Kelley (1):
      genirq: Properly pair kobject_del() with kobject_add()

Mihail Atanassov (1):
      drm/komeda: Add support for 'memory-region' DT node property

Mikulas Patocka (3):
      Revert "dm bufio: fix deadlock with loop device"
      dm integrity: fix a crash due to BUG_ON in __journal_read_write()
      dm table: fix invalid memory accesses with too high sector number

Mohamad Heib (1):
      net/mlx5e: ethtool, Avoid setting speed to 56GBASE when autoneg off

Moni Shoua (4):
      IB/mlx5: Consolidate use_umr checks into single function
      IB/mlx5: Report and handle ODP support properly
      IB/mlx5: Fix MR re-registration flow to use UMR properly
      IB/mlx5: Block MR WR if UMR is not possible

Nathan Chancellor (1):
      net: tc35815: Explicitly check NET_IP_ALIGN is not zero in tc35815_rx

Nicholas Kazlauskas (1):
      drm/amd/display: Calculate bpc based on max_requested_bpc

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: prevent memory leaks in AMDGPU_CS ioctl

Nishka Dasgupta (2):
      drm/mediatek: mtk_drm_drv.c: Add of_node_put() before goto
      auxdisplay: ht16k33: Make ht16k33_fb_fix and ht16k33_fb_var constant

Oleg Nesterov (1):
      userfaultfd_release: always remove uffd flags and clear vm_userfaultf=
d_ctx

Pablo Neira Ayuso (6):
      netfilter: nf_tables: use-after-free in failing rule with bound set
      netfilter: nf_flow_table: conntrack picks up expired flows
      netfilter: nf_flow_table: teardown flow timeout race
      netfilter: nft_flow_offload: skip tcp rst and fin packets
      net: sched: use major priority number as hardware priority
      netfilter: nf_tables: map basechain priority to hardware priority

Paolo Bonzini (7):
      MAINTAINERS: change list for KVM/s390
      MAINTAINERS: add KVM x86 reviewers
      selftests: kvm: do not try running the VM in vmx_set_nested_state_tes=
t
      selftests: kvm: provide common function to enable eVMCS
      selftests: kvm: fix vmx_set_nested_state_test
      selftests: kvm: fix state save/load on processors without XSAVE
      Revert "KVM: x86/mmu: Zap only the relevant pages when removing a mem=
slot"

Petr Machata (1):
      mlxsw: spectrum_ptp: Keep unmatched entries in a linked list

Qian Cai (1):
      parisc: fix compilation errrors

Radim Krcmar (1):
      kvm: x86: skip populating logical dest map if apic is not sw enabled

Richard Weinberger (2):
      ubifs: Fix double unlock around orphan_delete()
      ubifs: Correctly initialize c->min_log_bytes

Rocky Liao (1):
      Bluetooth: hci_qca: Skip 1 error print in device_want_to_sleep()

Roman Gushchin (2):
      mm: memcontrol: flush percpu vmstats before releasing memcg
      mm: memcontrol: flush percpu vmevents before releasing memcg

Roman Mashak (2):
      net sched: update skbedit action for batched events operations
      tc-testing: updated skbedit action tests with batch create/delete

Ross Lagerwall (1):
      xen/netback: Reset nr_frags before freeing skb

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during CALL_NOSPEC on i386

Sebastian Andrzej Siewior (1):
      sched/core: Schedule new worker even if PI-blocked

Selvin Xavier (1):
      RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message

Somnath Kotur (1):
      bnxt_en: Fix to include flow direction in L2 key

Song Liu (1):
      md: update MAINTAINERS info

Stephen Boyd (1):
      clk: Fix falling back to legacy parent string matching

Stephen Hemminger (3):
      docs: admin-guide: remove references to IPX and token-ring
      net: docs: replace IPX in tuntap documentation
      net: cavium: fix driver name

Su Yanjun (1):
      perf/x86: Fix typo in comment

Sven Eckelmann (2):
      batman-adv: Fix netlink dumping of all mcast_flags buckets
      batman-adv: Fix deletion of RTR(4|6) mcast list entries

Sylwester Nawrocki (2):
      clk: samsung: Change signature of exynos5_subcmus_init() function
      clk: samsung: exynos5800: Move MAU subsystem clocks to MAU sub-CMU

Taehee Yoo (1):
      ixgbe: fix possible deadlock in ixgbe_service_task()

Takshak Chahande (1):
      libbpf : make libbpf_num_possible_cpus function thread safe

Tariq Toukan (5):
      net/mlx5: crypto, Fix wrong offset in encryption key command
      net/mlx5: kTLS, Fix wrong TIS opmod constants
      net/mlx5e: kTLS, Fix progress params context WQE layout
      net/mlx5e: kTLS, Fix tisn field name
      net/mlx5e: kTLS, Fix tisn field placement

Tetsuo Handa (1):
      nfsd: fix dentry leak upon mkdir failure.

Tho Vu (1):
      ravb: Fix use-after-free ravb_tstamp_skb

Thomas Falcon (2):
      ibmveth: Convert multicast list size for little-endian system
      ibmvnic: Unmap DMA address of TX descriptor buffers after use

Thomas Gleixner (2):
      x86/apic: Handle missing global clockevent gracefully
      timekeeping/vsyscall: Prevent math overflow in BOOTTIME update

Tom Lendacky (1):
      x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h

Tomi Valkeinen (1):
      drm/omap: ensure we have a valid dma_mask

Tony Luck (1):
      x86/cpu: Explain Intel model naming convention

Tuong Lien (1):
      tipc: fix false detection of retransmit failures

Vasundhara Volam (2):
      bnxt_en: Fix handling FRAG_ERR when NVM_INSTALL_UPDATE cmd fails
      bnxt_en: Suppress HWRM errors for HWRM_NVM_GET_VARIABLE command

Venkat Duvvuru (1):
      bnxt_en: Use correct src_fid to determine direction of the flow

Vitaly Kuznetsov (2):
      Tools: hv: kvp: eliminate 'may be used uninitialized' warning
      selftests/kvm: make platform_info_test pass on AMD

Vlastimil Babka (1):
      mm, page_owner: handle THP splits correctly

Wei Yongjun (2):
      Bluetooth: btusb: Fix error return code in btusb_mtk_setup_firmware()
      Bluetooth: hci_qca: Use kfree_skb() instead of kfree()

Wenwen Wang (12):
      net/mlx4_en: fix a memory leak bug
      cxgb4: fix a memory leak bug
      liquidio: add cleanup in octeon_setup_iq()
      net: myri10ge: fix memory leaks
      lan78xx: Fix memory leaks
      cx82310_eth: fix a memory leak bug
      net: kalmia: fix memory leaks
      wimax/i2400m: fix a memory leak bug
      IB/mlx4: Fix memory leaks
      infiniband: hfi1: fix a memory leak bug
      infiniband: hfi1: fix memory leaks
      dm raid: add missing cleanup in raid_ctr()

Xin Long (1):
      sctp: fix the transport error_count check

YueHaibing (5):
      bonding: Add vlan tx offload to hw_enc_features
      net: dsa: sja1105: remove set but not used variables 'tx_vid' and 'rx=
_vid'
      team: Add vlan tx offload to hw_enc_features
      gpio: Fix build error of function redefinition
      afs: use correct afs_call_type in yfs_fs_store_opaque_acl2

ZhangXiaoxu (2):
      dm btree: fix order of block initialization in btree_split_beneath
      dm space map metadata: fix missing store of apply_bops() return value

zhengbin (2):
      sctp: fix memleak in sctp_send_reset_streams
      RDMA/cma: fix null-ptr-deref Read in cma_cleanup
