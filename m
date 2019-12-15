Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB48C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 23:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2922467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 23:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576452275;
	bh=/ckP8ArNu0TbOKzrzjYYTTpULapCj4HOMmDrJyTGCVI=;
	h=From:Date:Subject:To:List-ID:From;
	b=WbUPl+2BDhR75lz/dfwNk96d6KDnQFZ0fRUkNVApzLGH1aUVVz1Ik2U62/u9lNK5m
	 EYFtCSNEIzJvxcqzKHCEgNtFvtOW+kbXs5SUTeMQtNZSzSeozZZbxIirU2ri0IIK23
	 bqY/kXGKZt1U95MCsEzXohIoLu5yiY9tQxpXR700=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfLOXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 18:24:28 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46780 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLOXY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 18:24:28 -0500
Received: by mail-lj1-f171.google.com with SMTP id z17so4674576ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zms2eBVxavs8z79aCKJdOqm8uX1YMLSrFYChbOEMt4I=;
        b=cirUCkSngye3OSlGVGTs5ZO5jjHXiZlbpPN5L2GiYCPcH1DooNoxTYN5y/x6Gn+fDW
         +fAfMmf1draLXLxLftOZUjToyg9Xta1a6FaSFveytVK/VVoAB/y5XmgEAFyzJKCSagiP
         G3Njju80qkAis7jpRP2IK7Z8crzuCmb0S2At0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zms2eBVxavs8z79aCKJdOqm8uX1YMLSrFYChbOEMt4I=;
        b=fEAr6gLR8KSBZfRIeu/5rmCaUZeyaW20RIzYkLxzIKLKrnMGPJqaEZkGa01pEiqNw/
         oHGbnu2YQ10nIk/TtsySoifTTlCzfJHmaX1REYMm5qS5ID1WgIfB+lOoivNkM2lVmucb
         mauOClvyQDV6E5doxzsJXJCGJZI5vUdDcbv9sjg7C/GvihsW/ea3B3e4PUWnjEsGDvIX
         9uQ/j+wK/EObDVRHpWny+a5SUCINhWg6eCouJXXcbBO4zfpTPOWX8gvAYM3fbZ69wrKW
         YLoSGg6yRz9C7D7MfCD7UQYRpjJ3E4DCxdnYumr3fpvgmpueQr1Vgbo1+n7S7m+hHjze
         zSAw==
X-Gm-Message-State: APjAAAXhzdms7s7QNG+dfn05O+7X2hHHvxz/Flfivh+mRUjCzSjqLhQz
        qczw/YiI07u809C6oamOvSIRHGACilk=
X-Google-Smtp-Source: APXvYqx/5Dy9pTFAahdjd46gK5uh25LIWGewGbWDs/2fJcGtu+a1+m8CfBEZZ10wnaaFf8OsaufeUg==
X-Received: by 2002:a2e:548:: with SMTP id 69mr17155711ljf.67.1576452264338;
        Sun, 15 Dec 2019 15:24:24 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q13sm10641909ljj.63.2019.12.15.15.24.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2019 15:24:23 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id m30so2883685lfp.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 15:24:22 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr15186205lfp.106.1576452262298;
 Sun, 15 Dec 2019 15:24:22 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Dec 2019 15:24:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgF1O8oPL9HRwRSrHt7NeLATtE5eZjcmP1QZfkcqE-+0g@mail.gmail.com>
Message-ID: <CAHk-=wgF1O8oPL9HRwRSrHt7NeLATtE5eZjcmP1QZfkcqE-+0g@mail.gmail.com>
Subject: Linux 5.5-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You all know the deal by now: another week, another rc.

Things look normal - rc2 is usually fairly calm, and so it was this
week too. All the stats look normal too - the bulk of this is drivers
(gpu, rdma, networking, scsi, usb stand out, but there's noise
elsewhere too), with the rest being random things all over - io_uring,
filesystems (ceph, overlayfs), core networking, arch updates, header
files, etc etc.

So peeps - go build it, install it and boot it, and report back any
problems you see,

                  Linus

---

