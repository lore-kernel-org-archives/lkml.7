Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77143C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2896F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 04:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AGGi5qpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfG2E63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 00:58:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfG2E62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 00:58:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xnWf3yX6z9s7T;
        Mon, 29 Jul 2019 14:58:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564376302;
        bh=cH9fNaxpGvw0ytHIMLWKDLFJV//I4CeFlzeG9bjMbSE=;
        h=Date:From:To:Cc:Subject:From;
        b=AGGi5qpVxczgKvxPc9WbsdJdHa+YPpuYqNKB/i9lpow2Fzo11mbQKiqNdmyjTHIOU
         3H61YMRvDKBhdC2sb5vscPESeBAjdltwsl5yiIxE3bf+5wFCAM6jmJ833pQ/RYHXnC
         Pzl5ho3thFpKXf1DCexj+z/eG7162N4zDouwFmvfNtUyFCPLcCCs3IGUEBWEGiGR7M
         sHzcTLcC2uxRAy167O9zKA5fOVin2X1QRqDubsZ0STh8QCFBkRrsjA8za3LKpEpGB0
         PkuTNq9Xow3a5XT9h8HhUXjM/EK9xBlFYSzxIuNTwxzgIJz6RwbJ+S2AzgkFSC9XZV
         uD6uD1JI8uciw==
Date:   Mon, 29 Jul 2019 14:58:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 29
Message-ID: <20190729145821.44114d3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sz/NYnBkeucxjbObBW5_H0Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sz/NYnBkeucxjbObBW5_H0Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190726:

The sh tree gained a conflict against Linus' tree.

The tip tree gained a conflict against Linus' tree.

I remerged the kspp-gustavo tree later to get some warning fixes.

The akpm-current tree lost its build failure.

