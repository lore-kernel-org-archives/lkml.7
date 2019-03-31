Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA95C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11E92086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554069660;
	bh=aOuISE2Dl6uuqdGe5xGS9voppbe5FDT1dtKHh+hYRSI=;
	h=From:Date:Subject:To:List-ID:From;
	b=p9nNBVjchgBgmdCYuLTunXReIlRxS4Rts5y+5T9a71FxpRlHIItVNlVKayBXP7pUQ
	 F2tIYsEqC+IQlq81phKoGrydlhT56hHYpzyUXzgMJum+fATH7HKP0M5MMXH+P6kGNn
	 cVa84j+x4WhXnmUHXTNuQDyRUDCyF1BMviWWx+x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfCaWA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:00:58 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34442 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:00:57 -0400
Received: by mail-lj1-f178.google.com with SMTP id j89so6334243ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k9ZVCVK9htm7z4jtTKM4Y/znlgCUdUuW961jp4JunEY=;
        b=OsmmYsJ8cDELbvKF7Fj5xZSFQbvZe/T+1ohxynnEj9t0WDi7RtNbS+TE7JeCyD5sHr
         p6K45Sdnxsb31ICLpMju2K5WqMR/UST2T0b+4uXXh0Hnui9Ja31G6QO5WY4WXQRbj73C
         sokgO5JBLeYvmpu7VLBy4+QeTTZ9vdHxpdoSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k9ZVCVK9htm7z4jtTKM4Y/znlgCUdUuW961jp4JunEY=;
        b=jv60nniC2ere6mIIbAN08M3EGRJe/G9ltD0vsYmpSmaz7wlpMpIKxuzlPDjpVG56K+
         QJqMgMckITh3EBEbrXc8L6Y4OR385IwWlngQ17Ef7p3zBD+CnwIkjzDWPJHMHLK/zwmx
         48kuNnHv2sg4OIP3OX5PAhRNk0+ZdqeJVL5FxCE4KDz4Q2zH+l2QzZPX/pRUAMxSNwjy
         GXBgN9FbVtBkSF6jxPYVmq/Tg6H8d9WKSaZlJSNMofVDJRbJ/QWtYtnbkCvr93f55Zxt
         BSZwQeNkrw7BzPd6Ny6KgBYDVbFnqlIqZlTs0fVCwLuZbbpPWRGdn7tx9zmWhwgPh6iO
         VDbQ==
X-Gm-Message-State: APjAAAXtaUz6LrFxuPaDFmJxpQTGNQLWky34aTxMdAoTJlDUGzOGbwtw
        GuyHZu4yWEjVUR2+kQxBdQibAysJNRM=
X-Google-Smtp-Source: APXvYqx7f/qo2HDPBudTmWa3BWnNRWOKddyXO1ORkwmksTeofHObiq79U8lmCdlyiIoeVSw+oUftDA==
X-Received: by 2002:a2e:9c0a:: with SMTP id s10mr9707909lji.162.1554069652217;
        Sun, 31 Mar 2019 15:00:52 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z18sm1479274lfi.57.2019.03.31.15.00.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 15:00:51 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id u21so4854168lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:00:51 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr30468788lfl.148.1554069650637;
 Sun, 31 Mar 2019 15:00:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 15:00:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHmEqxBvp3dfTqOut+NHzbNaip=BrnBO48SCTfnApLRg@mail.gmail.com>
Message-ID: <CAHk-=wiHmEqxBvp3dfTqOut+NHzbNaip=BrnBO48SCTfnApLRg@mail.gmail.com>
Subject: Linux 5.1-rc3
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing particularly unusual going on here.

The rc3 release is bigger than normal, which is obviously never
anything I want to see, but at the same time it's early enough in the
rc series that it's not something I really worry about. Yet.

