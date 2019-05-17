Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFA9C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D1F206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpkDzvLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfEQHdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:33:53 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39548 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfEQHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:33:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id x5so2287178ybn.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i0Oyc8t5jClE9gHj0fyck9NhY/ZvwP9di2+q36X+1pk=;
        b=bpkDzvLmz1wg8/SOdQQpRTnXCKhpUkWakUEu4hD8bbCVPHhZQs4tnozsf5s7NZktR2
         xebJnQo2Svk9/gdRv0gmIMev+vRNLr906vHAglPkO0mB6o2af66qBjLhWsulIANOVuFS
         r0yoJLRnaASgjYsAs58KU6Xk1pQ/XK9U9X+QMzxNToDm3iPNEHlOBYU5wh6iC1EQnNA+
         xyAYkYC/IWh4LC/A4HVzXzL8TJ62a/0fZIm3Ejkf7dlzh52rBbzlINS34cSdv51TUmKR
         3Es+wEtkBHLlfDx+Xt2/FoKB47mMGdcL1pRHqiFtjwcIrV/E2rRqNr2yC8/C5BPlKpha
         /X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i0Oyc8t5jClE9gHj0fyck9NhY/ZvwP9di2+q36X+1pk=;
        b=sOw8AWqubgb+60/GtPzSV3BY/yzNUjGDGxYSOJPkIiQqElqef24Yi3YLfKzlxZIPqJ
         o9e7FIKm1EjZ5HMHCjydny2jAWq9J7AkXOh6aySBSsAS6/2wqLUE4w6MLl652y5eG+QB
         9ys4C/VK08oRxjcDMuR0hDlQ1BAq8XhIOJ90Hs/sJdrbFMhrwxvBAItXMb6SywDkAOE4
         VSBdnWYWLCpGXSanRscLCfhaAbdL2criIAV7yMYE0ICeJBxVM3w2r17rHDbB0nfu9FrF
         Idsuh4GSFgyEDH3tc5R4C5fzNHOFQix1CaoruLmp3XFdAPkK48aeIaEfxjicLtspu8Eo
         Psag==
X-Gm-Message-State: APjAAAUzeEN/pbG1oTnyJLv5ZCnWEjYEmqQAjvQ86C5ZmF6MEfOL0FK2
        BfG++1UIHd5LyhAFJBeJMr0dQNwnHd2Ybg8le2D+pkGtqtGdZw==
X-Google-Smtp-Source: APXvYqwCY1CY0i3xMpc7UMrZH8eGWLK2w17tuAwV7rQzrAauzaDv+YfMvYQPDbndY4X6cQZzeWlbMCeMeuKzx4YvsN8=
X-Received: by 2002:a25:f509:: with SMTP id a9mr27750602ybe.391.1558078430580;
 Fri, 17 May 2019 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190517142152.588edb6e@canb.auug.org.au>
In-Reply-To: <20190517142152.588edb6e@canb.auug.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 17 May 2019 09:33:39 +0200
Message-ID: <CADYN=9Jan5Kwf5ZZPZNfa27CF=qjSiRwXnV-2gjE=OeL5e1EJw@mail.gmail.com>
Subject: Re: linux-next: Tree for May 17
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 at 06:21, Stephen Rothwell <sfr@canb.auug.org.au> wrote=
:
>
> Hi all,
>
> Please do not add any v5.3 material to your linux-next included
> trees/branches until after v5.2-rc1 has been released.
>
> Changes since 20190516:
>
> The kvm tree gained conflicts against Linus' tree.

When I built arm64 I saw this build failure:
../arch/arm64/kvm/../../../virt/kvm/kvm_main.c: In function =E2=80=98__kvm_=
map_gfn=E2=80=99:
../arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:9: error: implicit
declaration of function =E2=80=98memremap=E2=80=99; did you mean =E2=80=98m=
emcmp=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
   hva =3D memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
         ^~~~~~~~
         memcmp
../arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:46: error:
=E2=80=98MEMREMAP_WB=E2=80=99 undeclared (first use in this function)
   hva =3D memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
                                              ^~~~~~~~~~~
../arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1764:46: note: each
undeclared identifier is reported only once for each function it
appears in
../arch/arm64/kvm/../../../virt/kvm/kvm_main.c: In function =E2=80=98kvm_vc=
pu_unmap=E2=80=99:
../arch/arm64/kvm/../../../virt/kvm/kvm_main.c:1796:3: error: implicit
declaration of function =E2=80=98memunmap=E2=80=99; did you mean =E2=80=98v=
m_munmap=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
   memunmap(map->hva);
   ^~~~~~~~
   vm_munmap
cc1: some warnings being treated as errors
make[2]: *** [../scripts/Makefile.build:279:
arch/arm64/kvm/../../../virt/kvm/kvm_main.o] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/home/anders/src/kernel/next/Makefile:1071:
arch/arm64/kvm] Error 2

is this something that should be added maybe?

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8d83a787fd6b..5c5102799c2c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -51,6 +51,7 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/bsearch.h>
+#include <linux/io.h>

 #include <asm/processor.h>
 #include <asm/io.h>


