Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26DC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086020821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555870761;
	bh=Yfmifmg6GZEbdcuwqf2e035ZHRkrT6OxAuaj0C9PPR0=;
	h=From:Date:Subject:To:List-ID:From;
	b=qCWFwWX6kcMq28tQEqBXfwxypY2PNcbwTJ0hGFgA4/kdEHnMsqEHm8+pODW4MWV+Q
	 M2xwYi0b7N914nynX3M85JlQKE9mAuFMZgvyvGQq2H3CqUk2FME820CCY05pRnNRqO
	 HzH3yUT1kWg7iwhcnTe0YAK3IscOCQwCuXijYue8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDUSSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:18:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34804 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfDUSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 14:18:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id j89so8612590ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CATdb/wl0kDhHwzsiI4x43Q1lv5y1sOQl36wKGjSJWo=;
        b=adDA4B6ZBln8fBMg0X6S9zPSj/pG6QIQ0hrBW8Z1O/cYQr+WVInslGdhgZ5GooP1dz
         KET45AUuxPmfz3XHDwkkW/tSc5OpOziPS9Ylm/mrSfSqbVMpXwKZ8e/meFX3iCycmWwL
         Uz16bO5ef3f3DPfbI0VXClmI4Y13LAV6E9N6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CATdb/wl0kDhHwzsiI4x43Q1lv5y1sOQl36wKGjSJWo=;
        b=JcJhcdZuN2wpwB0sZVpsUlpEF+LN+fh//BgS1zhUqP0Y2IntIu+2EqTMns3571t/JF
         7n+e/KwIBuIF3SKgs0UybTW9waTxdSSZ4vs39UFP7Q21/lfXBCHxbZhDKrtZQu6j06k8
         u4UeE4FhMwYfzIX7UZNhCL/Hk2cKLPxH5a8T6YuJwcRlwef8RbW1E6KKsguRwfpvHbx0
         9NKpFjSEMXAdDnBcVAzmniCYGM80iHOfw0X8MHdORZK3PnnZaEASMsck7d5aZXJO8FT2
         RnLdbC2tZ1E+WPr0Ygb58hIYJgpOGOw2gJYGYdQTGWM2k5lTmG/yn/y8TPMJe3ZrJXkZ
         dH0Q==
X-Gm-Message-State: APjAAAVctROXOqzM4jzIBW63JExm2cAAXzCIHL9FLQQvUU+Hd/Ja+PYt
        qpiP10Zd3crV7xZlRRtfrG+bMY2zCGk=
X-Google-Smtp-Source: APXvYqx7BnctjTpKTHcoYuFs/ZCRNSrx19rblz0NSTZArTUoHzEciqUGdpjvM/CJZqrclDtZSWvA4A==
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr7772215ljj.128.1555870683842;
        Sun, 21 Apr 2019 11:18:03 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b20sm2139464lfi.78.2019.04.21.11.18.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 11:18:03 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id d12so7476476lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 11:18:02 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr8336689lfm.166.1555870682335;
 Sun, 21 Apr 2019 11:18:02 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Apr 2019 11:17:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii=Ym24FWf7J2s1CEwCXU3hjVXeHSkV3A8X5iAj6eT8Q@mail.gmail.com>
Message-ID: <CAHk-=wii=Ym24FWf7J2s1CEwCXU3hjVXeHSkV3A8X5iAj6eT8Q@mail.gmail.com>
Subject: Linux v5.1-rc6
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Easter Sunday here, but I don't let little things like random
major religious holidays interrupt my kernel development workflow. The
occasional scuba trip? Sure. But everybody sitting around eating
traditional foods? No. You have to have priorities. There's only so
much memma you can eat even if your wife had to make it from scratch
because nobody eats that stuff in the US.

Anyway, rc6 is actually larger than I would have liked, which made me
go back and look at history, and for some reason that's not all that
unusual. We recently had similar rc6 bumps in both 4.18 and 5.0.

So I'm not going to worry about it. I think it's just random timing of
pull requests, and almost certainly at least partly due to the
networking pull request in here (with just over a third of the changes
being networking-related, either in drivers or core networking).

Aside from the networking stuff, we've got the usual other driver
updates (nvdimm, iio, gpu stands out), arch updates (mainly x86 - kvm
fixes stand out), and tooling (selftests and perf).

And then we have various random collection of other changes: some core
mm, some filesystem fixes, scheduler and tracing stuff.

