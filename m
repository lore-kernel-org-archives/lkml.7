Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 17:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4730120717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572198718;
	bh=hs+SiYgASCroz0aA0QWo0CtuNIUZ9eGpWcDMz4o+lNQ=;
	h=From:Date:Subject:To:List-ID:From;
	b=y45juU4VOkR0tyzQWtbg4GypR7EUSOENPLjoHbzZJkIMGYi3KMkr8fvRXdaYXprr5
	 mjW9t1+36VR/PCr4Kw6T5cOnnE4e6suw8hj87T3qFnXYA8UfWYgDhV2gwC3bZoKWJa
	 tf6dWEsDxLMK5zAO9xr3mrMpbXF6DlpgWdK7l2uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfJ0Rv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 13:51:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43981 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfJ0Rv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 13:51:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id v24so6019025lfe.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/Fhc02mGS9e9VQXVxKanrHcoSe6T4N8KCWlOjEfyTQM=;
        b=Q6GZJxWutwXo/PWJROAk/CxUifF/QXkE2yACylugp3knmj3NjEfv+AK0ETzWQB4uH9
         Zr72KjalFkRYPnWWD8RH5gORNToBajqZjTLaU4UFmZlXgOpaFEg9EwuT9hkJmasky4yt
         NLR1e0htUVBXRW2Zv8IYGjtMifxslZqRpvZ9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/Fhc02mGS9e9VQXVxKanrHcoSe6T4N8KCWlOjEfyTQM=;
        b=Qo2e4QHCkIgeigbMJvjNjmyldbiUP+Lo9rdU3eCizgh6GmNk8I2yZgYOGNBaECvZZR
         Q7FqhkcZ1qk7pl2Xn2w2t8CdMBYdZsesTYcEs+N41tB2axcJIHatmKfqAPR4CEQH6iWa
         OB07p7ZxMh+R/cWmhQizAeQLPpPiXRwXSFc8bsL4lzye+si5vTGDuGWLmFbd0HGWl0Tw
         hhT26nUpPlQDvX4XAlqoUUZyy2s1hIXnZNubLE9vme25oNj4bH8Pe/+0ZaqV6au5YXnS
         wHdn2Vd9CzkpHpaQG3/ecDXhRhDBOzt5QvzyVtVX0xPiD/B1bvtjT+qScD5cg7mp1R67
         ibbw==
X-Gm-Message-State: APjAAAXM/qyiKmHY5DXwuAmjQOq45gIXzSWsksFsxx03aR2Hd6YgB5Be
        DH75RxOQSFRGJt1AD1grLYOG7++53QfO1A==
X-Google-Smtp-Source: APXvYqyP3kimvXBjAXBExpY48m2MvcaDp3tHLRdVG3m/HTskK603LQ9KusGKtdksKTEwnsYiakxvbQ==
X-Received: by 2002:ac2:44d5:: with SMTP id d21mr2386289lfm.66.1572198712523;
        Sun, 27 Oct 2019 10:51:52 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m28sm4867391ljc.96.2019.10.27.10.51.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 10:51:50 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id t8so5997093lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 10:51:50 -0700 (PDT)
X-Received: by 2002:a19:c790:: with SMTP id x138mr1832566lff.61.1572198710242;
 Sun, 27 Oct 2019 10:51:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 13:51:33 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgpewLxHxnO71tFHh=M4C4iUofJykMqq3r=eRyxUyVsiw@mail.gmail.com>
Message-ID: <CAHk-=wgpewLxHxnO71tFHh=M4C4iUofJykMqq3r=eRyxUyVsiw@mail.gmail.com>
Subject: Linux 5.4-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So usually by this time, I wish things were calming down. We've had a
few fairly small rc's so far in the 5.4 series, and sadly rc5 isn't
shrinking from that smaller baseline.

So unlike the previous rc's that were on the smaller side compared to
recent releases, 5.4-rc5 is a bit _bigger_ than the rc5's of the last
few releases. It's not huge, by any means, and partly exactly because
previous rc's were small, I'm going to treat it as just some pent-up
work going in, and I'm not worried.

So things still seem pretty normal, and none of the patches look all
that scary to me.

I'm still on the road, with OSS EU starting tomorrow, but apart from a
few long flights I should be fairly normally responsive and my travels
shouldn't be impacting the upcoming week. Particularly since I hope
that we'll at least start seeing a proper calming down period for rc6.

