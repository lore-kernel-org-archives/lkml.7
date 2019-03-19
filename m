Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D74520989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 05:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AEKF398o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCSFMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:12:43 -0400
Received: from ozlabs.org ([203.11.71.1]:53705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbfCSFMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 01:12:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Nh505qlnz9s71;
        Tue, 19 Mar 2019 16:12:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552972356;
        bh=tku+GLHBBIKdizp4RdWLxVyxmaR6u2f23FK40qxXntM=;
        h=Date:From:To:Cc:Subject:From;
        b=AEKF398oa/TgMSD9vI0zDqzxEFWD73P4u5xwifh68sFdXuDfzfEYNr20KdvwHRh3m
         OwE78/kro7XoAZTfJNl0S/WcOgiAIEOgmvW1EqLRE/q6+L7HFFsoINnzyrBzs2G5fE
         M+mLKr+z8IYWbSL1IWMkNvGXceikB7puYKOJEHKBESOSnFE8rciS9Y5GxfYA86VrwU
         eiDG1iX7NsAq2HAgATPzpDO1fsiOzBiRub4OYJ7/BdY2skpW0G/KZBJrWXbm7/OL/C
         K6fTJiEjdr6fYOT1Ar0thUTNHX7CUzp32pplRWxVs3+XvJCEde9B50EtUTB7blonO1
         TUrg/SQAFAueg==
Date:   Tue, 19 Mar 2019 16:12:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 19
Message-ID: <20190319161236.214675f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YSlRy_TBvBv1DY8r3g_yoJI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YSlRy_TBvBv1DY8r3g_yoJI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190318:

New trees: amdgpu-fixes, amdgpu

The amdgpu tree gained a conflict against Linus' tree and a build failure
for which I reverted a commit.

The drm-misc tree gained a conflict against the drm-intel tree.

The selinux tree gained a build failure so I used the version from
next-20190318.

The akpm-current tree gained a conflict against the amdgpu tree.

Non-merge commits (relative to Linus' tree): 1643
 1359 files changed, 50320 insertions(+), 21547 deletions(-)

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
Merging origin/master (9e98c678c2d6 Linux 5.1-rc1)
Merging fixes/master (2648624cfe7f adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (1f7ae812f87e x86/syscalls: Mark expecte=
d switch fall-throughs)
Merging kbuild-current/fixes (5453a3df2a5e Merge tag 'kconfig-v5.1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging arc-current/for-curr (9a18b5a412ba arch: arc: Kconfig: pedantic for=
matting)
Merging arm-current/fixes (d410a8a49e3e ARM: 8849/1: NOMMU: Fix encodings f=
or PMSAv8's PRBAR4/PRLAR4)
Merging arm64-fixes/for-next/fixes (74698f6971f2 arm64: Relax GIC version c=
heck during early boot)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (4622a2d43101 powerpc/6xx: fix setup and use of=
 SPRN_SPRG_PGDIR for hash32)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (25208dd856e7 doc: fix link to MSG_ZEROCOPY patchset)
Merging bpf/master (f01a7dbe98ae bpf: Try harder when allocating memory for=
 large maps)
Merging ipsec/master (6ee02a54ef99 xfrm6_tunnel: Fix potential panic when u=
nloading xfrm6_tunnel module)
Merging netfilter/master (74710e05906c netfilter: nft_redir: fix module aut=
oload with ip4)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (688cd8bd2c0f iwlwifi: fix 64-bit division)
Merging mac80211/master (d235c48b40d3 net: dsa: mv88e6xxx: power serdes on/=
off for 10G interfaces on 6390X)
Merging rdma-fixes/for-rc (ec4fe4bcc584 i40iw: Avoid panic when handling th=
e inetdev event)
Merging sound-current/for-linus (b4748e7ab731 ALSA: opl3: fix mismatch betw=
een snd_opl3_drum_switch definition and declaration)
Merging sound-asoc-fixes/for-linus (1c5b6a27e432 ASoC: rt5682: recording ha=
s no sound after booting)
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging spi-fixes/for-linus (7c3b21942dec Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (f57a98e1b713 PCI: Work around Synopsys dupli=
cate Device ID (HAPS USB3, NXP i.MX))
Merging driver-core.current/driver-core-linus (cd1b772d4881 driver core: re=
move BUS_ATTR())
Merging tty.current/tty-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging usb.current/usb-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (8d7fa3d4ea3f USB: serial: ftdi_sio: add=
 ID for Hjelmslund Electronics USB485)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging staging.current/staging-linus (90cd9bed5adb staging, mt7621-pci: fi=
x build without pci support)
Merging char-misc.current/char-misc-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (1c163f4c7b3f Linux 5.0)
Merging input-current/for-linus (44fc95e218a0 Input: wacom_serial4 - add su=
pport for Wacom ArtPad II tablet)
Merging crypto-current/master (00e87449430d crypto: caam - add missing put_=
device() call)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (7d4e591bc051 selftests: timers: use LDLIBS i=
nstead of LDFLAGS)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (3e35730dd754 mtd: powernv_flash: Fix device regis=
tration error)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (f6cab793d4a7 MIPS: Remove custom MIPS32 __ke=
rnel_fsid_t type)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (dc30e7039137 ARM: OMAP2+: Variable "reg" in funct=
ion omap4_dsi_mux_pads() could be uninitialized)
Merging kvm-fixes/master (de3ccd26fafc KVM: MMU: record maximum physical ad=
dress width in kvm_mmu_extended_role)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (8d0139ae5973 hwmon: (w83773g) Select REGMAP_I2C =
to fix build error)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (c8130f2c5c4e Merge branch 'misc-5.1' into n=
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
Merging scsi-fixes/fixes (388b4e6a00bb scsi: core: Avoid that system resume=
 triggers a kernel warning)
Merging drm-fixes/drm-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (000c4f90e3f0 drm/i915: Sanity=
 check mmap length against object size)
Merging mmc-fixes/fixes (9ce58dd7d9da mmc: davinci: remove extraneous __ini=
t annotation)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (bfeffd155283 Linux 5.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (e9abc611a941 drm/rockchip: vop=
: reset scale mode when win is disabled)
Merging kbuild/for-next (6fb7ef5a343d kbuild: pkg: grep include/config/auto=
.conf instead of $KCONFIG_CONFIG)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9ac060a708e0 leaking_addresses: Completely remove=
 --version flag)
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
Merging arm-soc/for-next (48d1dbf3918f arm-soc: document merges)
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
Merging imx-mxs/for-next (fe0b295f61af Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (c51f7f863552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (af3b69ea03a2 Merge branch 'omap-for-v5.1/cpsw' into =
for-next)
Merging reset/reset/next (dbfc54534dfc dt-bindings: reset: meson: add g12a =
bindings)
Merging qcom/for-next (75920dd0498d Merge tag 'qcom-fixes-for-5.0-rc8' into=
 doof)
Merging renesas/next (71775479b7cf Merge branches 'arm-dt-for-v5.2', 'arm-s=
oc-for-v5.2', 'arm64-defconfig-for-v5.2', 'arm64-dt-for-v5.2', 'drivers-for=
-v5.2' and 'dt-bindings-for-v5.2' into next)
Merging rockchip/for-next (6a8281008f61 Merge branch 'v5.1-armsoc/dts-fixes=
' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (30329ca944a4 ARM: dts: exynos: Fix interrupt=
 for shared EINTs on Exynos5260)
Merging sunxi/sunxi/for-next (65cfa029f488 Merge branch 'sunxi/dt-for-5.2' =
into sunxi/for-next)
Merging tegra/for-next (d92dde4f12f1 Merge branch for-5.1/fixes into for-ne=
xt)
Merging clk/clk-next (9e98c678c2d6 Linux 5.1-rc1)
Merging clk-samsung/for-next (81faa30df9b6 clk: samsung: exynos5433: Add se=
lected IMEM clocks)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (88d5f20a8139 csky: Fixup vdsp&fpu issues in kernel)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (aeb669d41ffa MIPS: lantiq: Remove separate GPHY Fir=
mware loader)
Merging nds32/next (4e8fa54d3d99 nds32: fix semicolon code style issue)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (dae50289effc Revert: parisc: Use F_EXTEND() mac=
ro in iosapic code)
Merging powerpc/next (de3c83c2fd2b powerpc/64s: Include <asm/nmi.h> header =
file to fix a warning)
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
Merging btrfs-kdave/for-next (836b12f8c30d Merge branch 'for-next-next-v5.0=
-20190228' into for-next-20190228)
CONFLICT (content): Merge conflict in fs/btrfs/transaction.c
Merging ceph/master (16d80c54ad42 rbd: set io_min, io_opt and discard_granu=
larity to alloc_size)
Merging cifs/for-next (643b07d8a67a fix incorrect error code mapping for OB=
JECTID_NOT_FOUND)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (547c7915ff83 fanotify: Allow copying of file handle =
to userspace)
Merging ext4/dev (6c7328400e04 ext4: report real fs size after failed resiz=
e)
Merging f2fs/dev (aff7b628ac2d f2fs: set pin_file under CAP_SYS_ADMIN)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (9e98c678c2d6 Linux 5.1-rc1)
Merging nfs-anna/linux-next (a3b22b9f11d9 Linux 5.0-rc7)
Merging nfsd/nfsd-next (f875a792abe9 nfsd: allow nfsv3 readdir request to b=
e larger.)
Merging orangefs/for-next (6e356d45950e orangefs: remove two un-needed BUG_=
ONs...)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (5578e48e5c0b ubi: wl: Silence uninitialized varia=
ble warning)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (6ef50fe9afae xfs: clean up xfs_dir2_leaf_addname)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (c0abe5af7341 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
Merging printk/for-next (943ca6ad81e5 printk/docs: Add extra integer types =
to printk-formats)
Merging pci/next (dd92b6677e3d Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (fb243959c9b0 Merge branch 'for-5.1/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging i3c/i3c/next (988bb4a1937b i3c: master: dw-i3c-master: mark expecte=
d switch fall-through)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (985e225142cf dt-bindings: hwmon: Add miss=
ing documentation for lm75)
Merging jc_docs/docs-next (9834857754ff doc:it_IT: translations for documen=
ts in process/)
Merging v4l-dvb/master (9e98c678c2d6 Linux 5.1-rc1)
Merging v4l-dvb-next/master (9e98c678c2d6 Linux 5.1-rc1)
Merging fbdev/fbdev-for-next (9a9f1d1a81a9 fbdev: mbx: fix a misspelled var=
iable name)
Merging pm/linux-next (fa59d1e0bc51 Merge branches 'acpi-scan', 'acpi-misc'=
 and 'acpi-debug' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (0334906c0696 cpufreq: kryo: Rel=
ease OPP tables on module removal)
Merging cpupower/cpupower (ae2917093fb6 tools/power/cpupower: Display boost=
 frequency separately)
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
Merging rdma/for-next (fca22e7e595f net/mlx5: ODP support for XRC transport=
 is not enabled by default in FW)
Merging net-next/master (3b319ee220a8 Merge tag 'acpi-5.1-rc1-2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging bpf-next/master (d9862cfbe209 Merge tag 'mips_5.1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/mips/linux)
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (37b6bb77c6fd net/mlx5: Factor out HCA capabili=
ties functions)
Merging netfilter-next/master (8c4238df4d0c Merge branch 'mlxsw-minimal-Add=
-ethtool-and-resource-query-support')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (501faf710230 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (e7564582f65b Bluetooth: btsdio: Use module_sdio_d=
river helper)
Merging mac80211-next/master (be9cefe796f3 selftests: rtnetlink: use intern=
al netns switch for ip commands)
Merging gfs2/for-next (12ad143e1b80 Merge branch 'perf-urgent-for-linus' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging mtd/mtd/next (9220d7befc9c Merge tag 'nand/for-5.1' of git://git.in=
fradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (53bcbb839438 mtd: rawnand: denali_dt: remove single=
 anonymous clock support)
Merging spi-nor/spi-nor/next (225c0eda36bd mtd: spi-nor: Fix wrong abbrevia=
tion HWCPAS)
Merging crypto/master (0918f18c7179 crypto: s5p - add AES support for Exyno=
s5433)
Merging drm/drm-next (9e98c678c2d6 Linux 5.1-rc1)
Merging amdgpu/drm-next (efb399511304 drm/amdgpu: revert "cleanup setting b=
ulk_movable")
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Applying: Revert "drm/amd/display: On DCN1, Wait for vupdate on cursor upda=
tes"
Merging drm-intel/for-linux-next (65baf0ef046b drm/i915: Hold a ref to the =
ring while retiring)
Merging drm-tegra/drm/tegra/for-next (ca52507efc03 drm/tegra: vic: Fix impl=
icit function declaration warning)
Merging drm-misc/for-linux-next (29054230f3e1 drm: add non-desktop quirks t=
o Sensics and OSVR headsets.)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_hdmi.c
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
Merging regmap/for-next (66fb181d6f82 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (cc4f8e91c4ed ALSA: firewire-lib: use 8 byte header =
for IR context to get isochronous cycle)
Merging sound-asoc/for-next (3863293a96c3 Merge branch 'for-5.1' of https:/=
/git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into asoc-5.2)
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
Merging mmc/next (b3725d97ba75 Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (d2d833e0bf2b mfd: mxs-lradc: Mark expected switch=
 fall-through)
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (655ab0bc462d power: reset: at91-reset: add suppor=
t for sam9x60 SoC)
Merging regulator/for-next (e2a08e75a11f Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (3963bdb87e66 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (6c07c1c74394 apparmor: fix blob compression=
 when ns is forced on a policy load)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (ff1bf4c0714e selinux: use kernel linux/socket.h for g=
enheaders and mdp)
$ git reset --hard HEAD^
Merging next-20190318 version of selinux
Merging tpmdd/next (5812f97c0a22 tpm: Fix the type of the return value in c=
alc_tpm2_event_size())
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (1150bc31ffe6 Merge branches 'iommu/fixes' and 'x86/vt-d=
' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (95e0b46fcebd audit: fix a memleak caused by auditing lo=
ad module)
Merging devicetree/for-next (935665c1a117 of: unittest: unflatten device tr=
ee on UML when testing)
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (b1856c93fd6d Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (2d8fdbb66245 Merge branch 'x86/uv')
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (580b5cf50ca8 EDAC/altera: Add separate SDRAM EDA=
C config)
Merging irqchip/irq/irqchip-next (b41fdc4a7bf9 irqchip/gic: Drop support fo=
r secondary GIC in non-DT systems)
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
Merging percpu/for-next (d33d9f3dd96b percpu: use chunk scan_hint to skip s=
ome scanning)
Merging workqueues/for-next (a2775bbc1d58 kernel/workqueue: Use __printf ma=
rkup to silence compiler in function 'alloc_workqueue')
Merging drivers-x86/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging chrome-platform/for-next (e363d6f29198 platform/chrome: Fix locking=
 pattern in wilco_ec_mailbox())
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (17bd79289638 leds: pca955x: Revert "Add ACPI support=
")
Merging ipmi/for-next (487ecb21fa66 ipmi: fix sleep-in-atomic in free_user =
at cleanup SRCU user->release_barrier)
Merging driver-core/driver-core-next (9e98c678c2d6 Linux 5.1-rc1)
Merging usb/usb-next (9e98c678c2d6 Linux 5.1-rc1)
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (6431866b6707 USB: serial: option: add Telit ME=
910 ECM composition)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (b8998e928030 phy: tegra: xusb: Add Tegra186 support)
Merging tty/tty-next (9e98c678c2d6 Linux 5.1-rc1)
Merging char-misc/char-misc-next (9e98c678c2d6 Linux 5.1-rc1)
Merging extcon/extcon-next (97faf3b90ee3 extcon: Fix build warning for extc=
on_unregister_notifier comment)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (2a6d2af3ec96 thunderbolt: Fix a missing check of =
kmemdup)
Merging staging/staging-next (043ad6b1c112 staging: rtl8723bs: Remove Dead =
Code in core/rtw_mlme.c)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (fcf9d0b7d2f5 drm/msm/a6xx: Add support for an interco=
nnect path)
Merging slave-dma/next (9e98c678c2d6 Linux 5.1-rc1)
Merging cgroup/for-next (6a613d24effc cpuset: remove unused task_has_mempol=
icy())
Merging scsi/for-next (c589c80ade7c Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (2ee60cf005d8 scsi: ia64: simscsi: use request ta=
g instead of serial_number)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (3fbdb54c7d5a arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in drivers/iommu/Makefile
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gpio-brgl/gpio/for-next (2e35bb6cd421 gpio: vf610: Don't use explic=
it &pdev->dev in vf610_gpio_probe())
Merging pinctrl/for-next (9bc8fee96e9a pinctrl: imx: fix scu link errors)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (d7d96312fe10 pwm: atmel: Remove useless symbolic defi=
nitions)
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (0e27ded1159f selftests/ftrace: Handle the absence o=
f tput)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (b420648f103d Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (0b7ba42535b7 coresight: catu: fix clang build warni=
ng)
Merging rtc/rtc-next (e91b94fd2bc4 rtc: pic32: convert to SPDX identifier)
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging ntb/ntb-next (8af642c76ef5 NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (50ceaa95ea09 lib: Introduce test_stackinit modu=
le)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
CONFLICT (content): Merge conflict in arch/powerpc/configs/skiroot_defconfig
Merging gnss/gnss-next (d4584bbfcf2a gnss: add driver for mediatek receiver=
s)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging nvmem/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (396ae57ef1ef Drivers: hv: vmbus: Expose counter=
s for interrupts and full conditions)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (f67dcc84eb36 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging devfreq/for-next (ca740a8f3e7f PM / devfreq: Fix static checker war=
ning in try_then_request_governor)
Merging akpm-current/current (097770be40ca ipc: do cyclic id allocation wit=
h ipcmni_extend mode)
CONFLICT (content): Merge conflict in mm/hmm.c
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
Merging akpm/master (3d41c6b20fa6 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/YSlRy_TBvBv1DY8r3g_yoJI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyQekQACgkQAVBC80lX
0GzbRwf/eQSuqgQoWV/ibmJ9crD9ITkI9Qf4sY2Oq/rRTPXKa2spRVRo4lF6El80
FYnW2TqdfSu01L98B8zF3R2HQSCVT+qo5VkVpYOBeBtD5SuvNpg6eZphBNBNYPfh
eIOQXs8H2CWl63td5/ATWXz/CQUtqk1bYkZ1E3bKpCdEPfBtfETQDKAQmcd9PEPA
wc5TFCY5j7vD2eONGcHU9NhGjo8+FNHymYfmuSi0AYV9wVpmUrh+Gtx3x5WEUqRy
IiUun7God6s39iUqftP8lE5v8xYoAqva64Ut0bUpb0hYY8EUTQZqd6Ikg2PkBWfv
csT7FLgMpPsQ2gHeAB8wY80+/ewmVA==
=oLwQ
-----END PGP SIGNATURE-----

--Sig_/YSlRy_TBvBv1DY8r3g_yoJI--