But despite rc6 being a bit larger than I'd hope for, all of it is
pretty small, and I don't think there's anything really worrisome in
here. In fact, a lot of it is truly trivial stuff, some of it just
spelling fixes and the like.

Have a gander at the appended shortlog for details if you care, but
more importantly, give it a whirl and kick the tires...

               Linus

---

Aditya Pakki (1):
      libnvdimm/btt: Fix a kmemdup failure check

Adrian Hunter (1):
      perf scripts python: export-to-sqlite.py: Fix use of parent_id
in calls_view

Alex Deucher (1):
      drm/amdgpu/gmc9: fix VM_L2_CNTL3 programming

Alexander Shishkin (2):
      perf/core: Fix the address filtering fix
      perf/ring_buffer: Fix AUX record suppression

Alexander Wetzel (1):
      mac80211: Honor SW_CRYPTO_CONTROL for unicast keys in AP VLAN mode

Alexey Dobriyan (2):
      proc: fix map_files test on F29
      proc: fixup proc-pid-vm test

Andi Kleen (2):
      afs: Avoid section confusion in CM_NAME
      x86/cpu/bugs: Use __initconst for 'const' init data

Andrea Arcangeli (1):
      coredump: fix race condition between
mmget_not_zero()/get_task_mm() and core dumping

Andrei Otcheretianski (1):
      mac80211: Increase MAX_MSG_LEN

Andrew Morton (1):
      locking/atomics: Don't assume that scripts are executable

Andy Duan (1):
      net: fec: manage ahb clock in runtime pm

Aneesh Kumar K.V (1):
      fs/dax: Deposit pagetable even when installing zero page

Anson Huang (1):
      Input: snvs_pwrkey - initialize necessary driver data before enabling=
 IRQ

Anup Patel (2):
      RISC-V: Add separate defconfig for 32bit systems
      RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit systems

Ard Biesheuvel (1):
      net/core: work around section mismatch warning for ptp_classifier

Arnaldo Carvalho de Melo (1):
      tools include uapi: Sync sound/asound.h copy

Arnd Bergmann (7):
      iio: pms7003: select IIO_TRIGGERED_BUFFER
      extcon: ptn5150: fix COMPILE_TEST dependencies
      gpu: host1x: Program stream ID to bypass without SMMU
      clocksource/drivers/npcm: select TIMER_OF
      afs: avoid deprecated get_seconds()
      socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
      mm/kmemleak.c: fix unused-function warning

Aurelien Aptel (1):
      CIFS: keep FileInfo handle live during oplock break

Baoquan He (1):
      x86/mm/KASLR: Fix the size of the direct mapping section

Bart Van Assche (1):
      locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' ag=
ain

Ben Gardon (1):
      kvm: mmu: Fix overflow on kvm mmu page limit calculation

Bo YU (1):
      misc: fastrpc: add checked value for dma_set_mask

Boris Brezillon (1):
      MAINTAINERS: Fix the I3C entry

Chang-An Chen (1):
      timers/sched_clock: Prevent generic sched_clock wrap caused by
tick_freeze()

Christian Brauner (1):
      signal: use fdget() since we don't allow O_PATH

Christian Gromm (1):
      staging: most: core: use device description as name

Christian K=C3=B6nig (3):
      drm/ttm: fix out-of-bounds read in ttm_put_pages() v2
      drm/ttm: fix start page for huge page check in ttm_put_pages()
      drm/ttm: fix incrementing the page pointer for huge pages

Christoph Hellwig (1):
      scsi: aic7xxx: fix EISA support

Claudiu Manoil (2):
      ocelot: Don't sleep in atomic context (irqs_disabled())
      ocelot: Clean up stats update deferred work

Colin Ian King (5):
      vxge: fix return of a free'd memblock on a failed dma mapping
      qede: fix write to free'd pointer error and double free of ptp
      bnx2x: fix spelling mistake "dicline" -> "decline"
      x86/Kconfig: Fix spelling mistake "effectivness" -> "effectiveness"
      qed: fix spelling mistake "faspath" -> "fastpath"

Corey Minyard (2):
      ipmi: Fix failure on SMBIOS specified devices
      ipmi: fix sleep-in-atomic in free_user at cleanup SRCU
user->release_barrier

Dan Williams (2):
      acpi/nfit: Always dump _DSM output payload
      init: initialize jump labels before command line option parsing

Dave Jiang (3):
      libnvdimm/security: provide fix for secure-erase to use zero-key
      libnvdimm/security, acpi/nfit: unify zero-key for all security comman=
