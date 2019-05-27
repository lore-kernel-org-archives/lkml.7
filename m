Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF76C282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D81721707
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 00:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558915908;
	bh=vEIo8newsStsYDnMt+b0mp51amF5ab/mUmDHt6dC8qs=;
	h=From:Date:Subject:To:List-ID:From;
	b=tdJevSPLOJ6i1hFHrjYh7Bh5BGd70Bbbu99kUvwZU9q34WJ7wm1bk+XnD9nN87ZHw
	 NI7dFNX5GH07hcQjMnl2LPZ7DRVsIGH4nHdpEfmUDIwELtr8RaWIMG/FUl6hdG5JuU
	 sT9Iei51g+3xqOXWoigw6BCf3KBkA4dWVROVUme8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfE0ALr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 20:11:47 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36718 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfE0ALq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 20:11:46 -0400
Received: by mail-lj1-f182.google.com with SMTP id z1so7632453ljb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 17:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9RBuLVNKvA7uuzdF0T2wbdaC9l0mimEdTOteyx0UJJI=;
        b=UHh0GjzAlDM4SWxn+RcdAvKWueZ1Xe9jpVUZj6phVlmUrNFewUxEnFFPax0LkW2ATY
         /yCTpwwztQcDdFKY+oLm8tbxarkFh6MKiedhHZCj16RnZcXc36+p8NFNV/UgCAZj6mTv
         h/NMyfJCikWsoH9RcKqLcnNdjtvbfP/FFZnNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9RBuLVNKvA7uuzdF0T2wbdaC9l0mimEdTOteyx0UJJI=;
        b=qH+HoDhVLnHId6LimdnDPvj8BtFTMoIeHsPAH3ACMTxHoycC2/kj1tzy+90z+CXm0x
         6CuMv4FO59f3fU7QZcRgXRbTQkR1nYDAzzvdl/a2rkfdLeEb589GrdGmYR6TcDTmudbo
         oKmwAuFOCK+vX2tDA/bnFYGeeEczCLBL9fa7BnK6HXbQa78X5KO1qyhxNnaSVYQLwx+S
         TJUSQkq445RNECK0Q4Bhu0wNYA7XQyse2cUwXMKnKCx+qUW49cvwLyO2fbOiduOCBemO
         itjRhOhbczuW8sd68DANJzmxIb9gbmZWBfUUn+kcWgc3EkZCH5gFB5ZInJXHbczxnINH
         HxEA==
X-Gm-Message-State: APjAAAXfqEzMusll1epOUDpE0trr9Qj3Rs56KPhZJQI/0ZelxxrO9vFO
        fY3+2GH6hKT24QRjU9IaPSJ3v59KXUY=
X-Google-Smtp-Source: APXvYqw4TLoZq/5x+ebHflMzG9mISIHg0DDTeEgLbUGOFEzcvKWU2l/LDCEkgi6dxTf/jn1lIhNQKw==
X-Received: by 2002:a2e:900e:: with SMTP id h14mr39519629ljg.77.1558915902718;
        Sun, 26 May 2019 17:11:42 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u11sm1946186lfb.60.2019.05.26.17.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 17:11:41 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z1so7632418ljb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 17:11:41 -0700 (PDT)
X-Received: by 2002:a2e:6109:: with SMTP id v9mr6911500ljb.205.1558915901205;
 Sun, 26 May 2019 17:11:41 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 May 2019 17:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgob1t2g9iQZCuZ8My39CY26xGb6nqjVhCtb1nTirsR2Q@mail.gmail.com>
Message-ID: <CAHk-=wgob1t2g9iQZCuZ8My39CY26xGb6nqjVhCtb1nTirsR2Q@mail.gmail.com>
Subject: Linux 5.2-rc2
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, what's to say? Fairly normal rc2, no real highlights - I think
most of the diff is the SPDX updates.

Who am I kidding? The highlight of the week was clearly Finland
winning the ice hockey world championships.

So once you sober up from the celebration, go test,

                 Linus

---

Alex Deucher (2):
      drm/amdgpu/soc15: skip reset on init
      drm/amdgpu/gmc9: set vram_width properly for SR-IOV

Alexei Starovoitov (1):
      selftests/bpf: fix bpf_get_current_task

Andrea Parri (2):
      bio: fix improper use of smp_mb__before_atomic()
      sbitmap: fix improper use of smp_mb__before_atomic()

Andreas Gruenbacher (1):
      gfs2: Fix sign extension bug in gfs2_update_stats