Anyway, shortlog is appended below for people who want to scan the
details. It's all very normal, with about half of the patch being
drivers (sound, pinctrl, regulator, gpu, cpufreq, usb..), with the
rest being arch updates, filesystem updates, misc core stuff and
documentation.

So we have a bit more fixes than normal during this stage, but nothing
looks very strange, and the diffstat looks _mostly_ flat (with the
cpufrequency power-QoS and io_uring changes looking a bit bigger)
which is my sign for "small changes all over".

Go test,

          Linus

---

Adam Ford (2):
      ARM: dts: logicpd-torpedo-som: Remove twl_keypad
      ARM: dts: imx6q-logicpd: Re-Enable SNVS power key

Adrian Hunter (1):
      perf tools: Fix mode setting in copyfile_mode_ns()

Alain Volmat (1):
      i2c: stm32f7: remove warning when compiling with W=3D1

Alan Mikhak (1):
      irqchip/sifive-plic: Skip contexts except supervisor in plic_init()

Alex Deucher (4):
      drm/amdgpu/uvd6: fix allocation size in enc ring test (v2)
      drm/amdgpu/uvd7: fix allocation size in enc ring test (v2)
      drm/amdgpu/vcn: fix allocation size in enc ring test
      drm/amdgpu/vce: fix allocation size in enc ring test

Alexander Shishkin (1):
      perf/aux: Fix AUX output stopping

Allen Pais (1):
      scsi: qla2xxx: fix a potential NULL pointer dereference

Amelie Delaunay (1):
      pinctrl: stmfx: fix null pointer on remove

Andi Kleen (1):
      perf evlist: Fix fix for freed id arrays

Andrew Jeffery (4):
      dt-bindings: pinctrl: aspeed-g6: Rework SD3 function and groups
      pinctrl: aspeed-g6: Sort pins for sanity
      pinctrl: aspeed-g6: Fix I2C14 SDA description
      pinctrl: aspeed-g6: Make SIG_DESC_CLEAR() behave intuitively

Andrew Price (1):
      gfs2: Fix memory leak when gfs2meta's fs_context is freed

Andrey Smirnov (2):
      ARM: dts: am3874-iceboard: Fix 'i2c-mux-idle-disconnect' usage
      ARM: dts: vf610-zii-scu4-aib: Specify 'i2c-mux-idle-disconnect'

Andy Shevchenko (1):
      pinctrl: intel: Allocate IRQ chip dynamic

Anson Huang (5):
      soc: imx: imx-scu: Getting UID from SCU should have response
      ARM: dts: imx7s: Correct GPT's ipg clock source
      arm64: dts: imx8mq: Use correct clock for usdhc's ipg clk
      arm64: dts: imx8mm: Use correct clock for usdhc's ipg clk
      arm64: dts: imx8mn: Use correct clock for usdhc's ipg clk

Arnaldo Carvalho de Melo (4):
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers kvm: Sync kvm.h headers with the kernel sources
      tools headers UAPI: Sync sched.h with the kernel

Arvind Sankar (1):
      iommu/vt-d: Return the correct dma mask when we are bypassing the IOM=
MU

Axel Lin (2):
      regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF
      regulator: ti-abb: Fix timeout in
ti_abb_wait_txdone/ti_abb_clear_all_txdone

Baolin Wang (1):
      MAINTAINERS: Update the Spreadtrum SoC maintainer

Bard Liao (1):
      ASoC: intel: sof_rt5682: use separate route map for dmic

Bart Van Assche (1):
      scsi: ch: Make it possible to open a ch device multiple times again

Bartosz Golaszewski (1):
      ARM: davinci_all_defconfig: enable GPIO backlight

Ben Dooks (Codethink) (1):
      timers/sched_clock: Include local timekeeping.h for missing declarati=
ons

Bodo Stroesser (1):
      scsi: target: core: Do not overwrite CDB byte 1

Charles Keepax (1):
      regulator: lochnagar: Add on_off_delay for VDDCORE

Chris Goldsworthy (1):
      of: reserved_mem: add missing of_node_put() for proper ref-counting

Chris Packham (1):
      pinctrl: iproc: allow for error from platform_get_irq()

Christian K=C3=B6nig (2):
      drm/amdgpu: fix potential VM faults
      drm/amdgpu: fix error handling in amdgpu_bo_list_create

