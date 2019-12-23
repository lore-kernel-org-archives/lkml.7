Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0655C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CEB206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577063713;
	bh=SSeixU2R9H6raWjl3TSzUY2pzCc5d7ixHZq2Atr0Y40=;
	h=From:Date:Subject:To:List-ID:From;
	b=dhGQs4RmcU+mjWykxlH8ryFjkZFb0v/gGJD/YHFjG2RM4aqhpwZ4NG1X5pvxaNQxY
	 NLUAzEiFCxpGoLsOGifLAH0xkjq6idLuEMDG3HM59SPjzMjEZKurym8edFC7xW4zKP
	 Vq3+bSwyfcK1wkAKJaCnmNUQu5PPS4ljj0qL8jKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWBPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:15:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40869 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLWBPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:15:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so16167338ljk.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PjRc2VMN4QyAeS5KdyTYuairaIR8bgNKq0V09CDGWYI=;
        b=d7w35FXiwZmFcVTmbAcR7zTYbAG8BbJiwCY2oaQGAKMirMRzrh/fZWDA1FOyPQAWIM
         9PRUEQloUlTuzKOMhGcIVa8p4bOKEVBbxZrkMpwhO3K4Il63vYfyjiwAyY42/OmbMuqt
         v+h1acQB3DI+hZRSgAvAbCB36F3+Kuxtb975Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PjRc2VMN4QyAeS5KdyTYuairaIR8bgNKq0V09CDGWYI=;
        b=Ryg1ktCKDh2nDiQWqzu97wneNytQ22eKfePsgb96B2+7TlWtLomOz84FA8j0jrQgIJ
         nefv+oE+ou+bUFmjf+wpg5GQWsTBCeJCL9X3t1Fn1nsnmxq4c0TwcnFg2dbtj1c57Wu0
         bOHwVZmTPbKlTj5owY+nNu8MZ2qz2y09zIvpMLaG3rnZux2ndd4Zj/hvhfSI3yB4O9Fe
         0s41rOZNl6q4CE5istkrqFzFrbYc6of2ZDB6tWrr3825bmx3GR7qGGadAs0qYKAa466U
         aWM3RAqiHO+kpPHJYY8ydlncu4dAAo2vY2ZWNXoykB9d+wYUm5jROgmqGhh0yYqoSmWD
         wvzQ==
X-Gm-Message-State: APjAAAXb4elRe5sJP0+mJEKRKxHXkb56lygK8SHy+pPkK0edexKkY1C8
        L/Xp3hR0XleLrl247VHh6ytn1sLGSa8=
X-Google-Smtp-Source: APXvYqx9GdDygHdICfpkLxddnkzcKlKwj1ugQNkH7OHEpWzu0MxaRZpVzeL3OOH3HdJ4Xq1Uz30l0Q==
X-Received: by 2002:a2e:9243:: with SMTP id v3mr8220103ljg.73.1577063705704;
        Sun, 22 Dec 2019 17:15:05 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id s1sm1723315ljc.3.2019.12.22.17.15.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 17:15:04 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id y1so11323195lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 17:15:04 -0800 (PST)
X-Received: by 2002:a19:23cb:: with SMTP id j194mr15374172lfj.79.1577063703842;
 Sun, 22 Dec 2019 17:15:03 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Dec 2019 17:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGKfWeUv294FD6bs4cw0m=nO_LdZkLz-vkp-2zwBzLcA@mail.gmail.com>
Message-ID: <CAHk-=wiGKfWeUv294FD6bs4cw0m=nO_LdZkLz-vkp-2zwBzLcA@mail.gmail.com>
Subject: Linux 5.5-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A normal rc release schedule, delayed perhaps a couple of hours by
xmas preparations on my side.

But the Christmas prep doesn't seem to have (yet) impacted the actual
development - it's bigger than rc2 was. Of course, "rc3 is bigger than
rc2" is almost always true, but this time it's quite a bit bigger, and
just looking at commit counts, this is one of the bigger rc3's we've
had in quite a while.

I'm going to assume it's just the usual fluctuation due to timing of
pull requests - we certainly have a bit of everything in there in rc3.
The diffstat is pretty much all obver the place, with drivers (net,
gpu, sound, pinctrl, usb, etc) only just edging out all the tooling
changes (selftest additions and perf).

But there's filesystems (xfs and btrfs and some core fixes too),
there's core networking and arch updates, and there's doc updates etc.
Just the shortlog is a thousand lines - still barely small enough to
be included here, but it's a slog to scroll through if you want to
really see an overview of all the details.

Anyway, I'm hoping rc3 is a one-off. In fact, with the holiday season
coming up, I'd be very surprised indeed if it wasn't. So I suspect
things will calm down a lot over the next coupld of weeks, but please
do use the down-time to do some extra testing instead, ok?

               Linus

---

Aditya Pakki (3):
      rfkill: Fix incorrect check to avoid NULL pointer dereference
      nfc: s3fwrn5: replace the assertion with a WARN_ON
      xen/grant-table: remove multiple BUG_ON on gnttab_interface

Adrian Hunter (3):
      perf inject: Fix processing of ID index for injected instruction trac=
ing
      mmc: sdhci: Workaround broken command queuing on Intel GLK
      mmc: sdhci: Add a quirk for broken command queuing

Alex Williamson (1):
      iommu/vt-d: Set ISA bridge reserved region as relaxable

Alexander Lobakin (1):
      net, sysctl: Fix compiler warning when only cBPF is present

Alexander Shishkin (6):
      perf/x86/intel/bts: Fix the use of page_private()
      perf/x86/intel: Fix PT PMI handling
      intel_th: pci: Add Comet Lake PCH-V support
      intel_th: pci: Add Elkhart Lake SOC support
      intel_th: Fix freeing IRQs
      intel_th: msu: Fix window switching without windows

Alexandre Belloni (1):
      clk: at91: fix possible deadlock

