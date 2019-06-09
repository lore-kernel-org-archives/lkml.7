Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC3AC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 03:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAE4212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 03:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560052416;
	bh=+nfDpqv7oK9wWLgWGFaQuHhJ/53hFeEZea54fWLGE9c=;
	h=From:Date:Subject:To:List-ID:From;
	b=KogJLxQcjbpMzbQYwoa+IYv5yAOa3fxxJwoRNy+xXhaztLaznwjOPrWnNmVLfJ7Bc
	 hrNo3U5VDQLo5bHGdRh2NJTuBOgfXb/D261mFVtorMf8VJfU7BeAWnGpJgxZBZLSd+
	 krXvJRqhoTIW/Z1gRjFZsplxNWBh7FOoJUu/P7zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfFIDrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 23:47:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40005 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfFIDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 23:47:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id a9so4338192lff.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=nq+Jf7wJDfRj7dtYB2zqAbyw39JxD1sj3GNsTP5yPZc=;
        b=NxgvAmcXtWfBlopbhqugvjJDcgNH6Jh0/nEKbCxIdT16ge2kppnRMrg9nMCgeQRaJJ
         cHw6wCpEUPhKIcRb3Y0tMnC72sI1KilNGGI0D6p9cSKxgUUS3PWJcTKdU45Qxs2+h5/I
         L4h5Q0TZFa+qvpvvUCVpfTbCZovco/RKgkme8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nq+Jf7wJDfRj7dtYB2zqAbyw39JxD1sj3GNsTP5yPZc=;
        b=jVIyZaxcUFWjRmoZ9BHqu1UMI//MHjiLGvpoiJrH+8l7fsH15hK8O1V80Gref7qg9y
         n8OWt5Yi6ru1/6HhhnJyHmTFqvaX1aWWgNdlpU6HX7fE9GxJQSzaVFHwReqASzn5KLxz
         yRyWq6jV5N2k6+dq3eXOyqu+q7zRQVL14Fh2S/U+vDXUPcaEpFGJjIvhPs43OUUrm9VH
         4Rv95DHGx8Pemd5hLf8l1hwKeVT028gIUuY4qSx64kH+qovAlwInBbiuURvtCbjd2c8L
         AKHkPscr76gFLIHf407U1DLm27MVQBvVfCD5vKZX8icjXScMQg+6XzKXfnLh1UuhbFK7
         vGNA==
X-Gm-Message-State: APjAAAUd+UYXTUImqJwwuBMSp93OUAKrAtK4TNjgldm4xfI6HKTuVMWq
        rugNAfCVl95Mcib5T8iZUvFLy7lUgUU=
X-Google-Smtp-Source: APXvYqysl+5E2gDFpLDG7Ep0LIKyrN4kKZgD9b2yNb2/2t8ohFBp61w92JS2zBlwENqymhirVA9IiA==
X-Received: by 2002:ac2:47fa:: with SMTP id b26mr17585703lfp.82.1560052026257;
        Sat, 08 Jun 2019 20:47:06 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n7sm1255788lfi.68.2019.06.08.20.47.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 20:47:05 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id a9so4338164lff.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 20:47:04 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr30311260lfc.29.1560052024456;
 Sat, 08 Jun 2019 20:47:04 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jun 2019 20:46:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
Message-ID: <CAHk-=wjm7FQxdF=RKa8Xe23CLNNpbGDOACewgo8e-hwDJ8TyQg@mail.gmail.com>
Subject: Linux 5.2-rc4
To:     Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, I'm not confused, and I haven't lost track of what day it is, I do
actually know that it's still Saturday here, not Sunday, and I'm just
doing rc4 a bit early because I'll be on an airplane during my normal
release time. And while I've done releases on airports and airplanes
before, I looked at my empty queue of pull requests and went "let's
just do it now".

We've had a fairly calm release so far, and on the whole that seems to
hold. rc4 isn't smaller than rc3 was (it's a bit bigger), but rc3 was
fairly small, so the size increase isn't all that worrisome. I do hope
that we'll start actually shrinking now, though.