Christoph Hellwig (2):
      riscv: cleanup <asm/bug.h>
      riscv: cleanup do_trap_break

Chuhong Yuan (2):
      ASoC: Intel: sof-rt5682: add a check for devm_clk_get
      cifs: Fix missed free operations

Colin Ian King (2):
      staging: wlan-ng: fix exit return when sme->key_idx >=3D NUM_WEPKEYS
      8250-men-mcb: fix error checking when get_num_ports returns -ENODEV

Dan Carpenter (5):
      ASoC: soc-component: fix a couple missing error assignments
      ASoC: topology: Fix a signedness bug in soc_tplg_dapm_widget_create()
      pinctrl: ns2: Fix off by one bugs in ns2_pinmux_enable()
      USB: legousbtower: fix a signedness bug in tower_probe()
      ACPI: NFIT: Fix unlock on error in scrub_show()

Dan Williams (1):
      fs/dax: Fix pmd vs pte conflict detection

Daniel Baluta (1):
      ASoC: simple_card_utils.h: Fix potential multiple redefinition error

Dave Wysochanski (1):
      cifs: Fix cifsInodeInfo lock_sem deadlock when reconnect occurs

David Abdurachmanov (1):
      riscv: fix fs/proc/kcore.c compilation with sparsemem enabled

David Sterba (1):
      btrfs: don't needlessly create extent-refs kernel thread

Dixit Parmar (1):
      Input: st1232 - fix reporting multitouch coordinates

Dmitry Torokhov (1):
      pinctrl: cherryview: restore Strago DMI workaround for all versions

Don Brace (1):
      scsi: hpsa: add missing hunks in reset-patch

Douglas Anderson (1):
      arm64: dts: rockchip: Fix override mode for rk3399-kevin panel

Dragos Tarcatu (1):
      ASoC: SOF: control: return true when kcontrol values change

Fabien Parent (1):
      i2c: mt65xx: fix NULL ptr dereference

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Enable CONFIG_DRM_MSM

Fabrice Gasnier (2):
      i2c: stm32f7: fix first byte to send in slave mode
      i2c: stm32f7: fix a race in slave mode with arbitration loss irq

Faiz Abbas (2):
      mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
      mmc: cqhci: Commit descriptors before setting the doorbell

Filipe Manana (3):
      Btrfs: add missing extents release on file extent cluster relocation =
error
      Btrfs: fix qgroup double free after failure to reserve metadata
for delalloc
      Btrfs: check for the full sync flag while holding the inode lock
during fsync

Florian Fainelli (1):
      MAINTAINERS: Remove Gregory and Brian for ARCH_BRCMSTB

Frank Wunderlich (1):
      mfd: mt6397: Fix probe after changing mt6397-core

Gerald Schaefer (1):
      s390/kaslr: add support for R_390_GLOB_DAT relocation type

Greg Kurz (1):
      KVM: PPC: Book3S HV: XIVE: Ensure VP isn't already in use

Gustavo A. R. Silva (2):
      perf annotate: Fix multiple memory and file descriptor leaks
      usb: udc: lpc32xx: fix bad bit shift operation

Hannes Reinecke (2):
      scsi: scsi_dh_alua: handle RTPG sense code correctly during
state transitions
      scsi: lpfc: remove left-over BUILD_NVME defines

Hans de Goede (1):
      ASoC: core: Fix pcm code debugfs error

Heiko Stuebner (1):
      dt-bindings: arm: rockchip: fix Theobroma-System board bindings

Hugh Cole-Baker (1):
      arm64: dts: rockchip: fix Rockpro64 RK808 interrupt line

Jae Hyun Yoo (1):
      i2c: aspeed: fix master pending state handling

James Morse (1):
      EDAC/ghes: Fix Use after free in ghes_edac remove path

Jann Horn (1):
      binder: Don't modify VMA bounds in ->mmap handler

Jaska Uimonen (3):
      ASoC: rt5682: add NULL handler to set_jack function
      ASoC: intel: sof_rt5682: add remove function to disable jack
      ASoC: intel: bytcr_rt5651: add null check to support_button_press

Jens Axboe (3):
      io_uring: revert "io_uring: optimize submit_and_wait API"
      io_uring: used cached copies of sq->dropped and cq->overflow
      io_uring: fix bad inflight accounting for SETUP_IOPOLL|SETUP_SQTHREAD