ds
      tools/testing/nvdimm: Retain security state after overwrite

David Ahern (1):
      selftests: fib_tests: Fix 'Command line is not complete' errors

David Francis (1):
      drm/amd/display: If one stream full updates, full update all planes

David Howells (3):
      rxrpc: Trace received connection aborts
      afs: Differentiate abort due to unmarshalling from other errors
      afs: Fix in-progess ops to ignore server-level callback invalidation

Denis Bolotin (4):
      qed: Delete redundant doorbell recovery types
      qed: Fix the doorbell address sanity check
      qed: Fix missing DORQ attentions
      qed: Fix the DORQ's attentions handling

Dmitry Torokhov (7):
      Input: document meanings of KEY_SCREEN and KEY_ZOOM
      [media] doc-rst: switch to new names for Full Screen/Aspect keys
      HID: input: fix mapping of aspect ratio key
      HID: input: add mapping for Expose/Overview key
      HID: input: add mapping for keyboard Brightness Up/Down/Toggle keys
      HID: input: add mapping for "Full Screen" key
      HID: input: add mapping for "Toggle Display" key

Dmytro Linkin (1):
      net/mlx5e: Protect against non-uplink representor for encap

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Eran Ben Elisha (2):
      net/mlx5e: Skip un-needed tx recover if interface state is down
      net/mlx5e: Use fail-safe channels reopen in tx reporter recover

Eric Biggers (1):
      crypto: x86/poly1305 - fix overflow during partial reduction

Eric Dumazet (4):
      dctcp: more accurate tracking of packets delivery
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()
      rtnetlink: fix rtnl_valid_stats_req() nlmsg_len check
      tcp: tcp_grow_window() needs to respect tcp_space()

Fabrice Gasnier (1):
      iio: core: fix a possible circular locking dependency

Felix Fietkau (9):
      mac80211: un-schedule TXQs on powersave start
      mac80211: fix unaligned access in mesh table hash function
      mac80211: fix memory accounting with A-MSDU aggregation
      mac80211: do not call driver wake_tx_queue op during reconfig
      mac80211: rework locking for txq scheduling / airtime fairness
      mac80211: make ieee80211_schedule_txq schedule empty TXQs
      mt76: mt7603: add missing initialization for dev->ps_lock
      mt76: mt7603: fix sequence number assignment
      mt76: mt7603: send BAR after powersave wakeup

Gao Xiang (1):
      staging: erofs: fix unexpected out-of-bound data access

Geert Uytterhoeven (2):
      serial: sh-sci: Fix HSCIF RX sampling point calculation
      serial: sh-sci: Fix HSCIF RX sampling point adjustment

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

Guoqing Jiang (2):
      sc16is7xx: move label 'err_spi' to correct section
      sc16is7xx: put err_spi and err_i2c into correct #ifdef

Gustavo A. R. Silva (2):
      perf header: Fix lock/unlock imbalances when processing BPF/BTF info
      net: atm: Fix potential Spectre v1 vulnerabilities

Gwendal Grignou (1):
      iio: cros_ec: Fix the maths for gyro scale calculation

Hangbin Liu (1):
      team: set slave to promisc if team is already in promisc mode

Hans de Goede (1):
      x86/cpu/intel: Lower the "ENERGY_PERF_BIAS: Set to normal"
message's log priority

Harald Freudenberger (2):
      s390/zcrypt: fix possible deadlock situation on ap queue remove
      s390/pkey: add one more argument space for debug feature entry

Hariprasad Kelam (1):
      KVM: x86: fix warning Using plain integer as NULL pointer

Hoang Le (1):
      tipc: missing entries in name table of publications

Hou Tao (1):
      block: kill all_q_node in request_queue

Hugh Dickins (4):
      mm: swapoff: shmem_find_swap_entries() filter out other types
      mm: swapoff: remove too limiting SWAP_UNUSE_MAX_TRIES
      mm: swapoff: take notice of completion sooner
      mm: swapoff: shmem_unuse() stop eviction without igrab()

Hui Wang (1):
      ALSA: hda/realtek - add two more pin configuration sets to quirk tabl=
e

Ian Abbott (4):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Ido Schimmel (7):
      mlxsw: spectrum_switchdev: Add MDB entries in prepare phase
      mlxsw: core: Do not use WQ_MEM_RECLAIM for EMAD workqueue
      mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw ordered workqueue
      mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw workqueue
      mlxsw: spectrum_router: Do not check VRF MAC address
      selftests: mlxsw: Test VRF MAC vetoing
      mlxsw: spectrum_buffers: Add a multicast pool for Spectrum-2

