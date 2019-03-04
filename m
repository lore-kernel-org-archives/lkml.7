Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6427EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33E520863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nnT0D96P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfCDHOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:14:25 -0500
Received: from ozlabs.org ([203.11.71.1]:60097 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfCDHOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:14:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CWVM1h2Nz9s5R;
        Mon,  4 Mar 2019 18:14:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551683659;
        bh=lgiRyYPvV+gDc4xlwFHFwxLFQwj/K97nWj+cK3yLdnM=;
        h=Date:From:To:Cc:Subject:From;
        b=nnT0D96PQ8mDSuFOmYFCdNE4cDoCwgIvw1xNnh2kmYrOCeP7gE4dAeh1ckq37ZdLC
         x0nVvfz7BHLDixPpk39W/BUKWzAk3BaNtSi4NXj1erYOI0tTV4Zt6uunCvGNnVbLgf
         Xe1GUZBQXL2ZZmTMqiBGIcietdlNwXX5UlZHDUMz7SFxO1xpvXLFYIkVcbqH7zQbrB
         Zvcehw2d26YBpu0ifHdB7rceJTXLKFkakF9pm5EUje7cYRosFdlhdA8Wf9d7DkEN8d
         tVfcG3OY35/jLRSSgUk2RgXXzz88as1jJdD4l9nHemI4mw+HiyM2JPEZJ+nPnucf4K
         GeCeFv6B4CtdQ==
Date:   Mon, 4 Mar 2019 18:14:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 4
Message-ID: <20190304181418.415316cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v+D6oDyYMw.m7fkziAoou+M"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v+D6oDyYMw.m7fkziAoou+M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any code destined for v5.2 to your linux-next included
branches until after v5.1-rc1 has been released.

News: I will not be doing linux-next releases from next Thursday (Mar
7) to the following Friday (Mar 15).  Sorry this happened to fall
across most of the merge window.

Changes since 20190301:

The kvm tree gained a conflict against Linus' tree.

The drivers-x86 tree gained a conflict against the watchdog tree.

Non-merge commits (relative to Linus' tree): 10954
 10914 files changed, 489355 insertions(+), 252184 deletions(-)

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

I am currently merging 297 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (c027c7cf1577 Merge tag 'armsoc-fixes' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging fixes/master (ed3ce4cfc919 adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (6f6c95f09001 ASN.1: mark expected switc=
h fall-through)
Merging kbuild-current/fixes (207a369e3c08 sh: fix build error for invisibl=
e CONFIG_BUILTIN_DTB_SOURCE)
Merging arc-current/for-curr (85d6adcbbe6d ARC: boot log: cut down on verbo=
sity)
Merging arm-current/fixes (d410a8a49e3e ARM: 8849/1: NOMMU: Fix encodings f=
or PMSAv8's PRBAR4/PRLAR4)
Merging arm64-fixes/for-next/fixes (74698f6971f2 arm64: Relax GIC version c=
heck during early boot)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (8f5b27347e88 powerpc/powernv/sriov: Register I=
OMMU groups for VFs)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (46b1c18f9deb net: sched: put back q.qlen into a single =
location)
Merging bpf/master (07f12b26e21a net: sit: fix memory leak in sit_init_net(=
))
Merging ipsec/master (d235c48b40d3 net: dsa: mv88e6xxx: power serdes on/off=
 for 10G interfaces on 6390X)
Merging netfilter/master (ecef67cb10db tun: remove unnecessary memory barri=
er)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (d5fa9c55e5f3 Merge tag 'mlx5-updates-2019-=
03-01' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging mac80211/master (d235c48b40d3 net: dsa: mv88e6xxx: power serdes on/=
off for 10G interfaces on 6390X)
Merging rdma-fixes/for-rc (f09ef134a7ca iw_cxgb4: cq/qp mask depends on bar=
2 pages in a host page)
Merging sound-current/for-linus (a634090a0f24 ALSA: usb-audio: Add quirk fo=
r MOTU MicroBook II)
Merging sound-asoc-fixes/for-linus (b5e806ae4ad8 Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (8cd0aeaa0868 Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (22e78ec655e8 Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (f57a98e1b713 PCI: Work around Synopsys dupli=
cate Device ID (HAPS USB3, NXP i.MX))
Merging driver-core.current/driver-core-linus (d13937116f1e Linux 5.0-rc6)
Merging tty.current/tty-linus (d13937116f1e Linux 5.0-rc6)
Merging usb.current/usb-linus (d13937116f1e Linux 5.0-rc6)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (8d7fa3d4ea3f USB: serial: ftdi_sio: add=
 ID for Hjelmslund Electronics USB485)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (827cb0323928 phy: ath79-usb: Fix the main reset name to =
match the DT binding)
Merging staging.current/staging-linus (d13937116f1e Linux 5.0-rc6)
Merging char-misc.current/char-misc-linus (d13937116f1e Linux 5.0-rc6)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (5908e6b738e3 Linux 5.0-rc8)
Merging input-current/for-linus (7ad222b3aed3 Input: elan_i2c - add ACPI ID=
 for touchpad in Lenovo V330-15ISK)
Merging crypto-current/master (f86d17e9efe0 crypto: arm64/chacha - fix hcha=
cha_block_neon() for big endian)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (7d4e591bc051 selftests: timers: use LDLIBS i=
nstead of LDFLAGS)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d13937116f1e Linux 5.0-rc6)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (3e35730dd754 mtd: powernv_flash: Fix device regis=
tration error)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (7bdf2c8fee51 media: v4l: ioctl: Sanitize num_p=
lanes before using it)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (e0bf304e4a00 MIPS: fix memory setup for plat=
forms with PHYS_OFFSET !=3D 0)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (dc30e7039137 ARM: OMAP2+: Variable "reg" in funct=
ion omap4_dsi_mux_pads() could be uninitialized)
Merging kvm-fixes/master (de3ccd26fafc KVM: MMU: record maximum physical ad=
dress width in kvm_mmu_extended_role)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (ff066653aeed hwmon: (pmbus/tps53679) Fix driver =
info initialization in probe routine)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (8834f5600cf3 Linux 5.0-rc5)
Merging vfs-fixes/fixes (d3d6a18d7d35 aio: Fix locking in aio_poll())
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (6a730fcb9cb4 Documentation/ABI: Correct ml=
xreg-io KernelVersion for 5.0)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (388b4e6a00bb scsi: core: Avoid that system resume=
 triggers a kernel warning)
Merging drm-fixes/drm-fixes (17fb465f1602 drm/bochs: Fix the ID mismatch er=
ror)
Merging drm-intel-fixes/for-linux-next-fixes (5908e6b738e3 Linux 5.0-rc8)
Merging mmc-fixes/fixes (e30be063d6db mmc: sdhci-esdhc-imx: correct the fix=
 of ERR004536)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (bfeffd155283 Linux 5.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (04b9c4885158 drm/bochs: Fix th=
e ID mismatch error)
Merging kbuild/for-next (85d89b922ba2 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (982ef2f7ef0a leaking_addresses: Completely remove=
 --version flag)
Merging dma-mapping/for-next (9eb9e96e97b3 Documentation/DMA-API-HOWTO: upd=
ate dma_mask sections)
Merging asm-generic/master (d724444ab97d asm-generic/page.h: fix typo in #e=
rror text requiring a real asm/page.h)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (585f8003e2e7 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (b855b58ac1b7 arm64: mmu: drop paging_init comm=
ents)
Merging arm-perf/for-next/perf (cf2d65ec1d21 perf: xgene: Remove set but no=
t used variable 'config')
Merging arm-soc/for-next (48d1dbf3918f arm-soc: document merges)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/nvidia/tegra210-p=
2597.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/nvidia/tegra194-p=
2972-0000.dts
CONFLICT (content): Merge conflict in arch/arm64/Kconfig.platforms
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (a973ebe8b4d7 Merge branch 'v5.1/drivers' into tmp=
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
Merging renesas/next (f4435b0d605e Merge branch 'fixes-for-v5.1' into next)
Merging rockchip/for-next (8444545ff72a Merge branch 'v5.1-clk/next' into f=
or-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (8ecb112edde9 Merge branch 'fixes-late-dt' in=
to for-next)
Merging sunxi/sunxi/for-next (1fc3dc289134 Merge remote-tracking branches '=
korg/sunxi/sunxi/dt-for-5.1', 'korg/sunxi/sunxi/dt64-for-5.1' and 'korg/sun=
xi/sunxi/h3-h5-for-5.1' into sunxi/for-next)
Merging tegra/for-next (d92dde4f12f1 Merge branch for-5.1/fixes into for-ne=
xt)
Merging clk/clk-next (43ae730290ff Merge branch 'clk-parent-rewrite' (early=
 part) into clk-next)
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
Merging m68knommu/for-next (d7e9d01ac292 m68k: add ColdFire mcf5441x eDMA p=
latform support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (aeb669d41ffa MIPS: lantiq: Remove separate GPHY Fir=
mware loader)
CONFLICT (content): Merge conflict in arch/mips/include/asm/pgtable.h
CONFLICT (content): Merge conflict in arch/mips/include/asm/barrier.h
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (6a5280012da5 parisc: use memblock_alloc() inste=
ad of custom get_memblock())
Merging powerpc/next (9580b71b5a78 powerpc/32: Clear on-stack exception mar=
ker upon exception return)
CONFLICT (content): Merge conflict in kernel/dma/Kconfig
CONFLICT (modify/delete): arch/powerpc/kernel/dma.c deleted in powerpc/next=
 and modified in HEAD. Version HEAD of arch/powerpc/kernel/dma.c left in tr=
ee.
CONFLICT (content): Merge conflict in arch/powerpc/kernel/dma-swiotlb.c
$ git rm -f arch/powerpc/kernel/dma.c
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (79a47bad61bb riscv: remove the HAVE_KPROBES option)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (9fe567d09f0f s390/dasd: fix read device characterist=
ic with CONFIG_VMAP_STACK=3Dy)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (940b241d9050 um: Remove obsolete reenable_XX calls)
Merging xtensa/xtensa-for-next (036ef74b3ecb Merge branch 'xtensa-5.1' into=
 xtensa-for-next)
Merging fscrypt/master (f5e55e777cc9 fscrypt: return -EXDEV for incompatibl=
e rename or link into encrypted dir)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (836b12f8c30d Merge branch 'for-next-next-v5.0=
-20190228' into for-next-20190228)
Merging ceph/master (6cbbda12cb4f rbd: remove experimental designation from=
 kernel layering)
Merging cifs/for-next (bb4369db96f2 smb3: for kerberos mounts display the c=
redential uid used)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (2337494f7c0f Merge udf cleanup.)
Merging ext4/dev (0df6f46995a9 jbd2: jbd2_get_transaction does not need to =
return a value)
Merging f2fs/dev (100e23619856 f2fs: print more parameters in trace_f2fs_ma=
p_blocks)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (a73881c96d73 SUNRPC: Fix an Oops in udp_poll())
Merging nfs-anna/linux-next (a3b22b9f11d9 Linux 5.0-rc7)
Merging nfsd/nfsd-next (c54f24e338ed nfsd: fix performance-limiting session=
 calculation)
Merging orangefs/for-next (6e356d45950e orangefs: remove two un-needed BUG_=
ONs...)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (2fe8b2d5578d ubifs: Reject unsupported ioctl flag=
s explicitly)
Merging v9fs/9p-next (5e3cc1ee1405 9p: use inode->i_lock to protect i_size_=
write() under 32-bit)
Merging xfs/for-next (1b9598c8fb99 xfs: fix reporting supported extra file =
attributes for statx())
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (c0abe5af7341 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in fs/Makefile
Merging printk/for-next (b60706644282 lib/vsprintf: Remove %pCr remnant in =
comment)
Merging pci/next (68e9f622555b Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (c81eee9fb58c Merge branch 'for-5.1/hid-uclogic' into =
for-next)
Merging i2c/i2c/for-next (a8219c9b6988 Merge branch 'i2c/for-5.1' into i2c/=
for-next)
Merging i3c/i3c/next (988bb4a1937b i3c: master: dw-i3c-master: mark expecte=
d switch fall-through)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (985e225142cf dt-bindings: hwmon: Add miss=
ing documentation for lm75)
Merging jc_docs/docs-next (19c3fe285cba docs: Explicitly state that the 'Fi=
xes:' tag shouldn't split lines)
Merging v4l-dvb/master (26b190053ec0 media: a few more typos at staging, pc=
i, platform, radio and usb)
CONFLICT (modify/delete): drivers/media/platform/soc_camera/sh_mobile_ceu_c=
amera.c deleted in v4l-dvb/master and modified in HEAD. Version HEAD of dri=
vers/media/platform/soc_camera/sh_mobile_ceu_camera.c left in tree.
$ git rm -f drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
Merging v4l-dvb-next/master (9fabe1d108ca media: ipu3-mmu: fix some kernel-=
doc macros)
Merging fbdev/fbdev-for-next (4c83c2f75a8f fbdev: omap2: fix warnings in ds=
s core)
Merging pm/linux-next (65787f5965bc Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (0334906c0696 cpufreq: kryo: Rel=
ease OPP tables on module removal)
Merging cpupower/cpupower (ae2917093fb6 tools/power/cpupower: Display boost=
 frequency separately)
Merging opp/opp/linux-next (a9a744dd5b82 cpufreq: OMAP: Register an Energy =
Model)
Merging thermal/next (b537f89a9e4b Merge branches 'fixes' and 'thermal-inte=
l' into next)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (8526e331c56f dlm: Fix test for -ERESTARTSYS)
Merging swiotlb/linux-next (22cb45d7692a swiotlb: drop pointless static qua=
lifier in swiotlb_create_debugfs())
CONFLICT (content): Merge conflict in kernel/dma/swiotlb.c
Merging rdma/for-next (bb618451544c RDMA/uverbs: Don't do double free of al=
located PD)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx4/Kconfig
Merging net-next/master (41bc0ddb80e0 Merge branch 'net-dsa-microchip-add-K=
SZ9893-switch-support')
Merging bpf-next/master (ea5bade929bf Merge branch 'split-test_progs')
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (37b6bb77c6fd net/mlx5: Factor out HCA capabili=
ties functions)
Merging netfilter-next/master (db8ab38880e0 netfilter: nf_tables: merge ipv=
4 and ipv6 nat chain types)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (501faf710230 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (d5fa9c55e5f3 Merge tag 'mlx5-updates-2019-03-01' =
of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
Merging mac80211-next/master (be9cefe796f3 selftests: rtnetlink: use intern=
al netns switch for ip commands)
Merging gfs2/for-next (2abbf9a4d262 gfs: no need to check return value of d=
ebugfs_create functions)
Merging mtd/mtd/next (9220d7befc9c Merge tag 'nand/for-5.1' of git://git.in=
fradead.org/linux-mtd into mtd/next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging nand/nand/next (53bcbb839438 mtd: rawnand: denali_dt: remove single=
 anonymous clock support)
Merging spi-nor/spi-nor/next (225c0eda36bd mtd: spi-nor: Fix wrong abbrevia=
tion HWCPAS)
Merging crypto/master (0918f18c7179 crypto: s5p - add AES support for Exyno=
s5433)
Merging drm/drm-next (7fbd5d784f75 Merge tag 'imx-drm-next-2019-02-22' of g=
it://git.pengutronix.de/pza/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-intel/for-linux-next (96e0adb4af42 drm/i915/opregion: rvda is r=
elative from opregion base in opregion 2.1+)
Merging drm-tegra/drm/tegra/for-next (ca52507efc03 drm/tegra: vic: Fix impl=
icit function declaration warning)
Merging drm-misc/for-linux-next (37406a60fac7 drm: Merge __drm_atomic_helpe=
r_disable_all() into drm_atomic_helper_disable_all())
Merging drm-msm/msm-next (f1a427d9d238 drm/msm: Remove pm_runtime calls fro=
m msm_iommu.c)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (dcc9d76b6d83 drm/komeda: Off by one i=
n komeda_fb_get_pixel_addr())
Merging imx-drm/imx-drm/next (a0ea4ffff266 drm/imx: only send commit done e=
vent when all state has been applied)
Merging etnaviv/etnaviv/next (9e05352340d3 drm/etnaviv: potential NULL dere=
ference)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (66fb181d6f82 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (a634090a0f24 ALSA: usb-audio: Add quirk for MOTU Mi=
croBook II)
Merging sound-asoc/for-next (8f3d4afab208 Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (44466306ebec Input: ti_am335x_tsc - remove set but not =
used variable 'tscadc_dev')
Merging block/for-next (c6b7e26ecf51 Merge branch 'io_uring' into for-next)
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
Merging device-mapper/for-next (cf603f07ca7d dm snapshot: don't define dire=
ct_access if we don't support it)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (d4721339dcca mmc:fix a bug when max_discard is 0)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (d2d833e0bf2b mfd: mxs-lradc: Mark expected switch=
 fall-through)
CONFLICT (content): Merge conflict in drivers/mfd/Kconfig
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (655ab0bc462d power: reset: at91-reset: add suppor=
t for sam9x60 SoC)
Merging regulator/for-next (218965f160f6 Merge branch 'regulator-5.1' into =
regulator-next)
CONFLICT (modify/delete): arch/arm/mach-pxa/raumfeld.c deleted in HEAD and =
modified in regulator/for-next. Version regulator/for-next of arch/arm/mach=
-pxa/raumfeld.c left in tree.
$ git rm -f arch/arm/mach-pxa/raumfeld.c
Merging security/next-testing (0d556c66dadd Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (df4d55f2e1b8 apparmor: fix double free when=
 unpack of secmark rules fails)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (45189a1998e0 selinux: fix avc audit messages)
Merging tpmdd/next (5812f97c0a22 tpm: Fix the type of the return value in c=
alc_tpm2_event_size())
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (d05e4c8600c3 Merge branches 'iommu/fixes', 'arm/msm', '=
arm/tegra', 'arm/mediatek', 'x86/vt-d', 'x86/amd', 'hyper-v' and 'core' int=
o next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (131d34cb0795 audit: mark expected switch fall-through)
Merging devicetree/for-next (935665c1a117 of: unittest: unflatten device tr=
ee on UML when testing)
CONFLICT (modify/delete): Documentation/devicetree/bindings/interrupt-contr=
oller/arm,gic-v3.txt deleted in devicetree/for-next and modified in HEAD. V=
ersion HEAD of Documentation/devicetree/bindings/interrupt-controller/arm,g=
ic-v3.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/interrupt-controller/arm,gic-=
v3.txt
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (e6a9a55b2cb4 Merge branch 'spi-5.1' into spi-next)
CONFLICT (modify/delete): arch/mips/ath79/dev-spi.h deleted in HEAD and mod=
ified in spi/for-next. Version spi/for-next of arch/mips/ath79/dev-spi.h le=
ft in tree.
$ git rm -f arch/mips/ath79/dev-spi.h
Merging tip/auto-latest (371f210ec2a3 Merge branch 'x86/urgent')
CONFLICT (content): Merge conflict in kernel/time/timer.c
CONFLICT (content): Merge conflict in kernel/time/hrtimer.c
CONFLICT (content): Merge conflict in include/uapi/linux/time.h
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
CONFLICT (content): Merge conflict in Kbuild
Applying: time: fix up for "y2038: remove struct definition redirects"
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (580b5cf50ca8 EDAC/altera: Add separate SDRAM EDA=
C config)
Merging irqchip/irq/irqchip-next (28528fca4908 irqchip/imx-irqsteer: Add mu=
lti output interrupts support)
Merging ftrace/for-next (1c347a94ca79 tracing: Comment why cond_snapshot is=
 checked outside of max_lock protection)
Merging rcu/rcu/next (e880edadc149 Merge LKMM and RCU)
Merging kvm/linux-next (71783e09b487 Merge tag 'kvmarm-for-v5.1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-next)
CONFLICT (content): Merge conflict in virt/kvm/kvm_main.c
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/vmx.h
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/vmx.c
CONFLICT (content): Merge conflict in arch/arm/include/asm/kvm_host.h
Merging kvm-arm/next (c88b093693cc arm64: KVM: Fix architecturally invalid =
reset value for FPEXC32_EL2)
Merging kvm-ppc/kvm-ppc-next (2b57ecd0208f KVM: PPC: Book3S: Add count cach=
e flush parameters to kvmppc_get_cpu_char())
Merging kvms390/next (11ba5961a215 KVM: s390: add debug logging for cpu mod=
el subfunctions)
Merging xen-tip/linux-next (1d988ed46543 x86/xen: dont add memory above max=
 allowed allocation)
Merging percpu/for-next (1b046b445c0f percpu: km: no need to consider pcpu_=
group_offsets[0])
Merging workqueues/for-next (8bdc6201785d workqueue: fix typo in comment)
Merging drivers-x86/for-next (238f9c11351f platform/x86: intel_pmc_core: Qu=
irk to ignore XTAL shutdown)
CONFLICT (content): Merge conflict in include/linux/platform_data/mlxreg.h
Merging chrome-platform/for-next (0d2f2a3da1f2 platform/chrome: wilco_ec: A=
dd RTC driver)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (5ddb0869bfc1 leds: lp55xx: fix null deref on firmwar=
e load failure)
Merging ipmi/for-next (038903593317 ipmi_si: Potential array underflow in h=
otmod_handler())
Merging driver-core/driver-core-next (36cf3b1363f4 driver core: platform: r=
emove misleading err_alloc label)
Merging usb/usb-next (1c7cf3d5e1c1 wusb: Remove unnecessary static function=
 ckhdid_printf)
CONFLICT (content): Merge conflict in drivers/phy/marvell/Makefile
CONFLICT (content): Merge conflict in drivers/phy/marvell/Kconfig
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (6431866b6707 USB: serial: option: add Telit ME=
910 ECM composition)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (203d9b11928c phy: qcom-qmp: Add QMP UFS PHY support =
for msm8998)
Merging tty/tty-next (f694936c3b5a tty: xilinx_uartps: Correct return value=
 in probe)
Merging char-misc/char-misc-next (142a0f83b216 habanalabs: adjust Kconfig t=
o fix build errors)
Merging extcon/extcon-next (3dfed89512d3 extcon: ptn5150: Fix return value =
check in ptn5150_i2c_probe())
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (5908e6b738e3 Linux 5.0-rc8)
Merging staging/staging-next (1f08c4a54b7c staging: mt7621-dma: remove lice=
nse boilerplate text)
CONFLICT (content): Merge conflict in drivers/staging/fsl-dpaa2/ethsw/ethsw=
.c
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (fcf9d0b7d2f5 drm/msm/a6xx: Add support for an interco=
nnect path)
Merging slave-dma/next (58810c58b9e7 Merge branch 'for-linus' into next)
CONFLICT (content): Merge conflict in drivers/dma/imx-sdma.c
CONFLICT (content): Merge conflict in drivers/dma/dmatest.c
CONFLICT (content): Merge conflict in Documentation/driver-api/dmaengine/cl=
ient.rst
Merging cgroup/for-next (6a613d24effc cpuset: remove unused task_has_mempol=
icy())
Merging scsi/for-next (8c1ceb38e449 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in include/linux/blkdev.h
CONFLICT (modify/delete): fs/exofs/ore_raid.c deleted in scsi/for-next and =
modified in HEAD. Version HEAD of fs/exofs/ore_raid.c left in tree.
CONFLICT (modify/delete): fs/exofs/ore.c deleted in scsi/for-next and modif=
ied in HEAD. Version HEAD of fs/exofs/ore.c left in tree.
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
$ git rm -f fs/exofs/ore.c fs/exofs/ore_raid.c
Merging scsi-mkp/for-next (26af1a368e40 scsi: cxgb4i: validate tcp sequence=
 number only if chip version <=3D T5)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (e7afa2912187 arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in kernel/dma/swiotlb.c
CONFLICT (content): Merge conflict in drivers/iommu/Makefile
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging rpmsg/for-next (6a4ac1cc9997 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Applying: remoteproc: fix for "dma-mapping: remove the DMA_MEMORY_EXCLUSIVE=
 flag"
Merging gpio/for-next (c378b3aa0159 gpio: pca953x: Fix dereference of irq d=
ata in shutdown)
Merging gpio-brgl/gpio/for-next (2a9e27408e12 gpio: mockup: rework debugfs =
interface)
Merging pinctrl/for-next (dcab77888da9 dt-bindings: pinctrl: Document the i=
.MX50 IOMUXC binding)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (7ca17b207127 pwm: imx: Signedness bug in imx_pwm_get_=
state())
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
Merging coresight/next (37af13cc74d1 perf record: implement --affinity=3Dno=
de|cpu option)
Merging rtc/rtc-next (51f896ffd1a5 rtc: rx8581: Add support for Epson rx857=
1 RTC)
Merging nvdimm/libnvdimm-for-next (c610002ab34f Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in mm/memory_hotplug.c
Merging at24/at24/for-next (950bcbbe3154 eeprom: at24: implement support fo=
r 'num-addresses' property)
Merging ntb/ntb-next (8af642c76ef5 NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (ddf89e25fad8 lib: Introduce test_stackinit modu=
le)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging gnss/gnss-next (d4584bbfcf2a gnss: add driver for mediatek receiver=
s)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (81648d8bc222 slimbus: core: add missing spin_lock=
_init on txn_lock)
Merging nvmem/for-next (c86d78c459db nvmem: allow to select i.MX nvmem driv=
er for i.MX 7D)
Merging xarray/xarray (4a5c8d898948 XArray: Fix xa_reserve for 2-byte align=
ed entries)
Applying: RDMA/devices: fix up for xa_alloc API change
Applying: RDMA/restrack: fix for __xa_alloc() API change
Merging hyperv/hyperv-next (396ae57ef1ef Drivers: hv: vmbus: Expose counter=
s for interrupts and full conditions)
Merging auxdisplay/auxdisplay (a3b22b9f11d9 Linux 5.0-rc7)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (f67dcc84eb36 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging devfreq/for-next (08cacec421f6 PM / devfreq: tegra: remove unneeded=
 variable)
Merging akpm-current/current (d24bf9977ff5 zram: default to lzo-rle instead=
 of lzo)
CONFLICT (content): Merge conflict in tools/testing/selftests/Makefile
CONFLICT (content): Merge conflict in scripts/gcc-plugins/Kconfig
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/kernfs.h
CONFLICT (content): Merge conflict in include/linux/fs.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: scripts/atomic/gen-atomics.sh: don't assume that scripts are exec=
utable
Applying: powerpc: prefer memblock APIs returning virtual address
Applying: microblaze: prefer memblock API returning virtual address
Applying: sh: prefer memblock APIs returning virtual address
Applying: openrisc: simplify pte_alloc_one_kernel()
Applying: arch: simplify several early memory allocations
Applying: arm, s390, unicore32: remove oneliner wrappers for memblock_alloc=
()
Applying: mm: create the new vm_fault_t type
Applying: x86/mm/fault.c: Convert to use vm_fault_t
Applying: mm/hmm: convert to use vm_fault_t
Applying: drm/nouveau/dmem: update for struct hmm_devmem_ops member change
Applying: MAINTAINERS: fix GTA02 entry and mark as orphan
Applying: fs: fs_parser: fix printk format warning
Applying: mm: refactor readahead defines in mm.h
Applying: mm-refactor-readahead-defines-in-mmh-fix
Applying: proc: calculate end pointer for /proc/*/* lookup at compile time
Applying: proc: merge fix for proc_pident_lookup() API change
Applying: unicore32: stop printing the virtual memory layout
Applying: arch/nios2/mm/fault.c: remove duplicate include
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: openrisc: prefer memblock APIs returning virtual address
Applying: powerpc: use memblock functions returning virtual address
Applying: powerpc: remove duplicated alloc_stack() function
Applying: memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phy=
s_alloc
Applying: memblock: drop memblock_alloc_base_nid()
Applying: memblock: emphasize that memblock_alloc_range() returns a physica=
l address
Applying: memblock: memblock_phys_alloc_try_nid(): don't panic
Applying: memblock: memblock_phys_alloc(): don't panic
Applying: memblock: drop __memblock_alloc_base()
Applying: memblock: drop memblock_alloc_base()
Applying: memblock: refactor internal allocation functions
Applying: memblock: fix parameter order in memblock_phys_alloc_try_nid()
Applying: memblock: make memblock_find_in_range_node() and choose_memblock_=
flags() static
Applying: arch: use memblock_alloc() instead of memblock_alloc_from(size, a=
lign, 0)
Applying: arch: don't memset(0) memory returned by memblock_alloc()
Applying: ia64: add checks for the return value of memblock_alloc*()
Applying: sparc: add checks for the return value of memblock_alloc*()
Applying: mm/percpu: add checks for the return value of memblock_alloc*()
Applying: init/main: add checks for the return value of memblock_alloc*()
Applying: swiotlb: add checks for the return value of memblock_alloc*()
Applying: treewide: add checks for the return value of memblock_alloc*()
Applying: mm: sparse: Use '%pa' with 'phys_addr_t' type
Applying: memblock: fix format strings for panics after memblock_alloc
Applying: mm/sparse: don't panic if the allocation in sparse_buffer_init fa=
ils
Applying: treewide-add-checks-for-the-return-value-of-memblock_alloc-fix-3-=
fix
Applying: memblock: memblock_alloc_try_nid: don't panic
Applying: memblock: drop memblock_alloc_*_nopanic() variants
Applying: memblock: remove memblock_{set,clear}_region_flags
Applying: memblock: split checks whether a region should be skipped to a he=
lper function
Applying: mm: memblock: update comments and kernel-doc
Applying: memblock-update-comments-and-kernel-doc-fix
Applying: of: fix kmemleak crash caused by imbalance in early memory reserv=
ation
Applying: of: fix parameters order for call to memblock_find_in_range()
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm, memcg: consider subtrees in memory.events
Applying: openvswitch: convert to kvmalloc
Applying: md: convert to kvmalloc
Applying: selinux: convert to kvmalloc
Applying: Generic radix trees
Applying: proc: commit to genradix
Applying: sctp: convert to genradix
Applying: Drop flex_arrays
Applying: include/linux/relay.h: fix percpu annotation in struct rchan
Applying: kernel/fork.c: remove duplicated include
Applying: samples/mic/mpssd/mpssd.h: remove duplicate header
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (67f7dd3a2da4 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/v+D6oDyYMw.m7fkziAoou+M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx80EoACgkQAVBC80lX
0Gxy/wf/dfOyPIv350OUHqAmXmSA1Ggl6jS88OwQ1uu5TzRH8tS6V4d5RB96ASpY
nT4/9wyzn/dYg1kFriqOxGG0MnMTcqbz2tfQpM3b06XLKpjJLL8H5DfD9T2zkXor
xfxJMvQL6C1kW1rz3g2FdhvxFIqOl92LqSVUfToi5a83T2LMAR8wW6itBpUK8irI
WKROq8b7tG5iAZHWIvvifpM0a/vIJkerE8gyQ9lWV+8vC02J/ovSpOZU69H40Fpx
ir1l6uFAD2y9fN5PiifiGbV43eMj3RgkHiIO1pjWR4jR5IJXSSD9PAACJr5xMuGH
wfsAnBdrfPgX/u0SBxlARm7/QcIBxQ==
=cdj9
-----END PGP SIGNATURE-----

--Sig_/v+D6oDyYMw.m7fkziAoou+M--