Andrew Jones (3):
      kvm: selftests: aarch64: dirty_log_test: fix unaligned memslot size
      kvm: selftests: aarch64: fix default vm mode
      kvm: selftests: aarch64: compile with warnings on

Andrii Nakryiko (2):
      libbpf: move logging helpers into libbpf_internal.h
      bpftool: fix BTF raw dump of FWD's fwd_kind

Ard Biesheuvel (2):
      arm64/kernel: kaslr: reduce module randomization range to 2 GB
      arm64/module: deal with ambiguity in PRELxx relocation ranges

Bernd Eckstein (1):
      usbnet: ipheth: fix racing condition

Bjorn Andersson (1):
      net: qrtr: Fix message type of outgoing packets

Bob Liu (1):
      blk-mq: fix hang caused by freeze/unfreeze sequence

Bodong Wang (1):
      net/mlx5: Fix peer pf disable hca command

Borislav Petkov (1):
      x86/kvm/pmu: Set AMD's virt PMU version to 1

Cengiz Can (1):
      Documentation: kdump: fix minor typo

Chenbo Feng (1):
      bpf: relax inode permission check for retrieving bpf program

Chris Packham (1):
      tipc: Avoid copying bytes beyond the supplied data

Chris Wilson (5):
      drm/i915: Rearrange i915_scheduler.c
      drm/i915: Pass i915_sched_node around internally
      drm/i915: Bump signaler priority on adding a waiter
      drm/i915: Downgrade NEWCLIENT to non-preemptive
      drm/i915: Truly bump ready tasks ahead of busywaits

Christian Borntraeger (2):
      KVM: s390: change default halt poll time to 50us
      KVM: s390: fix memory slot handling for KVM_SET_USER_MEMORY_REGION

Christoffer Dall (1):
      MAINTAINERS: KVM: arm/arm64: Remove myself as maintainer

Christoph Hellwig (9):
      arm64/iommu: handle non-remapped addresses in ->mmap and ->get_sgtabl=
e
      nvme: fix srcu locking on error return in nvme_get_ns_from_disk
      nvme: remove the ifdef around nvme_nvm_ioctl
      nvme: merge nvme_ns_ioctl into nvme_ioctl
      nvme: release namespace SRCU protection before performing
controller ioctls
      block: don't decrement nr_phys_segments for physically contigous segm=
ents
      block: force an unlimited segment size on queues with a virt boundary
      block: remove the segment size check in bio_will_gap
      block: remove the bi_seg_{front,back}_size fields in struct bio

Claudiu Manoil (3):
      enetc: Fix NULL dma address unmap for Tx BD extensions
      enetc: Allow to disable Tx SG
      enetc: Add missing link state info for ethtool

Colin Ian King (1):
      scsi: bnx2fc: fix incorrect cast to u64 on shift operation

Dan Carpenter (3):
      drm/amd/powerplay: fix locking in smu_feature_set_supported()
      drm/i915/gvt: Fix an error code in ppgtt_populate_spt_by_guest_entry(=
)
      KVM: selftests: Fix a condition in test_hv_cpuid()

Dan Williams (2):
      dax: Arrange for dax_supported check to span multiple devices
      libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead

Daniel Axtens (2):
      crypto: vmx - CTR: always increment IV as quadword
      crypto: vmx - ghash: do nosimd fallback manually

Daniel Borkmann (3):
      bpf: add map_lookup_elem_sys_only for lookups from syscall side
      bpf, lru: avoid messing with eviction heuristics upon syscall lookup
      bpf: test ref bit from data path and add new tests for syscall path

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit 0x1260 and 0x1261 compositions

Darrick J. Wong (1):
      xfs: don't reserve per-AG space for an internal log

Dave Airlie (1):
      Revert "drm/amd/display: Don't load DMCU for Raven 1"

David Ahern (1):
      selftests: pmtu.sh: Remove quotes around commands in setup_xfrm

David S. Miller (1):
      Revert "tipc: fix modprobe tipc failed after switch order of
device registration"

Dmytro Linkin (2):
      net/mlx5e: Add missing ethtool driver info for representors
      net/mlx5e: Additional check for flow destination comparison

Ed Cashin (1):
      aoe: list new maintainer for aoe driver

Edward Cree (1):
      flow_offload: support CVLAN match

Eli Britstein (3):
      net/mlx5e: Fix number of vports for ingress ACL configuration
      net/mlx5e: Fix no rewrite fields with the same match
      net/mlx5e: Fix possible modify header actions memory leak

