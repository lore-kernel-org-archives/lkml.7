Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA75C5B57D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 03:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE022086D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 03:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561865784;
	bh=hOpwgf1y35GHCFYVv1aNpaQZ29wvIO2TLYc8IbiLsVE=;
	h=From:Date:Subject:To:List-ID:From;
	b=By7e6/jT763T6SDeIMSBfLCg+eUZf4/78QuLEwyhj7hY1xvvoOw3rGiImkhsI+Cot
	 z7Wyab8XrPwr4o1XIPAfVnk3sQIFrWoooKUAlIPDAMGgNf+etTS5+qjKWjypboxrS7
	 Y34JpxN5yN2ukMdt8cBpKv6DdiA6W3S93wiKUBqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfF3DgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 23:36:22 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44206 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF3DgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 23:36:22 -0400
Received: by mail-lj1-f182.google.com with SMTP id k18so9620454ljc.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QMiePC6290Vww5l8oKgG8Pd39m3gAHyj9cIEKmNck1w=;
        b=QC7o/c5AV+YyBZ/q5vF53rPPzQjlkNN0d/s5/YprNqmWP8aVqWEnqje2CL/rypKppl
         oc7GaMCnKBouN3QfDyzicaYNkp8LC0R7EhQD6ZYhXg/8JFudSZIgriGQspOkzAbwMAxI
         AMA8UFZJJiroQBICNI8kUo50owm9AEeJ8KyrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QMiePC6290Vww5l8oKgG8Pd39m3gAHyj9cIEKmNck1w=;
        b=siibsGLg1wjf3j/KEQgMFjPSCk1lqgRTqBPoo3P2j2LxwuG36SwldbXdp2pItRFUMW
         k7oFixktYGNLqO1KRSMZq8IUqr+3lGOPdX7k3N0zm/5ZxwCfXgI5mbFvgiliXtfjkMj/
         Jbmul4iBNiL967t11yvhY0dxRma+GVHrdpzbPkAz/mp8p0MbzQU7UtpDWcgbgs8caIR2
         Z0cvUwflTvRYkssJGxsGHL7lGbF+bYma0uysQc0D2ayeqG7WhRBHyjHfdmDsV0RNhPgD
         GtbOUpWvJ3/fnFg6bR+cdCG5TQksei5qVmC4nQyC5ClzTDoAI1IbdewfwaSdFGwqM2dP
         Bw4w==
X-Gm-Message-State: APjAAAWZobR0oR7v0JuEEkkPql8vn5UtLAv6RJqs/cdHwxS/l6P200RD
        qSVyGDCbE+8PpLBO/fR6uAlPPCt4Ppo=
X-Google-Smtp-Source: APXvYqw5/FBuoslmB+3Cdq6KLVweQ/n7b93GMNzSJrZf6Kuei6sKKeBySna7R9yrCIZj9zIg8rmvZA==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr10092090lji.231.1561865778167;
        Sat, 29 Jun 2019 20:36:18 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h22sm2263906ljj.105.2019.06.29.20.36.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 20:36:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d11so6498418lfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 20:36:17 -0700 (PDT)
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr8802947lfm.61.1561865776697;
 Sat, 29 Jun 2019 20:36:16 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Jun 2019 11:36:00 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgL5GyQ93o=VyiymFPfw=Z0TGHEPBJrCtGSqFSW2Mhx8g@mail.gmail.com>
Message-ID: <CAHk-=wgL5GyQ93o=VyiymFPfw=Z0TGHEPBJrCtGSqFSW2Mhx8g@mail.gmail.com>
Subject: Linux 5.2-rc7
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Sunday afternoon _somewhere_ in the world right now. In
particular, in the middle of nowhere on a boat.

I didn't expect to have any internet this week, and honestly, I
haven't had much, and not fast. But enough to keep up with critical
pull requests, and enough to push out an rc.

But credit for the internet goes to Disk Hohndel and vmware, because
I'm mooching off his phone hotspot WiFi to do this.

