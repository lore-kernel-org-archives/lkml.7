Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7726AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D37B206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 00:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573432457;
	bh=fzcUnV1+Wyf9soXINFZyhZAiGXENgMnkI7YrKiNZmCI=;
	h=From:Date:Subject:To:List-ID:From;
	b=HtO37Z2jqtmt2dAq/1ryKKq9zM7Jq+b2pC4jCDE0x01M6kSKATCSsSeZWmcoMt4+k
	 RISsfOmu7AbEYoBJ9MAV1GqrZvEJkMJ5nUDRoOMhaIWgEWcTRvZdktfJn+ZUDVAvqa
	 t/CwS90upOr49hVXfj6huxBzvc1zARs8ibydD+fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKKAeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 19:34:15 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:37514 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfKKAeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 19:34:14 -0500
Received: by mail-lj1-f182.google.com with SMTP id d5so2351405ljl.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 16:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q+iePR/pfUIM4LLy09ReTMr4TZ3CocMq4WBSMlw9tmQ=;
        b=F+m2GH/3uQrIYE1bcIQTJ3/VvIyIWeS+Ymkn4MaOfo9X2uDoIZeYLn95koxQSNegkd
         n17vCItrhmvJJItSmy42HSFl4qq3B2PPTju8ffT/SVdY1sLWrsP7ce2ujFdRtekbn4Vt
         P1p1nHPpuWJiASVcJ6Lyp6iL6fHG6aXChnaoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q+iePR/pfUIM4LLy09ReTMr4TZ3CocMq4WBSMlw9tmQ=;
        b=TRxt85GTzFpI6Zb9RdQUkdOf5mgtokNW3kCiHZ/NH8ttNKN9g9RwfY/5w5WENjLKvo
         1UbglFzQ5Hol/gq8sBpNpy9zTF2F14nXsne2tKTMdlBQjOqL4OZkWMuuLwWiv381ORCm
         0CUR5RktTv6Mi5Mnlq3rteuI+QjjtlSd/IHuT+mjiaOSkLsNzH+UprlnjCHg0CvDN/fl
         PaZcO7kZejZfzEfL9rrw+6vvBf0q24KkyRYZRxemZDePtN2R3kYth1WPY8NQxUgrnpCY
         TUoL/VHF2Pc6MAAatXtzAjINmIo8GguJueZuLRqFhFxk6p48TeLgj755qO7YfqV9lr0A
         V6QQ==
X-Gm-Message-State: APjAAAUhkjqsqMCqIRmmY8CQmORAY8J193lssyn1pqvS35nUkTWbWS92
        omMPAREKRcima2H7krcpG9F1WVr2GNI=
X-Google-Smtp-Source: APXvYqz5v1AZa2ze1hrVh8mpMaZfMCrWYOF9ANrV/9Flsp9OvhFaAkDJ81IQacHVUCcYpDfg6MWw2g==
X-Received: by 2002:a2e:8518:: with SMTP id j24mr3788758lji.13.1573432448733;
        Sun, 10 Nov 2019 16:34:08 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e14sm8149778ljb.75.2019.11.10.16.34.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 16:34:07 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id b20so8461164lfp.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 16:34:07 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr1672188lfl.170.1573432446874;
 Sun, 10 Nov 2019 16:34:06 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 16:33:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivmGEOTha5XkRHgH6VwfiroiN+PFVMNK3B0r-d0eFLPQ@mail.gmail.com>
Message-ID: <CAHk-=wivmGEOTha5XkRHgH6VwfiroiN+PFVMNK3B0r-d0eFLPQ@mail.gmail.com>
Subject: Linux 5.4-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another rc.   Nothing looks all that scary, but we
definitely do have more changes than I would wish for.

In terms of pure lines of code, we have the new 'vboxsf' staging
driver, but ignoring that (and you should) everything looks normal.
Except we've got closer to 300 non-merge commits, and I really wish we
didn't have that many.

It's all over the place - about 55% is drivers (and that's ignoring
the vboxsf thing), the rest is networking, misc filesystem fixes
(octfs2, btrfs, ceph), arch updates (x86, arm64), tooling fixes, and
some core kernel and vm fixes.

