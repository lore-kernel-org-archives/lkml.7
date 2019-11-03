Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE8BCA9EBB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F562190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572820133;
	bh=DdIiZU1mhKSlnPMo0q5kMYtZ/fLLvzG7x1mgH5+JbNo=;
	h=From:Date:Subject:To:List-ID:From;
	b=G3AJUG0pGz+4NW+uKutqUnSI87VtLQkab63fyP0MoO34CcYvd8Ixhs/qtZSYD1EEM
	 baV/Ve3Y/HQwOubVIknPbiP8nznKDwrT/U5TQAeEAjI/kFny1g1790DdNIgpYOlp64
	 iRMdyR273sKr/uLEJR71k6Lb5xvJRCfr+h3kWaho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfKCW2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:28:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39765 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfKCW2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:28:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id y3so15527248ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AHntm+4LkPRdI8ytC/Mwf0IBnn2G7AuPM9sLCyIgAm8=;
        b=hJpsGcnK1cCIARYFJtQmYYOsIeHfntri4+SGGdo5V8W7jNO9+G6ZGetDkbKUBcehS3
         7t4sk/w+okPqFFAMnOLZT4y8qFOTfgX9Hl0ehM6N1UujcLpO4gWCV+uMhgLbsyAOqFxB
         rS+6jJCTUsoFrPIspOfz9no0CrlBbIFCJ/XZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AHntm+4LkPRdI8ytC/Mwf0IBnn2G7AuPM9sLCyIgAm8=;
        b=Ph3Pi5mCHGoVPHGlIeSGwWG9vAXEZ0RALeRjXt3VMO9IcmP/gkWgHPCLZkGcqMrNB2
         ls7vL9o2UU05bPUUGfjT8UDnhW3qTwwnSKGFDSOhh4VAyYHofhO4gSfkowtSIItoMghw
         JrIA2QfeBgBx92Mvg/TNffKKeO/lq13BwYGRatQmicHESbNqxFSWZLrB3fW1h8XBdU3d
         04Zgyn8RwX8m5+p9sW7clnqtjNEnsikYrdlOFbeyw77A6Rz+wgTcaaZyB467c9LryJ2r
         M/OYoQ/uqzaeUFjMpYZHl4dq1rTX4tZLXCtomoM8Hx9rj/y0QXABfUInkIM389aFdvFt
         oKvw==
X-Gm-Message-State: APjAAAXMJYXs/ZuX3DAfG1Ku9KOqwwTYqI1y/BCFociaGknFlyOTxDlD
        SkIpELfemxfvK4aMpPlAQnHHuvsQoX4=
X-Google-Smtp-Source: APXvYqxdloy9qcvs5PxG0i+OqNEih0G1seaI/J0+idaUGCtoYBwMxdai4ybPm4zMKUfn7a+ov7/4qg==
X-Received: by 2002:a2e:300e:: with SMTP id w14mr2999167ljw.114.1572820126725;
        Sun, 03 Nov 2019 14:28:46 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x9sm4006832lfn.21.2019.11.03.14.28.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2019 14:28:45 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id e9so2213648ljp.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 14:28:45 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr16300785ljp.133.1572820124868;
 Sun, 03 Nov 2019 14:28:44 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Nov 2019 14:28:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+8=w=sEx9WBF0OJj0SumQ4p-LuP8waRH=TSdAYDeqGg@mail.gmail.com>
Message-ID: <CAHk-=wg+8=w=sEx9WBF0OJj0SumQ4p-LuP8waRH=TSdAYDeqGg@mail.gmail.com>
Subject: Linux 5.4-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back from travels, and (knock wood) with not a lot of jetlag. So doing
the rc release the usual Sunday afternoon in the normal timezone for a
change.

I wish I could say things were calming down, but they aren't. This
week, the main culprit is networking - just about exactly half the
patch (and almost half the commits) is networking-related, either
drivers, core networking, or documentation.

That's not because of some sudden influx of networking issues, it's
just the usual timing thing - rc5 didn't get any networking pull at
all, so rc6 has two weeks worth of networking fixes in it.

