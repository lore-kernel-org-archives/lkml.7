Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991CDC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5FE2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561247024;
	bh=J53PpLrU6SpEGt7TfIv3+nEZxxj3JQu8UaZgefAKSHg=;
	h=From:Date:Subject:To:List-ID:From;
	b=S4t9f05HrfK61TlLOxpJBZr4qdKcjtbD+REtzy6f5/ADszRW1ynHtFr2nMzFx5R9s
	 kQAPHg6bbBraWLFr9nxtqHgOBnk+C5jVrCAIMQvAlx5MrEn51xKRfxMgqpwaDC2dxQ
	 nkKNWpb68B5FFGbGwtqzYvLQG0/89nTd5yQGJITQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFVXnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:43:43 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39468 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVXnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 19:43:42 -0400
Received: by mail-lf1-f45.google.com with SMTP id p24so7462123lfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LU3uMds1g/nrEEvS+9uj2luLp84Bfv5RdxRrhl191RA=;
        b=gQcoupc54I+c673TcT3IHRusLEMxC3HQfxJVPxZiteDCgrq18Ml/XlDJfT1WuN4Qq+
         +LdNMubIM875MtpjIJJZN3aDrn1f4CX92DhY64KksAs4hzvsy4tG12T/kqEyUNzQ4rpL
         +fEzIUCZY1+wlt9MrN120Az49ZgaK2bxPsKHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LU3uMds1g/nrEEvS+9uj2luLp84Bfv5RdxRrhl191RA=;
        b=CwbiRpCXtAv+Wac/8ftjOFrq6VZdm2RH3L3TpCW5av1oVyzEnhJLndfer4QExLAjOB
         +ya9zhr1BQslY0sNDNPYcw7r4voSrhx2foc4yCcUDhYL454fl0g1r3Q47E3huiVQgLgs
         fEEgE12qg2Z4Z5wMryOIpA+IZ4NjG1FT1R/tWSVx9LrWwz1OE16FotbqTXbYWqNGDzYG
         wzHeoDN1lB0NirLCxxK+98f+NZleEuYV8ZywVcDehZZ9tagtzHw+Gq0OqP2HB1WOnUao
         8g9Afx1WB/JVtImz/mvXiCG80g7q/jlzLZ/sPGpXKRynGNvq+U2no7gy5jv+UpvYCd9H
         6yzQ==
X-Gm-Message-State: APjAAAVRfC1p4vCX6n3uZYeNKgdARaRAyBlCZp/uM5WfzlLryrQnEleT
        0yD7+ugNZ68Xxo4mWNdDrKWA6t4adDE=
X-Google-Smtp-Source: APXvYqwJYsQLzUkHQfWy8fQuv3XVtoUgDqNB6En02AIKCXO8U2N95enTqqW3czFGunDvVV7D5fIphg==
X-Received: by 2002:a19:8116:: with SMTP id c22mr66980021lfd.111.1561247017019;
        Sat, 22 Jun 2019 16:43:37 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e13sm1045212ljg.102.2019.06.22.16.43.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 16:43:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h10so9212576ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 16:43:35 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr31411071ljj.165.1561247015167;
 Sat, 22 Jun 2019 16:43:35 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Jun 2019 16:43:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+nPKhdn=vKSgJQkfOSGhauTO4jyt=0FH9cnM_QChDLw@mail.gmail.com>
Message-ID: <CAHk-=wg+nPKhdn=vKSgJQkfOSGhauTO4jyt=0FH9cnM_QChDLw@mail.gmail.com>
Subject: Linux 5.2-rc6
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uhh-uh.

I really was hoping that we'd continue to have an increasingly quiet
and shrinking rc series. But that was not to be.

rc6 is the biggest rc in number of commits we've had so far for this
5.2 cycle (obviously ignoring the merge window itself and rc1). And
it's not just because of trivial patches (although admittedly we have
those too), but we obviously had the TCP SACK/fragmentation/mss fixes
in there, and they in turn required some fixes too.

Happily we did pick up on the problem quickly - largely thanks to the
patches making it into distro kernels quickly and then causing
problems for the steam client of all things - but it's still something
that doesn't exactly make me get the warm and fuzzies at this point in
the release cycle.

