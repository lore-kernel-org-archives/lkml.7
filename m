Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7588C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="t3CbG4LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfC0DuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:50:25 -0400
Received: from ozlabs.org ([203.11.71.1]:57353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbfC0DuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:50:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44TYtP24y0z9sSl;
        Wed, 27 Mar 2019 14:50:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553658621;
        bh=JR3nW+X807mR/8wWGExFa7ihMi3ICAekXWRuIPHOoaE=;
        h=Date:From:To:Cc:Subject:From;
        b=t3CbG4LRTAbP5WvYIpLy8luKc8YObRLpD1QjsbGGdXvT049gPmuyZl96jzbRZiUmz
         aCRHSD4hXjlvHEdC+5cNYYZg7HzkE0rJXDPsgs30sdjTXMJzM0Ypo7BX7TkUIIhJy/
         nHXYNJc6HKqCmmgu6iA3BUGRir3LdR7SC18NmKPED5kZE1vzgkOhgL2hsjuqWB2gsf
         IvS7FCJILUmJkGexw220FF3kxzunsoaed3IY9AlQEUlaU7GgS50EklhZNNWITPEIw7
         vyMOGCkNwqY6E0kZK44ybbcINhE1VNrmuIX+JmJn0/DTO/qx3Ii42HguDaxoA+OVDd
         hre4dvCOx9pJQ==
Date:   Wed, 27 Mar 2019 14:50:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 27
Message-ID: <20190327145020.2fff97b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6avwWivjuT6BEN5dkXmR8N4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6avwWivjuT6BEN5dkXmR8N4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190326:

The bpf-next tree gained a conflict against the net tree.

The sound-asoc tree lost its build failure but gained another for which
I reverted 3 commits.

The drm-intel tree gained a build failure for which I reverted some
comits.

Non-merge commits (relative to Linus' tree): 3198
 2776 files changed, 86711 insertions(+), 44562 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 299 trees (counting Linus' and 70 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (65ae689329c5 Merge tag 'for-5.1-rc2-tag' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/master (b352face4ca9 adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (1f7ae812f87e x86/syscalls: Mark expecte=
d switch fall-throughs)
Merging kbuild-current/fixes (688931a5ad4e kbuild: skip sub-make for in-tre=
e build with GNU Make 4.x)
Merging arc-current/for-curr (172fe06c57b8 ARC: ioc: diasble ioc if HIGHMEM=
/PAE iso panic)
Merging arm-current/fixes (d410a8a49e3e ARM: 8849/1: NOMMU: Fix encodings f=
or PMSAv8's PRBAR4/PRLAR4)
Merging arm64-fixes/for-next/fixes (e5a5af771861 arm64: remove obsolete sel=
ection of MULTI_IRQ_HANDLER)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (92edf8df0ff2 powerpc/security: Fix spectre_v2 =
reporting)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (8c838f53e149 dpaa2-eth: fix race condition with bql fra=
me accounting)
Merging bpf/master (f52c97d9df98 bpf, doc: fix BTF docs reflow of bullet li=
st)
Merging ipsec/master (01ce31c57b3f vti4: removed duplicate log message.)
Merging netfilter/master (5f543a54eec0 net: hns3: fix for not calculating t=
x bd num correctly)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (526949e877f4 rxrpc: avoid clang -Wuninitia=
lized warning)
Merging mac80211/master (d235c48b40d3 net: dsa: mv88e6xxx: power serdes on/=
off for 10G interfaces on 6390X)
Merging rdma-fixes/for-rc (8c2ffd917477 Linux 5.1-rc2)
Merging sound-current/for-linus (e2a829b3da01 ALSA: hda/realtek - Fix speak=
ers on Acer Predator Helios 500 Ryzen laptops)
Merging sound-asoc-fixes/for-linus (3c87e7364daa Merge branch 'asoc-5.1' in=
to asoc-linus)
Merging regmap-fixes/for-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging regulator-fixes/for-linus (6b0c8dbad170 Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (7c8e7c47b3f2 Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (0fa635aec9ab PCI/LINK: Deduplicate bandwidth=
 reports for multi-function devices)
Merging driver-core.current/driver-core-linus (cd1b772d4881 driver core: re=
move BUS_ATTR())
Merging tty.current/tty-linus (93bcefd4c6ba serial: sh-sci: Fix setting SCS=
CR_TIE while transferring data)
Merging usb.current/usb-linus (3d54d10c6afe usb: mtu3: fix EXTCON dependenc=
y)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (2908b076f519 USB: serial: mos7720: fix =
mos_parport refcount imbalance on error path)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging staging.current/staging-linus (9498da46d1ce staging: octeon-etherne=
t: fix incorrect PHY mode)
Merging char-misc.current/char-misc-linus (5cec2d2e5839 binder: fix race be=
tween munmap() and direct reclaim)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (8c2ffd917477 Linux 5.1-rc2)
Merging input-current/for-linus (44fc95e218a0 Input: wacom_serial4 - add su=
pport for Wacom ArtPad II tablet)
Merging crypto-current/master (00e87449430d crypto: caam - add missing put_=
device() call)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (76d252fecf58 selftests: efivarfs: remove the=
 test_create_read file if it was exist)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (9dfec7ca0ba7 dmaengine: stm32-mdma: Revert "=
dmaengine: stm32-mdma: Add a check on read_u32_array")
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (3e35730dd754 mtd: powernv_flash: Fix device regis=
tration error)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging reset-fixes/reset/fixes (13e8a05b9224 reset: meson-audio-arb: Fix m=
issing .owner setting of reset_controller_dev)
Merging mips-fixes/mips-fixes (f6cab793d4a7 MIPS: Remove custom MIPS32 __ke=
rnel_fsid_t type)
Merging at91-fixes/at91-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging omap-fixes/fixes (6691370646e8 ARM: dts: am335x-evmsk: Correct the =
regulators for the audio codec)
Merging kvm-fixes/master (de3ccd26fafc KVM: MMU: record maximum physical ad=
dress width in kvm_mmu_extended_role)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (99effd8af527 hwmon: (ntc_thermistor) Fix tempera=
ture type reporting)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (fb7d5dc911b1 Merge branch 'misc-5.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (d3d6a18d7d35 aio: Fix locking in aio_poll())
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (fba1bdd2a9a9 scsi: qla4xxx: fix a potential NULL =
pointer dereference)
Merging drm-fixes/drm-fixes (de53874a0f70 Merge tag 'drm-misc-fixes-2019-03=
-25' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (4b9a3932e7ba drm/i915: Mark A=
ML 0x87CA as ULX)
Merging mmc-fixes/fixes (8c2ffd917477 Linux 5.1-rc2)
Merging rtc-fixes/rtc-fixes (15d82d224987 rtc: sh: Fix invalid alarm warnin=
g for non-enabled alarm)
Merging gnss-fixes/gnss-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging hyperv-fixes/hyperv-fixes (46fc15487d02 Drivers: hv: vmbus: Expose =
monitor data only when monitor pages are used)
Merging drm-misc-fixes/for-linux-next-fixes (836f90f9e2d1 drm/bridge: dw-hd=
mi: disable SCDC configuration for invalid setups)
Merging kbuild/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (9eb9e96e97b3 Documentation/DMA-API-HOWTO: upd=
ate dma_mask sections)
Merging asm-generic/master (d724444ab97d asm-generic/page.h: fix typo in #e=
rror text requiring a real asm/page.h)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (4c2741ac5e10 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (b855b58ac1b7 arm64: mmu: drop paging_init comm=
ents)
Merging arm-perf/for-next/perf (cf2d65ec1d21 perf: xgene: Remove set but no=
t used variable 'config')
Merging arm-soc/for-next (93958742192e arm64: tegra: Disable CQE Support fo=
r SDMMC4 on Tegra186)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (e37c380254ef Merge branch 'v5.2/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (69dd6b9f7d58 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (5de92a35a8fb Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (c51f7f863552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging reset/reset/next (22815f1825e4 reset: Add acquire/release support f=
or arrays)
Merging qcom/for-next (75920dd0498d Merge tag 'qcom-fixes-for-5.0-rc8' into=
 doof)
Merging renesas/next (0958f03890a3 Merge branches 'arm-dt-for-v5.2' and 'ar=
m64-dt-for-v5.2' into next)
Merging rockchip/for-next (10a3eb1dccf7 Merge branch 'v5.1-armsoc/dts-fixes=
' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (377e1eb1008a Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (613e2ef60188 Merge branches 'sunxi/dt-for-5.2=
', 'sunxi/dt64-for-5.2' and 'sunxi/h3-h5-for-5.2' into sunxi/for-next)
Merging tegra/for-next (aaffea6880ea Merge branch for-5.2/soc into for-next)
Merging clk/clk-next (1772ee64946d Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (9eb1b84d0104 csky: Add non-uapi asm/ptrace.h names=
pace)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (733df11cfc36 m68k: defconfig: Update defconfigs for =
v5.1-rc1)
Merging m68knommu/for-next (8c2ffd917477 Linux 5.1-rc2)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (e6331a321aaf MIPS: KVM: Use prandom_u32_max() to ge=
nerate tlbwr index)
Merging nds32/next (4e8fa54d3d99 nds32: fix semicolon code style issue)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (4433887f3cd2 Revert: parisc: Use F_EXTEND() mac=
ro in iosapic code)
Merging powerpc/next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (13fd5de06514 RISC-V: Fixmap support and MM cleanup=
s)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (152e9b8676c6 s390/vtime: steal time exponential movi=
ng average)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (aea05eb56e47 um: Fix for a possible OOPS in ubd ini=
tialization)
Merging xtensa/xtensa-for-next (036ef74b3ecb Merge branch 'xtensa-5.1' into=
 xtensa-for-next)
Merging fscrypt/master (129ca2d2a83f MAINTAINERS: add Eric Biggers as an fs=
crypt maintainer)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (d39b26f16763 Merge branch 'for-next-stale-201=
90326' into for-next-20190326)
Merging ceph/master (187df76325af libceph: fix breakage caused by multipage=
 bvecs)
Merging cifs/for-next (4ad8ad2d8d07 CIFS: prevent refcount underflow)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (b0ad51173b3d Pull udf truncate fix.)
Merging ext4/dev (18915b5873f0 ext4: prohibit fstrim in norecovery mode)
Merging f2fs/dev (26f34433d5a4 f2fs: improve discard handling with multi-de=
vice volumes)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (166bd5b889ac pNFS/flexfiles: Fix layoutstats handli=
ng during read failovers)
Merging nfs-anna/linux-next (a3b22b9f11d9 Linux 5.0-rc7)
Merging nfsd/nfsd-next (93ab8c06c203 nfsd: avoid uninitialized variable war=
ning)
Merging orangefs/for-next (6e356d45950e orangefs: remove two un-needed BUG_=
ONs...)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (5578e48e5c0b ubi: wl: Silence uninitialized varia=
ble warning)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (6ef50fe9afae xfs: clean up xfs_dir2_leaf_addname)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (c0abe5af7341 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
Merging printk/for-next (2821fd0c2be0 lib/test_printf: Switch to bitmap_zal=
loc())
Merging pci/next (9e98c678c2d6 Linux 5.1-rc1)
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (53be96ab821a Merge branch 'for-5.1/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (cc6e0cb5f4a0 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (988bb4a1937b i3c: master: dw-i3c-master: mark expecte=
d switch fall-through)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (ab69001fa2bd hwmon: (ntc_thermistor) Use =
new HWMON_CHANNEL_INFO() macro)
Merging jc_docs/docs-next (6c5d24eef7be checkpatch: Warn on improper usage =
of Co-developed-by)
Merging v4l-dvb/master (149e31e90b50 media: v4l: rcar_fdp1: Fix indentation=
 oddities)
Merging v4l-dvb-next/master (81527254e151 media: seco: depend on CONFIG_RC_=
CORE=3Dy when not a module)
Merging fbdev/fbdev-for-next (9a9f1d1a81a9 fbdev: mbx: fix a misspelled var=
iable name)
Merging pm/linux-next (297042c1742f Merge branch 'pm-x86' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (0334906c0696 cpufreq: kryo: Rel=
ease OPP tables on module removal)
Merging cpupower/cpupower (8c2ffd917477 Linux 5.1-rc2)
Merging opp/opp/linux-next (a9a744dd5b82 cpufreq: OMAP: Register an Energy =
Model)
Merging thermal/next (2d7c4e17811f Merge branches 'fixes' and 'thermal-inte=
l' into next)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (8526e331c56f dlm: Fix test for -ERESTARTSYS)
Merging swiotlb/linux-next (22cb45d7692a swiotlb: drop pointless static qua=
lifier in swiotlb_create_debugfs())
Merging rdma/for-next (8c2ffd917477 Linux 5.1-rc2)
Merging net-next/master (fa7e428c6b7e openvswitch: add seqadj extension whe=
n NAT is used.)
Merging bpf-next/master (60e4786e229d tools/bpf: generate pkg-config file f=
or libbpf)
CONFLICT (content): Merge conflict in tools/lib/bpf/Makefile
Merging ipsec-next/master (f981c57ffd2d vti4: eliminated some duplicate cod=
e.)
Merging mlx5-next/mlx5-next (37b6bb77c6fd net/mlx5: Factor out HCA capabili=
ties functions)
Merging netfilter-next/master (68cc2999f692 Merge branch 'devlink-small-spr=
ing-cleanup')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (526949e877f4 rxrpc: avoid clang -Wuni=
nitialized warning)
Merging bluetooth/master (bbcece3d418c Bluetooth: mediatek: Fixed incorrect=
 type in assignment)
Merging mac80211-next/master (be9cefe796f3 selftests: rtnetlink: use intern=
al netns switch for ip commands)
Merging gfs2/for-next (d86dbd82b9a0 gfs2: Fix loop in gfs2_rbm_find (v2))
Merging mtd/mtd/next (9220d7befc9c Merge tag 'nand/for-5.1' of git://git.in=
fradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (9e98c678c2d6 Linux 5.1-rc1)
Merging spi-nor/spi-nor/next (7cbae399bde1 spi-nor: s25fl512s supports regi=
on locking)
Merging crypto/master (4e5180eb3d4f crypto: Kconfig - fix typos AEGSI -> AE=
GIS)
Merging drm/drm-next (0bec6219e5a0 Merge tag 'drm-misc-next-2019-03-21' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_drv.c
Merging amdgpu/drm-next (463fabd56188 drm/amd/display: Only allow VRR when =
vrefresh is within supported range)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-intel/for-linux-next (9511cb6481af drm/i915: Adding missing '; =
' to ENGINE_INSTANCES)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_hdmi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gvt/mmio_context=
.c
Merging drm-tegra/drm/tegra/for-next (11c632e1cfd3 drm/tegra: sor: Implemen=
t acquire/release for reset)
Merging drm-misc/for-linux-next (8782c647aec4 drm/fbdev: Make skip_vt_switc=
h the default)
Merging drm-msm/msm-next (745b19d74716 drm/msm/dpu: check split role for si=
ngle flush)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (b4a650fb0d72 drm/komeda: Add debugfs =
node "register" for register dump)
Merging imx-drm/imx-drm/next (a0ea4ffff266 drm/imx: only send commit done e=
vent when all state has been applied)
Merging etnaviv/etnaviv/next (9e05352340d3 drm/etnaviv: potential NULL dere=
ference)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (cc6a8d69ba62 regmap: debugfs: Jump to the next rea=
dable register)
Merging sound/for-next (e42dd3ee3f9c ALSA: emux: Add support of loading GUS=
-patch)
Merging sound-asoc/for-next (225b4db1cecf Merge branch 'asoc-5.2' into asoc=
-next)
Applying: Revert "ASoC: fsl: Add Audio Mixer CPU DAI driver"
Applying: Revert "ASoC: add fsl_audmix DT binding documentation"
Applying: Revert "ASoC: fsl: Add Audio Mixer machine driver"
Merging modules/modules-next (9672e2cb0fbd vmlinux.lds.h: drop unused __ver=
magic)
Merging input/next (6d3a41ab0c37 Input: edt-ft5x06 - convert to use SPDX id=
entifier)
Merging block/for-next (602d674ce90f nvme-tcp: support C2HData with SUCCESS=
 flag)
Merging device-mapper/for-next (225557446856 dm integrity: limit the rate o=
f error messages)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (db3d9547ee6a mmc: sdhci-of-arasan: Add DTS property to di=
sable DCMDs.)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (d2d833e0bf2b mfd: mxs-lradc: Mark expected switch=
 fall-through)
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging regulator/for-next (a2ad7f1e615b Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (3963bdb87e66 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (6c07c1c74394 apparmor: fix blob compression=
 when ns is forced on a policy load)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (98bbbb76f2ed selinux: avoid uninitialized variable wa=
rning)
Merging tpmdd/next (5812f97c0a22 tpm: Fix the type of the return value in c=
alc_tpm2_event_size())
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (4b144056431d Merge branches 'iommu/fixes', 'x86/vt-d' a=
nd 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (16add411645c syscall_get_arch: add "struct task_struct =
*" argument)
Merging devicetree/for-next (935665c1a117 of: unittest: unflatten device tr=
ee on UML when testing)
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (018a790fb20a Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (a8e7ea235ed1 Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (fc00c6a41638 EDAC/amd64: Adjust printed chip sel=
ect sizes when interleaved)
Merging irqchip/irq/irqchip-next (fca269f201a8 irqchip/mbigen: Don't clear =
eventid when freeing an MSI)
Merging ftrace/for-next (85f726a35e50 tracing: Use strncpy instead of memcp=
y when copying comm in trace.c)
Merging rcu/rcu/next (e880edadc149 Merge LKMM and RCU)
Merging kvm/linux-next (4a605bc08e98 kvm: vmx: fix formatting of a comment)
Merging kvm-arm/next (c88b093693cc arm64: KVM: Fix architecturally invalid =
reset value for FPEXC32_EL2)
Merging kvm-ppc/kvm-ppc-next (2b57ecd0208f KVM: PPC: Book3S: Add count cach=
e flush parameters to kvmppc_get_cpu_char())
Merging kvms390/next (11ba5961a215 KVM: s390: add debug logging for cpu mod=
el subfunctions)
Merging xen-tip/linux-next (0266def91377 xen/balloon: Fix mapping PG_offlin=
e pages to user space)
Merging percpu/for-next (cb453ce4846b Merge branch 'for-5.2' into for-next)
Merging workqueues/for-next (8194fe94ab08 kernel/workqueue: Document wq_wor=
ker_last_func() argument)
Merging drivers-x86/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging chrome-platform/for-next (8c2ffd917477 Linux 5.1-rc2)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (09466021a80c leds: netdev trigger: use memcpy in dev=
ice_name_store)
Merging ipmi/for-next (906242774f86 ipmi: Make ipmi_interfaces_srcu variabl=
e static)
Merging driver-core/driver-core-next (9e98c678c2d6 Linux 5.1-rc1)
Merging usb/usb-next (bb31b352510b usb: typec: fusb302: Add __printf attrib=
ute to fusb302_log function)
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (9e98c678c2d6 Linux 5.1-rc1)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (b8998e928030 phy: tegra: xusb: Add Tegra186 support)
Merging tty/tty-next (9e98c678c2d6 Linux 5.1-rc1)
Merging char-misc/char-misc-next (9e98c678c2d6 Linux 5.1-rc1)
Merging extcon/extcon-next (9d8e2af50df7 extcon: mrfld: Introduce extcon dr=
iver for Basin Cove PMIC)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (48f40b96de2c thunderbolt: xdomain: Fix to check r=
eturn value of kmemdup)
Merging staging/staging-next (14a56ec65bab staging: erofs: support IO read =
error injection)
CONFLICT (content): Merge conflict in drivers/staging/erofs/unzip_vle.c
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (fcf9d0b7d2f5 drm/msm/a6xx: Add support for an interco=
nnect path)
Merging slave-dma/next (23b846396b95 dmaengine: axi-dmac: extend support fo=
r ZynqMP arch)
Merging cgroup/for-next (0fcc4c8c044e device_cgroup: fix RCU imbalance in e=
rror case)
Merging scsi/for-next (55d4337e14d4 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (3e14592da654 scsi: gdth: Only call dma_free_cohe=
rent when buf is not NULL in ioc_general)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (3fbdb54c7d5a arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in drivers/iommu/Makefile
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (3b55cb88c389 Merge tag 'gpio-5.1-rc2-fixes-for-linus=
' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into fixes)
Merging gpio-brgl/gpio/for-next (c78c42d77165 gpio: add driver for Mellanox=
 BlueField GPIO controller)
Merging pinctrl/for-next (9bc8fee96e9a pinctrl: imx: fix scu link errors)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (9ff06679e109 pwm: sysfs: fix typo "its" -> "it's")
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (f5b2be36fa1d selftest/gpio: Remove duplicate header)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (b420648f103d Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (d5d246a56af0 coresight: Merge the static and dynami=
c replicator drivers)
Merging rtc/rtc-next (2bc81d03b915 rtc: mt6397: Don't call irq_dispose_mapp=
ing.)
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (d333bad1f6f3 dt-bindings: at24: add Renesas R1E=
X24016)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (50ceaa95ea09 lib: Introduce test_stackinit modu=
le)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (80471330ec58 slimbus: fix a NULL pointer derefere=
nce in of_qcom_slim_ngd_register)
Merging nvmem/for-next (6b37a3af354e nvmem: core: add nvmem_cell_read_u16)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (396ae57ef1ef Drivers: hv: vmbus: Expose counter=
s for interrupts and full conditions)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (f764e20d5f46 tests: add pidctl() tests)
Merging devfreq/for-next (e143645ca40d PM / devfreq: rk3399_dmc: Pass ODT a=
nd auto power down parameters to TF-A.)
Applying: Revert "drm/i915: Adding missing '; ' to ENGINE_INSTANCES"
Applying: Revert "drm/i915: Update size upon return from GEM_CREATE"
Applying: Revert "drm/i915: take a reference to uncore in the engine and us=
e it"
Applying: Revert "drm/i915: switch intel_wait_for_register to uncore"
Applying: Revert "drm/i915: intel_wait_for_register_fw to uncore"
Applying: Revert "drm/i915: switch intel_uncore_forcewake_for_reg to intel_=
uncore"
Applying: Revert "drm/i915: switch uncore mmio funcs to use intel_uncore"
Applying: Revert "drm/i915: take a ref to the rpm in the uncore structure"
Applying: Revert "drm/i915: add uncore flags for unclaimed mmio"
Applying: Revert "drm/i915: add HAS_FORCEWAKE flag to uncore"
Applying: Revert "drm/i915: rename raw reg access functions"
Merging akpm-current/current (90dcc77f765a ipc: do cyclic id allocation wit=
h ipcmni_extend mode)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: scripts/atomic/gen-atomics.sh: don't assume that scripts are exec=
utable
Applying: fs: fs_parser: fix printk format warning
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (a67e4bf8b4f5 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/6avwWivjuT6BEN5dkXmR8N4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlya8vwACgkQAVBC80lX
0GwlwQf6AjGoiv8BqQa/1szHBPmZJyJlcgOQPKGLX8ZRb4ZFBNFaCTM288xwWNeW
IPxNoBM7McqX8a2ZyTo2lDOFlQZDza5lzM344RcUe73DBr1YP3chm0gglHremgGo
An3xfE8IB/frn+RCSappHtdYdvKxPtj0eFyhreyA6/LsE0ltlOGGUI3MzDxBmEK6
imToYBjJAEGDZClT+DSHs/ra41YynZoucfgfEYWiN/ldk1be7dsIcQorsMVYhfDF
nLXRx/dsuioVVTnO5qyBmXWokN0orMnojJDHfuZkMBfPe2AMraHkhUlxh3cGdzP2
FuYJ5sEP6EsefK533CZy22YsfLYkxg==
=wiBU
-----END PGP SIGNATURE-----

--Sig_/6avwWivjuT6BEN5dkXmR8N4--
