Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5BECA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 21:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E7F218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 21:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571608123;
	bh=W5qPy3ytAiXv5Ngdg4oLihiEZONL8QjVFf8tAXTKVkA=;
	h=From:Date:Subject:To:List-ID:From;
	b=Sr918HmyoBi5WiriPbUoUy8QAT+X1dL4LoxcrOy0zPBuF7MLO75+3sRG1OwY/CY9Y
	 u0WPHu6eMl1Q+oqCRPDTmqlNY8PZ8ij8h3ft6qHN9kuZDlagcvI6VPFWzfq8BOQJXC
	 DgbJXwQBK17N0jKTViF3ClK82qJsg4OSF4/AyazI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfJTVsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 17:48:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34092 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfJTVsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 17:48:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id f5so725953lfp.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zJRcEoWOCnFdQesbhYcztNSaovU/yECTquUW0cvlM1E=;
        b=Frf4hmQHYzcs6+hLsdkazu9uKUBOdehkEIxNzGgvMGYib6VHSi5SJaLqx5SRjJ0EaD
         3NYi3bxXGTfKatXlekIq5KmPMYkBYPV2nYwTU46XI9CGAdNBZ8pdM9q7BJ++ZjjBTVOj
         oBC7oSYRBwiX8dm5pM1s0u1NsEOke5QrMIwG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zJRcEoWOCnFdQesbhYcztNSaovU/yECTquUW0cvlM1E=;
        b=RRiSMSHXt/iBYw6mUalCZuLRbaRDg1W2/F+KpTqGmCcgppP59Xy5wW7JFwyPCHTUHa
         4jQIsoMBjPJroSwA6c+qx4LkGeHhh1Y3WsOpCphGVZTGtclfpMSmrQGsZ8s7tn9l0vOv
         4ToleW8dpOV+Ju+6hAD98isE/Vaj5QV5SsPb6KnKVviVQQoVNKQYVTpXn0PgtCc4Ueok
         bW1zhRTQfn3ivel5I1mJCnr53prmAel8F9VKbqnjAivVscRqKKdKWfJHFjB8uQJ+LlXW
         k1F7a1LHOPBOHIV7z2Z91OxUDdzJV9oUr328ln+eLK+CoOjEZTBUHp5fURhljraoxJWV
         59ag==
X-Gm-Message-State: APjAAAXCZzR76Eczwsvt1h9tHb9yWM+kuU266WZ/3qkm+NK/1TTgXqhA
        QjKYjvobqIZMEw1Bhd3OwD+yT4xOJv3nqQ==
X-Google-Smtp-Source: APXvYqyA16hI0oeQg3cIRzqH2iF66OPmobj8hdtIZO8A2r/aCqFrvMMUc+Gpqbh/ONq6Bpb6CApbnw==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr12332238lfn.12.1571608110798;
        Sun, 20 Oct 2019 14:48:30 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 202sm5540125ljf.75.2019.10.20.14.48.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 14:48:26 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y3so11199674ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 14:48:26 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr12682214ljf.133.1571608105180;
 Sun, 20 Oct 2019 14:48:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Oct 2019 17:48:09 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh3jhffc0u7s5n=-zUFpztuh+0Hfth4vwuyfc5SpBmvSA@mail.gmail.com>
Message-ID: <CAHk-=wh3jhffc0u7s5n=-zUFpztuh+0Hfth4vwuyfc5SpBmvSA@mail.gmail.com>
Subject: Linux 5.4-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This release cycle remains pretty normal. In fact, the rc's have been
a bit on the smaller side of the average of the last few releases, and
rc4 continues this, if only barely.

The stats all look fairly normal too. About half is drivers, with
networking being the bulk of it, but there's stuff all over the place:
drm, input, block, md, gpio, irqchip...