Alexandre Torgue (1):
      pinctrl: pinmux: fix a possible null pointer in
pinmux_can_be_used_for_gpio

Alexei Starovoitov (2):
      bpf: Make BPF trampoline use register_ftrace_direct() API
      selftests/bpf: Test function_graph tracer and bpf trampoline together

Amery Song (1):
      ASoC: Intel: common: work-around incorrect ACPI HID for CML boards

Anand Jain (1):
      btrfs: send: remove WARN_ON for readonly mount

Anders Kaseorg (1):
      Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ detection"

Andi Kleen (10):
      perf cpumap: Maintain cpumaps ordered and without dups
      perf evlist: Maintain evlist->all_cpus
      perf evsel: Add iterator to iterate over events ordered by CPU
      perf evsel: Add functions to close evsel on a CPU
      perf stat: Use affinity for closing file descriptors
      perf stat: Factor out open error handling
      perf stat: Use affinity for opening events
      perf stat: Use affinity for reading
      perf evsel: Add functions to enable/disable for a specific CPU
      perf stat: Use affinity for enabling/disabling events

Andreas F=C3=A4rber (1):
      btrfs: tree-checker: Fix error format string for size_t

Andreas Kemnade (2):
      ARM: dts: e60k02: fix power button
      regulator: rn5t618: fix module aliases

Andreas Schwab (1):
      riscv: Fix use of undefined config option CONFIG_CONFIG_MMU

Andrew Donnellan (1):
      powerpc: Fix __clear_user() with KUAP enabled

Andrew Jeffery (1):
      pinctrl: aspeed-g6: Fix LPC/eSPI mux configuration

Andrey Ryabinin (1):
      kasan: fix crashes on access to memory mapped by vm_map_ram()

Andy Shevchenko (5):
      efi/earlycon: Remap entire framebuffer after page initialization
      pinctrl: baytrail: Update North Community pin list
      pinctrl: baytrail: Add GPIO <-> pin mapping ranges via callback
      pinctrl: baytrail: Pass irqchip when adding gpiochip
      platform/x86: pcengines-apuv2: Spelling fixes in the driver

Animesh Manna (1):
      drm/i915/dsb: Fix in mmio offset calculation of DSB instance

Antoine Tenart (2):
      of: mdio: export of_mdiobus_child_is_phy
      net: macb: fix probing of PHY not described in the dt

Ard Biesheuvel (2):
      efi/memreserve: Register reservations as 'reserved' in /proc/iomem
      efi: Don't attempt to map RCI2 config table if it doesn't exist

Arnaldo Carvalho de Melo (15):
      perf machine: Fill map_symbol->maps in append_inlines() to fix segfau=
lt
      perf bench: Update the copies of x86's mem{cpy,set}_64.S
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers uapi: Sync linux/fscrypt.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers UAPI: Sync sched.h with the kernel
      perf beauty: Add CLEAR_SIGHAND support for clone's flags arg
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      perf kvm: Clarify the 'perf kvm' -i and -o command line options
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers
      tools headers kvm: Sync linux/kvm.h with the kernel sources
      perf arch: Make the default get_cpuid() return compatible error
      perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS

Arnd Bergmann (6):
      bpf: Fix build in minimal configurations, again
      ARM: mmp: include the correct cputype.h
      ptp: clockmatrix: add I2C dependency
      net: ethernet: ti: select PAGE_POOL for switchdev driver
      net: ethernet: ti: build cpsw-common for switchdev
      net: dsa: ocelot: add NET_VENDOR_MICROSEMI dependency

Arthur Kiyanovski (2):
      net: ena: fix default tx interrupt moderation interval
      net: ena: fix issues in setting interrupt moderation params in ethtoo=
l

Arvind Sankar (4):
      efi/gop: Return EFI_NOT_FOUND if there are no usable GOPs
      efi/gop: Return EFI_SUCCESS if a usable GOP was found
      efi/gop: Fix memory leak in __gop_query32/64()
      efi: Fix efi_loaded_image_t::unload type

Bart Van Assche (2):
      block: Fix the type of 'sts' in bsg_queue_rq()
      block: Fix a lockdep complaint triggered by request queue flushing

Bartosz Golaszewski (1):
      regulator: max77650: add of_match table

Ben Dooks (Codethink) (1):
      net: dsa: make unexported dsa_link_touch() static

Ben Hutchings (1):
      net: qlogic: Fix error paths in ql_alloc_large_buffers()

Brendan Higgins (3):
      Documentation: kunit: fix typos and gramatical errors
      Documentation: kunit: add documentation for kunit_tool
      staging: axis-fifo: add unspecified HAS_IOMEM dependency

Brian Foster (2):
      xfs: stabilize insert range start boundary to avoid COW writeback rac=
e
      xfs: use bitops interface for buf log item AIL flag check

Brian Gianforcaro (1):
      io_uring: fix stale comment and a few typos

Chan Shu Tak, Alex (1):
      llc2: Fix return statement of llc_stat_ev_rx_null_dsap_xid_c (and _te=
st_c)

Changbin Du (1):
      lib/Kconfig.debug: fix some messed up configurations

Chaotian Jing (1):
      mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode

Charles Keepax (2):
      spi: cadence: Correct handling of native chipselect
      spi: dw: Correct handling of native chipselect

Charles McLachlan (1):
      sfc: Include XDP packet headroom in buffer step size.

Chen Wandun (2):
      habanalabs: remove variable 'val' set but not used
      xfs: Make the symbol 'xfs_rtalloc_log_count' static

Chris Wilson (3):
      drm/i915: Copy across scheduler behaviour flags across submit fences
      drm/i915: Set fence_work.ops before dma_fence_init
      drm/i915/gem: Keep request alive while attaching fences

Christian Borntraeger (1):
      s390/purgatory: do not build purgatory with kcov, kasan and friends