The SPDX conversions do continue to stand out, and make the diffstat a
bit noisy. They don't affect actual code, so it's not like we should
have any issues with them, but it makes the patch statistics look a
bit odd. There's just a lot more files changed than is normal in the
rc phase, and 90+% of that changed file list comes from the SPDX
changes. Of course, the SPDX changes also account for 95+% percent of
the removed lines in rc4, which is why I'm not complaining. It does
make the copyright boilerplates be a lot more legible to humans too,
not just for scripting.

But it does make the diff almost impossible to read, because so much
of it is due to just the SPDX notice work. You can use interdiff to
skip the SPDX stuff if you really want to, and if you do, you'll see
the usual arch updates (arm64, mips, parisc, nds32) various random
drivers updates (gpu stands out, some rdma), networking fixes,
filesystems (ceph, ovlfs, xfs). And misc other stuff.

But the appended shortlog is probably even more informative. None of
it really looks all that gnarly.

                Linus

---

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      hwmon: (pmbus/core) mutex_lock write in pmbus_set_samples

Adrian Hunter (1):
      mmc: sdhci: Fix SDIO IRQ thread deadlock

Alakesh Haloi (1):
      userfaultfd: selftest: fix compiler warning

Aleksei Gimbitskii (2):
      drm/i915/gvt: Check if cur_pt_type is valid
      drm/i915/gvt: Assign NULL to the pointer after memory free.

Alex Shi (3):
      kselftest/cgroup: fix unexpected testing failure on test_memcontrol
      kselftest/cgroup: fix unexpected testing failure on test_core
      kselftest/cgroup: fix incorrect test_core skip

Alexandra Winter (1):
      s390/qeth: fix VLAN attribute in bridge_hostnotify udev event

Alexey Brodkin (1):
      ARC: [plat-hsdk] Get rid of inappropriate PHY settings

Amir Goldstein (2):
      ovl: support the FS_IOC_FS[SG]ETXATTR ioctls
      ovl: detect overlapping layers

Anders Roxell (1):
      arm64: arch_timer: mark functions as __always_inline

Andrey Konovalov (1):
      uaccess: add noop untagged_addr definition

Angelo Ruocco (2):
      cgroup: let a symlink too be created with a cftype file
      block, bfq: add weight symlink to the bfq.weight cgroup parameter

Avri Altman (1):
      scsi: ufs: Check that space was properly alloced in copy_query_response

Baolin Wang (3):
      dmaengine: sprd: Fix the possible crash when getting descriptor status
      dmaengine: sprd: Add validation of current descriptor in irq handler
      dmaengine: sprd: Add interrupt support for 2-stage transfer

Bart Van Assche (1):
      MAINTAINERS: Hand over skd maintainership

Ben Skeggs (6):
      drm/nouveau/core: pass subdev into nvkm_firmware_get, rather than device
      drm/nouveau/core: support versioned firmware loading
      drm/nouveau/secboot: pass max supported FW version to LS load funcs
      drm/nouveau/secboot: split out FW version-specific LS function pointers
      drm/nouveau/secboot: enable loading of versioned LS PMU/SEC2 ACR
msgqueue FW
      drm/nouveau/secboot/gp10[2467]: support newer FW to fix SEC2
failures on some boards

Bob Peterson (1):
      Revert "gfs2: Replace gl_revokes with a GLF flag"

Chengguang Xu (1):
      fpga: dfl: expand minor range when registering chrdev region

Chengming Gui (1):
      drm/amd/powerplay: add set_power_profile_mode for raven1_refresh

Christian Brauner (2):
      signal: improve comments
      tests: fix pidfd-test compilation

Christoph Hellwig (4):
      nvme-pci: don't limit DMA segement size
      rsxx: don't call dma_set_max_seg_size
      mtip32xx: also set max_segment_size in the device
      mmc: also set max_segment_size in the device