And while it's bigger, nothing really unusual stands out. The single
biggest patch in there (by far - it's in fact about a third of the
whole rc3 patch) is just removal of the mt7621-eth staging driver,
which is because the regular mediatek ethernet driver now handles that
hardware. In fact, due to the removal of that driver, the full rc3
patch removes more lines than it adds, which is always nice to see
(honestly in advertising: looking at the whole release so far rather
than just this week's rc, that is very much not true).

But no, that driver removal isn't why I'm saying that rc3 is larger
than usual - that's just a single commit. And we simply also have more
commits than we normally do at this point. But I'm hopeful that it's
just a one-off - the whole "size of rc's" measure tends to be somewhat
noisy and depends on whether a particular week saw all the major
subsystems merging in their fixes or not. This time we obviously just
had a lot of it.

If you ignore that big chunk of the rc3 patch that is the removal of
that single driver, the changes really are pretty widely spread out.
About a third is drivers in general, another roughly third is tooling
and documentation changes, and the final third is just "misc" all over
(networking is a big chunk of it, but there are arch updates, core
kernel, kvm, you name it).

The appended shortlog gives a flavor of the details, and I don't think
there's any fundamental pattern there. Just a lot of small details.

Let's hope the rc's will start shrinking from this point on, but I
don't think we have anything particularly bad going on.

Go forth and test,

                Linus


---
Aaro Koskinen (4):
      net: stmmac: don't set own bit too early for jumbo frames
      net: stmmac: fix jumbo frame sending with non-linear skbs
      net: stmmac: fix memory corruption with large MTUs
      staging: octeon-ethernet: fix incorrect PHY mode

Aditya Pakki (8):
      qlcnic: Avoid potential NULL pointer dereference
      serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference
      serial: max310x: Fix to avoid potential NULL pointer dereference
      nfc: Fix to check for kmemdup failure
      staging: rtl8188eu: Fix potential NULL pointer dereference of kcalloc
      staging: rtlwifi: rtl8822b: fix to avoid potential NULL pointer
dereference
      staging: rtlwifi: Fix potential NULL pointer dereference of kzalloc
      usb: usb251xb: fix to avoid potential NULL pointer dereference

Adrian Hunter (3):
      perf intel-pt: Fix TSC slip
      perf scripts python: exported-sql-viewer.py: Fix never-ending loop
      perf scripts python: exported-sql-viewer.py: Fix python3 support

Al Viro (1):
      ceph: fix use-after-free on symlink traversal

Alakesh Haloi (1):
      SUNRPC: fix uninitialized variable warning

Alexandre Belloni (1):
      checkpatch: add %pt as a valid vsprintf extension

Alexandru Gagniuc (1):
      PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked

Alin Nastac (1):
      netfilter: nf_conntrack_sip: remove direct dependency on IPv6

Anders Roxell (1):
      drm/tegra: vic: Fix implicit function declaration warning

Andrea Righi (1):
      btrfs: raid56: properly unmap parity page in finish_parity_scrub()

Andrei Vagin (1):
      ptrace: take into account saved_sigmask in PTRACE{GET,SET}SIGMASK

Andrew Jeffery (1):
      Revert "gpio: use new gpio_set_config() helper in more places"

Andrey Smirnov (2):
      gpio: of: Check propname before applying "cs-gpios" quirks
      gpio: of: Check for "spi-cs-high" in child instead of parent node

Andrii Nakryiko (3):
      libbpf: handle BTF parsing and loading properly
      btf: resolve enum fwds in btf_dedup
      selftests/bpf: add fwd enum resolution test for btf_dedup

Arnaldo Carvalho de Melo (6):
      tools headers uapi: Sync asm-generic/mman-common.h and linux/mman.h
      tools headers uapi: Sync linux/fcntl.h to get the
F_SEAL_FUTURE_WRITE addition
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      tools headers uapi: Update drm/i915_drm.h
      tools headers: Update x86's syscall_64.tbl and uapi/asm-generic/unist=
d
      tools headers uapi: Sync powerpc's asm/kvm.h copy with the kernel sou=
rces

Arnd Bergmann (10):
      iwlwifi: fix 64-bit division
      staging: olpc_dcon_xo_1: add missing 'const' qualifier
      staging: axis-fifo: add CONFIG_OF dependency
      netfilter: fix NETFILTER_XT_TARGET_TEE dependencies
      mlxsw: core: mlxsw: core: avoid -Wint-in-bool-context warning
      3c515: fix integer overflow warning
      rxrpc: avoid clang -Wuninitialized warning
      io_uring: fix big-endian compat signal mask handling
      usb: mtu3: fix EXTCON dependency
      chelsio: use BUG() instead of BUG_ON(1)

Axel Lin (1):
      gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input

Baoquan He (1):
      x86/boot: Fix incorrect ifdeffery scope

Bart Van Assche (1):
      scsi: sd: Fix a race between closing an sd device and sd I/O

Bartosz Golaszewski (2):
      gpio: mockup: fix debugfs read
      gpio: mockup: use simple_read_from_buffer() in debugfs read callback

Ben Gardon (1):
      kvm: mmu: Used range based flushing in slot_handle_level_range

Bernhard Rosenkraenzer (1):
      ALSA: hda/realtek - Fix speakers on Acer Predator Helios 500 Ryzen la=
ptops

Bhupesh Sharma (1):
      proc/kcore: Remove unused kclist_add_remap()

Bjorn Helgaas (1):
      mISDN: hfcpci: Test both vendor & device ID for Digium HFC4S

Bj=C3=B6rn T=C3=B6pel (1):
      xsk: fix umem memory leak on cleanup

Bj=C3=B8rn Mork (1):
      USB: serial: option: add Olicard 600

Brian Foster (2):
      xfs: don't trip over uninitialized buffer on extent read of
corrupted inode
      xfs: serialize unaligned dio writes against all other dio writes

Catalin Marinas (1):
      NFS: Fix nfs4_lock_state refcounting in nfs4_alloc_{lock,unlock}data(=
)

Changbin Du (2):
      kconfig/[mn]conf: handle backspace (^H) key
      mailmap: add Changbin Du

Chao Yu (1):
      staging: erofs: fix to handle error path of erofs_vmap()

Chen Zhou (1):
      arm64: replace memblock_alloc_low with memblock_alloc

Chen-Yu Tsai (2):
      phy: sun4i-usb: Support set_mode to USB_HOST for non-OTG PHYs
      usb: core: Try generic PHY_MODE_USB_HOST if usb_phy_roothub_set_mode =
fails

Chris Chiu (2):
      ALSA: hda/realtek - Add support for Acer Aspire E5-523G/ES1-432
headset mic
      ALSA: hda/realtek: Enable headset mic of ASUS P5440FF with ALC256

Christian Lamparter (4):
      dt-bindings: net: dsa: qca8k: fix example
      dt-bindings: net: dsa: qca8k: support internal mdio-bus
      net: dsa: qca8k: remove leftover phy accessors
      net: dsa: qca8k: extend slave-bus implementations

Christoph Hellwig (1):
      nvme-tcp: fix an endianess miss-annotation

Christoph Paasch (1):
      net/packet: Set __GFP_NOWARN upon allocation in alloc_pg_vec

Colin Ian King (2):
      drivers: net: atp: fix various indentation issues
      net: sis900: fix indentation issues, remove some spaces

Colin Xu (1):
      drm/i915/gvt: Add in context mmio 0x20D8 to gen9 mmio list

Cornelia Huck (1):
      vfio: ccw: only free cp on final interrupt

Dan Carpenter (3):
      staging: rtl8712: uninitialized memory in read_bbreg_hdl()
      staging: vc04_services: Fix an error code in vchiq_probe()
      drm/i915/selftests: Fix an IS_ERR() vs NULL check

Dan Murphy (1):
      net: phy: Add DP83825I to the DP83822 driver

Daniel Borkmann (3):
      bpf, libbpf: fix version info and add it to shared object
      bpf, libbpf: clarify bump in libbpf version info
      x86/retpolines: Disable switch jump tables when retpolines are enable=
d

Darrick J. Wong (5):
      xfs: dabtree scrub needs to range-check level
      xfs: fix btree scrub checking with regards to root-in-inode
      xfs: always init bma in xfs_bmapi_write
      xfs: prohibit fstrim in norecovery mode
      ocfs2: fix inode bh swapping mixup in ocfs2_reflink_inodes_lock

Dave Airlie (1):
      drm/fb: avoid setting 0 depth.

Dave Carroll (1):
      scsi: aacraid: Insure we don't access PCIe space during AER/EEH

David Howells (2):
      vfs: Update mount API docs
      afs: Fix StoreData op marshalling

David Sterba (1):
      btrfs: don't report readahead errors and don't update statistics

Davide Caratti (18):
      net/sched: prepare TC actions to properly validate the control action
      net/sched: act_bpf: validate the control action inside init()
      net/sched: act_csum: validate the control action inside init()
      net/sched: act_gact: validate the control action inside init()
      net/sched: act_ife: validate the control action inside init()
      net/sched: act_mirred: validate the control action inside init()
      net/sched: act_connmark: validate the control action inside init()
      net/sched: act_nat: validate the control action inside init()
      net/sched: act_pedit: validate the control action inside init()
      net/sched: act_police: validate the control action inside init()
      net/sched: act_sample: validate the control action inside init()
      net/sched: act_simple: validate the control action inside init()
      net/sched: act_skbedit: validate the control action inside init()
      net/sched: act_skbmod: validate the control action inside init()
      net/sched: act_tunnel_key: validate the control action inside init()
      net/sched: act_vlan: validate the control action inside init()
      net/sched: don't dereference a->goto_chain to read the chain index
      net/sched: let actions use RCU to access 'goto_chain'

Dmitry Bezrukov (1):
      net: usb: aqc111: Extend HWID table by QNAP device

Dmitry Bogdanov (1):
      net: aquantia: fix rx checksum offload for UDP/TCP over IPv6

Eric Anholt (3):
      soc: bcm: bcm2835-pm: Fix PM_IMAGE_PERI power domain support.
      soc: bcm: bcm2835-pm: Fix error paths of initialization.
      arm64: bcm2835: Add missing dependency on MFD_CORE.

Eric Biggers (2):
      drm/vgem: fix use-after-free when drm_gem_handle_create() fails
      drm/vkms: fix use-after-free when drm_gem_handle_create() fails

Eric Dumazet (5):
      tun: properly test for IFF_UP
      tun: add a missing rcu_read_unlock() in error path
      net: rose: fix a possible stack overflow
      tcp: do not use ipv6 header for ipv4 flow
      dccp: do not use ipv6 header for ipv4 flow

Erik Hugne (2):
      tipc: allow service ranges to be connect()'ed on RDM/DGRAM
      tipc: fix cancellation of topology subscriptions

Erik Schmauss (1):
      ACPI: use different default debug value than ACPICA

Erin Lo (1):
      dt-bindings: serial: Add compatible for Mediatek MT8183

Fabien Dessenne (1):
      tty: fix NULL pointer issue when tty_port ops is not set

Fabrizio Castro (1):
      usb: common: Consider only available nodes for dr_mode

Felipe Balbi (1):
      usb: dwc3: pci: add support for Comet Lake PCH ID

Felix Fietkau (16):
      mt76: rewrite dma descriptor base and ring size on queue reset
      mt76: mt76x02: when setting a key, use PN from mac80211
      mt76: mt76x2: implement full device restart on watchdog reset
      mt76: mt76x02: only update the base mac address if necessary
      mt76: mt76x02: reduce false positives in ED/CCA tx blocking
      mt76: mt7603: fix tx status HT rate validation
      mt76: mt76x2: fix external LNA gain settings
      mt76: mt76x2: fix 2.4 GHz channel gain settings
      mt76: mt7603: clear ps filtering mode before releasing buffered frame=
s
      mt76: mt7603: fix up hardware queue index for PS filtered packets
      mt76: mt7603: notify mac80211 about buffered frames in ps queue
      mt76: mt7603: clear the service period on releasing PS filtered packe=
ts
      mt76: when releasing PS frames, end the service period if no
frame was found
      mt76: mt76x02: disable ED/CCA by default
      mt76: mt7603: set moredata flag when queueing ps-filtered packets
      mt76: mt7603: use the correct hweight8() function

Filipe Manana (3):
      Btrfs: fix incorrect file size after shrinking truncate and fsync
      Btrfs: fix file corruption after snapshotting due to mix of
buffered/DIO writes
      Btrfs: fix assertion failure on fsync with NO_HOLES enabled

Finn Thain (1):
      mac8390: Fix mmio access size probe

Florian Fainelli (2):
      Documentation: networking: Update netdev-FAQ regarding patches
      net: phy: Re-parent menus for MDIO bus drivers correctly

Frank Rowand (1):
      tracing: initialize variable in create_dyn_event()

Fredrik Noring (1):
      kbuild: modversions: Fix relative CRC byte order interpretation

Gao Xiang (2):
      staging: erofs: fix error handling when failed to read compresssed da=
ta
      staging: erofs: keep corrupted fs from crashing kernel in erofs_readd=
ir()

Gautham R. Shenoy (1):
      powerpc/pseries/energy: Use OF accessor functions to read ibm,drc-ind=
exes

Geert Uytterhoeven (2):
      arm64: dts: renesas: r8a774c0: Fix SCIF5 DMA channels
      gpio: of: Fix of_gpiochip_add() error path

George McCollister (1):
      USB: serial: ftdi_sio: add additional NovaTech products

Greg Kroah-Hartman (2):
      driver core: remove BUS_ATTR()
      USB: serial: cp210x: add new device id

Guido Kiener (3):
      usb: gadget: net2280: Fix overrun of OUT messages
      usb: gadget: net2280: Fix net2280_dequeue()
      usb: gadget: net2272: Fix net2272_dequeue()

Gustavo A. R. Silva (4):
      usb: typec: Fix unchecked return value
      usb: usb251xb: Remove unnecessary comparison of unsigned integer with=
 >=3D 0
      ALSA: rawmidi: Fix potential Spectre v1 vulnerability
      ALSA: seq: oss: Fix Spectre v1 vulnerability

Hans de Goede (2):
      usb: typec: tcpm: Try PD-2.0 if sink does not respond to 3.0 source-c=
aps
      virt: vbox: Implement passing requestor info to the host for
VirtualBox 6.0.x

Harald Freudenberger (1):
      s390/zcrypt: revisit ap device remove procedure

Harini Katakam (1):
      net: macb: Add null check for PCLK and HCLK

Hariprasad Kelam (1):
      ftrace: Fix warning using plain integer as NULL & spelling correction=
s

Heiner Kallweit (3):
      r8169: don't read interrupt mask register in interrupt handler
      r8169: fix cable re-plugging issue
      net: phy: don't clear BMCR in genphy_soft_reset

Helen Koike (1):
      ARM: dts: bcm283x: Fix hdmi hpd gpio pull

Herbert Xu (1):
      rhashtable: Still do rehash when we get EEXIST

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Ian Abbott (1):
      staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Ilya Dryomov (1):
      libceph: fix breakage caused by multipage bvecs

Ioana Ciocoi Radulescu (1):
      dpaa2-eth: Fix possible access beyond end of array

Ioana Ciornei (1):
      dpaa2-eth: fix race condition with bql frame accounting

Jakub Kicinski (1):
      bpf: verifier: propagate liveness on all frames

Jan Kara (1):
      mm/memory.c: fix modifying of page protection by insert_pfn()

Jann Horn (2):
      x86/cpufeature: Fix __percpu annotation in this_cpu_has()
      Yama: mark local symbols as static

Jarkko Nikula (1):
      i2c: i801: Add support for Intel Comet Lake

Jean-Philippe Brucker (2):
      drm/meson: Fix invalid pointer in meson_drv_unbind()
      drm/meson: Uninstall IRQ handler

Jeff Layton (1):
      locks: wake any locks blocked on request before deadlock check

Jens Axboe (1):
      blk-mq: fix sbitmap ws_active for shared tags

Jerome Brunet (1):
      net: phy: meson-gxl: fix interrupt support

Jian-Hong Pan (3):
      ALSA: hda/realtek: Enable headset MIC of Acer Aspire Z24-890 with ALC=
286
      ALSA: hda/realtek: Enable ASUS X441MB and X705FD headset MIC with ALC=
256
      ALSA: hda/realtek: Enable headset MIC of ASUS X430UN and X512DK
with ALC256

Jiri Olsa (1):
      perf evsel: Fix max perf_event_attr.precise_ip detection

Jiri Pirko (1):
      net: devlink: skip info_get op call if it is not defined in dumpit

Joe Lawrence (1):
      kbuild: strip whitespace in cmd_record_mcount findstring

Joerg Roedel (2):
      iommu: Don't print warning when IOMMU driver only supports
unmanaged domains
      iommu/amd: Reserve exclusion range in iova-domain

John Hurley (1):
      net: sched: fix cleanup NULL pointer exception in act_mirr

Jon Maloy (1):
      tipc: tipc clang warning

Jonas Karlman (1):
      drm/rockchip: vop: reset scale mode when win is disabled

Jonathan Hunter (1):
      arm64: tegra: Disable CQE Support for SDMMC4 on Tegra186

Josef Bacik (1):
      btrfs: remove WARN_ON in log_dir_items

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/icl: Fix VEBOX mismatch BUG_ON()

Julian Wiedmann (3):
      s390/qeth: don't erase configuration while probing
      s390/qeth: fix race when initializing the IP address table
      s390/qeth: be drop monitor friendly

Kan Liang (1):
      perf pmu: Fix parser error for uncore event alias

Kangjie Lu (14):
      net: ieee802154: fix a potential NULL pointer dereference
      net: strparser: fix a missing check for create_singlethread_workqueue
      net: openvswitch: fix a NULL pointer dereference
      net: openvswitch: fix missing checks for nla_nest_start
      net: ncsi: fix a missing check for nla_nest_start
      net: tipc: fix a missing check of nla_nest_start
      net: tipc: fix a missing check for nla_nest_start
      netfilter: ip6t_srh: fix NULL pointer dereferences
      tty: atmel_serial: fix a potential NULL pointer dereference
      tty: mxs-auart: fix a potential NULL pointer dereference
      gpio: exar: add a check for the return value of ida_simple_get fails
      gpio: aspeed: fix a potential NULL pointer dereference
      scsi: qla4xxx: fix a potential NULL pointer dereference
      leds: pca9532: fix a potential NULL pointer dereference

Kees Cook (1):
      LSM: Revive CONFIG_DEFAULT_SECURITY_* for "make oldconfig"

Kohji Okuno (1):
      ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected t=
ime

Krish Sadhukhan (1):
      kvm: nVMX: Add a vmentry check for HOST_SYSENTER_ESP and
HOST_SYSENTER_EIP fields

Kristian Evensen (1):
      USB: serial: option: add support for Quectel EM12

Lars Persson (1):
      mm/migrate.c: add missing flush_dcache_page for non-mapped page migra=
te

Leslie Monis (1):
      net: sched: Kconfig: update reference link for PIE

Li RongQing (1):
      ieee802154: hwsim: propagate genlmsg_reply return code

Lin Yi (1):
      USB: serial: mos7720: fix mos_parport refcount imbalance on error pat=
h

Linus Torvalds (2):
      Revert "parport: daisy: use new parport device model"
      Linux 5.1-rc3

Linus Walleij (1):
      ARM: dts: nomadik: Fix polarity of SPI CS

Lorenzo Bianconi (3):
      mt76: introduce q->stopped parameter
      mt76x2u: remove duplicated entry in mt76x2u_device_table
      mt76: fix schedule while atomic in mt76x02_reset_state

Lukas Wunner (8):
      net: ks8851: Dequeue RX packets explicitly
      net: ks8851: Reassert reset pin if chip ID check fails
      net: ks8851: Delay requesting IRQ until opened
      net: ks8851: Set initial carrier state to down
      net: ks8851: Fix register macro misnomers
      net: ks8851: Deduplicate register macros
      PCI/LINK: Clear bandwidth notification interrupt before enabling it
      PCI/LINK: Deduplicate bandwidth reports for multi-function devices

Magnus Karlsson (1):
      libbpf: fix to reject unknown flags in xsk_socket__create()

Mahesh Salgaonkar (1):
      powerpc/pseries/mce: Fix misleading print for TLB mutlihit

Malcolm Priestley (2):
      staging: vt6655: Fix interrupt race condition on device start up.
      staging: vt6655: Remove vif check from vnt_interrupt

Manasi Navare (1):
      drm/i915/icl: Fix the TRANS_DDI_FUNC_CTL2 bitfield macro

Mans Rullgard (1):
      USB: serial: option: set driver_info for SIM5218 and compatibles

Mao Wenan (1):
      sc16is7xx: missing unregister/delete driver on error in sc16is7xx_ini=
t()

Marc Zyngier (4):
      KVM: arm64: Reset the PMU in preemptible context
      arm64: KVM: Always set ICH_HCR_EL2.EN if GICv4 is enabled
      KVM: arm/arm64: vgic-its: Take the srcu lock when writing to guest me=
mory
      KVM: arm/arm64: vgic-its: Take the srcu lock when parsing the memslot=
s

Marcelo Ricardo Leitner (1):
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_DEFAULT_SEND_PARAM sockopt

Marco Felsch (1):
      ARM: dts: pfla02: increase phy reset duration

Martin George (1):
      nvme-multipath: relax ANA state check

Martin K. Petersen (1):
      scsi: sd: Quiesce warning if device does not report optimal I/O size

Martin KaFai Lau (6):
      bpf: Fix bpf_tcp_sock and bpf_sk_fullsock issue related to bpf_sk_rel=
ease
      bpf: Add bpf_get_listener_sock(struct bpf_sock *sk) helper
      bpf: Sync bpf.h to tools/
      bpf: Test ref release issue in bpf_tcp_sock and bpf_sk_fullsock
      bpf: Add an example for bpf_get_listener_sock
      bpf: Only print ref_obj_id for refcounted reg

Martin Schwidefsky (2):
      s390: limit brk randomization to 32MB
      s390/vtime: steal time exponential moving average

Martynas Pumputis (1):
      bpf: Try harder when allocating memory for large maps

Masahiro Yamada (4):
      kbuild: skip sub-make for in-tree build with GNU Make 4.x
      kbuild: skip parsing pre sub-make code for recursion
      kbuild: do not overwrite .gitignore in output directory
      KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> iif KVM is suppor=
ted

Masanari Iida (1):
      ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi

Mathias Nyman (3):
      xhci: Fix port resume done detection for SS ports with LPM enabled
      usb: xhci: dbc: Don't free all memory with spinlock held
      xhci: Don't let USB3 ports stuck in polling state prevent suspend

Matteo Croce (3):
      gtp: change NET_UDP_TUNNEL dependency to select
      x86/realmode: Don't leak the trampoline kernel address
      x86/realmode: Make set_real_mode_mem() static inline

Matthias Kaehlcke (1):
      Revert "kbuild: use -Oz instead of -Os when using clang"

Max Gurtovoy (1):
      nvmet: fix error flow during ns enable

Maxim Zhukov (1):
      staging, mt7621-pci: fix build without pci support

Maxime Chevallier (1):
      packets: Always register packet sk in the same order

Michael Ellerman (1):
      powerpc/64: Fix memcmp reading past the end of src/dest

Michael Stefaniuc (1):
      scripts: coccinelle: Fix description of badty.cocci

Michal Vok=C3=A1=C4=8D (2):
      ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the cpu port
      ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch

Minchan Kim (1):
      drivers/block/zram/zram_drv.c: fix idle/writeback string compare

Ming Lei (2):
      sbitmap: order READ/WRITE freed instance and setting clear bit
      nvmet: fix building bvec from sg list

Mukesh Ojha (1):
      usb: u132-hcd: fix resource leak

Nathan Chancellor (1):
      tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_s=
etup

Naveen N. Rao (1):
      powerpc: bpf: Fix generation of load/store DW instructions

Neil Armstrong (1):
      drm/meson: fix TMDS clock filtering for DMT monitors

NeilBrown (3):
      staging: remove mt7621-eth
      staging: mt7621-dts: update ethernet settings.
      NFS: fix mount/umount race in nlmclnt.

Nicholas Kazlauskas (1):
      drm/amd/display: Only allow VRR when vrefresh is within supported ran=
ge

Nicolas Boichat (2):
      mm: add support for kmem caches in DMA32 zone
      iommu/io-pgtable-arm-v7s: request DMA32 memory, and improve debugging

Nikolay Borisov (2):
      btrfs: Fix bound checking in qgroup_trace_new_subtree_blocks
      btrfs: Avoid possible qgroup_rsv_size overflow in
btrfs_calculate_inode_block_rsv_size

Nishad Kamdar (1):
      ARM: dts: imx6ull: Use the correct style for SPDX License Identifier

Noralf Tr=C3=B8nnes (1):
      drm: Fix drm_release() and device unplug

Oded Gabbay (3):
      habanalabs: perform accounting for active CS
      habanalabs: prevent host crash during suspend/resume
      habanalabs: cast to expected type

Olga Kornievskaia (1):
      NFSv4.1 don't free interrupted slot on open

Omer Shpigelman (4):
      habanalabs: fix MMU number of pages calculation
      habanalabs: fix bug when mapping very large memory area
      habanalabs: complete user context cleanup before hard reset
      habanalabs: fix mapping with page size bigger than 4KB

Oscar Salvador (1):
      mm/debug.c: fix __dump_page when mapping->host is not set

Pablo Neira Ayuso (4):
      netfilter: nft_set_rbtree: check for inactive element after flag mism=
atch
      netfilter: nf_tables: bogus EBUSY in helper removal from transaction
      netfilter: nft_redir: fix module autoload with ip4
      netfilter: nf_flowtable: remove duplicated transition in diagram

Paolo Bonzini (1):
      Documentation: kvm: clarify KVM_SET_USER_MEMORY_REGION

Pedro Tammela (1):
      net: add documentation to socket.c

Peng Hao (1):
      x86/resctrl: Remove unused variable

Petr =C5=A0tetiar (1):
      serial: ar933x_uart: Fix build failure with disabled console

Pierre-Yves MORDRET (1):
      dmaengine: stm32-mdma: Revert "dmaengine: stm32-mdma: Add a
check on read_u32_array"

Qian Cai (5):
      kasan: fix variable 'tag' set but not used warning
      mm/debug.c: add a cast to u64 for atomic64_read()
      mm/hotplug: fix offline undo_isolate_page_range()
      mm/memory_hotplug.c: fix notification in offline error path
      mm/page_isolation.c: fix a wrong flag in set_migratetype_isolate()

Quentin Monnet (3):
      bpf: fix documentation for eBPF helpers
      bpf: add documentation for helpers bpf_spin_lock(), bpf_spin_unlock()
      tools: bpf: synchronise BPF UAPI header with tools

Radoslav Gerganov (1):
      USB: gadget: f_hid: fix deadlock in f_hidg_write()

Rafa=C5=82 Mi=C5=82ecki (1):
      leds: trigger: netdev: fix refcnt leak on interface rename

Ralph Campbell (1):
      x86/mm: Don't exceed the valid physical address space

Randy Dunlap (3):
      networking: fix snmp_counter.rst Doc. Warnings
      include/linux/list.h: fix list_is_first() kernel-doc
      fs: fs_parser: fix printk format warning

Rasmus Villemoes (1):
      leds: trigger: netdev: use memcpy in device_name_store

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Robert Tarasov (1):
      drm/udl: Refactor edid retrieving in UDL driver (v2)

Rolf Eike Beer (1):
      objtool: Query pkg-config for libelf location

Romain Izard (1):
      usb: cdc-acm: fix race during wakeup blocking TX traffic

Roman Penyaev (1):
      io_uring: offload write to async worker in case of -EAGAIN

Samuel Thibault (1):
      staging: speakup_soft: Fix alternate speech with other synths

Sean Christopherson (11):
      KVM: nVMX: Do not inherit quadrant and invalid for the root shadow EP=
T
      KVM: x86: fix handling of role.cr4_pae and rename it to 'gpte_size'
      KVM: doc: Fix incorrect word ordering regarding supported use of APIs
      KVM: Reject device ioctls from processes other than the VM's creator
      KVM: x86: Emulate MSR_IA32_ARCH_CAPABILITIES on AMD hosts
      KVM: x86: update %rip after emulating IO
      KVM: selftests: assert on exit reason in CR4/cpuid sync test
      KVM: selftests: explicitly disable PIE for tests
      KVM: selftests: disable stack protector for all KVM tests
      KVM: selftests: complete IO before migrating guest state
      KVM: doc: Document the life cycle of a VM and its resources

Sebastian Andrzej Siewior (1):
      kvm: don't redefine flags as something else

Sekhar Nori (1):
      ARM: davinci: fix build failure with allnoconfig

Singh, Brijesh (1):
      KVM: SVM: Workaround errata#1096 (insn_len maybe zero on SMAP violati=
on)