Erez Alfasi (1):
      net/mlx4_en: ethtool, Remove unsupported SFP EEPROM high pages query

Eric Biggers (1):
      crypto: hash - fix incorrect HASH_MAX_DESCSIZE

Eric Dumazet (4):
      bpf: devmap: fix use-after-free Read in __dev_map_entry_free
      tcp: do not recycle cloned skbs
      ipv6: prevent possible fib6 leaks
      net: avoid weird emergency message

Erwan Velu (1):
      scsi: smartpqi: Reporting unhandled SCSI errors

Ezequiel Garcia (1):
      drm/panfrost: Select devfreq

Filipe Manana (4):
      Btrfs: do not abort transaction at btrfs_update_root() after
failure to COW path
      Btrfs: avoid fallback to transaction commit during fsync of
files with holes
      Btrfs: fix race between ranged fsync and writeback of adjacent ranges
      Btrfs: tree-checker: detect file extent items with overlapping ranges

Flora Cui (1):
      drm/amdgpu: keep stolen memory on picasso

Florian Fainelli (1):
      net: Always descend into dsa/

Florian Westphal (2):
      xfrm: ressurrect "Fix uninitialized memory read in _decode_session4"
      kselftests: netfilter: fix leftover net/net-next merge conflict

Fuqian Huang (1):
      atm: iphase: Avoid copying pointers to user space.

Gabriel Krisman Bertazi (1):
      ext4: fix dcache lookup of !casefolded directories

Gary Lin (2):
      bpf: btf: fix the brackets of BTF_INT_OFFSET()
      tools/bpf: Sync kernel btf.h header

Gustavo A. R. Silva (2):
      macvlan: Mark expected switch fall-through
      vlan: Mark expected switch fall-through

Hangbin Liu (3):
      selftests: fib_rule_tests: fix local IPv4 address typo
      selftests: fib_rule_tests: enable forwarding before ipv4 from/iif tes=
t
      selftests: fib_rule_tests: use pre-defined DEV_ADDR

Hans de Goede (1):
      platform/x86: pmc_atom: Add Lex 3I380D industrial PC to
critclk_systems DMI table

Harish Kasiviswanathan (1):
      drm/amdkfd: Fix compute profile switching

Harry Wentland (2):
      drm/amd/display: Add ASICREV_IS_PICASSO
      drm/amd/display: Don't load DMCU for Raven 1

Heiko Stuebner (1):
      Revert "thermal: rockchip: fix up the tsadc pinctrl setting error"

Herbert Xu (2):
      rhashtable: Remove RCU marking from rhash_lock_head
      rhashtable: Fix cmpxchg RCU warnings

Hillf Danton (1):
      arm64: assembler: Update comment above cond_yield_neon() macro

Igor Russkikh (3):
      Revert "aqc111: fix double endianness swap on BE"
      Revert "aqc111: fix writing to the phy on BE"
      aqc111: cleanup mtu related logic

Iuliana Prodan (1):
      crypto: caam - fix typo in i.MX6 devices list for errata

Jagadeesh Pagadala (1):
      kernel/trace/trace.h: Remove duplicate header of trace_seq.h

Jagan Teki (1):
      drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow

James Morse (2):
      KVM: arm64: Move pmu hyp code under hyp's Makefile to avoid
instrumentation
      KVM: arm/arm64: Move cc/it checks under hyp's Makefile to avoid
instrumentation

James Smart (4):
      scsi: lpfc: resolve lockdep warnings
      scsi: lpfc: correct rcu unlock issue in lpfc_nvme_info_show
      scsi: lpfc: add check for loss of ndlp when sending RRQ
      scsi: lpfc: Update lpfc version to 12.2.0.2

Jan Kara (2):
      ext4: wait for outstanding dio during truncate in nojournal mode
      ext4: do not delete unlinked inode from orphan list on failed truncat=
e

Jean-Philippe Brucker (2):
      arm64: insn: Fix ldadd instruction encoding
      arm64: insn: Add BUILD_BUG_ON() for invalid masks

Jens Axboe (2):
      tools/io_uring: fix Makefile for pthread library link
      tools/io_uring: sync with liburing

Jernej Skrabec (2):
      drm/sun4i: Fix sun8i HDMI PHY clock initialization
      drm/sun4i: Fix sun8i HDMI PHY configuration for > 148.5 MHz

Jianbo Liu (1):
      net/mlx5e: Fix calling wrong function to get inner vlan key and mask

