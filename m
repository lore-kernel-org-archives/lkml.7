Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FCDC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 01:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80F420880
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 01:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfGTBHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 21:07:05 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:33150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728810AbfGTBHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 21:07:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3BBA618023EDA;
        Sat, 20 Jul 2019 01:07:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loss46_77878c3fae019
X-Filterd-Recvd-Size: 15460
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Jul 2019 01:07:01 +0000 (UTC)
Message-ID: <6482e6546dc328ec47b07dba9a78a9573ebb3e56.camel@perches.com>
Subject: trivial script to update MAINTAINERS directory patterns
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Jul 2019 18:06:59 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all directory file patterns in MAINTAINERS end with a trailing /.
There are some directory file patterns that do not.
It'd be nice to update those without the trailing / properly.

Can you please run and apply this script after rc1 ?

$ git grep -h "^[FX]:" MAINTAINERS | \
  cut -f2- | grep -vP '/$|\*|\?|\[' | \
  while read file ; do \
    if [ -d $file ]; then \
      sed -i -e "s@${file}\$@${file}/@" MAINTAINERS ; \
    fi ; \
  done

Today this produces:
---
 MAINTAINERS | 104 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 500cdb68ccbc..cbdf20ac20b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -369,7 +369,7 @@ M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	drivers/acpi/arm64
+F:	drivers/acpi/arm64/
 
 ACPI I2C MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
@@ -1070,7 +1070,7 @@ L:	devel@driverdev.osuosl.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
 S:	Supported
-F:	drivers/staging/android/ion
+F:	drivers/staging/android/ion/
 F:	drivers/staging/android/uapi/ion.h
 
 AOA (Apple Onboard Audio) ALSA DRIVER
@@ -1467,10 +1467,10 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>
 S:	Maintained
 L:	linux-arm-kernel@axis.com
-F:	arch/arm/mach-artpec
+F:	arch/arm/mach-artpec/
 F:	arch/arm/boot/dts/artpec6*
-F:	drivers/clk/axis
-F:	drivers/crypto/axis
+F:	drivers/clk/axis/
+F:	drivers/crypto/axis/
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
@@ -1624,7 +1624,7 @@ F:	drivers/clk/sirf/
 F:	drivers/clocksource/timer-prima2.c
 F:	drivers/clocksource/timer-atlas7.c
 N:	[^a-z]sirf
-X:	drivers/gnss
+X:	drivers/gnss/
 
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
@@ -2313,7 +2313,7 @@ M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang@linaro.org>
 M:	Chunyan Zhang <zhang.lyra@gmail.com>
 S:	Maintained
-F:	arch/arm64/boot/dts/sprd
+F:	arch/arm64/boot/dts/sprd/
 N:	sprd
 
 ARM/STI ARCHITECTURE
@@ -2796,7 +2796,7 @@ M:	Bradley Grove <linuxdrivers@attotech.com>
 L:	linux-scsi@vger.kernel.org
 W:	http://www.attotech.com
 S:	Supported
-F:	drivers/scsi/esas2r
+F:	drivers/scsi/esas2r/
 
 ATUSB IEEE 802.15.4 RADIO DRIVER
 M:	Stefan Schmidt <stefan@datenfreihafen.org>
@@ -2904,7 +2904,7 @@ S:	Maintained
 F:	drivers/video/backlight/
 F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
-F:	Documentation/devicetree/bindings/leds/backlight
+F:	Documentation/devicetree/bindings/leds/backlight/
 
 BATMAN ADVANCED
 M:	Marek Lindner <mareklindner@neomailbox.ch>
@@ -2946,7 +2946,7 @@ L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 W:	https://linuxtv.org
 S:	Supported
-F:	drivers/media/platform/sti/bdisp
+F:	drivers/media/platform/sti/bdisp/
 
 BECKHOFF CX5020 ETHERCAT MASTER DRIVER
 M:	Dariusz Marcinkiewicz <reksio@newterm.pl>
@@ -3176,7 +3176,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/anholt/linux
 S:	Maintained
 N:	bcm2835
-F:	drivers/staging/vc04_services
+F:	drivers/staging/vc04_services/
 
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
@@ -3733,7 +3733,7 @@ T:	git git://linuxtv.org/media_tree.git
 W:	http://linuxtv.org
 S:	Supported
 F:	Documentation/media/kapi/cec-core.rst
