Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54ADC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229D216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YpHCklgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfGLGbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:31:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfGLGbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:31:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lNNy4kpKz9sBF;
        Fri, 12 Jul 2019 16:31:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562913090;
        bh=6N4AbSGwqEV6jLOriiC5W3mEtC+x4JgeKTbf7C2Jtro=;
        h=Date:From:To:Cc:Subject:From;
        b=YpHCklgprmVWX+YNLMfVhA2A0pJQ78BZhGoJLlnUNJ0bAMIlFNECepeNZIF0qi5CA
         Yvylrx2MC5h6yoaib3tr3kC4FgqMWabwLey7hfRRaPwaRM40u3EIFYl95yZYsnHBEo
         8unZAou0gmwGgwg7p2VWxuDEVjcBpPr47i5AqTsnZ1jW/D9FOS2sfajZ0EBADofbN6
         m20/zMrs2e7+ZX7Rj2EcQXbIZw4ehVeiQ3w9Ad4QlXci8YjSAY3LZMjkTYE7+mLBAv
         8ZolcNiuPY1lerVgjDqrA+pFuEa+g8D5U3cM2ge348p/GlKuZTLq1GJJK3rUApSOpi
         85vx52e8Ioh7w==
Date:   Fri, 12 Jul 2019 16:31:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 12
Message-ID: <20190712163129.57a36192@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3zR2wgvTf9jHVJ1oN5zUwkJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3zR2wgvTf9jHVJ1oN5zUwkJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add v5.4 material to your linux-next included branches
until after v5.3-rc1 has been released.

Changes since 20190711:

The block tree gained build failures due to an interaction with the
f2fs and xfs trees for which I applied merge fix patches.