Nothing looks _bad_, but there is too much of it.

So I'm leaning towards an rc8 being likely next weekend due to that,
but I won't make a final decision yet. We'll see.

Last time around, v5.3-rc7 was even bigger. We did do an rc8 for that
one (although there were other reasons for that rc8).

We'll see how this week goes and how I feel about it next Sunday.
Maybe I'll feel like there's no reason to do an rc8 at that point.

But it would be lovely if you all went out and kicked the tires and
tested it all out..

              Linus

---

Adam Ford (1):
      ARM: dts: imx6-logicpd: Re-enable SNVS power key

Ahmed Zaki (1):
      mac80211: fix station inactive_time shortly after boot

Al Viro (2):
      ceph: fix RCU case handling in ceph_d_revalidate()
      ceph: add missing check in d_revalidate snapdir handling

Aleksander Morgado (1):
      net: usb: qmi_wwan: add support for DW5821e with eSIM support

Alex Deucher (3):
      drm/amdgpu/arcturus: properly set BANK_SELECT and FRAGMENT_SIZE
      drm/amdgpu/renoir: move gfxoff handling into gfx9 module
      drm/radeon: fix si_enable_smc_cac() failed issue

Alex Vesker (2):
      net/mlx5: DR, Fix memory leak in modify action destroy
      net/mlx5: DR, Fix memory leak during rule creation

Alexander Shishkin (4):
      intel_th: gth: Fix the window switching sequence
      intel_th: msu: Fix an uninitialized mutex
      intel_th: pci: Add Comet Lake PCH support
      intel_th: pci: Add Jasper Lake PCH support

Alexander Sverdlin (1):
      net: ethernet: octeon_mgmt: Account for second possible VLAN header

Alexandre Belloni (1):
      clk: at91: avoid sleeping early

Alexandru Ardelean (1):
      iio: imu: adis16480: make sure provided frequency is positive

Amelie Delaunay (3):
      ARM: dts: stm32: remove OV5640 pinctrl definition on stm32mp157c-ev1
      ARM: dts: stm32: change joystick pinctrl definition on stm32mp157c-ev=
1
      pinctrl: stmfx: fix valid_mask init sequence

Andreas Klinger (1):
      iio: srf04: fix wrong limitation in distance measuring

Andy Shevchenko (2):
      pinctrl: intel: Avoid potential glitches if pin is in GPIO mode
      pinctrl: cherryview: Allocate IRQ chip dynamic

Anson Huang (1):
      watchdog: imx_sc_wdt: Pretimeout should follow SCU firmware format

Anton Eidelman (1):
      nvme-multipath: fix crash in nvme_mpath_clear_ctrl_paths

Appana Durga Kedareswara rao (1):
      can: xilinx_can: Fix flags field initialization for axi can

Arkadiusz Kubalewski (1):
      i40e: Fix for ethtool -m issue on X722 NIC

Arnd Bergmann (1):
      watchdog: cpwd: fix build regression

Bard Liao (1):
      soundwire: intel: fix intel_register_dai PDI offsets and numbers

Ben Dooks (1):
      soc: imx: gpc: fix initialiser format

Bj=C3=B6rn T=C3=B6pel (3):
      perf tools: Make usage of test_attr__* optional for perf-sys.h
      samples/bpf: fix build by setting HAVE_ATTR_TEST to zero
      bpf: Change size to u64 for bpf_map_{area_alloc, charge_init}()

Catalin Marinas (1):
      arm64: Do not mask out PTE_RDONLY in pte_same()

Charles Machalow (1):
      nvme: change nvme_passthru_cmd64 to explicitly mark rsvd

Cheng-Yi Chiang (1):
      ASoC: rockchip: rockchip_max98090: Enable SHDN to fix headset detecti=
on

Christian Brauner (1):
      clone3: validate stack arguments

Christophe Roullier (1):
      ARM: dts: stm32: Fix CAN RAM mapping on stm32mp157c

Chuhong Yuan (1):
      net: fec: add missed clk_disable_unprepare in remove