Ihab Zhaika (2):
      iwlwifi: rename structs to fit the new names
      iwlwifi: add new 0x2723/0x2080 card for 22000

Ilan Peer (1):
      cfg80211: Handle WMM rules in regulatory domain intersection

Jaesoo Lee (1):
      scsi: core: set result when the command cannot be dispatched

Jakub Kicinski (5):
      net/tls: fix the IV leaks
      net/tls: don't leak partially sent record in device mode
      net: strparser: partially revert "strparser: Call skb_unclone
conditionally"
      net/tls: fix build without CONFIG_TLS_DEVICE
      net/tls: prevent bad memory access in tls_is_sk_tx_device_offloaded()

Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

Jason Wang (1):
      vhost: reject zero size iova range

Jean-Francois Dagenais (1):
      iio: dac: mcp4725: add missing powerdown bits in store eeprom

Jeffrey Altman (1):
      rxrpc: Fix detection of out of order acks

Jens Axboe (6):
      io_uring: park SQPOLL thread if it's percpu
      io_uring: only test SQPOLL cpu after we've verified it
      bfq: update internal depth state when queue depth changes
      io_uring: drop io_file_put() 'file' argument
      io_uring: fix possible deadlock between io_uring_{enter,register}
      io_uring: fix CQ overflow condition

Jian-Hong Pan (1):
      x86/reboot, efi: Use EFI reboot for Acer TravelMate X514-51T

Jie Liu (1):
      tipc: set sysctl_tipc_rmem and named_timeout right range

Jiri Olsa (6):
      perf stat: Disable DIR_FORMAT feature for 'perf stat record'
      perf top: Always sample time to satisfy needs of use of ordered queui=
ng
      perf bpf: Return NULL when RB tree lookup fails in
perf_env__find_bpf_prog_info()
      perf evlist: Fix side band thread draining
      perf tools: Fix map reference counting
      perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf=
()

Joe Perches (1):
      s390/mem_detect: Use IS_ENABLED(CONFIG_BLK_DEV_INITRD)

Johannes Berg (4):
      iwlwifi: mvm: fix TX crypto on 22560+ devices
      iwlwifi: mvm: avoid possible deadlock in TX path
      iwlwifi: mvm: update offloaded rate control on changes
      mac80211_hwsim: calculate if_combination.max_interfaces

Johannes Weiner (1):
      mm: fix inactive list balancing between NUMA nodes and cgroups

Jonathan Cameron (1):
      iio: chemical: fix missing Kconfig block for sgp30

Jonathan Lemon (1):
      route: Avoid crash from dereferencing NULL rt->from

KT Liao (1):
      Input: elan_i2c - add hardware ID for multiple Lenovo laptops

Kan Liang (1):
      perf/x86: Fix incorrect PEBS_REGS

Kangjie Lu (2):
      libnvdimm/namespace: Fix a potential NULL pointer dereference
      net/smc: fix a NULL pointer dereference

Karsten Graul (2):
      net/smc: wait for pending work before clcsock release_sock
      net/smc: fix return code from FLUSH command

Kim Phillips (1):
      perf/x86/amd: Add event map for AMD Family 17h

Konstantin Khlebnikov (2):
      net/mlx5e: Switch to Toeplitz RSS hash by default
      mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=3Dy
CONFIG_SMP=3Dn

Lars-Peter Clausen (1):
      iio: Fix scan mask selection

Leonard Pollak (1):
      Staging: iio: meter: fixed typo

Li RongQing (1):
      libnvdimm/pmem: fix a possible OOB access when read and write pmem

Lin Yi (1):
      drm/ttm: fix dma_fence refcount imbalance on error path

Linus Torvalds (1):
      Linux 5.1-rc6

Liran Alon (2):
      KVM: x86: Raise #GP when guest vCPU do not support PMU
      KVM: nVMX: Expose RDPMC-exiting only when guest supports PMU

Lorenzo Bianconi (1):
      net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_r=
ecv

Luca Coelho (1):
      iwlwifi: add support for quz firmwares

Lukas Bulwahn (1):
      MAINTAINERS: normalize Woojung Huh's email address

Mao Han (1):
      perf evsel: Use hweight64() instead of hweight_long(attr.sample_regs_=
user)

