Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007DBC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A95223BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L3ZD05Hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfGWEXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:23:55 -0400
Received: from ozlabs.org ([203.11.71.1]:44261 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfGWEXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:23:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45t52X2SXWz9s7T;
        Tue, 23 Jul 2019 14:23:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563855828;
        bh=sASGPdve+cvkEZXGAOzbaZdbCGr5RFgmBddpCWw1y6M=;
        h=Date:From:To:Cc:Subject:From;
        b=L3ZD05Hib6/ETX7irCLFQ5eUPXMX1vOnZZNAUc0jBOaMlZ34bCJLF+hSb8DaCV8LO
         Aymu4gYOl7Q1tyzod43x/sHJGwXmJ4z2sHQe5Z3cpxseo6RNmaUx79RGckkNIeP1xw
         GQ+JYm1RPEDX7fcueZuvbxXe91aKv+Bb33DwOWrkvdfNZqsWJRaVvcqT5GAcxjMvd/
         OktV6VXDTMhGGqOc6zNDRgzPbiiEGGFLg65tE4yTSOmf3LnNQ0uO54M1qm1+r4yKZd
         tIBIC4eYnosLs6kUY5trfeuW3Op1DRChYAQLEnpBp1+16DePixjH2sSFbYAbZ5rJ7m
         XG2qrMgTPv55g==
Date:   Tue, 23 Jul 2019 14:23:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 23
Message-ID: <20190723142347.66fc0f43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bzXFr37XtX=2bGbbLFa0Qfi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bzXFr37XtX=2bGbbLFa0Qfi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190722:

The v4l-dvb tree gained a build failure for which I applied a patch.

The drm-intel tree gained a conflict against the kspp-gustavo tree.

Non-merge commits (relative to Linus' tree): 1453
 1509 files changed, 143742 insertions(+), 24819 deletions(-)

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

I am currently merging 299 trees (counting Linus' and 72 trees of bug
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
Merging origin/master (7b5cf701ea9c Merge branch 'sched-urgent-for-linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (c309b6f24222 Merge tag 'docs/v5.3-1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging kbuild-current/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging arc-current/for-curr (24a20b0a443f ARC: [plat-hsdk]: Enable AXI DW =
DMAC in defconfig)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (ae00fcc51e71 ARM: Delete netx a second tim=
e)
Merging arm64-fixes/for-next/fixes (40ca0ce56d4b arm64: entry: SP Alignment=
 Fault doesn't write to FAR_EL1)
Merging m68k-current/for-linus (f28a1f16135c m68k: Don't select ARCH_HAS_DM=
A_PREP_COHERENT for nommu or coldfire)
Merging powerpc-fixes/fixes (f16d80b75a09 powerpc/tm: Fix oops on sigreturn=
 on systems without TM)
Merging s390-fixes/fixes (9a159190414d s390/unwind: avoid int overflow in o=
utside_of_stack)
Merging sparc/master (192f0f8e9db7 Merge tag 'powerpc-5.3-1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (12185dfe4436 bonding: Force slave speed check after lin=
k state recovery for 802.3ad)
Merging bpf/master (c8eee4135a45 selftests/bpf: fix sendmsg6_prog on s390)
Merging ipsec/master (22d6552f827e xfrm interface: fix management of phydev)
Merging netfilter/master (15a78ba1844a netfilter: ebtables: fix a memory le=
ak bug in compat)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (5f9e832c1370 Linus 5.3-rc1)
Merging mac80211/master (d2b3fe42bc62 mac80211: don't warn about CW params =
when not using them)
Merging rdma-fixes/for-rc (5f9e832c1370 Linus 5.3-rc1)
Merging sound-current/for-linus (e4091bdd2fd9 ALSA: line6: Fix a typo)
Merging sound-asoc-fixes/for-linus (5ee3c836a2ad Merge branch 'asoc-5.3' in=
to asoc-linus)
Merging regmap-fixes/for-linus (5f9e832c1370 Linus 5.3-rc1)
Merging regulator-fixes/for-linus (b9131a51dc49 Merge branch 'regulator-5.3=
' into regulator-linus)
Merging spi-fixes/for-linus (29a603af8bc6 Merge branch 'spi-5.3' into spi-l=
inus)
Merging pci-current/for-linus (6dbbd053e6ae PCI/P2PDMA: Ignore root complex=
 whitelist when an IOMMU is present)
Merging driver-core.current/driver-core-linus (5f9e832c1370 Linus 5.3-rc1)
Merging tty.current/tty-linus (5f9e832c1370 Linus 5.3-rc1)
Merging usb.current/usb-linus (5f9e832c1370 Linus 5.3-rc1)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (f8377eff5481 USB: serial: ftdi_sio: add=
 ID for isodebug v1)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (5f9e832c1370 Linus 5.3-rc1)
Merging char-misc.current/char-misc-linus (c8917b8ff09e firmware: fix build=
 errors in paged buffer handling code)
Merging soundwire-fixes/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging thunderbolt-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging input-current/for-linus (a7cd67e2b76e Input: applespi - fix warning=
s detected by sparse)
Merging crypto-current/master (cf144f81a99d padata: use smp_mb in padata_re=
order to avoid orphaned padata jobs)
Merging ide/master (192f0f8e9db7 Merge tag 'powerpc-5.3-1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (5d6fb560729a dmaengine: ste_dma40: fix unnee=
ded variable warning)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (c7a87ceb17ae mtd: rawnand: sunxi: Add A23/A33 =
DMA support with extra MBUS configuration)
Merging mfd-fixes/for-mfd-fixes (63b2de12b7ee mfd: stmfx: Fix an endian bug=
 in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (22be8233b34f media: videodev2.h: change V4L2_P=
IX_FMT_BGRA444 define: fourcc was already in use)
Merging reset-fixes/reset/fixes (a71dcd3757e2 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (2a15d6481741 MIPS: Annotate fall-through in =
Cavium Octeon code)
Merging at91-fixes/at91-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging omap-fixes/fixes (fb59ee37cfe2 ARM: dts: am57xx: Disable voltage sw=
itching for SD card)
Merging kvm-fixes/master (30cd8604323d KVM: x86: Add fixed counters to PMU =
filter)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (223b2b5030f3 hwmon: (k8temp) documentation: upda=
te URL of datasheet)
Merging nvdimm-fixes/libnvdimm-fixes (a4a357fd4477 Merge branch 'for-5.2/da=
x' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (5560015d7537 Merge branch 'misc-5.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (75f2d86b20bf fs: VALIDATE_FS_PARSER should default=
 to n)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging drivers-x86-fixes/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (e2297f7c3ab3 dt-bindings: pinctrl: stm32=
: Fix missing 'clocks' property in examples)
Merging scsi-fixes/fixes (985eaf99eb18 scsi: target: cxgbit: add support fo=
r IEEE_8021QAZ_APP_SEL_STREAM selector)
Merging drm-fixes/drm-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging amdgpu-fixes/drm-fixes (1bcff32679f6 drm/amdgpu/smu: move fan rpm q=
uery into the asic specific code)
Merging drm-intel-fixes/for-linux-next-fixes (d7e8a19b38c8 drm/i915: Don't =
dereference request if it may have been retired when printing)
CONFLICT (modify/delete): drivers/gpu/drm/i915/intel_context.c deleted in H=
EAD and modified in drm-intel-fixes/for-linux-next-fixes. Version drm-intel=
-fixes/for-linux-next-fixes of drivers/gpu/drm/i915/intel_context.c left in=
 tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_workaro=
unds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
cs.c
$ git rm -f drivers/gpu/drm/i915/intel_context.c
Merging mmc-fixes/fixes (3a6ffb3c8c32 mmc: mmc_spi: Enable stable writes)
Merging rtc-fixes/rtc-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (9be11356057a PCI: pci-hyperv: fix build =
errors on non-SYSFS config)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (0db7f5cd4aeb riscv: mm: Fix code comment)
Merging drm-misc-fixes/for-linux-next-fixes (bbb6fc43f131 drm: silence vari=
able 'conn' set but not used)
Merging kspp-gustavo/for-next/kspp (bc512fd704a9 Makefile: Globally enable =
fall-through warning)
Merging kbuild/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (449fa54d6815 dma-direct: correct the physical=
 addr in dma_direct_sync_sg_for_cpu/device)
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (b7a735f3a606 Merge branch 'for-arm-soc' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging arm-perf/for-next/perf (d482e575fbf0 perf: arm_spe: Enable ACPI/Pla=
tform automatic module loading)
Merging arm-soc/for-next (f1698cc9dde0 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (11343d25a03b Merge branch 'v5.3/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (a1f5c11ddb7d Merge branches 'dt-for-v5.3', 'defcon=
fig-for-v5.3' and 'soc-for-v5.3' into for-next)
Merging at91/at91-next (90fbe456b5f0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (08e3c4158538 ARM: bcm283x: Enable DMA support for=
 SPI controller)
Merging imx-mxs/for-next (2a7f6c1a5376 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (e1b0b32a5ad6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (7376d6a65730 Merge branch 'fixes' into for-next)
Merging qcom/for-next (07c1ef894030 Merge tag 'qcom-dts-for-5.3-2' into ini=
tial-for-5.3)
Merging renesas/next (a16ecb14d0b0 Merge branches 'arm-dt-for-v5.3', 'arm-s=
oc-for-v5.3', 'arm-defconfig-for-v5.3', 'arm64-defconfig-for-v5.3', 'arm64-=
dt-for-v5.3' and 'dt-bindings-for-v5.3' into next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (6cb9edc169e3 Merge branch 'v5.4-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (cf6664323e0f Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (5f9e832c1370 Linus 5.3-rc1)
Merging sunxi/sunxi/for-next (630f3100e19d Merge branch 'sunxi/dt-for-5.4' =
into sunxi/for-next)
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (5f9e832c1370 Linus 5.3-rc1)
Merging clk-samsung/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (9f98b3142d22 csky: Improve string operations perfo=
rmance by glibc code)
CONFLICT (content): Merge conflict in arch/csky/abiv1/strksyms.c
CONFLICT (modify/delete): arch/csky/abiv1/memset.c deleted in HEAD and modi=
fied in csky/linux-next. Version csky/linux-next of arch/csky/abiv1/memset.=
c left in tree.
CONFLICT (content): Merge conflict in arch/csky/abiv1/inc/abi/string.h
Merging h8300/h8300-next (f293d4d4649c h8300: Add missing symbol "BOOT_LINK=
_OFFSET")
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f28a1f16135c m68k: Don't select ARCH_HAS_DMA_PREP_CO=
HERENT for nommu or coldfire)
Merging m68knommu/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (f23478f6ea2e MIPS: qi_lb60: Move MMC configuration =
to devicetree)
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (f017da5c7077 nios2: configs: Remove useless UEVENT_=
HELPER_PATH)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (69245c97560b parisc: Flush ITLB in flush_tlb_al=
l_local() only on split TLB machines)
Merging powerpc/next (5f9e832c1370 Linus 5.3-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (f51edcec5288 MAINTAINERS: Add an entry for generic=
 architecture topology)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (499723d12063 docs: s390: s390dbf: typos and formatti=
ng, update crash command)
Merging sh/sh-next (d3023897b437 arch/sh: Check for kprobe trap number befo=
re trying to handle a kprobe trap)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (b482e48d29f1 um: fix build without CONFIG_UML_TIME_=
TRAVEL_SUPPORT)
Merging xtensa/xtensa-for-next (6326b440055f Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0564336329f0 fscrypt: document testing with xfstest=
s)
Merging afs/afs-next (fb2b827702ba afs: Fix loop index mixup in afs_deliver=
_vl_get_entry_by_name_u())
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (80dfdbfd37d2 Merge branch 'for-next-current-v=
5.2-20190705' into for-next-20190705)
Merging ceph/master (d31d07b97a5e ceph: fix end offset in truncate_inode_pa=
ges_range call)
Merging cifs/for-next (02845e9936f0 cifs: allow chmod to set mode bits usin=
g special sid)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (7451c54abc91 ecryptfs: Change return type of ecryptf=
s_process_flags)
Merging ext3/for_next (5450e8a316a6 Merge tag 'pidfd-updates-v5.3' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging ext4/dev (96fcaf86c3cb ext4: fix coverity warning on error path of =
filename setup)
Merging f2fs/dev (e3110f4526c7 f2fs: fix to read source block before invali=
dating it)
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (d5b9216fd511 pnfs/flexfiles: Add tracepoints for de=
tecting pnfs fallback to MDS)
Merging nfs-anna/linux-next (68f461593f76 NFS/flexfiles: Use the correct TC=
P timeout for flexfiles I/O)
Merging nfsd/nfsd-next (b78fa45d4edb nfsd: Make __get_nfsdfs_client() stati=
c)
Merging orangefs/for-next (e65682b55956 orangefs: eliminate needless variab=
le assignments)
Merging overlayfs/overlayfs-next (0be0bfd2de9d ovl: fix regression caused b=
y overlapping layers detection)
Merging ubifs/linux-next (8009ce956c3d ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (89b408a68b9d Documentation: filesystem: Convert xfs.t=
xt to ReST)
Merging iomap/iomap-for-next (5d907307adc1 iomap: move internal declaration=
s into fs/iomap/)
Merging djw-vfs/vfs-for-next (7e328e5930ad mm/fs: don't allow writes to imm=
utable files)
Merging file-locks/locks-next (6b0e42771795 locks: revise generic_add_lease=
 tracepoint)
Merging vfs/for-next (38760c17cc96 Merge branch 'work.dcache' into for-next)
CONFLICT (content): Merge conflict in fs/ubifs/super.c
CONFLICT (content): Merge conflict in fs/namespace.c
CONFLICT (content): Merge conflict in fs/internal.h
CONFLICT (content): Merge conflict in fs/gfs2/super.c
CONFLICT (content): Merge conflict in fs/ceph/super.c
CONFLICT (modify/delete): Documentation/filesystems/vfs.txt deleted in HEAD=
 and modified in vfs/for-next. Version vfs/for-next of Documentation/filesy=
stems/vfs.txt left in tree.
$ git rm -f Documentation/filesystems/vfs.txt
Applying: docs: filesystems: vfs: update for "vfs: Kill mount_single()"
Merging printk/for-next (ba174ef6d224 Merge branch 'for-5.3-fixes' into for=
-next)
Merging pci/next (7b4b0f6b34d8 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (4c6d80e1144b pstore: Fix double-free in pst=
ore_mkfile() failure path)
Merging hid/for-next (bf4945efabdf Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (9a74c745c689 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (ede2001569c3 i3c: master: Use struct_size() helper)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (9cbd0d64180c hwmon: (adt7475) Convert to =
use hwmon_device_register_with_groups())
Merging jc_docs/docs-next (143134ba4983 doc:it_IT: rephrase statement)
Merging v4l-dvb/master (66193b24514c media: dvbsky: add support for Mygica =
T230C v2)
Applying: media: uapi: new file needs types.h
Merging v4l-dvb-next/master (5f9e832c1370 Linus 5.3-rc1)
Merging fbdev/fbdev-for-next (732146a3f1dc video: fbdev: imxfb: fix a typo =
in imxfb_probe())
Merging pm/linux-next (f76cb066edd1 powercap: Invoke powercap_init() and ra=
pl_init() earlier)
Merging cpufreq-arm/cpufreq/arm/linux-next (3355c91b7939 cpufreq: ap806: Ad=
d NULL check after kcalloc)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (560d1bcad715 opp: Don't use IS_ERR on invalid s=
upplies)
Merging thermal/next (6c395f66e98c drivers: thermal: processor_thermal_devi=
ce: Fix build warning)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (a48f9721e6db dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (dd853b2dfa65 Merge branch 'stable/for-linus-5.2=
' into linux-next)
Merging rdma/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging net-next/master (66b5f1c43984 net-ipv6-ndisc: add support for RFC77=
10 RA Captive Portal Identifier)
Merging bpf-next/master (66b5f1c43984 net-ipv6-ndisc: add support for RFC77=
10 RA Captive Portal Identifier)
Merging ipsec-next/master (c7b37c769d2a xfrm: remove get_mtu indirection fr=
om xfrm_type)
Merging mlx5-next/mlx5-next (5f9e832c1370 Linus 5.3-rc1)
Merging netfilter-next/master (192f0f8e9db7 Merge tag 'powerpc-5.3-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (5adcdab6ae1b Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (0ed8a186eaff Bluetooth: hidp: Let hidp_send_messa=
ge return number of queued bytes)
Merging mac80211-next/master (17c74d7c5f0d nl80211: fix VENDOR_CMD_RAW_DATA)
Merging gfs2/for-next (bb4cb25dd319 gfs2: Remove unused gfs2_iomap_alloc ar=
gument)
Merging mtd/mtd/next (46ce10df799f Merge tag 'spi-nor/for-5.3-v2' of gitoli=
te.kernel.org:pub/scm/linux/kernel/git/mtd/linux into mtd/next)
Merging nand/nand/next (bce9437a0a48 mtd: rawnand: stm32_fmc2: increase DMA=
 completion timeouts)
Merging spi-nor/spi-nor/next (5f9e832c1370 Linus 5.3-rc1)
Merging crypto/master (f3880a23564e crypto: stm32/hash - remove interruptib=
le condition for dma)
Merging drm/drm-next (8ee795625665 Merge branch 'linux-5.3' of git://github=
.com/skeggsb/linux into drm-next)
Merging amdgpu/drm-next (0e738e03472a drm/amdkfd/kfd_mqd_manager_v10: Avoid=
 fall-through warning)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/navi10_=
ppt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn20/=
dcn20_hwseq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_stream.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/clk_mg=
r/dcn20/dcn20_clk_mgr.c
Merging drm-intel/for-linux-next (3bdd4f848531 drm/i915: Rely on spinlock p=
rotection for GPU error capture)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_workaro=
unds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (d808097627e5 drm/i915: Fix up broken merge)
Merging drm-msm/msm-next (4cf643a39221 Merge tag 'drm-next-5.3-2019-06-27' =
of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (4cf643a39221 Merge tag 'drm-next-5.3-=
2019-06-27' of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging imx-drm/imx-drm/next (fee77829083a gpu: ipu-v3: image-convert: Enab=
le double write reduction)
Merging etnaviv/etnaviv/next (57bdd4057516 drm/etnaviv: Use devm_platform_i=
oremap_resource())
Merging regmap/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging sound/for-next (d2d5a6b0253d ALSA: firewire-motu: more code refacto=
ring for MOTU data block processing layer)
Merging sound-asoc/for-next (b6319b061ba2 ASoC: sgtl5000: Fix charge pump s=
ource assignment)
Merging modules/modules-next (93651f80dcb6 modules: fix compile error if do=
n't have strict module rwx)
Merging input/next (5d4b45a1dd7b Input: add support for the FlySky FS-iA6B =
RC receiver)
Merging block/for-next (5b9ddbdf2f36 Merge branch 'for-linus' into for-next)
Merging device-mapper/for-next (733232f8c852 dm: use printk ratelimiting fu=
nctions)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (248979babbd8 Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (7efd105c27fd mfd: hi655x-pmic: Fix missing return=
 value check for devm_regmap_init_mmio_clk)
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
Merging battery/for-next (caa2b557841c power: reset: nvmem-reboot-mode: add=
 CONFIG_OF dependency)
Merging regulator/for-next (bf8211f74935 Merge branch 'regulator-5.4' into =
regulator-next)
Merging security/next-testing (286e47a07799 Merge branch 'next-lsm' into ne=
xt-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (650b29dbdf2c integrity: Introduce struct =
evm_xattr)
Merging keys/keys-next (20adf5593389 Merge tag 'keys-acl-20190703' into key=
s-next)
Merging selinux/next (ea74a685ad81 selinux: format all invalid context as u=
ntrusted)
Merging tpmdd/next (166a2809d65b tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (7fb832ae7294 watchdog: digicolor_wdt: Remove unuse=
d variable in dc_wdt_probe)
Merging iommu/next (d95c3885865b Merge branches 'x86/vt-d', 'x86/amd', 'arm=
/smmu', 'arm/omap', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (1e4d09d2212d mdev: Send uevents around parent device reg=
istration)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (f59d261180f3 dt-bindings: vendor-prefixes: add=
 Sipeed)
Merging mailbox/mailbox-for-next (25777e5784a7 mailbox: handle failed named=
 mailbox channel request)
Merging spi/for-next (87ce8c22d3b5 Merge branch 'spi-5.4' into spi-next)
Merging tip/auto-latest (5f9e832c1370 Linus 5.3-rc1)
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging irqchip/irq/irqchip-next (3dae67ce600c irqchip/gic-pm: Remove PM_CL=
K dependency)
Merging ftrace/for-next (6d54ceb539aa tracing: Fix user stack trace "??" ou=
tput)
Merging rcu/rcu/next (b989ff070574 Merge LKMM and RCU commits)
Merging kvm/linux-next (30cd8604323d KVM: x86: Add fixed counters to PMU fi=
lter)
Merging kvm-arm/next (1e0cf16cdad1 KVM: arm/arm64: Initialise host's MPIDRs=
 by reading the actual register)
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
Merging xen-tip/linux-next (a1078e821b60 xen: let alloc_xenballooned_pages(=
) fail if not enough memory free)
Merging percpu/for-next (03ed70fb0e5e Merge branch 'for-5.3' into for-next)
Merging workqueues/for-next (be69d00d9769 workqueue: Remove GPF argument fr=
om alloc_workqueue_attrs())
Merging drivers-x86/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging chrome-platform/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (60439711b69b leds: apu: add pr_fmt prefix for better=
 log output)
Merging ipmi/for-next (fec88ab0af97 Merge tag 'for-linus-hmm' of git://git.=
kernel.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging driver-core/driver-core-next (5f9e832c1370 Linus 5.3-rc1)
Merging usb/usb-next (5f9e832c1370 Linus 5.3-rc1)
Merging usb-gadget/next (b2357839c56a usb: renesas_usbhs: add a workaround =
for a race condition of workqueue)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (520602640419 phy: qcom-qmp: Raise qcom_qmp_phy_enabl=
e() polling delay)
Merging tty/tty-next (5f9e832c1370 Linus 5.3-rc1)
Merging char-misc/char-misc-next (5f9e832c1370 Linus 5.3-rc1)
Merging extcon/extcon-next (0937fbb7abeb extcon: fsa9480: Fix Kconfig warni=
ng and build errors)
Merging soundwire/next (5f9e832c1370 Linus 5.3-rc1)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (5f9e832c1370 Linus 5.3-rc1)
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (72503b25ee36 dmaengine: bcm2835: Print error in cas=
e setting DMA mask fails)
Merging cgroup/for-next (22a0b83583ab Merge branch 'for-5.3' into for-next)
Merging scsi/for-next (07d9aa143464 scsi: megaraid_sas: set an unlimited ma=
x_segment_size)
Merging scsi-mkp/for-next (838c1efc6a0a scsi: ufs: change msleep to usleep_=
range)
Merging vhost/linux-next (842aa64eddac vhost: fix WARNING in __mmdrop)
Merging rpmsg/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging gpio/for-next (88785b7fa74a Merge tag 'gpio-v5.3-rc1-fixes-for-linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into fixes)
Merging gpio-brgl/gpio/for-next (66ad66293ede gpio: em: use a helper variab=
le for &pdev->dev)
Merging pinctrl/for-next (4c105769bf6d pinctrl: aspeed: Strip moved macros =
and structs from private header)
Merging pinctrl-samsung/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging pwm/for-next (3d25025ce9c2 pwm: fsl-ftm: Make sure to unlock mutex =
on failure)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2bls)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (ee8a84c60bcc rseq/selftests: Fix Thumb mode build f=
ailure on arm32)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (28f28ea4343a Merge branch 'for-5.3-core' int=
o for-next)
Merging coresight/next (70d4c349268a coresight: cpu-debug: Add support for =
Qualcomm Kryo)
Merging rtc/rtc-next (06c8e550a84e rtc: s5m: convert to i2c_new_dummy_devic=
e)
Merging nvdimm/libnvdimm-for-next (cb3110f7452d Merge branch 'for-5.3/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (10742fee98eb eeprom: at24: remove unneeded incl=
ude)
Merging ntb/ntb-next (5f9e832c1370 Linus 5.3-rc1)
Merging kspp/for-next/kspp (2dcbe7fe2265 lib/test_stackinit: Handle Clang a=
uto-initialization pattern)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (f2c7c76c5d0a Linux 5.2-rc3)
Merging fsi/next (371975b0b075 fsi/core: Fix error paths on CFAM init)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging nvmem/for-next (341f8ae0f820 dt-bindings: nvmem: SID: Fix the examp=
les node names)
CONFLICT (content): Merge conflict in drivers/nvmem/meson-mx-efuse.c
CONFLICT (content): Merge conflict in drivers/nvmem/meson-efuse.c
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/nvm=
em/allwinner,sun4i-a10-sid.yaml
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/freescale/fsl,scu.txt
Merging xarray/xarray (91abab83839a XArray: Fix xas_next() with a single en=
try at 0)
Merging hyperv/hyperv-next (765e33f5211a Drivers: hv: vmbus: Break out ISA =
independent parts of mshyperv.h)
Merging auxdisplay/auxdisplay (f4bb1f895aa0 auxdisplay/ht16k33.c: Convert t=
o use vm_map_pages_zero())
Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler w=
arning)
Merging pidfd/for-next (4382fc438ca5 Merge branch 'clone' into for-next)
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/xtensa/kernel/syscalls/syscall.t=
bl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
CONFLICT (content): Merge conflict in arch/microblaze/kernel/syscalls/sysca=
ll.tbl
CONFLICT (content): Merge conflict in arch/arm64/include/asm/unistd32.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/unistd.h
CONFLICT (content): Merge conflict in arch/arm/tools/syscall.tbl
Merging devfreq/for-next (27c17be8e488 PM / devfreq: tegra20: add COMMON_CL=
K dependency)
Merging hmm/hmm (5f9e832c1370 Linus 5.3-rc1)
Merging akpm-current/current (eb5b38e7b494 ipc/msg.c: consolidate all xxxct=
l_down() functions)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (c504c313f8ec drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/bzXFr37XtX=2bGbbLFa0Qfi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl02i9MACgkQAVBC80lX
0GzrRAf+O0LvEPdGxORNEdk0l99h3rRUNW1NdbZa+5df83XKIAPYpqyqrJ/Cqnda
7PWxdXxznYD4bExyVQkUhaddP4YgNWTwb6V3XmKNgQGbXCrP6tdOX612rRJX0wY/
OmJJfTW5+q7MS35ltzNi5/GZHtPckspq8RXQyEbGcYWsBbUtWT0/u5xyanumn1nj
kh257PszdjnGGSMoOtnHaUSGN6iNn/SO80LeSuncpdTqNns6+/YrF5e+mXbl1SaF
aQ+uKU/EorJ+odH11bPDEs45BoB9Hkw/p/gYzHol7nThAsA/MbWneeimEj97GRnx
v62pI5iTX4Y9roQdPkzZQ4TbvAP3Rg==
=0MXw
-----END PGP SIGNATURE-----

--Sig_/bzXFr37XtX=2bGbbLFa0Qfi--