Solomon Tan (1):
      perf cs-etm: Add missing case value

Souptick Joarder (1):
      include/linux/hugetlb.h: convert to use vm_fault_t

Sreekanth Reddy (1):
      scsi: mpt3sas: Fix kernel panic during expander reset

Srinivas Pandruvada (2):
      ACPI / CPPC: Fix guaranteed performance handling
      cpufreq: intel_pstate: Also use CPPC nominal_perf for base_frequency

Stanislaw Gruszka (4):
      mt76x02: fix hdr pointer in write txwi for USB
      mt7601u: check chip version on probe
      mt76x02u: check chip version on probe
      mt76x02: do not enable RTS/CTS by default

Steffen Maier (3):
      scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host
      scsi: zfcp: fix scsi_eh host reset with port_forced ERP for
non-NPIV FCP devices
      scsi: zfcp: reduce flood of fcrscn1 trace records on multi-element RS=
CN

Suzuki K Poulose (2):
      KVM: arm/arm64: Enforce PTE mappings at stage2 when needed
      KVM: arm/arm64: Fix handling of stage2 huge mappings

Taehee Yoo (1):
      netfilter: nf_tables: add missing ->release_ops() in error path
of newrule()

Takashi Iwai (3):
      ALSA: pcm: Fix possible OOB access in PCM oss plugins
      ALSA: hda/ca0132 - Simplify alt firmware loading code
      ALSA: pcm: Don't suspend stream in unrecoverable PCM state