Colin Ian King (1):
      dmaengine: dw-axi-dmac: fix null dereference when pointer first is null

Colin Xu (3):
      drm/i915/gvt: Update force-to-nonpriv register whitelist
      drm/i915/gvt: Fix GFX_MODE handling
      drm/i915/gvt: Fix vGPU CSFE_CHICKEN1_REG mmio handler

Dan Carpenter (7):
      dmaengine: mediatek-cqdma: sleeping in atomic context
      genwqe: Prevent an integer overflow in the ioctl
      test_firmware: Use correct snprintf() limit
      memstick: mspro_block: Fix an error code in mspro_block_issue_req()
      mmc: tegra: Fix a warning message
      scsi: smartpqi: unlock on error in pqi_submit_raid_request_synchronous()
      drm/komeda: Potential error pointer dereference

Dan Rue (1):
      kbuild: teach kselftest-merge to find nested config files

Darrick J. Wong (2):
      xfs: fix broken log reservation debugging
      xfs: inode btree scrubber should calculate im_boffset correctly

Dave Martin (2):
      arm64: cpufeature: Fix missing ZFR0 in __read_sysreg_by_encoding()
      arm64: Silence gcc warnings about arch ABI drift

Eduardo Valentin (1):
      hwmon: (core) add thermal sensors only if dev->of_node is present

Eric Biggers (2):
      crypto: jitterentropy - change back to module_init()
      crypto: hmac - fix memory leak in hmac_init_tfm()

Eric Long (3):
      dmaengine: sprd: Fix the incorrect start for 2-stage destination channels
      dmaengine: sprd: Fix block length overflow
      dmaengine: sprd: Fix the right place to configure 2-stage transfer

Eugeniy Paltsev (3):
      ARC: mm: SIGSEGV userspace trying to access kernel virtual memory
      ARC: [plat-hsdk]: enable creg-gpio controller
      ARC: [plat-hsdk]: Add support of Vivante GPU

Fabrizio Castro (1):
      virtio: Fix indentation of VIRTIO_MMIO

Faiz Abbas (1):
      mmc: sdhci_am654: Fix SLOTTYPE write

Florian Fainelli (1):
      arm64: smp: Moved cpu_logical_map[] to smp.h

Gal Pressman (2):
      RDMA/uverbs: Pass udata on uverbs error unwind
      RDMA/efa: Remove MAYEXEC flag check from mmap flow

Gao, Fred (1):
      drm/i915/gvt: Fix cmd length of VEB_DI_IECP

Geert Uytterhoeven (1):
      MIPS: TXx9: Fix boot crash in free_initmem()

Gen Zhang (1):
      mdesc: fix a missing-check bug in get_vdev_port_node_info()

George G. Davis (2):
      scripts/checkstack.pl: Fix arm64 wrong or unknown architecture
      ARM64: trivial: s/TIF_SECOMP/TIF_SECCOMP/ comment typo fix

Gerald Schaefer (1):
      s390/mm: fix address space detection in exception handling

Greg Kroah-Hartman (1):
      block: aoe: no need to check return value of debugfs_create functions

Guenter Roeck (2):
      xtensa: Fix section mismatch between memblock_reserve and mem_reserve
      samples: fix pidfd-metadata compilation

Gustavo A. R. Silva (1):
      xprtrdma: Use struct_size() in kzalloc()

Hangbin Liu (1):
      Revert "fib_rules: return 0 directly if an exactly same rule
exists when NLM_F_EXCL not supplied"

Helen Koike (5):
      drm/rockchip: fix fb references in async update
      drm/amd: fix fb references in async update
      drm/msm: fix fb references in async update
      drm/vc4: fix fb references in async update
      drm: don't block fb changes for async plane updates

Helge Deller (3):
      parisc: Allow building 64-bit kernel without -mlong-calls compiler option
      parisc: Fix compiler warnings in float emulation code
      parisc: Fix crash due alternative coding for NP iopdir_fdc bit