Cheers,
Anders

>
> Non-merge commits (relative to Linus' tree): 1023
>  1119 files changed, 27058 insertions(+), 7629 deletions(-)
>
> -------------------------------------------------------------------------=
---
>
> I have created today's linux-next tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> (patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
> are tracking the linux-next tree using git, you should not use "git pull"
> to do so as that will try to merge the new linux-next release with the
> old one.  You should use "git fetch" and checkout or reset to the new
> master.
>
> You can see which trees have been included by looking in the Next/Trees
> file in the source.  There are also quilt-import.log and merge.log
> files in the Next directory.  Between each merge, the tree was built
> with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
> multi_v7_defconfig for arm and a native build of tools/perf. After
> the final fixups (if any), I do an x86_64 modules_install followed by
> builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
> ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
> and sparc64 defconfig. And finally, a simple boot test of the powerpc
> pseries_le_defconfig kernel in qemu (with and without kvm enabled).
>
> Below is a summary of the state of the merge.
>
> I am currently merging 298 trees (counting Linus' and 69 trees of bug
> fix patches pending for the current merge release).
>
> Stats about the size of the tree over time can be seen at
> http://neuling.org/linux-next-size.html .
>
> Status of my local build tests will be at
> http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
> advice about cross compilers/configs that work, we are always open to add
> more builds.
>
> Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
> Gortmaker for triage and bug fixes.
>
> --
> Cheers,
> Stephen Rothwell
>
> $ git checkout master
> $ git reset --hard stable
> Merging origin/master (01be377c6221 Merge tag 'media/v5.2-1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media)
> Merging fixes/master (2bbacd1a9278 Merge tag 'kconfig-v5.2' of git://git.=
kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
> Merging kspp-gustavo/for-next/kspp (ccaa75187a5f memstick: mark expected =
switch fall-throughs)
> Merging kbuild-current/fixes (a2d635decbfa Merge tag 'drm-next-2019-05-09=
' of git://anongit.freedesktop.org/drm/drm)
> Merging arc-current/for-curr (308a06dc72c0 ARC: mm: do_page_fault refacto=
r #8: release mmap_sem sooner)
> Merging arm-current/fixes (e17b1af96b2a ARM: 8857/1: efi: enable CP15 DMB=
 instructions before cleaning the cache)
> Merging arm64-fixes/for-next/fixes (7a0a93c51799 arm64: vdso: Explicitly =
add build-id option)
> Merging m68k-current/for-linus (fdd20ec8786a Documentation/features/time:=
 Mark m68k having modern-timekeeping)
> Merging powerpc-fixes/fixes (12f363511d47 powerpc/32s: Fix BATs setting w=
ith CONFIG_STRICT_KERNEL_RWX)
> Merging sparc/master (63863ee8e2f6 Merge tag 'gcc-plugins-v5.2-rc1' of ss=
h://gitolite.kernel.org/pub/scm/linux/kernel/git/kees/linux)
> Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
> Merging net/master (510e2ceda031 ipv6: fix src addr routing with the exce=
ption table)
> Merging bpf/master (d72386fe7a84 libbpf: move logging helpers into libbpf=
_internal.h)
> Merging ipsec/master (9b3040a6aafd ipv4: Define __ipv4_neigh_lookup_noref=
 when CONFIG_INET is disabled)
> Merging netfilter/master (d4c26eb6e721 net: ethernet: stmmac: dwmac-sun8i=
: enable support of unicast filtering)
> Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function=
 must not have side effects)
> Merging wireless-drivers/master (7a0f8ad5ff63 Merge ath-current from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
> Merging mac80211/master (933b40530b4b mac80211: remove set but not used v=
ariable 'old')
> Merging rdma-fixes/for-rc (2557fabd6e29 RDMA/hns: Bugfix for mapping user=
 db)
> Merging sound-current/for-linus (56df90b631fc ALSA: hda/realtek - Fix for=
 Lenovo B50-70 inverted internal microphone bug)
> Merging sound-asoc-fixes/for-linus (81566b4cbc5d Merge branch 'asoc-5.1' =
into asoc-linus)
> Merging regmap-fixes/for-linus (1d6106cafb37 Merge branch 'regmap-5.1' in=
to regmap-linus)
> Merging regulator-fixes/for-linus (0d183fc1760f Merge branch 'regulator-5=
.1' into regulator-linus)
> Merging spi-fixes/for-linus (72e3b3285a43 Merge branch 'spi-5.1' into spi=
-linus)
> Merging pci-current/for-linus (9c9c5fc89b09 PCI/LINK: Add Kconfig option =
(default off))
> Merging driver-core.current/driver-core-linus (83f3ef3de625 Merge tag 'li=
bnvdimm-fixes-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvd=
imm/nvdimm)
> Merging tty.current/tty-linus (83f3ef3de625 Merge tag 'libnvdimm-fixes-5.=
2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm)
> Merging usb.current/usb-linus (83f3ef3de625 Merge tag 'libnvdimm-fixes-5.=
2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm)
> Merging usb-gadget-fixes/fixes (072684e8c58d USB: gadget: f_hid: fix dead=
lock in f_hidg_write())
> Merging usb-serial-fixes/usb-linus (79a3aaa7b82e Linux 5.1-rc3)
> Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea:=
 fix static checker warning for NULL pointer)
> Merging phy/fixes (e6f32efb1b12 phy: sun4i-usb: Make sure to disable PHY0=
 passby for peripheral mode)
> Merging staging.current/staging-linus (8c05f3b965da Merge tag 'for-linus'=
 of git://git.armlinux.org.uk/~rmk/linux-arm)
> Merging char-misc.current/char-misc-linus (83f3ef3de625 Merge tag 'libnvd=
imm-fixes-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/=
nvdimm)
> Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
> Merging thunderbolt-fixes/fixes (e93c9c99a629 Linux 5.1)
> Merging input-current/for-linus (145b11d1baa3 Input: elan_i2c - increment=
 wakeup count if wake source)
> Merging crypto-current/master (cbc22b062106 Revert "crypto: caam/jr - Rem=
ove extra memory barrier during job ring dequeue")
> Merging ide/master (b970afcfcabd Merge tag 'powerpc-5.2-1' of ssh://gitol=
ite.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
> Merging vfio-fixes/for-linus (492855939bdb vfio/type1: Limit DMA mappings=
 per container)
> Merging kselftest-fixes/fixes (15ade5d2e777 Linux 5.1-rc4)
> Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of =
wrong module .text address)
> Merging slave-dma-fixes/fixes (37624b58542f Linux 5.1-rc7)
> Merging backlight-fixes/for-backlight-fixes (e93c9c99a629 Linux 5.1)
> Merging mtd-fixes/mtd/fixes (9a8f612ca0d6 mtd: rawnand: marvell: Clean th=
e controller state before each operation)
> Merging mfd-fixes/for-mfd-fixes (e93c9c99a629 Linux 5.1)
> Merging v4l-dvb-fixes/fixes (fc8670d1f72b media: rockchip/vpu: Fix/re-ord=
er probe-error/remove path)
> Merging reset-fixes/reset/fixes (d5d4218e1669 reset: remove redundant nul=
l check on pointer dev)
> Merging mips-fixes/mips-fixes (a1e8783db8e0 MIPS: perf: ath79: Fix perfco=
unt IRQ assignment)
> Merging at91-fixes/at91-fixes (ba5e60c9b75d arm/mach-at91/pm : fix possib=
le object reference leak)
> Merging omap-fixes/fixes (1ba12322e2f0 Merge branch 'am5-sdio-fixes' into=
 fixes)
> Merging kvm-fixes/master (e8ab8d24b488 KVM: nVMX: Fix size checks in vmx_=
set_nested_state)
> Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYC=
BD.31 to check CRYCBD validity)
> Merging hwmon-fixes/hwmon (b88c5049219a hwmon: (occ) Fix extended status =
bits)
> Merging nvdimm-fixes/libnvdimm-fixes (c4703ce11c23 libnvdimm/namespace: F=
ix label tracking error)
> Merging btrfs-fixes/next-fixes (4792878ab434 Merge branch 'misc-5.2' into=
 next-fixes)
> Merging vfs-fixes/fixes (05883eee857e do_move_mount(): fix an unsafe use =
of is_anon_ns())
> Merging dma-mapping-fixes/for-linus (8c5165430c01 dma-debug: only skip on=
e stackframe entry)
> Merging i3c-fixes/master (709a53e19484 MAINTAINERS: Fix the I3C entry)
> Merging drivers-x86-fixes/fixes (e93c9c99a629 Linux 5.1)
> Merging samsung-krzk-fixes/fixes (9e98c678c2d6 Linux 5.1-rc1)
> Merging pinctrl-samsung-fixes/pinctrl-fixes (9e98c678c2d6 Linux 5.1-rc1)
> Merging devicetree-fixes/dt/linus (e10e55e9d933 dt-bindings: sifive: desc=
ribe sifive-blocks versioning)
> Merging scsi-fixes/fixes (f4cefcd67067 scsi: bnx2fc: fix incorrect cast t=
o u64 on shift operation)
> Merging drm-fixes/drm-fixes (e93c9c99a629 Linux 5.1)
> Merging amdgpu-fixes/drm-fixes (f7b1844bacec drm/amdgpu: Update gc golden=
 setting for vega family)
> Merging drm-intel-fixes/for-linux-next-fixes (f5c58ba18ab8 drm/i915: Rest=
ore correct bxt_ddi_phy_calc_lane_lat_optim_mask() calculation)
> Merging mmc-fixes/fixes (ec0970e0a1b2 mmc: sdhci-iproc: Set NO_HISPD bit =
to fix HS50 data hold time problem)
> Merging rtc-fixes/rtc-fixes (882c5e552ffd rtc: da9063: set uie_unsupporte=
d when relevant)
> Merging gnss-fixes/gnss-linus (79a3aaa7b82e Linux 5.1-rc3)
> Merging hyperv-fixes/hyperv-fixes (69c8caafb72d hv: tools: fixed Python p=
ep8/flake8 warnings for lsvmbus)
> Merging drm-misc-fixes/for-linux-next-fixes (ab042b824c11 Revert "drm/qxl=
: drop prime import/export callbacks")
> Merging kbuild/for-next (f9d7adc7b0d6 kbuild: remove 'addtree' and 'flags=
' magic for header search paths)
> Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-r=
c7)
> Merging leaks/leaks-next (9e98c678c2d6 Linux 5.1-rc1)
> Merging dma-mapping/for-next (13bf5ced9377 dma-mapping: add a Kconfig sym=
bol to indicate arch_dma_prep_coherent presence)
> Merging asm-generic/master (6edd1dbace0e asm-generic: optimize generic ua=
ccess for 8-byte loads and stores)
> Merging arc/for-next (5908e6b738e3 Linux 5.0-rc8)
> Merging arm/for-next (d486065b35e4 Merge branches 'fixes' and 'misc' into=
 for-next)
> Merging arm64/for-next/core (6127bf372add Merge branch 'for-next/mmiowb' =
of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux into for-next/=
core)
> Merging arm-perf/for-next/perf (9bcb929f969e perf/arm-ccn: Clean up CPU h=
otplug handling)
> Merging arm-soc/for-next (7ad1b252cabe ARM: Document merges)
> Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-s=
ps' into next)
> Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
> Merging amlogic/for-next (68a837de19ed Merge branch 'v5.2/fixes' into tmp=
/aml-rebuild)
> Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enab=
le uart1)
> Merging at91/at91-next (ac650130c227 Merge branches 'at91-soc', 'at91-dt'=
 and 'at91-defconfig' into at91-next)
> Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next=
' into for-next)
> Merging imx-mxs/for-next (d9c3322a2906 Merge branch 'imx/defconfig' into =
for-next)
> CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
> Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' in=
to next)
> Merging mediatek/for-next (73ade6a62931 Merge branch 'v5.1-next/soc' into=
 for-next)
> Merging mvebu/for-next (891f0f865c37 Merge branch 'mvebu/dt64' into mvebu=
/for-next)
> Merging omap/for-next (481df0abf8cf Merge branch 'omap-for-v5.2/ti-sysc' =
into for-next)
> Merging reset/reset/next (21a5d26b8164 reset: Switch to SPDX license iden=
tifier for reset-simple)
> Merging qcom/for-next (1d31c0b1a28a Merge tag 'qcom-arm64-for-5.2-1' into=
 really-done-for-5.2)
> Merging renesas/next (982700f80241 Merge branch 'arm-dt-for-v5.2' into ne=
xt)
> Merging rockchip/for-next (9c539071723e Merge branch 'v5.2-clk/next' into=
 for-next)
> Merging samsung/for-next (bebc6082da0a Linux 4.14)
> Merging samsung-krzk/for-next (831c75782772 Merge branch 'next/dt64' into=
 for-next)
> Merging sunxi/sunxi/for-next (613c4ce8fddb Merge branch 'sunxi/dt-for-5.2=
' into sunxi/for-next)
> Merging tegra/for-next (0c0ffecf65fd Merge branch for-5.2/arm64/defconfig=
 into for-next)
> Merging clk/clk-next (62e59c4e69b3 clk: Remove io.h from clk-provider.h)
> Merging clk-samsung/for-next (3c297d9e65d8 clk: samsung: exynos5410: Add =
gate clock for ADC)
> Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
> Merging csky/linux-next (d2adb7b6249a csky: Select intc & timer drivers)
> Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declarati=
on of pcibios_penalize_isa_irq)
> Merging ia64/next (c51836246f97 ia64: generate uapi header and system cal=
l table files)
> Merging m68k/for-next (fdd20ec8786a Documentation/features/time: Mark m68=
k having modern-timekeeping)
> Merging m68knommu/for-next (37624b58542f Linux 5.1-rc7)
> Merging microblaze/next (226a893bbb1f microblaze: no need to check return=
 value of debugfs_create functions)
> Merging mips/mips-next (b1e479e3dcbc MIPS: Alchemy: add DMA masks for on-=
chip ethernet)
> CONFLICT (content): Merge conflict in arch/mips/sgi-ip27/ip27-irq.c
> Merging nds32/next (af9abd65983c nds32: Fix vDSO clock_getres())
> Merging nios2/for-next (21e6bff5e0ef nios2: Fix update_mmu_cache preload =
the TLB with the new PTE)
> Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arc=
h/or32)
> Merging parisc-hd/for-next (4d658e1524ee parisc: Allow building 64-bit ke=
rnel without -mlong-calls compiler option)
> Merging powerpc/next (8150a153c013 powerpc/64s: Use early_mmu_has_feature=
() in set_kuap())
> Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_=
dma_set_mask")
> Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' =
of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
> Merging risc-v/for-next (81eba518d95f RISC-V: sifive_l2_cache: Add L2 cac=
he controller driver for SiFive SoCs)
> Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
> Merging s390/features (f3e20ad67b4c s390: move arch/s390/defconfig to arc=
h/s390/configs/defconfig)
> Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git=
.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
> Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
> Merging uml/linux-next (1987b1b8f9f1 um: irq: don't set the chip for all =
irqs)
> Merging xtensa/xtensa-for-next (0542593fff0f Merge branch 'xtensa-for-nex=
t' into xtensa-5.2-fixes)
> Merging fscrypt/master (2c58d548f570 fscrypt: cache decrypted symlink tar=
get in ->i_link)
> Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding st=
andard issues)
> Merging btrfs/next (29dcea88779c Linux 4.17)
> Merging btrfs-kdave/for-next (6fc9f4e59957 Merge branch 'for-next-current=
-v5.1-20190509' into for-next-20190509)
> Merging ceph/master (00abf69dd24f ceph: flush dirty inodes before proceed=
ing with remount)
> Merging cifs/for-next (dece44e381ab cifs: add support for SEEK_DATA and S=
EEK_HOLE)
> Merging configfs/for-next (35399f87e271 configfs: fix possible use-after-=
free in configfs_register_group)
> Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with =
ecryptfs_xattr mount option when create readonly file)
> Merging ext3/for_next (91e9f2c1d861 Merge quota fix from Chengguang.)
> Merging ext4/dev (0c72924ef346 ext4: fix block validity checks for journa=
l inodes using indirect blocks)
> Merging f2fs/dev (e0654264c480 Merge tag 'backlight-next-5.2' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/lee/backlight)
> Merging fuse/for-next (9031a69cf9f0 fuse: clean up fuse_alloc_inode)
> Merging jfs/jfs-next (a5fdd713d256 jfs: fix bogus variable self-initializ=
ation)
> Merging nfs/linux-next (d7a02fa0a8f9 Merge tag 'upstream-5.2-rc1' of ssh:=
//gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs)
> Merging nfs-anna/linux-next (5940d1cf9f42 SUNRPC: Rebalance a kref in aut=
h_gss.c)
> Merging nfsd/nfsd-next (1c73b9d24f80 nfsd: update callback done processin=
g)
> Merging orangefs/for-next (33713cd09ccd orangefs: truncate before updatin=
g size)
> Merging overlayfs/overlayfs-next (acf3062a7e1c ovl: relax WARN_ON() for o=
verlapping layers use case)
> Merging ubifs/linux-next (c16e73587ad6 ubifs: Don't leak orphans on memor=
y during commit)
> Merging v9fs/9p-next (80a316ff1627 9p/xen: Add cleanup path in p9_trans_x=
en_init)
> Merging xfs/for-next (8869a2d297cb Merge remote-tracking branch 'korg/iom=
ap-5.2-merge' into for-next)
> Merging file-locks/locks-next (945ab8f6de94 locks: wake any locks blocked=
 on request before deadlock check)
> Merging vfs/for-next (6e14c3cf8bc4 Merge branch 'work.icache' into for-ne=
xt)
> CONFLICT (content): Merge conflict in Documentation/filesystems/porting
> Merging printk/for-next (967aa2217b6d Merge branch 'for-5.2-fixes' into f=
or-next)
> Merging pci/next (c7a1c2bbb65e Merge branch 'pci/trivial')
> Merging pstore/for-next/pstore (0be6a6927254 pstore/ram: Improve backward=
 compatibility with older Chromebooks)
> Merging hid/for-next (eb18d1215405 Merge branch 'for-5.2/logitech' into f=
or-next)
> Merging i2c/i2c/for-next (8d1d950a6072 Merge branch 'i2c/for-5.2' into i2=
c/for-next)
> Merging i3c/i3c/next (476c7e1d34f2 i3c: Fix a shift wrap bug in i3c_bus_s=
et_addr_slot_status())
> Merging dmi/master (57361846b52b Linux 4.19-rc2)
> Merging hwmon-staging/hwmon-next (39abe9d88b30 hwmon: (lm75) Add support =
for TMP75B)
> Merging jc_docs/docs-next (afbd4d42470e Merge branch 'x86' into docs-next=
)
> Merging v4l-dvb/master (fc8670d1f72b media: rockchip/vpu: Fix/re-order pr=
obe-error/remove path)
> Merging v4l-dvb-next/master (a455eda33faa Merge branch 'linus' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal)
> Merging fbdev/fbdev-for-next (d4a5611743a6 video: fbdev: Use dev_get_drvd=
ata())
> Merging pm/linux-next (03216f1a350e Merge branch 'acpi-pm' into linux-nex=
t)
> Merging cpufreq-arm/cpufreq/arm/linux-next (8db82563451f cpufreq: armada-=
37xx: fix frequency calculation for opp)
> Merging cpupower/cpupower (21027e78e7c1 cpupower: correct spelling of int=
erval)
> Merging opp/opp/linux-next (2f36bde0fc8f OPP: Introduce dev_pm_opp_find_f=
req_ceil_by_volt())
> Merging thermal/next (6df24c3e81b9 Merge branches 'thermal-core', 'therma=
l-built-it' and 'thermal-intel' into next)
> Merging thermal-soc/next (37bcec5d9f71 hwmon: (pwm-fan) Use devm_thermal_=
of_cooling_device_register)
> Merging ieee1394/for-next (812cd88749e0 firewire: mark expected switch fa=
ll-throughs)
> Merging dlm/next (54cca4bad076 dlm: allow binding to all network interfac=
es)
> Merging swiotlb/linux-next (063b8271ec8f swiotlb-xen: ensure we have a si=
ngle callsite for xen_dma_map_page)
> Merging rdma/for-next (c191f93454bc net/mlx5: Set completion EQs as share=
d resources)
> Merging net-next/master (35c99ffa20ed Merge tag 'for_linus' of git://git.=
kernel.org/pub/scm/linux/kernel/git/mst/vhost)
> Merging bpf-next/master (35c99ffa20ed Merge tag 'for_linus' of git://git.=
kernel.org/pub/scm/linux/kernel/git/mst/vhost)
> Merging ipsec-next/master (601e6bcc4ef0 Merge git://git.kernel.org/pub/sc=
m/linux/kernel/git/davem/net)
> Merging mlx5-next/mlx5-next (91a40a48d52d net/mlx5: Fix broken hca cap of=
fset)
> Merging netfilter-next/master (601e6bcc4ef0 Merge git://git.kernel.org/pu=
b/scm/linux/kernel/git/davem/net)
> Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warni=
ngs)
> Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus po=
rt values for other l4 protocols)
> Merging wireless-drivers-next/master (f9b628d61fae rtw88: add license for=
 Makefile)
> Merging bluetooth/master (62a91990f4c5 Bluetooth: hci_qca: Rename STATE_<=
flags> to QCA_<flags>)
> Merging mac80211-next/master (80f232121b69 Merge git://git.kernel.org/pub=
/scm/linux/kernel/git/davem/net-next)
> Merging gfs2/for-next (fbcde197e1be gfs2: Fix error path kobject memory l=
eak)
> Merging mtd/mtd/next (3008ba870938 mtd: part: fix incorrect format specif=
ier for an unsigned long long)
> Merging nand/nand/next (1c14fe2167ef mtd: nandsim: switch to exec_op inte=
rface)
> Merging spi-nor/spi-nor/next (e43f53c22a93 spi-nor: intel-spi: Add suppor=
t for Intel Comet Lake SPI serial flash)
> Merging crypto/master (e59f755ceb6d crypto: ccree - use a proper le32 typ=
e for le32 val)
> Merging drm/drm-next (8da0e1525b7f Merge tag 'drm-misc-next-fixes-2019-05=
-15' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
> Merging amdgpu/drm-next (af6a5febf001 drm/amd/powerplay: Fix maybe-uninit=
ialized in get_ppfeature_status)
> Merging drm-intel/for-linux-next (c36beba6b296 drm/i915: Seal races betwe=
en async GPU cancellation, retirement and signaling)
> Merging drm-tegra/drm/tegra/for-next (61b51fb51c01 drm/tegra: gem: Fix CP=
U-cache maintenance for BO's allocated using get_pages())
> Merging drm-misc/for-linux-next (51a0d1a90bff drm/sun4i: sun6i_mipi_dsi: =
Fix hsync_porch overflow)
> Merging drm-msm/msm-next (b02872df58ac drm/msm/a6xx: Don't enable GPU sta=
te code if dependencies are missing)
> Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atom=
ic commits that disable only the plane)
> Merging mali-dp/for-upstream/mali-dp (15e9122d9b5c drm/komeda: Mark the l=
ocal functions as static)
> Merging imx-drm/imx-drm/next (5d5fe9970c76 drm/imx: enable IDMAC watermar=
k feature)
> Merging etnaviv/etnaviv/next (2b76f5be7c27 drm/etnaviv: initialize idle m=
ask before querying the HW db)
> Merging kconfig/for-next (bebc6082da0a Linux 4.14)
> Merging regmap/for-next (a136e5257f67 Merge branch 'regmap-5.2' into regm=
ap-next)
> Merging sound/for-next (56df90b631fc ALSA: hda/realtek - Fix for Lenovo B=
50-70 inverted internal microphone bug)
> Merging sound-asoc/for-next (78c1aaab61fa Merge branch 'asoc-5.2' into as=
oc-next)
> Merging modules/modules-next (dadec066d8fa module: add stubs for within_m=
odule functions)
> Merging input/next (b283d0c353de Input: eeti_ts -  read hardware state on=
ce after wakeup)
> Merging block/for-next (e35d0b782065 Merge branch 'for-5.2/block-post' in=
to for-next)
> Merging device-mapper/for-next (8454fca4f53b dm: fix a couple brace codin=
g style issues)
> Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protoco=
l disabling for Ricoh bridges)
> Merging mmc/next (0a49a619e7e1 mmc: sdhci-pci: Fix BYT OCP setting)
> Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers =
instead of hashed addresses)
> CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
> Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by bar=
rier)
> Merging mfd/for-mfd-next (ed835136ee67 mfd: Use dev_get_drvdata() directl=
y)
> Merging backlight/for-backlight-next (53fa0f87177d backlight: lm3630a: Ad=
d firmware node support)
> Merging battery/for-next (baf5964ecfe1 power: supply: olpc_battery: force=
 the le/be casts)
> Merging regulator/for-next (16f26207b3b1 Merge branch 'regulator-5.2' int=
o regulator-next)
> Merging security/next-testing (5664f5faac11 Merge branch 'next-smack' int=
o next-testing)
> Merging apparmor/apparmor-next (06c13f554a71 apparmor: re-introduce a var=
iant of PROFILE_MEDIATES_SAFE)
> Merging integrity/next-integrity (a2ffe5774e8e selftests/kexec: update ge=
t_secureboot_mode)
> Merging selinux/next (35a196bef449 proc: prevent changes to overridden cr=
edentials)
> Merging tpmdd/next (ff89e2f4b34d tpm: Actually fail on TPM errors during =
"get random")
> Merging watchdog/master (a9f0bda567e3 watchdog: Enforce that at least one=
 pretimeout governor is enabled)
> Merging iommu/next (b5531563e8a0 Merge branches 'arm/tegra', 'arm/mediate=
k', 'arm/smmu', 'x86/vt-d', 'x86/amd' and 'core' into next)
> Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
> Merging vfio/next (15c80c1659f2 vfio: Add Cornelia Huck as reviewer)
> Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
> Merging audit/next (70c4cf17e445 audit: fix a memory leak bug)
> Merging devicetree/for-next (2a656cb5a4a3 of: unittest: Remove error prin=
ting on OOM)
> Merging mailbox/mailbox-for-next (8fbbfd966efa mailbox: Add support for A=
rmada 37xx rWTM mailbox)
> Merging spi/for-next (aa459d194583 Merge remote-tracking branch 'spi/topi=
c/bpw-check' into spi-next)
> Merging tip/auto-latest (09feda54b176 Merge branch 'core/mm')
> Merging clockevents/clockevents/next (8c9374068ef6 misc: atmel_tclib: Do =
not probe already used TCBs)
> Merging edac-amd/for-next (8de9930a4618 Revert "EDAC/amd64: Support more =
than two controllers for chip select handling")
> Merging irqchip/irq/irqchip-next (16e32c3cde77 iommu/dma-iommu: Remove io=
mmu_dma_map_msi_msg())
> Merging ftrace/for-next (693713cbdb3a x86: Hide the int3_emulate_call/jmp=
 functions from UML)
> Merging rcu/rcu/next (91df49e187c1 Merge LKMM and RCU commits)
> Merging kvm/linux-next (dd53f6102c30 Merge tag 'kvmarm-for-v5.2' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
> CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/dirty_l=
og_test.c
> CONFLICT (content): Merge conflict in arch/x86/kvm/paging_tmpl.h
> CONFLICT (content): Merge conflict in Documentation/virtual/kvm/api.txt
> Merging kvm-arm/next (9eecfc22e0bf KVM: arm64: Fix ptrauth ID register ma=
sking logic)
> Merging kvm-ppc/kvm-ppc-next (4894fbcce856 KVM: PPC: Book3S: Remove usele=
ss checks in 'release' method of KVM device)
> Merging kvms390/next (b2d0371d2e37 KVM: s390: vsie: Return correct values=
 for Invalid CRYCB format)
> Merging xen-tip/linux-next (fe846979d305 xen/arm: Use p2m entry with lock=
 protection)
> Merging percpu/for-next (558ac86039fc Merge branch 'for-5.3' into for-nex=
t)
> Merging workqueues/for-next (24acfb718225 workqueue: Use normal rcu)
> Merging drivers-x86/for-next (6456fd731517 platform/x86: Add support for =
Basin Cove power button)
> Merging chrome-platform/for-next (1690e1728451 platform/chrome: Add Chrom=
eOS EC ISHTP driver)
> Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple=
_attr.cocci warnings)
> Merging leds/for-next (0db37915d912 leds: avoid races with workqueue)
> Merging ipmi/for-next (a2d635decbfa Merge tag 'drm-next-2019-05-09' of gi=
t://anongit.freedesktop.org/drm/drm)
> Merging driver-core/driver-core-next (83f3ef3de625 Merge tag 'libnvdimm-f=
ixes-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdim=
m)
> Merging usb/usb-next (83f3ef3de625 Merge tag 'libnvdimm-fixes-5.2-rc1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm)
> Merging usb-gadget/next (2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERR=
ATA)
> Merging usb-serial/usb-next (7f6fc50242d1 USB: serial: f81232: implement =
break control)
> Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: im=
x: set power polarity)
> Merging phy-next/next (708310711e6c dt-bindings: phy-qcom-qmp: Tweak qcom=
,msm8998-qmp-ufs-phy)
> Merging tty/tty-next (83f3ef3de625 Merge tag 'libnvdimm-fixes-5.2-rc1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm)
> Merging char-misc/char-misc-next (83f3ef3de625 Merge tag 'libnvdimm-fixes=
-5.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm)
> Merging extcon/extcon-next (00053de52231 extcon: arizona: Disable mic det=
ect if running when driver is removed)
> Merging soundwire/next (4abbd783d126 soundwire: intel: fix implicit heade=
r use of module.h/export.h)
> Merging thunderbolt/next (37209783c73a thunderbolt: Make priority unsigne=
d in struct tb_path)
> Merging staging/staging-next (8c05f3b965da Merge tag 'for-linus' of git:/=
/git.armlinux.org.uk/~rmk/linux-arm)
> Merging mux/for-next (561eb7335f13 Merge branch 'i2c-mux/for-next' into f=
or-next)
> Merging icc/icc-next (83fdb2dfb0c2 interconnect: convert to DEFINE_SHOW_A=
TTRIBUTE)
> Merging slave-dma/next (f33e7bb3eb92 dmaengine: tegra210-adma: restore ch=
annel status)
> Merging cgroup/for-next (05b289263772 signal: unconditionally leave the f=
rozen state in ptrace_stop())
> Merging scsi/for-next (faec2dda93d3 Merge branch 'misc' into for-next)
> Merging scsi-mkp/for-next (d4023db71108 scsi: qla2xxx: Avoid that lockdep=
 complains about unsafe locking in tcm_qla2xxx_close_session())
> Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to =
wake up sleeping login worker)
> Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
> Merging vhost/linux-next (82c80f76e9da virtio: Fix indentation of VIRTIO_=
MMIO)
> CONFLICT (content): Merge conflict in drivers/pci/of.c
> Merging rpmsg/for-next (6e9b4f32f9fa Merge branches 'hwspinlock-next', 'r=
pmsg-next' and 'rproc-next' into for-next)
> Merging gpio/for-next (0fbee1df2078 gpio: Update documentation)
> Merging gpio-brgl/gpio/for-next (b0d2569d8276 gpio: mlxbf: remove unused =
including <linux/version.h>)
> Merging pinctrl/for-next (e0e31695b53b pinctrl: mcp23s08: Do not complain=
 about unsupported params)
> Merging pinctrl-samsung/for-next (9e98c678c2d6 Linux 5.1-rc1)
> Merging pwm/for-next (f41efceb46e6 pwm: meson: Add clock source configura=
tion for Meson G12A)
> Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVE=
NT_EXIT)
> Merging ktest/for-next (d20f6b41b7c2 ktest: update sample.conf for grub2b=
ls)
> Merging random/dev (b7d5dc21072c random: add a spinlock_t to struct batch=
ed_entropy)
> Merging kselftest/next (61c2018c0743 selftests: avoid KBUILD_OUTPUT dir c=
luttering with selftest objects)
> CONFLICT (content): Merge conflict in tools/testing/selftests/rseq/rseq-s=
390.h
> Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
> Merging livepatching/for-next (591be2f7f7b5 Merge branch 'for-5.2/core' i=
nto for-next)
> Merging coresight/next (78e6427b4e7b coresight: funnel: Support static fu=
nnel)
> Merging rtc/rtc-next (dacb6a4035a0 rtc: snvs: Use __maybe_unused instead =
of #if CONFIG_PM_SLEEP)
> Merging nvdimm/libnvdimm-for-next (1ffc664f9b8c Merge branch 'for-5.1/dax=
' into libnvdimm-for-next)
> CONFLICT (content): Merge conflict in fs/dax.c
> Merging at24/at24/for-next (d333bad1f6f3 dt-bindings: at24: add Renesas R=
1EX24016)
> Merging ntb/ntb-next (6202b3c150bc NTB: ntb_test: Fix bug when counting r=
emote files)
> Merging kspp/for-next/kspp (259799ea5a9a gcc-plugins: arm_ssp_per_task_pl=
ugin: Fix for older GCC < 6)
> Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remo=
ve)
> Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
> Merging gnss/gnss-next (7cc10c5cb143 gnss: ubx: add u-blox,neo-6m compati=
ble)
> Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header=
)
> Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
> Merging slimbus/for-next (80471330ec58 slimbus: fix a NULL pointer derefe=
rence in of_qcom_slim_ngd_register)
> Merging nvmem/for-next (889ba60c36ce nvmem: core: add NVMEM_SYSFS Kconfig=
)
> Merging xarray/xarray (dd12805ed1db XArray: Remove radix tree compatibili=
ty)
> Merging hyperv/hyperv-next (a3fb7bf369ef drivers: input: serio: Add a mod=
ule desription to the hyperv_keyboard driver)
> Merging auxdisplay/auxdisplay (cc5d04d840d6 auxdisplay: charlcd: make bac=
klight initial state configurable)
> Merging kgdb-dt/kgdb/for-next (ca976bfb3154 kdb: Fix bound check compiler=
 warning)
> Merging pidfd/for-next (2d383e614b17 pidfd: add polling selftests)
> Merging devfreq/for-next (cf451adfa392 PM / devfreq: add tracing for sche=
duling work)
> Merging akpm-current/current (a21b4ccc1491 scripts/gdb: add hlist utiliti=
es)
> CONFLICT (content): Merge conflict in include/linux/pid.h
> $ git checkout -b akpm remotes/origin/akpm/master
> Applying: pinctrl: fix pxa2xx.c build warnings
> Applying: mm, memcg: consider subtrees in memory.events
> Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer o=
verflow
> Merging akpm/master (bfc7ef6ead0e drivers/media/platform/sti/delta/delta-=
ipc.c: fix read buffer overflow)