Takeshi Kihara (1):
      arm64: dts: renesas: r8a77990: Fix SCIF5 DMA channels

Tetsuo Handa (1):
      fs/open.c: allow opening only regular files during execve()

Thierry Reding (1):
      drm/tegra: hub: Fix dereference before check

Thomas Gleixner (5):
      gpio: amd-fch: Fix bogus SPDX identifier
      watchdog: Respect watchdog cpumask on CPU hotplug
      cpu/hotplug: Prevent crash when CPU bringup fails on CONFIG_HOTPLUG_C=
PU=3Dn
      x86/smp: Enforce CONFIG_HOTPLUG_CPU when SMP=3Dy
      MAINTAINERS: Remove deleted file from futex file pattern

Thomas Richter (1):
      s390/cpumf: Fix warning from check_processor_id

Tobias Klauser (1):
      doc: fix link to MSG_ZEROCOPY patchset

Todd Kjos (2):
      binder: fix BUG_ON found by selinux-testsuite
      binder: fix race between munmap() and direct reclaim

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      sch_cake: Interpret fwmark parameter as a bitmask

Tom Zanussi (1):
      tracing: Remove unnecessary var_ref destroy in track_data_destroy()

Tony Krowiak (1):
      zcrypt: handle AP Info notification from CHSC SEI command