The networking backlog shows up outside of drivers too, with core
networking changes being about a third of the non-driver part of the
patches. But there's the usual arch updates (arm64, x86, xtensa), and
a noticeable chunk of mm fixes from Andrew. And the rest is
miscellaneous all over - Documentation, core kernel, filesystems, gdb
scripting, tools.

But none of it is really all that big or looks all that scary or unusual.

Shortlog appended so that you can scroll through it and get a feeling
for the details.

I'm traveling this week before Open Source Summit Europe, but if
things stay this calm it shouldn't even be noticeable.

                Linus

---

Aaron Komisar (1):
      mac80211: fix scan when operating on DFS channels in ETSI domains

Al Viro (1):
      xtensa: fix {get,put}_user() for 64bit values

Aleksa Sarai (1):
      lib: test_user_copy: style cleanup

Alex Deucher (2):
      drm/amdgpu/powerplay: fix typo in mvdd table setup
      Revert "drm/radeon: Fix EEH during kexec"

Alex Vesker (1):
      net/mlx5: DR, Allow insertion of duplicate rules

Alexander Potapenko (2):
      mm/slub.c: init_on_free=3D1 should wipe freelist ptr for bulk allocat=
ions
      lib/test_meminit: add a kmem_cache_alloc_bulk() test

Alexandra Winter (2):
      s390/qeth: Fix error handling during VNICC initialization
      s390/qeth: Fix initialization of vnicc cmd masks during set online

Alexandre Belloni (2):
      net: lpc_eth: avoid resetting twice
      coccinelle: api/devm_platform_ioremap_resource: remove useless script

Andrea Parri (1):
      x86/hyperv: Set pv_info.name to "Hyper-V"

Andrew Lunn (1):
      net: usb: lan78xx: Connect PHY before registering MAC

Andy Shevchenko (8):
      platform/x86: intel_punit_ipc: Avoid error message when retrieving IR=
Q
      platform/x86: i2c-multi-instantiate: Fail the probe if no IRQ provide=
d
      gpio: merrifield: Restore use of irq_base
      gpiolib: Initialize the hardware with a callback
      gpio: intel-mid: Move hardware initialization to callback
      gpio: lynxpoint: Move hardware initialization to callback
      gpio: merrifield: Move hardware initialization to callback
      gpio: lynxpoint: set default handler to be handle_bad_irq()

Aneesh Kumar K.V (1):
      mm/memunmap: don't access uninitialized memmap in memunmap_pages()

Antonio Borneo (3):
      ptp: fix typo of "mechanism" in Kconfig help text
      net: stmmac: fix length of PTP clock's name string
      net: stmmac: fix disabling flexible PPS output

Ard Biesheuvel (1):
      nvme: retain split access workaround for capability reads

Ben Dooks (4):
      PM: sleep: include <linux/pm_runtime.h> for pm_wq
      kthread: make __kthread_queue_delayed_work static
      mm: include <linux/huge_mm.h> for is_vma_temporary_stack
      mm/filemap.c: include <linux/ramfs.h> for generic_file_vm_ops definit=
ion

Ben Dooks (Codethink) (4):
      davinci_cpdma: make cpdma_chan_split_pool static
      net: stmmac: make tc_flow_parsers static
      net: stmmac: fix argument to stmmac_pcs_ctrl_ane()
      mm/init-mm.c: include <linux/mman.h> for vm_committed_as_batch

Biao Huang (1):
      net: stmmac: disable/enable ptp_ref_clk in suspend/resume flow

Bj=C3=B6rn T=C3=B6pel (1):
      samples/bpf: Fix build for task_fd_query_user.c

Brian Vazquez (2):
      selftests/bpf: test_progs: Don't leak server_fd in tcp_rtt
      selftests/bpf: test_progs: Don't leak server_fd in test_sockopt_inher=
it

Catalin Marinas (1):
      kmemleak: Do not corrupt the object_list during clean-up

Chengguang Xu (1):
      ocfs2: fix error handling in ocfs2_setattr()