Jim Mattson (2):
      kvm: x86: Include multiple indices with CPUID leaf 0x8000001d
      kvm: x86: Include CPUID leaf 0x8000001e in kvm's supported CPUID

Johannes Berg (1):
      NFC: Orphan the subsystem

John Fastabend (4):
      bpf: sockmap, only stop/flush strp if it was enabled at some point
      bpf: sockmap remove duplicate queue free
      bpf: sockmap fix msg->sg.size account on ingress skb
      bpf, tcp: correctly handle DONT_WAIT flags and timeo =3D=3D 0

Johnny Chang (1):
      btrfs: Check the compression level before getting a workspace

Jorge E. Moreira (1):
      vsock/virtio: Initialize core virtio vsock before registering the dri=
ver

Josef Bacik (2):
      btrfs: don't double unlock on error in btrfs_punch_hole
      btrfs: use the existing reserved items for our first prop for inherit=
ance

Junwei Hu (3):
      tipc: switch order of device registration to fix a crash
      tipc: fix modprobe tipc failed after switch order of device registrat=
ion
      tipc: fix modprobe tipc failed after switch order of device registrat=
ion

Kamal Dasu (1):
      dt: bindings: mtd: replace references to nand.txt with
nand-controller.yaml

Kees Cook (2):
      selftests: Remove forced unbuffering for test running
      selftests/timers: Add missing fflush(stdout) calls

Keith Busch (7):
      nvme-pci: Fix controller freeze wait disabling
      nvme-pci: Don't disable on timeout in reset state
      nvme-pci: Unblock reset_work on IO failure
      nvme-pci: Sync queues on reset
      nvme: Fix known effects
      nvme: update MAINTAINERS
      nvme-pci: use blk-mq mapping for unmanaged irqs

Kent Russell (1):
      drm/amdkfd: Add missing Polaris10 ID

Kloetzke Jan (1):
      usbnet: fix kernel crash after disconnect

Konstantin Khlebnikov (1):
      net: bpfilter: fallback to netfilter if failed to load bpfilter
kernel module

Kurt Kanzenbach (2):
      1/2] net: axienet: use readx_poll_timeout() in mdio wait function
      2/2] net: xilinx_emaclite: use readx_poll_timeout() in mdio wait func=
tion

Laine Walker-Avina (1):
      nvme: copy MTFA field from identify controller

Laura Abbott (1):
      arm64: vdso: Explicitly add build-id option

Linus Torvalds (1):
      Linux 5.2-rc2

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix build error when IOMMU_SUPPORT is disabled

Luca Ceresoli (1):
      net: macb: fix error format in dev_err()

Madalin-cristian Bucur (1):
      net: phy: aquantia: readd XGMII support for AQR107

Marc Zyngier (1):
      arm64: Handle erratum 1418040 as a superset of erratum 1188873

Mark Rutland (1):
      arm64/mm: Inhibit huge-vmap with ptdump

Martin K. Petersen (1):
      Revert "scsi: sd: Keep disk read-only when re-reading partition"

Masahiro Yamada (1):
      kbuild: do not check name uniqueness of builtin modules

Masanari Iida (1):
      net-next: net: Fix typos in ip-sysctl.txt

Mauro Carvalho Chehab (1):
      dt: fix refs that were renamed to json with the same file name

Michael Lass (1):
      dm: make sure to obey max_io_len_target_boundary

Miguel Ojeda (1):
      tracing: Silence GCC 9 array bounds warning

Mike Manning (1):
      ipv6: Consider sk_bound_dev_if when binding a raw socket to an addres=
s

Murray McAllister (2):
      drm/vmwgfx: NULL pointer dereference from vmw_cmd_dx_view_define()
      drm/vmwgfx: integer underflow in vmw_cmd_dx_set_shader() leading
to an invalid read

Nick Desaulniers (1):
      kbuild: drop support for cc-ldoption

Paolo Abeni (1):
      selinux: do not report error on connect(AF_UNSPEC)

Paolo Bonzini (8):
      KVM: nVMX: really fix the size checks on KVM_SET_NESTED_STATE
      kvm: selftests: avoid type punning
      kvm: fix compilation on s390
      KVM: selftests: do not blindly clobber registers in guest asm
      KVM: x86: do not spam dmesg with VMCS/VMCB dumps
      KVM: x86/pmu: mask the result of rdpmc according to the width of
the counters
      KVM: x86/pmu: do not mask the value that is written to fixed PMUs
      KVM: x86: fix return value for reserved EFER

Parav Pandit (1):
      net/mlx5: E-Switch, Correct type to u16 for vport_num and int