Jernej Skrabec (2):
      arm64: dts: allwinner: a64: pine64-plus: Add PHY regulator delay
      arm64: dts: allwinner: a64: sopine-baseboard: Add PHY regulator delay

Jessica Yu (1):
      scripts/nsdeps: use alternative sed delimiter

Jim Mattson (2):
      kvm: x86: Expose RDPID in KVM_GET_SUPPORTED_CPUID
      KVM: nVMX: Don't leak L1 MMIO regions to L2

Jiri Olsa (1):
      perf/x86/intel/pt: Fix base for single entry topa

Jisheng Zhang (1):
      pinctrl: berlin: as370: fix a typo s/spififib/spdifib

Joerg Roedel (1):
      vfio/type1: Initialize resv_msi_base

Johan Hovold (7):
      USB: ldusb: fix memleak on disconnect
      USB: legousbtower: fix memleak on disconnect
      USB: usblp: fix use-after-free on disconnect
      USB: serial: ti_usb_3410_5052: fix port-close races
      USB: serial: ti_usb_3410_5052: clean up serial data access
      USB: ldusb: fix read info leaks
      s390/zcrypt: fix memleak at release

Johnny Huang (3):
      pinctrl: aspeed-g6: Fix I3C3/I3C4 pinmux configuration
      pinctrl: aspeed-g6: Fix UART13 group pinmux
      pinctrl: aspeed-g6: Rename SD3 to EMMC and rework pin groups

Jonas Gorski (1):
      MIPS: bmips: mark exception vectors as char arrays

Josef Bacik (2):
      nbd: protect cmd->status with cmd->lock
      nbd: handle racing with error'ed out commands

Juergen Gross (1):
      xen: issue deprecation warning for 32-bit pv guest

Junya Monden (1):
      ASoC: rsnd: Reinitialize bit clock inversion flag for every format se=
tting

Kai Vehmanen (2):
      ASoC: SOF: pcm: fix resource leak in hw_free
      ASoC: SOF: Intel: hda: fix warnings during FW load

Kailang Yang (1):
      ALSA: hda/realtek - Add support for ALC711

Kefeng Wang (2):
      riscv: Fix implicit declaration of 'page_to_section'
      riscv: Fix undefined reference to vmemmap_populate_basepages

Keyon Jie (1):
      ASoC: SOF: topology: fix parse fail issue for byte/bool tuple types

Kiran Gunda (1):
      regulator: qcom-rpmh: Fix PMIC5 BoB min voltage

Li Xu (1):
      ASoC: wm_adsp: Fix theoretical NULL pointer for alg_region

Liam Girdwood (1):
      ASoC: SOF: Intel: initialise and verify FW crash dump data.

Linus Torvalds (1):
      Linux 5.4-rc5

Linus Walleij (1):
      pinctrl: bcm-iproc: Use SPDX header

Liran Alon (1):
      KVM: VMX: Remove specialized handling of unexpected exit-reasons

Lucas Stach (1):
      arm64: dts: zii-ultra: fix ARM regulator states

Marc Zyngier (4):
      KVM: arm64: pmu: Fix cycle counter truncation
      arm64: KVM: Handle PMCR_EL0.LC as RES1 on pure AArch64 systems
      KVM: arm64: pmu: Set the CHAINED attribute before creating the
in-kernel event
      KVM: arm64: pmu: Reset sample period on overflow handling

Marco Felsch (3):
      regulator: of: fix suspend-min/max-voltage parsing
      regulator: core: make regulator_register() EPROBE_DEFER aware
      regulator: da9062: fix suspend_enable/disable preparation

Marek Beh=C3=BAn (1):
      arm64: dts: armada-3720-turris-mox: convert usb-phy to phy-supply

Marek Szyprowski (1):
      opp: core: Revert "add regulators enable and disable"

Mark Brown (1):
      ata: libahci_platform: Fix regulator_get_optional() misuse

Masahiro Yamada (1):
      ARM: 8908/1: add __always_inline to functions called from
__get_user_check()

Matthias Maennich (3):
      modpost: delegate updating namespaces to separate function
      modpost: make updating the symbol namespace explicit
      symbol namespaces: revert to previous __ksymtab name scheme