Chenwandun (2):
      zram: fix race between backing_dev_show and backing_dev_store
      net: aquantia: add an error handling in aq_nic_set_multicast_list

Chris Wilson (3):
      drm/i915/execlists: Refactor -EIO markup of hung requests
      drm/i915/userptr: Never allow userptr into the mappable GGTT
      drm/i915: Fixup preempt-to-busy vs resubmission of a virtual request

Chris von Recklinghausen (1):
      arm64: Fix kcore macros after 52-bit virtual addressing fallout

Christian K=C3=B6nig (2):
      drm/ttm: fix busy reference in ttm_mem_evict_first
      drm/ttm: fix handling in ttm_bo_add_mem_to_lru

Christophe JAILLET (1):
      memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()=
'

Cong Wang (2):
      net_sched: fix backward compatibility for TCA_KIND
      net_sched: fix backward compatibility for TCA_ACT_KIND

C=C3=A9dric Le Goater (1):
      net/ibmvnic: Fix EOI when running in XIVE mode.

Damien Le Moal (2):
      scsi: core: save/restore command resid for error handling
      block: Fix elv_support_iosched()

Dan Williams (1):
      libata/ahci: Fix PCS quirk application

Daniel Black (1):
      ACPI: HMAT: ACPI_HMAT_MEMORY_PD_VALID is deprecated since ACPI-6.3

Daniel Drake (1):
      ALSA: hda/realtek - Enable headset mic on Asus MJ401TA

Daniel Wagner (1):
      scsi: qla2xxx: Remove WARN_ON_ONCE in qla2x00_status_cont_entry()

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit 0x1050 composition

Darrick J. Wong (1):
      xfs: change the seconds fields in xfs_bulkstat to signed

David Ahern (1):
      net: Update address for vrf and l3mdev in MAINTAINERS

David Hildenbrand (5):
      drivers/base/memory.c: don't access uninitialized memmaps in
soft_offline_page_store()
      fs/proc/page.c: don't access uninitialized memmaps in fs/proc/page.c
      mm/memory-failure.c: don't access uninitialized memmaps in
memory_failure()
      mm/memory_hotplug: don't access uninitialized memmaps in
shrink_pgdat_span()
      hugetlbfs: don't access uninitialized memmaps in
pfn_range_valid_gigantic()

David Howells (7):
      rxrpc: Fix call ref leak
      rxrpc: Fix trace-after-put looking at the put peer record
      rxrpc: Fix trace-after-put looking at the put connection record
      rxrpc: Fix trace-after-put looking at the put call record
      rxrpc: rxrpc_peer needs to hold a ref on the rxrpc_local record
      rxrpc: Fix call crypto state cleanup
      rxrpc: Fix possible NULL pointer access in ICMP handling

David Rientjes (1):
      mm, hugetlb: allow hugepage allocations to reclaim as needed

Davide Caratti (2):
      net: avoid errors when trying to pop MLPS header on non-MPLS packets
      net/sched: fix corrupted L2 header with MPLS 'push' and 'pop' actions

Dmitry Bogdanov (2):
      net: aquantia: do not pass lro session with invalid tcp checksum
      net: aquantia: correctly handle macvlan and multicast coexistence

Dmitry Goldin (1):
      kheaders: substituting --sort in archive creation

Dmitry Torokhov (1):
      rt2x00: remove input-polldev.h header

Dongsheng Yang (1):
      rbd: cancel lock_dwork if the wait is interrupted

Doug Berger (4):
      net: bcmgenet: don't set phydev->link from MAC
      net: phy: bcm7xxx: define soft_reset for 40nm EPHY
      net: bcmgenet: soft reset 40nm EPHYs before MAC init
      net: bcmgenet: reset 40nm EPHY on energy detect

