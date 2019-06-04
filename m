Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B189EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D1C24889
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m7A1Bdz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFDGKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:10:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFDGKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:10:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45J1jd3LrBz9s1c;
        Tue,  4 Jun 2019 16:09:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559628597;
        bh=nRYNBi1N+xTcMGpUmmr5UlmuET46mKJU/MF2RRN55NI=;
        h=Date:From:To:Cc:Subject:From;
        b=m7A1Bdz6l+nABvLoha/ASL5LhCH3pgqPL5VN9UBeoYBxhjZwKImZmx8OXZE+Z4L3h
         FQG7Z9Rezz98/b7VyWuwrysU5sYOVUTgXSis0JthQXqRAFUqKL4cbjyS58SuKJEz8x
         PBtC+rD9AwYCiZTcUJq+2eolIyi04PAIxPKL6jK4hc0JmIVg/cfxm7HhG2Ffifseeg
         /07Qv9PJFYjJq8p3BYUd1fWrCzbR+hQOk9BkROn3nLByPrOLPc0def45hl6zKLG57n
         IeAOUcbp6xG4EFRziqFsl8kep9KgYl9uoI6zGF04tMi5sp+Blxp1NgVsJtrIRms+Nr
         URTtiGHneyskA==
Date:   Tue, 4 Jun 2019 16:09:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 4
Message-ID: <20190604160956.5194d2c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qA+IA/MV_ybP3g/A7_gDTy1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qA+IA/MV_ybP3g/A7_gDTy1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190603:

The net-next tree gained conflicts against Linus' tree.

The nand tree gained a conflict against Linus' tree.

The clockevents tree lost its build failure.

The xarray tree lost its runtime problems.