Maxime Ripard (2):
      dt-bindings: media: sun4i-csi: Drop the module clock
      ARM: dts: sun7i: Drop the module clock from the device tree

Miaohe Lin (1):
      KVM: SVM: Fix potential wrong physical id in avic_handle_ldr_update

Mihail Atanassov (2):
      drm/komeda: Don't flush inactive pipes
      drm/komeda: Fix typos in komeda_splitter_validate

Mike Christie (1):
      nbd: verify socket is supported during setup

Navid Emamdoost (1):
      of: unittest: fix memory leak in unittest_data_add

Nayna Jain (1):
      sysfs: Fixes __BIN_ATTR_WO() macro

Olivier Moysan (1):
      ASoC: stm32: sai: fix sysclk management on shutdown

Pan Xiuli (2):
      ASoC: SOF: pcm: harden PCM STOP sequence
      ALSA: hda: Add Tigerlake/Jasperlake PCI ID

Paolo Bonzini (1):
      kvm: clear kvmclock MSR on reset

Patrice Chotard (1):
      ARM: dts: stm32: relax qspi pins slew-rate for stm32mp157

Patrick Williams (2):
      pinctrl: armada-37xx: fix control of pins 32 and up
      pinctrl: armada-37xx: swap polarity on LED group

Paul Burton (2):
      MAINTAINERS: Use @kernel.org address for Paul Burton
      MIPS: tlbex: Fix build_restore_pagemask KScratch restore

Paulo Alcantara (SUSE) (1):
      cifs: Handle -EINPROGRESS only when noblockcnt is set

Pavel Begunkov (3):
      io_uring: Fix corrupted user_data
      io_uring: Fix broken links with offloading
      io_uring: Fix race for sqes with userspace

Pavel Shilovsky (2):
      CIFS: Fix retry mid list corruption on reconnects
      CIFS: Fix use after free of file info structures

Pawel Laszczak (1):
      usb: cdns3: Fix dequeue implementation.

Peter Ujfalusi (1):
      ARM: davinci: dm365: Fix McBSP dma_slave_map entry

Philip Yang (1):
      drm/amdgpu: user pages array memory leak fix

Philippe Schenker (1):
      dt-bindings: fixed-regulator: fix compatible enum

Pierre-Louis Bossart (1):
      ASoC: SOF: loader: fix kernel oops on firmware boot failure

Pragnesh Patel (1):
      media: dt-bindings: Fix building error for dt_binding_check

Prateek Sood (1):
      tracing: Fix race in perf_trace_buf initialization

Qu Wenruo (4):
      btrfs: block-group: Fix a memory leak due to missing
btrfs_put_block_group()
      btrfs: qgroup: Always free PREALLOC META reserve in
btrfs_delalloc_release_extents()
      btrfs: tracepoints: Fix wrong parameter order for qgroup events
      btrfs: tracepoints: Fix bad entry members of qgroup events

Rafael J. Wysocki (3):
      PM: QoS: Introduce frequency QoS
      cpufreq: Use per-policy frequency QoS
      PM: QoS: Drop frequency QoS types from device PM QoS

Ran Wang (1):
      arm64: dts: lx2160a: Correct CPU core idle state name

Ranjani Sridharan (1):
      ASoC: SOF: Intel: hda: Disable DMI L1 entry during capture

Rayagonda Kokatanur (1):
      arm64: dts: Fix gpio to pinmux mapping

Rob Herring (1):
      dt-bindings: riscv: Fix CPU schema errors

Roberto Bergantinos Corpas (1):
      CIFS: avoid using MID 0xFFFF

Robin Murphy (1):
      ASoc: rockchip: i2s: Fix RPM imbalance

Roger Quadros (1):
      usb: cdns3: Error out if USB_DR_MODE_UNKNOWN in cdns3_core_init_role(=
)

Russell King (3):
      drivers/amba: fix reset control error handling
      ARM: mm: fix alignment handler faults under memory pressure
      ARM: mm: alignment: use "u32" for 32-bit instructions

Sascha Hauer (1):
      mmc: mxs: fix flags passed to dmaengine_prep_slave_sg

Sathyanarayana Nujella (1):
      ASoC: max98373: check for device node before parsing

Simon Arlott (1):
      mailmap: Add Simon Arlott (replacement for expired email address)