Trond Myklebust (3):
      SUNRPC: Don't let RPC_SOFTCONN tasks time out if the transport
is connected
      NFS: Fix a typo in nfs_init_timeout_values()
      pNFS/flexfiles: Fix layoutstats handling during read failovers

Tyrel Datwyler (4):
      scsi: ibmvfc: Remove "failed" from logged errors
      scsi: ibmvfc: Add failed PRLI to cmd_status lookup array
      scsi: ibmvfc: Byte swap status and error codes when logging
      scsi: ibmvfc: Clean up transport events

Uwe Kleine-K=C3=B6nig (2):
      ARM: imx_v6_v7_defconfig: continue compiling the pwm driver
      ARM: imx_v4_v5_defconfig: enable PWM driver

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Mark AML 0x87CA as ULX

Vinay K Nallamothu (1):
      mpls: Fix 6PE forwarding

Vincent Stehl=C3=A9 (1):
      cpufreq: scpi: Fix use after free

Vinod Koul (1):
      MAINTAINERS: Fix uniphier-mdmac.c file path

Vitaly Kuznetsov (1):
      x86/kvm/hyper-v: avoid spurious pending stimer on vCPU init

Vladimir Oltean (1):
      net: phy: bcm54xx: Encode link speed and activity into LEDs

Wang Hai (1):
      net-sysfs: Fix memory leak in netdev_register_kobject