-F:	Documentation/media/uapi/cec
+F:	Documentation/media/uapi/cec/
 F:	drivers/media/cec/
 F:	drivers/media/rc/keymaps/rc-cec.c
 F:	include/media/cec.h
@@ -4413,7 +4413,7 @@ M:	Karen Xie <kxie@chelsio.com>
 L:	linux-scsi@vger.kernel.org
 W:	http://www.chelsio.com
 S:	Supported
-F:	drivers/scsi/cxgbi/cxgb3i
+F:	drivers/scsi/cxgbi/cxgb3i/
 
 CXGB3 IWARP RNIC DRIVER (IW_CXGB3)
 M:	Potnuri Bharat Teja <bharat@chelsio.com>
@@ -4428,7 +4428,7 @@ M:	Atul Gupta <atul.gupta@chelsio.com>
 L:	linux-crypto@vger.kernel.org
 W:	http://www.chelsio.com
 S:	Supported
-F:	drivers/crypto/chelsio
+F:	drivers/crypto/chelsio/
 
 CXGB4 ETHERNET DRIVER (CXGB4)
 M:	Vishal Kulkarni <vishal@chelsio.com>
@@ -4442,7 +4442,7 @@ M:	Karen Xie <kxie@chelsio.com>
 L:	linux-scsi@vger.kernel.org
 W:	http://www.chelsio.com
 S:	Supported
-F:	drivers/scsi/cxgbi/cxgb4i
+F:	drivers/scsi/cxgbi/cxgb4i/
 
 CXGB4 IWARP RNIC DRIVER (IW_CXGB4)
 M:	Potnuri Bharat Teja <bharat@chelsio.com>
@@ -4675,7 +4675,7 @@ L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 W:	https://linuxtv.org
 S:	Supported
-F:	drivers/media/platform/sti/delta
+F:	drivers/media/platform/sti/delta/
 
 DENALI NAND DRIVER
 M:	Masahiro Yamada <yamada.masahiro@socionext.com>
@@ -4960,7 +4960,7 @@ DOCUMENTATION/ITALIAN
 M:	Federico Vaga <federico.vaga@vaga.pv.it>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
-F:	Documentation/translations/it_IT
+F:	Documentation/translations/it_IT/
 
 DONGWOON DW9714 LENS VOICE COIL DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
@@ -4989,7 +4989,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/soc/fsl/dpio
+F:	drivers/soc/fsl/dpio/
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
@@ -5006,7 +5006,7 @@ M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-dpaa2/ethsw
+F:	drivers/staging/fsl-dpaa2/ethsw/
 
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
@@ -5444,7 +5444,7 @@ M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel@lists.freedesktop.org
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
-F:	drivers/gpu/drm/sti
+F:	drivers/gpu/drm/sti/
 F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
 
 DRM DRIVERS FOR STM
@@ -5455,7 +5455,7 @@ M:	Vincent Abriou <vincent.abriou@st.com>
 L:	dri-devel@lists.freedesktop.org
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
-F:	drivers/gpu/drm/stm
+F:	drivers/gpu/drm/stm/
 F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
 
 DRM DRIVERS FOR TI LCDC
@@ -6145,7 +6145,7 @@ EZchip NPS platform support
 M:	Vineet Gupta <vgupta@synopsys.com>
 M:	Ofer Levi <oferle@mellanox.com>
 S:	Supported
-F:	arch/arc/plat-eznps
+F:	arch/arc/plat-eznps/
 F:	arch/arc/boot/dts/eznps.dts
 
 F2FS FILE SYSTEM
@@ -6465,13 +6465,13 @@ FREESCALE QORIQ DPAA ETHERNET DRIVER
 M:	Madalin Bucur <madalin.bucur@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/freescale/dpaa
+F:	drivers/net/ethernet/freescale/dpaa/
 
 FREESCALE QORIQ DPAA FMAN DRIVER
 M:	Madalin Bucur <madalin.bucur@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/freescale/fman
+F:	drivers/net/ethernet/freescale/fman/
 F:	Documentation/devicetree/bindings/net/fsl-fman.txt
 
 FREESCALE QORIQ PTP CLOCK DRIVER
@@ -6855,7 +6855,7 @@ R:	Jon Olson <jonolson@google.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/device_drivers/google/gve.txt
-F:	drivers/net/ethernet/google
+F:	drivers/net/ethernet/google/
 
 GPD POCKET FAN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