for vport_index

Patrick Talbert (1):
      net: Treat sock->sk_drops as an unsigned int when printing

Patrik Jakobsson (1):
      drm/gma500/cdv: Check vbt config bits when detecting lvds panels

Paul Walmsley (1):
      dt-bindings: sifive: describe sifive-blocks versioning

Peter Xu (1):
      kvm: Check irqchip mode before assign irqfd

Petr =C5=A0tetiar (1):
      of_net: fix of_get_mac_address retval if compiled without CONFIG_OF

Philippe Mazenauer (1):
      lib: Correct comment of prandom_seed

Pieter Jansen van Vuuren (1):
      nfp: flower: add rcu locks when accessing netdev for tunnels

Qian Cai (1):
      libnvdimm: Fix compilation warnings with W=3D1

Qu Wenruo (1):
      btrfs: extent-tree: Fix a bug that btrfs is unable to add pinned byte=
s

Quinn Tran (1):
      scsi: qla2xxx: Add cleanup for PCI EEH recovery

Randy Dunlap (2):
      net: fix kernel-doc warnings for socket.c
      counter: fix Documentation build error due to incorrect source file n=
ame

Richard Cochran (1):
      ptp: Fix example program to match kernel.

Rob Herring (3):
      dt-bindings: Pass binding directory to validation tools
      dt-bindings: interrupt-controller: arm,gic: Fix schema errors in exam=
ple
      checkpatch.pl: Update DT vendor prefix check

Robin Murphy (1):
      dt-bindings: arm: Clean up CPU binding examples

Russell King (1):
      net: phylink: ensure inband AN works correctly

Sabrina Dubroca (1):
      rtnetlink: always put IFLA_LINK for links with a link-netnsid

Saeed Mahameed (2):
      net/mlx5: Imply MLXFW in mlx5_core
      net/mlx5e: Fix ethtool rxfh commands when CONFIG_MLX5_EN_RXNFC is dis=
abled

Sean Christopherson (1):
      KVM: nVMX: Clear nested_run_pending if setting nested state fails

Stanislav Fomichev (5):
      bpf: mark bpf_event_notify and bpf_event_init as static
      libbpf: don't fail when feature probing fails
      selftests/bpf: add missing \n to flow_dissector CHECK errors
      selftests/bpf: add prog detach to flow_dissector test
      selftests/bpf: add test_sysctl and map_tests/tests.h to .gitignore

Stefan Raspl (1):
      tools/kvm_stat: fix fields filter for child events

Stefano Garzarella (1):
      vsock/virtio: free packets during the socket release

Steffen Dirkwinkel (1):
      platform/x86: pmc_atom: Add several Beckhoff Automation boards
to critclk_systems DMI table

Sunil Muthuswamy (1):
      hv_sock: Add support for delayed close

Suthikulpanit, Suravee (1):
      kvm: svm/avic: fix off-by-one in checking host APIC ID

Sven Eckelmann (2):
      scripts/spdxcheck.py: Fix path to deprecated licenses
      scripts/spdxcheck.py: Add dual license subdirectory

Tan, Tee Min (1):
      net: stmmac: fix ethtool flow control not able to get/set

Tariq Toukan (1):
      net/mlx5e: Fix wrong xmit_more application

Theodore Ts'o (2):
      ext4: don't perform block validity checks on the journal inode
      random: fix soft lockup when trying to read from an
uninitialized blocking pool

Thomas Gleixner (109):
      treewide: Add SPDX license identifier for missed files
      treewide: Add SPDX license identifier for more missed files
      treewide: Add SPDX license identifier - Makefile/Kconfig
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 1
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 3
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 4
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 5
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 7
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 9
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 10
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 11
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 12
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 13
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 14
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 15
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 17
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 18
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 19
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 20
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 21
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 22
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 23
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 24
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 25
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 26
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 27
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 28
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 29
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 30
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 31
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 32
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 33
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 34
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 35
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 36
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 37
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 38
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 39
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 40
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 41
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 42
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 44
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 45
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 46
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 47
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 48
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 49
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 50
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 51
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 52
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 53
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 54
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 55
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 56
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 57
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 59
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 60
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 61
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 62
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 63
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 64
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 65
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 67
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 68
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 69
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 70
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 71
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 72
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 73
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 74
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 75
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 76
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 77
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 78
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 79
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 81
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 82
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 83
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 84
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 86
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 88
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 89
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 90
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 91
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 93
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 94
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 95
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 96
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 97
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 98
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 101
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 102
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 103
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 104
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 105
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 106
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 110
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 111
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 112
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 113
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 114
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 116
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 118
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 119
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 120
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 121
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 122
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 123
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 125

