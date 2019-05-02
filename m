Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DD9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9958F20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UBvqb2lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEBKKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:10:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfEBKKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:10:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vrcQ3HQvz9s3Z;
        Thu,  2 May 2019 20:10:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556791830;
        bh=2iJVz0oGBxNCyIFWAOjCjoyzBUEbhMDEM9K6OJJKnF4=;
        h=Date:From:To:Cc:Subject:From;
        b=UBvqb2lcc45Bzqv4igDm0mmQM65uSjdKeF8z5PmQixqsJfRlmlBynhWUtMDAbxWfe
         NFKPhhaZxpimPOQhx7yJ1eV/BN+Obo5sPwFjAeDp3OrJ1Am67VQJmwH36AjTrZPH8n
         PDkiEXR7/8DeLz5jzCi/aEp480BGxIDPN1EbkyDJ/rzm/bTmAH/abG8FUF+uaMqsBo
         pqe8V9lzHxHNXmWWDXg7DZYpOvY7oTKJy0IQ/L3RJMU9OgnbeIkZYCPlM2XSRi//7N
         aiz09STmPNuCSBRNDx+Kwsfkb2plNjDuywBOw23ryzun2JN8mD9CFtqaTCE/V85rxo
         AFdUknFv6Un5Q==
Date:   Thu, 2 May 2019 20:10:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 2
Message-ID: <20190502201028.707453d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.JQ1w3siGsZ+htIUgzOtaVT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.JQ1w3siGsZ+htIUgzOtaVT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190501:

The kbuild tree gained a conflict against Linus' tree.

The f2fs tree gained a build failure for which I applied a patch.

The net-next tree gained a conflict against the net tree.

The pidfd tree gained a conflict against the kbuild tree.

The akpm-current tree gained a conflict against the parisc-hd tree.

Non-merge commits (relative to Linus' tree): 10425
 10206 files changed, 459072 insertions(+), 301989 deletions(-)

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
Merging origin/master (65beea4c3a52 Merge tag 'arc-5.1-final' of git://git.=
kernel.org/pub/scm/linux/kernel/git/vgupta/arc)
Merging fixes/master (1995fa480636 kernel/compat.c: mark expected switch fa=
ll-throughs)
Merging kspp-gustavo/for-next/kspp (ccaa75187a5f memstick: mark expected sw=
itch fall-throughs)
Merging kbuild-current/fixes (79a3aaa7b82e Linux 5.1-rc3)
Merging arc-current/for-curr (55c0c4c793b5 ARC: memset: fix build with L1_C=
ACHE_SHIFT !=3D 6)
Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB i=
nstructions before cleaning the cache)
Merging arm64-fixes/for-next/fixes (4e69ecf4da1e arm64/module: ftrace: deal=
 with place relative nature of PLTs)