Christian Lamparter (1):
      ath9k: use iowrite32 over __raw_writel

Christoph Hellwig (1):
      riscv: move sifive_l2_cache.c to drivers/soc

Christoph Niedermaier (1):
      ARM: imx: Correct ocotp id for serial number support of i.MX6ULL/ULZ =
SoCs

Christophe JAILLET (1):
      regulator: s5m8767: Fix a warning message

Christophe Leroy (4):
      spi: fsl: don't map irq during probe
      powerpc/irq: fix stack overflow verification
      spi: fsl: use platform_get_irq() instead of of_irq_to_resource()
      powerpc/8xx: fix bogus __init on mmu_mapin_ram_chunk()

Chuhong Yuan (3):
      spi: spi-cavium-thunderx: Add missing pci_release_regions()
      fjes: fix missed check in fjes_acpi_add
      drm/exynos: gsc: add missed component_del

Cristian Birsan (2):
      net: usb: lan78xx: Fix suspend/resume PHY register access error
      net: usb: lan78xx: Fix error message format specifier

Cristian Marussi (1):
      regulator: core: avoid unneeded .list_voltage calls

Curtis Malainey (3):
      ASoC: core: Init pcm runtime work early to avoid warnings
      ASoC: core: only flush inited work during free
      ASoC: SOF: Intel: split cht and byt debug window sizes

Dan Carpenter (3):
      mac80211: airtime: Fix an off by one in ieee80211_calc_rx_airtime()
      btrfs: return error pointer from alloc_test_extent_buffer
      ext4: unlock on error in ext4_expand_extra_isize()

Dan Murphy (4):
      MAINTAINERS: Add myself as a maintainer for MMIO m_can
      MAINTAINERS: Add myself as a maintainer for TCAN4x5x
      dt-bindings: tcan4x5x: Make wake-gpio an optional gpio
      can: tcan45x: Make wake-up GPIO an optional GPIO

Dan Williams (1):
      tools/testing/nvdimm: Fix mock support for ioremap

Daniel Axtens (3):
      mm/memory.c: add apply_to_existing_page_range() helper
      kasan: use apply_to_existing_page_range() for releasing vmalloc shado=
w
      kasan: don't assume percpu shadow allocations will succeed

Daniel Baluta (2):
      ASoC: SOF: topology: Fix unload for SAI/ESAI
      ASoC: simple-card: Don't create separate link when platform is presen=
t

Daniel Borkmann (4):
      bpf: Fix missing prog untrack in release_maps
      bpf: Fix cgroup local storage prog tracking
      bpf: Fix record_func_key to perform backtracking on r3
      bpf: Add further test_verifier cases for record_func_key

Daniel T. Lee (2):
      samples: bpf: Replace symbol compare of trace_event
      samples: bpf: fix syscall_tp due to unused syscall

Darrick J. Wong (5):
      xfs: fix log reservation overflows when allocating large rt extents
      libxfs: resync with the userspace libxfs
      xfs: refactor agfl length computation function
      xfs: split the sunit parameter update into two parts
      xfs: don't commit sunit/swidth updates to disk if that would
cause repair failures

Dave Young (1):
      x86/efi: Update e820 with reserved EFI boot services data to fix
kexec breakage

David Abdurachmanov (1):
      riscv: define vmemmap before pfn_to_page calls

David Engraf (1):
      tty/serial: atmel: fix out of range clock divider handling

David Hildenbrand (1):
      powerpc/pseries/cmm: fix managed page counts when migrating
pages between zones

David Jeffery (1):
      sbitmap: only queue kyber's wait callback if not already active

David Sterba (1):
      btrfs: fix devs_max constraints for raid1c3 and raid1c4

Davide Caratti (3):
      tc-testing: unbreak full listing of tdc testcases
      net/sched: cls_u32: fix refcount leak in the error path of u32_change=
()
      tc-testing: initial tdc selftests for cls_u32

Davidlohr Bueso (1):
      Revert "locking/mutex: Complain upon mutex API misuse in IRQ contexts=
"

Dmitry Golovin (1):
      x86/boot: kbuild: allow readelf executable to be specified

Dragos Tarcatu (2):
      ASoC: topology: Check return value for snd_soc_add_dai_link()
      ASoC: topology: Check return value for soc_tplg_pcm_create()

Ed Maste (2):
      perf vendor events s390: Fix counter long description for
DTLB1_GPAGE_WRITES
      perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES descript=
ion

Edward Cree (1):
      sfc: fix channel allocation with brute force

Enrico Weigelt, metux IT consult (3):
      scripts: package: mkdebian: add missing rsync dependency
      platform/x86: pcengines-apuv2: fix simswap GPIO assignment
      platform/x86: pcengines-apuv2: detect apuv4 board

Eric Auger (1):
      iommu: fix KASAN use-after-free in iommu_insert_resv_region

Eric Biggers (2):
      KEYS: remove CONFIG_KEYS_COMPAT
      KEYS: asymmetric: return ENOMEM if akcipher_request_alloc() fails

Eric Dumazet (9):
      netfilter: bridge: make sure to pull arp header in br_nf_forward_arp(=
)
      neighbour: remove neigh_cleanup() method
      bonding: fix bond_neigh_init()
      tcp/dccp: fix possible race __inet_lookup_established()
      6pack,mkiss: fix possible deadlock
      tcp: do not send empty skb from tcp_write_xmit()
      tcp: refine tcp_write_queue_empty() implementation
      tcp: refine rule to allow EPOLLOUT generation under mem pressure
      net: annotate lockless accesses to sk->sk_pacing_shift

Eric Sandeen (2):
      fs: avoid softlockups in s_inodes iterators
      fs: call fsnotify_sb_delete after evict_inodes

Erkka Talvitie (1):
      USB: EHCI: Do not return -EPIPE when hub is disconnected