Eric Biggers (5):
      llc: fix sk_buff leak in llc_sap_state_process()
      llc: fix sk_buff leak in llc_conn_service()
      llc: fix another potential sk_buff leak in llc_ui_sendmsg()
      llc: fix sk_buff refcounting in llc_conn_state_process()
      lib/generic-radix-tree.c: add kmemleak annotations

Eric Dumazet (24):
      bonding: fix potential NULL deref in bond_update_slave_arr
      netfilter: conntrack: avoid possible false sharing
      tun: remove possible false sharing in tun_flow_update()
      net: avoid possible false sharing in sk_leave_memory_pressure()
      net: add {READ|WRITE}_ONCE() annotations on ->rskq_accept_head
      tcp: annotate lockless access to tcp_memory_pressure
      net: silence KCSAN warnings around sk_add_backlog() calls
      net: annotate sk->sk_rcvlowat lockless reads
      net: silence KCSAN warnings about sk->sk_backlog.len reads
      tcp: add rcu protection around tp->fastopen_rsk
      tcp: annotate tp->rcv_nxt lockless reads
      tcp: annotate tp->copied_seq lockless reads
      tcp: annotate tp->write_seq lockless reads
      tcp: annotate tp->snd_nxt lockless reads
      tcp: annotate tp->urg_seq lockless reads
      tcp: annotate sk->sk_rcvbuf lockless reads
      tcp: annotate sk->sk_sndbuf lockless reads
      tcp: annotate sk->sk_wmem_queued lockless reads
      hrtimer: Annotate lockless access to timer->base
      tcp: fix a possible lockdep splat in tcp_done()
      net: avoid potential infinite loop in tc_ctl_action()
      rxrpc: use rcu protection while reading sk->sk_user_data
      net: ensure correct skb->tstamp in various fragmenters
      net: reorder 'struct net' fields to avoid false sharing

Evan Green (1):
      Input: synaptics-rmi4 - avoid processing unknown IRQs

Florian Fainelli (3):
      net: dsa: b53: Do not clear existing mirrored port mask
      net: bcmgenet: Set phydev->dev_flags only for internal PHYs
      net: bcmgenet: Fix RGMII_MODE_EN value for GENET v1/2/3

Florin Chiculita (1):
      dpaa2-eth: add irq for the dpmac connect/disconnect event

Geert Uytterhoeven (3):
      mmc: renesas_sdhi: Do not use platform_get_irq() to count interrupts
      mmc: sh_mmcif: Use platform_get_irq_optional() for optional interrupt
      iommu/ipmmu-vmsa: Only call platform_get_irq() when interrupt is mand=
atory

Greentime Hu (1):
      RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_S=
TART

Haim Dreyfuss (1):
      iwlwifi: mvm: force single phy init

Haishuang Yan (1):
      ip6erspan: remove the incorrect mtu limit for ip6erspan

Hans de Goede (2):
      Input: soc_button_array - partial revert of support for newer
surface devices
      drm/amdgpu: Bail earlier when amdgpu.cik_/si_support is not set to 1

Heiko Stuebner (1):
      iommu/rockchip: Don't use platform_get_irq to implicitly count irqs

Heiner Kallweit (1):
      r8169: fix jumbo packet handling on resume from suspend

Helge Deller (3):
      MAINTAINERS: Add hp_sdc drivers to parisc arch
      parisc: sysctl.c: Use CONFIG_PARISC instead of __hppa_ define
      parisc: Fix vmap memory leak in ioremap()/iounmap()

Himanshu Madhani (1):
      scsi: MAINTAINERS: Update qla2xxx driver

Honglei Wang (1):
      mm: memcg: get number of pages on the LRU list in memcgroup base
on lru_zone_size

Ido Schimmel (1):
      mlxsw: spectrum_trap: Push Ethernet header before reporting trap

Igor Russkikh (2):
      net: aquantia: temperature retrieval fix
      net: aquantia: when cleaning hw cache it should be toggled

Ilya Leoshkevich (1):
      scripts/gdb: fix debugging modules on s390