Claudiu Manoil (2):
      net: mscc: ocelot: don't handle netdev events for other netdevs
      net: mscc: ocelot: fix NULL pointer on LAG slave removal

Colin Ian King (6):
      clk: sunxi-ng: a80: fix the zero'ing of bits 16 and 18
      intel_th: msu: Fix missing allocation failure check on a kstrndup
      intel_th: msu: Fix overflow in shift of an unsigned int
      can: j1939: fix resource leak of skb on error return paths
      staging: vboxsf: fix dereference of pointer dentry before it is
null checked
      ice: fix potential infinite loop because loop counter being too small

Corentin Labbe (1):
      lib: Remove select of inexistant GENERIC_IO

Dan Carpenter (2):
      netfilter: ipset: Fix an error code in ip_set_sockfn_get()
      block: drbd: remove a stray unlock in __drbd_send_protocol()

Daniel Borkmann (1):
      bpf, doc: Add Andrii as official reviewer to BPF subsystem

David Ahern (1):
      ipv4: Fix table id reference in fib_sync_down_addr

David Hildenbrand (1):
      mm/memory_hotplug: fix updating the node span

David Sterba (1):
      btrfs: un-deprecate ioctls START_SYNC and WAIT_SYNC

Dmytro Linkin (1):
      net/mlx5e: Use correct enum to determine uplink port

Dotan Barak (1):
      mlx4_core: fix wrong comment about the reason of subtract one
from the max_cqes

Doug Berger (3):
      net: bcmgenet: use RGMII loopback for MAC reset
      Revert "net: bcmgenet: soft reset 40nm EPHYs before MAC init"
      net: bcmgenet: reapply manual settings to the PHY

Dragos Tarcatu (1):
      ASoC: SOF: topology: Fix bytes control size checks

Eric Dumazet (5):
      powerpc/bpf: Fix tail call implementation
      dccp: do not leak jiffies on the wire
      net: prevent load/store tearing on sk->sk_stamp
      ipv6: fixes rt6_probe() and fib6_nh->last_probe init
      net: fix data-race in neigh_event_send()

Eugen Hristev (1):
      clk: at91: sam9x60: fix programmable clock

Evan Quan (1):
      drm/amdgpu: register gpu instance before fan boost feature enablment

Fabien Parent (1):
      clocksource/drivers/mediatek: Fix error handling

Fabio Estevam (1):
      ARM: dts: imx6qdl-sabreauto: Fix storm of accelerometer interrupts

Fabrice Gasnier (1):
      iio: adc: stm32-adc: fix stopping dma

Fernando Fernandez Mancera (1):
      netfilter: nf_tables: fix unexpected EOPNOTSUPP error

Filipe Manana (1):
      Btrfs: fix race leading to metadata space leak after task received si=
gnal

Florian Fainelli (1):
      net: dsa: bcm_sf2: Fix driver removal

Florian Westphal (1):
      bridge: ebtables: don't crash when using dnat target in output chains

Geert Uytterhoeven (2):
      clocksource/drivers/sh_mtu2: Do not loop using platform_get_irq_by_na=
me()
      fbdev: c2p: Fix link failure on non-inlining

Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Hans de Goede (3):
      pinctrl: cherryview: Fix irq_valid_mask calculation
      staging: Add VirtualBox guest shared folder (vboxsf) support
      HID: i2c-hid: Send power-on command after reset

Heiner Kallweit (1):
      r8169: fix page read in r8168g_mdio_read

Honggang Li (1):
      configfs: calculate the depth of parent item

Huacai Chen (1):
      timekeeping/vsyscall: Update VDSO data unconditionally

Huazhong Tan (1):
      net: hns3: add compatible handling for command HCLGE_OPC_PF_RST_DONE

Ilya Leoshkevich (2):
      bpf: Allow narrow loads of bpf_sysctl fields with offset > 0
      scripts/gdb: fix debugging modules compiled with hot/cold partitionin=
g

Imre Deak (1):
      drm/i915: Avoid HPD poll detect triggering a new detect cycle

Ivan Khoronzhuk (1):
      taprio: fix panic while hw offload sched list swap