Igor Stoppa (1):
      virtio: add unlikely() to WARN_ON_ONCE()

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpsw_ethtool: fix ethtool ring param set

Jaesoo Lee (1):
      nvme: Fix u32 overflow in the number of namespace list calculation

Jakub Kicinski (2):
      Revert "net/tls: avoid NULL-deref on resync during device removal"
      net/tls: replace the sleeping lock around RX resync with a bit lock

James Clarke (1):
      sparc64: Fix regression in non-hypervisor TLB flush xcall

Jan Glauber (1):
      lockref: Limit number of cmpxchg loop retries

Jann Horn (2):
      habanalabs: fix debugfs code
      x86/insn-eval: Fix use-after-free access to LDT entry

Jason Gunthorpe (1):
      RDMA/core: Clear out the udata before error unwind

Jason Wang (4):
      vhost: introduce vhost_exceeds_weight()
      vhost_net: fix possible infinite loop
      vhost: vsock: add weight support
      vhost: scsi: add weight support

Jerome Brunet (1):
      mmc: meson-gx: fix irq ack

Jiri Kosina (1):
      x86/power: Fix 'nosmt' vs hibernation triple fault during resume

Joel Fernandes (Google) (2):
      kheaders: Move from proc to sysfs
      kheaders: Do not regenerate archive if config is not changed

John David Anglin (2):
      parisc: Use implicit space register selection for loading the
coherence index of I/O pdirs
      parisc: Use lpa instruction to load physical addresses in driver code

Jon Hunter (3):
      dmaengine: tegra210-adma: Fix crash during probe
      dmaengine: tegra210-adma: Fix channel FIFO configuration
      dmaengine: tegra210-adma: Fix spelling

Jose Abreu (2):
      ARC: [plat-hsdk]: Add missing multicast filter bins number to GMAC node
      ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node

Julian Wiedmann (3):
      s390/qeth: handle limited IPv4 broadcast in L3 TX path
      s390/qeth: check dst entry before use
      s390/qeth: handle error when updating TX queue count

Kamal Heib (1):
      RDMA/core: Fix panic when port_data isn't initialized

Kamenee Arumugam (1):
      IB/hfi1: Validate page aligned for a given virtual address

Kees Cook (3):
      lkdtm/usercopy: Moves the KERNEL_DS test to non-canonical
      lkdtm/bugs: Adjust recursion test to avoid elision
      pstore/ram: Run without kernel crash dump region

Kefeng Wang (1):
      block: Drop unlikely before IS_ERR(_OR_NULL)

Krzysztof Kozlowski (1):
      parisc: configs: Remove useless UEVENT_HELPER_PATH

Leon Romanovsky (2):
      RDMA/srp: Rename SRP sysfs name after IB device rename trigger
      RDMA/hns: Fix PD memory leak for internal allocation

Linus Torvalds (2):
      rcu: locking and unlocking need to always be at least barriers
      Linux 5.2-rc4

Louis Li (1):
      drm/amdgpu: fix ring test failure issue during s3 in vce 3.0 (V2)

Lowry Li (Arm Technology China) (1):
      drm/komeda: fixing of DMA mapping sg segment warning

Lucas Stach (1):
      udmabuf: actually unmap the scatterlist

Mariusz Bialonczyk (1):
      w1: ds2408: Fix typo after 49695ac46861 (reset on output_write
retry with readback)

Masahiro Yamada (4):
      MIPS: mark ginvt() as __always_inline
      MIPS: remove a space after -I to cope with header search paths for VDSO
      kconfig: tests: fix recursive inclusion unit test
      kbuild: use more portable 'command -v' for cc-cross-prefix

Max Gurtovoy (1):
      nvme-rdma: use dynamic dma mapping per command

Maxime Chevallier (1):
      net: mvpp2: Use strscpy to handle stat strings

Miaohe Lin (1):
      net: ipvlan: Fix ipvlan device tso disabled while NETIF_F_IP_CSUM is set