Anyway, It's been _fairly_ calm. Would I have hoped for even calmer
with my crappy internet? Sure. But hey, it's a lot smaller than rc6
was and I'm not really complaining.

All small and fairly uninteresting. Arch updates, networking, core
kernel, filesystems, misc drivers. Nothing stands out - just read the
appended shortlog. It's small enough to be easy to just scroll
through.

             Linus

---

Al Viro (1):
      copy_process(): don't use ksys_close() on cleanups

Alejandro Jimenez (1):
      x86/speculation: Allow guests to use SSBD even if host does not

Alexandre Belloni (2):
      pinctrl: ocelot: fix gpio direction for pins after 31
      pinctrl: ocelot: fix pinmuxing for pins after 31

Alexey Brodkin (1):
      ARC: build: Try to guess CROSS_COMPILE with cc-cross-prefix

Andrea Arcangeli (1):
      fork,memcg: alloc_thread_stack_node needs to set tsk->stack

Anshuman Khandual (1):
      mm/dev_pfn: exclude MEMORY_DEVICE_PRIVATE while computing virtual add=
ress

Antoine Tenart (1):
      net: macb: do not copy the mac address if NULL

Ard Biesheuvel (1):
      efi/memreserve: deal with memreserve entries in unmapped memory

Arnd Bergmann (2):
      ARM: omap2: remove incorrect __init annotation
      mm/vmalloc.c: avoid bogus -Wmaybe-uninitialized warning

Atish Patra (1):
      RISC-V: defconfig: enable MMC & SPI for RISC-V

Bj=C3=B8rn Mork (1):
      qmi_wwan: Fix out-of-bounds read

Christian Brauner (1):
      proc: remove useless d_is_dir() check

Colin Ian King (2):
      x86/apic: Fix integer overflow on 10 bit left shift of cpu_khz
      mm/page_idle.c: fix oops because end_pfn is larger than max_pfn

Dan Carpenter (3):
      mfd: stmfx: Uninitialized variable in stmfx_irq_handler()
      mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
      HID: intel-ish-hid: Fix a use after free in load_fw_from_host()

David Howells (4):
      afs: Fix over zealous "vnode modified" warnings
      afs: Fix vlserver record corruption
      afs: Fix uninitialised spinlock afs_volume::cb_break_lock
      afs: Fix setting of i_blocks

Dinh Nguyen (1):
      clk: socfpga: stratix10: fix divider entry for the emac clocks

Dirk van der Merwe (1):
      net/tls: fix page double free on TX cleanup

Dmitry Bogdanov (1):
      net: aquantia: fix vlans not working over bridged network

Dmitry V. Levin (2):
      fork: don't check parent_tidptr with CLONE_PIDFD
      samples: make pidfd-metadata fail gracefully on older kernels

Eiichi Tsukata (2):
      net/ipv6: Fix misuse of proc_dointvec "skip_notify_on_dev_down"
      cpu/hotplug: Fix out-of-bounds read when setting fail state

Eric Dumazet (1):
      net/packet: fix memory leak in packet_set_ring()

Eugeniy Paltsev (1):
      ARC: [plat-hsdk]: unify memory apertures configuration

Florian Fainelli (2):
      MAINTAINERS: BCM2835: Add internal Broadcom mailing list
      MAINTAINERS: BCM53573: Add internal Broadcom mailing list

Geert Uytterhoeven (2):
      cpu/speculation: Warn on unsupported mitigations=3D parameter
      initramfs: fix populate_initrd_image() section mismatch

Gen Zhang (1):
      dm init: fix incorrect uses of kstrndup()

Guo Ren (2):
      irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus
      csky: Fixup libgcc unwind error

Hans de Goede (2):
      efi/bgrt: Drop BGRT status field reserved bits check
      HID: logitech-dj: Fix forwarding of very long HID++ reports

Helge Deller (1):
      parisc: Fix module loading error with JUMP_LABEL feature

Heyi Guo (1):
      irqchip/gic-v3-its: Fix command queue pointer comparison bug

