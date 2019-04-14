Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D189DC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 22:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7218B2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555281670;
	bh=i/FtWVjmrR3MPIheDanzXn7vN2j56CF+ZAirxk0Y2kg=;
	h=From:Date:Subject:To:List-ID:From;
	b=DzArcZgdq0z3XJ7XO02jC+mIdSMULrPIduRQ9Pxgytod65lhM4YiGI7lLPNSzc03U
	 Mp6TvRDf9m/QEzpEt6XWmFVA/5Hv7AIRl6mKXvHkIcTEwjDOYuaYo5sEHFj5aCsajs
	 yUWom96LjOVvQKyVGYOl0hVjZTHrajP8vlfgnLwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfDNWlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 18:41:08 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:39282 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfDNWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 18:41:08 -0400
Received: by mail-lf1-f54.google.com with SMTP id z9so11503774lfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KXbYQP7qgnb51ldZq/UC9W17PpZdGbbmUC2W02KbF9w=;
        b=Rq5DgUBzE9uBbawVJYqKnfyl+W3dqdcaGI1IkIH2o4E3ZM7N0eMWmCcnpa6gzGCB1T
         NeENND9kjTnWI+yT7i0Fr+wVljLkHCgamvEhWNo6idQKbz+9kGLQbX/Blu+eKxPrcpBy
         FLiu969chRHOmFmGps6EtB4HjfkbgEIHT66k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KXbYQP7qgnb51ldZq/UC9W17PpZdGbbmUC2W02KbF9w=;
        b=KhhiSNDclSvqnMMRfKC/UWA1nBx1c+7l7xSJr9LxHza4YWlt06ElMP4U6Vy/0Q5yZr
         BI6cv8zAdbbpRv1Jg4t6tklBMKmxS7QmozoOEJ+Fd8CX/b8DawYkC+7n4IgR8tj/NWrS
         LWWX4tQjQYquyGYyyPMYPcCJHuk3rTbXigL5zIZTtXqyN+dEL61YalWQrPk/nnkeLrVE
         9FbKyaDTi/mfr2/pXJ+GDEbkrMo4NNFDNv8lIrXPsGo+o6/VaImAhLNKXvrAr3zwopF0
         /tB3eOcX9aiNrM04ipzVEf86q1Ok4hEcZqIVSOx1M4eP+iTbMPBliqMBVmk1Bh/Mvz5B
         oJsw==
X-Gm-Message-State: APjAAAUeRfEkEa6YGezgNvohoHjiyBz6YMgAkOj8slZHaWqwoc/oG6Gq
        9Tj9pdzz7464853xvsK55RKREhYkGIs=
X-Google-Smtp-Source: APXvYqwfwgwjyi8E/e2CqBrAPVxNkbK4d760/OAKJbvfP/QjHMf80lMqQObkJUe+qAU03r1BqYYn8g==
X-Received: by 2002:a19:e619:: with SMTP id d25mr9406901lfh.66.1555281664797;
        Sun, 14 Apr 2019 15:41:04 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a24sm9660834ljd.32.2019.04.14.15.41.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 15:41:03 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id o19so7197509lfl.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 15:41:03 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr9108930lfn.62.1555281663251;
 Sun, 14 Apr 2019 15:41:03 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Apr 2019 15:40:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
Message-ID: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
Subject: Linux 5.1-rc5
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here we go again.. It's Sunday afternoon, must mean another rc kernel.

We have changes all over, but not unseasonably many of them, and most
of the ones here are very small. Looking at the stats, the sound
driver updates kind of stand out, being almost a third of the patch
(and about a third of the commits too, so it's not because of some
single big patch). But none of it looks all that scary.

Outside of the sound fixes, another third is other drivers (gpu, rdma,
nvme, mmc, block layer..) and the last third is "misc". That includes
arch updates, tooling, and various core fixes (networking, filesystem,
security modules, and core kernel/mm).

Nothing in here makes me feel uncomfortable about this release cycle
so far. Knock wood.

Shortlog appended with an overview of the details, as usual.

            Linus

---

Alex Deucher (1):
      drm/amdkfd: Add picasso pci id

Alexander Potapenko (1):
      x86/asm: Use stricter assembly constraints in bitops

Anand Jain (2):
      btrfs: prop: fix zstd compression parameter validation
      btrfs: prop: fix vanished compression property after failed set

Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Andrei Vagin (1):
      alarmtimer: Return correct remaining time