Wei Li (1):
      perf machine: Update kernel map address and re-order properly

Wei Yang (1):
      KVM: x86: remove check on nr_mmu_pages in kvm_arch_commit_memory_regi=
on()

Wei Yongjun (1):
      mt76: fix return value check in mt76_wmac_probe()

Weinan Li (1):
      drm/i915/gvt: stop scheduling workload when vgpu is inactive

Wen Yang (5):
      ARM: imx51: fix a leaked reference by adding missing of_node_put
      net: xilinx: fix possible object reference leak
      net: ibm: fix possible object reference leak
      net: ethernet: ti: fix possible object reference leak
      coccinelle: put_device: reduce false positives

Wentao Wang (1):
      Disable kgdboc failed by echo space to
/sys/module/kgdboc/parameters/kgdboc

Wolfram Sang (5):
      i2c: iop3xx: make bindings file name match the driver
      i2c: mt65xx: make bindings file name match the driver
      i2c: stu300: make bindings file name match the driver
      i2c: sun6i-p2wi: make bindings file name match the driver
      i2c: wmt: make bindings file name match the driver

Xiaoyao Li (1):
      kvm/x86: Move MSR_IA32_ARCH_CAPABILITIES to array emulated_msrs

Xin Long (18):
      netfilter: bridge: set skb transport_header before entering