Huang Ying (1):
      mm, swap: fix THP swap out

Huaping Zhou (1):
      net/smc: hold conns_lock before calling smc_lgr_register_conn()

Hyungwoo Yang (1):
      HID: intel-ish-hid: fix wrong driver_data usage

Jan Kara (1):
      scsi: vmw_pscsi: Fix use-after-free in pvscsi_queue_lck()

Jann Horn (1):
      fs/binfmt_flat.c: make load_flat_shared_library() work

Jeff Layton (1):
      ceph: fix ceph_mdsc_build_path to not stop on first component

Jens Axboe (1):
      io_uring: ensure req->file is cleared on allocation

Jerome Brunet (1):
      clk: meson: fix MPLL 50M binding id typo

Jerome Marchand (1):
      dm table: don't copy from a NULL pointer in realloc_argv()

Johannes Weiner (1):
      mm: fix page cache convergence regression

John Ogness (1):
      fs/proc/array.c: allow reporting eip/esp for all coredumping threads

Jon Hunter (1):
      clk: tegra210: Fix default rates for HDA clocks

Josh Poimboeuf (1):
      x86/unwind/orc: Fall back to using frame pointers for generated code

Kai-Heng Feng (1):
      HID: multitouch: Add pointstick support for ALPS Touchpad

Kan Liang (5):
      perf/x86: Disable extended registers for non-supported PMUs
      perf/x86/regs: Check reserved bits
      perf/x86: Clean up PEBS_XMM_REGS
      perf/x86: Remove pmu->pebs_no_xmm_regs
      perf/x86/regs: Use PERF_REG_EXTENDED_MASK

Kirill A. Shutemov (3):
      x86/boot/64: Fix crash if kernel image crosses page table boundary
      x86/boot/64: Add missing fixup_pointer() for next_early_pgt access
      x86/mm: Handle physical-virtual alignment mismatch in phys_p4d_init()

Kyle Godbey (1):
      HID: uclogic: Add support for Huion HS64 tablet

Li Yang (1):
      arm64: defconfig: Enable FSL_EDMA driver

Linus Torvalds (1):
      Linux 5.2-rc7

Linus Walleij (2):
      ARM: dts: Blank D-Link DIR-685 console
      ARM: dts: gemini Fix up DNS-313 compatible string

Marek Vasut (1):
      net: dsa: microchip: Use gpiod_set_value_cansleep()

Martin Blumenstingl (4):
      clk: meson: meson8b: fix a typo in the VPU parent names array variabl=
e
      ARM: dts: meson8: fix GPU interrupts and drop an undocumented propert=
y
      ARM: dts: meson8b: drop undocumented property from the Mali GPU node
      ARM: dts: meson8b: fix the operating voltage of the Mali GPU

Matthew Wilcox (1):
      XArray tests: Add check_insert

Matthew Wilcox (Oracle) (1):
      idr: Fix idr_get_next race with idr_remove

Michael Ellerman (2):
      powerpc/mm/64s/hash: Reallocate context ids on fork
      selftests/powerpc: Add test of fork with mapping above 512TB

Milan Broz (1):
      dm verity: use message limit for data block corruption message

Naoya Horiguchi (2):
      mm: soft-offline: return -EBUSY if set_hwpoison_free_buddy_page() fai=
ls
      mm: hugetlb: soft-offline: dissolve_free_huge_page() return zero
on !PageHuge

Neil Horman (1):
      af_packet: Block execution of tasks waiting for transmit to
complete in AF_PACKET

Nicholas Piggin (1):
      powerpc/64s/exception: Fix machine check early corrupting AMR

Nick Desaulniers (1):
      MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info

Nicolas Boichat (2):
      pinctrl: mediatek: Ignore interrupts that are wake only during resume
      pinctrl: mediatek: Update cur_mask in mask/mask ops

Nicolas Dichtel (2):
      ipv6: constify rt6_nexthop()
      ipv6: fix neighbour resolution with raw socket

Oleg Nesterov (1):
      signal: remove the wrong signal_pending() check in restore_user_sigma=