Annaliese McDermond (2):
      ASoC: tlv320aic32x4: Fix Common Pins
      ASoC: tlv320aic32x4: Change author's name

Ard Biesheuvel (1):
      arm64/ftrace: fix inadvertent BUG() in trampoline check

Arnaud Pouliquen (1):
      ASoC: stm32: fix sai driver name initialisation

Bart Van Assche (1):
      locking/lockdep: Zap lock classes even with lock debugging disabled

Brian Norris (1):
      Bluetooth: btusb: request wake pin with NOAUTOEN

CK Hu (2):
      drm/mediatek: Implement gem prime vmap/vunmap function
      drm/mediatek: Add Mediatek framebuffer device

Charles Keepax (6):
      ASoC: wm_adsp: Correct handling of compressed streams that restart
      ASoC: wm_adsp: Correct error messages in wm_adsp_buffer_get_error
      ASoC: wm_adsp: Add locking to wm_adsp2_bus_error
      ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeou=
t
      ASoC: wm_adsp: Check for buffer in trigger stop
      ASoC: cs35l35: Disable regulators on driver removal

Chong Qiao (1):
      MIPS: KGDB: fix kgdb support for SMP platforms.

Chris Wilson (2):
      drm/i915/gvt: Annotate iomem usage
      drm/i915/gvt: Prevent use-after-free in ppgtt_free_all_spt()

Christoph Hellwig (1):
      sparc64/pci_sun4v: fix ATU checks for large DMA masks

Christophe Leroy (2):
      powerpc/32: Fix early boot failure with RTAS built-in
      powerpc/vdso32: fix CLOCK_MONOTONIC on PPC64

Chuck Lever (2):
      NFS: Fix handling of reply page vector
      xprtrdma: Fix helper that drains the transport

Cornelia Huck (1):
      virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Dan Carpenter (5):
      drm/mediatek: Fix an error code in mtk_hdmi_dt_parse_pdata()
      aio: Fix an error code in __io_submit_one()
      irqchip/irq-ls1x: Missing error code in ls1x_intc_of_init()
      NFC: nci: Add some bounds checking in nci_hci_cmd_received()
      nfc: nci: Potential off by one in ->pipes[] array

Daniel Drake (1):
      mmc: alcor: don't write data before command has completed

Daniel Mack (1):
      ASoC: cs4270: Set auto-increment bit for register writes

Daniel Mentz (1):
      ALSA: uapi: #include <time.h> in asound.h

Dave Airlie (1):
      drm/udl: add a release method and delay modeset teardown

David M=C3=BCller (1):
      clk: x86: Add system specific quirk to mark clocks as critical

Dongli Zhang (2):
      virtio-blk: limit number of hw queues by nr_cpu_ids
      scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids

Erik Schmauss (1):
      ACPICA: Namespace: remove address node from global list after
method termination

Faiz Abbas (1):
      mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

Filipe Manana (1):
      Btrfs: do not allow trimming when a fs is mounted with the
nologreplay option

Guenter Roeck (1):
      ASoC: intel: Fix crash at suspend/resume after failed codec registrat=
ion

Gustavo A. R. Silva (1):
      ASoC: ab8500: Mark expected switch fall-through

Hans Holmberg (1):
      lightnvm: pblk: fix crash in pblk_end_partial_read due to multipage b=
vecs

Hans de Goede (1):
      ASoC: Intel: cht_bsw_max98090_ti: Enable codec clock once and
keep it enabled

Heiner Kallweit (1):
      r8169: disable ASPM again

Horatiu Vultur (1):
      MIPS: generic: Add switchdev, pinctrl and fit to ocelot_defconfig

Hui Wang (1):
      ALSA: hda - Add two more machines to the power_save_blacklist

Imre Deak (1):
      drm/i915: Get power refs in encoder->get_power_domains()

Iuliana Prodan (1):
      crypto: caam - fix copy of next buffer for xcbc and cmac

James Smart (1):
      nvme-fc: correct csn initialization and increments on error

Jani Nikula (1):
      drm/i915/dp: revert back to max link rate and lane count on eDP

Jann Horn (1):
      linux/kernel.h: Use parentheses around argument in u64_to_user_ptr()