Michal Kubecek (1):
      mlx5: avoid 64-bit division

Mike Marciniszyn (3):
      IB/rdmavt: Fix alloc_qpn() WARN_ON()
      IB/hfi1: Insure freeze_work work_struct is canceled on shutdown
      IB/{qib, hfi1, rdmavt}: Correct ibv_devinfo max_mr value

Mike Rapoport (1):
      parisc: Kconfig: remove ARCH_DISCARD_MEMBLOCK

Miklos Szeredi (5):
      fuse: fallocate: fix return with locked inode
      fuse: add FUSE_WRITE_KILL_PRIV
      fuse: fix copy_file_range() in the writeback case
      fuse: extract helper for range writeback
      ovl: doc: add non-standard corner cases

Ming Lei (1):
      block: free sched's request pool in blk_cleanup_queue

Minwoo Im (1):
      nvmet: fix data_len to 0 for bdev-backed write_zeroes

Moritz Fischer (1):
      fpga: zynqmp-fpga: Correctly handle error pointer

Naresh Kamboju (1):
      selftests: vm: install test_vmalloc.sh for run_vmtests

Neil Horman (1):
      Fix memory leak in sctp_process_init

Nikita Danilov (1):
      net: aquantia: fix wol configuration not applied sometimes

Nikita Yushchenko (1):
      net: dsa: mv88e6xxx: avoid error message on remove from VLAN 0

Oded Gabbay (2):
      uapi/habanalabs: add opcode for enable/disable device debug mode
      habanalabs: fix bug in checking huge page optimization

Olga Kornievskaia (1):
      SUNRPC fix regression in umount of a secure mount

Olivier Matz (2):
      ipv6: use READ_ONCE() for inet->hdrincl as in ipv4
      ipv6: fix EFAULT on sendto with icmpv6 and hdrincl

Omer Shpigelman (1):
      habanalabs: halt debug engines on user process close

Paolo Abeni (2):
      net: fix indirect calls helpers for ptype list hooks.
      pktgen: do not sleep with the thread lock held.

Paul Burton (3):
      MIPS: Bounds check virt_addr_valid
      MIPS: Make virt_addr_valid() return bool
      MIPS: pistachio: Build uImage.gz by default

Paul Cercueil (1):
      dmaengine: jz4780: Fix transfers being ACKed too soon

Peng Ma (1):
      dmaengine: fsl-qdma: Add improvement

Pi-Hsun Shih (1):
      pstore: Set tfm to NULL on free_buf_for_compression

Prike Liang (1):
      drm/amd/amdgpu: add RLC firmware to support raven1 refresh

Rafael J. Wysocki (2):
      x86: intel_epb: Do not build when CONFIG_PM is unset
      PM: sleep: Add kerneldoc comments to some functions

Robert Hancock (2):
      hwmon: (pmbus/core) Treat parameters as paged if on multiple pages
      i2c: xiic: Add max_read_len quirk

Robin Murphy (2):
      drm/arm/hdlcd: Actually validate CRTC modes
      drm/arm/hdlcd: Allow a bit of clock tolerance

Roger Pau Monne (1):
      xen-blkfront: switch kcalloc to kvcalloc for large array allocation

Russell King (9):
      fs/adfs: factor out filename comparison
      fs/adfs: factor out filename case lowering
      fs/adfs: factor out object fixups
      fs/adfs: factor out filename fixup
      fs/adfs: remove truncated filename hashing
      fs/adfs: move append_filetype_suffix() into adfs_object_fixup()
      fs/adfs: fix filename fixup handling for "/" and "//" names
      net: sfp: read eeprom in maximum 16 byte increments
      net: phylink: avoid reducing support mask

Sagi Grimberg (2):
      nvme-rdma: fix queue mapping when queue count is limited
      nvme-tcp: fix queue mapping when queue count is limited