sk()

Oleksandr Natalenko (1):
      HID: chicony: add another quirk for PixArt mouse

Paolo Valente (1):
      block, bfq: fix operator in BFQQ_TOTALLY_SEEKY

Paul Burton (1):
      irqchip/mips-gic: Use the correct local interrupt map registers

Paul Walmsley (2):
      dt-bindings: riscv: resolve 'make dt_binding_check' warnings
      dt-bindings: clock: sifive: add MIT license as an option for the
header file

Peter Ujfalusi (1):
      irqchip/ti-sci-inta: Fix kernel crash if irq_create_fwspec_mapping fa=
il

Peter Zijlstra (1):
      perf/core: Fix perf_sample_regs_user() mm check

Petr Oros (1):
      be2net: fix link failure after ethtool offline test

Phil Reid (1):
      pinctrl: mcp23s08: Fix add_data and irqchip_add_nested call order

Qian Cai (1):
      x86/efi: fix a -Wtype-limits compilation warning

Rafael J. Wysocki (1):
      PCI: PM: Avoid skipping bus-level PM on platforms without ACPI

Ran Wang (1):
      arm64: dts: ls1028a: Fix CPU idle fail.

Ravi Bangoria (1):
      perf/ioctl: Add check for the sample_period value

Reinette Chatre (1):
      x86/resctrl: Prevent possible overrun during bitmap operations

Roland Hii (2):
      net: stmmac: fixed new system time seconds value calculation
      net: stmmac: set IC bit when transmitting frames with HW timestamp

Sascha Hauer (1):
      mtd: rawnand: initialize ntargets with maxchips

Sergej Benilov (1):
      sis900: fix TX completion

ShihPo Hung (1):
      riscv: mm: Fix code comment

Song Liu (1):
      perf/x86: Always store regs->ip in perf_callchain_kernel()

Souptick Joarder (2):
      auxdisplay/cfag12864bfb.c: Convert to use vm_map_pages_zero()
      auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()

Stephen Boyd (2):
      clk: Do a DT parent lookup even when index < 0
      dm init: remove trailing newline from calls to DMERR() and DMINFO()

Stephen Suryaputra (2):
      ipv4: Use return value of inet_iif() for __raw_v4_lookup in the while=
 loop
      ipv4: reset rt_iif for recirculated mcast/bcast out pkts

S=C3=A9bastien Szymanski (1):
      ARM: dts: imx6ul: fix PWM[1-4] interrupts

Takashi Iwai (1):
      ppp: mppe: Add softdep to arc4

Thomas Gleixner (1):
      x86/microcode: Fix the microcode load on CPU hotplug for real

Tian Baofeng (1):
      efibc: Replace variable set function in notifier call

Tony Lindgren (1):
      clk: ti: clkctrl: Fix returning uninitialized data

Trond Myklebust (2):
      SUNRPC: Fix up calculation of client message length
      NFS/flexfiles: Use the correct TCP timeout for flexfiles I/O

Tudor Ambarus (1):
      mtd: spi-nor: use 16-bit WRR command when QE is set on spansion flash=
es

Vinod Koul (1):
      linux/kernel.h: fix overflow for DIV_ROUND_UP_ULL

Xin Long (3):
      tipc: change to use register_pernet_device
      tipc: check msg->req data len in tipc_nl_compat_bearer_disable
      sctp: change to hold sk after auth shkey is created successfully

Yafang Shao (1):
      mm/oom_kill.c: fix uninitialized oc->constraint

Yash Shah (1):
      riscv: dts: Re-organize the DT nodes

YueHaibing (4):
      net/sched: cbs: Fix error path of cbs_module_init
      bonding: Always enable vlan tx offload
      net/smc: Fix error path in smc_init
      team: Always enable vlan tx offload

zhangyi (F) (1):
      dm log writes: make sure super sector log updates are written in orde=
r

zhong jiang (1):
      mm/mempolicy.c: fix an incorrect rebind node in mpol_rebind_nodemask