NF_INET_PRE_ROUTING
      sctp: get sctphdr by offset in sctp_compute_cksum
      sctp: not copy sctp_sock pd_lobby in sctp_copy_descendant
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_DELAYED_SACK sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_DEFAULT_SNDINFO sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_CONTEXT sock=
opt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_MAX_BURST so=
ckopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_AUTH_KEY soc=
kopt
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_AUTH_ACTIVE_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_AUTH_DELETE_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_AUTH_DEACTIVATE_KEY sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_DEFAULT_PRINFO sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_ENABLE_STREAM_RESET sockopt
      sctp: fix ignoring asoc_id for tcp-style sockets on SCTP_EVENT sockop=
t
      sctp: fix ignoring asoc_id for tcp-style sockets on
SCTP_STREAM_SCHEDULER sockopt
      ipv6: make ip6_create_rt_rcu return ip6_null_entry instead of NULL
      sctp: use memdup_user instead of vmemdup_user
      tipc: change to check tipc_own_id to return in tipc_net_stop

Xu Yu (1):
      bpf: do not restore dst_reg when cur_state is freed

Yang Shi (1):
      mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specif=
ied

Yasushi Asano (1):
      usb: host: xhci-rcar: Add XHCI_TRUST_TX_LENGTH quirk

Yonghong Song (1):
      selftests/bpf: fix segfault of test_progs when prog loading failed