Merging m68k-current/for-linus (28713169d879 m68k: Add -ffreestanding to CF=
LAGS)
Merging powerpc-fixes/fixes (7a3a4d763837 powerpc/mm_iommu: Allow pinning l=
arge regions)
Merging sparc/master (7d762d69145a afs: Fix manually set volume location se=
rver list)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (886b7a50100a ipv6: A few fixes on dereferencing rt->fro=
m)
Merging bpf/master (b9aa0b35d878 bpf, x32: Fix bug for BPF_ALU64 | BPF_NEG)
Merging ipsec/master (837f74116585 xfrm: update doc about xfrm[46]_gc_thres=
h)
Merging netfilter/master (33cc3c0cfa64 netfilter: nf_flow_table: check ttl =
value in flow offload data path)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (7a0f8ad5ff63 Merge ath-current from git://=
git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mac80211/master (517879147493 mac80211: don't attempt to rename ERR=
_PTR() debugfs dirs)
Merging rdma-fixes/for-rc (2557fabd6e29 RDMA/hns: Bugfix for mapping user d=
b)
Merging sound-current/for-linus (3887c26c0e24 ALSA: hda/realtek - Apply the=
 fixup for ASUS Q325UAR)
Merging sound-asoc-fixes/for-linus (952f0986cc51 Merge branch 'asoc-5.1' in=
to asoc-linus)
Merging regmap-fixes/for-linus (7fdc9fc87492 Merge branch 'regmap-5.1' into=
 regmap-linus)
Merging regulator-fixes/for-linus (222d7eef42eb Merge branch 'regulator-5.1=
' into regulator-linus)
Merging spi-fixes/for-linus (9f2487a2ae45 Merge branch 'spi-5.1' into spi-l=
inus)
Merging pci-current/for-linus (9c9c5fc89b09 PCI/LINK: Add Kconfig option (d=
efault off))
Merging driver-core.current/driver-core-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging tty.current/tty-linus (085b7755808a Linux 5.1-rc6)
Merging usb.current/usb-linus (c114944d7d67 USB: w1 ds2490: Fix bug caused =
by improper use of altsetting array)
Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix deadlo=
ck in f_hidg_write())
Merging usb-serial-fixes/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (e6f32efb1b12 phy: sun4i-usb: Make sure to disable PHY0 p=
assby for peripheral mode)
Merging staging.current/staging-linus (085b7755808a Linux 5.1-rc6)
Merging char-misc.current/char-misc-linus (24f1bc280bce misc: rtsx: Fixed r=
ts5260 power saving parameter and sd glitch)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (37624b58542f Linux 5.1-rc7)
Merging input-current/for-linus (3a349763cf11 Input: synaptics-rmi4 - write=
 config register values to the right offset)
Merging crypto-current/master (b257b48cd583 crypto: lrw - Fix atomic sleep =
when walking skcipher)
Merging ide/master (dc5c37736d16 drivers: ide: Kconfig: pedantic formatting)
Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings p=
er container)
Merging kselftest-fixes/fixes (15ade5d2e777 Linux 5.1-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (37624b58542f Linux 5.1-rc7)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/mtd/fixes (9a8f612ca0d6 mtd: rawnand: marvell: Clean the =
controller state before each operation)
Merging mfd-fixes/for-mfd-fixes (a05a2e7998ab mfd: sun6i-prcm: Allow to com=
pile with COMPILE_TEST)
Merging v4l-dvb-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging reset-fixes/reset/fixes (13e8a05b9224 reset: meson-audio-arb: Fix m=
issing .owner setting of reset_controller_dev)
Merging mips-fixes/mips-fixes (a1e8783db8e0 MIPS: perf: ath79: Fix perfcoun=
t IRQ assignment)
Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possible=
 object reference leak)