Ioana Radulescu (1):
      dpaa2-eth: Fix TX FQID values

Jacob Keller (1):
      net: update net_dim documentation after rename

Jakub Kicinski (2):
      net: netem: fix error path for corrupted GSO frames
      net: netem: correct the parent's backlog when corrupted packet was dr=
opped

Jane Chu (1):
      mm/memory-failure: poison read receives SIGKILL instead of
SIGBUS if mmaped more than once

Jean Delvare (1):
      firmware: dmi: Fix unlikely out-of-bounds read in save_mem_devices

Jeff Layton (1):
      ceph: just skip unrecognized info in ceph_reply_info_extra

Jeffrey Hugo (1):
      drm/msm/dsi: Implement reset correctly

Jens Axboe (1):
      io_uring: fix up O_NONBLOCK handling for sockets

Jiri Benc (2):
      selftests/bpf: Set rp_filter in test_flow_dissector
      selftests/bpf: More compatible nc options in test_lwt_ip_encap

Joel Colledge (1):
      scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set

Joerg Roedel (1):
      iommu/amd: Check PM_LEVEL_SIZE() condition in locked section

Johan Hovold (1):
      NFC: pn533: fix use-after-free and memleaks

Johannes Berg (3):
      mac80211: accept deauth frames in IBSS mode
      iwlwifi: pcie: fix indexing in command dump for new HW
      iwlwifi: pcie: fix rb_allocator workqueue allocation

John Garry (1):
      ACPI: CPPC: Set pcc_data[pcc_ss_id] to NULL in acpi_cppc_processor_ex=
it()

John Hubbard (2):
      mm/gup_benchmark: add a missing "w" to getopt string
      mm/gup: fix a misnamed "write" argument, and a related bug

Jose Abreu (3):
      net: stmmac: selftests: Check if filtering is available before runnin=
g
      net: stmmac: gmac4+: Not all Unicast addresses may be available
      net: stmmac: selftests: Fix L2 Hash Filter test

Juergen Gross (1):
      xen/netback: fix error path of xenvif_connect_data()

Julien Grall (1):
      arm64: cpufeature: Treat ID_AA64ZFR0_EL1 as RAZ when SVE is not enabl=
ed

Julien Thierry (1):
      arm64: entry.S: Do not preempt from IRQ before all cpufeatures are en=
abled

KP Singh (1):
      samples/bpf: Add a workaround for asm_inline

Kai-Heng Feng (3):
      ALSA: hda/realtek: Reduce the Headphone static noise on XPS 9350/9360
      drm/edid: Add 6 bpc quirk for SDC panel in Lenovo G50
      Revert "Input: elantech - enable SMBus on new (2018+) systems"

Karsten Graul (2):
      net/smc: receive returns without data
      net/smc: receive pending data after RCV_SHUTDOWN

Keith Busch (5):
      nvme-pci: Free tagset if no IO queues
      nvme: Remove ADMIN_ONLY state
      nvme: Restart request timers in resetting state
      nvme: Prevent resets during paused controller state
      nvme: Wait for reset state when required

Kevin Hao (1):
      nvme-pci: Set the prp2 correctly when using more than 4k page

Kirill A. Shutemov (3):
      proc/meminfo: fix output alignment
      mm/thp: fix node page state in split_huge_page_to_list()
      mm/thp: allow dropping THP from page cache

Konstantin Khlebnikov (1):
      mm/memcontrol: update lruvec counters in mem_cgroup_move_account

Linus Torvalds (3):
      sparc64: disable fast-GUP due to unexplained oopses
      filldir[64]: remove WARN_ON_ONCE() for bad directory entries
      Linux 5.4-rc4

Liu Xiang (1):
      iommu/arm-smmu: Free context bitmap in the err path of
arm_smmu_init_domain_context