@@ -7168,7 +7168,7 @@ M:	Mike Marciniszyn <mike.marciniszyn@intel.com>
 M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-F:	drivers/infiniband/hw/hfi1
+F:	drivers/infiniband/hw/hfi1/
 
 HFS FILESYSTEM
 L:	linux-fsdevel@vger.kernel.org
@@ -7287,7 +7287,7 @@ HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
 W:	http://www.hisilicon.com
 S:	Supported
-F:	drivers/perf/hisilicon
+F:	drivers/perf/hisilicon/
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 
 HISILICON ROCE DRIVER
@@ -7414,7 +7414,7 @@ L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 W:	https://linuxtv.org
 S:	Supported
-F:	drivers/media/platform/sti/hva
+F:	drivers/media/platform/sti/hva/
 
 HWPOISON MEMORY FAILURE HANDLING
 M:	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
@@ -7442,7 +7442,7 @@ F:	arch/x86/include/asm/mshyperv.h
 F:	arch/x86/include/asm/trace/hyperv.h
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
-F:	arch/x86/hyperv
+F:	arch/x86/hyperv/
 F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
@@ -7618,7 +7618,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-i3c
 F:	Documentation/devicetree/bindings/i3c/
-F:	Documentation/driver-api/i3c
+F:	Documentation/driver-api/i3c/
 F:	drivers/i3c/
 F:	include/linux/i3c/
 
@@ -7807,7 +7807,7 @@ F:	Documentation/networking/ieee802154.rst
 IFE PROTOCOL
 M:	Yotam Gigi <yotam.gi@gmail.com>
 M:	Jamal Hadi Salim <jhs@mojatatu.com>
-F:	net/ife
+F:	net/ife/
 F:	include/net/ife.h
 F:	include/uapi/linux/ife.h
 
@@ -8566,7 +8566,7 @@ L:	linux-rdma@vger.kernel.org
 L:	target-devel@vger.kernel.org
 S:	Supported
 W:	http://www.linux-iscsi.org
-F:	drivers/infiniband/ulp/isert
+F:	drivers/infiniband/ulp/isert/
 
 ISDN/mISDN SUBSYSTEM
 M:	Karsten Keil <isdn@linux-pingi.de>
@@ -8574,8 +8574,8 @@ L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
 W:	http://www.isdn4linux.de
 S:	Maintained
-F:	drivers/isdn/mISDN
-F:	drivers/isdn/hardware
+F:	drivers/isdn/mISDN/
+F:	drivers/isdn/hardware/
 
 ISDN/CAPI SUBSYSTEM
 M:	Karsten Keil <isdn@linux-pingi.de>
@@ -8994,7 +8994,7 @@ L3MDEV
 M:	David Ahern <dsa@cumulusnetworks.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	net/l3mdev
+F:	net/l3mdev/
 F:	include/net/l3mdev.h
 
 L7 BPF FRAMEWORK
@@ -9021,8 +9021,8 @@ LANTIQ MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-F:	arch/mips/lantiq
-F:	drivers/soc/lantiq
+F:	arch/mips/lantiq/
+F:	drivers/soc/lantiq/
 
 LAPB module
 L:	linux-x25@vger.kernel.org
@@ -9259,7 +9259,7 @@ F:	drivers/rtc/rtc-opal.c
 F:	drivers/scsi/ibmvscsi/
 F:	drivers/tty/hvc/hvc_opal.c
 F:	drivers/watchdog/wdrtas.c
-F:	tools/testing/selftests/powerpc
+F:	tools/testing/selftests/powerpc/
 N:	/pmac
 N:	powermac
 N:	powernv
@@ -10479,7 +10479,7 @@ MICROCHIP AUDIO ASOC DRIVERS
 M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-F:	sound/soc/atmel
+F:	sound/soc/atmel/
 
 MICROCHIP DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
@@ -11388,7 +11388,7 @@ M:	Pavel Machek <pavel@ucw.cz>
 M:	Sakari Ailus <sakari.ailus@iki.fi>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	drivers/media/i2c/et8ek8
+F:	drivers/media/i2c/et8ek8/
 F:	drivers/media/i2c/ad5820.c
 
 NOKIA N900 POWER SUPPLY DRIVERS