Jarkko Sakkinen (2):
      tpm: turn on TPM on suspend for TPM 1.x
      KEYS: trusted: allow trusted.ko to initialize w/o a TPM

Jason Yan (1):
      block: fix the return errno for direct IO

Jenny TC (1):
      ASoC: Intel: Skylake: enable S24_LE format support

Jens Axboe (2):
      tools/io_uring: remove IOCQE_FLAG_CACHEHIT
      io_uring: restrict IORING_SETUP_SQPOLL to root

Jernej Skrabec (1):
      drm/sun4i: DW HDMI: Lower max. supported rate for H6

Jerome Brunet (1):
      ASoC: dpcm: skip missing substream while applying symmetry

Jiada Wang (2):
      ASoC: rsnd: src: Avoid a potential deadlock
      ASoC: rsnd: src: fix compiler warnings

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21
with ALC233

Joerg Roedel (1):
      iommu/amd: Set exclusion range correctly

John Hsu (2):
      ASoC: nau8824: fix the issue of the widget with prefix name
      ASoC: nau8810: fix the issue of widget with prefixed name

Jonathan Hunter (1):
      ASoC: soc-core: Fix probe deferral following prelink failure

Josh Poimboeuf (1):
      objtool: Add rewind_stack_do_exit() to the noreturn list

J=C3=A9r=C3=B4me Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

KaiChieh Chuang (2):
      ASoC: mediatek: btcvsd add loopback
      ASoC: dpcm: prevent snd_soc_dpcm use after free

Kaike Wan (5):
      IB/hfi1: Failed to drain send queue when QP is put into error state
      IB/hfi1: Clear the IOWAIT pending bits when QP is put into error stat=
e
      IB/hfi1: Eliminate opcode tests on mr deref
      IB/hfi1: Fix the allocation of RSM table
      IB/hfi1: Do not flush send queue in the TID RDMA second leg

Kailang Yang (1):
      ALSA: hda/realtek - Move to ACT_INIT state

Kamal Heib (1):
      RDMA/vmw_pvrdma: Fix memory leak on pvrdma_pci_remove

Kees Cook (1):
      apparmor: Restore Y/N in /sys for apparmor's "enabled"

Kefeng Wang (1):
      genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=3Dn

Keith Busch (1):
      nvmet: fix discover log page when offsets are used

Kuninori Morimoto (2):
      ASoC: audio-graph-card: don't select DPCM via audio-graph-card
      ASoC: simple-card: don't select DPCM via simple-audio-card

Lendacky, Thomas (3):
      x86/perf/amd: Resolve race condition when disabling PMC
      x86/perf/amd: Resolve NMI latency issues for active PMCs
      x86/perf/amd: Remove need to check "running" bit in NMI handler

Leonard Crestez (1):
      clk: imx: Fix PLL_1416X not rounding rates

Lijun Ou (1):
      RDMA/hns: Fix bug that caused srq creation to fail

Linus Torvalds (4):
      mm: make page ref count overflow check tighter and more explicit
      mm: add 'try_get_page()' helper function
      mm: prevent get_user_pages() from overflowing page refcount
      Linux 5.1-rc5

Longpeng (1):
      virtio_pci: fix a NULL pointer reference in vp_del_vqs

Lorenzo Bianconi (2):
      net: ip_gre: fix possible use-after-free in erspan_rcv
      net: ip6_gre: fix possible use-after-free in ip6erspan_rcv

Marc Gonzalez (1):
      ASoC: wcd9335: Fix missing regmap requirement

Martin Blumenstingl (1):
      clk: meson: pll: fix rounding and setting a rate that matches precise=
ly

Matteo Croce (1):
      drm/omap: fix typo

Matthew Wilcox (1):
      fs: prevent page refcount overflow in pipe_buf_get

Matthias Wieloch (1):
      clk: at91: fix programmable clock for sama5d2

Max Filippov (4):
      xtensa: use actual syscall number in do_syscall_trace_leave
      xtensa: fix initialization of pt_regs::syscall in start_thread
      xtensa: fix return_address
      xtensa: fix format string warning in init_pmd

Maxime Jourdan (2):
      clk: meson-gxbb: round the vdec dividers to closest
      clk: meson: g12a: fix VPU clock muxes mask

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical
load calculation

Miaohe Lin (1):
      net: vrf: Fix ping failed when vrf mtu is set to 0