Thomas Hellstrom (4):
      drm/vmwgfx: Don't send drm sysfs hotplug events on initial master set
      drm/vmwgfx: Fix user space handle equal to zero
      drm/vmwgfx: Fix compat mode shader operation
      drm/vmwgfx: Use the dma scatter-gather iterator to get dma addresses

Thomas Huth (3):
      KVM: selftests: Compile code with warnings enabled
      KVM: selftests: Remove duplicated TEST_ASSERT in hyperv_cpuid.c
      KVM: selftests: Wrap vcpu_nested_state_get/set functions with x86 gua=
rd

Tobin C. Harding (2):
      btrfs: sysfs: Fix error path kobject memory leak
      btrfs: sysfs: don't leak memory when failing add fsid

Tom Zanussi (3):
      tracing: Prevent hist_field_var_ref() from accessing NULL tracing_map=
_elts
      tracing: Check keys for variable references in expressions too
      tracing: Add a check_val() check before updating cond_snapshot() trac=
k_val

Tong Bo (1):
      selftests/x86: Support Atom for syscall_arg_fault test

Trac Hoang (2):
      mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold
time problem
      mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

Vadim Pasternak (2):
      mlxsw: core: Prevent QSFP module initialization for old hardware
      mlxsw: core: Prevent reading unsupported slave address from SFP EEPRO=
M

Valentine Fatiev (1):
      net/mlx5: Add meaningful return codes to status_to_err function

Waiman Long (1):
      locking/lock_events: Use this_cpu_add() when necessary

Wanpeng Li (4):
      KVM: Fix spinlock taken warning during host resume
      KVM: nVMX: Fix using __this_cpu_read() in preemptible context
      KVM: LAPIC: Fix lapic_timer_advance_ns parameter overflow
      KVM: LAPIC: Expose per-vCPU timer_advance_ns to userspace

Wei Wang (1):
      ipv6: fix src addr routing with the exception table

Wei Yongjun (1):
      KVM: s390: fix typo in parameter description

Weifeng Voon (1):
      net: stmmac: dma channel control register need to be init first

Weinan (1):
      drm/i915/gvt: emit init breadcrumb for gvt request

Weitao Hou (2):
      fddi: fix typos in code comments
      networking: : fix typos in code comments

Will Deacon (5):
      drivers/perf: arm_spe: Don't error on high-order pages for aux buf
      arm64: Print physical address of page table base in show_pte()
      arm64: Remove useless message during oops
      arm64: errata: Add workaround for Cortex-A76 erratum #1463225
      arm64: Kconfig: Make ARM64_PSEUDO_NMI depend on BROKEN for now

Willem de Bruijn (1):
      net: test nouarg before dereferencing zerocopy pointers

Yan Zhao (4):
      drm/i915/gvt: use cmd to restore in-context mmios to hw for gen9 plat=
form
      drm/i915/gvt: Tiled Resources mmios are in-context mmios for gen9+
      drm/i915/gvt: add 0x4dfc to gen9 save-restore list
      drm/i915/gvt: do not let TRTTE and 0x4dfc write passthrough to hardwa=
re

Yi Wang (1):
      kvm: vmx: Fix -Wmissing-prototypes warnings

Yintian Tao (1):
      drm/amdgpu: skip fw pri bo alloc for SRIOV

Yonghong Song (1):
      tools/bpftool: move set_max_rlimit() before __bpf_object__open_xattr(=
)

Yoshihiro Kaneko (3):
      thermal: rcar_gen3_thermal: Update value of Tj_1
      thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
      thermal: rcar_gen3_thermal: Update temperature conversion method

Yuchung Cheng (1):
      tcp: fix retrans timestamp on passive Fast Open

YueHaibing (5):
      scsi: qedi: remove memset/memcpy to nfunc and use func instead
      scsi: qedi: remove set but not used variables 'cdev' and 'udev'
      ppp: deflate: Fix possible crash in deflate_init
      scsi: myrs: Fix uninitialized variable
      thermal: tegra: Make tegra210_tsensor_thermtrips static

Yufen Yu (1):
      nvme: fix memory leak for power latency tolerance

Yunjian Wang (1):
      net/mlx4_core: Change the error print to info print

Yury Norov (1):
      arm64: don't trash config with compat symbol if COMPAT is disabled

swkhack (1):
      net: caif: fix the value of size argument of snprintf