Non-merge commits (relative to Linus' tree): 2571
 2915 files changed, 181840 insertions(+), 73157 deletions(-)

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

I am currently merging 301 trees (counting Linus' and 72 trees of bug
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
Merging origin/master (609488bc979f Linux 5.3-rc2)
Merging fixes/master (c309b6f24222 Merge tag 'docs/v5.3-1' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
Merging kbuild-current/fixes (b25e8a23d4ea kbuild: remove unused single-use=
d-m)
Merging arc-current/for-curr (24a20b0a443f ARC: [plat-hsdk]: Enable AXI DW =
DMAC in defconfig)
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (7bd9d465140a Merge tag 'imx-fixes-5.3' of =
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes)
Merging arm64-fixes/for-next/fixes (5a46d3f71d5e ACPI/IORT: Fix off-by-one =
check in iort_dev_find_its_id())
Merging m68k-current/for-linus (f28a1f16135c m68k: Don't select ARCH_HAS_DM=
A_PREP_COHERENT for nommu or coldfire)
Merging powerpc-fixes/fixes (3a855b7ac7d5 powerpc/papr_scm: Force a scm-unb=
ind if initial scm-bind fails)
Merging s390-fixes/fixes (98abe0227827 MAINTAINERS: vfio-ccw: Remove myself=
 as the maintainer)
Merging sparc/master (038029c03e21 sparc: remove unneeded uapi/asm/statfs.h)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (003bd5b4a7b4 r8169: don't use MSI before RTL8168d)
Merging bpf/master (5d01ab7bac46 libbpf: fix erroneous multi-closing of BTF=
 FD)
Merging ipsec/master (22d6552f827e xfrm interface: fix management of phydev)
Merging netfilter/master (67d86835840a netfilter: nft_meta_bridge: Eliminat=
e 'out' label)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (5f9e832c1370 Linus 5.3-rc1)
Merging mac80211/master (e6f4051123fd {nl,mac}80211: fix interface combinat=
ions on crypto controlled devices)
Merging rdma-fixes/for-rc (b7165bd0d6cb IB/mlx5: Fix RSS Toeplitz setup to =
be aligned with the HW specification)
Merging sound-current/for-linus (74bf71ed792a ALSA: hda: Fix 1-minute detec=
tion delay when i915 module is not available)
Merging sound-asoc-fixes/for-linus (3a03327120de Merge branch 'asoc-5.3' in=
to asoc-linus)
Merging regmap-fixes/for-linus (5f9e832c1370 Linus 5.3-rc1)
Merging regulator-fixes/for-linus (a853c0a0b013 regulator: lp87565: Fix pro=
be failure for "ti,lp87565")
Merging spi-fixes/for-linus (d24f33303ad1 Merge branch 'spi-5.3' into spi-l=
inus)
Merging pci-current/for-linus (5f9e832c1370 Linus 5.3-rc1)
Merging driver-core.current/driver-core-linus (5f9e832c1370 Linus 5.3-rc1)
Merging tty.current/tty-linus (61d51456f357 vt: Grab console_lock around co=
n_is_bound in show_bind)
Merging usb.current/usb-linus (d39b5bad8658 xhci: Fix crash if scatter gath=
er is used with Immediate Data Transfer (IDT).)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (f8377eff5481 USB: serial: ftdi_sio: add=
 ID for isodebug v1)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (09f6109ff4f8 Merge tag 'iio-fixes-fo=
r-5.3a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into sta=
ging-linus)
Merging char-misc.current/char-misc-linus (d4fddac5a51c test_firmware: fix =
a memory leak bug)
Merging soundwire-fixes/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging thunderbolt-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging input-current/for-linus (25f8c834e2a6 Input: synaptics - enable RMI=
 mode for HP Spectre X360)
Merging crypto-current/master (cf144f81a99d padata: use smp_mb in padata_re=
order to avoid orphaned padata jobs)
Merging ide/master (baf6722aa0cb ide: Use dev_get_drvdata where possible)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (527d37e9e575 selftests/livepatch: add test s=
kip handling)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d105ef8120dd dmaengine: tegra210-adma: Fix u=
nused function warnings)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (5f9e832c1370 Linus 5.3-rc1)
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
Merging nvdimm-fixes/libnvdimm-fixes (87a30e1f05d7 driver-core, libnvdimm: =
Let device subsystems add local lockdep coverage)
Merging btrfs-fixes/next-fixes (af5a46b43a56 Merge branch 'misc-5.3' into n=
ext-fixes)
Merging vfs-fixes/fixes (a53abf2c5bd0 Unbreak mount_capable())
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging drivers-x86-fixes/fixes (66013e8ec685 platform/x86: intel_pmc_core:=
 Add ICL-NNPI support to PMC Core)
Merging samsung-krzk-fixes/fixes (5f9e832c1370 Linus 5.3-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5f9e832c1370 Linus 5.3-rc1)
Merging devicetree-fixes/dt/linus (e1ff7390f58e dt-bindings: Fix more $id v=
alue mismatches filenames)
Merging scsi-fixes/fixes (20122994e38a scsi: scsi_dh_alua: always use a 2 s=
econd delay before retrying RTPG)
Merging drm-fixes/drm-fixes (4d5308e78527 Merge tag 'drm-fixes-5.3-2019-07-=
24' of git://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (92e6475ae0a0 drm/amd/display: Set enabled t=
o false at start of audio disable)
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
Merging risc-v-fixes/fixes (2f0f80fd9227 riscv: defconfig: align RV64 defco=
nfig to the output of "make savedefconfig")
Merging drm-misc-fixes/for-linux-next-fixes (bbb6fc43f131 drm: silence vari=
able 'conn' set but not used)
Merging kspp-gustavo/for-next/kspp (609488bc979f Linux 5.3-rc2)
Merging kbuild/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (ad3c7b18c5b3 arm: use swiotlb for bounce buff=
ering on LPAE configs)
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (b7a735f3a606 Merge branch 'for-arm-soc' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging arm-perf/for-next/perf (ca786b8db751 arm64: perf: Remove unused mac=
ro)
Merging arm-soc/for-next (1439dbf17e9e Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (7671b33bcaa8 Merge branch 'v5.3/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (caec3f63d83f Merge branches 'dt-for-v5.4' and 'def=
config-for-v5.4' into for-next)
Merging at91/at91-next (90fbe456b5f0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (f83e5000db15 Merge branch 'bcm2835-dt-next' into =
for-next)
Merging imx-mxs/for-next (1596861583cb Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (78145dbeaea1 Merge branch 'for_5.3/driver-soc' into =
next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (e1b0b32a5ad6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (7376d6a65730 Merge branch 'fixes' into for-next)
Merging qcom/for-next (9f407b8ad181 Merge branches 'arm64-for-5.4' and 'dri=
vers-for-5.3' into for-next)
Merging renesas/next (a16ecb14d0b0 Merge branches 'arm-dt-for-v5.3', 'arm-s=
oc-for-v5.3', 'arm-defconfig-for-v5.3', 'arm64-defconfig-for-v5.3', 'arm64-=
dt-for-v5.3' and 'dt-bindings-for-v5.3' into next)
Merging reset/reset/next (6b251ea99242 dt-bindings: reset: imx7: Fix the sp=
elling of 'indices')
CONFLICT (content): Merge conflict in drivers/reset/reset-simple.c
Merging rockchip/for-next (55d674eec75b Merge branch 'v5.4-armsoc/dts32' in=
to for-next)
Merging samsung-krzk/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging scmi/for-linux-next (5f9e832c1370 Linus 5.3-rc1)
Merging sunxi/sunxi/for-next (b184e1e79e6d Merge branches 'sunxi/config64-f=
or-5.4' and 'sunxi/dt-for-5.4' into sunxi/for-next)
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (03d7036efa4a Merge branch 'clk-fixes' into clk-next)
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
Merging h8300/h8300-next (a5de8865cb3e h8300: move definition of __kernel_s=
ize_t etc. to posix_types.h)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f28a1f16135c m68k: Don't select ARCH_HAS_DMA_PREP_CO=
HERENT for nommu or coldfire)
Merging m68knommu/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (cdab7e2c73d5 mips: vdso: Fix flip/flop vdso buildin=
g bug)
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (f017da5c7077 nios2: configs: Remove useless UEVENT_=
HELPER_PATH)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (989c786e3f18 parisc: rename default_defconfig t=
o defconfig)
Merging powerpc/next (5f9e832c1370 Linus 5.3-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (f51edcec5288 MAINTAINERS: Add an entry for generic=
 architecture topology)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (5f9e832c1370 Linus 5.3-rc1)
Merging sh/sh-next (cd10afbc932d sh: remove unneeded uapi asm-generic wrapp=
ers)
CONFLICT (modify/delete): arch/sh/include/uapi/asm/types.h deleted in sh/sh=
-next and modified in HEAD. Version HEAD of arch/sh/include/uapi/asm/types.=
h left in tree.
CONFLICT (modify/delete): arch/sh/include/uapi/asm/setup.h deleted in sh/sh=
-next and modified in HEAD. Version HEAD of arch/sh/include/uapi/asm/setup.=
h left in tree.
$ git rm -f arch/sh/include/uapi/asm/setup.h arch/sh/include/uapi/asm/types=
.h
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging uml/linux-next (b482e48d29f1 um: fix build without CONFIG_UML_TIME_=
TRAVEL_SUPPORT)
Merging xtensa/xtensa-for-next (1386dcaa9226 Merge branch 'xtensa-5.3' into=
 xtensa-for-next)
Merging fscrypt/master (0564336329f0 fscrypt: document testing with xfstest=
s)
Merging afs/afs-next (579cb95f6d3a afs: Support RCU pathwalk)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (80dfdbfd37d2 Merge branch 'for-next-current-v=
5.2-20190705' into for-next-20190705)
Merging ceph/master (d31d07b97a5e ceph: fix end offset in truncate_inode_pa=
ges_range call)
Merging cifs/for-next (ee7340d63f98 smb3: add missing flag definitions)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (7451c54abc91 ecryptfs: Change return type of ecryptf=
s_process_flags)
Merging ext3/for_next (5450e8a316a6 Merge tag 'pidfd-updates-v5.3' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging ext4/dev (96fcaf86c3cb ext4: fix coverity warning on error path of =
filename setup)
Merging f2fs/dev (543b8c468f55 f2fs: fix to read source block before invali=
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
Merging file-locks/locks-next (43e4cb942e88 locks: Fix procfs output for fi=
le leases)
Merging vfs/for-next (dad5ea4bac62 ceph_real_mount(): missing initializatio=
n)
CONFLICT (content): Merge conflict in fs/ubifs/super.c
CONFLICT (content): Merge conflict in fs/gfs2/super.c
CONFLICT (content): Merge conflict in fs/ceph/super.c
CONFLICT (modify/delete): Documentation/filesystems/vfs.txt deleted in HEAD=
 and modified in vfs/for-next. Version vfs/for-next of Documentation/filesy=
stems/vfs.txt left in tree.
$ git rm -f Documentation/filesystems/vfs.txt
Applying: docs: filesystems: vfs: update for "vfs: Kill mount_single()"
Merging printk/for-next (ba174ef6d224 Merge branch 'for-5.3-fixes' into for=
-next)
Merging pci/next (5f9e832c1370 Linus 5.3-rc1)
Merging pstore/for-next/pstore (4c6d80e1144b pstore: Fix double-free in pst=
ore_mkfile() failure path)
Merging hid/for-next (bf4945efabdf Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (9a74c745c689 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (934d24a5e150 i3c: move i3c_device_match_id to device.=
c and export it)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (a41c6eb90457 hwmon: (acpi_power_meter) Ch=
ange log level for 'unsafe software power cap')
Merging jc_docs/docs-next (32630d526b9f MAINTAINERS: add entries for some d=
ocumentation scripts)
Merging v4l-dvb/master (a8f910ec6658 media: v4l2-core: Cleanup Makefile)
Merging v4l-dvb-next/master (5f9e832c1370 Linus 5.3-rc1)
Merging fbdev/fbdev-for-next (732146a3f1dc video: fbdev: imxfb: fix a typo =
in imxfb_probe())
Merging pm/linux-next (28d0e69ea0fa Merge branch 'pm-sleep' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (fc7d8233c794 Merge branch 'cpuf=
req/qcom-updates' into cpufreq/arm/linux-next)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (0203c0343a1f Merge branch 'opp/qcom-updates' in=
to opp/linux-next)
Merging thermal/next (d093f91ff7d0 Merge branch 'for-rc' into next)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (a48f9721e6db dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (4cdfb27ba80d xen/swiotlb: remember having calle=
d xen_create_contiguous_region())
Merging rdma/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging net-next/master (dda91bd7abb0 Merge branch 'mlxsw-spectrum_acl-Forb=
id-unsupported-filters')
CONFLICT (content): Merge conflict in drivers/net/can/flexcan.c
CONFLICT (content): Merge conflict in Documentation/PCI/pci-error-recovery.=
rst
Merging bpf-next/master (475e31f8da1b Merge branch 'revamp-test_progs')
Merging ipsec-next/master (c7b37c769d2a xfrm: remove get_mtu indirection fr=
om xfrm_type)
Merging mlx5-next/mlx5-next (5f9e832c1370 Linus 5.3-rc1)
Merging netfilter-next/master (9eed21c01c78 mlx4: avoid large stack usage i=
n mlx4_init_hca())
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
CONFLICT (content): Merge conflict in drivers/nfc/st21nfca/se.c
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (15e830e90fde mwifiex: use eth_broadca=
st_addr() to assign broadcast address)
Merging bluetooth/master (fa9ccaf84f5d Bluetooth: hidp: Let hidp_send_messa=
ge return number of queued bytes)
Merging mac80211-next/master (ae6fa4d5e94e nl80211: Include wiphy address s=
etup in NEW_WIPHY)
Merging gfs2/for-next (5d69e57fa9cc gfs2: Minor gfs2_alloc_inode cleanup)
Merging mtd/mtd/next (5f9e832c1370 Linus 5.3-rc1)
Merging nand/nand/next (1670e678a8a7 mtd: rawnand: ingenic: Add of_node_put=
() before return)
Merging spi-nor/spi-nor/next (5f9e832c1370 Linus 5.3-rc1)
Merging crypto/master (8dfa20fcfbeb crypto: ghash - add comment and improve=
 help text)
Merging drm/drm-next (5f9e832c1370 Linus 5.3-rc1)
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
Merging drm-intel/for-linux-next (62336cc666b0 drm/i915/uc: Fixup kerneldoc=
 after params were flipped and renamed)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_workaro=
unds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
Merging drm-tegra/drm/tegra/for-next (2a6fc3cb5cb6 drm/tegra: Fix gpiod_get=
_from_of_node() regression)
Merging drm-misc/for-linux-next (63b87c310a83 drm/mst: Fix sphinx warnings =
in drm_dp_msg_connector register functions)
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
Merging sound/for-next (9e4d5c1be21f ALSA: usb-audio: Scarlett Gen 2 mixer =
interface)
Merging sound-asoc/for-next (33854feb1faa Merge branch 'asoc-5.4' into asoc=
-next)
Merging modules/modules-next (5f9e832c1370 Linus 5.3-rc1)
Merging input/next (c394159310d0 Input: soc_button_array - add support for =
newer surface devices)
Merging block/for-next (5b9ddbdf2f36 Merge branch 'for-linus' into for-next)
Merging device-mapper/for-next (733232f8c852 dm: use printk ratelimiting fu=
nctions)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (979f97f2771b mmc: host: sdhci: Fix the incorrect soft res=
et operation when runtime resuming)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (b5e29aa880be mfd: davinci_voicecodec: Remove poin=
tless #include)
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
Merging battery/for-next (caa2b557841c power: reset: nvmem-reboot-mode: add=
 CONFIG_OF dependency)
Merging regulator/for-next (43b84b2883b1 Merge branch 'regulator-5.4' into =
regulator-next)
Merging security/next-testing (286e47a07799 Merge branch 'next-lsm' into ne=
xt-testing)
Merging apparmor/apparmor-next (136db994852a apparmor: increase left match =
history buffer size)
Merging integrity/next-integrity (650b29dbdf2c integrity: Introduce struct =
evm_xattr)
Merging keys/keys-next (8cf8684e0d24 Merge branch 'keys-acl' into keys-next)
CONFLICT (content): Merge conflict in include/linux/key.h
CONFLICT (content): Merge conflict in fs/afs/security.c
Merging selinux/next (5f9e832c1370 Linus 5.3-rc1)
Merging tpmdd/next (166a2809d65b tpm: Don't duplicate events from the final=
 event log in the TCG2 log)
Merging watchdog/master (a18670f4617d watchdog: ath79_wdt: fix a typo in th=
e name of a function)
Merging iommu/next (66929812955b iommu/amd: Add support for X2APIC IOMMU in=
terrupts)
Merging vfio/next (1e4d09d2212d mdev: Send uevents around parent device reg=
istration)
Merging audit/next (5f9e832c1370 Linus 5.3-rc1)
Merging devicetree/for-next (470062c40eaa dt-bindings: crypto: Convert Allw=
inner A10 Security Engine to a schema)
Merging mailbox/mailbox-for-next (25777e5784a7 mailbox: handle failed named=
 mailbox channel request)
Merging spi/for-next (1bda625684d2 Merge branch 'spi-5.4' into spi-next)
Merging tip/auto-latest (397d428ddd0f Merge branch 'locking/core')
CONFLICT (modify/delete): arch/x86/include/uapi/asm/types.h deleted in tip/=
auto-latest and modified in HEAD. Version HEAD of arch/x86/include/uapi/asm=
/types.h left in tree.
$ git rm -f arch/x86/include/uapi/asm/types.h
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac/edac-for-next (3123c5c4ca15 edac: altera: Move Stratix10 SDRAM=
 ECC to peripheral)
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
Merging leds/for-next (246eab59eefc leds: lm3697: Switch to use fwnode_prop=
erty_count_uXX())
Merging ipmi/for-next (fec88ab0af97 Merge tag 'for-linus-hmm' of git://git.=
kernel.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging driver-core/driver-core-next (bbe70e4e4211 fs: kernfs: Fix possible=
 null-pointer dereferences in kernfs_path_from_node_locked())
Merging usb/usb-next (6389a62ff798 usbip: tools: fix GCC8 warning for strnc=
py)
Merging usb-gadget/next (b2357839c56a usb: renesas_usbhs: add a workaround =
for a race condition of workqueue)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (520602640419 phy: qcom-qmp: Raise qcom_qmp_phy_enabl=
e() polling delay)
Merging tty/tty-next (67de843e3158 serial/8250: Add support for NI-Serial P=
XI/PXIe+485 devices)
Merging char-misc/char-misc-next (41db5f8397ee misc: fastrpc: fix memory le=
ak when out of memory)
Merging extcon/extcon-next (21be848ebc5f extcon: axp288: Use for_each_set_b=
it() in axp288_extcon_log_rsi())
Merging soundwire/next (5f9e832c1370 Linus 5.3-rc1)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (e59fc5252911 staging: rtl8192*: display ESSID=
s using %pE)
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (f4c255f1a747 dmaengine: dma-jz4780: Break descripto=
r chains on JZ4740)
Merging cgroup/for-next (a581563f1bef cgroup: minor tweak for logic to get =
cgroup css)
Merging scsi/for-next (20122994e38a scsi: scsi_dh_alua: always use a 2 seco=
nd delay before retrying RTPG)
Merging scsi-mkp/for-next (838c1efc6a0a scsi: ufs: change msleep to usleep_=
range)
Merging vhost/linux-next (73f628ec9e6b vhost: disable metadata prefetch opt=
imization)
Merging rpmsg/for-next (7f1345e9efcc Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (88785b7fa74a Merge tag 'gpio-v5.3-rc1-fixes-for-linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into fixes)
Merging gpio-brgl/gpio/for-next (66ad66293ede gpio: em: use a helper variab=
le for &pdev->dev)
Merging pinctrl/for-next (4c105769bf6d pinctrl: aspeed: Strip moved macros =
and structs from private header)
Merging pinctrl-samsung/for-next (5f9e832c1370 Linus 5.3-rc1)
Merging pwm/for-next (3d25025ce9c2 pwm: fsl-ftm: Make sure to unlock mutex =
on failure)
Merging userns/for-next (318759b4737c signal/x86: Move tsk inside of CONFIG=
_MEMORY_FAILURE in do_sigbus)
Merging ktest/for-next (aecea57f84b0 ktest: Fix some typos in config-bisect=
.pl)
Merging random/dev (58be0106c530 random: fix soft lockup when trying to rea=
d from an uninitialized blocking pool)
Merging kselftest/next (5f9e832c1370 Linus 5.3-rc1)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
CONFLICT (content): Merge conflict in arch/riscv/include/uapi/asm/unistd.h
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
Merging hmm/hmm (cc374377a19d mm/hmm: remove hmm_range vma)
Merging fpga/for-next (7d62460b4060 MAINTAINERS: Move linux-fpga tree to ne=
w location)
Merging kspp-gustavo/for-next/kspp (d167a4566175 net: spider_net: Mark expe=
cted switch fall-through)
Merging akpm-current/current (2d8c3d2fb959 ipc/msg.c: consolidate all xxxct=
l_down() functions)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: mm: treewide: clarify pgtable_page_{ctor,dtor}() naming
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (60e47d61fcf1 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/sz/NYnBkeucxjbObBW5_H0Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+fO0ACgkQAVBC80lX
0GzdRggAgZuT6VmGAaBBL4hi7x7178qHL2144CY/8IcwCxj0nN3g1LgJJPDw5dAP
y1aPotwetpW7EambOZF/jN3DhfSeG5gi43iMcJ/scigqO/MBU5GXObhjB1dz5Xhv
zuMt129XOAE7nIdSzXHmGtOEHAGivVazg1Rz2lnd0a3njg48ofl+bqRvbr2AVCvq
lRBGu/onN6WWuphR+C+kStdFtlu9rUfpwFtH1CjEVAozzxfM9a8IzylfgvZRU3+5
w/0DoXGJEU/Gnggfw3GJDEMlrH6lF9a8/YsM67y+aSgguTRL14A1n/7kJFFCgpmN
chIBnVZXN55kckmQJVPp07FsI2H/oQ==
=iPEz
-----END PGP SIGNATURE-----

--Sig_/sz/NYnBkeucxjbObBW5_H0Y--