I'm also doing this rc on a Saturday, because I am going to spend all
of tomorrow on a plane once again. So I'm traveling first for a
conference and then for some R&R on a liveaboard, so I'm going to have
spotty access to email for a few days, and then for a week I'll be
entirely incommunicado. So rc7 will be delayed.

I was thinking that I timed it all really well in what should be the
quietest period of the release cycle for me, and now I obviously hope
that last week really was a fluke.

Anyway, if something happens when I'm offline, Greg can presumably
step up, although he'll have the same conference travel (but
presumably at least the reverse jetlag ;)

With all that out of the way, I'm still reasonably optimistic that
we're on track for a calm final part of the release, and I don't think
there is anything particularly bad on the horizon.

And while we did have some excitement this week, _most_ of it by far
was the usual small fixes. Including the by now expected SPDX updates,
so the diffstat looks a bit messy again.

Anyway, ignoring the SPDX updates (and you should, even if they
dominate the diffstat), about a quarter of the rc6 update is
networking (the TCP fixes being a fairly small part of it - the bulk
is still network driver and other networking fixes, including bpf).
Another quarter is selftests (mostly bpf) and documentation.

The rest other driver updates (gpu, rdma, thunderbolt, usb..) arch
updates (x86, risc-v and arm[64]), and misc other updates (overlayfs
etc).

But honestly, most of it really is pretty small (again - ignoring the
SPDX noise), so despite my misgivings I don't think we're really in
trouble.

Shortlog appended for the brave souls who want to look at details,

                 Linus

---

Aaron Lewis (2):
      kvm: tests: Sort tests in the Makefile alphabetically
      tests: kvm: Check for a kernel warning

Aaron Ma (1):
      Input: elantech - enable middle button support on 2 ThinkPads

Alaa Hleihel (2):
      net/mlx5: Avoid reloading already removed devices
      net/mlx5e: Avoid detaching non-existing netdev under switchdev mode

Alakesh Haloi (1):
      selftests: bpf: fix compiler warning in flow_dissector test

Alan Tull (1):
      MAINTAINERS: fpga: hand off maintainership to Moritz

Alexander Dahl (1):
      can: usb: Kconfig: Remove duplicate menu entry

Alexander Mikhaylenko (1):
      Input: synaptics - enable SMBus on ThinkPad E480 and E580

Alexei Starovoitov (1):
      bpf, x64: fix stack layout of JITed bpf code

Amir Goldstein (3):
      ovl: fix wrong flags check in FS_IOC_FS[SG]ETXATTR ioctls
      ovl: make i_ino consistent with st_ino in more cases
      fanotify: update connector fsid cache on add mark

Anders Roxell (1):
      net: dsa: fix warning same module names

Andreas Schwab (1):
      riscv: export pm_power_off again

Andrew Jones (1):
      KVM: arm/arm64: Fix emulated ptimer irq injection

Andrey Smirnov (1):
      Input: uinput - add compat ioctl number translation for UI_*_FF_UPLOA=
D

Andy Gross (1):
      MAINTAINERS: Change QCOM repo location

Andy Lutomirski (1):
      x86/vdso: Prevent segfaults due to hoisted vclock reads

Andy Strohman (1):
      nl80211: fix station_info pertid memory leak

Anisse Astier (2):
      arm64: ssbd: explicitly depend on <linux/prctl.h>
      arm64/sve: <uapi/asm/ptrace.h> should not depend on <uapi/linux/prctl=
.h>

Anna Schumaker (1):
      Revert "SUNRPC: Declare RPC timers as TIMER_DEFERRABLE"

Anson Huang (2):
      firmware: imx: SCU irq should ONLY be enabled after SCU IPC is ready
      Input: imx_keypad - make sure keyboard can always wake up system

Anssi Hannula (1):
      can: xilinx_can: use correct bittiming_const for CAN FD core

Arnd Bergmann (6):
      firmware: trusted_foundations: add ARMv7 dependency
      ARM: ixp4xx: don't select SERIAL_OF_PLATFORM
      ARM: ixp4xx: mark ixp4xx_irq_setup as __init
      ARM: ixp4xx: include irqs.h where needed
      ovl: fix bogus -Wmaybe-unitialized warning
      habanalabs: use u64_to_user_ptr() for reading user pointers

Arthur Fabre (1):
      bpf: Fix out of bounds memory access in bpf_sk_storage