Luca Coelho (4):
      iwlwifi: don't access trans_cfg via cfg
      iwlwifi: fix ACPI table revision checks
      iwlwifi: exclude GEO SAR support for 3168
      iwlwifi: pcie: change qu with jf devices to use qu configuration

Lukas Wunner (1):
      ALSA: hda - Force runtime PM on Nvidia HDMI codecs

Magnus Karlsson (1):
      xsk: Fix crash in poll when device does not support ndo_xsk_wakeup

Mahesh Bandewar (2):
      blackhole_netdev: fix syzkaller reported issue
      Revert "blackhole_netdev: fix syzkaller reported issue"

Mans Rullgard (1):
      net: ethernet: dwmac-sun8i: show message only when switching to promi=
sc

Marc Zyngier (5):
      irqchip/sifive-plic: Switch to fasteoi flow
      arm64: KVM: Trap VM ops when ARM64_WORKAROUND_CAVIUM_TX2_219_TVM is s=
et
      arm64: Enable workaround for Cavium TX2 erratum 219 when running SMT
      arm64: Avoid Cavium TX2 erratum 219 when switching TTBR
      arm64: Allow CAVIUM_TX2_ERRATUM_219 to be selected

Marco Felsch (1):
      Input: da9063 - fix capability and drop KEY_SLEEP

Marek Vasut (4):
      net: dsa: microchip: Do not reinit mutexes on KSZ87xx
      net: dsa: microchip: Add shared regmap mutex
      net: phy: micrel: Discern KSZ8051 and KSZ8795 PHYs
      net: phy: micrel: Update KSZ87xx PHY name

Mario Limonciello (1):
      ACPI: PM: Drop Dell XPS13 9360 from LPS0 Idle _DSM blacklist

Mark Rutland (2):
      arm64: mm: fix inverted PAR_EL1.F check
      stop_machine: Avoid potential race behaviour

MarkLee (2):
      net: ethernet: mediatek: Fix MT7629 missing GMII mode support
      arm: dts: mediatek: Update mt7629 dts to reflect the latest dt-bindin=
g

Masahiro Yamada (1):
      kbuild: update comment about KBUILD_ALLDIRS

Max Filippov (5):
      xtensa: clean up assembly arguments in uaccess macros
      xtensa: fix type conversion in __get_user_[no]check
      xtensa: drop EXPORT_SYMBOL for outs*/ins*
      xtensa: virt: fix PCI IO ports mapping
      xtensa: fix change_bit in exclusive access option

Max Gurtovoy (2):
      nvmet-loop: fix possible leakage during error flow
      nvme-tcp: fix possible leakage during error flow

Miaoqing Pan (1):
      ath10k: fix latency issue for QCA988x

Michael Ellerman (1):
      usercopy: Avoid soft lockups in test_check_nonzero_user()

Michael S. Tsirkin (3):
      tools/virtio: more stubs
      tools/virtio: xen stub
      vhost/test: stop device before reset

Michael Tretter (1):
      macb: propagate errors when getting optional clocks

Michael Vassernis (1):
      mac80211_hwsim: fix incorrect dev_alloc_name failure goto

Mike Rapoport (1):
      mm: memblock: do not enforce current limit for memblock_phys* family

Mikulas Patocka (3):
      dm snapshot: introduce account_start_copy() and account_end_copy()
      dm snapshot: rework COW throttling to fix deadlock
      dm cache: fix bugs when a GFP_NOWAIT allocation fails

Naftali Goldstein (1):
      iwlwifi: mvm: fix race in sync rx queue notification

Navid Emamdoost (3):
      nl80211: fix memory leak in nl80211_get_ftm_responder_stats
      iwlwifi: dbg_ini: fix memory leak in alloc_sgtable
      iwlwifi: pcie: fix memory leaks in iwl_pcie_ctxt_info_gen3_init

Nick Desaulniers (1):
      parisc: prefer __section from compiler_attributes.h