Alex Deucher (4):
      drm/amdgpu: add header line for power profile on Arcturus
      drm/amdgpu/display: add fallthrough comment
      drm/amdgpu: fix license on Kconfig and Makefiles
      Revert "drm/amdgpu: dont schedule jobs while in reset"

Alexei Starovoitov (1):
      ftrace: Fix function_graph tracer interaction with BPF trampoline

Amanda Liu (1):
      drm/amd/display: Fix screen tearing on vrr tests

Amir Goldstein (7):
      ovl: fix lookup failure on multi lower squashfs
      ovl: make sure that real fid is 32bit aligned in memory
      ovl: don't use a temp buf for encoding real fh
      ovl: fix corner case of non-unique st_dev;st_ino
      ovl: relax WARN_ON() on rename to self
      docs: filesystems: overlayfs: Rename overlayfs.txt to .rst
      docs: filesystems: overlayfs: Fix restview warnings

Andrea Merello (1):
      iio: ad7949: fix channels mixups

Andrea Righi (1):
      staging: exfat: properly support discard in clr_alloc_bitmap()

Andreas Gruenbacher (1):
      block: fix "check bi_size overflow before merge"

Andy Shevchenko (1):
      fbtft: Fix the initialization from property algorithm

Arnaud Pouliquen (1):
      dt-bindings: remoteproc: stm32: add wakeup-source property

Arnd Bergmann (2):
      drm/amd/display: fix undefined struct member reference
      drm/amd/display: include linux/slab.h where needed

Bart Van Assche (1):
      scsi: iscsi: Fix a potential deadlock in the timeout handler

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: fix panel scaling

Beniamin Bia (1):
      iio: adc: ad7606: fix reading unnecessary data from device

Bo Wu (2):
      scsi: lpfc: Fix memory leak on lpfc_bsg_write_ebuf_set func
      scsi: iscsi: Avoid potential deadlock in iscsi_if_rx func

Boris Brezillon (4):
      drm/panfrost: Fix a race in panfrost_ioctl_madvise()
      drm/panfrost: Fix a BO leak in panfrost_ioctl_mmap_bo()
      drm/panfrost: Fix a race in panfrost_gem_free_object()
      drm/panfrost: Open/close the perfcnt BO

Brandon Syu (1):
      drm/amd/display: fixed that I2C over AUX didn't read data issue