Arun Easi (1):
      scsi: qla2xxx: Fix hardlockup in abort command during driver remove

Avraham Stern (1):
      cfg80211: report measurement start TSF correctly

Bartosz Golaszewski (2):
      ARM: davinci: da850-evm: call regulator_has_full_constraints()
      ARM: davinci: da8xx: specify dma_coherent_mask for lcdc

Benjamin Coddington (1):
      NFS4: Only set creation opendata if O_CREAT

Bj=C3=B6rn T=C3=B6pel (2):
      bpf, riscv: clear target register high 32-bits for and/or/xor on ALU3=
2
      selftests: bpf: add zero extend checks for ALU32 and/or/xor

Boris Brezillon (1):
      drm/panfrost: Make sure a BO is only unmapped when appropriate

Chang-Hsien Tsai (1):
      samples, bpf: fix to change the buffer size for read()

Chris Mi (1):
      net/mlx5e: Add ndo_set_feature for uplink representor

Christian Brauner (1):
      fs/namespace: fix unprivileged mount propagation

Christoph Hellwig (3):
      block: return from __bio_try_merge_page if merging occured in
the same page
      block: fix page leak when merging to same page
      powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac

Christophe Leroy (3):
      powerpc/32s: fix initial setup of segment registers on secondary CPU
      powerpc/booke: fix fast syscall entry on SMP
      powerpc/32: fix build failure on book3e with KVM

Colin Ian King (1):
      net: lio_core: fix potential sign-extension overflow on large shift

Crt Mori (1):
      iio: temperature: mlx90632 Relax the compatibility check

Dan Carpenter (2):
      soc: ixp4xx: npe: Fix an IS_ERR() vs NULL check in probe
      drm: return -EFAULT if copy_to_user() fails

Daniel Borkmann (6):
      bpf: fix unconnected udp hooks
      bpf: sync tooling uapi header
      bpf, libbpf: enable recvmsg attach types
      bpf, bpftool: enable recvmsg attach types
      bpf: more msg_name rewrite tests to test_sock_addr
      bpf: expand section tests for test_section_names

Daniel Smith (1):
      Input: silead - add MSSL0017 to acpi_device_id

Dave Martin (2):
      KVM: arm64: Filter out invalid core register IDs in KVM_GET_REG_LIST
      KVM: arm/arm64: vgic: Fix kvm_device leak in vgic_its_destroy

David Ahern (1):
      ipv6: Default fib6_type to RTN_UNICAST when not set

David S. Miller (1):
      Revert "net: phylink: set the autoneg state in phylink_phy_change"

Dennis Restle (1):
      KVM: fix typo in documentation

Dexuan Cui (1):
      hv_sock: Suppress bogus "may be used uninitialized" warnings

Douglas Anderson (5):
      Revert "brcmfmac: disable command decode in sdio_aos"
      mmc: core: API to temporarily disable retuning for SDIO CRC errors
      brcmfmac: sdio: Disable auto-tuning around commands expected to fail
      mmc: core: Add sdio_retune_hold_now() and sdio_retune_release()
      brcmfmac: sdio: Don't tune while the card is off

Edward Srouji (1):
      net/mlx5: Update pci error handler entries and command translation

Eli Britstein (1):
      net/mlx5e: Support tagged tunnel over bond

Emmanuel Grumbach (1):
      iwlwifi: fix load in rfkill flow for unified firmware

Enrico Weigelt (1):
      net: ipv4: fib_semantics: fix uninitialized variable

Eric Biggers (2):
      cfg80211: fix memory leak of wiphy device name
      vfs: fsmount: add missing mntget()

Eric Dumazet (14):
      ipv6: flowlabel: fl6_sock_lookup() must use atomic_inc_not_zero
      sysctl: define proc_do_static_key()
      tcp: add tcp_rx_skb_cache sysctl
      tcp: add tcp_tx_skb_cache sysctl
      net: add high_order_alloc_disable sysctl/static key
      tcp: limit payload size of sacked skbs
      tcp: tcp_fragment() should apply sane memory limits
      tcp: add tcp_min_snd_mss sysctl
      tcp: enforce tcp_min_snd_mss in tcp_mtu_probing()
      tcp: fix compile error if !CONFIG_SYSCTL
      neigh: fix use-after-free read in pneigh_get_next
      ax25: fix inconsistent lock state in ax25_destroy_timer
      inet: clear num_timeout reqsk_alloc()
      tcp: refine memory limit test in tcp_fragment()

