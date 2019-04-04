Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A23C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8C7206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Al1lFNoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDDFZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:25:17 -0400
Received: from ozlabs.org ([203.11.71.1]:56751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDFZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:25:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ZWc22nnkz9sR8;
        Thu,  4 Apr 2019 16:25:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554355506;
        bh=RAk8tDzK3IbSFDofWZSFlw0TeFYHaWXVcoG3DirIwPY=;
        h=Date:From:To:Cc:Subject:From;
        b=Al1lFNoIr+3HBMjp1mYv/vqs5IUzvXNWpkpqy5BVkxqCmLK27WG9F/MJ/AemKYTJA
         IzvL9SYGrqE5u3kRhXWIoEF6hDxrdC+g+QN/axHFPi6vyE8fMmUbMbxWC7FL+kPEqu
         OMk400CgbOcG26DPsw49Gvz1wy4Upn/tTuQEJMmulEC1Krayk8qGspr4DRD3drRUs6
         F0J35Ft2wAeqwosLHm5OR47xU5fVlyiJs8onmZHIDEdEgoNtwUZ5CDZfKmZwgltHgk
         Noz4uZYO+W3WG6n2TH81UpnGzbDBsXk1Ms23GqHsxAcxayr/S/xDbr6XUEFymJrNOF
         eceqnM12J+nUg==
Date:   Thu, 4 Apr 2019 16:25:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 4
Message-ID: <20190404162505.04d952d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ERqvmpRNbOVA0_9h0uPpQpW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ERqvmpRNbOVA0_9h0uPpQpW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190403:

The sound-asoc tree lost its build failure.

The mfd tree lost its build failure.

The selinux tree lost its build failure.

The ipmi tree lost its build failure.

The staging tree gained conflicts against the spi and v4l-dvb trees.

Non-merge commits (relative to Linus' tree): 4662
 4557 files changed, 143113 insertions(+), 68010 deletions(-)

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

I am currently merging 298 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (8ed86627f715 Merge branch 'for-linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/hid/hid)
Merging fixes/master (b352face4ca9 adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (2d212a1bac7e NFC: st21nfca: Fix fall-th=
rough warnings)
Merging kbuild-current/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging arc-current/for-curr (831e90bd606e ARC: PAE40: don't panic and inst=
ead turn off hw ioc)
Merging arm-current/fixes (d410a8a49e3e ARM: 8849/1: NOMMU: Fix encodings f=
or PMSAv8's PRBAR4/PRLAR4)
Merging arm64-fixes/for-next/fixes (221f6eefc354 arm64: fix wrong check of =
on_sdei_stack in nmi context)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (6f845ebec270 powerpc/pseries/mce: Fix misleadi=
ng print for TLB mutlihit)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (b2e54b09a3d2 ip6_tunnel: Match to ARPHRD_TUNNEL6 for de=
v type)
Merging bpf/master (a090dbf25c56 Merge branch 'bpf-flow-dissector-fixes')
Merging ipsec/master (8742dc86d0c7 xfrm4: Fix uninitialized memory read in =
_decode_session4)
Merging netfilter/master (5f543a54eec0 net: hns3: fix for not calculating t=
x bd num correctly)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (4837696f6b54 Merge tag 'iwlwifi-for-kalle-=
2019-03-22' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwif=
i-fixes)
Merging mac80211/master (53bf5811ca37 cfg80211: add ratelimited variants of=
 err and warn)
Merging rdma-fixes/for-rc (1abe186ed8a6 IB/mlx5: Reset access mask when loo=
ping inside page fault handler)
Merging sound-current/for-linus (80690a276f44 ALSA: hda/realtek - Add quirk=
 for Tuxedo XC 1509)
Merging sound-asoc-fixes/for-linus (33c10c7d0413 Merge branch 'asoc-5.1' in=
to asoc-linus)
Merging regmap-fixes/for-linus (34fd5ecd01f0 Merge branch 'regmap-5.1' into=
 regmap-linus)
Merging regulator-fixes/for-linus (29a825a05951 Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (c97f6ad307e9 Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (0fa635aec9ab PCI/LINK: Deduplicate bandwidth=
 reports for multi-function devices)
Merging driver-core.current/driver-core-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging tty.current/tty-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb.current/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (d5d60c3f25ab phy: fix platform_no_drv_owner.cocci warnin=
gs)
Merging staging.current/staging-linus (131ac62253db staging: most: core: us=
e device description as name)
Merging char-misc.current/char-misc-linus (01b76c32e3f3 misc: fastrpc: add =
checked value for dma_set_mask)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging input-current/for-linus (c01908a14bf7 HID: input: add mapping for "=
Toggle Display" key)
Merging crypto-current/master (b4e9e931e9bb crypto: caam - fix copy of next=
 buffer for xcbc and cmac)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (1bb208e36bc9 selftests: cgroup: fix cleanup =
path in test_memcg_subtree_control())
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/mtd/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging reset-fixes/reset/fixes (13e8a05b9224 reset: meson-audio-arb: Fix m=
issing .owner setting of reset_controller_dev)
Merging mips-fixes/mips-fixes (e4952b0c2c03 MIPS: SGI-IP27: Fix use of unch=
ecked pointer in shutdown_bridge_irq)
Merging at91-fixes/at91-fixes (e7dfb6d04e47 ARM: dts: at91: Fix typo in ISC=
_D0 on PC9)
Merging omap-fixes/fixes (81717283cf2c Merge commit '7d56bedb2730dc2ea8abf0=
fd7240ee99ecfee3c9' into omap-for-v5.1/fixes)
Merging kvm-fixes/master (690edec54cba Merge tag 'kvmarm-fixes-for-5.1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-master)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (34fdbe5544c7 hwmon: (pwm-fan) Disable PWM if fet=
ching cooling data fails)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (3db79a379489 Merge branch 'misc-5.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (18bfb9c6a8a5 aio: Fix an error code in __io_submit=
_one())
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (d6e2635b9cf7 scsi: ibmvfc: Clean up transport eve=
nts)
Merging drm-fixes/drm-fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (a145b5b0e487 drm/i915: Always=
 backoff after a drm_modeset_lock() deadlock)
Merging mmc-fixes/fixes (157c99c5a295 mmc: alcor: don't write data before c=
ommand has completed)
Merging rtc-fixes/rtc-fixes (882c5e552ffd rtc: da9063: set uie_unsupported =
when relevant)
Merging gnss-fixes/gnss-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging hyperv-fixes/hyperv-fixes (46fc15487d02 Drivers: hv: vmbus: Expose =
monitor data only when monitor pages are used)
Merging drm-misc-fixes/for-linux-next-fixes (fe6169288666 drm/atomic-helper=
: Make atomic_enable/disable crtc callbacks optional)
Merging kbuild/for-next (79a3aaa7b82e Linux 5.1-rc3)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (9eb9e96e97b3 Documentation/DMA-API-HOWTO: upd=
ate dma_mask sections)
Merging asm-generic/master (d724444ab97d asm-generic/page.h: fix typo in #e=
rror text requiring a real asm/page.h)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (4c2741ac5e10 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (697e96ed1720 arm64: vdso: fix and clean-up Mak=
efile)
Merging arm-perf/for-next/perf (79a3aaa7b82e Linux 5.1-rc3)
Merging arm-soc/for-next (93958742192e arm64: tegra: Disable CQE Support fo=
r SDMMC4 on Tegra186)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (09466d997703 Merge branch 'v5.2/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (ff73f1f2190e Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (ac8ffad29938 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (c51f7f863552 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (81717283cf2c Merge commit '7d56bedb2730dc2ea8abf0fd7=
240ee99ecfee3c9' into omap-for-v5.1/fixes)
Merging reset/reset/next (d005aa750c9b reset: fix linux/reset.h errors)
Merging qcom/for-next (b9c7d1e25e51 Merge branch 'arm64-for-5.2' into all-f=
or-5.2)
Merging renesas/next (e4176560d265 Merge branches 'arm-defconfig-for-v5.2' =
and 'arm-dt-for-v5.2' into next)
Merging rockchip/for-next (a1dcc8301796 Merge branch 'v5.2-armsoc/dts32' in=
to for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (377e1eb1008a Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (0e790f20d032 Merge branches 'sunxi/clk-for-5.=
2' and 'sunxi/clk-fixes-for-5.1' into sunxi/for-next)
Merging tegra/for-next (8b2072d950fc Merge branch for-5.2/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (4ec3d901fbd2 Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (597a99877ca7 csky: Reconstruct signal.c and entry.=
S)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (733df11cfc36 m68k: defconfig: Update defconfigs for =
v5.1-rc1)
Merging m68knommu/for-next (79a3aaa7b82e Linux 5.1-rc3)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (e6331a321aaf MIPS: KVM: Use prandom_u32_max() to ge=
nerate tlbwr index)
Merging nds32/next (4e8fa54d3d99 nds32: fix semicolon code style issue)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (4b924b392fa4 parisc: Skip registering LED when =
running in QEMU)
Merging powerpc/next (8c2ffd917477 Linux 5.1-rc2)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (da4ed3787391 RISC-V: Use IS_ENABLED(CONFIG_CMODEL_=
MEDLOW))
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (46a984ffb86c s390/cpum_cf: Add support for CPU-MF SV=
N 6)
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
Merging btrfs-kdave/for-next (d0d85ba55d62 Merge branch 'for-next-stale-201=
90328' into for-next-20190328)
Merging ceph/master (daf5cc27eed9 ceph: fix use-after-free on symlink trave=
rsal)
Merging cifs/for-next (65bcad74f6c6 cifs: update module internal version nu=
mber)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (b98177978014 Pull quota limit handling fix.)
Merging ext4/dev (18915b5873f0 ext4: prohibit fstrim in norecovery mode)
Merging f2fs/dev (26f34433d5a4 f2fs: improve discard handling with multi-de=
vice volumes)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (a816fd6b49b6 Merge tag 'pidfd-fixes-v5.1-rc3' of gi=
tolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux)
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
Merging xfs/for-next (2032a8a27b5c xfs: serialize unaligned dio writes agai=
nst all other dio writes)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (c0abe5af7341 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
Merging printk/for-next (2821fd0c2be0 lib/test_printf: Switch to bitmap_zal=
loc())
Merging pci/next (e3a5de7be7a5 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (096c2e2bd33e Merge branch 'for-5.2/macally' into for-=
next)
Merging i2c/i2c/for-next (fd99dfc48e67 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (124dbd750da4 i3c: master: dw: remove dead code from d=
w_i3c_master_*_xfers())
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (9ef9dd1fe6ba hwmon: (iio_hwmon) Simplify =
attr.name generation in iio_hwmon_probe())
Merging jc_docs/docs-next (5e3ec254e086 docs: Fix a build error in coding-s=
tyle.rst)
Merging v4l-dvb/master (1c3ec30bb230 media: index.rst: exclude Indexes sect=
ion from latex/pdf output)
Merging v4l-dvb-next/master (81527254e151 media: seco: depend on CONFIG_RC_=
CORE=3Dy when not a module)
Merging fbdev/fbdev-for-next (9dc20113988b fbdev: sm712fb: fix memory frequ=
ency by avoiding a switch/case fallthrough)
Merging pm/linux-next (d86fde4fb00d Merge branches 'pm-cpuidle' and 'pm-sle=
ep' into linux-next)
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
Merging rdma/for-next (061ccb52d23c RDMA/cma: Set proper port number as ind=
ex)
Merging net-next/master (3eed52842b9f net: sched: don't set tunnel for deca=
p action)
CONFLICT (modify/delete): drivers/staging/mt7621-eth/mtk_eth_soc.c deleted =
in HEAD and modified in net-next/master. Version net-next/master of drivers=
/staging/mt7621-eth/mtk_eth_soc.c left in tree.
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/en/port_buffer.c
$ git rm -f drivers/staging/mt7621-eth/mtk_eth_soc.c
Merging bpf-next/master (e83b9f55448a kbuild: add ability to generate BTF t=
ype info for vmlinux)
Merging ipsec-next/master (f981c57ffd2d vti4: eliminated some duplicate cod=
e.)
Merging mlx5-next/mlx5-next (aef6c443fe84 net/mlx5: Fix false compilation w=
arning)
Merging netfilter-next/master (68cc2999f692 Merge branch 'devlink-small-spr=
ing-cleanup')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (8db32fa40091 Merge tag 'iwlwifi-next-=
for-kalle-2019-03-22' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlw=
ifi/iwlwifi-next)
Merging bluetooth/master (bbcece3d418c Bluetooth: mediatek: Fixed incorrect=
 type in assignment)
Merging mac80211-next/master (be9cefe796f3 selftests: rtnetlink: use intern=
al netns switch for ip commands)
Merging gfs2/for-next (3e4815fd93fa gfs2: clean_journal improperly set sd_l=
og_flush_head)
Merging mtd/mtd/next (9e98c678c2d6 Linux 5.1-rc1)
Merging nand/nand/next (61e27a0b8e3a mtd: nand: Remove useless line in Kcon=
fig)
Merging spi-nor/spi-nor/next (dcb4b22eeaf4 spi-nor: s25fl512s supports regi=
on locking)
Merging crypto/master (33d69455e402 crypto: caam - limit AXI pipeline to a =
depth of 1)
Merging drm/drm-next (5ebffda25773 Merge commit 'refs/for-upstream/mali-dp'=
 of git://linux-arm.org/linux-ld into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gvt/mmio_context=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_drv.c
Merging amdgpu/drm-next (6752bea8b03e drm/amd/display: Prevent cursor hotsp=
ot overflow for RV overlay planes)
Merging drm-intel/for-linux-next (795f672b88ba drm/i915: Expose full 1024 L=
UT entries on ivb+)
Merging drm-tegra/drm/tegra/for-next (11c632e1cfd3 drm/tegra: sor: Implemen=
t acquire/release for reset)
Merging drm-misc/for-linux-next (ffc267407149 drm/vc4: Disable V3D interact=
ions if the v3d component didn't probe.)
Applying: drm/lima: update for xa_alloc API change
Merging drm-msm/msm-next (745b19d74716 drm/msm/dpu: check split role for si=
ngle flush)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (e8e3cc7d39ff MAINTAINERS: Fix pattern=
 for Documentation path for Arm Mali Komeda)
Merging imx-drm/imx-drm/next (a0ea4ffff266 drm/imx: only send commit done e=
vent when all state has been applied)
Merging etnaviv/etnaviv/next (9e05352340d3 drm/etnaviv: potential NULL dere=
ference)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (c55296ebb4f2 Merge branch 'regmap-5.2' into regmap=
-next)
Merging sound/for-next (4b81dad109ad ALSA: doc: my_chip has no element iopo=
rt)
Merging sound-asoc/for-next (7c636f5ec5b0 Merge branch 'asoc-5.2' into asoc=
-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging modules/modules-next (1c7651f43777 kallsyms: store type information=
 in its own array)
Merging input/next (a5f50c501321 Input: goodix - add GT5663 CTP support)
Merging block/for-next (c5f47384a877 Merge branch 'for-5.2/block' into for-=
next)
Merging device-mapper/for-next (c96e0a974714 dm: disable DISCARD if the und=
erlying storage no longer supports it)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (8e3c818111de mmc: mmc_spi: Convert to use SPDX identifier)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (d42bcf4bbc95 mfd: axp20x: Allow the AXP223 to be =
probed by I2C)
Merging backlight/for-backlight-next (a6d6a589cb09 video: lcd: Remove usele=
ss BACKLIGHT_CLASS_DEVICE dependencies)
Merging battery/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging regulator/for-next (96be5cb3b9a5 Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (4c5d789ce175 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (6c07c1c74394 apparmor: fix blob compression=
 when ns is forced on a policy load)
Merging integrity/next-integrity (51a6db60254b selftests/kexec: make kexec_=
load test independent of IMA being enabled)
Merging selinux/next (593854c05210 MAINTAINERS: update SELinux file pattern=
s)
Merging tpmdd/next (5812f97c0a22 tpm: Fix the type of the return value in c=
alc_tpm2_event_size())
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (abc8cad6822d Merge branches 'iommu/fixes', 'x86/vt-d' a=
nd 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (a1aa08a01f73 audit: link integrity evm_write_xattrs rec=
ord to syscall event)
Merging devicetree/for-next (1d9bb69a454a of: property: Document that of_gr=
aph_get_endpoint_by_regs needs of_node_put)
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (5fe4eda0bef6 Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (2ecdfd10d440 Merge branch 'linus')
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (fad9fab975cb EDAC/altera, firmware/intel: Add St=
ratix10 ECC DBE SMC call)
Merging irqchip/irq/irqchip-next (fca269f201a8 irqchip/mbigen: Don't clear =
eventid when freeing an MSI)
Merging ftrace/for-next (85f726a35e50 tracing: Use strncpy instead of memcp=
y when copying comm in trace.c)
Merging rcu/rcu/next (41e1c2c6379f Merge LKMM and RCU branches)
Merging kvm/linux-next (690edec54cba Merge tag 'kvmarm-fixes-for-5.1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-master)
Merging kvm-arm/next (5d8d4af24460 arm64: KVM: Fix system register enumerat=
ion)
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
Merging leds/for-next (6e6c214f16e4 leds: Small fixes for Flash class descr=
iption)
Merging ipmi/for-next (c16fec806b4b ipmi: fix sleep-in-atomic in free_user =
at cleanup SRCU user->release_barrier)
Merging driver-core/driver-core-next (c03a0fd0b609 kobject: Don't trigger k=
object_uevent(KOBJ_REMOVE) twice.)
Merging usb/usb-next (8cdfd068c1ea Merge 5.1-rc3 into usb-next)
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (f64c3ab23068 USB: serial: pl2303: fix tranceiv=
er suspend mode)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (46c12f846a2a dt-bindings: phy: Add a new property dr=
ive-impedance-ohm for RK's emmc PHY)
Merging tty/tty-next (b63d443be43b Merge 5.1-rc3 into tty-next)
Merging char-misc/char-misc-next (d358b1733fc3 chardev: update comment base=
d on the code)
CONFLICT (content): Merge conflict in drivers/misc/fastrpc.c
Merging extcon/extcon-next (9d8e2af50df7 extcon: mrfld: Introduce extcon dr=
iver for Basin Cove PMIC)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (fd21b79e541e thunderbolt: Fix to check the return=
 value of kmemdup)
Merging staging/staging-next (44b8ef17c435 staging: media: tegra-vde: add p=
roper SPDX identifiers on file that did not have it.)
CONFLICT (modify/delete): drivers/staging/mt7621-spi/Makefile deleted in HE=
AD and modified in staging/staging-next. Version staging/staging-next of dr=
ivers/staging/mt7621-spi/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/mt7621-spi/Kconfig deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of dri=
vers/staging/mt7621-spi/Kconfig left in tree.
CONFLICT (modify/delete): drivers/staging/media/mt9t031/Makefile deleted in=
 HEAD and modified in staging/staging-next. Version staging/staging-next of=
 drivers/staging/media/mt9t031/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/media/mt9t031/Kconfig deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/mt9t031/Kconfig left in tree.
CONFLICT (content): Merge conflict in drivers/spi/spi-mt7621.c
$ git rm -f drivers/staging/media/mt9t031/Kconfig drivers/staging/media/mt9=
t031/Makefile drivers/staging/mt7621-spi/Kconfig drivers/staging/mt7621-spi=
/Makefile
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (a5a743996384 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (23b846396b95 dmaengine: axi-dmac: extend support fo=
r ZynqMP arch)
Merging cgroup/for-next (0fcc4c8c044e device_cgroup: fix RCU imbalance in e=
rror case)
Merging scsi/for-next (0a2101343274 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (fb17358ce8a0 scsi: qedf: Update the driver versi=
on to 8.37.25.19)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (3fbdb54c7d5a arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
CONFLICT (content): Merge conflict in drivers/iommu/Makefile
CONFLICT (content): Merge conflict in drivers/iommu/Kconfig
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (251b87a181ba Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (85edcd01a902 gpiolib: acpi: Fix references=
 in kernel doc and amend)
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
Merging livepatching/for-next (768321fdbcb1 Merge branch 'for-5.1-upstream-=
fixes' into for-next)
Merging coresight/next (d5d246a56af0 coresight: Merge the static and dynami=
c replicator drivers)
Merging rtc/rtc-next (4b4ef06d96f7 rtc: pcf85063: add RTC_VL_READ/RTC_VL_CL=
R support)
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
Merging gnss/gnss-next (79a3aaa7b82e Linux 5.1-rc3)
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
Merging pidfd/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging devfreq/for-next (e143645ca40d PM / devfreq: rk3399_dmc: Pass ODT a=
nd auto power down parameters to TF-A.)
Merging akpm-current/current (ae42e32c5602 ipc: do cyclic id allocation for=
 the ipc object.)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: scripts/atomic/gen-atomics.sh: don't assume that scripts are exec=
utable
Applying: fs/coda/psdev.c: remove duplicate header
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs/cachefiles/namei.c: remove duplicate header
Applying: fs/block_dev.c: Remove duplicate header
Applying: kernel, resource: use resource_overlaps() to simplify region_inte=
rsects()
Applying: treewide: replace #include <asm/sizes.h> with #include <linux/siz=
es.h>
Applying: arch: remove <asm/sizes.h> amd <asm-generic/sizes.h>
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm-rename-ambiguously-named-memorystat-counters-and-functions-fix
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (dad916f07605 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/ERqvmpRNbOVA0_9h0uPpQpW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyllTEACgkQAVBC80lX
0Gze9gf/f1z2BkPnwcjOzFdEiHXLzOMjNqxD0GhCdEu2Hr9mRODEjiG9iLoEpq2A
s+vqb0FheUmYF0u6uzglKs0EqNTxVFVHqzUyBmZlUoZz8MCCgMiuWFVtltAbBGZF
fEm08f1loGM5f2W6POlKLI+KpqimTnEGHJp/BYyhBlp/e2v655FL0ILeF4D8TV6M
zXWFoTxZGw1Onl7lCZVZtPslRl5wuJZ0yo98ltU1B0XYati98h+cH9u9Vve5uP3h
Rzyb2aAX/SYtqaQwUupz4tKW38KIiMRyOx3jgLZTG+a5glCm5Ym7n1zNF1aSHGUT
67wswjBA1xR5zeQ7R+LQEJXv72Kzyw==
=dy6y
-----END PGP SIGNATURE-----

--Sig_/ERqvmpRNbOVA0_9h0uPpQpW--