Jacob Keller (1):
      igb/igc: use ktime accessors for skb->tstamp

Jakub Kicinski (4):
      net/tls: fix sk_msg trim on fallback to copy mode
      net/tls: don't pay attention to sk_write_pending when pushing
partial records
      net/tls: add a TX lock
      selftests/tls: add test for concurrent recv and send

Jan Beulich (1):
      x86/apic/32: Avoid bogus LDR warnings

Jason Gerecke (1):
      HID: wacom: generic: Treat serial number and related fields as unsign=
ed

Jason Gunthorpe (1):
      mm/mmu_notifiers: use the right return code for WARN_ON

Jay Vosburgh (1):
      bonding: fix state transition issue in link monitoring

Jayachandran C (1):
      MAINTAINERS: update Cavium ThunderX2 maintainers

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix no data on MPU6050

Jeff Layton (2):
      ceph: don't try to handle hashed dentries in non-O_CREAT atomic_open
      ceph: return -EINVAL if given fsc mount option on kernel w/o support

Jeroen Hofstee (10):
      can: peak_usb: report bus recovery as well
      can: c_can: D_CAN: c_can_chip_config(): perform a sofware reset on op=
en
      can: c_can: C_CAN: add bus recovery events
      can: rx-offload: can_rx_offload_irq_offload_timestamp(): continue on =
error
      can: ti_hecc: ti_hecc_stop(): stop the CPK on down
      can: ti_hecc: keep MIM and MD set
      can: ti_hecc: release the mailbox a bit earlier
      can: ti_hecc: add fifo overflow error reporting
      can: ti_hecc: properly report state changes
      can: ti_hecc: add missing state changes

Jerome Brunet (1):
      ASoC: hdmi-codec: drop mutex locking again

Jessica Yu (1):
      scripts/nsdeps: make sure to pass all module source files to spatch

Jiada Wang (1):
      ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma address

Jiri Olsa (1):
      perf tools: Fix time sorting

Jiri Slaby (1):
      stacktrace: Don't skip first entry on noncurrent tasks

Joakim Zhang (1):
      can: flexcan: disable completely the ECC mechanism

Joel Stanley (1):
      clk: ast2600: Fix enabling of clocks

Johan Hovold (3):
      can: mcba_usb: fix use-after-free on disconnect
      can: usb_8dev: fix use-after-free on disconnect
      can: peak_usb: fix slab info leak

Johannes Berg (1):
      mac80211: fix ieee80211_txq_setup_flows() failure path

Johannes Weiner (2):
      mm/page_alloc.c: ratelimit allocation failure warnings more aggressiv=
ely
      mm: memcontrol: fix network errors from failing __GFP_ATOMIC charges

John Hubbard (1):
      mm/gup_benchmark: fix MAP_HUGETLB case

John Hurley (1):
      net: sched: prevent duplicate flower rules from tcf_proto destroy rac=
e

Jorge Ramirez-Ortiz (1):
      watchdog: pm8916_wdt: fix pretimeout registration flow

Jose Abreu (11):
      net: stmmac: gmac4: bitrev32 returns u32
      net: stmmac: xgmac: bitrev32 returns u32
      net: stmmac: selftests: Prevent false positives in filter tests
      net: stmmac: xgmac: Only get SPH header len if available
      net: stmmac: xgmac: Fix TSA selection
      net: stmmac: xgmac: Fix AV Feature detection
      net: stmmac: xgmac: Disable Flow Control when 1 or more queues are in=
 AV
      net: stmmac: xgmac: Disable MMC interrupts by default
      net: stmmac: Fix the packet count in stmmac_rx()
      net: stmmac: Fix TSO descriptor with Enhanced Addressing
      net: stmmac: Fix the TX IOC in xmit path

Josef Bacik (1):
      btrfs: save i_size to avoid double evaluation of i_size_read in
compress_file_range

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/dp: Do not switch aux to TBT mode for non-TC ports

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix nla_policies to fully support NL_VALIDATE_STRIC=
T

Kai Vehmanen (2):
      ASoC: hdac_hda: fix race in device removal
      ALSA: hda: hdmi - add Tigerlake support