Brendan Higgins (1):
      staging: exfat: fix multiple definition error of `rename_file'

Bryan O'Donoghue (1):
      usb: common: usb-conn-gpio: Don't log an error on probe deferral

Can Guo (1):
      scsi: ufs: Give an unique ID to each ufs-bsg

Chris Lesiak (1):
      iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel reporting

Chris Wilson (3):
      drm/i915/gt: Save irqstate around virtual_context_destroy
      drm/i915/gt: Detect if we miss WaIdleLiteRestore
      drm/i915: Serialise with remote retirement

Christian Borntraeger (1):
      s390/uv: use EOPNOTSUPP instead of ENOTSUPP

Chuhong Yuan (2):
      iio: adc: max1027: fix not unregistered iio trigger
      RDMA/cma: add missed unregister_pernet_subsys in init failure

Colin Ian King (2):
      iio: temperature: ltc2983: fix u32 read into a unsigned long long
      s390/test_unwind: fix spelling mistake "reqister" -> "register"

Dan Carpenter (2):
      iio: adc: intel_mrfld_adc: Allocating too much data in probe()
      scsi: iscsi: qla4xxx: fix double free in probe

Daniel Lezcano (1):
      MAINTAINERS: thermal: Change the git tree location

Daniel Vetter (1):
      MAINTAINERS: Match on dma_buf|fence|resv anywhere

David Galiffi (1):
      drm/amd/display: Fixed kernel panic when booting with DP-to-HDMI dong=
le

David Hildenbrand (1):
      virtio-balloon: fix managed page counts when migrating pages between =
zones

David Howells (5):
      afs: Fix SELinux setting security label on /afs
      afs: Fix mountpoint parsing
      afs: Fix creation calls in the dynamic root to fail with EOPNOTSUPP
      afs: Fix missing cell comparison in afs_test_super()
      afs: Show volume name in /proc/net/afs/<cell>/volumes

David Sterba (1):
      btrfs: add Kconfig dependency for BLAKE2B

Diego Calleja (1):
      dm: add dm-clone to the documentation index

Dominik Brodowski (5):
      devtmpfs: use do_mount() instead of ksys_mount()
      initrd: use do_mount() instead of ksys_mount()
      init: use do_mount() instead of ksys_mount()
      init: unify opening /dev/console as stdin/stdout/stderr
      fs: remove ksys_dup()

EJ Hsu (1):
      usb: gadget: fix wrong endpoint desc

Edmund Nadolski (1):
      nvme: else following return is not needed

Emiliano Ingrassia (1):
      usb: core: urb: fix URB structure initialization function

Enric Balletbo i Serra (1):
      PCI: rockchip: Fix IO outbound ATU register number

Eric Biggers (1):
      docs: dm-integrity: remove reference to ARC4

Eric Yang (2):
      drm/amd/display: update sr and pstate latencies for Renoir
      drm/amd/display: update dispclk and dppclk vco frequency

Florian Fainelli (1):
      MAINTAINERS: thermal: Eduardo's email is bouncing

Fredrik Noring (1):
      USB: Fix incorrect DMA allocations for local memory pool drivers

Gao Xiang (2):
      erofs: zero out when listxattr is called with no xattr
      erofs: update documentation

Geert Uytterhoeven (1):
      iio: adc: max9611: Fix too short conversion time delay

George Shen (1):
      drm/amd/display: Increase the number of retries after AUX DEFER

Georgi Djakov (3):
      interconnect: qcom: sdm845: Walk the list safely on node removal
      interconnect: qcom: qcs404: Walk the list safely on node removal
      interconnect: qcom: msm8974: Walk the list safely on node removal

Greg Kroah-Hartman (1):
      lib: raid6: fix awk build warnings

Grygorii Strashko (1):
      dt-bindings: net: ti: cpsw-switch: update to fix comments

Guchun Chen (1):
      drm/amdgpu: add check before enabling/disabling broadcast mode

Guenter Roeck (3):
      staging/octeon: Mark Ethernet driver as BROKEN
      drivers: Fix boot problem on SuperH
      nios2: Fix ioremap

Guoqing Jiang (2):
      raid5: need to set STRIPE_HANDLE for batch head
      blk-cgroup: remove blkcg_drain_queue

Hans de Goede (2):
      drm/nouveau: Move the declaration of struct nouveau_conn_atom up a bi=
t
      drm/nouveau: Fix drm-core using atomic code-paths on pre-nv50 hardwar=
e

Heikki Krogerus (1):
      usb: dwc3: pci: add ID for the Intel Comet Lake -H variant

Heiko Carstens (1):
      s390: remove last diag 0x44 caller

Henry Lin (1):
      usb: xhci: only set D3hot for pci device

Himanshu Madhani (1):
      scsi: qla2xxx: Correctly retrieve and interpret active flash region

Hou Tao (1):
      dm btree: increase rebalance threshold in __rebalance2()

Hui Wang (1):
      ALSA: hda/realtek - Line-out jack doesn't work on a Dell AIO

Israel Rukshin (3):
      nvme-rdma: Avoid preallocating big SGL for data
      nvme-fc: Avoid preallocating big SGL for data
      nvmet-loop: Avoid preallocating big SGL for data

James Smart (3):
      nvme_fc: add module to ops template to allow module references
      nvme: add error message on mismatching controller ids
      nvme-fc: fix double-free scenarios on hw queues

Jason A. Donenfeld (1):
      crypto: arm/curve25519 - add arch-specific key generation function

Jason Yan (1):
      scsi: libsas: stop discovering if oob mode is disconnected

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix temperature reporting using bad unit

Jeff Layton (2):
      ceph: convert int fields in ceph_mount_options to unsigned int
      ceph: show tasks waiting on caps in debugfs caps file

Jens Axboe (11):
      io_uring: allow unbreakable links
      io-wq: remove worker->wait waitqueue
      io-wq: briefly spin for new work after finishing work
      io_uring: sqthread should grab ctx->uring_lock for submissions
      io_uring: deferred send/recvmsg should assign iov
      io_uring: don't dynamically allocate poll data
      io_uring: run next sqe inline if possible
      io_uring: only hash regular files for async work execution
      net: make socket read/write_iter() honor IOCB_NOWAIT
      io_uring: add sockets to list of files that support non-blocking issu=
e
      io_uring: ensure we return -EINVAL on unknown opcode

Johan Hovold (9):
      staging: gigaset: fix general protection fault on probe
      staging: gigaset: fix illegal free on probe errors
      staging: gigaset: add endpoint-type sanity check
      USB: serial: io_edgeport: fix epic endpoint lookup
      USB: idmouse: fix interface sanity checks
      USB: adutux: fix interface sanity check
      USB: atm: ueagle-atm: add missing endpoint check
      staging: rtl8188eu: fix interface sanity check
      staging: rtl8712: fix interface sanity check

Joseph Gravenor (3):
      drm/amd/display: fix DalDramClockChangeLatencyNs override
      drm/amd/display: populate bios integrated info for renoir
      drm/amd/display: have two different sr and pstate latency tables
for renoir

Juergen Gross (1):
      xen/balloon: fix ballooned page accounting without hotplug enabled

Kai-Heng Feng (1):
      xhci: Increase STS_HALT timeout in xhci_suspend()

Kay Friedrich (1):
      staging/wlan-ng: add CRC32 dependency in Kconfig

Kefeng Wang (4):
      workqueue: Use pr_warn instead of pr_warning
      printk: Drop pr_warning definition
      checkpatch: Drop pr_warning check
      riscv: only select serial sifive if TTY is enabled

Keith Busch (5):
      nvme: Namepace identification descriptor list is optional
      nvme/pci: Remove last_cq_head
      nvme/pci: Fix write and poll queue types
      nvme/pci Limit write queue sizes to possible cpus
      nvme/pci: Fix read queue count

Krzysztof Kozlowski (1):
      interconnect: qcom: Fix Kconfig indentation

Kuninori Morimoto (1):
      sh: kgdb: Mark expected switch fall-throughs

Leo (Hanghong) Ma (1):
      drm/amd/display: Change the delay time before enabling FEC

Leonard Crestez (6):
      PM / devfreq: Fix devfreq_notifier_call returning errno
      PM / devfreq: Set scaling_max_freq to max on OPP notifier error
      PM / devfreq: Introduce get_freq_range helper
      PM / devfreq: Don't fail devfreq_dev_release if not in list
      PM / devfreq: Add PM QoS support
      PM / devfreq: Use PM QoS for sysfs min/max_freq

Linus Torvalds (2):
      pipe: simplify signal handling in pipe_read() and add comments
      Linux 5.5-rc2

Linus Walleij (1):
      staging: fbtft: Do not hardcode SPI CS polarity inversion

Logan Gunthorpe (1):
      block: fix NULL pointer dereference in account statistics with IDE

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: fix decimation factor estimation
      iio: imu: st_lsm6dsx: track hw FIFO buffering with fifo_mask
      iio: imu: st_lsm6dsx: do not power-off accel if events are enabled

Lukas Wunner (1):
      ALSA: hda/hdmi - Fix duplicate unref of pci_dev

Lyude Paul (3):
      drm/nouveau/kms/nv50-: Call outp_atomic_check_view() before handling =
PBN
      drm/nouveau/kms/nv50-: Store the bpc we're using in nv50_head_atom
      drm/nouveau/kms/nv50-: Limit MST BPC to 8

Maor Gottlieb (1):
      IB/mlx5: Fix steering rule of drop and count

Marc Dionne (1):
      afs: Fix afs_find_server lookups for ipv4 peers

Marcelo Diop-Gonzalez (1):
      staging: vchiq: call unregister_chrdev_region() when driver
registration fails

Marcelo Schmitt (2):
      dt-bindings: iio: adc: ad7292: Update SPDX identifier
      dt-bindings: iio: adc: ad7292: fix constraint over channel quantity

Marcelo Tosatti (1):
      cpuidle: use first valid target residency as poll time

Mark Zhang (1):
      RDMA/counter: Prevent auto-binding a QP which are not tracked with re=
s

Martin Blumenstingl (1):
      drm: meson: venc: cvbs: fix CVBS mode matching

Mathias Nyman (3):
      xhci: fix USB3 device initiated resume race with roothub autosuspend
      xhci: handle some XHCI_TRUST_TX_LENGTH quirks cases as default behavi=
our.
      xhci: make sure interrupts are restored to correct state

Maxime Ripard (1):
      dt-bindings: Change maintainer address

Michael Hernandez (2):
      scsi: qla2xxx: Added support for MPI and PEP regions for ISP28XX
      scsi: qla2xxx: Fix incorrect SFUB length used for Secure Flash
Update MB Cmd

Michael S. Tsirkin (2):
      virtio_balloon: name cleanups
      virtio_balloon: divide/multiply instead of shifts

Mika Westerberg (1):
      xhci: Fix memory leak in xhci_add_in_port()

Mike Snitzer (1):
      dm mpath: remove harmful bio-based optimization

Mircea Caprioru (1):
      iio: adc: ad7124: Enable internal reference

Navid Emamdoost (1):
      dma-buf: Fix memory leak in sync_file_merge()

Nikola Cornij (2):
      drm/amd/display: Map DSC resources 1-to-1 if numbers of OPPs and
DSCs are equal
      drm/amd/display: Reset steer fifo before unblanking the stream

Nikos Tsironis (5):
      dm clone metadata: Track exact changes per transaction
      dm clone metadata: Use a two phase commit
      dm clone: Flush destination device before committing metadata
      dm thin metadata: Add support for a pre-commit callback
      dm thin: Flush data device before committing metadata

Olof Johansson (2):
      ALSA: echoaudio: simplify get_audio_levels
      riscv: Fix build dependency for loader

Pankaj Bharadiya (2):
      MIPS: OCTEON: Replace SIZEOF_FIELD() macro
      treewide: Use sizeof_field() macro

Parav Pandit (1):
      IB/mlx4: Follow mirror sequence of device add during device removal

Paul Durrant (1):
      xen-blkback: prevent premature module unload

Paul Menzel (1):
      scsi: smartpqi: Update attribute name to `driver_version`

Pavel Shilovsky (1):
      CIFS: Close cached root handle only if it has a lease

Pete Zaitcev (1):
      usb: mon: Fix a deadlock in usbmon between mmap and read

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: add cache flush workaround to gfx8 emit_fence

Quinn Tran (1):
      scsi: qla2xxx: Use explicit LOGO in target mode

Rafael J. Wysocki (3):
      ACPI: PM: Avoid attaching ACPI PM domain to certain devices
      cpuidle: Fix cpuidle_driver_state_disabled()
      cpuidle: Drop unnecessary type cast in cpuidle_poll_time()

Randy Dunlap (1):
      i2c: fix header file kernel-doc warning

Rob Herring (1):
      dt-bindings: memory-controllers: tegra: Fix type references

Roman Bolshakov (12):
      scsi: qla2xxx: Ignore NULL pointer in tcm_qla2xxx_free_mcmd
      scsi: qla2xxx: Initialize free_work before flushing it
      scsi: qla2xxx: Drop superfluous INIT_WORK of del_work
      scsi: qla2xxx: Change discovery state before PLOGI
      scsi: qla2xxx: Allow PLOGI in target mode
      scsi: qla2xxx: Don't call qlt_async_event twice
      scsi: qla2xxx: Fix PLOGI payload and ELS IOCB dump length
      scsi: qla2xxx: Configure local loop for N2N target
      scsi: qla2xxx: Send Notify ACK after N2N PLOGI
      scsi: qla2xxx: Don't defer relogin unconditonally
      scsi: qla2xxx: Ignore PORT UPDATE after N2N PLOGI
      scsi: qla2xxx: Add debug dump of LOGO payload and ELS IOCB

Saravana Kannan (2):
      of/platform: Unconditionally pause/resume sync state during kernel in=
it
      of/platform: Unconditionally pause/resume sync state during kernel in=
it

Stephan Gerhold (1):
      drm/mcde: dsi: Fix invalid pointer dereference if panel cannot be fou=
nd

Stephen Rothwell (1):
      Fix up for "printk: Drop pr_warning definition"

Steve French (2):
      smb3: fix refcount underflow warning on unmount when no directory lea=
ses
      SMB3: Fix crash in SMB2_open_init due to uninitialized field in
compounding path

Steve Wise (2):
      Update mailmap info for Steve Wise
      rxe: correctly calculate iCRC for unaligned payloads

Steven Price (1):
      drm/panfrost: devfreq: Round frequencies to OPPs

Steven Rostedt (VMware) (1):
      module: Remove accidental change of module_enable_x()

Takashi Sakamoto (3):
      ALSA: firewire-motu: fix double unlocked 'motu->mutex'
      ALSA: oxfw: fix return value in error path of isochronous
resources reservation
      ALSA: fireface: fix return value in error path of isochronous
resources reservation

Tejas Joglekar (1):
      usb: dwc3: gadget: Fix logical condition

Thinh Nguyen (2):
      usb: dwc3: gadget: Clear started flag for non-IOC
      usb: dwc3: ep0: Clear started flag on completion

Thomas Richter (2):
      s390/cpum_sf: Adjust sampling interval to avoid hitting sample limits
      s390/cpum_sf: Avoid SBD overflow condition in irq handler

Thomas Zimmermann (1):
      drm/mgag200: Flag all G200 SE A machines as broken wrt <startadd>

Tianci.Yin (4):
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14
      drm/amdgpu/gfx10: update gfx golden settings
      drm/amdgpu/gfx10: update gfx golden settings for navi14

Todd Kjos (1):
      binder: fix incorrect calculation for num_valid

Umesh Nerlige Ramappa (2):
      drm/i915/perf: Allow non-privileged access when OA buffer is not samp=
led
      drm/i915/perf: Configure OAR for specific context

Vasily Gorbik (2):
      s390/spinlock: remove confusing comment in arch_spin_lock_wait
      s390/kasan: add KASAN_VMALLOC support

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/fbc: Disable fbc by default on all glk+
      drm/i915/hdcp: Nuke intel_hdcp_transcoder_config()

Wen Yang (2):
      usb: roles: fix a potential use after free
      usb: typec: fix use after free in typec_register_port()

Wolfram Sang (2):
      i2c: remove i2c_new_dummy() API
      i2c: add helper to check if a client has a driver attached

Xiubo Li (3):
      ceph: trigger the reclaim work once there has enough pending caps
      ceph: switch to global cap helper
      ceph: add more debug info when decoding mdsmap

Yishai Hadas (2):
      IB/core: Introduce rdma_user_mmap_entry_insert_range() API
      IB/mlx5: Fix device memory flows

Yongqiang Sun (1):
      drm/amd/display: Compare clock state member to determine optimization=
.

YueHaibing (4):
      thermal: power_allocator: Fix Kconfig warning
      iio: st_accel: Fix unused variable warning
      staging: hp100: Fix build error without ETHERNET
      tracing: remove set but not used variable 'buffer'

Yufen Yu (1):
      md: make sure desc_nr less than MD_SB_DISKS

Zhang Rui (1):
      MAINTAINERS: thermal: Add Daniel Lezcano as the thermal maintainer

Zhiqiang Liu (1):
      md: raid1: check rdev before reference in raid1_sync_request func

changzhu (3):
      drm/amdgpu: avoid using invalidate semaphore for picasso
      drm/amdgpu: add invalidate semaphore limit for SRIOV and picasso in g=
mc9
      drm/amdgpu: add invalidate semaphore limit for SRIOV in gmc10

sheebab (1):
      scsi: ufs: Disable autohibern8 feature in Cadence UFS