Yoshiki Komachi (1):
      af_packet: fix the tx skb protocol in raw sockets with ETH_P_ALL

YueHaibing (6):
      appletalk: Fix potential NULL pointer dereference in
unregister_snap_client
      net-sysfs: call dev_hold if kobject_init_and_add success
      KVM: arm/arm64: vgic-its: Make attribute accessors static
      genetlink: Fix a memory leak on error path
      fs/proc/kcore.c: make kcore_modules static
      fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links

Yufen Yu (2):
      blk-mq: use blk_mq_put_driver_tag() to put tag
      blk-mq: update comment for blk_mq_hctx_has_pending()

Yunsheng Lin (1):
      net: hns3: fix for not calculating tx bd num correctly

Zenghui Yu (1):
      KVM: arm/arm64: Comments cleanup in mmu.c

Zhenyu Wang (4):
      drm/i915/gvt: Fix MI_FLUSH_DW parsing with correct index check
      drm/i915/gvt: Don't submit request for error workload dispatch
      drm/i915/gvt: Only assign ppgtt root at dispatch time
      drm/i915/gvt: Add mutual lock for ppgtt mm LRU list

Zhiqiang Liu (1):
      vxlan: Don't call gro_cells_destroy() before device is unregistered

raymond pang (1):
      libata: fix using DMA buffers on stack

zhengbin (1):
      scsi: core: Run queue when state is set to running after being blocke=
d