Faiz Abbas (2):
      Revert "mmc: sdhci: Fix incorrect switch to HS mode"
      mmc: sdhci: Update the tuning failed messages to pr_debug level

Filipe Manana (5):
      Btrfs: fix cloning range with a hole when using the NO_HOLES feature
      Btrfs: fix missing data checksums after replaying a log tree
      Btrfs: make tree checker detect checksum items with overlapping range=
s
      Btrfs: fix removal logic of the tree mod log that leads to
use-after-free issues
      Btrfs: fix hole extent items with a zero size after range cloning

Flavio Leitner (1):
      sched/cputime, proc/stat: Fix incorrect guest nice cpustat value

Florian Fainelli (5):
      ARM: dts: BCM5301X: Fix MDIO node address/size cells
      ARM: dts: Cygnus: Fix MDIO node address/size cells
      dt-bindings: reset: Fix brcmstb-reset example
      reset: brcmstb: Remove resource checks
      net: dsa: b53: Fix egress flooding settings

Florian Westphal (3):
      netfilter: ctnetlink: netns exit must wait for callbacks
      netfilter: conntrack: tell compiler to not inline nf_ct_resolve_clash
      selftests: netfilter: use randomized netns names

Frederic Barrat (2):
      ocxl: Fix concurrent AFU open and device removal
      ocxl: Fix potential memory leak on context creation

Fredrik Olofsson (1):
      mac80211: fix TID field in monitor mode transmit

Ganapathi Bhat (1):
      mwifiex: fix possible heap overflow in mwifiex_process_country_ie()

Gao Fred (1):
      drm/i915/gvt: Fix guest boot warning

Geert Uytterhoeven (4):
      reset: Fix {of,devm}_reset_control_array_get kerneldoc return types
      reset: Do not register resource data for missing resets
      ARM: shmobile: defconfig: Restore debugfs support
      net: dst: Force 4-byte alignment of dst_metrics

Greentime Hu (1):
      riscv: fix scratch register clearing in M-mode.

Grygorii Strashko (2):
      net: ethernet: ti: davinci_cpdma: fix warning "device driver
frees DMA memory with different size"
      ARM: omap2plus_defconfig: enable NET_SWITCHDEV

Guenter Roeck (1):
      usb: xhci: Fix build warning seen with CONFIG_PM=3Dn

H. Nikolaus Schaller (1):
      ARM: bcm: Add missing sentinel to bcm2711_compat[]

Haiyang Zhang (2):
      hv_netvsc: Fix tx_table init in rndis_set_subchannel()
      hv_netvsc: Fix unwanted rx_table reset

Hangbin Liu (2):
      ipv6/addrconf: only check invalid header values when
NETLINK_F_STRICT_CHK is set
      selftests: pmtu: fix init mtu value in description

Hanjun Guo (1):
      perf/smmuv3: Remove the leftover put_cpu() in error path

Hans de Goede (7):
      ASoC: Intel: bytcr_rt5640: Update quirk for Teclast X89
      pinctrl: baytrail: Really serialize all register accesses
      pinctrl: cherryview: Split out irq hw-init into a separate helper fun=
ction
      pinctrl: cherryview: Add GPIO <-> pin mapping ranges via callback
      pinctrl: cherryview: Pass irqchip when adding gpiochip
      s390/purgatory: Make sure we fail the build if purgatory has
missing symbols
      platform/x86: hp-wmi: Make buffer for HPWMI_FEATURE2_QUERY 128 bytes

Heidi Fahim (1):
      kunit: testing kunit: Bug fix in test_run_timeout function

Helge Deller (2):
      parisc: soft_offline_page() now takes the pfn
      parisc: Fix compiler warnings in debug_core.c

Huanpeng Xin (1):
      spi: sprd: Fix the incorrect SPI register

Ian Abbott (1):
      staging: comedi: gsc_hpdi: check dma_alloc_coherent() return value

Ian Rogers (1):
      perf jit: Move test functionality in to a test

Ido Schimmel (2):
      mlxsw: spectrum_router: Remove unlikely user-triggerable warning
      selftests: forwarding: Delete IPv6 address at the end

Ioana Ciornei (1):
      dpaa2-ptp: fix double free of the ptp_qoriq IRQ

Iurii Zaikin (1):
      fs/ext4/inode-test: Fix inode test on 32 bit platforms.

James Bottomley (1):
      security: keys: trusted: fix lost handle flush

James Hogan (1):
      MAINTAINERS: Orphan KVM for MIPS

Jan H. Sch=C3=B6nherr (1):
      x86/mce: Fix possibly incorrect severity calculation on AMD

Jan H=C3=B6ppner (1):
      s390/dasd/cio: Interpret ccw_device_get_mdc return value correctly

Jan Kara (4):
      ext4: fix ext4_empty_dir() for directories with holes
      ext4: check for directory entries too close to block end
      pipe: Fix bogus dereference in iov_iter_alignment()
      ext4: clarify impact of 'commit' mount option

Jan Stancek (1):
      pipe: fix empty pipe check in pipe_write()

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Jasper Lake

Jason A. Donenfeld (1):
      random: don't forget compat_ioctl on urandom

Jeffrey Hugo (1):
      clk: qcom: Avoid SMMU/cx gdsc corner cases

Jens Axboe (11):
      io_uring: fix sporadic -EFAULT from IORING_OP_RECVMSG
      io-wq: re-add io_wq_current_is_worker()
      io_uring: fix pre-prepped issue with force_nonblock =3D=3D true
      io_uring: remove 'sqe' parameter to the OP helpers that take it
      io_uring: any deferred command must have stable sqe data
      io_uring: make IORING_POLL_ADD and IORING_POLL_REMOVE deferrable
      io_uring: make IORING_OP_CANCEL_ASYNC deferrable
      io_uring: make IORING_OP_TIMEOUT_REMOVE deferrable
      io_uring: read opcode and user_data from SQE exactly once
      io_uring: warn about unhandled opcode
      io_uring: io_wq_submit_work() should not touch req->rw