Non-merge commits (relative to Linus' tree): 3569
 4072 files changed, 144389 insertions(+), 150138 deletions(-)

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

I am currently merging 293 trees (counting Linus' and 71 trees of bug
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
Merging origin/master (788a024921c4 Merge tag 'arc-5.2-rc4' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (034e673710d3 platform/x86: acer-wmi: Ma=
rk expected switch fall-throughs)
Merging kbuild-current/fixes (30a28f11b618 kbuild: tar-pkg: enable communic=
ation with jobserver)
Merging arc-current/for-curr (46e04c25e72f ARC: [plat-hsdk] Get rid of inap=
propriate PHY settings)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (1e29ab3186e3 arm64: use the correct fun=
ction type for __arm64_sys_ni_syscall)
Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time: M=
ark m68k having modern-timekeeping)
Merging powerpc-fixes/fixes (8b909e354870 powerpc/kexec: Fix loading of ker=
nel + initramfs with kexec_file_load())
Merging s390-fixes/fixes (674459be1169 MAINTAINERS: add Vasily Gorbik and C=
hristian Borntraeger for s390)
Merging sparc/master (30d1d92a888d Merge tag 'nds32-for-linux-5.2-rc3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (28e74a7cfd64 net: sfp: read eeprom in maximum 16 byte i=
ncrements)
Merging bpf/master (e7f3dd281cf9 Merge branch 'reuseport-fixes')
Merging ipsec/master (7c80eb1c7e2b af_key: fix leaks in key_pol_get_resp an=
d dump_sp.)
Merging netfilter/master (5142967ab524 netfilter: nf_tables: fix module aut=
oload with inet family)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (69ae4f6aac15 mwifiex: Fix heap overflow in=
 mwifiex_uap_parse_tail_ies())
Merging mac80211/master (180aa422ef27 nl80211: fill all policy .type entrie=
s)
Merging rdma-fixes/for-rc (4f240dfec6bc RDMA/efa: Remove MAYEXEC flag check=
 from mmap flow)
Merging sound-current/for-linus (717f43d81afc ALSA: hda/realtek - Update he=
adset mode for ALC256)
Merging sound-asoc-fixes/for-linus (b8e81490e3ea Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (38ee2a8cc70e Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (9a917498e18a Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (7c2d023fb358 Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (a188339ca5a3 Linux 5.2-rc1)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (2649939ad750 usb: typec: ucsi: ccg: fix memo=
ry leak in do_flash)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (f3dfd4072c3e USB: serial: option: add T=
elit 0x1260 and 0x1261 compositions)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (700ffe3c92c2 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging char-misc.current/char-misc-linus (8aa75b72e3e6 Merge tag 'misc-hab=
analabs-fixes-2019-05-24' of git://people.freedesktop.org/~gabbayo/linux in=
to char-misc-linus)
Merging soundwire-fixes/fixes (03ecad90d379 soundwire: stream: fix out of b=
oundary access on port properties)
Merging thunderbolt-fixes/fixes (cd6c84d8f0cd Linux 5.2-rc2)
Merging input-current/for-linus (7c7da40da164 Input: uinput - add compat io=
ctl number translation for UI_*_FF_UPLOAD)
Merging crypto-current/master (7829a0c1cb9c crypto: hmac - fix memory leak =
in hmac_init_tfm())
Merging ide/master (54dee406374c Merge tag 'arm64-fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/arm64/linux)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (bc2cce3f2ebc selftests: vm: install test_vma=
lloc.sh for run_vmtests)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (8243b87c3abb dt-bindings: dma: uart: rename =
binding)
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (b2b5921fe4b3 mtd: rawnand: initialize ntargets=
 with maxchips)
Merging mfd-fixes/for-mfd-fixes (e93c9c99a629 Linux 5.1)
Merging v4l-dvb-fixes/fixes (a200c721956c media: venus: hfi_parser: fix a r=
egression in parser)
Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f532beeeff0c MIPS: uprobes: remove set but n=
ot used variable 'epc')
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc'=
 into fixes)
Merging kvm-fixes/master (f8d221d2e0e1 Merge tag 'kvm-s390-master-5.2-2' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-maste=
r)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (ef583670a438 hwmon: core: add thermal sensors on=
ly if dev->of_node is present)
Merging nvdimm-fixes/libnvdimm-fixes (52f476a323f9 libnvdimm/pmem: Bypass C=
ONFIG_HARDENED_USERCOPY overhead)
Merging btrfs-fixes/next-fixes (8b1d37b7b32d Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (d8076bdb56af uapi: Wire up the mount API syscalls =
on non-x86 arches [ver #2])
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (d6423bd03031 platform/x86: pmc_atom: Add s=
everal Beckhoff Automation boards to critclk_systems DMI table)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (3b0541791453 scsi: libsas: delete sas port if exp=
ander discover failed)
Merging drm-fixes/drm-fixes (2a3e0b716296 Merge tag 'imx-drm-fixes-2019-05-=
29' of git://git.pengutronix.de/git/pza/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (afb286bcae85 Merge tag 'gvt-f=
ixes-2019-05-30' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (739799314587 mmc: sdhci_am654: Fix SLOTTYPE write)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (2a3e0b716296 Merge tag 'imx-dr=
m-fixes-2019-05-29' of git://git.pengutronix.de/git/pza/linux into drm-fixe=
s)
Merging kbuild/for-next (2409207a73cc Merge tag 'scsi-fixes' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (2e96e04d25ca MIPS: use the generic uncached s=
egment support in dma-direct)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (ef94e8ea94ed ARC: entry: EV_Trap expects r10 (vs. r9)=
 to have exception cause)
Merging arm/for-next (91da0d72dcff Merge commit 'riscpc^{/ARM: riscpc: dma:=
 use __iomem pointers for writing DMA}' into for-next)
Merging arm64/for-next/core (6127bf372add Merge branch 'for-next/mmiowb' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux into for-next/co=
re)
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (7ad1b252cabe ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (1194145dec96 Merge branch 'v5.3/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (130413736376 ARM: dts: aspeed: Add Microsoft Olymp=
us BMC)
Merging at91/at91-next (32dfd9cfa4c6 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (83d02ffe0144 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (07eb35473c64 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (4ee23cd76c0c Merge branch 'omap-for-v5.2/ti-sysc' in=
to fixes)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging qcom/for-next (d1b240beca65 Merge branch 'drivers-for-5.3' into all=
-for-5.3)
Merging renesas/next (f7918626c158 Merge branches 'arm-soc-for-v5.3' and 'a=
rm64-dt-for-v5.3' into next)
Merging rockchip/for-next (958bf721f5d2 Merge branch 'v5.3-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (d68c44eaa535 Merge branch 'next/defconfig' i=
nto for-next)
Merging sunxi/sunxi/for-next (31d382a2bb08 Merge branch 'sunxi/dt-for-5.3' =
into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging tegra/for-next (c47cf10c6cb2 Merge branch for-5.3/arm64/dt into for=
-next)
Merging clk/clk-next (f191a146bcee Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (c304b8d2f9aa clk: samsung: exynos5433: Use of=
_clk_get_parent_count())
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (6b436744a0b7 csky: Fixup no panic in kernel for so=
me traps)
Merging h8300/h8300-next (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linu=
x-nfs.org/~bfields/linux)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f67d667213ba m68k: defconfig: Update defconfigs for =
v5.2-rc1)
Merging m68knommu/for-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (361686288213 MIPS: replace MBIT_ULL() with BIT_ULL(=
))
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (029ab28a86e7 parisc: Use implicit space registe=
r selection for loading the coherence index of I/O pdirs)
Merging powerpc/next (a3bf9fbdad60 powerpc/pseries: Fix xive=3Doff command =
line)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (5d1d046e2868 soc: fsl: qbman_portals: add APIs to ret=
rieve the probing status)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (8fef9900d43f riscv: fix locking violation in page =
fault handler)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (2409207a73cc Merge tag 'scsi-fixes' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging sh/sh-next (860dbce3d8dd Merge branch 'master' of git://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all ir=
qs)
Merging xtensa/xtensa-for-next (2ba543d3e7db Merge branch 'xtensa-5.2-fixes=
' into xtensa-for-next)
Merging fscrypt/master (5858bdad4d0d fscrypt: don't set policy for a dead d=
irectory)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current-v=
5.1-20190509' into for-next-20190509)
Merging ceph/master (00abf69dd24f ceph: flush dirty inodes before proceedin=
g with remount)
Merging cifs/for-next (f45a72c7597d cifs: Use kmemdup in SMB2_ioctl_init())
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (3803f4dc265f Merge ext2 bitmap bh leak fix.)
Merging ext4/dev (a49773064bc2 jbd2: fix typo in comment of journal_submit_=
inode_data_buffers)
Merging f2fs/dev (b1820efff17a f2fs: add error prints for debugging mount f=
ailure)
Merging fuse/for-next (26eb3bae5003 fuse: extract helper for range writebac=
k)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging nfs-anna/linux-next (ba851a39c970 NFSv4.1: Fix bug only first CB_NO=
TIFY_LOCK is handled)
Merging nfsd/nfsd-next (f420eae8f7c9 nfsd: Spelling s/EACCESS/EACCES/)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (5d3211b651a0 ovl: doc: add non-standard c=
orner cases)
Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (5cd213b0fec6 xfs: don't reserve per-AG space for an i=
nternal log)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-next)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging printk/for-next (967aa2217b6d Merge branch 'for-5.2-fixes' into for=
-next)
Merging pci/next (a188339ca5a3 Linux 5.2-rc1)
Merging pstore/for-next/pstore (e070e380c674 Merge branch 'for-linus/pstore=
' into for-next/pstore)
Merging hid/for-next (d4582ee4fc55 Merge branch 'for-5.2/fixes' into for-ne=
xt)
Merging i2c/i2c/for-next (6e2700c656e5 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (5e343fbb7176 dt-bindings: i3c: Document dropped suppo=
rt for I2C 10 bit devices)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (532454c231d8 hwmon: (tc654) Update to use=
 SPDX-License-Identifier)
CONFLICT (content): Merge conflict in drivers/hwmon/tc654.c
Merging jc_docs/docs-next (6c01edd395a7 docs: look for sphinx-pre-install i=
n the source tree)
Merging v4l-dvb/master (0864c9ce8fe8 media: dt-bindings: Fix vendor-prefixe=
s YAML)
CONFLICT (content): Merge conflict in drivers/media/i2c/cx25840/cx25840-cor=
e.c
Merging v4l-dvb-next/master (a188339ca5a3 Linux 5.2-rc1)
Merging fbdev/fbdev-for-next (73ee89436047 Merge tag 'v5.2-rc1' of https://=
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux into fbdev-for-next)
Merging pm/linux-next (a58e37b837ca Merge branches 'pm-sleep' and 'pm-x86' =
into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (036eb5c6d532 cpufreq: armada-37=
xx: Remove set but not used variable 'freq')
Merging cpupower/cpupower (21027e78e7c1 cpupower: correct spelling of inter=
val)
Merging opp/opp/linux-next (c0ab9e0812da opp: Allocate genpd_virt_devs from=
 dev_pm_opp_attach_genpd())
Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'thermal-=
built-it' and 'thermal-intel' into next)
Merging thermal-soc/next (cd6c84d8f0cd Linux 5.2-rc2)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (063b8271ec8f swiotlb-xen: ensure we have a sing=
le callsite for xen_dma_map_page)
Merging rdma/for-next (97545b10221a RDMA/hns: Bugfix for posting multiple s=
rq work request)
Merging net-next/master (b7034146756b net: fix use-after-free in kfree_skb_=
list)
CONFLICT (modify/delete): drivers/isdn/hisax/hfc_usb.c deleted in net-next/=
master and modified in HEAD. Version HEAD of drivers/isdn/hisax/hfc_usb.c l=
eft in tree.
CONFLICT (modify/delete): drivers/isdn/gigaset/i4l.c deleted in net-next/ma=
ster and modified in HEAD. Version HEAD of drivers/isdn/gigaset/i4l.c left =
in tree.
$ git rm -f drivers/isdn/gigaset/i4l.c drivers/isdn/hisax/hfc_usb.c
Merging bpf-next/master (0462eaacee49 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/bpf/bpf-next)
Merging ipsec-next/master (f49aa1de9836 Merge tag 'for-5.2-rc1-tag' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging mlx5-next/mlx5-next (8693115af4c2 {IB,net}/mlx5: Constify rep ops f=
unctions pointers)
Merging netfilter-next/master (b33bc2b878e0 nexthop: Add entry to MAINTAINE=
RS)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (ec2e93cf1910 b43: Avoid possible doub=
le calls to b43_one_core_detach())
Merging bluetooth/master (b33bc2b878e0 nexthop: Add entry to MAINTAINERS)
Merging mac80211-next/master (a3ce17d1495b cfg80211: Handle bss expiry duri=
ng connection)
Merging gfs2/for-next (d8e126ba276a gfs2: Clean up freeing struct gfs2_sbd)
Merging mtd/mtd/next (a188339ca5a3 Linux 5.2-rc1)
Merging nand/nand/next (5dc353d306bf mtd: onenand_base: Avoid fall-through =
warnings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/brcm,brcmnand.txt
Merging spi-nor/spi-nor/next (a188339ca5a3 Linux 5.2-rc1)
Merging crypto/master (0adb0c99594b dt-bindings: move Atmel ECC508A I2C cry=
pto processor to trivial-devices)
CONFLICT (content): Merge conflict in drivers/crypto/talitos.c
CONFLICT (modify/delete): crypto/crypto_wq.c deleted in crypto/master and m=
odified in HEAD. Version HEAD of crypto/crypto_wq.c left in tree.
$ git rm -f crypto/crypto_wq.c
Merging drm/drm-next (91c1ead6aee2 Merge branch 'drm-next-5.3' of git://peo=
ple.freedesktop.org/~agd5f/linux into drm-next)
Merging amdgpu/drm-next (b88039ffc5bb drm/amdgpu: fix a race in GPU reset w=
ith IB test (v2))
Merging drm-intel/for-linux-next (912348b64d09 drm/i915/icl: Ensure port A =
combo PHY HW state is correct)
Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CPU-=
cache maintenance for BO's allocated using get_pages())
Merging drm-misc/for-linux-next (1b94f47793b1 drm/docs: More links for impl=
icit/explicit fencing.)
Merging drm-msm/msm-next (981f2aabeae6 drm/msm/a6xx: Rename a6xx_gmu_probe =
to a6xx_gmu_init)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (15e9122d9b5c drm/komeda: Mark the loc=
al functions as static)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle mas=
k before querying the HW db)
Merging regmap/for-next (38ee2a8cc70e Merge branch 'regmap-5.2' into regmap=
-linus)
Merging sound/for-next (e046b64b1547 ALSA: hda/ca0132: Use struct_size())
CONFLICT (content): Merge conflict in sound/pci/rme9652/hdspm.c
Merging sound-asoc/for-next (4cdd20afb127 Merge branch 'asoc-5.3' into asoc=
-next)
Merging modules/modules-next (dadec066d8fa module: add stubs for within_mod=
ule functions)
Merging input/next (b02f6b6b711b Input: tca8418 - remove set but not used v=
ariable 'max_keys')
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging block/for-next (51af912e51dd Merge branch 'io_uring-next' into for-=
next)
Merging device-mapper/for-next (51b86f9a8d1c dm: make sure to obey max_io_l=
en_target_boundary)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (a78b6dc2b410 mmc: sdhci-pci: remove redundant check of sl=
ots =3D=3D 0)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-mx-sdio.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (e9aa1154179d mfd: intel-lpss: Keep device tables =
sorted by ID)
Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Add =
firmware node support)
Merging battery/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging regulator/for-next (71ebdf157a12 Merge branch 'regulator-5.3' into =
regulator-next)
Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a varia=
nt of PROFILE_MEDIATES_SAFE)
Merging integrity/next-integrity (8902b36bab4c ima: prevent a file already =
mmap'ed write to be mmap'ed execute)
Merging selinux/next (beee56f3543a selinux: remove some no-op BUG_ONs)
Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during "g=
et random")
Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one p=
retimeout governor is enabled)
Merging iommu/next (d6f11edc3bf7 Merge branches 'iommu/fixes', 'x86/vt-d', =
'x86/amd', 'arm/renesas', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (b361797f3d0b dt-bindings: vendor: Fix simtek v=
endor compatible)
Merging mailbox/mailbox-for-next (8fbbfd966efa mailbox: Add support for Arm=
ada 37xx rWTM mailbox)
Merging spi/for-next (aee1b3ddcffd Merge remote-tracking branch 'spi/topic/=
pump-rt' into spi-next)
Merging tip/auto-latest (00d8b7582f55 Merge branch 'core/urgent')
Merging clockevents/clockevents/next (1a2b562af754 clocksource/drivers/exyn=
os_mct: Increase priority over ARM arch timer)
Merging edac-amd/for-next (8de9930a4618 Revert "EDAC/amd64: Support more th=
an two controllers for chip select handling")
Merging irqchip/irq/irqchip-next (4770533f71de irqchip/renesas-irqc: Conver=
t to managed initializations)
Merging ftrace/for-next (a124692b698b ftrace: Enable trampoline when rec co=
unt returns back to one)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (94830f188a80 Merge tag 'kvm-s390-master-5.2-1' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (4894fbcce856 KVM: PPC: Book3S: Remove useless=
 checks in 'release' method of KVM device)
Merging kvms390/next (b3fe4882c368 KVM: selftests: enable pgste option for =
the linker on s390)
Merging xen-tip/linux-next (1d5c76e66433 xen-blkfront: switch kcalloc to kv=
calloc for large array allocation)
Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (ef071bab655b power: supply: olpc_battery: All=
ow building the driver on non-x86)
Merging chrome-platform/for-next (ac5bdfdc0e1c platform/chrome: cros_ec_spi=
: Request the SPI thread be realtime)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (1916ebfdfbac leds: max77650: Remove set but not used=
 variable 'parent')
Merging ipmi/for-next (3559c3270aa3 drivers: ipmi: Drop device reference)
Merging driver-core/driver-core-next (c9c2c27d7cec debugfs: make debugfs_cr=
eate_u32_array() return void)
Merging usb/usb-next (119a7fdfeece Merge 5.2-rc3 into usb-next)
Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRAT=
A)
Merging usb-serial/usb-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (6ef72bc036bc phy: qcom: Add Qualcomm PCIe2 PHY drive=
r)
Merging tty/tty-next (888dc273ea4e Merge 5.2-rc3 into tty-next)
Merging char-misc/char-misc-next (381e9760ee87 firmware: google: coreboot: =
Drop unnecessary headers)
Merging extcon/extcon-next (fbdc60b2a787 extcon: arizona: Correct error han=
dling on regmap_update_bits_check)
Merging soundwire/next (432732b801c8 soundwire: intel_init: add checks on l=
ink numbers)
Merging thunderbolt/next (cd6c84d8f0cd Linux 5.2-rc2)
Merging staging/staging-next (23004ec33092 Merge 5.2-rc3 into staging-next)
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (7b11ef9653d2 dmaengine: stm32: use to_platform_devi=
ce())
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
Merging cgroup/for-next (a5e112e6424a cgroup: add cgroup_parse_float())
Merging scsi/for-next (1c5176c3dd8c Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_spi.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_iscsi.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport_fc.h
CONFLICT (content): Merge conflict in include/scsi/scsi_transport.h
CONFLICT (content): Merge conflict in include/scsi/scsi_bsg_iscsi.h
CONFLICT (content): Merge conflict in include/scsi/sas_ata.h
CONFLICT (content): Merge conflict in include/scsi/sas.h
CONFLICT (content): Merge conflict in include/scsi/libsas.h
CONFLICT (content): Merge conflict in include/scsi/libiscsi_tcp.h
CONFLICT (content): Merge conflict in include/scsi/libiscsi.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_proto.h
CONFLICT (content): Merge conflict in include/scsi/iscsi_if.h
CONFLICT (content): Merge conflict in drivers/scsi/st.c
CONFLICT (content): Merge conflict in drivers/scsi/sr.c
CONFLICT (content): Merge conflict in drivers/scsi/sg.c
CONFLICT (content): Merge conflict in drivers/scsi/ses.c
CONFLICT (content): Merge conflict in drivers/scsi/sd.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_spi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_sas.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_iscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_transport_fc.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysfs.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_sysctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_pm.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_lib.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_ioctl.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi_error.c
CONFLICT (content): Merge conflict in drivers/scsi/scsi.c
CONFLICT (modify/delete): drivers/scsi/osst.c deleted in scsi/for-next and =
modified in HEAD. Version HEAD of drivers/scsi/osst.c left in tree.
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_task.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_scsi_host.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_internal.h
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_init.c
CONFLICT (content): Merge conflict in drivers/scsi/libsas/sas_ata.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi_tcp.c
CONFLICT (content): Merge conflict in drivers/scsi/libiscsi.c
CONFLICT (content): Merge conflict in drivers/scsi/hosts.c
$ git rm -f drivers/scsi/osst.c
Merging scsi-mkp/for-next (f9ee0f083e1f scsi: message: fusion: Use kmemdup =
instead of memcpy and kmalloc)
Merging vhost/linux-next (317e03c88c57 iommu/virtio: Add event queue)
Merging rpmsg/for-next (37d3f7e0947c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (8b74ae41f1ee gpio: pca953x: Add support for the TI T=
CA9539)
Merging gpio-brgl/gpio/for-next (2674700c4c0e gpio: max732x: use devm_gpioc=
hip_add_data())
Merging pinctrl/for-next (8219ffa1e232 pinctrl: u300: Fix SPDX tags)
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-u300.c
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-coh901.c
CONFLICT (content): Merge conflict in drivers/pinctrl/nomadik/pinctrl-abx50=
0.c
CONFLICT (content): Merge conflict in drivers/pinctrl/nomadik/Kconfig
Merging pinctrl-samsung/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configurati=
on for Meson G12A)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (fe48319243a6 selftests/timers: Add missing fflush(s=
tdout) calls)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (95def8fe33ed Merge branch 'for-5.2/fixes' in=
to for-next)
Merging coresight/next (8f35caae1e1f coresight: acpi: Support for platform =
devices)
Merging rtc/rtc-next (a3094fc1a15e rtc: imx-sc: add rtc alarm support)
Merging nvdimm/libnvdimm-for-next (cd6c84d8f0cd Linux 5.2-rc2)
Merging at24/at24/for-next (9ae9d9bfb72c eeprom: at24: use struct_size() in=
 devm_kzalloc())
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (0ff9848067b7 security/loadpin: Allow to exclude=
 specific file types)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (c8d087d040cf nvmem: Broaden the selection of NVMEM_=
SNVS_LPGPR)
Merging xarray/xarray (12fd2aee6db7 XArray tests: Add check_insert)
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (f4cd7203c1d4 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (08f2abef168d tests: add pidfd_open() tests)
CONFLICT (content): Merge conflict in tools/testing/selftests/pidfd/Makefile
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (87bfe5d0dc25 include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in kernel/pid.c
CONFLICT (content): Merge conflict in include/linux/pid.h
CONFLICT (content): Merge conflict in include/linux/genalloc.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm/hmm.c: suppress compilation warnings when CONFIG_HUGETLB_PAGE =
is not set
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (38906445f2f4 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/qA+IA/MV_ybP3g/A7_gDTy1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz2CzQACgkQAVBC80lX
0GxmWgf7BMjGkWtAftTqIO/yeJKQVLeRVxR6FbUlamsY/36yLE9OiDwzjhZIpDVQ
lske8LEGcVyGkpwDLfgysf59k0FShFYYpTb2lVVy6TodG9tsX6FbLKBgVvIjtjc1
e6RKHjw6zjDfKuyEMoPM+RiRqMfYQUFgMmoIJW6W4XCwoH2+EbStGCyXiNIg1/rT
DE0RkE8F+8l6lI9bKyMSR13U+OtL7PteYDs1/FIDPFE/DmvZrFq6sCsUv6t2D/FX
ARgoATfN+MCWM5CxGcUd8XVw2vpZ7KgClLTSPBlcGhoP5nNw3UuG1antX7WEqfln
3a8iRA65kN1cLYdWfzsdIXwqg7ee5g==
=aUAi
-----END PGP SIGNATURE-----

--Sig_/qA+IA/MV_ybP3g/A7_gDTy1--