Kevin Hao (1):
      dump_stack: avoid the livelock of the dump_lock

Kevin Wang (1):
      drm/amd/swSMU: fix smu workload bit map error

Keyon Jie (1):
      ASoC: SOF: Intel: hda-stream: fix the CONFIG_ prefix missing

Kishon Vijay Abraham I (1):
      reset: Fix memory leak in reset_control_array_put()

Kurt Van Dijck (1):
      can: c_can: c_can_poll(): only read status register after status IRQ

Leonard Crestez (2):
      interconnect: qcom: Fix icc_onecell_data allocation
      clk: imx8m: Use SYS_PLL1_800M as intermediate parent of CLK_ARM

Linus Torvalds (1):
      Linux 5.4-rc7

Linus Walleij (3):
      Revert "gpio: merrifield: Move hardware initialization to callback"
      Revert "gpio: merrifield: Restore use of irq_base"
      Revert "gpio: merrifield: Pass irqchip when adding gpiochip"

Lucas Stach (1):
      arm64: dts: zii-ultra: fix ARM regulator GPIO handle

Luis Henriques (2):
      ceph: fix use-after-free in __ceph_remove_cap()
      ceph: don't allow copy_file_range when stripe_count !=3D 1

Lukas Wunner (1):
      netfilter: nf_tables: Align nft_expr private data to 64-bit

Magnus Karlsson (2):
      i40e: need_wakeup flag might not be set for Tx
      ixgbe: need_wakeup flag might not be set for Tx

Manish Chopra (1):
      qede: fix NULL pointer deref in __qede_remove()

Marc Kleine-Budde (8):
      can: rx-offload: can_rx_offload_queue_sorted(): fix error
handling, avoid skb mem leak
      can: rx-offload: can_rx_offload_queue_tail(): fix error
handling, avoid skb mem leak
      can: rx-offload: can_rx_offload_offload_one(): do not increase
the skb_queue beyond skb_queue_len_max
      can: rx-offload: can_rx_offload_offload_one(): increment
rx_fifo_errors on queue overflow or OOM
      can: rx-offload: can_rx_offload_offload_one(): use ERR_PTR() to
propagate error value in case of errors
      can: rx-offload: can_rx_offload_irq_offload_fifo(): continue on error
      can: flexcan: increase error counters if skb enqueueing via
can_rx_offload_queue_sorted() fails
      can: ti_hecc: ti_hecc_error(): increase error counters if skb
enqueueing via can_rx_offload_queue_sorted() fails

Marek Szyprowski (3):
      clk: samsung: exynos5433: Fix error paths
      clk: samsung: exynos542x: Move G3D subsystem clocks to its sub-CMU
      clk: samsung: exynos5420: Preserve PLL configuration during suspend/r=
esume

Martin Blumenstingl (1):
      clk: meson: gxbb: let sar_adc_clk_div set the parent clock rate

Matthew Wilcox (Oracle) (5):
      XArray: Fix xas_next() with a single entry at 0
      idr: Fix idr_get_next_ul race with idr_remove
      radix tree: Remove radix_tree_iter_find
      idr: Fix integer overflow in idr_for_each_entry
      idr: Fix idr_alloc_u32 on 32-bit systems

Matti Vaittinen (1):
      watchdog: bd70528: Add MODULE_ALIAS to allow module auto loading

Max Gurtovoy (1):
      nvme-rdma: fix a segmentation fault during module unload

Mel Gorman (1):
      mm, meminit: recalculate pcpu batch and high limits after init comple=
tes

Michael Zhivich (1):
      x86/tsc: Respect tsc command line paraemeter for clocksource_tsc_earl=
y

Michal Hocko (2):
      mm, vmstat: hide /proc/pagetypeinfo from normal users
      mm, vmstat: reduce zone->lock holding time by /proc/pagetypeinfo

Michal Suchanek (2):
      soundwire: depend on ACPI
      soundwire: depend on ACPI || OF

Mika Westerberg (3):
      thunderbolt: Read DP IN adapter first two dwords in one go
      thunderbolt: Fix lockdep circular locking depedency warning
      thunderbolt: Drop unnecessary read when writing LC command in Ice Lak=