Nicolas Dichtel (1):
      netns: fix NLM_F_ECHO mechanism for RTM_NEWNSID

Nicolas Saenz Julienne (1):
      mmc: sdhci-iproc: fix spurious interrupts on Multiblock reads with bc=
m2711

Nishad Kamdar (3):
      net: dsa: microchip: Use the correct style for SPDX License Identifie=
r
      net: cavium: Use the correct style for SPDX License Identifier
      net: dsa: sja1105: Use the correct style for SPDX License Identifier

Oliver Neukum (2):
      scsi: sd: Ignore a failure to sync cache due to lack of authorization
      usb: hso: obey DMA rules in tiocmget

Paul Walmsley (2):
      riscv: dts: HiFive Unleashed: add default chosen/stdout-path
      riscv: tlbflush: remove confusing comment on local_flush_tlb_all()

Pavel Tatashin (1):
      arm64: hibernate: check pgd table allocation

Qian Cai (2):
      mm/slub: fix a deadlock in show_slab_objects()
      mm/page_owner: don't access uninitialized memmaps when reading
/proc/pagetypeinfo

Qiang Yu (1):
      dma-buf/resv: fix exclusive fence get

Rafael J. Wysocki (3):
      cpufreq: Avoid cpufreq_suspend() deadlock on system shutdown
      PCI: PM: Fix pci_power_up()
      ACPI: processor: Avoid NULL pointer dereferences at init time

Rander Wang (1):
      ALSA: hdac: clear link output stream mapping

Randy Dunlap (10):
      Doc: networking/device_drivers/pensando: fix ionic.rst warnings
      phylink: fix kernel-doc warnings
      fs/direct-io.c: fix kernel-doc warning
      fs/libfs.c: fix kernel-doc warning
      fs/fs-writeback.c: fix kernel-doc warning
      bitmap.h: fix kernel-doc warning and typo
      xarray.h: fix kernel-doc warning
      mm/slab.c: fix kernel-doc warning for __ksize()
      scripts: setlocalversion: fix a bashism
      net: ethernet: broadcom: have drivers select DIMLIB as needed

Robin Murphy (2):
      iommu/io-pgtable-arm: Correct Mali attributes
      iommu/io-pgtable-arm: Support all Mali configurations

Roman Gushchin (1):
      mm: memcg/slab: fix panic in __free_slab() caused by premature
memcg pointer release

Roman Kagan (1):
      x86/hyperv: Make vapic support x2apic mode

Sagi Grimberg (1):
      nvme: fix possible deadlock when nvme_update_formats fails

Sandeep Sheriker Mallikarjun (1):
      irqchip/atmel-aic5: Add support for sam9x60 irqchip

Sara Sharon (1):
      cfg80211: fix a bunch of RCU issues in multi-bssid code

Sean Christopherson (1):
      x86/apic/x2apic: Fix a NULL pointer deref when handling a dying cpu

Sean Wang (1):
      net: Update address for MediaTek ethernet driver in MAINTAINERS

Sebastian Andrzej Siewior (1):
      nvme-tcp: Initialize sk->sk_ll_usec only with NET_RX_BUSY_POLL

Shannon Nelson (1):
      ionic: fix stats memory dereference

Shuah Khan (1):
      tools: bpf: Use !building_out_of_srctree to determine srctree

Song Liu (2):
      md/raid0: fix warning message for parameter default_layout
      kernel/events/uprobes.c: only do FOLL_SPLIT_PMD for uprobe register

Stanislaw Gruszka (1):
      rt2x00: initialize last_reset

Stefano Brivio (1):
      ipv4: Return -ENETUNREACH if we can't create route but saddr is valid

Stefano Garzarella (2):
      vsock/virtio: send a credit update when buffer size is changed
      vsock/virtio: discard packets if credit is not respected

Steffen Maier (3):
      scsi: core: fix missing .cleanup_rq for SCSI hosts without
