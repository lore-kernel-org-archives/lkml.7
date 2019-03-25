Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6941AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB39F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VPvSrsae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfCYDJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:09:23 -0400
Received: from ozlabs.org ([203.11.71.1]:37109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbfCYDJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:09:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44SK3y08qmz9s70;
        Mon, 25 Mar 2019 14:09:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553483358;
        bh=/FALI3ir7mAPkZDqAtwmL8xoVXc5UhIc7KdDYe3DbiM=;
        h=Date:From:To:Cc:Subject:From;
        b=VPvSrsaehv59+vUF/RfX6fCVQSWw6K+4R96Z69J3u9IGmQdkTAVhz9mcmRIODTveK
         VTqVx9/YrzTdq8k1DlPWKiPYxO4gShWwg75zgT4dsX+NYq2kJMyZsGh8nroKm5Lm3Y
         JbHlGdB8LgZ6bwfyS1u+Kq+NXGsmRNbgN/YaDZaUDWm4K2Nj9h9L3d2mghkYCtKMsY
         3cTRHdmxIWke0y0CnMTyCdWEkQbHRDtujsssXdt0lDxdFVD2/+1am3FLSSdu2ZnAsw
         FdNQ4pvXOeG4TDW6tT2Wq4r2rjdFdxhZvijXWe0+OlhVC86JMlVLKUYeX4PamGdqDY
         ygdXw7VWT1Mhw==
Date:   Mon, 25 Mar 2019 14:09:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 25
Message-ID: <20190325140917.358f2107@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0iv0tmLM7RBHblCQlckD/dN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0iv0tmLM7RBHblCQlckD/dN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190322:

Non-merge commits (relative to Linus' tree): 2741
 2308 files changed, 76588 insertions(+), 37798 deletions(-)

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
Merging origin/master (231c807a6071 Merge branch 'sched-urgent-for-linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (b352face4ca9 adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (1f7ae812f87e x86/syscalls: Mark expecte=
d switch fall-throughs)
Merging kbuild-current/fixes (688931a5ad4e kbuild: skip sub-make for in-tre=
e build with GNU Make 4.x)
Merging arc-current/for-curr (9a18b5a412ba arch: arc: Kconfig: pedantic for=
matting)
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
Merging net/master (526949e877f4 rxrpc: avoid clang -Wuninitialized warning)
Merging bpf/master (83d163124cf1 bpf: verifier: propagate liveness on all f=
rames)
Merging ipsec/master (01ce31c57b3f vti4: removed duplicate log message.)
Merging netfilter/master (5f543a54eec0 net: hns3: fix for not calculating t=
x bd num correctly)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (7dfc45e6282a mt76x02: do not enable RTS/CT=
S by default)
Merging mac80211/master (d235c48b40d3 net: dsa: mv88e6xxx: power serdes on/=
off for 10G interfaces on 6390X)
Merging rdma-fixes/for-rc (ec4fe4bcc584 i40iw: Avoid panic when handling th=
e inetdev event)
Merging sound-current/for-linus (4fc90fb883fc ALSA: hda/ca0132 - Simplify a=
lt firmware loading code)
Merging sound-asoc-fixes/for-linus (0ff4e8c61b79 ASoC: fsl_esai: fix channe=
l swap issue when stream starts)
Merging regmap-fixes/for-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging regulator-fixes/for-linus (3e8a4628a4d4 Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (35137ca07194 Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging driver-core.current/driver-core-linus (cd1b772d4881 driver core: re=
move BUS_ATTR())
Merging tty.current/tty-linus (93bcefd4c6ba serial: sh-sci: Fix setting SCS=
CR_TIE while transferring data)
Merging usb.current/usb-linus (d92f2c59cc2c xhci: Don't let USB3 ports stuc=
k in polling state prevent suspend)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (2908b076f519 USB: serial: mos7720: fix =
mos_parport refcount imbalance on error path)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging staging.current/staging-linus (6a8ca24590a2 staging: rtlwifi: Fix p=
otential NULL pointer dereference of kzalloc)
Merging char-misc.current/char-misc-linus (5cec2d2e5839 binder: fix race be=
tween munmap() and direct reclaim)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging input-current/for-linus (44fc95e218a0 Input: wacom_serial4 - add su=
pport for Wacom ArtPad II tablet)
Merging crypto-current/master (00e87449430d crypto: caam - add missing put_=
device() call)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
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
Merging reset-fixes/reset/fixes (8ec49035c8a6 dt-bindings: reset: meson-g12=
a: Add missing USB2 PHY resets)
Merging mips-fixes/mips-fixes (f6cab793d4a7 MIPS: Remove custom MIPS32 __ke=
rnel_fsid_t type)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
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
Merging scsi-fixes/fixes (7f5203c13ba8 scsi: ibmvscsi: Fix empty event pool=
 access during host removal)
Merging drm-fixes/drm-fixes (8e078788b57d Merge branch 'drm-fixes-5.1' of g=
it://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (69903dfae031 drm/i915/icl: Fi=
x the TRANS_DDI_FUNC_CTL2 bitfield macro)
Merging mmc-fixes/fixes (c9a9497ccef2 mmc: renesas_sdhi: limit block count =
to 16 bit for old revisions)
Merging rtc-fixes/rtc-fixes (15d82d224987 rtc: sh: Fix invalid alarm warnin=
g for non-enabled alarm)
Merging gnss-fixes/gnss-linus (9e98c678c2d6 Linux 5.1-rc1)
Merging hyperv-fixes/hyperv-fixes (46fc15487d02 Drivers: hv: vmbus: Expose =
monitor data only when monitor pages are used)
Merging drm-misc-fixes/for-linux-next-fixes (e9abc611a941 drm/rockchip: vop=
: reset scale mode when win is disabled)
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
Merging renesas/next (2846fc448cf8 Merge branches 'arm-dt-for-v5.2' and 'ar=
m64-dt-for-v5.2' into next)
Merging rockchip/for-next (6a8281008f61 Merge branch 'v5.1-armsoc/dts-fixes=
' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (8a7e0f327b8e Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (ebbbe2442097 Merge branches 'sunxi/fixes-for-=
5.1' and 'sunxi/h3-h5-for-5.2' into sunxi/for-next)
Merging tegra/for-next (aaffea6880ea Merge branch for-5.2/soc into for-next)
Merging clk/clk-next (1772ee64946d Merge branch 'clk-fixes' into clk-next)
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
Merging mips/mips-next (371a415153be arch: mips: Kconfig: pedantic formatti=
ng)
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
Merging btrfs-kdave/for-next (a8d7c6cd42dd Merge branch 'next/stale-2019032=
2' into for-next-20190322)
Merging ceph/master (9d4a227f6ef1 rbd: drop wait_for_latest_osdmap())
Merging cifs/for-next (231c807a6071 Merge branch 'sched-urgent-for-linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
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
Merging nfs/linux-next (5a698243930c NFS: Fix a typo in nfs_init_timeout_va=
lues())
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
Merging file-locks/locks-next (b9637d08f1a5 locks: ignore same lock in bloc=
ked_lock_hash)
Merging vfs/for-next (c0abe5af7341 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
Merging printk/for-next (2821fd0c2be0 lib/test_printf: Switch to bitmap_zal=
loc())
Merging pci/next (9e98c678c2d6 Linux 5.1-rc1)
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (53be96ab821a Merge branch 'for-5.1/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging i3c/i3c/next (988bb4a1937b i3c: master: dw-i3c-master: mark expecte=
d switch fall-through)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (ab69001fa2bd hwmon: (ntc_thermistor) Use =
new HWMON_CHANNEL_INFO() macro)
Merging jc_docs/docs-next (9834857754ff doc:it_IT: translations for documen=
ts in process/)
Merging v4l-dvb/master (8a3946cad244 media: v4l2-fwnode: Add a deprecation =
note in the old ACPI parsing example)
Merging v4l-dvb-next/master (81527254e151 media: seco: depend on CONFIG_RC_=
CORE=3Dy when not a module)
Merging fbdev/fbdev-for-next (9a9f1d1a81a9 fbdev: mbx: fix a misspelled var=
iable name)
Merging pm/linux-next (2c9e385d1d4c Merge branches 'pm-domains' and 'pm-too=
ls' into linux-next)
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
Merging rdma/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging net-next/master (68cc2999f692 Merge branch 'devlink-small-spring-cl=
eanup')
Merging bpf-next/master (7df5e3db8f63 selftests: bpf: tc-bpf flow shaping w=
ith EDT)
Merging ipsec-next/master (e6d1407013a9 tcp: remove conditional branches fr=
om tcp_mstamp_refresh())
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
Merging drm/drm-next (9e98c678c2d6 Linux 5.1-rc1)
Merging amdgpu/drm-next (463fabd56188 drm/amd/display: Only allow VRR when =
vrefresh is within supported range)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-intel/for-linux-next (dd19f6bf9245 drm/i915: Remove defunct int=
el_suspend_gt_powersave())
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gvt/mmio_context=
.c
Merging drm-tegra/drm/tegra/for-next (11c632e1cfd3 drm/tegra: sor: Implemen=
t acquire/release for reset)
Merging drm-misc/for-linux-next (ff01e6971ecd drm/fourcc: Fix conflicting Y=
41x definitions)
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
Merging regmap/for-next (cc6a8d69ba62 regmap: debugfs: Jump to the next rea=
dable register)
Merging sound/for-next (cc4f8e91c4ed ALSA: firewire-lib: use 8 byte header =
for IR context to get isochronous cycle)
Merging sound-asoc/for-next (e9d5a8685259 Merge branch 'asoc-5.2' into asoc=
-next)
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
Merging mmc/next (15e7c91b26df Merge branch 'fixes' into next)
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
Merging regulator/for-next (c51372746475 Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (3963bdb87e66 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (6c07c1c74394 apparmor: fix blob compression=
 when ns is forced on a policy load)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (c72c4cde8095 selinux: Make selinux_kernfs_init_securi=
ty static)
Merging tpmdd/next (5812f97c0a22 tpm: Fix the type of the return value in c=
alc_tpm2_event_size())
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (3a0ae3d2b585 Merge branches 'iommu/fixes' and 'x86/vt-d=
' into next)
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
Merging spi/for-next (2880fca899ad Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (206276879add Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (1bd76ff448a9 EDAC, altera: Fix S10 Double Bit Er=
ror Notification)
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
Merging leds/for-next (23c7152b7f92 leds: lt3593: Remove unneeded assignmen=
t in lt3593_led_probe)
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
Merging staging/staging-next (6a023205d2d7 staging: rts5208: correction in =
spelling)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (fcf9d0b7d2f5 drm/msm/a6xx: Add support for an interco=
nnect path)
Merging slave-dma/next (5ba846b1ee07 dmaengine: idma64: Use actual device f=
or DMA transfers)
Merging cgroup/for-next (0fcc4c8c044e device_cgroup: fix RCU imbalance in e=
rror case)
Merging scsi/for-next (69a3c01d588e Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (f55d0b40eccf scsi: target: iscsi: Free conn_ops =
when zalloc_cpumask_var failed)
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
Merging gpio-brgl/gpio/for-next (6e4484ee3548 gpio: mockup: move the driver=
 out of the IOMEM drivers section)
Merging pinctrl/for-next (9bc8fee96e9a pinctrl: imx: fix scu link errors)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (9ff06679e109 pwm: sysfs: fix typo "its" -> "it's")
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (9e98c678c2d6 Linux 5.1-rc1)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (b420648f103d Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (bbadc95b129b coresight: catu: Make catu_helper_ops =
and catu_ops static)
Merging rtc/rtc-next (c330d1290d91 rtc: mt6397: Don't call irq_dispose_mapp=
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
Merging pidfd/for-next (e68cf4aead0b tests: add pidctl() tests)
Merging devfreq/for-next (ca740a8f3e7f PM / devfreq: Fix static checker war=
ning in try_then_request_governor)
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
Merging akpm/master (5b799e83e328 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/0iv0tmLM7RBHblCQlckD/dN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyYRl0ACgkQAVBC80lX
0GyHngf/ePM8XwAeB7oRKV1//dp18rplWCOl3EvkB0L4NgJFa+gVUszs59wOL/iS
8VUbMJbX9CeEyrz2reXt0qzP9CfnnH7jWSubOekaOw/fHI6/93hGl41UJTd7y5+u
yVSZuJHrWEtwPmxU9taWHA8ecKbzal6tjrjAivlLvCJa5vX8NsVbTrrKA+GNmMvR
GV5psKz0VvCzlpIabIrDsKna/rhYXDo+wxYKrez8KuxP/VEOPpBPfk+RerMhNK+Z
zFFqrh/0ecOvQs1NpQEnl/xtfpw+LbnctVcOjGu5dpxrTBvrILH/5ihVrDlTGj+O
PhIWn9vrqV1QIkSum4hnFpjgFV1BeQ==
=blUu
-----END PGP SIGNATURE-----

--Sig_/0iv0tmLM7RBHblCQlckD/dN--