Jerome Brunet (1):
      clk: walk orphan list on clock provider registration

Jerry Snitselaar (3):
      tpm_tis: reserve chip for duration of tpm_tis_core_init
      iommu: set group default domain before creating direct mappings
      iommu/vt-d: Allocate reserved region for ISA with correct permission

Jia He (1):
      KVM: arm/arm64: Remove excessive permission check in
kvm_arch_prepare_memory_region

Jia-Ju Bai (1):
      net: nfc: nci: fix a possible sleep-in-atomic-context bug in
nci_uart_tty_receive()

Jiangfeng Xiao (1):
      net: hisilicon: Fix a BUG trigered by wrong bytes_compl

Jim Mattson (2):
      kvm: x86: Host feature SSBD doesn't imply guest feature SPEC_CTRL_SSB=
D
      kvm: x86: Host feature SSBD doesn't imply guest feature AMD_SSBD

Joakim Zhang (2):
      can: flexcan: add low power enter/exit acknowledgment helper
      can: flexcan: poll MCR_LPM_ACK instead of GPR ACK for stop mode
acknowledgment

Johannes Weiner (2):
      sched/psi: Fix sampling error and rare div0 crashes with cgroups
and high uptime
      psi: Fix a division error in psi poll()

John Hurley (1):
      nfp: flower: fix stats id allocation

Jonathan Lemon (1):
      bnxt: apply computed clamp value for coalece parameter

Jose Abreu (9):
      net: stmmac: selftests: Needs to check the number of Multicast regs
      net: stmmac: Determine earlier the size of RX buffer
      net: stmmac: Do not accept invalid MTU values
      net: stmmac: Only the last buffer has the FCS field
      net: stmmac: xgmac: Clear previous RX buffer size
      net: stmmac: RX buffer size must be 16 byte aligned
      net: stmmac: 16KB buffer must be 16 byte aligned
      net: stmmac: Enable 16KB buffer size
      net: stmmac: Always arm TX Timer at end of transmission start

Josef Bacik (7):
      btrfs: do not call synchronize_srcu() in inode_tree_del
      btrfs: handle error in btrfs_cache_block_group
      btrfs: don't double lock the subvol_sem for rename exchange
      btrfs: abort transaction after failed inode updates in create_subvol
      btrfs: handle ENOENT in btrfs_uuid_tree_iterate
      btrfs: skip log replay on orphaned roots
      btrfs: do not leak reloc root if we fail to read the fs root

Jouni Hogander (1):
      net-sysfs: Call dev_hold always in rx_queue_add_kobject

Julian Wiedmann (3):
      s390/qeth: handle error due to unsupported transport mode
      s390/qeth: fix promiscuous mode after reset
      s390/qeth: don't return -ENOTSUPP to userspace

J=C3=A9r=C3=B4me Pouiller (10):
      staging: wfx: fix the cache of rate policies on interface reset
      staging: wfx: fix case of lack of tx_retry_policies
      staging: wfx: fix counter overflow
      staging: wfx: use boolean appropriately
      staging: wfx: firmware does not support more than 32 total retries
      staging: wfx: fix rate control handling
      staging: wfx: ensure that retry policy always fallbacks to MCS0 / 1Mb=
ps
      staging: wfx: detect race condition in WEP authentication
      staging: wfx: fix hif_set_mfp() with big endian hosts
      staging: wfx: fix wrong error message

Kai-Heng Feng (2):
      x86/intel: Disable HPET on Intel Coffee Lake H platforms
      x86/intel: Disable HPET on Intel Ice Lake platforms

Kajol Jain (1):
      perf metricgroup: Fix printing event names of metric group with
multiple events

Karol Trzcinski (2):
      ASoC: SOF: loader: snd_sof_fw_parse_ext_data log warning on unknown h=
eader
      ASoC: SOF: loader: fix snd_sof_fw_parse_ext_data

Karsten Graul (1):
      net/smc: unregister ib devices in reboot_event

Keita Suzuki (1):
      tracing: Avoid memory leak in process_system_preds()

Keyon Jie (1):
      ASoC: SOF: Intel: BYT: fix a copy/paste mistake in byt_dump()

Konstantin Khlebnikov (1):
      x86/MCE/AMD: Do not use rdmsr_safe_on_cpu() in smca_configure()

Krzysztof Kozlowski (1):
      MAINTAINERS: Include Samsung SoC serial driver in Samsung SoC entry

Leo Yan (1):
      tty: serial: msm_serial: Fix lockup for sysrq and oops

Leonard Crestez (3):
      ARM: dts: imx6ul-evk: Fix peripheral regulator
      ARM: imx_v6_v7_defconfig: Explicitly restore CONFIG_DEBUG_FS
      ARM: imx: Fix boot crash if ocotp is not found

Liming Sun (1):
      platform/mellanox: fix the mlx-bootctl sysfs

Linus Torvalds (3):
      Fix root mounting with no mount options
      early init: fix error handling when opening /dev/console
      Linux 5.5-rc3

Linus Walleij (3):
      spi: fsl: Fix GPIO descriptor support
      gpio: Handle counting of Freescale chipselects
      spi: fsl: Handle the single hardwired chipselect case

Lorenz Bauer (1):
      bpf: Clear skb->tstamp in bpf_redirect when necessary

Lorenzo Bianconi (1):
      mt76: mt76x0: fix default mac address overwrite

Lu Baolu (2):
      iommu/vt-d: Fix dmar pte read access not set error
      iommu/vt-d: Remove incorrect PSI capability check

Luca Coelho (1):
      iwlwifi: pcie: move power gating workaround earlier in the flow

Lukasz Luba (1):
      MAINTAINERS: Update Lukasz Luba's email address