Michael Chan (2):
      bnxt_en: Improve RX consumer index validity check.
      bnxt_en: Reset device on RX buffer errors.

Michael Ellerman (1):
      powerpc/mm: Define MAX_PHYSMEM_BITS for all 64-bit configs

Michael S. Tsirkin (1):
      MAiNTAINERS: add Paolo, Stefan for virtio blk/scsi

Michael Zhivich (3):
      ethtool: avoid signed-unsigned comparison in ethtool_validate_speed()
      broadcom: tg3: fix use of SPEED_UNKNOWN ethtool constant
      qlogic: qlcnic: fix use of SPEED_UNKNOWN ethtool constant

Miguel Ojeda (1):
      clang-format: Update with the latest for_each macro list

Ming Lei (3):
      block: don't use for-inside-for in bio_for_each_segment_all
      blk-mq: introduce blk_mq_complete_request_sync()
      nvme: cancel request synchronously

Moni Shoua (1):
      IB/mlx5: Reset access mask when looping inside page fault handler

Neil Armstrong (4):
      clk: meson-g12a: fix VPU clock parents
      drm/bridge: dw-hdmi: disable SCDC configuration for invalid setups
      clk: meson: vid-pll-div: remove warning and return 0 on invalid confi=
g
      Revert "Documentation/gpu/meson: Remove link to meson_canvas.c"

Nicholas Kazlauskas (1):
      drm/amd/display: Fix negative cursor pos programming (v2)

Nicholas Piggin (1):
      powerpc/64s/radix: Fix radix segment exception handling

Nicolas Dichtel (1):
      selftests: add a tc matchall test case

Oleksandr Andrushchenko (1):
      ALSA: xen-front: Do not use stream buffer size before it is set

Olga Kornievskaia (1):
      NFSv4.1 fix incorrect return value in copy_file_range

Olivier Moysan (9):
      ASoC: stm32: sai: fix iec958 controls indexation
      ASoC: stm32: sai: fix exposed capabilities in spdif mode
      ASoC: stm32: sai: fix race condition in irq handler
      ASoC: stm32: sai: fix oversampling mode
      ASoC: stm32: sai: fix set_sync service
      ASoC: stm32: i2s: fix registers declaration in regmap
      ASoC: stm32: dfsdm: manage multiple prepare
      ASoC: stm32: dfsdm: fix debugfs warnings on entry creation
      ASoC: stm32: sai: fix master clock management

Ondrej Jirman (1):
      drm/sun4i: tcon top: Fix NULL/invalid pointer dereference in
sun8i_tcon_top_un/bind

Pankaj Bharadiya (1):
      ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontro=
l

Paolo Valente (1):
      block, bfq: fix use after free in bfq_bfqq_expire

Paul Thomas (1):
      net: macb driver, check for SKBTX_HW_TSTAMP

Peter Zijlstra (2):
      perf/x86/intel: Initialize TFA MSR
      perf/core: Fix perf_event_disable_inatomic() race

Philipp Puschmann (1):
      ASoC: tlv320aic3x: fix reset gpio reference counting

Qian Cai (1):
      slab: fix a crash by reading /proc/slab_allocators

Rander Wang (3):
      ASoC:soc-pcm:fix a codec fixup issue in TDM case
      ASoC:hdac_hda:use correct format to setup hda codec
      ASoC:intel:skl:fix a simultaneous playback & capture issue on hda pla=
tform

Ranjani Sridharan (6):
      ASoC: dapm: set power_check callback for widgets that shouldnt
be always on
      ASoC: intel: skylake: add remove() callback for component driver
      ASoC: topology: Use the correct dobj to free enum control values and =
texts
      ASoC: core: conditionally increase module refcount on component open
      ASoC: pcm: update module refcount if module_get_upon_open is set
      ASoC: pcm: fix error handling when try_module_get() fails.

Richard Sailer (1):
      ALSA: hda/realtek - Add quirk for Tuxedo XC 1509

Rodrigo Siqueira (1):
      drm/atomic-helper: Make atomic_enable/disable crtc callbacks optional

Russell King (2):
      ASoC: hdmi-codec: fix S/PDIF DAI
      ASoC: hdmi-codec: avoid limiting params->msbits in hw_params()