Eugen Hristev (1):
      can: m_can: implement errata "Needless activation of MRAF irq"

Fabio Estevam (3):
      ARM: imx: cpuidle-imx6sx: Restrict the SW2ISO increase to i.MX6SX
      can: flexcan: Remove unneeded registration message
      staging: iio: adt7316: Fix build errors when GPIOLIB is not set

Faiz Abbas (2):
      ARM: dts: am57xx-idk: Remove support for voltage switching for SD car=
d
      ARM: dts: dra76x: Update MMC2_HS200_MANUAL1 iodelay values

Farhan Ali (1):
      vfio-ccw: Destroy kmem cache region on module exit

Fei Li (1):
      tun: wake up waitqueues after IFF_UP is set

Filipe Manana (2):
      Btrfs: fix race between block group removal and block group allocatio=
n
      Btrfs: fix failure to persist compression property xattr deletion on =
fsync

Florian Fainelli (3):
      soc: brcmstb: Fix error path for unsupported CPUs
      soc: bcm: brcmstb: biuctrl: Register writes require a barrier
      ARM: dts: bcm: Add missing device_type =3D "memory" property

Fred Klassen (1):
      net/udp_gso: Allow TX timestamp with UDP GSO

Gal Pressman (2):
      RDMA/efa: Fix success return value in case of error
      RDMA/efa: Handle mmap insertions overflow

Gao Xiang (1):
      staging: erofs: add requirements field in superblock

Gavin Schenk (1):
      MAINTAINERS / Documentation: Thorsten Scherer is the successor
of Gavin Schenk

George Wilkie (1):
      mpls: fix warning with multi-label encap

Govindarajulu Varadarajan (1):
      net: handle 802.1P vlan 0 packets properly

Guenter Roeck (1):
      s390/ctl_reg: mark __ctl_set_bit and __ctl_clear_bit as __always_inli=
ne

Guillaume Nault (2):
      netfilter: ipv6: nf_defrag: fix leakage of unqueued fragments
      netfilter: ipv6: nf_defrag: accept duplicate fragments again

Gustavo A. R. Silva (1):
      mac80211_hwsim: mark expected switch fall-through

Haiyang Zhang (1):
      hv_netvsc: Set probe mode to sync

Hangbin Liu (1):
      selftests/bpf: move test_lirc_mode2_user to TEST_GEN_PROGS_EXTENDED

Hanjun Guo (1):
      MAINTAINERS: Update my email address

Heiko Carstens (1):
      s390/boot: disable address-of-packed-member warning

Ido Schimmel (4):
      mlxsw: spectrum: Use different seeds for ECMP and LAG hash
      mlxsw: spectrum_router: Refresh nexthop neighbour when it becomes dea=
d
      selftests: mlxsw: Test nexthop offload indication
      mlxsw: spectrum: Disallow prio-tagged packets when PVID is removed

Ilya Maximets (1):
      xdp: check device pointer before clearing

Ioana Ciornei (1):
      net: phylink: set the autoneg state in phylink_phy_change

Ivan Vecera (1):
      be2net: Fix number of Rx queues used for flow hashing

J. Bruce Fields (1):
      nfsd: replace Jeff by Chuck as nfsd co-maintainer

Jakub Kicinski (2):
      net: netem: fix backlog accounting for corrupted GSO frames
      net: netem: fix use after free and double free with packet corruption

Jakub Sitnicki (1):
      bpf: sockmap, restore sk_write_space when psock gets dropped

Jan Kundr=C3=A1t (1):
      ARM: mvebu_v7_defconfig: fix Ethernet on Clearfog

Jann Horn (1):
      apparmor: enforce nullbyte at end of tag string

Jason A. Donenfeld (1):
      ARM: 8867/1: vdso: pass --be8 to linker if necessary

Jeff LaBundy (1):
      Input: iqs5xx - get axis info before calling input_mt_init_slots()

Jeremy Sowden (1):
      lapb: fixed leak of control-blocks.