Merging omap-fixes/fixes (6a38df676a0a ARM: dts: logicpd-som-lv: Fix MMC1 c=
ard detect)
Merging kvm-fixes/master (e8ab8d24b488 KVM: nVMX: Fix size checks in vmx_se=
t_nested_state)
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (b88c5049219a hwmon: (occ) Fix extended status bi=
ts)
Merging nvdimm-fixes/libnvdimm-fixes (a7de824d947a Merge branch 'for-5.1/da=
x' into libnvdimm-for-next)
Merging btrfs-fixes/next-fixes (38464fdaacb5 Merge branch 'misc-5.1' into n=
ext-fixes)
Merging vfs-fixes/fixes (f69e749a4935 Abort file_remove_privs() for non-reg=
. files)
Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip one =
stackframe entry)
Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
Merging drivers-x86-fixes/fixes (57f634b76a95 platform/x86: dell-laptop: fi=
x rfkill functionality)
Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (144ec97493af scsi: aic7xxx: fix EISA support)
Merging drm-fixes/drm-fixes (37624b58542f Linux 5.1-rc7)
Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden s=
etting for vega family)
Merging drm-intel-fixes/for-linux-next-fixes (f5c58ba18ab8 drm/i915: Restor=
e correct bxt_ddi_phy_calc_lane_lat_optim_mask() calculation)
Merging mmc-fixes/fixes (dc4060a5dc25 Linux 5.1-rc5)
Merging rtc-fixes/rtc-fixes (882c5e552ffd rtc: da9063: set uie_unsupported =
when relevant)
Merging gnss-fixes/gnss-linus (79a3aaa7b82e Linux 5.1-rc3)
Merging hyperv-fixes/hyperv-fixes (a0033bd1eae4 Drivers: hv: vmbus: Remove =
the undesired put_cpu_ptr() in hv_synic_cleanup())
Merging drm-misc-fixes/for-linux-next-fixes (ab042b824c11 Revert "drm/qxl: =
drop prime import/export callbacks")
Merging kbuild/for-next (f711b2ddcf08 Merge branch 'kconfig' into for-next)
CONFLICT (content): Merge conflict in Makefile
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
Merging dma-mapping/for-next (148a97d5a02a dma-mapping: remove an unnecessa=
ry NULL check)
Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic uacc=
ess for 8-byte loads and stores)
Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
Merging arm/for-next (3d3c616177cc Merge branches 'fixes' and 'misc' into f=
or-next)
Merging arm64/for-next/core (a8f7ce5a9fbc Merge branch 'for-next/mmiowb' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux into for-next/co=
re)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/futex.h
Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU hot=
plug handling)
Merging arm-soc/for-next (c19ddad91159 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (14248aa919f9 Merge branch 'v5.2/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (ac650130c227 Merge branches 'at91-soc', 'at91-dt' a=
nd 'at91-defconfig' into at91-next)
CONFLICT (content): Merge conflict in arch/arm/mach-at91/pm.c
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (7119403f9617 Merge branch 'imx/defconfig' into fo=
r-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into f=
or-next)
Merging mvebu/for-next (891f0f865c37 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ef2989fe20d8 Merge branch 'fixes' into for-next)
Merging reset/reset/next (d005aa750c9b reset: fix linux/reset.h errors)
Merging qcom/for-next (1d31c0b1a28a Merge tag 'qcom-arm64-for-5.2-1' into r=
eally-done-for-5.2)
Merging renesas/next (982700f80241 Merge branch 'arm-dt-for-v5.2' into next)
Merging rockchip/for-next (9c539071723e Merge branch 'v5.2-clk/next' into f=
or-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (831c75782772 Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (613c4ce8fddb Merge branch 'sunxi/dt-for-5.2' =
into sunxi/for-next)
Merging tegra/for-next (b31c477a9892 Merge branch for-5.2/arm64/defconfig i=
nto for-next)
Merging clk/clk-next (61d9707c08e7 Merge branch 'clk-imx' into clk-next)
Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add ga=
te clock for ADC)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (a691f3334d58 csky/syscall_trace: Fixup return proc=
essing flow)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (733df11cfc36 m68k: defconfig: Update defconfigs for =
v5.1-rc1)
Merging m68knommu/for-next (37624b58542f Linux 5.1-rc7)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (cf0c4876684d mips: Combine memblock init and memory=
 reservation loops)
Merging nds32/next (83f7b748f739 nds32: fix asm/syscall.h)
Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload th=
e TLB with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (2b731a920986 parisc: Update huge TLB page suppo=
rt to use per-pagetable spinlock)
Merging powerpc/next (26ad26718dfa powerpc/mm: Fix section mismatch warning)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (fd7f744caed8 riscv: vdso: drop unnecessary cc-ldop=
tion)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (7a5da02de8d6 locking/lockdep: check for freed initme=
m in static_obj())
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (aea05eb56e47 um: Fix for a possible OOPS in ubd ini=
tialization)
Merging xtensa/xtensa-for-next (a26a70426e9b Merge branch 'xtensa-5.1-fixes=
' into xtensa-for-next)
Merging fscrypt/master (2c58d548f570 fscrypt: cache decrypted symlink targe=
t in ->i_link)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6033347bcdd8 Merge branch 'for-next-stale-201=
90425' into for-next-20190425)
Merging ceph/master (37659182bff1 ceph: fix ci->i_head_snapc leak)
Merging cifs/for-next (838a20335ea5 cifs: update module internal version nu=
mber)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (91e9f2c1d861 Merge quota fix from Chengguang.)
Merging ext4/dev (7403c629f6c8 ext4: fix ext4_show_options for file systems=
 w/o journal)
Merging f2fs/dev (90a238561901 f2fs: add tracepoint for f2fs_filemap_fault(=
))
Applying: f2fs: fix up for "f2fs: add tracepoint for f2fs_filemap_fault()"
Merging fuse/for-next (6407f44aaf2a fuse: Add ioctl flag for x32 compat ioc=
tl)
Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializat=
ion)
Merging nfs/linux-next (f2bc9c908dfe Merge tag 'fsnotify_for_v5.1-rc8' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs)
Merging nfs-anna/linux-next (b422df915cef lockd: Store the lockd client cre=
dential in struct nlm_host)
Merging nfsd/nfsd-next (5926459e7c89 locks: move checks from locks_free_loc=
k() to locks_release_private())
Merging orangefs/for-next (7dccb4027ef9 orangefs: copy Orangefs-sized block=
s into the pagecache if possible.)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (5578e48e5c0b ubi: wl: Silence uninitialized varia=
ble warning)
Merging v9fs/9p-next (bb06c388fa20 9p/net: fix memory leak in p9_client_cre=
ate)
Merging xfs/for-next (f00b8b784f75 Merge remote-tracking branch 'korg/iomap=
-5.2-merge' into for-next)
Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked o=
n request before deadlock check)
Merging vfs/for-next (af467ef6c590 Merge branches 'work.misc' and 'work.dca=
che' into for-next)
Merging printk/for-next (3ba3fee931aa Merge branch 'for-5.2-vsprintf-harden=
ing' into for-next)
CONFLICT (content): Merge conflict in mm/memblock.c
CONFLICT (content): Merge conflict in include/trace/events/sunrpc.h
CONFLICT (content): Merge conflict in drivers/base/power/main.c
Merging pci/next (e564375c4460 Merge branch 'pci/trivial')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (eb18d1215405 Merge branch 'for-5.2/logitech' into for=
-next)
Merging i2c/i2c/for-next (5dc8e322f1a8 Merge branch 'i2c/for-current-fixed'=
 into i2c/for-next)
Merging i3c/i3c/next (124dbd750da4 i3c: master: dw: remove dead code from d=
w_i3c_master_*_xfers())
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (a60170000338 hwmon: (s3c) Use dev_get_drv=
data())
Merging jc_docs/docs-next (41f0a9542a25 docs/vm: Minor editorial changes in=
 the THP and hugetlbfs)
Merging v4l-dvb/master (7afa8db323e3 media: vsp1: Add support for missing 1=
6-bit RGB555 formats)
Merging v4l-dvb-next/master (9e98c678c2d6 Linux 5.1-rc1)
Merging fbdev/fbdev-for-next (261ac4ddfa9f video: fbdev: atmel_lcdfb: remov=
e set but not used variable 'pdata')
Merging pm/linux-next (ff9cb8b1104e Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (8db82563451f cpufreq: armada-37=
xx: fix frequency calculation for opp)
Merging cpupower/cpupower (21027e78e7c1 cpupower: correct spelling of inter=
val)
Merging opp/opp/linux-next (2f36bde0fc8f OPP: Introduce dev_pm_opp_find_fre=
q_ceil_by_volt())
Merging thermal/next (c5e7be3b089d Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fall=
-throughs)
Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfaces)
Merging swiotlb/linux-next (8395c154abb7 swiotlb: dump used and total slots=
 when swiotlb buffer is full (v2))
Merging rdma/for-next (b9b0f34531e0 uverbs: Convert idr to XArray)
Merging net-next/master (f76c4b571fee Merge branch 'net-mvpp2-cls-Add-class=
ification')
CONFLICT (content): Merge conflict in net/ipv6/route.c
CONFLICT (content): Merge conflict in net/ipv4/xfrm4_policy.c
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/mv=
m/debugfs-vif.c
CONFLICT (content): Merge conflict in .mailmap
Merging bpf-next/master (2b5bc3c8ebce r8169: remove manual autoneg restart =
workaround)
Merging ipsec-next/master (bb9cd077e216 xfrm: remove unneeded export_symbol=
s)
Applying: xfrm4: fix up for moved _decode_session4
Merging mlx5-next/mlx5-next (91a40a48d52d net/mlx5: Fix broken hca cap offs=
et)
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/main.c
Merging netfilter-next/master (1de6f3342191 netfilter: connlabels: fix spel=
ling mistake "trackling" -> "tracking")
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (5a489b99ecbc Merge tag 'mt76-for-kval=
o-2019-05-01' of https://github.com/nbd168/wireless)
CONFLICT (content): Merge conflict in drivers/net/wireless/intel/iwlwifi/fw=
/file.h
Merging bluetooth/master (aa5658534f4f dt-bindings: net: bluetooth: Add dev=
ice tree bindings for QTI chip WCN3998)
Merging mac80211-next/master (88d6272acaaa net: phy: avoid unneeded MDIO re=
ads in genphy_read_status)
Merging gfs2/for-next (08b22006ad4e gfs2: Fix iomap write page reclaim dead=
lock)
Merging mtd/mtd/next (9e98c678c2d6 Linux 5.1-rc1)
Merging nand/nand/next (1c14fe2167ef mtd: nandsim: switch to exec_op interf=
ace)
Merging spi-nor/spi-nor/next (dcb4b22eeaf4 spi-nor: s25fl512s supports regi=
on locking)
Merging crypto/master (1036633e10f8 crypto: ecrdsa - select ASN1 and OID_RE=
GISTRY for EC-RDSA)
Merging drm/drm-next (060cebb20cdb drm: introduce a capability flag for syn=
cobj timeline support)
CONFLICT (content): Merge conflict in drivers/gpu/drm/virtio/virtgpu_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/virtio/virtgpu_drv.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_fbdev.c
Applying: drm/virtio: fix up bad merge of virtgpu_gem_prime_get_sg_table
Merging amdgpu/drm-next (9cf211b86430 drm/amdkfd: Adjust weight to represen=
t num_hops info when report xgmi iolink)
Merging drm-intel/for-linux-next (9628e15ca9d5 drm/i915/icl: Whitelist GEN9=
_SLICE_COMMON_ECO_CHICKEN1)
Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CPU-=
cache maintenance for BO's allocated using get_pages())
Merging drm-misc/for-linux-next (761e473f6b23 drm/gem: Fix sphinx warnings)
Merging drm-msm/msm-next (b02872df58ac drm/msm/a6xx: Don't enable GPU state=
 code if dependencies are missing)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (ed94cfab195f drm/komeda: Use memset t=
o initialize config_id)
Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermark =
feature)
Merging etnaviv/etnaviv/next (fd2450a77d33 drm/etnaviv: clean up etnaviv_ge=
m_new_handle)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (615c4d9a50e2 Merge branch 'regmap-5.2' into regmap=
-next)
Merging sound/for-next (f495222e2827 ALSA: hda - Register irq handler after=
 the chip initialization)
Merging sound-asoc/for-next (5b89c74d6724 Merge branch 'asoc-5.2' into asoc=
-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging modules/modules-next (fde1bd9b0ceb kernel/module: Reschedule while =
waiting for modules to finish loading)
Merging input/next (7b5bb55d0dad Input: add support for Azoteq IQS550/572/5=
25)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ven=
dor-prefixes.txt
Merging block/for-next (33a213b75fd5 Merge branch 'for-5.2/block' into for-=
next)
Merging device-mapper/for-next (940bc471780b dm mpath: always free attached=
_handler_name in parse_path())
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (7a8b9daf7ea6 mmc: omap_hsmmc: Use dev_get_drvdata())
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (7f042743306c mfd: cros_ec: Instantiate the CrOS U=
SB PD logger driver)
Merging backlight/for-backlight-next (a6d6a589cb09 video: lcd: Remove usele=
ss BACKLIGHT_CLASS_DEVICE dependencies)
Merging battery/for-next (61e93655fc30 power: supply: core: Add missing doc=
umentation for CHARGE_CONTROL_* properties)
Merging regulator/for-next (5d8a6506ef59 Merge branch 'regulator-5.2' into =
regulator-next)
Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' into =
next-testing)
Merging apparmor/apparmor-next (058c4f342582 apparmor: fix spelling mistake=
 "immutible" -> "immutable")
Merging integrity/next-integrity (a2ffe5774e8e selftests/kexec: update get_=
secureboot_mode)
Merging selinux/next (35a196bef449 proc: prevent changes to overridden cred=
entials)
CONFLICT (content): Merge conflict in scripts/selinux/mdp/mdp.c
Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during "g=
et random")
Merging watchdog/master (458c8961c194 watchdog: w83877f_wdt: Mark expected =
switch fall-through)
Merging iommu/next (398ece5bde7e Merge branches 'arm/tegra', 'arm/mediatek'=
, 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (41be3e261817 vfio: Fix WARNING "do not call blocking ops=
 when !TASK_RUNNING")
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (70c4cf17e445 audit: fix a memory leak bug)
CONFLICT (content): Merge conflict in kernel/seccomp.c
CONFLICT (content): Merge conflict in arch/mips/kernel/ptrace.c
Merging devicetree/for-next (440868661f36 of: fix clang -Wunsequenced for b=
e32_to_cpu())
Merging mailbox/mailbox-for-next (17b860bbfc84 mailbox: imx: keep MU irq wo=
rking during suspend/resume)
Merging spi/for-next (2e5f081003f0 Merge branch 'spi-5.2' into spi-next)
Merging tip/auto-latest (bc94903cc4a3 Merge branch 'core/core')
CONFLICT (content): Merge conflict in mm/kasan/Makefile
CONFLICT (content): Merge conflict in arch/x86/kernel/irq_64.c
CONFLICT (content): Merge conflict in arch/s390/include/asm/Kbuild
CONFLICT (content): Merge conflict in arch/arm64/include/asm/Kbuild
Merging clockevents/clockevents/next (dbfc6db7ba46 soc/tegra: default selec=
t TEGRA_TIMER for Tegra210)
Merging edac-amd/for-next (74676a8e247a arm64: dts: stratix10: Use new Stra=
tix10 EDAC bindings)
Merging irqchip/irq/irqchip-next (009669e74813 arm64: arch_k3: Enable inter=
rupt controller drivers)
Merging ftrace/for-next (070ea1a24f40 function_graph: Place ftrace_graph_en=
try_stub() prototype in include/linux/ftrace.h)
Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
Merging kvm/linux-next (3a1e5e4a2c7a Revert "KVM: doc: Document the life cy=
cle of a VM and its resources")
Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register mask=
ing logic)
Merging kvm-ppc/kvm-ppc-next (0caecf5b0019 KVM: PPC: Book3S HV: XIVE: Clear=
 escalation interrupt pointers on device close)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging kvms390/next (b2d0371d2e37 KVM: s390: vsie: Return correct values f=
or Invalid CRYCB format)
Merging xen-tip/linux-next (72813bfbf027 xen/pvh: correctly setup the PV EF=
I interface for dom0)
Merging percpu/for-next (cb453ce4846b Merge branch 'for-5.2' into for-next)
Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
Merging drivers-x86/for-next (98e2630284ab platform/x86: alienware-wmi: fix=
 kfree on potentially uninitialized pointer)
Merging chrome-platform/for-next (cdb80268a6b5 platform/chrome: wilco_ec: A=
dd property helper library)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (05b8ccfba5d4 ALSA: line6: Avoid polluting led_* name=
space)
Merging ipmi/for-next (ed6c3a6d8996 ipmi: Remove warning if no slave addres=
s is present)
Merging driver-core/driver-core-next (391c0325cc5f Revert "driver core: pla=
tform: Fix the usage of platform device name(pdev->name)")
CONFLICT (content): Merge conflict in block/blk-sysfs.c
Merging usb/usb-next (ce64cea47cc4 usb: isp1760-hcd: Fix fall-through annot=
ations)
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (80ed53707bb3 USB: serial: drop unused iflag ma=
cro)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (708310711e6c dt-bindings: phy-qcom-qmp: Tweak qcom,m=
sm8998-qmp-ufs-phy)
Merging tty/tty-next (45c054d0815b tty: serial: add driver for the SiFive U=
ART)
Merging char-misc/char-misc-next (e21107aa6bf3 Merge tag 'soundwire-5.2-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into cha=
r-misc-next)
CONFLICT (content): Merge conflict in drivers/misc/Makefile
CONFLICT (content): Merge conflict in drivers/misc/Kconfig
Merging extcon/extcon-next (00053de52231 extcon: arizona: Disable mic detec=
t if running when driver is removed)
Merging soundwire/next (1eea00d8e714 soundwire: cadence_master: remove spur=
ious newline)
Merging thunderbolt/next (37209783c73a thunderbolt: Make priority unsigned =
in struct tb_path)
Merging staging/staging-next (0580db2cb6b3 staging: rtl8192u: ieee80211: Re=
solve ERROR reported by checkpatch)
CONFLICT (modify/delete): drivers/staging/mt7621-spi/Makefile deleted in HE=
AD and modified in staging/staging-next. Version staging/staging-next of dr=
ivers/staging/mt7621-spi/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/mt7621-spi/Kconfig deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of dri=
vers/staging/mt7621-spi/Kconfig left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36060.h deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36060.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36060.c deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36060.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36057.h deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36057.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36050.h deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36050.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36050.c deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36050.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36016.h deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36016.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zr36016.c deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/zoran/zr36016.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_procfs.h delete=
d in HEAD and modified in staging/staging-next. Version staging/staging-nex=
t of drivers/staging/media/zoran/zoran_procfs.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_procfs.c delete=
d in HEAD and modified in staging/staging-next. Version staging/staging-nex=
t of drivers/staging/media/zoran/zoran_procfs.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_driver.c delete=
d in HEAD and modified in staging/staging-next. Version staging/staging-nex=
t of drivers/staging/media/zoran/zoran_driver.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_device.h delete=
d in HEAD and modified in staging/staging-next. Version staging/staging-nex=
t of drivers/staging/media/zoran/zoran_device.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_device.c delete=
d in HEAD and modified in staging/staging-next. Version staging/staging-nex=
t of drivers/staging/media/zoran/zoran_device.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_card.h deleted =
in HEAD and modified in staging/staging-next. Version staging/staging-next =
of drivers/staging/media/zoran/zoran_card.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran_card.c deleted =
in HEAD and modified in staging/staging-next. Version staging/staging-next =
of drivers/staging/media/zoran/zoran_card.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/zoran.h deleted in HE=
AD and modified in staging/staging-next. Version staging/staging-next of dr=
ivers/staging/media/zoran/zoran.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/videocodec.h deleted =
in HEAD and modified in staging/staging-next. Version staging/staging-next =
of drivers/staging/media/zoran/videocodec.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/videocodec.c deleted =
in HEAD and modified in staging/staging-next. Version staging/staging-next =
of drivers/staging/media/zoran/videocodec.c left in tree.
CONFLICT (modify/delete): drivers/staging/media/zoran/Kconfig deleted in HE=
AD and modified in staging/staging-next. Version staging/staging-next of dr=
ivers/staging/media/zoran/Kconfig left in tree.
CONFLICT (modify/delete): drivers/staging/media/mt9t031/Makefile deleted in=
 HEAD and modified in staging/staging-next. Version staging/staging-next of=
 drivers/staging/media/mt9t031/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/media/mt9t031/Kconfig deleted in =
HEAD and modified in staging/staging-next. Version staging/staging-next of =
drivers/staging/media/mt9t031/Kconfig left in tree.
CONFLICT (content): Merge conflict in drivers/staging/erofs/unzip_vle.c
CONFLICT (content): Merge conflict in drivers/staging/erofs/data.c
CONFLICT (content): Merge conflict in drivers/spi/spi-mt7621.c
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/ven=
dor-prefixes.txt
$ git rm -f drivers/staging/media/mt9t031/Kconfig drivers/staging/media/mt9=
t031/Makefile drivers/staging/mt7621-spi/Kconfig drivers/staging/mt7621-spi=
/Makefile drivers/staging/media/zoran/Kconfig drivers/staging/media/zoran/v=
ideocodec.c drivers/staging/media/zoran/videocodec.h drivers/staging/media/=
zoran/zoran.h drivers/staging/media/zoran/zoran_card.c drivers/staging/medi=
a/zoran/zoran_card.h drivers/staging/media/zoran/zoran_device.c drivers/sta=
ging/media/zoran/zoran_device.h drivers/staging/media/zoran/zoran_driver.c =
drivers/staging/media/zoran/zoran_procfs.c drivers/staging/media/zoran/zora=
n_procfs.h drivers/staging/media/zoran/zr36016.c drivers/staging/media/zora=
n/zr36016.h drivers/staging/media/zoran/zr36050.c drivers/staging/media/zor=
an/zr36050.h drivers/staging/media/zoran/zr36057.h drivers/staging/media/zo=
ran/zr36060.c drivers/staging/media/zoran/zr36060.h
Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_ATT=
RIBUTE)
Merging slave-dma/next (c6504be53972 dmaengine: stm32-dma: Fix unsigned var=
iable compared with zero)
Merging cgroup/for-next (cd4f686eb6df Merge branch 'for-5.2' into for-next)
Merging scsi/for-next (aec67294b839 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/lpfc/lpfc_els.c
CONFLICT (add/add): Merge conflict in drivers/phy/mediatek/phy-mtk-ufs.c
Merging scsi-mkp/for-next (9bee24d08c08 scsi: fdomain: Resurrect driver - P=
CI support)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (4e76105b74c1 virtio: use dependent_ptr_mb)
CONFLICT (content): Merge conflict in drivers/pci/of.c
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (93c6d8ca2807 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (b0d2569d8276 gpio: mlxbf: remove unused in=
cluding <linux/version.h>)
Merging pinctrl/for-next (b7cd97cd140f Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging pwm/for-next (9ff06679e109 pwm: sysfs: fix typo "its" -> "it's")
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (b7d5dc21072c random: add a spinlock_t to struct batched=
_entropy)
Merging kselftest/next (d917fb876f6e selftests: build and run gpio when out=
put directory is the src dir)
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (7df6a9f68d5d Merge branch 'for-5.2-core' int=
o for-next)
Merging coresight/next (b627167ed8e6 coresight: funnel: Support static funn=
el)
Merging rtc/rtc-next (87ccec4fd05d rtc: pcap: convert to SPDX identifier)
CONFLICT (content): Merge conflict in drivers/rtc/rtc-omap.c
Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax' =
into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/dax.c
Merging at24/at24/for-next (d333bad1f6f3 dt-bindings: at24: add Renesas R1E=
X24016)
Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (7f6563fc1e6b Merge branch 'for-linus/seccomp' i=
nto for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (7cc10c5cb143 gnss: ubx: add u-blox,neo-6m compatibl=
e)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (80471330ec58 slimbus: fix a NULL pointer derefere=
nce in of_qcom_slim_ngd_register)
Merging nvmem/for-next (889ba60c36ce nvmem: core: add NVMEM_SYSFS Kconfig)
Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibility)
Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a modul=
e desription to the hyperv_keyboard driver)
Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make backl=
ight initial state configurable)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (eb364bbe6791 samples: show race-free pidfd metadata=
 access)
CONFLICT (content): Merge conflict in samples/Makefile
Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for schedu=
ling work)
Merging akpm-current/current (b78fc46079e4 ipc-do-cyclic-id-allocation-for-=
the-ipc-object-fix)
CONFLICT (content): Merge conflict in mm/vmalloc.c
CONFLICT (content): Merge conflict in kernel/fork.c
CONFLICT (modify/delete): arch/s390/mm/gup.c deleted in HEAD and modified i=
n akpm-current/current. Version akpm-current/current of arch/s390/mm/gup.c =
left in tree.
CONFLICT (content): Merge conflict in arch/powerpc/platforms/Kconfig.cputype
CONFLICT (content): Merge conflict in arch/powerpc/mm/mmu_context_iommu.c
CONFLICT (content): Merge conflict in arch/powerpc/mm/mem.c
CONFLICT (content): Merge conflict in arch/parisc/mm/init.c
CONFLICT (content): Merge conflict in arch/nios2/Kconfig
CONFLICT (content): Merge conflict in arch/m68k/Kconfig
$ git rm -f arch/s390/mm/gup.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: fs/coda/psdev.c: remove duplicate header
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs/cachefiles/namei.c: remove duplicate header
Applying: fs/block_dev.c: Remove duplicate header
Applying: treewide: replace #include <asm/sizes.h> with #include <linux/siz=
es.h>
Applying: arch: remove <asm/sizes.h> and <asm-generic/sizes.h>
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm-rename-ambiguously-named-memorystat-counters-and-functions-fix
Applying: mm, memcg: consider subtrees in memory.events
Applying: drivers/virt/fsl_hypervisor.c: dereferencing error pointers in io=
ctl
Applying: drivers/virt/fsl_hypervisor.c: prevent integer overflow in ioctl
Applying: mm: memcontrol: make cgroup stats and events query API explicitly=
 local
Applying: mm-memcontrol-make-cgroup-stats-and-events-query-api-explicitly-l=
ocal-fix
Applying: mm: memcontrol: move stat/event counting functions out-of-line
Applying: mm: memcontrol: fix recursive statistics correctness & scalabilty
Applying: mm: memcontrol: fix NUMA round-robin reclaim at intermediate level
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (35eaa57007cd drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/.JQ1w3siGsZ+htIUgzOtaVT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKwhQACgkQAVBC80lX
0GwlTAf/c3hVMWqKNlN8qvRqXbAS3E+yA6IKb+cfpFOMjVNOiZCw1G7xJek/Rz46
dcgBD/rFSbYbPXh58QjLFpaR+gDdgmUyWcc9S/3UQIWMt46cbx6GYo92qBIBq7jm
/WqUf4oLojSn2nosicxrYQvOy6X8ChE4mQ0aBvkJgjaiUbtfoReMzAPb11lrxGjB
wU4DC+eiJD+ZEVBmBMljUeoprgiHixBgaaw/e2HyDhRfxnyzRXqOA8I6aXtZ30Pv
oGlTPNP654bDOzZVi+oMlvKL3exCI/F11Mphx1xBclIIGvpjPuWPjHb+sgeZKI6m
iK6iDQ8jMRHYuBokmi2gRZq4VcLo/A==
=dmuc
-----END PGP SIGNATURE-----

--Sig_/.JQ1w3siGsZ+htIUgzOtaVT--