Mahesh Bandewar (1):
      bonding: fix active-backup transition after link failure

Manish Chopra (4):
      qede: Fix multicast mac configuration
      bnx2x: Do not handle requests from VFs after parity
      bnx2x: Fix logic to get total no. of PFs per engine
      qede: Disable hardware gro when xdp prog is installed

Mans Rullgard (1):
      ARM: dts: am335x-sancloud-bbe: fix phy mode

Mao Wenan (1):
      af_packet: set defaule value for tmo

Marc Kleine-Budde (1):
      can: j1939: fix address claim code example

Marc Zyngier (1):
      KVM: arm/arm64: Properly handle faulting of device mappings

Marcelo Ricardo Leitner (1):
      sctp: fix memleak on err handling of stream initialization

Marco Elver (1):
      locking/spinlock/debug: Fix various data races

Marco Oliverio (1):
      netfilter: nf_queue: enqueue skbs with NULL dst

Marcus Comstedt (1):
      KVM: PPC: Book3S HV: Fix regression on big endian hosts

Marek Szyprowski (1):
      ARM: exynos_defconfig: Restore debugfs support

Mark Rutland (2):
      KVM: arm64: Sanely ratelimit sysreg messages
      KVM: arm64: Don't log IMP DEF sysreg traps

Martin Schiller (1):
      net/x25: add new state X25_STATE_5

Masahiro Yamada (6):
      kbuild: fix 'No such file or directory' warning when cleaning
      mkcompile_h: git rid of UTS_TRUNCATE from LINUX_COMPILE_{BY,HOST}
      mkcompile_h: use printf for LINUX_COMPILE_BY
      scripts/kallsyms: fix offset overflow of kallsyms_relative_base
      kconfig: remove ---help--- from documentation
      kbuild: clarify the difference between obj-y and obj-m w.r.t. descend=
ing

Masami Hiramatsu (7):
      selftests/ftrace: Fix to check the existence of set_ftrace_filter
      selftests/ftrace: Fix ftrace test cases to check unsupported
      selftests/ftrace: Do not to use absolute debugfs path
      selftests/ftrace: Fix multiple kprobe testcase
      selftests: safesetid: Move link library to LDLIBS
      selftests: safesetid: Check the return value of setuid/setgid
      selftests: safesetid: Fix Makefile to set correct test program

Matt Roper (2):
      drm/i915/ehl: Define EHL powerwells independently of ICL
      drm/i915/tgl: Drop Wa#1178

Matthias Kaehlcke (1):
      clk: qcom: gcc-sc7180: Fix setting flag for votable GDSCs

Maxim Mikityanskiy (4):
      xsk: Add rcu_read_lock around the XSK wakeup
      net/mlx5e: Fix concurrency issues between config flow and XSK
      net/i40e: Fix concurrency issues between config flow and XSK
      net/ixgbe: Fix concurrency issues between config flow and XSK

Miaohe Lin (3):
      KVM: arm/arm64: Get rid of unused arg in cpu_init_hyp_mode()
      KVM: arm/arm64: vgic: Fix potential double free dist->spis in
__kvm_vgic_destroy()
      KVM: arm/arm64: vgic: Use wrapper function to lock/unlock all
vcpus in kvm_vgic_create()

Michael Chan (2):
      bnxt_en: Fix MSIX request logic for RDMA driver.
      bnxt_en: Free context memory in the open path if firmware has been re=
set.

Michael Ellerman (1):
      selftests: Fix dangling documentation references to kselftest_module.=
sh

Michael Grzeschik (1):
      net: dsa: ksz: use common define for tag len

Michael Haener (1):
      platform/x86: pmc_atom: Add Siemens CONNECT X300 to
critclk_systems DMI table

Michael Petlan (1):
      perf header: Fix false warning when there are no duplicate cache entr=
ies

Michael Walle (4):
      ASoC: wm8904: fix automatic sysclk configuration
      arm64: dts: ls1028a: fix typo in TMU calibration data
      arm64: dts: ls1028a: fix reboot node
      spi: nxp-fspi: Ensure width is respected in spi-mem operations

Mike Christie (1):
      nbd: fix shutdown and recv work deadlock v2

Mike Rapoport (1):
      powerpc: Ensure that swiotlb buffer is allocated from low memory

Nathan Chancellor (2):
      netfilter: nf_flow_table_offload: Don't use offset uninitialized
in flow_offload_port_{d,s}nat
      xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk

Navid Emamdoost (1):
      net: gemini: Fix memory leak in gmac_setup_txqs

Netanel Belgazal (1):
      net: ena: fix napi handler misbehavior when the napi budget is zero

Nicolas Saenz Julienne (1):
      ARM: dts: bcm2711: fix soc's node dma-ranges

Nikolay Borisov (1):
      btrfs: Fix error messages in qgroup_rescan_init

Oded Gabbay (1):
      habanalabs: rate limit error msg on waiting for CS

Oleksij Rempel (2):
      can: j1939: j1939_sk_bind(): take priv after lock is held
      net: ag71xx: fix compile warnings

Olof Johansson (1):
      clk: Move clk_core_reparent_orphans() under CONFIG_OF

Pablo Neira Ayuso (7):
      netfilter: nf_flow_table_offload: add IPv6 match description
      netfilter: nft_set_rbtree: bogus lookup/get on consecutive
elements in named sets
      netfilter: nf_tables: validate NFT_SET_ELEM_INTERVAL_END
      netfilter: nf_tables: validate NFT_DATA_VALUE after nft_data_init()
      netfilter: nf_tables: skip module reference count bump on object upda=
tes
      netfilter: nf_tables_offload: return EOPNOTSUPP if rule
specifies no actions
      netfilter: nf_flow_table_offload: Correct memcpy size for
flow_overload_mangle()

Padmanabhan Rajanbabu (1):
      net: stmmac: platform: Fix MDIO init for platforms without PHY