Jia-Ju Bai (1):
      iwlwifi: Fix double-free problems in iwl_req_fw_callback()

JingYi Hou (1):
      net: remove duplicate fetch in sock_getsockopt

Jiong Wang (2):
      selftests: bpf: move sub-register zero extension checks into subreg.c
      selftests: bpf: complete sub-register zero extension checks

Jiri Pirko (2):
      mlxsw: spectrum_flower: Fix TOS matching
      selftests: tc_flower: Add TOS matching test

Joakim Zhang (1):
      can: flexcan: fix timeout when set small bitrate

Johannes Berg (3):
      nl80211: fill all policy .type entries
      iwlwifi: mvm: remove d3_sram debugfs file
      mac80211: drop robust management frames from unknown TA

John Crispin (1):
      mac80211: fix rate reporting inside cfg80211_calculate_bitrate_he()

John Fastabend (2):
      bpf: sockmap, fix use after free from sleep in psock backlog workqueu=
e
      net: tls, correctly account for copied bytes with multiple sk_msgs

John Hurley (1):
      nfp: ensure skb network header is set for packet redirect

John Johansen (1):
      apparmor: fix PROFILE_MEDIATES for untrusted input

Jonathan Lemon (1):
      bpf: lpm_trie: check left child of last leftmost node for NULL

Jouni Malinen (1):
      mac80211: Do not use stack memory with scatterlist for GMAC

Jules Maselbas (1):
      usb: dwc2: Use generic PHY width in params setup

Julian Wiedmann (3):
      net/af_iucv: remove GFP_DMA restriction for HiperTransport
      net/af_iucv: build proper skbs for HiperTransport
      net/af_iucv: always register net_device notifier

Kaike Wan (1):
      IB/hfi1: Validate fault injection opcode user input

Keerthy (5):
      ARM: dts: dra76x: Disable rtc target module
      ARM: dts: dra76x: Disable usb4_tm target module
      ARM: dts: dra71x: Disable rtc target module
      ARM: dts: dra71x: Disable usb4_tm target module
      ARM: dts: dra72x: Disable usb4_tm target module

Kees Cook (1):
      lib/test_stackinit: Handle Clang auto-initialization pattern

Kevin Hilman (1):
      RISC-V: defconfig: enable clocks, serial console

Krzesimir Nowak (1):
      tools: bpftool: Fix JSON output when lookup fails

Krzysztof Kozlowski (1):
      net: hns3: Fix inconsistent indenting

Lin Yi (1):
      net :sunrpc :clnt :Fix xps refcount imbalance on the error path

Linus Torvalds (1):
      Linux 5.2-rc6

Linus Walleij (1):
      net: dsa: rtl8366: Fix up VLAN filtering

Lior Cohen (1):
      iwlwifi: mvm: change TLC config cmd sent by rs to be async

Liran Alon (1):
      KVM: x86: Modify struct kvm_nested_state to have explicit fields for =
data

Logan Gunthorpe (1):
      PCI/P2PDMA: Ignore root complex whitelist when an IOMMU is present

Lorenz Bauer (1):
      bpf: fix out-of-bounds read in __bpf_skc_lookup

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c controller

Luca Coelho (1):
      cfg80211: use BIT_ULL in cfg80211_parse_mbssid_data()

Luke Nelson (1):
      bpf, riscv: clear high 32 bits for ALU32 add/sub/neg/lsh/rsh/arsh

Manikanta Pubbisetty (1):
      {nl,mac}80211: allow 4addr AP operation on crypto controlled devices

Marcel Holtmann (1):
      Bluetooth: Fix regression with minimum encryption key size alignment

Mariusz Tkaczyk (1):
      md: fix for divide error in status_resync

Martin KaFai Lau (4):
      bpf: Check sk_fullsock() before returning from bpf_sk_lookup()
      bpf: udp: ipv6: Avoid running reuseport's bpf_prog from __udp6_lib_er=
r
      bpf: udp: Avoid calling reuseport's bpf_prog from udp_gro
      bpf: net: Set sk_bpf_storage back to NULL for cloned sk

Martynas Pumputis (2):
      bpf: simplify definition of BPF_FIB_LOOKUP related flags
      bpf: sync BPF_FIB_LOOKUP flag changes with BPF uapi

Masanari Iida (1):
      linux-next: DOC: RDS: Fix a typo in rds.txt