Non-merge commits (relative to Linus' tree): 6135
 5497 files changed, 639039 insertions(+), 131609 deletions(-)

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
Merging origin/master (753c8d9b7d81 Merge branch 'x86-urgent-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (3ab4436f688c Merge tag 'nfsd-5.2-1' of git://linux-nf=
s.org/~bfields/linux)
Merging kspp-gustavo/for-next/kspp (d93512ef0f0e Makefile: Globally enable =
fall-through warning)
Merging kbuild-current/fixes (d1fdb6d8f6a4 Linux 5.2-rc4)
Merging arc-current/for-curr (24a20b0a443f ARC: [plat-hsdk]: Enable AXI DW =
DMAC in defconfig)
CONFLICT (content): Merge conflict in arch/arc/mm/fault.c
Merging arm-current/fixes (c5d0e49e8d8f ARM: 8867/1: vdso: pass --be8 to li=
nker if necessary)
Merging arm-soc-fixes/arm/fixes (2659dc8d225c Merge tag 'davinci-fixes-for-=
v5.2-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-=
davinci into arm/fixes)
Merging arm64-fixes/for-next/fixes (aa69fb62bea1 arm64/efi: Mark __efistub_=
stext_offset as an absolute symbol explicitly)
Merging m68k-current/for-linus (f28a1f16135c m68k: Don't select ARCH_HAS_DM=
A_PREP_COHERENT for nommu or coldfire)
Merging powerpc-fixes/fixes (b7cbb5240130 Merge tag 'powerpc-5.2-6' into fi=
xes)
Merging s390-fixes/fixes (11aff183225c vfio-ccw: Destroy kmem cache region =
on module exit)
Merging sparc/master (61daf52c4ddd sparc64: Add missing newline at end of f=
ile)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (311633b60406 hsr: switch ->dellink() to ->ndo_uninit())
Merging bpf/master (9d1bc24b52fb bonding: validate ip header before check I=
PPROTO_IGMP)
Merging ipsec/master (56c5ee1a5823 xfrm interface: fix memory leak on creat=
ion)
Merging netfilter/master (1c5ec78272e3 netfilter: nfnetlink: avoid deadlock=
 due to synchronous request_module)
Merging ipvs/master (58e8b37069ff Merge branch 'net-phy-dp83867-add-some-fi=
xes')
Merging wireless-drivers/master (2a92b08b1855 mt76: usb: fix rx A-MSDU supp=
ort)
Merging mac80211/master (d2ce8d6bfcfe nl80211: Fix undefined behavior in bi=
t shift)
Merging rdma-fixes/for-rc (4b972a01a7da Linux 5.2-rc6)
Merging sound-current/for-linus (0dcb4efb1095 ALSA: firewire-lib: code refa=
ctoring for local variables)
Merging sound-asoc-fixes/for-linus (bd6fe4ae445e Merge branch 'asoc-5.2' in=
to asoc-linus)
Merging regmap-fixes/for-linus (ea09b3e21f18 Merge branch 'regmap-5.2' into=
 regmap-linus)
Merging regulator-fixes/for-linus (174bc9941d7d Merge branch 'regulator-5.2=
' into regulator-linus)
Merging spi-fixes/for-linus (70b5fa4cc32f Merge branch 'spi-5.2' into spi-l=
inus)
Merging pci-current/for-linus (6dbbd053e6ae PCI/P2PDMA: Ignore root complex=
 whitelist when an IOMMU is present)
Merging driver-core.current/driver-core-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging tty.current/tty-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging usb.current/usb-linus (4b972a01a7da Linux 5.2-rc6)
Merging usb-gadget-fixes/fixes (42de8afc40c9 usb: dwc2: Use generic PHY wid=
th in params setup)
Merging usb-serial-fixes/usb-linus (f8377eff5481 USB: serial: ftdi_sio: add=
 ID for isodebug v1)
Merging usb-chipidea-fixes/ci-for-usb-stable (16009db47c51 usb: chipidea: u=
dc: workaround for endpoint conflict issue)
Merging phy/fixes (ada28f7b3a97 phy: tegra: xusb: Add Tegra210 PLL power su=
pplies)
Merging staging.current/staging-linus (4b972a01a7da Linux 5.2-rc6)
Merging char-misc.current/char-misc-linus (4b972a01a7da Linux 5.2-rc6)
Merging soundwire-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging thunderbolt-fixes/fixes (6fbc7275c7a9 Linux 5.2-rc7)
Merging input-current/for-linus (597473720f4d Merge branch 'next' into for-=
linus)
CONFLICT (content): Merge conflict in drivers/input/misc/da9063_onkey.c
Merging crypto-current/master (f3880a23564e crypto: stm32/hash - remove int=
erruptible condition for dma)
Merging ide/master (13990cf8a180 ide: use BIT() macro for defining bit-flag=
s)
Merging vfio-fixes/for-linus (5715c4dd66a3 vfio/mdev: Synchronize device cr=
eate/remove with parent removal)
Merging kselftest-fixes/fixes (e2e88325f4bc selftests: vm: Fix test build f=
ailure when built by itself)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (0ecfebd2b524 Linux 5.2)
Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
Merging mtd-fixes/mtd/fixes (c7a87ceb17ae mtd: rawnand: sunxi: Add A23/A33 =
DMA support with extra MBUS configuration)
Merging mfd-fixes/for-mfd-fixes (63b2de12b7ee mfd: stmfx: Fix an endian bug=
 in stmfx_irq_handler())
Merging v4l-dvb-fixes/fixes (22be8233b34f media: videodev2.h: change V4L2_P=
IX_FMT_BGRA444 define: fourcc was already in use)
Merging reset-fixes/reset/fixes (a71dcd3757e2 reset: remove redundant null =
check on pointer dev)
Merging mips-fixes/mips-fixes (f2ff671f8941 MAINTAINERS: Correct path to mo=
ved files)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (fb59ee37cfe2 ARM: dts: am57xx: Disable voltage sw=
itching for SD card)
Merging kvm-fixes/master (e644fa18e2ff KVM: arm64/sve: Fix vq_present() mac=
ro to yield a bool)
Merging kvms390-fixes/master (a86cb413f4bf KVM: s390: Do not report unusabl=
ed IDs via KVM_CAP_MAX_VCPU_ID)
Merging hwmon-fixes/hwmon (5696e4aaabf2 hwmon: (pwm-fan) Check return value=
 from devm_add_action_or_reset)
Merging nvdimm-fixes/libnvdimm-fixes (a4a357fd4477 Merge branch 'for-5.2/da=
x' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (02252ea054b8 Merge branch 'misc-5.2' into n=
ext-fixes)
Merging vfs-fixes/fixes (75f2d86b20bf fs: VALIDATE_FS_PARSER should default=
 to n)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (6fbc7275c7a9 Linux 5.2-rc7)
Merging drivers-x86-fixes/fixes (9e0babf2c06c Linux 5.2-rc5)
Merging samsung-krzk-fixes/fixes (a188339ca5a3 Linux 5.2-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging devicetree-fixes/dt/linus (852d095d16a6 checkpatch.pl: Update DT ve=
ndor prefix check)
Merging scsi-fixes/fixes (5dd6c4933912 scsi: iscsi: set auth_protocol back =
to NULL if CHAP_A value is not supported)
Merging drm-fixes/drm-fixes (a0b2cf792ac9 Merge tag 'imx-drm-fixes-2019-07-=
04' of git://git.pengutronix.de/git/pza/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (c08e56c647ba drm/amd/display: Don't load DM=
CU for Raven 1 (v2))
Merging drm-intel-fixes/for-linux-next-fixes (d7e8a19b38c8 drm/i915: Don't =
dereference request if it may have been retired when printing)
Merging mmc-fixes/fixes (83293386bc95 mmc: core: Prevent processing SDIO IR=
Qs when the card is suspended)
Merging rtc-fixes/rtc-fixes (a188339ca5a3 Linux 5.2-rc1)
Merging gnss-fixes/gnss-linus (f2c7c76c5d0a Linux 5.2-rc3)
Merging hyperv-fixes/hyperv-fixes (01e7d61b8ace PCI: hv: Detect and fix Hyp=
er-V PCI domain number collision)
Merging soc-fsl-fixes/fix (5674a92ca4b7 soc/fsl/qe: Fix an error code in qe=
_pin_request())
Merging risc-v-fixes/fixes (0db7f5cd4aeb riscv: mm: Fix code comment)
Merging drm-misc-fixes/for-linux-next-fixes (2f040d27080d drm/panfrost: Fix=
 a double-free error)
Merging kbuild/for-next (1be54c4a3caa Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a188339ca5a3 Linux 5.2-rc1)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (e67a5ed1f86f dma-direct: Force unencrypted DM=
A under SME for certain DMA masks)
CONFLICT (content): Merge conflict in include/linux/genalloc.h
Merging asm-generic/master (7f3a8dff1219 asm-generic: remove ptrace.h)
Merging arc/for-next (6fbc7275c7a9 Linux 5.2-rc7)
Merging arm/for-next (b7a735f3a606 Merge branch 'for-arm-soc' into for-next)
Merging arm64/for-next/core (0c61efd322b7 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging arm-perf/for-next/perf (d482e575fbf0 perf: arm_spe: Enable ACPI/Pla=
tform automatic module loading)
Merging arm-soc/for-next (242af9ac5b32 ARM: Document merges)
CONFLICT (modify/delete): arch/arm/include/debug/netx.S deleted in arm-soc/=
for-next and modified in HEAD. Version HEAD of arch/arm/include/debug/netx.=
S left in tree.
CONFLICT (content): Merge conflict in arch/arm/configs/exynos_defconfig
$ git rm -f arch/arm/include/debug/netx.S
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging amlogic/for-next (11343d25a03b Merge branch 'v5.3/fixes' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (a1f5c11ddb7d Merge branches 'dt-for-v5.3', 'defcon=
fig-for-v5.3' and 'soc-for-v5.3' into for-next)
Merging at91/at91-next (7eb505978425 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
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
Merging rockchip/for-next (13622a50d8db Merge branch 'v5.3-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (cf6664323e0f Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (0ecfebd2b524 Linux 5.2)
Merging sunxi/sunxi/for-next (6c6b5d7650d9 Merge branch 'sunxi/dt64-for-5.3=
' into sunxi/for-next)
Merging tegra/for-next (033de83170dd Merge branch for-5.3/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (491933274860 Merge branch 'clk-lochnagar' into clk-ne=
xt)
CONFLICT (content): Merge conflict in drivers/clk/ingenic/Makefile
CONFLICT (content): Merge conflict in drivers/clk/bcm/Kconfig
CONFLICT (modify/delete): arch/mips/include/asm/mach-jz4740/clock.h deleted=
 in clk/clk-next and modified in HEAD. Version HEAD of arch/mips/include/as=
m/mach-jz4740/clock.h left in tree.
$ git rm -f arch/mips/include/asm/mach-jz4740/clock.h
Applying: clk: consoldiate the __clk_get_hw() declarations
Merging clk-samsung/for-next (7ef91224c486 clk: samsung: Add bus clock for =
GPU/G3D on Exynos4412)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (9f98b3142d22 csky: Improve string operations perfo=
rmance by glibc code)
Merging h8300/h8300-next (38ef0515e1e8 H8300: remove unused barrier defines)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (f28a1f16135c m68k: Don't select ARCH_HAS_DMA_PREP_CO=
HERENT for nommu or coldfire)
Merging m68knommu/for-next (ad97f9df0fee riscv: add binfmt_flat support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (c9093486f283 mips/kprobes: Export kprobe_fault_hand=
ler())
CONFLICT (content): Merge conflict in arch/mips/include/asm/mach-ralink/pin=
mux.h
Merging nds32/next (932296120543 nds32: add new emulations for floating poi=
nt instruction)
Merging nios2/for-next (f017da5c7077 nios2: configs: Remove useless UEVENT_=
HELPER_PATH)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (0fbf351ddc32 parisc: Ensure userspace privilege=
 for ptraced processes in regset functions)
Merging powerpc/next (73a2b047c810 ocxl: Update for AFU descriptor template=
 version 1.1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging soc-fsl/next (21560067fb1f soc: fsl: qe: fold qe_get_num_of_snums i=
nto qe_snums_init)
Merging risc-v/for-next (0f327f2aaad6 RISC-V: Add an Image header that boot=
 loader can parse.)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (499723d12063 docs: s390: s390dbf: typos and formatti=
ng, update crash command)
Merging sh/sh-next (d3023897b437 arch/sh: Check for kprobe trap number befo=
re trying to handle a kprobe trap)
CONFLICT (content): Merge conflict in arch/sh/configs/titan_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7721_defconfig
CONFLICT (content): Merge conflict in arch/sh/configs/se7712_defconfig
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
Applying: rbd: fix up for lockdep_assert_held_exclusive rename
Merging cifs/for-next (df070afd9b8c cifs: fix parsing of symbolic link erro=
r response)
Merging configfs/for-next (f6122ed2a4f9 configfs: Fix use-after-free when a=
ccessing sd->s_dentry)
Merging ecryptfs/next (7451c54abc91 ecryptfs: Change return type of ecryptf=
s_process_flags)
Merging ext3/for_next (f13c042dcf1c udf: support 2048-byte spacing of VRS d=
escriptors on 4K media)
Merging ext4/dev (96fcaf86c3cb ext4: fix coverity warning on error path of =
filename setup)
Merging f2fs/dev (2d008835ec2f f2fs: improve print log in f2fs_sanity_check=
_ckpt())
Merging fuse/for-next (766741fcaa1f Revert "fuse: require /dev/fuse reads t=
o have enough buffer capacity")
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (9f7249191314 Merge tag 'nfs-rdma-for-5.3-1' of git:=
//git.linux-nfs.org/projects/anna/linux-nfs)
Merging origin/master (17a20acaf171 Merge tag 'usb-5.3-rc1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/gregkh/usb)
Merging nfs-anna/linux-next (68f461593f76 NFS/flexfiles: Use the correct TC=
P timeout for flexfiles I/O)
Merging nfsd/nfsd-next (b78fa45d4edb nfsd: Make __get_nfsdfs_client() stati=
c)
Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updating =
size)
Merging overlayfs/overlayfs-next (6dde1e42f497 ovl: make i_ino consistent w=
ith st_ino in more cases)
Merging ubifs/linux-next (8009ce956c3d ubifs: Don't leak orphans on memory =
during commit)
Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_xen=
_init)
Merging xfs/for-next (488ca3d8d088 xfs: chain bios the right way around in =
xfs_rw_bdev)
CONFLICT (content): Merge conflict in fs/xfs/xfs_aops.c
Merging iomap/iomap-for-next (eec9066e4a22 iomap: move internal declaration=
s into fs/iomap/)
CONFLICT (modify/delete): fs/iomap.c deleted in iomap/iomap-for-next and mo=
dified in HEAD. Version HEAD of fs/iomap.c left in tree.
$ git rm -f fs/iomap.c
Applying: iomap: fix for block changes and split of iomap.c
Merging djw-vfs/vfs-for-next (7e328e5930ad mm/fs: don't allow writes to imm=
utable files)
Merging file-locks/locks-next (5450e8a316a6 Merge tag 'pidfd-updates-v5.3' =
of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux)
Merging vfs/for-next (3fcb59f577e2 Merge branches 'fixes' and 'work.adfs' i=
nto for-next)
CONFLICT (content): Merge conflict in fs/ubifs/super.c
CONFLICT (content): Merge conflict in fs/nfsd/nfsctl.c
CONFLICT (content): Merge conflict in fs/gfs2/super.c
CONFLICT (modify/delete): Documentation/filesystems/vfs.txt deleted in HEAD=
 and modified in vfs/for-next. Version vfs/for-next of Documentation/filesy=
stems/vfs.txt left in tree.
$ git rm -f Documentation/filesystems/vfs.txt
Applying: docs: filesystems: vfs: update for "vfs: Kill mount_single()"
Applying: convert vmwballoon to use the new mount API
Merging printk/for-next (f0cc370ab74d Merge branch 'for-5.3' into for-next)
Merging pci/next (e738ad2fa779 Merge branch 'pci/trivial')
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging pstore/for-next/pstore (4c6d80e1144b pstore: Fix double-free in pst=
ore_mkfile() failure path)
Merging hid/for-next (bf4945efabdf Merge branch 'for-5.3/wacom' into for-ne=
xt)
Merging i2c/i2c/for-next (9a74c745c689 Merge branch 'i2c/for-5.3' into i2c/=
for-next)
Merging i3c/i3c/next (ede2001569c3 i3c: master: Use struct_size() helper)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (9f7546570bcb hwmon: (ina3221) Add of_node=
_put() before return)
Merging jc_docs/docs-next (454f96f2b738 docs: automarkup.py: ignore excepti=
ons when seeking for xrefs)
Merging v4l-dvb/master (22be8233b34f media: videodev2.h: change V4L2_PIX_FM=
T_BGRA444 define: fourcc was already in use)
Merging v4l-dvb-next/master (22be8233b34f media: videodev2.h: change V4L2_P=
IX_FMT_BGRA444 define: fourcc was already in use)
Merging fbdev/fbdev-for-next (732146a3f1dc video: fbdev: imxfb: fix a typo =
in imxfb_probe())
Merging pm/linux-next (e31361ee1cea Merge branch 'pm-cpufreq' into linux-ne=
xt)
CONFLICT (content): Merge conflict in Documentation/power/pm_qos_interface.=
rst
Merging cpufreq-arm/cpufreq/arm/linux-next (f9020441dbc3 cpufreq: s5pv210: =
Don't flood kernel log after cpufreq change)
Merging cpupower/cpupower (04507c0a9385 cpupower : frequency-set -r option =
misses the last cpu in related cpu list)
Merging opp/opp/linux-next (560d1bcad715 opp: Don't use IS_ERR on invalid s=
upplies)
Merging thermal/next (ff9b011ad143 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (4cb9f043447e thermal: thermal_mmio: remove some d=
ead code)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (6051531997ed dlm: no need to check return value of debugf=
s_create functions)
Merging swiotlb/linux-next (dd853b2dfa65 Merge branch 'stable/for-linus-5.2=
' into linux-next)
Merging rdma/for-next (cea743f2ea81 RDMA/siw: Mark expected switch fall-thr=
oughs)
CONFLICT (modify/delete): drivers/infiniband/hw/nes/nes.c deleted in rdma/f=
or-next and modified in HEAD. Version HEAD of drivers/infiniband/hw/nes/nes=
.c left in tree.
$ git rm -f drivers/infiniband/hw/nes/nes.c
Applying: rdma: attempt to build rdma_counter.h stand alone again
Applying: RDMA: fix for removal of for_ifa()
Merging net-next/master (a131c2bf1656 Merge tag 'acpi-5.3-rc1-2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging bpf-next/master (b14a260e33dd Merge branch 'nfp-tls-fixes-for-initi=
al-TLS-support')
Merging ipsec-next/master (c7b37c769d2a xfrm: remove get_mtu indirection fr=
om xfrm_type)
Merging mlx5-next/mlx5-next (1dd7382b1bb6 net/mlx5: Introduce VHCA tunnel d=
evice capability)
Merging netfilter-next/master (1ff2f0fa450e net/mlx5e: Return in default ca=
se statement in tx_post_resync_params)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (1b0b807dd746 Merge branch 'r8169-fw')
Merging wireless-drivers-next/master (5adcdab6ae1b Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (4409aabb7f46 Bluetooth: btqca: Use correct byte f=
ormat for opcode of injected command)
Merging mac80211-next/master (17c74d7c5f0d nl80211: fix VENDOR_CMD_RAW_DATA)
Merging gfs2/for-next (bb4cb25dd319 gfs2: Remove unused gfs2_iomap_alloc ar=
gument)
Merging mtd/mtd/next (46ce10df799f Merge tag 'spi-nor/for-5.3-v2' of gitoli=
te.kernel.org:pub/scm/linux/kernel/git/mtd/linux into mtd/next)
CONFLICT (content): Merge conflict in include/linux/platform_data/intel-spi=
.h
CONFLICT (modify/delete): drivers/mtd/spi-nor/stm32-quadspi.c deleted in mt=
d/mtd/next and modified in HEAD. Version HEAD of drivers/mtd/spi-nor/stm32-=
quadspi.c left in tree.
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.h
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-platfor=
m.c
CONFLICT (content): Merge conflict in drivers/mtd/spi-nor/intel-spi-pci.c
CONFLICT (content): Merge conflict in drivers/mtd/nand/raw/mtk_ecc.h
$ git rm -f drivers/mtd/spi-nor/stm32-quadspi.c
Merging nand/nand/next (bce9437a0a48 mtd: rawnand: stm32_fmc2: increase DMA=
 completion timeouts)
Merging spi-nor/spi-nor/next (8d1336c241bd mtd: spi-nor: cadence-quadspi: a=
dd reset control)
Merging crypto/master (f3880a23564e crypto: stm32/hash - remove interruptib=
le condition for dma)
Merging drm/drm-next (f27b99a1cea7 Merge tag 'imx-drm-next-2019-07-05' of g=
it://git.pengutronix.de/git/pza/linux into drm-next)
CONFLICT (content): Merge conflict in include/uapi/linux/magic.h
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-ic-prpe=
ncvf.c
CONFLICT (modify/delete): drivers/gpu/drm/i915/intel_context.c deleted in d=
rm/drm-next and modified in HEAD. Version HEAD of drivers/gpu/drm/i915/inte=
l_context.c left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_workaro=
unds.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
types.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_engine_=
cs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Makefile.header-=
test
CONFLICT (content): Merge conflict in Documentation/fb/modedb.rst
$ git rm -f drivers/gpu/drm/i915/intel_context.c
Applying: dma-buf: convert to new mount api
Merging amdgpu/drm-next (3b3e45669a3a Revert "drm/amdgpu: support key datab=
ase loading for navi10")
Merging drm-intel/for-linux-next (a1c5f1510b3f drm/i915/tgl: Update DPLL cl=
ock reference register)
Merging drm-tegra/drm/tegra/for-next (eb7cf945a8da host1x: debugfs_create_d=
ir() can never return NULL)
Merging drm-misc/for-linux-next (7f3bbc0b817b drm/modes: Skip invalid cmdli=
ne mode)
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
Merging regmap/for-next (aaccf3863ce2 Merge branch 'regmap-5.3' into regmap=
-next)
Merging sound/for-next (b89b889a326a Merge branch 'topic/hda-refresh-cleanu=
p' into for-next)
Merging sound-asoc/for-next (f82b1d01dead Merge branch 'asoc-5.3' into asoc=
-next)
Merging modules/modules-next (93651f80dcb6 modules: fix compile error if do=
n't have strict module rwx)
Merging input/next (593fdd4fb44e Input: gpio_keys_polled - allow specifying=
 name of input device)
Merging block/for-next (e156afacf978 Merge branch 'for-linus' into for-next)
Applying: xfs: fix up for wbc_account_io rename
Applying: f2fs: fix for wbc_account_io rename
Merging device-mapper/for-next (9b459b7861c6 dm snapshot: add optional disc=
ard support features)
CONFLICT (content): Merge conflict in Documentation/device-mapper/snapshot.=
rst
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (59592cc1f593 mmc: sdhci_am654: Add dependency on MMC_SDHC=
I_AM654)
CONFLICT (content): Merge conflict in drivers/mmc/host/meson-gx-mmc.c
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (7efd105c27fd mfd: hi655x-pmic: Fix missing return=
 value check for devm_regmap_init_mmio_clk)
CONFLICT (content): Merge conflict in include/linux/mfd/cros_ec_commands.h
CONFLICT (content): Merge conflict in drivers/gpio/Makefile
Merging backlight/for-backlight-next (73fbfc499448 backlight: pwm_bl: Fix h=
euristic to determine number of brightness levels)
CONFLICT (content): Merge conflict in drivers/video/backlight/pwm_bl.c
Merging battery/for-next (caa2b557841c power: reset: nvmem-reboot-mode: add=
 CONFIG_OF dependency)
CONFLICT (content): Merge conflict in drivers/power/supply/Makefile
CONFLICT (content): Merge conflict in drivers/power/supply/Kconfig
CONFLICT (modify/delete): Documentation/power/power_supply_class.txt delete=
d in HEAD and modified in battery/for-next. Version battery/for-next of Doc=
umentation/power/power_supply_class.txt left in tree.
$ git rm -f Documentation/power/power_supply_class.txt
Applying: power: supply: update for conversion to .rst
Merging regulator/for-next (097ba891307c Merge branch 'regulator-5.3' into =
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
Merging tpmdd/next (0ce9bf1a55c9 tpm: tpm_ibm_vtpm: Fix unallocated banks)
Merging watchdog/master (053bc5764bb0 watchdog: ie6xx_wdt: Use spinlock_t i=
nstead of struct spinlock)
CONFLICT (add/add): Merge conflict in Documentation/watchdog/watchdog-param=
eters.rst
CONFLICT (content): Merge conflict in Documentation/watchdog/hpwdt.rst
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/freescale/fsl,scu.txt
Merging iommu/next (d95c3885865b Merge branches 'x86/vt-d', 'x86/amd', 'arm=
/smmu', 'arm/omap', 'generic-dma-ops' and 'core' into next)
Merging vfio/next (1e4d09d2212d mdev: Send uevents around parent device reg=
istration)
Merging audit/next (839d05e41385 audit: remove the BUG() calls in the audit=
 rule comparison functions)
Merging devicetree/for-next (f59d261180f3 dt-bindings: vendor-prefixes: add=
 Sipeed)
CONFLICT (content): Merge conflict in scripts/dtc/libfdt/Makefile.libfdt
CONFLICT (content): Merge conflict in scripts/dtc/Makefile.dtc
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/net=
/ethernet.txt
Merging mailbox/mailbox-for-next (20b5d24c7669 mailbox: tegra: avoid resume=
 NULL mailboxes)
Merging spi/for-next (2e77a18d0464 Merge branch 'spi-5.3' into spi-next)
Merging tip/auto-latest (ffae13efa5d3 Merge branch 'core/urgent')
Merging clockevents/clockevents/next (b0c74b96d177 clocksource/drivers/davi=
nci: Add support for clocksource)
Merging edac-amd/for-next (b2572772d13e EDAC: Make edac_debugfs_create_x*()=
 return void)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging irqchip/irq/irqchip-next (3dae67ce600c irqchip/gic-pm: Remove PM_CL=
K dependency)
Merging ftrace/for-next (730a95953b1f tracing/kprobe: Check registered stat=
e using kprobe)
Merging rcu/rcu/next (b989ff070574 Merge LKMM and RCU commits)
Merging kvm/linux-next (a45ff5994c9c Merge tag 'kvm-arm-for-5.3' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
CONFLICT (content): Merge conflict in Documentation/arm64/silicon-errata.rst
Merging kvm-arm/next (1e0cf16cdad1 KVM: arm/arm64: Initialise host's MPIDRs=
 by reading the actual register)
Merging kvm-ppc/kvm-ppc-next (3bda7f0ae0f7 KVM: PPC: Book3S PR: Fix softwar=
e breakpoints)
Merging kvms390/next (8343ba2d4820 KVM: selftests: enable pgste option for =
the linker on s390)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
Merging xen-tip/linux-next (3cd270089485 Revert "x86/paravirt: Set up the v=
irt_spin_lock_key after static keys get initialized")
Merging percpu/for-next (e0afe6d4d12c Merge branch 'for-5.4' into for-next)
Merging workqueues/for-next (be69d00d9769 workqueue: Remove GPF argument fr=
om alloc_workqueue_attrs())
Merging drivers-x86/for-next (8e8fe446a91c platform/x86: asus-wmi: Use dev_=
get_drvdata())
Merging chrome-platform/for-next (8c3166e17cf1 mfd / platform: cros_ec_debu=
gfs: Expose resume result via debugfs)
Merging hsi/for-next (a188339ca5a3 Linux 5.2-rc1)
Merging leds/for-next (2605085fba22 dt: leds-lm36274.txt: fix a broken refe=
rence to ti-lmu.txt)
Merging ipmi/for-next (ac499fba98c3 docs: ipmb: place it at driver-api and =
convert to ReST)
Merging driver-core/driver-core-next (c33d442328f5 debugfs: make error mess=
age a bit more verbose)
CONFLICT (content): Merge conflict in net/sunrpc/debugfs.c
CONFLICT (content): Merge conflict in fs/ceph/super.c
CONFLICT (content): Merge conflict in drivers/misc/vmw_balloon.c
CONFLICT (content): Merge conflict in drivers/misc/mei/debugfs.c
CONFLICT (modify/delete): drivers/hwtracing/coresight/of_coresight.c delete=
d in HEAD and modified in driver-core/driver-core-next. Version driver-core=
/driver-core-next of drivers/hwtracing/coresight/of_coresight.c left in tre=
e.
CONFLICT (content): Merge conflict in drivers/acpi/sleep.c
$ git rm -f drivers/hwtracing/coresight/of_coresight.c
Applying: merge fix for conflict between the s390 and driver-core tree
Applying: coresight: fix for "bus_find_device: Unify the match callback wit=
h class_find_device"
Applying: coresight: Make the coresight_device_fwnode_match declaration's f=
wnode parameter const
Merging usb/usb-next (2bc8bb813cba Merge tag 'usb-ci-v5.3-rc1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-next)
Merging usb-gadget/next (b2357839c56a usb: renesas_usbhs: add a workaround =
for a race condition of workqueue)
Merging usb-serial/usb-next (9e0babf2c06c Linux 5.2-rc5)
Merging usb-chipidea-next/ci-for-usb-next (034252e37b31 usb: chipidea: msm:=
 Use devm_platform_ioremap_resource())
Merging phy-next/next (520602640419 phy: qcom-qmp: Raise qcom_qmp_phy_enabl=
e() polling delay)
Merging tty/tty-next (35a4ed0164e9 tty: serial: fsl_lpuart: add imx8qxp sup=
port)
Merging char-misc/char-misc-next (2f4281f4dce1 Merge tag 'soundwire-5.3-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into cha=
r-misc-next)
Merging extcon/extcon-next (0937fbb7abeb extcon: fsa9480: Fix Kconfig warni=
ng and build errors)
Merging soundwire/next (2aeac95d1a4c soundwire: add module_sdw_driver helpe=
r macro)
Merging thunderbolt/next (6fbc7275c7a9 Linux 5.2-rc7)
Merging staging/staging-next (5d1532482943 staging: kpc2000: simplify compa=
rison to NULL in fileops.c)
Merging mux/for-next (05fb8284a417 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (5c274ca4cfb2 dmaengine: Revert "dmaengine: fsl-edma=
: add i.mx7ulp edma2 version support")
CONFLICT (modify/delete): include/linux/sudmac.h deleted in slave-dma/next =
and modified in HEAD. Version HEAD of include/linux/sudmac.h left in tree.
CONFLICT (content): Merge conflict in drivers/dma/mediatek/Makefile
CONFLICT (content): Merge conflict in drivers/dma/dma-jz4780.c
CONFLICT (content): Merge conflict in drivers/dma/dma-axi-dmac.c
$ git rm -f include/linux/sudmac.h
Merging cgroup/for-next (22a0b83583ab Merge branch 'for-5.3' into for-next)
Merging scsi/for-next (8fdf518974b5 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (484647088826 scsi: zfcp: fix GCC compiler warnin=
g emitted with -Wmaybe-uninitialized)
Merging vhost/linux-next (5e663f0410fa virtio-mmio: add error check for pla=
tform_get_irq)
Applying: iommu/virtio: Constify data parameter in viommu_match_node
Merging rpmsg/for-next (ab1291acd4ab Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (9b3b623804a6 Revert "gpio: tegra: Clean-up debugfs i=
nitialisation")
Merging gpio-brgl/gpio/for-next (f360dcd4ef7f gpio: mockup: no need to chec=
k return value of debugfs_create functions)
Merging pinctrl/for-next (4c105769bf6d pinctrl: aspeed: Strip moved macros =
and structs from private header)
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8b-gpio=
.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson8-gpio.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxl-gp=
io.h
CONFLICT (content): Merge conflict in include/dt-bindings/gpio/meson-gxbb-g=
pio.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8b=
.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8-=
pmx.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson8-=
pmx.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson.h
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson-g=
xl.c
CONFLICT (content): Merge conflict in drivers/pinctrl/meson/pinctrl-meson-g=
xbb.c
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
Merging coresight/next (2f4281f4dce1 Merge tag 'soundwire-5.3-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-nex=
t)
Merging rtc/rtc-next (3572e8aea3bf rtc: pcf8563: Clear event flags and disa=
ble interrupts before requesting irq)
Merging nvdimm/libnvdimm-for-next (7c40cc44161a Merge branch 'for-5.3/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in include/uapi/linux/virtio_ids.h
Merging at24/at24/for-next (dce91ba39c76 eeprom: at24: modify a comment ref=
erring to platform data)
Merging ntb/ntb-next (d9c53aa440b3 NTB: Describe the ntb_msi_test client in=
 the documentation.)
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
CONFLICT (content): Merge conflict in arch/x86/include/asm/mshyperv.h
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
Merging hmm/hmm (cc5dfd59e375 Merge branch 'hmm-devmem-cleanup.4' into rdma=
.git hmm)
CONFLICT (content): Merge conflict in include/linux/ioport.h
Applying: mm/hmm: fixup for "locking/lockdep: Rename lockdep_assert_held_ex=
clusive() -> lockdep_assert_held_write()"
Applying: drm/amdgpu: adopt to hmm_range_register API change
Merging akpm-current/current (c1ced6498285 include/linux/lz4.h: fix spellin=
g and copy-paste errors in documentation)
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in mm/Kconfig
CONFLICT (content): Merge conflict in kernel/dma/remap.c
CONFLICT (content): Merge conflict in arch/powerpc/mm/book3s64/radix_pgtabl=
e.c
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/pgtable.h
Applying: merge fixup for "mm: Add an apply_to_pfn_range interface"
Applying: another fixup for "mm: Add an apply_to_pfn_range interface"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: device-dax: fix memory and resource leak if hotplug fails
Applying: mm/hotplug: make remove_memory() interface usable
Applying: device-dax: "Hotremove" persistent memory that is used like norma=
l RAM
Applying: mm: move MAP_SYNC to asm-generic/mman-common.h
Applying: mm/mmap: move common defines to mman-common.h
Applying: mm: section numbers use the type "unsigned long"
Applying: mm-section-numbers-use-the-type-unsigned-long-fix
Applying: mm-section-numbers-use-the-type-unsigned-long-v3
Applying: drivers/base/memory: Use "unsigned long" for block ids
Applying: mm: make register_mem_sect_under_node() static
Applying: mm/memory_hotplug: rename walk_memory_range() and pass start+size=
 instead of pfns
Applying: mm/memory_hotplug: move and simplify walk_memory_blocks()
Applying: drivers/base/memory.c: Get rid of find_memory_block_hinted()
Applying: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3
Applying: drivers-base-memoryc-get-rid-of-find_memory_block_hinted-v3-fix
Applying: mm: clean up is_device_*_page() definitions
Applying: mm: introduce ARCH_HAS_PTE_DEVMAP
Applying: arm64: mm: implement pte_devmap support
Applying: arm64-mm-implement-pte_devmap-support-fix
Applying: mm/sparsemem: introduce struct mem_section_usage
Applying: mm/sparsemem: introduce a SECTION_IS_EARLY flag
Applying: mm/sparsemem: add helpers track active portions of a section at b=
oot
Applying: mm/hotplug: prepare shrink_{zone, pgdat}_span for sub-section rem=
oval
Applying: mm/sparsemem: convert kmalloc_section_memmap() to populate_sectio=
n_memmap()
Applying: mm/hotplug: kill is_dev_zone() usage in __remove_pages()
Applying: mm: kill is_dev_zone() helper
Applying: mm/sparsemem: prepare for sub-section ranges
Applying: mm/sparsemem: support sub-section hotplug
Applying: mm: document ZONE_DEVICE memory-model implications
Applying: docs/vm: update ZONE_DEVICE memory model documentation
Applying: mm/devm_memremap_pages: enable sub-section remap
Applying: libnvdimm/pfn: fix fsdax-mode namespace info-block zero-fields
Applying: libnvdimm/pfn: stop padding pmem namespaces to section alignment
Applying: mm/sparsemem: cleanup 'section number' data types
Applying: mm-sparsemem-cleanup-section-number-data-types-fix
Applying: mm: migrate: remove unused mode argument
Applying: mm: migrate: fix for fs/iomap.c splitting
Applying: mm: add account_locked_vm utility function
Applying: mm-add-account_locked_vm-utility-function-v3
Applying: mm-add-account_locked_vm-utility-function-v3-fix
Applying: proc/sysctl: add shared variables for range check
Applying: tipc: remove two unused variables
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-2-fix
Applying: proc/sysctl: make firmware loader table conditional
Applying: proc-sysctl-add-shared-variables-for-range-check-fix-4
Applying: drivers/tty/serial/sh-sci.c: suppress warning
Applying: fs/select.c: use struct_size() in kmalloc()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (3df4809b8f1b drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/3zR2wgvTf9jHVJ1oN5zUwkJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0oKUEACgkQAVBC80lX
0Gx+PQf/ZwlhyNz3zgeDI8sSK9jOVFsANmre3h5rUXBYNMMryXbBwZKqv9YuBYpI
RItzdbDt89zsOBzU5P6kFuWXs4vRn0uuWpKlwUQou/8MQzefcvwGMsHVjbZYTRJY
E7/Y0p9OaysnRKf5xOPP1HUhOmLTYtii7XXDIi0C9kqNwua420U1b72G6LgbyDRs
u1BpvfH7PciPeVt2mJIwrrCUkcHit/YdtSL56T/5/fsuy+nCzo6bLDFLoGOPSpBf
4tIp+c4E5YKtMtGanH/AtLOVflulOH5qnJ23dbZLxsGr+I5LG/WZ3deopf+g/zZi
pIQlqZ6aUXq7EUgDWwOAs/mu110d3A==
=KBJz
-----END PGP SIGNATURE-----

--Sig_/3zR2wgvTf9jHVJ1oN5zUwkJ--