Soeren Moch (3):
      arm64: dts: rockchip: fix RockPro64 vdd-log regulator settings
      arm64: dts: rockchip: fix RockPro64 sdhci settings
      arm64: dts: rockchip: fix RockPro64 sdmmc settings

Srinivas Kandagatla (1):
      ASoC: msm8916-wcd-digital: add missing MIX2 path for RX1/2

Stefan Wahren (3):
      MAINTAINERS: Add BCM2711 to BCM2835 ARCH
      ARM: dts: bcm2835-rpi-zero-w: Fix bus-width of sdhci
      ARM: dts: bcm2837-rpi-cm3: Avoid leds-gpio probing issue

Steve French (1):
      cifs: clarify comment about timestamp granularity for old servers

Stuart Henderson (1):
      ASoC: wm_adsp: Don't generate kcontrols without READ flags

Sudeep Holla (1):
      cpufreq: Cancel policy update work scheduled before freeing

Suman Anna (2):
      ARM: OMAP2+: Plug in device_enable/idle ops for IOMMUs
      ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU

Sylwester Nawrocki (2):
      ASoC: samsung: arndale: Add missing OF node dereferencing
      ASoC: wm8994: Do not register inapplicable controls for WM1811

Takashi Iwai (1):
      ALSA: usb-audio: Fix copy&paste error in the validator

Tero Kristo (1):
      ARM: dts: omap5: fix gpu_cm clock provider name

Thomas Bogendoerfer (2):
      scsi: sni_53c710: fix compilation error
      scsi: fix kconfig dependency warning related to 53C700_LE_ON_BE

Thomas Gleixner (1):
      lib/vdso: Make clock_getres() POSIX compliant again

Thomas Hellstrom (2):
      x86/cpu/vmware: Use the full form of INL in VMWARE_HYPERCALL,
for clang/llvm
      x86/cpu/vmware: Fix platform detection VMWARE_PORT macro

Thomas Richter (2):
      perf jvmti: Link against tools/lib/ctype.h to have weak strlcpy()
      perf/aux: Fix tracking of auxiliary trace buffer allocation

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Fix selected panels after generic panel cha=
nges
      ARM: dts: Use level interrupt for omap4 & 5 wlcore
      bus: ti-sysc: Fix watchdog quirk handling

Vasily Khoruzhick (1):
      arm64: dts: allwinner: a64: Drop PMU node

Vincenzo Frascino (1):
      mips: vdso: Fix __arch_get_hw_counter()

Viresh Kumar (2):
      opp: of: drop incorrect lockdep_assert_held()
      opp: Reinitialize the list_kref before adding the static OPPs again

Vitaly Kuznetsov (5):
      selftests: kvm: synchronize .gitignore to Makefile
      selftests: kvm: vmx_set_nested_state_test: don't check for VMX
support twice
      selftests: kvm: consolidate VMX support checks
      selftests: kvm: vmx_dirty_log_test: skip the test when VMX is
not supported
      selftests: kvm: fix sync_regs_test with newer gccs

Vivek Unune (1):
      arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box

Vladimir Murzin (1):
      ARM: 8914/1: NOMMU: Fix exc_ret for XIP

Wanpeng Li (1):
      KVM: Don't shrink/grow vCPU halt_poll_ns if host side polling is disa=
bled

Yi Wang (1):
      posix-cpu-timers: Fix two trivial comments

Yizhuo (1):
      regulator: pfuze100-regulator: Variable "val" in
pfuze100_regulator_probe() could be uninitialized

Yufen Yu (1):
      scsi: core: try to get module before removing device

Yunfeng Ye (3):
      perf tools: Fix resource leak of closedir() on the error paths
      perf c2c: Fix memory leak in build_cl_output()
      perf kmem: Fix memory leak in compact_gfp_flags()

Zenghui Yu (1):
      irqchip/gic-v3-its: Use the exact ITSList for VMOVP

Zhengjun Xing (1):
      tracing: Fix "gfp_t" format for synthetic events

Zhenzhong Duan (1):
      cpuidle: haltpoll: Take 'idle=3D' override into account

afzal mohammed (1):
      ARM: 8926/1: v7m: remove register save to stack before svc

kbuild test robot (1):
      KVM: x86: fix bugon.cocci warnings

zhangyi (F) (2):
      io_uring : correct timeout req sequence when waiting timeout
      io_uring: correct timeout req sequence when inserting a new entry