Marc Dionne (5):
      rxrpc: Clear socket error
      rxrpc: Make rxrpc_kernel_check_life() indicate if call completed
      rxrpc: Allow errors to be returned from rxrpc_queue_packet()
      afs: Check for rxrpc call completion in wait loop
      afs: Unlock pages for __pagevec_release()

Mark Rutland (1):
      kcov: improve CONFIG_ARCH_HAS_KCOV help text

Martin Leung (1):
      drm/amd/display: extending AUX SW Timeout

Martin Schwidefsky (1):
      s390/3270: fix lockdep false positive on view->lock

Masami Hiramatsu (4):
      kprobes: Fix error check when reusing optimized probes
      x86/kprobes: Verify stack frame on kretprobe
      kprobes: Mark ftrace mcount handler functions nokprobe
      x86/kprobes: Avoid kretprobe recursion bug

Matteo Croce (3):
      percpu: stop printing kernel addresses
      net: thunderx: raise XDP MTU to 1508
      net: thunderx: don't allow jumbo frames with XDP

Mike Looijmans (3):
      iio/gyro/bmg160: Use millidegrees for temperature scale
      iio:chemical:bme680: Fix, report temperature in millidegrees
      iio:chemical:bme680: Fix SPI read interface

Mikulas Patocka (1):
      vt: fix cursor when clearing the screen

Ming Lei (1):
      block: make sure that bvec length can't be overflow

Mircea Caprioru (1):
      staging: iio: ad7192: Fix ad7193 channel address

Nathan Chancellor (3):
      cfg80211: Change an 'else if' into an 'else' in
cfg80211_calculate_bitrate_he
      clocksource/drivers/timer-ti-dm: Remove omap_dm_timer_set_load_start
      arm64: futex: Restore oldval initialization to work around buggy comp=
ilers

Neil Armstrong (1):
      clocksource/drivers/oxnas: Fix OX820 compatible

Nikolay Aleksandrov (3):
      net: bridge: multicast: use rcu to access port list from
br_multicast_start_querier
      net: bridge: fix per-port af_packet sockets
      net: bridge: fix netlink export of vlan_stats_per_port option

Oded Gabbay (1):
      habanalabs: remove low credit limit of DMA #0

Or Gerlitz (1):
      Revert "net/mlx5e: Enable reporting checksum unnecessary also
for L3 packets"

Paolo Bonzini (5):
      KVM: nVMX: allow tests to use bad virtual-APIC page address
      KVM: nVMX: always use early vmcs check when EPT is disabled
      selftests: kvm/evmcs_test: complete I/O before migrating guest state
      selftests: kvm: fix for compilers that do not support -no-pie
      KVM: fix spectrev1 gadgets

Paul Walmsley (1):
      dt-bindings: clock: sifive: add FU540-C000 PRCI clock constants

Peter Oberparleiter (1):
      s390/dasd: Fix capacity calculation for large volumes

Peter Zijlstra (1):
      x86/mm/tlb: Revert "x86/mm: Align TLB invalidation info"

Phil Auld (1):
      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Qian Cai (2):
      slab: store tagged freelist for off-slab slabmgmt
      mm/hotplug: treat CMA pages as unmovable

Rikard Falkeborn (1):
      tools lib traceevent: Fix missing equality check for strcmp

Ronnie Sahlberg (1):
      cifs: fix handle leak in smb2_query_symlink()

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Saeed Mahameed (5):
      net/mlx5: FPGA, tls, hold rcu read lock a bit longer
      net/mlx5: FPGA, tls, idr remove on flow delete
      net/mlx5e: XDP, Avoid checksum complete when XDP prog is loaded
      net/mlx5e: Rx, Fixup skb checksum for packets with tail padding
      net/mlx5e: Rx, Check ip headers sanity

Sami Tolvanen (1):
      x86/build/lto: Fix truncated .bss with -fdata-sections

Saurav Kashyap (1):
      Revert "scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO"

Sean Christopherson (6):
      KVM: x86/mmu: Fix an inverted list_empty() check when zapping sptes
      KVM: x86: Load SMRAM in a single shot when leaving SMM
      KVM: x86: Open code kvm_set_hflags
      KVM: x86: clear SMM flags before loading state while leaving SMM
      KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU
      KVM: x86: Always use 32-bit SMRAM save state for 32-bit kernels

Sergey Larin (1):
      iio: gyro: mpu3050: fix chip ID reading