Mathias Nyman (2):
      usb: xhci: Don't try to recover an endpoint if port is in error state=
.
      xhci: detect USB 3.2 capable host controllers correctly

Matt Chen (1):
      iwlwifi: fix AX201 killer sku loading firmware issue

Matt Mullins (1):
      bpf: fix nested bpf tracepoints with per-cpu data

Matteo Croce (3):
      samples, bpf: suppress compiler warning
      mpls: fix af_mpls dependencies
      mpls: fix af_mpls dependencies for real

Mauro S. M. Rodrigues (1):
      bnx2x: Check if transceiver implements DDM before access

Maxim Mikityanskiy (1):
      wireless: Skip directory when generating certificates

Maxime Chevallier (3):
      net: ethtool: Allow matching on vlan DEI bit
      net: mvpp2: prs: Fix parser range for VID filtering
      net: mvpp2: prs: Use the correct helpers when removing all VID filter=
s

Melissa Wen (1):
      staging:iio:ad7150: fix threshold mode config bit

Michael Neuling (1):
      KVM: PPC: Book3S HV: Fix r3 corruption in h_set_dabr()

Michael Schmitz (1):
      net: phy: rename Asix Electronics PHY driver

Michal Rostecki (1):
      libbpf: Return btf_fd for load_sk_storage_btf

Mika Westerberg (2):
      thunderbolt: Make sure device runtime resume completes before
taking domain lock
      thunderbolt: Implement CIO reset correctly for Titan Ridge

Mike Marciniszyn (9):
      IB/hfi1: Close PSM sdma_progress sleep window
      IB/hfi1: Correct tid qp rcd to match verbs context
      IB/hfi1: Avoid hardlockup with flushlist_lock
      IB/hfi1: Silence txreq allocation warnings
      IB/hfi1: Create inline to get extended headers
      IB/hfi1: Use aborts to trigger RC throttling
      IB/hfi1: Wakeup QPs orphaned on wait list after flush
      IB/hfi1: Handle wakeup of orphaned QPs for pio
      IB/hfi1: Handle port down properly in pio

Mike Rapoport (1):
      arm64/mm: don't initialize pgd_cache twice

Mike Salvatore (1):
      apparmor: reset pos on failure to unpack for various functions

Miklos Szeredi (2):
      Revert "fuse: require /dev/fuse reads to have enough buffer capacity"
      ovl: don't fail with disconnected lower NFS

Mordechay Goodstein (1):
      cfg80211: util: fix bit count off by one

Naftali Goldstein (1):
      mac80211: do not start any work during reconfigure flow

Naohiro Aota (1):
      btrfs: start readahead also in seed devices

Nathan Chancellor (1):
      rsi: Properly initialize data in rsi_sdio_ta_reset

Nathan Huckleberry (1):
      net: mvpp2: debugfs: Add pmap to fs dump

Naveen N. Rao (2):
      bpf: fix div64 overflow tests to properly detect errors
      powerpc/bpf: use unsigned division instruction for 64-bit operations

Neil Horman (1):
      sctp: Free cookie before we memdup a new one

Nick Hu (1):
      riscv: Fix udelay in RV32.

Nicolas Schier (1):
      ovl: fix typo in MODULE_PARM_DESC

Nilesh Javali (2):
      scsi: qedi: Check targetname while finding boot target information
      scsi: qedi: update driver version to 8.37.0.20

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix module autoload with inet family

Paolo Bonzini (1):
      KVM: nVMX: reorganize initial steps of vmx_set_nested_state

Patrick Havelange (1):
      counter/ftm-quaddec: Add missing dependencies in Kconfig

Paul Walmsley (5):
      arch: riscv: add support for building DTB files from DT source data
      dt-bindings: riscv: sifive: add YAML documentation for the SiFive FU5=
40
      dt-bindings: riscv: convert cpu binding to json-schema
      riscv: dts: add initial support for the SiFive FU540-C000 SoC
      riscv: dts: add initial board data for the SiFive HiFive Unleashed

Peter Chen (1):
      usb: chipidea: udc: workaround for endpoint conflict issue

Peter Xu (1):
      Revert "iommu/vt-d: Fix lock inversion between iommu->lock and
device_domain_lock"