Paolo Bonzini (1):
      MAINTAINERS: remove Radim from KVM maintainers

Paul Cercueil (1):
      pinctrl: ingenic: Fixup PIN_CONFIG_OUTPUT config

Paul Chaignon (2):
      bpf, riscv: Limit to 33 tail calls
      bpf, mips: Limit to 33 tail calls

Paul Durrant (5):
      xen-netback: avoid race that can lead to NULL pointer dereference
      xenbus: move xenbus_dev_shutdown() into frontend code...
      xenbus: limit when state is forced to closed
      xen/interface: re-define FRONT/BACK_RING_ATTACH()
      xen-blkback: support dynamic unbind/bind

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't do ultravisor calls on systems
without ultravisor

Pavel Begunkov (2):
      io_uring: make HARDLINK imply LINK
      io_uring: don't wait when under-submitting

Pavel Tatashin (1):
      tpm/tpm_ftpm_tee: add shutdown call back

Peng Fan (3):
      clk: imx: clk-composite-8m: add lock to gate/mux
      clk: imx: clk-imx7ulp: Add missing sentinel of ulp_div_table
      clk: imx: pll14xx: fix clk_pll14xx_wait_lock

Peter Zijlstra (1):
      perf/x86: Fix potential out-of-bounds access

Phil Sutter (1):
      netfilter: uapi: Avoid undefined left-shift in xt_sctp.h

Phong Tran (1):
      ext4: use RCU API in debug_print_tree

Prateek Sood (1):
      tracing: Fix lock inversion in trace_event_enable_tgid_record()

Rafael J. Wysocki (1):
      cpufreq: Avoid leaving stale IRQ work items during CPU offline

Rahul Lakkireddy (1):
      cxgb4: fix refcount init for TC-MQPRIO offload

Rahul Tanwar (1):
      pinctrl: Modify Kconfig to fix linker error

Randy Dunlap (3):
      xfs: fix Sphinx documentation warning
      jbd2: fix kernel-doc notation warning
      net: fix kernel-doc warning in <linux/netdevice.h>

Rasmus Villemoes (1):
      mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add erratum
A-009204 support"

Ravi Bangoria (4):
      perf report/top TUI: Replace pr_err() with ui__error()
      perf report: Make -F more strict like -s
      perf report: Bail out --mem-mode if mem info is not available
      perf/x86/pmu-events: Fix Kernel_Utilization metric

Rob Herring (1):
      dt-bindings: Add missing 'properties' keyword enclosing 'snps,tso'

Robin Murphy (2):
      iommu/dma: Rationalise types for DMA masks
      iommu/dma: Relax locking in iommu_dma_prepare_msi()

Roman Penyaev (1):
      block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWA=
IT

Russell King (4):
      net: marvell: mvpp2: phylink requires the link interrupt
      net: phylink: fix interface passed to mac_link_up
      mod_devicetable: fix PHY module format
      net: phy: ensure that phy IDs are correctly typed

Sean Nyekjaer (3):
      can: flexcan: fix possible deadlock and out-of-order reception
after wakeup
      can: m_can: tcan4x5x: add required delay after reset
      dt-bindings: can: tcan4x5x: reset pin is active high

Sebastian Andrzej Siewior (1):
      perf/core: Add SRCU annotation for pmus list walk

SeongJae Park (2):
      kselftest/runner: Print new line in print of timeout log
      kselftest: Support old perl versions

Shengjiu Wang (1):
      ASoC: wm8962: fix lambda value

Shuming Fan (1):
      ASoC: rt5682: fix i2c arbitration lost issue

Srikar Dronamraju (2):
      powerpc/vcpu: Assume dedicated processors as non-preempt
      powerpc/shared: Use static key to detect shared processor

Srinivas Neeli (1):
      can: xilinx_can: Fix missing Rx can packets on CANFD2.0

Stefan B=C3=BChler (1):
      cfg80211: fix double-free after changing network namespace

Stefan Haberland (2):
      s390/dasd: fix memleak in path handling error case
      s390/dasd: fix typo in copyright statement

Stefan Roese (1):
      ARM: dts: imx6ul: imx6ul-14x14-evk.dtsi: Fix SPI NOR probing

Stefan Wahren (1):
      ARM: dts: bcm283x: Fix critical trip point

Stefano Garzarella (2):
      vsock/virtio: fix null-pointer dereference in
virtio_transport_recv_listen()
      vsock/virtio: add WARN_ON check on virtio_transport_get_ops()

Stephan Gerhold (1):
      NFC: nxp-nci: Fix probing without ACPI

Steven Rostedt (VMware) (1):
      tracing: Have the histogram compare functions convert to u64 first

Subash Abhinov Kasiviswanathan (1):
      MAINTAINERS: Add maintainers for rmnet

Sudeep Holla (2):
      ARM: vexpress: Set-up shared OPP table instead of individual for each=
 CPU
      cpufreq: vexpress-spc: Switch cpumask from topology core to OPP shari=
ng

Sudip Mukherjee (4):
      libtraceevent: Fix lib installation with O=3D
      libtraceevent: Copy pkg-config file to output folder when using O=3D
      libtraceevent: Allow custom libdir path
      tty: link tty and port before configuring it as console

Suwan Kim (2):
      usbip: Fix receive error in vhci-hcd when using scatter-gather
      usbip: Fix error path of vhci_recv_ret_submit()

Sven Schnelle (5):
      parisc: fix compilation when KEXEC=3Dn and KEXEC_FILE=3Dy
      parisc: add missing __init annotation
      s390/ftrace: fix endless recursion in function_graph tracer
      samples/trace_printk: Wait for IRQ work to finish
      tracing: Fix endianness bug in histogram trigger

Tadeusz Struk (3):
      tpm: fix invalid locking in NONBLOCKING mode
      tpm: selftest: add test covering async mode
      tpm: selftest: cleanup after unseal with wrong auth/policy test