e

Nathan Chancellor (1):
      clk: sunxi: Fix operator precedence in sunxi_divs_clk_setup

Navid Emamdoost (3):
      ASoC: SOF: Fix memory leak in sof_dfsentry_write
      ASoC: SOF: ipc: Fix memory leak in sof_set_get_large_ctrl_data
      can: gs_usb: gs_can_open(): prevent memory leak

Neil Armstrong (2):
      clk: meson: g12a: fix cpu clock rate setting
      clk: meson: g12a: set CLK_MUX_ROUND_CLOSEST on the cpu clock muxes

Nicholas Nunley (1):
      iavf: initialize ITRN registers with correct values

Nishad Kamdar (1):
      net: hns3: Use the correct style for SPDX License Identifier

Oleksij Rempel (3):
      can: j1939: fix memory leak if filters was set
      can: j1939: transport: j1939_session_fresh_new(): make sure EOMA
is send with the total message size set
      can: j1939: transport: j1939_xtp_rx_eoma_one(): Add sanity check
for correct total message size

Oliver Neukum (1):
      CDC-NCM: handle incomplete transfer of MTU

Olivier Moysan (1):
      ASoC: stm32: sai: add restriction on mmap support

Ondrej Jirman (2):
      ARM: dts: sun8i-a83t-tbs-a711: Fix WiFi resume from suspend
      ARM: sunxi: Fix CPU powerdown on A83T

Pablo Neira Ayuso (3):
      netfilter: nf_tables_offload: check for register data length mismatch=
es
      netfilter: nf_tables: bogus EOPNOTSUPP on basechain update
      netfilter: nf_tables_offload: skip EBUSY on chain update

Pan Bian (3):
      NFC: fdp: fix incorrect free object
      NFC: st21nfca: fix double free
      nfc: netlink: fix double device reference drop

Patrice Chotard (1):
      ARM: dts: stm32: relax qspi pins slew-rate for stm32mp157

Pavel Shilovsky (1):
      SMB3: Fix persistent handles reconnect

Peter Ujfalusi (2):
      ASoC: ti: sdma-pcm: Add back the flags parameter for non
standard dma names
      clk: ti: dra7-atl-clock: Remove ti_clk_add_alias call

Peter Zijlstra (1):
      sched: Fix pick_next_task() vs 'change' pattern race

Philipp Zabel (4):
      reset: fix of_reset_simple_xlate kerneldoc comment
      reset: fix of_reset_control_get_count kerneldoc comment
      reset: fix reset_control_lookup kerneldoc comment
      reset: fix reset_control_get_exclusive kerneldoc comment

Pierre-Louis Bossart (1):
      soundwire: slave: fix scanf format

Qais Yousef (1):
      sched/core: Fix compilation error when cgroup not selected

Qu Wenruo (2):
      btrfs: Consider system chunk array size for new SYSTEM chunks
      btrfs: tree-checker: Fix wrong check on max devid

Randy Dunlap (1):
      reset: fix reset_control_ops kerneldoc comment

Rob Clark (1):
      drm/atomic: fix self-refresh helpers crtc state dereference

Rob Herring (1):
      drm/shmem: Add docbook comments for drm_gem_shmem_object madvise fiel=
ds

Roi Dayan (1):
      net/mlx5e: Fix eswitch debug print of max fdb flow

Roman Gushchin (1):
      mm: slab: make page_cgroup_ino() to recognize non-compound slab
pages properly

Russell King (2):
      ASoC: kirkwood: fix external clock probe defer
      ASoC: kirkwood: fix device remove ordering

Salil Mehta (1):
      net: hns: Fix the stray netpoll locks causing deadlock in NAPI path

Sean Tranchetti (1):
      net: qualcomm: rmnet: Fix potential UAF when unregistering

Shakeel Butt (1):
      mm: memcontrol: fix NULL-ptr deref in percpu stats flush

Shengjiu Wang (2):
      arm64: dts: imx8mm: fix compatible string for sdma
      arm64: dts: imx8mn: fix compatible string for sdma