But it does mean that we're not seeing the slowdown that I tend to
expect by this time (well, maybe "wish for" is closer than "expect" -
I guess it's more the norm than the exception that rc6 is larger than
I would wish for in a perfect world.. ;^)

There's no particular area or outstanding issue that is worrisome, but
if things don't calm down this week, I suspect we'll be looking at one
of those releases when we have an rc8. We'll see how things evolve
here over the next couple of weeks.

Anyway, outside of the networking changes, it's all the usual stuff:
almost two thirds drivers (all over: gpu, hid, usb, rdma, sound,
dmaengine, acpi..). With the rest being misc arch updates (risc-v,
arm64, x86) and filesystem and core kernel fixlets.

Shortlog appended, easy to scroll through.

Go test, there's nothing scary in here,

           Linus

---

Aaron Ma (1):
      ALSA: hda/realtek - Fix 2 front mics of codec 0x623

Aidan Yang (1):
      drm/amd/display: Allow inverted gamma

Alan Somers (1):
      fuse: Add changelog entries for protocols 7.1 - 7.8

Alan Stern (5):
      HID: Fix assumption that devices have inputs
      USB: Skip endpoints with 0 maxpacket length
      usb-storage: Revert commit 747668dbc061 ("usb-storage: Set
virt_boundary_mask to avoid SG overflows")
      UAS: Revert commit 3ae62a42090f ("UAS: fix alignment of
scatter/gather segments")
      USB: gadget: Reject endpoints with 0 maxpacket value

Alex Deucher (1):
      drm/amdgpu/gmc10: properly set BANK_SELECT and FRAGMENT_SIZE

Alexander Shishkin (1):
      perf/core: Start rejecting the syscall with attr.__reserved_2 set

Alexey Brodkin (1):
      ARC: perf: Accommodate big-endian CPU

Andrew Price (1):
      gfs2: Fix initialisation of args for remount

Andrey Grodzovsky (2):
      drm/sched: Set error to s_fence if HW job submission failed.
      drm/amdgpu: If amdgpu_ib_schedule fails return back the error.

Andrey Smirnov (3):
      HID: logitech-hidpp: split g920_get_config()
      HID: logitech-hidpp: rework device validation
      HID: logitech-hidpp: do all FF cleanup in hidpp_ff_destroy()

Anna Karas (1):
      drm/i915/tgl: Fix doc not corresponding to code

Anson Huang (2):
      net: fec_main: Use platform_get_irq_byname_optional() to avoid
error message
      net: fec_ptp: Use platform_get_irq_xxx_optional() to avoid error mess=
age

Anton Eidelman (2):
      nvme-multipath: fix possible io hang after ctrl reconnect
      nvme-multipath: remove unused groups_only mode in ana log

Anton Ivanov (1):
      um-ubd: Entrust re-queue to the upper layers

Ard Biesheuvel (1):
      efi: libstub/arm: Account for firmware reserved memory at the base of=
 RAM

Arnd Bergmann (3):
      dynamic_debug: provide dynamic_hex_dump stub
      usb: dwc3: select CONFIG_REGMAP_MMIO
      net: dsa: sja1105: improve NET_DSA_SJA1105_TAS dependency

Avri Altman (1):
      scsi: ufs-bsg: Wake the device before sending raw upiu commands

Aya Levin (2):
      net/mlx5e: Fix ethtool self test: link speed
      net/mlx5e: Initialize on stack link modes bitmap

Ayala Beker (1):
      iwlwifi: fw api: support new API for scan config cmd

Baolin Wang (1):
      dmaengine: sprd: Fix the possible memory leak issue

Bart Van Assche (1):
      scsi: target: cxgbit: Fix cxgbit_fw4_ack()

Ben Dooks (Codethink) (8):
      ipv6: include <net/addrconf.h> for missing declarations
      net: mvneta: make stub functions static inline
      net: hwbm: if CONFIG_NET_HWBM unset, make stub functions static
      usb: mtu3: fix missing include of mtu3_dr.h
      usb: cdns3: include host-export,h for cdns3_host_init
      usb: renesas_usbhs: fix __le16 warnings
      usb: renesas_usbhs: fix type of buf
      usb: xhci: fix __le32/__le64 accessors in debugfs code

Benjamin Herrenschmidt (1):
      net: ethernet: ftgmac100: Fix DMA coherency issue with SW checksum

Bjorn Andersson (2):
      arm64: cpufeature: Enable Qualcomm Falkor/Kryo errata 1003
      arm64: cpufeature: Enable Qualcomm Falkor errata 1009 for Kryo

Catalin Marinas (1):
      arm64: Ensure VM_WRITE|VM_SHARED ptes are clean by default

Chandana Kishori Chiluveru (1):
      usb: gadget: composite: Fix possible double free memory bug

Christian Gmeiner (1):
      drm/etnaviv: fix dumping of iommuv2

Christophe Leroy (1):
      powerpc/32s: fix allow/prevent_user_access() when crossing
segment boundaries.

Chuhong Yuan (1):
      net: ethernet: arc: add the missed clk_disable_unprepare

Colin Ian King (2):
      HID: prodikeys: make array keys static const, makes object smaller
      qed: fix spelling mistake "queuess" -> "queues"

Cristian Birsan (1):
      usb: gadget: udc: atmel: Fix interrupt storm in FIFO mode.

Dan Carpenter (2):
      RDMA/uverbs: Prevent potential underflow
      iocost: don't nest spin_lock_irq in ioc_weight_write()

Daniel Borkmann (2):
      bpf: Fix use after free in subprog's jited symbol removal
      bpf: Fix use after free in bpf_get_prog_name

Daniel Wagner (3):
      scsi: lpfc: Check queue pointer before use
      scsi: lpfc: Honor module parameter lpfc_use_adisc
      net: usb: lan78xx: Disable interrupts before calling generic_handle_i=
rq()

David Ahern (1):
      selftests: Make l2tp.sh executable

David Howells (1):
      rxrpc: Fix handling of last subpacket of jumbo packet

Davide Caratti (1):
      ipvs: don't ignore errors in case refcounting ip_vs module fails

Dmytro Linkin (2):
      net/mlx5e: Determine source port properly for vlan push action
      net/mlx5e: Remove incorrect match criteria assignment line

Dominik Brodowski (1):
      efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness

Doug Berger (1):
      arm64: apply ARM64_ERRATUM_845719 workaround for Brahma-B53 core

Eli Britstein (1):
      net/mlx5: Fix NULL pointer dereference in extended destination

Eran Ben Elisha (1):
      net/mlx4_core: Dynamically set guaranteed amount of counters per VF

Eric Dumazet (14):
      ipv4: fix IPSKB_FRAG_PMTU handling with fragmentation
      net/flow_dissector: switch to siphash
      ipvs: move old_secure_tcp into struct netns_ipvs
      net: add skb_queue_empty_lockless()
      udp: use skb_queue_empty_lockless()
      net: use skb_queue_empty_lockless() in poll() handlers
      net: use skb_queue_empty_lockless() in busy poll contexts
      net: add READ_ONCE() annotation in __skb_wait_for_more_packets()
      udp: fix data-race in udp_set_dev_scratch()
      net: annotate accesses to sk->sk_incoming_cpu
      net: annotate lockless accesses to sk->sk_napi_id
      net: increase SOMAXCONN to 4096
      tcp: increase tcp_max_syn_backlog max value
      inet: stop leaking jiffies on the wire

Eugeniy Paltsev (2):
      ARC: [plat-hsdk]: Enable on-board SPI NOR flash IC
      ARC: [plat-hsdk]: Enable on-boardi SPI ADC IC

Felipe Balbi (1):
      usb: dwc3: gadget: fix race when disabling ep with cancelled xfers

Florian Fainelli (4):
      arm64: Brahma-B53 is SSB and spectre v2 safe
      arm64: apply ARM64_ERRATUM_843419 workaround for Brahma-B53 core
      net: phylink: Fix phylink_dbg() macro
      net: dsa: bcm_sf2: Fix IMP setup for port different than 8

Frederic Barrat (1):
      powerpc/powernv/eeh: Fix oops when probing cxl devices

Geert Uytterhoeven (1):
      perf/headers: Fix spelling s/EACCESS/EACCES/, s/privilidge/privilege/

Guillaume Nault (1):
      netns: fix GFP flags in rtnl_net_notifyid()

GwanYeong Kim (1):
      usbip: tools: Fix read_usb_vudc_device() error path handling

Haiyang Zhang (2):
      hv_netvsc: Fix error handling in netvsc_set_features()
      hv_netvsc: Fix error handling in netvsc_attach()

Hannes Reinecke (1):
      scsi: qla2xxx: fixup incorrect usage of host_byte

Hans de Goede (1):
      HID: i2c-hid: add Trekstor Primebook C11B to descriptor override

Heiko Carstens (1):
      s390/idle: fix cpu idle time calculation

Heiner Kallweit (1):
      r8169: fix wrong PHY ID issue with RTL8168dp

Hillf Danton (1):
      net: openvswitch: free vport unless register_netdevice() succeeds

Himanshu Madhani (1):
      scsi: qla2xxx: Initialized mailbox to prevent driver load failure

Ido Schimmel (1):
      netdevsim: Fix use-after-free during device dismantle

Igor Pylypiv (1):
      ixgbe: Remove duplicate clear_bit() call

Ilya Leoshkevich (1):
      s390/unwind: fix mixing regs and sp

Jakub Kicinski (4):
      MAINTAINERS: remove Dave Watson as TLS maintainer
      selftests: bpf: Skip write only files in debugfs
      net: cls_bpf: fix NULL deref on offload filter removal
      net: fix installing orphaned programs

Jason Gunthorpe (1):
      RDMA/mlx5: Use irq xarray locking for mkey_table

Jason Wang (1):
      vringh: fix copy direction of vringh_iov_push_kern()

Javier Martinez Canillas (1):
      efi/efi_test: Lock down /dev/efi_test and require CAP_SYS_ADMIN

Jeff Kirsher (1):
      i40e: Fix receive buffer starvation for AF_XDP

Jeffrey Hugo (1):
      dmaengine: qcom: bam_dma: Fix resource leak

Jens Axboe (2):
      io_uring: don't touch ctx in setup after ring fd install
      io_uring: ensure we clear io_kiocb->result before each issue

Jerry Snitselaar (1):
      efi/tpm: Return -EINVAL when determining tpm final events log size fa=
ils

Jiangfeng Xiao (2):
      net: hisilicon: Fix "Trying to free already-free IRQ"
      net: hisilicon: Fix ping latency when deal with high throughput

Jim Mattson (2):
      kvm: Allocate memslots and buses before calling kvm_arch_init_vm
      kvm: call kvm_arch_destroy_vm if vm creation fails

Jiri Benc (2):
      bpf: lwtunnel: Fix reroute supplying invalid dst
      selftests/bpf: More compatible nc options in test_tc_edt

Jiri Pirko (1):
      mlxsw: core: Unpublish devlink parameters during reload

Johan Hovold (5):
      USB: ldusb: fix ring-buffer locking
      USB: ldusb: use unsigned size format specifiers
      USB: ldusb: fix control-message timeout
      USB: serial: whiteheat: fix potential slab corruption
      USB: serial: whiteheat: fix line-speed endianness

Johannes Berg (1):
      iwlwifi: mvm: handle iwl_mvm_tvqm_enable_txq() error return

John Donnelly (1):
      iommu/vt-d: Fix panic after kexec -p for kdump

Jonathan Neusch=C3=A4fer (1):
      Documentation: networking: device drivers: Remove stray asterisks

Jun Lei (2):
      drm/amd/display: do not synchronize "drr" displays
      drm/amd/display: add 50us buffer as WA for pstate switch in active

Justin Song (1):
      ALSA: usb-audio: Add DSD support for Gustard U16/X26 USB Interface

Kai-Heng Feng (1):
      HID: i2c-hid: Remove runtime power management

Kaike Wan (1):
      IB/hfi1: Avoid excessive retry for TID RDMA READ request

Kailang Yang (1):
      ALSA: hda/realtek - Add support for ALC623

Kairui Song (1):
      x86, efi: Never relocate kernel below lowest acceptable address

Kamal Heib (1):
      RDMA/qedr: Fix reported firmware version

Kan Liang (1):
      perf/x86/uncore: Fix event group support

Kazutoshi Noguchi (1):
      r8152: add device id for Lenovo ThinkPad USB-C Dock Gen 2

Kim Phillips (2):
      perf/x86/amd/ibs: Fix reading of the IBS OpData register and
thus precise RIP validity
      perf/x86/amd/ibs: Handle erratum #420 only on the affected CPU
family (10h)

Krishnamraju Eraparaju (2):
      RDMA/iwcm: move iw_rem_ref() calls out of spinlock
      RDMA/siw: free siw_base_qp in kref release routine

Kyle Mahlkuch (1):
      drm/radeon: Fix EEH during kexec

Larry Finger (1):
      rtlwifi: rtl_pci: Fix problem of too small skb->len

Laura Abbott (1):
      rtlwifi: Fix potential overflow on P2P code

Lijun Ou (1):
      RDMA/hns: Prevent memory leaks of eq->buf_list

Linus Torvalds (1):
      Linux 5.4-rc6

Lorenzo Bianconi (2):
      mt76: mt76x2e: disable pcie_aspm by default
      mt76: dma: fix buffer unmap with non-linear skbs

Luca Coelho (5):
      iwlwifi: pcie: fix merge damage on making QnJ exclusive
      iwlwifi: pcie: fix PCI ID 0x2720 configs that should be soc
      iwlwifi: pcie: fix all 9460 entries for qnj
      iwlwifi: pcie: add workaround for power gating in integrated 22000
      iwlwifi: pcie: 0x2720 is qu and 0x30DC is not

Lucas Stach (2):
      drm/etnaviv: fix deadlock in GPU coredump
      drm/etnaviv: reinstate MMUv1 command buffer window check

Lyude Paul (1):
      igb/igc: Don't warn on fatal read failures when the device is removed

Magnus Karlsson (1):
      xsk: Fix registration of Rx-only sockets

Manfred Rudigier (2):
      igb: Enable media autosense for the i350.
      igb: Fix constant media auto sense switching when no cable is connect=
ed

Maor Gottlieb (1):
      net/mlx5e: Replace kfree with kvfree when free vhca stats

Mark Zhang (1):
      RDMA/nldev: Skip counter if port doesn't match

Markus Theil (1):
      nl80211: fix validation of mesh path nexthop

Martin Fuzzey (1):
      net: phy: smsc: LAN8740: add PHY_RST_AFTER_CLK_EN flag

Marvin Liu (1):
      virtio_ring: fix stalls for packed rings

Masashi Honma (1):
      nl80211: Disallow setting of HT for channel 14

Mathias Nyman (1):
      xhci: Fix use-after-free regression in xhci clear hub TT implementati=
on

Maxim Mikityanskiy (1):
      net/mlx5e: Fix handling of compressed CQEs in case of low NAPI budget

Michael Chan (1):
      bnxt_en: Fix devlink NVRAM related byte order related issues.

Michael Strauss (1):
      drm/amd/display: Passive DP->HDMI dongle detection fix

Micha=C5=82 Miros=C5=82aw (1):
      HID: fix error message in hid_open_report()

Mike Marciniszyn (1):
      IB/hfi1: Use a common pad buffer for 9B and 16B packets

Miklos Szeredi (5):
      virtio-fs: don't show mount options
      fuse: don't dereference req->args on finished request
      fuse: don't advise readdirplus for negative lookup
      fuse: flush dirty data/metadata before non-truncate setattr
      fuse: truncate pending writes on O_TRUNC

Narendra K (1):
      efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only

Navid Emamdoost (5):
      net/mlx5: prevent memory leak in mlx5_fpga_conn_create_cq
      net/mlx5: fix memory leak in mlx5_fw_fatal_reporter_dump
      drm/v3d: Fix memory leak in v3d_submit_cl_ioctl
      usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
      wimax: i2400: Fix memory leak in i2400m_op_rfkill_sw_toggle

Nicholas Piggin (2):
      scsi: qla2xxx: stop timer in shutdown path
      powerpc/powernv: Fix CPU idle to be called with IRQs disabled

Nick Desaulniers (3):
      drm/amdgpu: fix stack alignment ABI mismatch for Clang
      drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
      drm/amdgpu: enable -msse2 for GCC 7.1+ users

Nicolas Boichat (1):
      HID: google: add magnemite/masterball USB ids

Nicolin Chen (1):
      hwmon: (ina3221) Fix read timeout issue

Nikhil Badola (1):
      usb: fsl: Check memory resource before releasing it

Nikolay Aleksandrov (1):
      net: rtnetlink: fix a typo fbd -> fdb

Nishad Kamdar (2):
      net: ethernet: Use the correct style for SPDX License Identifier
      net: dpaa2: Use the correct style for SPDX License Identifier

Pablo Neira Ayuso (2):
      netfilter: nf_flow_table: set timeout before insertion into hashes
      netfilter: nf_tables_offload: restore basechain deletion

Palmer Dabbelt (1):
      MAINTAINERS: Change to my personal email address

Paolo Abeni (2):
      ipv4: fix route update on metric change.
      selftests: fib_tests: add more tests for metric update

Paolo Bonzini (1):
      KVM: vmx, svm: always run with EFER.NXE=3D1 when shadow paging is act=
ive

Parav Pandit (3):
      IB/core: Use rdma_read_gid_l2_fields to compare GID L2 fields
      IB/core: Avoid deadlock during netlink message handling
      net/mlx5: Fix rtable reference leak

Paul Walmsley (6):
      riscv: add prototypes for assembly language functions from head.S
      riscv: init: merge split string literals in preprocessor directive
      riscv: mark some code and data as file-static
      riscv: add missing header file includes
      riscv: fp: add missing __user pointer annotations
      riscv: for C functions called only from assembly, mark with __visible

Pavel Begunkov (1):
      io_uring: Fix leaked shadow_req

Pelle van Gils (1):
      drm/amdgpu/powerplay/vega10: allow undervolting in p7

Peter Chen (1):
      usb: gadget: configfs: fix concurrent issue between composite APIs

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu/sdma5: do not execute 0-sized IBs (v2)

Potnuri Bharat Teja (2):
      iw_cxgb4: fix ECN check on the passive accept
      RDMA/iw_cxgb4: Avoid freeing skb twice in arp failure case

Quinn Tran (1):
      scsi: qla2xxx: Fix partial flash write of MBI

Radhey Shyam Pandey (2):
      dmaengine: xilinx_dma: Fix 64-bit simple AXIDMA transfer
      dmaengine: xilinx_dma: Fix control reg update in vdma_channel_set_con=
fig

Rafael J. Wysocki (1):
      ACPI: processor: Add QoS requests for all CPUs

Rafi Wiener (1):
      RDMA/mlx5: Clear old rate limit when closing QP

Raju Rangoju (1):
      cxgb4: request the TX CIDX updates to status page

Robin Gong (1):
      dmaengine: imx-sdma: fix size check for sdma script_number

Robin Murphy (1):
      drm/panfrost: Don't dereference bogus MMU pointers

Roger Quadros (2):
      usb: cdns3: gadget: Don't manage pullups
      usb: cdns3: gadget: Fix g_audio use case when connected to
Super-Speed host

Roi Dayan (1):
      net/mlx5: Fix flow counter list auto bits struct

Sameer Pujar (1):
      dmaengine: tegra210-adma: fix transfer failure

Samuel Holland (1):
      usb: xhci: fix Immediate Data Transfer endianness

Sanket Parmar (1):
      usb: cdns3: gadget: reset EP_CLAIMED flag while unloading

Stefano Garzarella (1):
      vsock/virtio: remove unused 'work' field from 'struct virtio_vsock_pk=
t'

Steve French (1):
      fix memory leak in large read decrypt offload

Sudarsana Reddy Kalluru (1):
      qed: Optimize execution time for nvm attributes configuration.

Suwan Kim (1):
      usbip: Fix free of unallocated memory in vhci tx

Sven Eckelmann (2):
      batman-adv: Avoid free/alloc race when handling OGM2 buffer
      batman-adv: Avoid free/alloc race when handling OGM buffer

Sven Schnelle (1):
      parisc: fix frame pointer in ftrace_regs_caller()

Taehee Yoo (12):
      net: core: limit nested device depth
      net: core: add generic lockdep keys
      bonding: fix unexpected IFF_BONDING bit unset
      bonding: use dynamic lockdep key instead of subclass
      team: fix nested locking lockdep warning
      macsec: fix refcnt leak in module exit routine
      net: core: add ignore flag to netdev_adjacent structure
      vxlan: add adjacent link to limit depth level
      net: remove unnecessary variables and callback
      virt_wifi: fix refcnt leak in module exit routine
      bonding: fix using uninitialized mode_lock
      vxlan: fix unexpected failure of vxlan_changelink()

Takashi Iwai (4):
      Revert "ALSA: hda: Flush interrupts on disabling"
      iommu/amd: Apply the same IVRS IOAPIC workaround to Acer Aspire A315-=
41
      ALSA: hda - Fix mutex deadlock in HDMI codec driver
      ALSA: timer: Fix mutex deadlock at releasing card

Takashi Sakamoto (1):
      ALSA: bebob: Fix prototype of helper function to return negative valu=
e

Takeshi Misawa (1):
      keys: Fix memory leak in copy_net_ns

Tariq Toukan (13):
      net/mlx5e: Tx, Fix assumption of single WQEBB of NOP in cleanup flow
      net/mlx5e: Tx, Zero-memset WQE info struct upon update
      net/mlx5e: kTLS, Release reference on DUMPed fragments in shutdown fl=
ow
      net/mlx5e: kTLS, Size of a Dump WQE is fixed
      net/mlx5e: kTLS, Save only the frag page to release at completion
      net/mlx5e: kTLS, Save by-value copy of the record frags
      net/mlx5e: kTLS, Fix page refcnt leak in TX resync error flow
      net/mlx5e: kTLS, Fix missing SQ edge fill
      net/mlx5e: kTLS, Limit DUMP wqe size
      net/mlx5e: kTLS, Remove unneeded cipher type checks
      net/mlx5e: kTLS, Save a copy of the crypto info
      net/mlx5e: kTLS, Enhance TX resync flow
      net/mlx5e: TX, Fix consumer index of error cqe dump

Tejun Heo (1):
      net: fix sk_page_frag() recursion from memory reclaim

Thiago Jung Bauermann (1):
      powerpc/prom_init: Undo relocation before entering secure mode

Thierry Reding (1):
      Revert "pwm: Let pwm_get_state() return the last implemented state"

Tianci.Yin (3):
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: update gfx golden settings for navi12

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      xdp: Prevent overflow in devmap_hash cost calculation for 32-bit buil=
ds
      xdp: Handle device unregister for devmap_hash map type

Tomeu Vizoso (1):
      panfrost: Properly undo pm_runtime_enable when deferring a probe

Tony Lindgren (1):
      dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle

Trond Myklebust (5):
      SUNRPC: The TCP back channel mustn't disappear while requests
are outstanding
      SUNRPC: The RDMA back channel mustn't disappear while requests
are outstanding
      SUNRPC: Destroy the back channel when we destroy the host transport
      NFSv4: Don't allow a cached open with a revoked delegation
      NFS: Fix an RCU lock leak in nfs4_refresh_delegation_stateid()

Ursula Braun (3):
      net/smc: fix closing of fallback SMC sockets
      net/smc: keep vlan_id for SMC-R in smc_listen_work()
      net/smc: fix refcounting for non-blocking connect()

Valentin Schneider (2):
      sched/topology: Don't try to build empty sched domains
      sched/topology: Allow sched_asym_cpucapacity to be disabled

Vasily Averin (1):
      fuse: redundant get_fuse_inode() calls in fuse_writepages_fill()

Vasundhara Volam (4):
      bnxt_en: Fix the size of devlink MSIX parameters.
      bnxt_en: Adjust the time to wait before polling firmware readiness.
      bnxt_en: Minor formatting changes in FW devlink_health_reporter
      bnxt_en: Avoid disabling pci device in bnxt_remove_one() for
already disabled device.

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix PCH reference clock for FDI on HSW/BDW

Vincent Prince (1):
      net: sch_generic: Use pfifo_fast as fallback scheduler for CAN hardwa=
re

Vishal Kulkarni (1):
      cxgb4: fix panic when attaching to ULD fail

Vivek Goyal (6):
      virtio-fs: Change module name to virtiofs.ko
      virtiofs: Do not end request in submission context
      virtiofs: No need to check fpq->connected state
      virtiofs: Set FR_SENT flag only after request has been sent
      virtiofs: Count pending forgets as in_flight forgets
      virtiofs: Retry request submission from worker context

Vlad Buslov (2):
      net/mlx5e: Only skip encap flows update when encap init failed
      net/mlx5e: Don't store direct pointer to action's tunnel info

Vladimir Oltean (2):
      net: mscc: ocelot: fix vlan_filtering when enslaving to bridge
before link is up
      net: mscc: ocelot: refuse to overwrite the port's native vlan

Wei Wang (1):
      selftests: net: reuseport_dualstack: fix uninitalized parameter

Wenwen Wang (1):
      e1000: fix memory leaks

Will Deacon (1):
      fjes: Handle workqueue allocation failure

Xiang Chen (1):
      scsi: sd: define variable dif as unsigned int instead of bool

Xin Long (2):
      erspan: fix the tun_info options_len check for erspan
      vxlan: check tun_info options_len properly

Yangchun Fu (1):
      gve: Fixes DMA synchronization.

Yash Shah (1):
      RISC-V: Add PCIe I/O BAR memory mapping

Yi Wang (2):
      net: sched: taprio: fix -Wmissing-prototypes warnings
      drm/panfrost: fix -Wmissing-prototypes warnings

Yihui ZENG (1):
      s390/cmm: fix information leak in cmm_timeout_handler()

Yinbo Zhu (1):
      usb: dwc3: remove the call trace of USBx_GFLADJ

Yoshihiro Shimoda (2):
      usb: gadget: udc: renesas_usb3: Fix __le16 warnings
      usb: renesas_usbhs: Fix warnings in usbhsg_recip_handler_std_set_devi=
ce()

YueHaibing (1):
      iommu/ipmmu-vmsa: Remove dev_err() on platform_get_irq() failure

Zhan liu (2):
      drm/amd/display: Change Navi14's DWB flag to 1
      drm/amd/display: setting the DIG_MODE to the correct value.

Zhang Lixu (1):
      HID: intel-ish-hid: fix wrong error handling in ishtp_cl_alloc_tx_rin=
g()

Zhenfang Wang (1):
      dmaengine: sprd: Fix the link-list pointer register configuration iss=
ue

amy.shih (1):
      hwmon: (nct7904) Fix the incorrect value of vsen_mask &
tcpu_mask & temp_mode in nct7904_data struct.

chen gong (1):
      drm/amdgpu: Fix SDMA hang when performing VKexample test

wenxu (1):
      netfilter: nft_payload: fix missing check for matching length in offl=
oads

yuqi jin (1):
      net: stmmac: Fix the problem of tso_xmit

zhanglin (1):
      net: Zeroing the structure ethtool_wolinfo in ethtool_get_wol()

zhengbin (1):
      virtiofs: Remove set but not used variable 'fc'

zhongshiqi (1):
      dc.c:use kzalloc without test