Petr Machata (1):
      mlxsw: spectrum_buffers: Reduce pool size on Spectrum-2

Pradeep Kumar Chitrapu (1):
      mac80211: free peer keys before vif down in mesh

Qian Cai (1):
      drm/vmwgfx: fix a warning due to missing dma_parms

Raed Salem (1):
      net/mlx5e: Fix source port matching in fdb peer flow rule

Rafael J. Wysocki (1):
      PCI: PM: Skip devices in D0 for suspend-to-idle

Randy Dunlap (1):
      Documentation/networking: fix af_xdp.rst Sphinx warnings

Rasmus Villemoes (1):
      net: dsa: mv88e6xxx: fix shift of FID bits in mv88e6185_g1_vtu_loadpu=
rge()

Raul E Rangel (1):
      mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning

Ravi Chandra Sadineni (1):
      Input: elan_i2c - increment wakeup count if wake source

Reinhard Speyerer (4):
      qmi_wwan: add support for QMAP padding in the RX path
      qmi_wwan: add network device usage statistics for qmimux devices
      qmi_wwan: avoid RCU stalls on device disconnect when in QMAP mode
      qmi_wwan: extend permitted QMAP mux_id value range

Robert Hancock (1):
      net: dsa: microchip: Don't try to read stats for unused ports

Rolf Eike Beer (1):
      riscv: remove unused barrier defines

Ronnie Sahlberg (3):
      cifs: fix panic in smb2_reconnect
      cifs: add spinlock for the openFileList to cifsInodeInfo
      cifs: fix GlobalMid_Lock bug in cifs_reconnect

Russell King - ARM Linux admin (1):
      net: phylink: further mac_config documentation improvements

Sean Christopherson (1):
      KVM: x86/mmu: Allocate PAE root array when using SVM's 32-bit NPT

Sean Nyekjaer (2):
      dt-bindings: can: mcp251x: add mcp25625 support
      can: mcp251x: add support for mcp25625

Shahar S Matityahu (2):
      iwlwifi: clear persistence bit according to device family
      iwlwifi: print fseq info upon fw assert

Shay Agroskin (1):
      net/mlx5e: Replace reciprocal_scale in TX select queue function

ShihPo Hung (1):
      riscv: mm: synchronize MMU after pte change

Srinivas Kandagatla (3):
      soundwire: stream: fix out of boundary access on port properties
      soundwire: stream: fix bad unlock balance
      soundwire: intel: set dai min and max channels correctly

Stanislaw Gruszka (2):
      rtw88: fix subscript above array bounds compiler warning
      rtw88: avoid circular locking between local->iflist_mtx and rtwdev->m=
utex

Stanley Chu (1):
      scsi: ufs: Avoid runtime suspend possibly being blocked forever

Stefan Wahren (1):
      MAINTAINERS: Update Stefan Wahren email address

Stefano Brivio (2):
      vxlan: Don't assume linear buffers in error handler
      geneve: Don't assume linear buffers in error handler

Stephen Barber (1):
      vsock/virtio: set SOCK_DONE on peer shutdown

Stephen Suryaputra (1):
      vrf: Increment Icmp6InMsgs on the original netdev

Steve French (1):
      SMB3: retry on STATUS_INSUFFICIENT_RESOURCES instead of failing write

Steve Longerbeam (3):
      gpu: ipu-v3: image-convert: Fix input bytesperline width/height align
      gpu: ipu-v3: image-convert: Fix input bytesperline for packed formats
      gpu: ipu-v3: image-convert: Fix image downsize coefficients

Sunil Muthuswamy (1):
      hvsock: fix epollout hang from race condition

Suraj Jitindar Singh (2):
      KVM: PPC: Book3S HV: Only write DAWR[X] when handling h_set_dawr
in real mode
      KVM: PPC: Book3S HV: Invalidate ERAT when flushing guest TLB entries

Taehee Yoo (1):
      net: openvswitch: do not free vport if register_netdevice() is failed=
.

Takashi Iwai (4):
      mwifiex: Fix possible buffer overflows at parsing bss descriptor
      mwifiex: Abort at too short BSS descriptor element
      mwifiex: Fix heap overflow in mwifiex_uap_parse_tail_ies()
      docs: fb: Add TER16x32 to the available font names