S.j. Wang (2):
      ASoC: fsl_asrc: add constraint for the asrc of older version
      ASoC: fsl_esai: fix channel swap issue when stream starts

Scott Wood (1):
      dma-debug: only skip one stackframe entry

Sean Paul (1):
      Documentation/gpu/meson: Remove link to meson_canvas.c

Sergey Miroshnichenko (1):
      PCI: pciehp: Ignore Link State Changes after powering off a slot

Shuming Fan (3):
      ASoC: rt5682: Check JD status when system resume
      ASoC: rt5682: fix jack type detection issue
      ASoC: rt5682: recording has no sound after booting

Stefan Agner (1):
      gpu: host1x: Fix compile error when IOMMU API is not available

Stefan Schmidt (1):
      MAINTAINERS: ieee802154: update documentation file pattern

Stephane Eranian (1):
      perf/x86/intel: Fix handling of wakeup_events for multi-entry PEBS

Stephen Boyd (2):
      genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()
      platform/x86: pmc_atom: Drop __initconst on dmi table

Sugar Zhang (2):
      ASoC: rockchip: pdm: fix regmap_ops hang issue
      ASoC: rockchip: pdm: change dma burst to 8

Sylwester Nawrocki (2):
      ASoC: samsung: i2s: Fix DAPM routes for capture stream
      ASoC: samsung: odroid: Fix clock configuration for 44100 sample rate

Tadeusz Struk (3):
      tpm: fix an invalid condition in tpm_common_poll
      selftests/tpm2: Extend tests to cover partial reads
      selftests/tpm2: Open tpm dev in unbuffered mode

Takashi Iwai (1):
      ALSA: hda: Fix racy display power access

Tetsuo Handa (1):
      NFS: Forbid setting AF_INET6 to "struct sockaddr_in"->sin_family.

Thomas Bogendoerfer (1):
      MIPS: SGI-IP27: Fix use of unchecked pointer in shutdown_bridge_irq

Tony Lindgren (1):
      drm/omap: hdmi4_cec: Fix CEC clock handling for PM

Trond Myklebust (1):
      Revert "SUNRPC: Micro-optimise when the task is known not to be sleep=
ing"

Tzung-Bi Shih (2):
      ASoC: mediatek: mt8183: skip for i2s5 in mck_disable
      ASoC: Intel: kbl: fix wrong number of channels

Vandita Kulkarni (2):
      drm/i915/icl: Ungate ddi clocks before IO enable
      drm/i915/icl: Fix port disable sequence for mipi-dsi

Varun Prakash (1):
      scsi: csiostor: fix missing data copy in csio_scsi_err_handler()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix pipe_bpp readout for BXT/GLK DSI

Wangyan Wang (5):
      drm/mediatek: fix the rate and divder of hdmi phy for MT2701
      drm/mediatek: make implementation of recalc_rate() for MT2701 hdmi ph=
y
      drm/mediatek: remove flag CLK_SET_RATE_PARENT for MT2701 hdmi phy
      drm/mediatek: using new factor for tvdpll for MT2701 hdmi phy
      drm/mediatek: no change parent rate in round_rate() for MT2701 hdmi p=
hy

Wei Yongjun (1):
      aio: use kmem_cache_free() instead of kfree()

Weiyi Lu (1):
      clk: mediatek: fix clk-gate flag setting

Wen Yang (1):
      drm/mediatek: fix possible object reference leak

Will Deacon (2):
      arm64: backtrace: Don't bother trying to unwind the userspace stack
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

Xiaochen Shen (1):
      x86/resctrl: Fix typos in the mba_sc mount option

Xiong Zhang (1):
      drm/i915/gvt: Roundup fb->height into tile's height at calucation fb-=
>size

Yangyang Li (1):
      RDMA/hns: Bugfix for SCC hem free

Yue Haibing (1):
      tpm: Fix the type of the return value in calc_tpm2_event_size()

YueHaibing (1):
      iov_iter: Fix build error without CONFIG_CRYPTO

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy

ndesaulniers@google.com (1):
      KEYS: trusted: fix -Wvarags warning

shaoyunl (1):
      drm/amdgpu: Adjust IB test timeout for XGMI configuration

tiancyin (1):
      drm/amd/display: fix cursor black issue

wentalou (1):
      drm/amdgpu: amdgpu_device_recover_vram always failed if only one
node in shadow_list