@@ -11529,7 +11529,7 @@ NXP SJA1105 ETHERNET SWITCH DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/net/dsa/sja1105
+F:	drivers/net/dsa/sja1105/
 
 NXP TDA998X DRM DRIVER
 M:	Russell King <linux@armlinux.org.uk>
@@ -11553,7 +11553,7 @@ M:	Clément Perrochaud <clement.perrochaud@effinnov.com>
 R:	Charles Gorand <charles.gorand@effinnov.com>
 L:	linux-nfc@lists.01.org (moderated for non-subscribers)
 S:	Supported
-F:	drivers/nfc/nxp-nci
+F:	drivers/nfc/nxp-nci/
 
 OBJAGG
 M:	Jiri Pirko <jiri@mellanox.com>
@@ -11917,7 +11917,7 @@ M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
 M:	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-F:	drivers/infiniband/ulp/opa_vnic
+F:	drivers/infiniband/ulp/opa_vnic/
 
 OPEN FIRMWARE AND DEVICE TREE OVERLAYS
 M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
@@ -12980,7 +12980,7 @@ F:	drivers/block/ps3vram.c
 PSAMPLE PACKET SAMPLING SUPPORT:
 M:	Yotam Gigi <yotam.gi@gmail.com>
 S:	Maintained
-F:	net/psample
+F:	net/psample/
 F:	include/net/psample.h
 F:	include/uapi/linux/psample.h
 
@@ -13352,7 +13352,7 @@ M:	Avinash Patil <avinashp@quantenna.com>
 M:	Sergey Matyukevich <smatyukevich@quantenna.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-F:	drivers/net/wireless/quantenna
+F:	drivers/net/wireless/quantenna/
 
 RADEON and AMDGPU DRM DRIVERS
 M:	Alex Deucher <alexander.deucher@amd.com>
@@ -13418,7 +13418,7 @@ RALINK MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
-F:	arch/mips/ralink
+F:	arch/mips/ralink/
 
 RALINK RT2X00 WIRELESS LAN DRIVER
 P:	rt2x00 project
@@ -13476,7 +13476,7 @@ R:	Lai Jiangshan <jiangshanlai@gmail.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
-F:	tools/testing/selftests/rcutorture
+F:	tools/testing/selftests/rcutorture/
 
 RDC R-321X SoC
 M:	Florian Fainelli <florian@openwrt.org>
@@ -13493,7 +13493,7 @@ M:	Dennis Dalessandro <dennis.dalessandro@intel.com>
 M:	Mike Marciniszyn <mike.marciniszyn@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-F:	drivers/infiniband/sw/rdmavt
+F:	drivers/infiniband/sw/rdmavt/
 
 RDS - RELIABLE DATAGRAM SOCKETS
 M:	Santosh Shilimkar <santosh.shilimkar@oracle.com>
@@ -14075,7 +14075,7 @@ M:	Robert Baldyga <r.baldyga@samsung.com>
 M:	Krzysztof Opasiak <k.opasiak@samsung.com>
 L:	linux-nfc@lists.01.org (moderated for non-subscribers)
 S:	Supported
-F:	drivers/nfc/s3fwrn5
+F:	drivers/nfc/s3fwrn5/
 
 SAMSUNG S5C73M3 CAMERA DRIVER
 M:	Kyungmin Park <kyungmin.park@samsung.com>
@@ -15448,7 +15448,7 @@ F:	Documentation/devicetree/bindings/clock/snps,pll-clock.txt
 SYNOPSYS ARC SDP platform support
 M:	Alexey Brodkin <abrodkin@synopsys.com>
 S:	Supported
-F:	arch/arc/plat-axs10x
+F:	arch/arc/plat-axs10x/
 F:	arch/arc/boot/dts/ax*
 F:	Documentation/devicetree/bindings/arc/axs10*
 
@@ -17502,7 +17502,7 @@ L:	platform-driver-x86@vger.kernel.org
 L:	x86@kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 S:	Maintained
-F:	arch/x86/platform
+F:	arch/x86/platform/
 
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
@@ -17520,7 +17520,7 @@ F:	lib/idr.c
 F:	lib/xarray.c
 F:	include/linux/idr.h
 F:	include/linux/xarray.h
-F:	tools/testing/radix-tree
+F:	tools/testing/radix-tree/
 
 XBOX DVD IR REMOTE
 M:	Benjamin Valentin <benpicco@googlemail.com>