Shirish S (1):
      drm/amdgpu: dont schedule jobs while in reset

Shuah Khan (1):
      tools: gpio: Use !building_out_of_srctree to determine srctree

Shuning Zhang (1):
      ocfs2: protect extent tree in ocfs2_prepare_inode_for_write()

Song Liu (1):
      MAINTAINERS: update information for "MEMORY MANAGEMENT"

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix invalid EPB setting

Stefano Brivio (1):
      netfilter: ipset: Copy the right MAC address in hash:ip,mac IPv6 sets

Stefano Garzarella (1):
      vsock/virtio: fix sock refcnt holding during the shutdown

Stephan Gerhold (1):
      ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2 MUX

Stephane Grosjean (1):
      can: peak_usb: fix a potential out-of-sync while decoding packets

Steven Rostedt (VMware) (2):
      perf scripting engines: Iterate on tep event arrays directly
      perf tools: Remove unused trace_find_next_event()

Takashi Iwai (2):
      ALSA: hda/ca0132 - Fix possible workqueue stall
      ALSA: timer: Fix incorrectly assigned timer instance

Takashi Sakamoto (1):
      ALSA: bebob: fix to detect configured source of sampling clock
for Focusrite Saffire Pro i/o series

Tariq Toukan (1):
      Documentation: TLS: Add missing counter description

Tejun Heo (2):
      blkcg: make blkcg_print_stat() print stats only for online blkgs
      cgroup,writeback: don't switch wbs immediately on dead wbs if
the memcg is dead

Thomas Gleixner (1):
      x86/dumpstack/64: Don't evaluate exception stacks before setup

Tianci.Yin (1):
      drm/amdgpu: add navi14 PCI ID

Timo Schl=C3=BC=C3=9Fler (1):
      can: mcp251x: mcp251x_restart_work_handler(): Fix potential
force_quit race condition

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      net/fq_impl: Switch to kvmalloc() for memory allocation

Tony Lindgren (1):
      clk: ti: clkctrl: Fix failed to enable error with double udelay timeo=
ut

Ursula Braun (1):
      net/smc: fix ethernet interface refcounting

Uwe Kleine-K=C3=B6nig (1):
      pwm: bcm-iproc: Prevent unloading the driver module while in use

Ville Syrj=C3=A4l=C3=A4 (1):
      mm/khugepaged: fix might_sleep() warn with CONFIG_HIGHPTE=3Dy

Vitaly Wool (1):
      zswap: add Vitaly to the maintainers list

Vladimir Oltean (1):
      net: mscc: ocelot: fix __ocelot_rmw_ix prototype

Wei Yongjun (2):
      intel_th: msu: Fix possible memory leak in mode_store()
      staging: Fix error return code in vboxsf_fill_super()

Wen Yang (1):
      can: dev: add missing of_node_put() after calling of_get_child_by_nam=
e()

Xiaochen Shen (1):
      x86/resctrl: Prevent NULL pointer dereference when reading mondata

Xiaojun Sang (1):
      ASoC: compress: fix unsigned integer overflow check

Xingyu Chen (1):
      watchdog: meson: Fix the wrong value of left time

Yang Shi (1):
      mm: thp: handle page cache THP correctly in PageTransCompoundMap

Yegor Yefremov (1):
      can: don't use deprecated license identifiers

Yi Wang (1):
      irq/irqdomain: Update __irq_domain_alloc_fwnode() function documentat=
ion

Yong Zhi (1):
      ASoC: max98373: replace gpio_request with devm_gpio_request

Yuantian Tang (1):
      arm64: dts: ls1028a: fix a compatible issue

YueHaibing (1):
      staging: vboxsf: Remove unused including <linux/version.h>

Zhan Liu (2):
      drm/amd/display: Add ENGINE_ID_DIGD condition check for Navi14
      Revert "drm/amd/display: setting the DIG_MODE to the correct value."

changzhu (2):
      drm/amdgpu: add dummy read by engines for some GCVM status
registers in gfx10
      drm/amdgpu: add warning for GRBM 1-cycle delay issue in gfx9