Scott Wood (2):
      fpga: dfl: afu: Pass the correct device to dma_mapping_error()
      fpga: dfl: Add lockdep classes for pdata->lock

Sean Wang (2):
      net: ethernet: mediatek: Use hw_feature to judge if HWLRO is supported
      net: ethernet: mediatek: Use NET_IP_ALIGN to judge if HW
RX_2BYTE_OFFSET is enabled

Shuah Khan (1):
      selftests: vm: Fix test build failure when built by itself

Takeshi Saito (1):
      mmc: tmio: fix SCC error handling to avoid false positive CRC error

Thomas Gleixner (159):
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rules 251..450

Tim Beale (1):
      udp: only choose unbound UDP socket for multicast when not in a VRF

Tina Zhang (1):
      drm/i915/gvt: Initialize intel_gvt_gtt_entry in stack

Tomer Tayar (3):
      habanalabs: Avoid using a non-initialized MMU cache mutex
      habanalabs: Fix virtual address access via debugfs for 2MB pages
      habanalabs: Read upper bits of trace buffer from RWPHI

Trevor Bourget (1):
      kbuild: tar-pkg: enable communication with jobserver

Trond Myklebust (1):
      SUNRPC: Fix a use after free when a server rejects the
RPCSEC_GSS credential

Tvrtko Ursulin (1):
      drm/i915/icl: Add WaDisableBankHangMode

Vasily Gorbik (1):
      s390/unwind: correct stack switching during unwind

Vincent Chen (3):
      math-emu: Use statement expressions to fix Wshift-count-overflow warning
      nds32: Avoid IEX status being incorrectly modified
      nds32: add new emulations for floating point instruction

Vineet Gupta (1):
      ARC: fix build warnings

Vivien Didelot (1):
      ethtool: fix potential userspace buffer overflow

Vladimir Oltean (2):
      net: dsa: sja1105: Don't store frame type in skb->cb
      net: dsa: sja1105: Fix link speed not working at 100 Mbps and below

Wei Liu (1):
      Update my email address

Weinan Li (1):
      drm/i915/gvt: add F_CMD_ACCESS flag for wa regs

Wen He (1):
      drm/arm/mali-dp: Add a loop around the second set CVAL and try 5 times

Wen Yang (1):
      fpga: stratix10-soc: fix use-after-free on s10_init()

Willem de Bruijn (1):
      packet: unconditionally free po->rollover

Wolfram Sang (1):
      MAINTAINERS: Karthikeyan Ramasubramanian is MIA

Xiaolin Zhang (1):
      drm/i915/gvt: save RING_HEAD into vreg when vgpu switched out

Xin Long (3):
      selftests: set sysctl bc_forwarding properly in router_broadcast.sh
      ipv4: not do cache for local delivery if bc_forwarding is enabled
      ipv6: fix the check before getting the cookie in rt6_get_cookie

Xiong Zhang (1):
      drm/i915/gvt: refine ggtt range validation

Yan, Zheng (3):
      ceph: single workqueue for inode related works
      ceph: avoid iput_final() while holding mutex or in dispatch thread
      ceph: fix error handling in ceph_get_caps()

Yihao Wu (2):
      NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails to wake a waiter
      NFSv4.1: Fix bug only first CB_NOTIFY_LOCK is handled

Yonglong Liu (1):
      net: hns: Fix loopback test failed at copper ports

Young Xiao (1):
      sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD

YueHaibing (3):
      parport: Fix mem leak in parport_register_dev_model
      MIPS: uprobes: remove set but not used variable 'epc'
      drm/komeda: remove set but not used variable 'kcrtc'

Yury Norov (1):
      parisc/slab: cleanup after /proc/slab_allocators removal

Zhu Yanjun (2):
      net: rds: fix memory leak when unload rds_rdma
      net: rds: fix memory leak in rds_ib_flush_mr_pool

james qian wang (Arm Technology China) (1):
      drm/komeda: Constify the usage of komeda_component/pipeline/dev_funcs