Taehee Yoo (4):
      gtp: do not allow adding duplicate tid and ms_addr pdp context
      gtp: fix wrong condition in gtp_genl_dump_pdp()
      gtp: fix an use-after-free in ipv4_pdp_find()
      gtp: avoid zero size hashtable

Takashi Iwai (6):
      ALSA: pcm: Avoid possible info leaks from PCM stream buffers
      ALSA: hda/ca0132 - Keep power on during processing DSP response
      ALSA: hda/ca0132 - Avoid endless loop
      ALSA: hda/ca0132 - Fix work handling in delayed HP detection
      ALSA: hda: Fix regression by strip mask fix
      ALSA: hda - Downgrade error message for single-cmd fallback

Tejun Heo (1):
      iocost: over-budget forced IOs should schedule async delay

Thadeu Lima de Souza Cascardo (1):
      selftests: net: tls: remove recv_rcvbuf test

Theodore Ts'o (2):
      ext4: optimize __ext4_check_dir_entry()
      ext4: validate the debug_want_extra_isize mount option at parse time

Thomas Falcon (1):
      net/ibmvnic: Fix typo in retry check

Thomas Hebb (1):
      kconfig: don't crash on NULL expressions in expr_eq()

Tina Zhang (1):
      drm/i915/gvt: Pin vgpu dma address before using

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      bpftool: Don't crash on missing jited insns or ksyms
      mac80211: Turn AQL into an NL80211_EXT_FEATURE

Tomi Valkeinen (1):
      ARM: dts: am437x-gp/epos-evm: fix panel compatible

Tony Lindgren (3):
      bus: ti-sysc: Fix missing force mstandby quirk handling
      ARM: omap2plus_defconfig: Add back DEBUG_FS
      bus: ti-sysc: Fix missing reset delay handling

Tuong Lien (4):
      tipc: fix name table rbtree issues
      tipc: fix potential hanging after b/rcast changing
      tipc: fix retrans failure due to wrong destination
      tipc: fix use-after-free in tipc_disc_rcv()

Tvrtko Ursulin (1):
      drm/i915: Fix pid leak with banned clients

Tzung-Bi Shih (3):
      ASoC: max98090: remove msleep in PLL unlocked workaround
      ASoC: max98090: exit workaround earlier if PLL is locked
      ASoC: max98090: fix possible race conditions

Ursula Braun (1):
      net/smc: add fallback check to connect()

Vandita Kulkarni (1):
      drm/i915: Fix WARN_ON condition for cursor plane ddb allocation

Vasily Gorbik (2):
      s390/unwind: stop gracefully at user mode pt_regs in irq stack
      s390/ftrace: save traced function caller

Vasundhara Volam (5):
      bnxt_en: Return error if FW returns more data than dump length
      bnxt_en: Fix bp->fw_health allocation and free logic.
      bnxt_en: Remove unnecessary NULL checks for fw_health
      bnxt_en: Fix the logic that creates the health reporters.
      bnxt_en: Add missing devlink health reporters for VFs.

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Correct the offset and value for DDR_CONFIG register

Vignesh Raghavendra (1):
      spi: spi-ti-qspi: Fix a bug when accessing non default CS

Vincent Guittot (2):
      sched/fair: Fix find_idlest_group() to handle CPU affinity
      sched/cfs: fix spurious active migration

Vishal Kulkarni (1):
      cxgb4: Fix kernel panic while accessing sge_info

Vivien Didelot (1):
      mailmap: add entry for myself

Wei Li (1):
      arm64: cpu_errata: Add Hisilicon TSV110 to spectre-v2 safe list

Wen Yang (2):
      regulator: fix use after free issue
      regulator: core: fix regulator_register() error paths to
properly release rdev

Will Deacon (1):
      KVM: arm64: Ensure 'params' is initialised when looking up sys regist=
er

Xiaolong Huang (1):
      can: kvaser_usb: kvaser_usb_leaf: Fix some info-leaks to USB devices

Xiaotao Yin (1):
      iommu/iova: Init the struct iova to fix the possible memleak

Xin Long (1):
      sctp: fully initialize v4 addr in some functions

Yang Shi (1):
      mm: vmscan: protect shrinker idr replace with CONFIG_MEMCG

Yang Yingliang (1):
      block: fix memleak when __blk_rq_map_user_iov() is failed

Yangbo Lu (2):
      mmc: sdhci-of-esdhc: fix P2020 errata handling
      mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround

Yazen Ghannam (1):
      x86/MCE/AMD: Allow Reserved types to be overwritten in smca_banks[]

Yonghan Ye (1):
      serial: sprd: Add clearing break interrupt operation

Yu-Hsuan Hsu (1):
      ASoC: AMD: Enable clk in startup intead of hw_params

YueHaibing (3):
      ASoC: rt5677: Fix build error without CONFIG_SPI
      ASoC: Intel: sst: Add missing include <linux/io.h>
      gpiolib: of: Make of_gpio_spi_cs_get_count static

Yunfeng Ye (1):
      ext4: fix unused-but-set-variable warning in ext4_add_entry()

Zhenyu Wang (2):
      drm/i915/gvt: use vgpu lock for active state setting
      drm/i915/gvt: set guest display buffer as readonly

qize wang (1):
      mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()

wenxu (3):
      netfilter: nf_flow_table_offload: Fix block setup as TC_SETUP_FT cmd
      netfilter: nf_flow_table_offload: Fix block_cb tc_setup_type as
TC_SETUP_CLSFLOWER
      netfilter: nf_tables_offload: Check for the NETDEV_UNREGISTER event

yangerkun (1):
      ext4: reserve revoke credits in __ext4_new_inode

zhong jiang (1):
      usb: typec: fusb302: Fix an undefined reference to 'extcon_get_state'