Sergey Senozhatsky (1):
      kernel/watchdog_hld.c: hard lockup message should end with a newline

Shahar S Matityahu (4):
      iwlwifi: add sync_nmi to trans ops
      iwlwifi: dbg_ini: in case of region dump failure set memory to 0
      iwlwifi: dbg_ini: fix bad dump size calculation
      iwlwifi: use sync nmi in case of init flow failure

Si-Wei Liu (1):
      failover: allow name change on IFF_UP slave interfaces

Song Liu (1):
      perf tools: Check maps for bpf programs

Stanislaw Gruszka (2):
      cfg80211: add ratelimited variants of err and warn
      mt76x02: avoid status_list.lock and sta->rate_ctrl_lock dependency

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Sunil Dutt (1):
      nl80211: Add NL80211_FLAG_CLEAR_SKB flag for other NL commands

Suthikulpanit, Suravee (2):
      Revert "svm: Fix AVIC incomplete IPI emulation"
      svm/avic: Fix invalidate logical APIC id entry

Sven Van Asbroeck (3):
      iio: adc: xilinx: fix potential use-after-free on remove
      iio: adc: xilinx: fix potential use-after-free on probe
      iio: adc: xilinx: prevent touching unclocked h/w on remove

Takashi Iwai (3):
      ALSA: hda: Initialize power_state field properly
      ALSA: info: Fix racy addition/deletion of nodes
      ALSA: core: Fix card races between register and disconnect

Tetsuo Handa (9):
      net/rds: Check address length before reading address family
      mISDN: Check address length before reading address family
      sctp: Check address length before reading address family
      net: netlink: Check address length before reading groups field
      rxrpc: Check address length before reading srx_service field
      Bluetooth: Check address length before reading address field
      llc: Check address length before reading address field
      bpf: Check address length before reading address family
      udpv6: Check address length before reading address family

Thierry Reding (1):
      drm/tegra: hdmi: Setup audio only if configured

Thomas Falcon (2):
      ibmvnic: Enable GRO
      ibmvnic: Fix netdev feature clobbering during a reset

Thomas Gleixner (3):
      x86/speculation: Prevent deadlock on ssb_state::lock
      drivers: power: supply: goldfish_battery: Fix bogus SPDX identifier
      x86/mm: Prevent bogus warnings with "noexec=3Doff"

Tony Camuso (1):
      ipmi: ipmi_si_hardcode.c: init si_type array to fix a crash

Trond Myklebust (1):
      SUNRPC: Ignore queue transmission errors on successful transmission

Tuong Lien (1):
      tipc: fix link established but not in session

Ursula Braun (2):
      net/smc: propagate file from SMC to TCP socket
      net/smc: move unhash before release of clcsock

Vasily Gorbik (1):
      s390: correct some inline assembly constraints

Vijayakumar Durai (1):
      rt2x00: do not increment sequence number while re-transmitting

Vitaly Kuznetsov (3):
      KVM: x86: svm: make sure NMI is injected after nmi_singlestep
      selftests: kvm: add a selftest for SMM
      KVM: x86: avoid misreporting level-triggered irqs as
edge-triggered in tracing

Vitor Soares (2):
      i3c: Fix the verification of random PID
      i3c: dw: Fix dw_i3c_master_disable controller by using correct mask

WANG Chao (1):
      x86/kvm: move kvm_load/put_guest_xcr0 into atomic context

Wang Hai (1):
      Revert "net-sysfs: Fix memory leak in netdev_register_kobject"

Xiaochen Shen (1):
      x86/resctrl: Do not repeat rdtgroup mode initialization

Yangtao Li (1):
      clocksource/drivers/arm_arch_timer: Remove unneeded pr_fmt macro

YueHaibing (2):
      cfg80211: Use kmemdup in cfg80211_gen_new_ie()
      net: netrom: Fix error cleanup path of nr_proto_init

Yuya Kusakabe (1):
      net: Fix missing meta data in skb with vlan packet

ZhangXiaoxu (3):
      cifs: Fix use-after-free in SMB2_write
      cifs: Fix use-after-free in SMB2_read
      cifs: Fix lease buffer length error

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.

luca abeni (1):
      sched/deadline: Correctly handle active 0-lag timers

wentalou (1):
      drm/amdgpu: shadow in shadow_list without tbo.mem.start cause
page fault in sriov TDR

zhong jiang (1):
      mm/memory_hotplug: do not unlock after failing to take the
device_hotplug_lock