Teresa Remmet (1):
      ARM: dts: am335x phytec boards: Fix cd-gpios active level

Thomas Falcon (3):
      ibmvnic: Do not close unopened driver during reset
      ibmvnic: Refresh device multicast list after reset
      ibmvnic: Fix unchecked return codes of memory allocations

Thomas Gleixner (65):
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 226
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 230
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 231
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 232
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 233
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 234
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 235
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 237
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 238
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 239
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 243
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 244
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 245
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 246
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 247
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 248
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 250
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 451
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 452
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 454
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 455
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 456
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 457
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 459
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 460
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 461
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 462
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 463
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 464
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 465
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 466
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 467
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 468
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 469
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 471
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 472
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 473
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 474
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 475
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 477
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 479
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 480
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 481
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 482
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 484
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 485
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 486
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 487
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 488
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 489
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 490
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 491
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 495
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 496
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 497
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 498
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 499
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 500
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 501
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 502
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 503
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 504
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 505
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 506
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 507

Thomas Hellstrom (2):
      drm/vmwgfx: Use the backdoor port if the HB port is not available
      drm/vmwgfx: Honor the sg list segment size limitation

Thomas Pedersen (1):
      mac80211: mesh: fix RCU warning

Todd Kjos (1):
      binder: fix possible UAF when freeing buffer

Tony Lindgren (3):
      ARM: dts: Configure osc clock for d_can on am335x
      bus: ti-sysc: Handle devices with no control registers
      ARM: dts: Drop bogus CLKSEL for timer12 on dra7

Toshiaki Makita (3):
      bpf, devmap: Fix premature entry free on destroying map
      bpf, devmap: Add missing bulk queue free
      bpf, devmap: Add missing RCU read lock on flush

Trond Myklebust (1):
      SUNRPC: Fix a credential refcount leak

Tuong Lien (1):
      tipc: fix issues with early FAILOVER_MSG from peer

Ulf Hansson (1):
      mmc: core: Prevent processing SDIO IRQs when the card is suspended

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Don't clobber M/N values during fastset check

Viresh Kumar (1):
      KVM: arm64: Implement vq_present() as a macro

Vitaly Kuznetsov (1):
      KVM: nVMX: use correct clean fields when copying from eVMCS

Vlad Buslov (1):
      net: sched: flower: don't call synchronize_rcu() on mask creation

Weinan Li (1):
      drm/i915/gvt: ignore unexpected pvinfo write

Will Deacon (1):
      MAINTAINERS: Update my email address to use @kernel.org

Willem de Bruijn (2):
      can: purge socket error queue on sock destruct
      net: correct udp zerocopy refcnt also when zerocopy only on append

Wolfram Sang (2):
      mmc: sdhi: disallow HS400 for M3-W ES1.2, RZ/G2M, and V3H
      mmc: core: complete HS400 before checking status

Xin Long (4):
      tipc: purge deferredq list for each grp member in tipc_group_delete
      ip_tunnel: allow not to count pkts on tstats by setting skb's dev to =
NULL
      ip6_tunnel: allow not to count pkts on tstats by passing dev as NULL
      tipc: pass tunnel dev as NULL to udp_tunnel(6)_xmit_skb

Yan-Hsuan Chuang (1):
      rtw88: fix unassigned rssi_level in rtw_sta_info

Yang Yingliang (1):
      doc: fix documentation about UIO_MEM_LOGICAL using

Yibo Zhao (1):
      mac80211: only warn once on chanctx_conf being NULL

Young Xiao (1):
      nfc: Ensure presence of required attributes in the
deactivate_target handler

Yu Wang (1):
      mac80211: handle deauthentication/disassociation from TDLS peer

Yuchung Cheng (1):
      tcp: fix undo spurious SYNACK in passive Fast Open

YueHaibing (5):
      arm64: imx: Fix build error without CONFIG_SOC_BUS
      mac80211: remove set but not used variable 'old'
      rtw88: Make some symbols static
      arm64: arch_k3: Fix kconfig dependency warning
      can: af_can: Fix error path of can_init()

jjian zhou (2):
      mmc: mediatek: fix SDIO IRQ interrupt handle flow
      mmc: mediatek: fix SDIO IRQ detection issue

yangerkun (1):
      quota: fix a problem about transfer quota