request batching
      scsi: core: fix dh and multipathing for SCSI hosts without
request batching
      scsi: zfcp: fix reaction on bit error threshold notification

Steve Wahl (2):
      x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area
      x86/boot/64: Round memory hole size up to next PMD page

Steven Price (2):
      drm/panfrost: Add missing GPU feature registers
      drm/panfrost: Handle resetting on timeout better

Suthikulpanit, Suravee (1):
      iommu/amd: Fix incorrect PASID decoding from event log

Sven Schnelle (1):
      parisc: Remove 32-bit DMA enforcement from sba_iommu

Szabolcs Sz=C5=91ke (1):
      ALSA: usb-audio: Disable quirks for BOSS Katana amplifiers

Talel Shenhar (1):
      irqchip/al-fic: Add support for irq retrigger

Tejun Heo (2):
      blkcg: Fix multiple bugs in blkcg_activate_policy()
      blk-rq-qos: fix first node deletion of rq_qos_del()

Thomas Bogendoerfer (1):
      net: i82596: fix dma_alloc_attr for sni_82596

Thomas Hellstrom (1):
      drm/ttm: Restore ttm prefaulting

Ulf Magnusson (1):
      drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER

Ursula Braun (1):
      net/smc: fix SMCD link group creation with VLAN id

Valentin Vidic (1):
      net: usb: sr9800: fix uninitialized local variable

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Favor last VBT child device with conflicting AUX ch/DDC pin

Vincent Chen (1):
      riscv: remove the switch statement in do_trap_break()

Vinicius Costa Gomes (2):
      net: taprio: Fix returning EINVAL when configuring without flags
      sched: etf: Fix ordering of packets with same txtime

Vivien Didelot (1):
      net: dsa: fix switch tree list

Vlastimil Babka (4):
      mm, page_owner: fix off-by-one error in __set_page_owner_handle()
      mm, page_owner: decouple freeing stack trace from debug_pagealloc
      mm, page_owner: rename flag indicating that page is allocated
      mm, compaction: fix wrong pfn handling in __reset_isolation_pfn()

Wei Wang (1):
      ipv4: fix race condition between route lookup and invalidation

Will Deacon (3):
      mac80211: Reject malformed SSID elements
      cfg80211: wext: avoid copying malformed SSIDs
      arm64: tags: Preserve tags for addresses translated via TTBR1

William Kucharski (1):
      mm/vmscan.c: support removing arbitrary sized pages from mapping

Xiaojie Yuan (1):
      drm/amdgpu/sdma5: fix mask value of POLL_REGMEM packet for pipe sync

Xin Long (2):
      sctp: add chunks to sk_backlog when the newsk sk_socket is not set
      sctp: change sctp_prot .no_autobind with true

Yang Yingliang (1):
      arm64: sysreg: fix incorrect definition of SYS_PAR_EL1_F

Yauhen Kharuzhy (1):
      Input: goodix - add support for 9-bytes reports

Yi Li (1):
      ocfs2: fix panic due to ocfs2_wq is null

Yonghong Song (1):
      libbpf: handle symbol versioning properly for libbpf.a

Yonglong Liu (2):
      net: phy: Fix "link partner" information disappear issue
      net: hns3: fix mis-counting IRQ vector numbers issue

YueHaibing (3):
      dm clone: Make __hash_find static
      act_mirred: Fix mirred_init_module error handling
      netdevsim: Fix error handling in nsim_fib_init and nsim_fib_exit

Zenghui Yu (1):
      irqchip/gic-v3: Fix GIC_LINE_NR accessor

Zhenzhong Duan (1):
      x86/boot/acpi: Move get_cmdline_acpi_rsdp() under #ifdef guard

yangerkun (2):
      io_uring: consider the overflow of sequence for timeout req
      io_uring: fix logic error in io_timeout

yu kuai (1):
      platform/x86: classmate-laptop: remove unused variable
