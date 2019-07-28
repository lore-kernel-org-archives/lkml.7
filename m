Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75544C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35DD2070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PxTLRSFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfG1RgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:36:02 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:60674 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfG1Rf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:35:58 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x6SHYoZG026150;
        Mon, 29 Jul 2019 02:34:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x6SHYoZG026150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564335290;
        bh=+57Jo6UQBbm5f5OGnCqGSk0jhcvFJkA64v5F66BqyL8=;
        h=From:To:Cc:Subject:Date:From;
        b=PxTLRSFxxqMIiK1gM/u2jIvkiTA8ldNQhVkQpuqfozVbbOYaGRlrMHwpgqaWZwtsc
         AnA3/H9kOY00yLiTzLI+EdJWMvYs/cKpgJE6lKGbyMT155/gPECK4TB519xGNqdsR3
         QhP5QW9l/tBFPa6dzR6S99oG8JKTti0LO+1XFqMd4aTi50/iAZLiQVOZTYlP1P5G+w
         AM2Ta7Qtp0xqofqmU61rDmh4nQYHtmgKW7gL4115jramDJ0w07buVndinQHPpvyNkj
         5Q507TZ6pb5gzDcRG0DYiCgLSLxKneiheWdeWS2jv/vC3Il7hn2XWxUq6PO0qDC2e4
         qPtJ7T93nf5rA==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] kbuild: stop compile-testing kernel headers by wildcard patterns
Date:   Mon, 29 Jul 2019 02:34:44 +0900
Message-Id: <20190728173445.10954-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This compile-test started from the strong belief that (almost) all
headers should be able to be compiled as a standalone unit, but this
requirement seems to be annoying.

I believe it is nice to compile-test all the exported headers. On the
other hand, in-kernel headers are not necessarily always compilable.
Actually, some headers are only included under a certain combination
of CONFIG options, and that is definitely fine.

Currently, newly added headers are compile-tested by default. It
sometimes catches (not fatal) bugs, but sometimes raises false
positives.

This commit inverts the logic to compile-test only headers that are
explicitly added to header-test-y. New headers must manually be added
to header-test-y if somebody wants to put them in the test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/makefiles.rst |   10 -
 include/Kbuild                     | 1288 +---------------------------
 include/acpi/Kbuild                |   18 +
 include/clocksource/Kbuild         |    8 +
 include/crypto/Kbuild              |   61 ++
 include/drm/Kbuild                 |   86 ++
 include/keys/Kbuild                |   10 +
 include/kvm/Kbuild                 |    5 +
 include/linux/Kbuild               | 1135 ++++++++++++++++++++++++
 include/linux/byteorder/Kbuild     |    4 +
 include/linux/ceph/Kbuild          |   19 +
 include/linux/i3c/Kbuild           |    5 +
 include/linux/iio/Kbuild           |   22 +
 include/linux/mfd/Kbuild           |  151 ++++
 include/linux/mmc/Kbuild           |   14 +
 include/linux/mtd/Kbuild           |   30 +
 include/linux/pinctrl/Kbuild       |   10 +
 include/linux/platform_data/Kbuild |  145 ++++
 include/linux/regulator/Kbuild     |   25 +
 include/linux/sched/Kbuild         |   27 +
 include/linux/spi/Kbuild           |   18 +
 include/linux/sunrpc/Kbuild        |   28 +
 include/linux/usb/Kbuild           |   42 +
 include/math-emu/Kbuild            |    6 +
 include/media/Kbuild               |   98 +++
 include/misc/Kbuild                |    5 +
 include/net/Kbuild                 |  206 +++++
 include/pcmcia/Kbuild              |    6 +
 include/ras/Kbuild                 |    3 +
 include/rdma/Kbuild                |   32 +
 include/scsi/Kbuild                |   19 +
 include/soc/Kbuild                 |   26 +
 include/sound/Kbuild               |   91 ++
 include/target/Kbuild              |    6 +
 include/trace/Kbuild               |   78 ++
 include/vdso/Kbuild                |    4 +
 include/video/Kbuild               |   32 +
 include/xen/Kbuild                 |    9 +
 scripts/Makefile.lib               |   10 -
 39 files changed, 2506 insertions(+), 1286 deletions(-)
 create mode 100644 include/acpi/Kbuild
 create mode 100644 include/clocksource/Kbuild
 create mode 100644 include/crypto/Kbuild
 create mode 100644 include/drm/Kbuild
 create mode 100644 include/keys/Kbuild
 create mode 100644 include/kvm/Kbuild
 create mode 100644 include/linux/Kbuild
 create mode 100644 include/linux/byteorder/Kbuild
 create mode 100644 include/linux/ceph/Kbuild
 create mode 100644 include/linux/i3c/Kbuild
 create mode 100644 include/linux/iio/Kbuild
 create mode 100644 include/linux/mfd/Kbuild
 create mode 100644 include/linux/mmc/Kbuild
 create mode 100644 include/linux/mtd/Kbuild
 create mode 100644 include/linux/pinctrl/Kbuild
 create mode 100644 include/linux/platform_data/Kbuild
 create mode 100644 include/linux/regulator/Kbuild
 create mode 100644 include/linux/sched/Kbuild
 create mode 100644 include/linux/spi/Kbuild
 create mode 100644 include/linux/sunrpc/Kbuild
 create mode 100644 include/linux/usb/Kbuild
 create mode 100644 include/math-emu/Kbuild
 create mode 100644 include/media/Kbuild
 create mode 100644 include/misc/Kbuild
 create mode 100644 include/net/Kbuild
 create mode 100644 include/pcmcia/Kbuild
 create mode 100644 include/ras/Kbuild
 create mode 100644 include/rdma/Kbuild
 create mode 100644 include/scsi/Kbuild
 create mode 100644 include/soc/Kbuild
 create mode 100644 include/sound/Kbuild
 create mode 100644 include/target/Kbuild
 create mode 100644 include/trace/Kbuild
 create mode 100644 include/vdso/Kbuild
 create mode 100644 include/video/Kbuild
 create mode 100644 include/xen/Kbuild

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index f4f0f7ffde2b..881c73c37810 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1144,16 +1144,6 @@ When kbuild executes, the following steps are followed (roughly):
 	i.e. compilable as standalone units. If CONFIG_HEADER_TEST is enabled,
 	this builds them as part of extra-y.
 
-    header-test-pattern-y
-
-	This works as a weaker version of header-test-y, and accepts wildcard
-	patterns. The typical usage is:
-
-		  header-test-pattern-y += *.h
-
-	This specifies all the files that matches to '*.h' in the current
-	directory, but the files in 'header-test-' are excluded.
-
 6.7 Commands useful for building a boot image
 ---------------------------------------------
 
diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267..aee20dcd18b8 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -1,1268 +1,24 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-# Add header-test-$(CONFIG_...) guard to headers that are only compiled
-# for particular architectures.
-#
-# Headers listed in header-test- are excluded from the test coverage.
-# Many headers are excluded for now because they fail to build. Please
-# consider to fix headers first before adding new ones to the blacklist.
-#
-# Sorted alphabetically.
-header-test-			+= acpi/acbuffer.h
-header-test-			+= acpi/acpi.h
-header-test-			+= acpi/acpi_bus.h
-header-test-			+= acpi/acpi_drivers.h
-header-test-			+= acpi/acpi_io.h
-header-test-			+= acpi/acpi_lpat.h
-header-test-			+= acpi/acpiosxf.h
-header-test-			+= acpi/acpixf.h
-header-test-			+= acpi/acrestyp.h
-header-test-			+= acpi/actbl.h
-header-test-			+= acpi/actbl1.h
-header-test-			+= acpi/actbl2.h
-header-test-			+= acpi/actbl3.h
-header-test-			+= acpi/actypes.h
-header-test-			+= acpi/battery.h
-header-test-			+= acpi/cppc_acpi.h
-header-test-			+= acpi/nfit.h
-header-test-			+= acpi/platform/acenv.h
-header-test-			+= acpi/platform/acenvex.h
-header-test-			+= acpi/platform/acintel.h
-header-test-			+= acpi/platform/aclinux.h
-header-test-			+= acpi/platform/aclinuxex.h
-header-test-			+= acpi/processor.h
-header-test-$(CONFIG_X86)	+= clocksource/hyperv_timer.h
-header-test-			+= clocksource/timer-sp804.h
-header-test-			+= crypto/cast_common.h
-header-test-			+= crypto/internal/cryptouser.h
-header-test-			+= crypto/pkcs7.h
-header-test-			+= crypto/poly1305.h
-header-test-			+= crypto/sha3.h
-header-test-			+= drm/ati_pcigart.h
-header-test-			+= drm/bridge/dw_hdmi.h
-header-test-			+= drm/bridge/dw_mipi_dsi.h
-header-test-			+= drm/drm_audio_component.h
-header-test-			+= drm/drm_auth.h
-header-test-			+= drm/drm_debugfs.h
-header-test-			+= drm/drm_debugfs_crc.h
-header-test-			+= drm/drm_displayid.h
-header-test-			+= drm/drm_encoder_slave.h
-header-test-			+= drm/drm_fb_cma_helper.h
-header-test-			+= drm/drm_fb_helper.h
-header-test-			+= drm/drm_fixed.h
-header-test-			+= drm/drm_format_helper.h
-header-test-			+= drm/drm_lease.h
-header-test-			+= drm/drm_legacy.h
-header-test-			+= drm/drm_panel.h
-header-test-			+= drm/drm_plane_helper.h
-header-test-			+= drm/drm_rect.h
-header-test-			+= drm/i915_component.h
-header-test-			+= drm/intel-gtt.h
-header-test-			+= drm/tinydrm/tinydrm-helpers.h
-header-test-			+= drm/ttm/ttm_debug.h
-header-test-			+= keys/asymmetric-parser.h
-header-test-			+= keys/asymmetric-subtype.h
-header-test-			+= keys/asymmetric-type.h
-header-test-			+= keys/big_key-type.h
-header-test-			+= keys/request_key_auth-type.h
-header-test-			+= keys/trusted.h
-header-test-			+= kvm/arm_arch_timer.h
-header-test-			+= kvm/arm_pmu.h
-header-test-$(CONFIG_ARM)	+= kvm/arm_psci.h
-header-test-$(CONFIG_ARM64)	+= kvm/arm_psci.h
-header-test-			+= kvm/arm_vgic.h
-header-test-			+= linux/8250_pci.h
-header-test-			+= linux/a.out.h
-header-test-			+= linux/adxl.h
-header-test-			+= linux/agpgart.h
-header-test-			+= linux/alcor_pci.h
-header-test-			+= linux/amba/clcd.h
-header-test-			+= linux/amba/pl080.h
-header-test-			+= linux/amd-iommu.h
-header-test-$(CONFIG_ARM)	+= linux/arm-cci.h
-header-test-$(CONFIG_ARM64)	+= linux/arm-cci.h
-header-test-			+= linux/arm_sdei.h
-header-test-			+= linux/asn1_decoder.h
-header-test-			+= linux/ata_platform.h
-header-test-			+= linux/ath9k_platform.h
-header-test-			+= linux/atm_tcp.h
-header-test-			+= linux/atomic-fallback.h
-header-test-			+= linux/avf/virtchnl.h
-header-test-			+= linux/bcm47xx_sprom.h
-header-test-			+= linux/bcma/bcma_driver_gmac_cmn.h
-header-test-			+= linux/bcma/bcma_driver_mips.h
-header-test-			+= linux/bcma/bcma_driver_pci.h
-header-test-			+= linux/bcma/bcma_driver_pcie2.h
-header-test-			+= linux/bit_spinlock.h
-header-test-			+= linux/blk-mq-rdma.h
-header-test-			+= linux/blk-mq.h
-header-test-			+= linux/blktrace_api.h
-header-test-			+= linux/blockgroup_lock.h
-header-test-			+= linux/bma150.h
-header-test-			+= linux/bpf_lirc.h
-header-test-			+= linux/bpf_types.h
-header-test-			+= linux/bsg-lib.h
-header-test-			+= linux/bsg.h
-header-test-			+= linux/btf.h
-header-test-			+= linux/btree-128.h
-header-test-			+= linux/btree-type.h
-header-test-$(CONFIG_CPU_BIG_ENDIAN) += linux/byteorder/big_endian.h
-header-test-			+= linux/byteorder/generic.h
-header-test-$(CONFIG_CPU_LITTLE_ENDIAN) += linux/byteorder/little_endian.h
-header-test-			+= linux/c2port.h
-header-test-			+= linux/can/dev/peak_canfd.h
-header-test-			+= linux/can/platform/cc770.h
-header-test-			+= linux/can/platform/sja1000.h
-header-test-			+= linux/ceph/ceph_features.h
-header-test-			+= linux/ceph/ceph_frag.h
-header-test-			+= linux/ceph/ceph_fs.h
-header-test-			+= linux/ceph/debugfs.h
-header-test-			+= linux/ceph/msgr.h
-header-test-			+= linux/ceph/rados.h
-header-test-			+= linux/cgroup_subsys.h
-header-test-			+= linux/clk/sunxi-ng.h
-header-test-			+= linux/clk/ti.h
-header-test-			+= linux/cn_proc.h
-header-test-			+= linux/coda_psdev.h
-header-test-			+= linux/compaction.h
-header-test-			+= linux/console_struct.h
-header-test-			+= linux/count_zeros.h
-header-test-			+= linux/cs5535.h
-header-test-			+= linux/cuda.h
-header-test-			+= linux/cyclades.h
-header-test-			+= linux/dcookies.h
-header-test-			+= linux/delayacct.h
-header-test-			+= linux/delayed_call.h
-header-test-			+= linux/device-mapper.h
-header-test-			+= linux/devpts_fs.h
-header-test-			+= linux/dio.h
-header-test-			+= linux/dirent.h
-header-test-			+= linux/dlm_plock.h
-header-test-			+= linux/dm-dirty-log.h
-header-test-			+= linux/dm-region-hash.h
-header-test-			+= linux/dma-debug.h
-header-test-			+= linux/dma/mmp-pdma.h
-header-test-			+= linux/dma/sprd-dma.h
-header-test-			+= linux/dns_resolver.h
-header-test-			+= linux/drbd_genl.h
-header-test-			+= linux/drbd_genl_api.h
-header-test-			+= linux/dw_apb_timer.h
-header-test-			+= linux/dynamic_debug.h
-header-test-			+= linux/dynamic_queue_limits.h
-header-test-			+= linux/ecryptfs.h
-header-test-			+= linux/edma.h
-header-test-			+= linux/eeprom_93cx6.h
-header-test-			+= linux/efs_vh.h
-header-test-			+= linux/elevator.h
-header-test-			+= linux/elfcore-compat.h
-header-test-			+= linux/error-injection.h
-header-test-			+= linux/errseq.h
-header-test-			+= linux/eventpoll.h
-header-test-			+= linux/ext2_fs.h
-header-test-			+= linux/f75375s.h
-header-test-			+= linux/falloc.h
-header-test-			+= linux/fault-inject.h
-header-test-			+= linux/fbcon.h
-header-test-			+= linux/firmware/intel/stratix10-svc-client.h
-header-test-			+= linux/firmware/meson/meson_sm.h
-header-test-			+= linux/firmware/trusted_foundations.h
-header-test-			+= linux/firmware/xlnx-zynqmp.h
-header-test-			+= linux/fixp-arith.h
-header-test-			+= linux/flat.h
-header-test-			+= linux/fs_types.h
-header-test-			+= linux/fs_uart_pd.h
-header-test-			+= linux/fsi-occ.h
-header-test-			+= linux/fsi-sbefifo.h
-header-test-			+= linux/fsl/bestcomm/ata.h
-header-test-			+= linux/fsl/bestcomm/bestcomm.h
-header-test-			+= linux/fsl/bestcomm/bestcomm_priv.h
-header-test-			+= linux/fsl/bestcomm/fec.h
-header-test-			+= linux/fsl/bestcomm/gen_bd.h
-header-test-			+= linux/fsl/bestcomm/sram.h
-header-test-			+= linux/fsl_hypervisor.h
-header-test-			+= linux/fsldma.h
-header-test-			+= linux/ftrace_irq.h
-header-test-			+= linux/gameport.h
-header-test-			+= linux/genl_magic_func.h
-header-test-			+= linux/genl_magic_struct.h
-header-test-			+= linux/gpio/aspeed.h
-header-test-			+= linux/gpio/gpio-reg.h
-header-test-			+= linux/hid-debug.h
-header-test-			+= linux/hiddev.h
-header-test-			+= linux/hippidevice.h
-header-test-			+= linux/hmm.h
-header-test-			+= linux/hp_sdc.h
-header-test-			+= linux/huge_mm.h
-header-test-			+= linux/hugetlb_cgroup.h
-header-test-			+= linux/hugetlb_inline.h
-header-test-			+= linux/hwmon-vid.h
-header-test-			+= linux/hyperv.h
-header-test-			+= linux/i2c-algo-pca.h
-header-test-			+= linux/i2c-algo-pcf.h
-header-test-			+= linux/i3c/ccc.h
-header-test-			+= linux/i3c/device.h
-header-test-			+= linux/i3c/master.h
-header-test-			+= linux/i8042.h
-header-test-			+= linux/ide.h
-header-test-			+= linux/idle_inject.h
-header-test-			+= linux/if_frad.h
-header-test-			+= linux/if_rmnet.h
-header-test-			+= linux/if_tap.h
-header-test-			+= linux/iio/accel/kxcjk_1013.h
-header-test-			+= linux/iio/adc/ad_sigma_delta.h
-header-test-			+= linux/iio/buffer-dma.h
-header-test-			+= linux/iio/buffer_impl.h
-header-test-			+= linux/iio/common/st_sensors.h
-header-test-			+= linux/iio/common/st_sensors_i2c.h
-header-test-			+= linux/iio/common/st_sensors_spi.h
-header-test-			+= linux/iio/dac/ad5421.h
-header-test-			+= linux/iio/dac/ad5504.h
-header-test-			+= linux/iio/dac/ad5791.h
-header-test-			+= linux/iio/dac/max517.h
-header-test-			+= linux/iio/dac/mcp4725.h
-header-test-			+= linux/iio/frequency/ad9523.h
-header-test-			+= linux/iio/frequency/adf4350.h
-header-test-			+= linux/iio/hw-consumer.h
-header-test-			+= linux/iio/imu/adis.h
-header-test-			+= linux/iio/sysfs.h
-header-test-			+= linux/iio/timer/stm32-timer-trigger.h
-header-test-			+= linux/iio/trigger.h
-header-test-			+= linux/iio/triggered_event.h
-header-test-			+= linux/imx-media.h
-header-test-			+= linux/inet_diag.h
-header-test-			+= linux/init_ohci1394_dma.h
-header-test-			+= linux/initrd.h
-header-test-			+= linux/input/adp5589.h
-header-test-			+= linux/input/bu21013.h
-header-test-			+= linux/input/cma3000.h
-header-test-			+= linux/input/kxtj9.h
-header-test-			+= linux/input/lm8333.h
-header-test-			+= linux/input/sparse-keymap.h
-header-test-			+= linux/input/touchscreen.h
-header-test-			+= linux/input/tps6507x-ts.h
-header-test-$(CONFIG_X86)	+= linux/intel-iommu.h
-header-test-			+= linux/intel-ish-client-if.h
-header-test-			+= linux/intel-pti.h
-header-test-			+= linux/intel-svm.h
-header-test-			+= linux/interconnect-provider.h
-header-test-			+= linux/ioc3.h
-header-test-$(CONFIG_BLOCK)	+= linux/iomap.h
-header-test-			+= linux/ipack.h
-header-test-			+= linux/irq_cpustat.h
-header-test-			+= linux/irq_poll.h
-header-test-			+= linux/irqchip/arm-gic-v3.h
-header-test-			+= linux/irqchip/arm-gic-v4.h
-header-test-			+= linux/irqchip/irq-madera.h
-header-test-			+= linux/irqchip/irq-sa11x0.h
-header-test-			+= linux/irqchip/mxs.h
-header-test-			+= linux/irqchip/versatile-fpga.h
-header-test-			+= linux/irqdesc.h
-header-test-			+= linux/irqflags.h
-header-test-			+= linux/iscsi_boot_sysfs.h
-header-test-			+= linux/isdn/capiutil.h
-header-test-			+= linux/isdn/hdlc.h
-header-test-			+= linux/isdn_ppp.h
-header-test-			+= linux/jbd2.h
-header-test-			+= linux/jump_label.h
-header-test-			+= linux/jump_label_ratelimit.h
-header-test-			+= linux/jz4740-adc.h
-header-test-			+= linux/kasan.h
-header-test-			+= linux/kcore.h
-header-test-			+= linux/kdev_t.h
-header-test-			+= linux/kernelcapi.h
-header-test-			+= linux/khugepaged.h
-header-test-			+= linux/kobj_map.h
-header-test-			+= linux/kobject_ns.h
-header-test-			+= linux/kvm_host.h
-header-test-			+= linux/kvm_irqfd.h
-header-test-			+= linux/kvm_para.h
-header-test-			+= linux/lantiq.h
-header-test-			+= linux/lapb.h
-header-test-			+= linux/latencytop.h
-header-test-			+= linux/led-lm3530.h
-header-test-			+= linux/leds-bd2802.h
-header-test-			+= linux/leds-lp3944.h
-header-test-			+= linux/leds-lp3952.h
-header-test-			+= linux/leds_pwm.h
-header-test-			+= linux/libata.h
-header-test-			+= linux/license.h
-header-test-			+= linux/lightnvm.h
-header-test-			+= linux/lis3lv02d.h
-header-test-			+= linux/list_bl.h
-header-test-			+= linux/list_lru.h
-header-test-			+= linux/list_nulls.h
-header-test-			+= linux/lockd/share.h
-header-test-			+= linux/lzo.h
-header-test-			+= linux/mailbox/zynqmp-ipi-message.h
-header-test-			+= linux/maple.h
-header-test-			+= linux/mbcache.h
-header-test-			+= linux/mbus.h
-header-test-			+= linux/mc146818rtc.h
-header-test-			+= linux/mc6821.h
-header-test-			+= linux/mdev.h
-header-test-			+= linux/mem_encrypt.h
-header-test-			+= linux/memfd.h
-header-test-			+= linux/mfd/88pm80x.h
-header-test-			+= linux/mfd/88pm860x.h
-header-test-			+= linux/mfd/abx500/ab8500-bm.h
-header-test-			+= linux/mfd/abx500/ab8500-gpadc.h
-header-test-			+= linux/mfd/adp5520.h
-header-test-			+= linux/mfd/arizona/pdata.h
-header-test-			+= linux/mfd/as3711.h
-header-test-			+= linux/mfd/as3722.h
-header-test-			+= linux/mfd/cros_ec_commands.h
-header-test-			+= linux/mfd/da903x.h
-header-test-			+= linux/mfd/da9055/pdata.h
-header-test-			+= linux/mfd/da9063/pdata.h
-header-test-			+= linux/mfd/db8500-prcmu.h
-header-test-			+= linux/mfd/dbx500-prcmu.h
-header-test-			+= linux/mfd/dln2.h
-header-test-			+= linux/mfd/dm355evm_msp.h
-header-test-			+= linux/mfd/ds1wm.h
-header-test-			+= linux/mfd/ezx-pcap.h
-header-test-			+= linux/mfd/intel_msic.h
-header-test-			+= linux/mfd/janz.h
-header-test-			+= linux/mfd/kempld.h
-header-test-			+= linux/mfd/lm3533.h
-header-test-			+= linux/mfd/lp8788-isink.h
-header-test-			+= linux/mfd/lpc_ich.h
-header-test-			+= linux/mfd/max77693.h
-header-test-			+= linux/mfd/max8998-private.h
-header-test-			+= linux/mfd/menelaus.h
-header-test-			+= linux/mfd/mt6397/core.h
-header-test-			+= linux/mfd/palmas.h
-header-test-			+= linux/mfd/pcf50633/backlight.h
-header-test-			+= linux/mfd/rc5t583.h
-header-test-			+= linux/mfd/retu.h
-header-test-			+= linux/mfd/samsung/core.h
-header-test-			+= linux/mfd/si476x-platform.h
-header-test-			+= linux/mfd/si476x-reports.h
-header-test-			+= linux/mfd/sky81452.h
-header-test-			+= linux/mfd/smsc.h
-header-test-			+= linux/mfd/sta2x11-mfd.h
-header-test-			+= linux/mfd/stmfx.h
-header-test-			+= linux/mfd/tc3589x.h
-header-test-			+= linux/mfd/tc6387xb.h
-header-test-			+= linux/mfd/tc6393xb.h
-header-test-			+= linux/mfd/tps65090.h
-header-test-			+= linux/mfd/tps6586x.h
-header-test-			+= linux/mfd/tps65910.h
-header-test-			+= linux/mfd/tps80031.h
-header-test-			+= linux/mfd/ucb1x00.h
-header-test-			+= linux/mfd/viperboard.h
-header-test-			+= linux/mfd/wm831x/core.h
-header-test-			+= linux/mfd/wm831x/otp.h
-header-test-			+= linux/mfd/wm831x/pdata.h
-header-test-			+= linux/mfd/wm8994/core.h
-header-test-			+= linux/mfd/wm8994/pdata.h
-header-test-			+= linux/mlx4/doorbell.h
-header-test-			+= linux/mlx4/srq.h
-header-test-			+= linux/mlx5/doorbell.h
-header-test-			+= linux/mlx5/eq.h
-header-test-			+= linux/mlx5/fs_helpers.h
-header-test-			+= linux/mlx5/mlx5_ifc.h
-header-test-			+= linux/mlx5/mlx5_ifc_fpga.h
-header-test-			+= linux/mm-arch-hooks.h
-header-test-			+= linux/mm_inline.h
-header-test-			+= linux/mmu_context.h
-header-test-			+= linux/mpage.h
-header-test-			+= linux/mtd/bbm.h
-header-test-			+= linux/mtd/cfi.h
-header-test-			+= linux/mtd/doc2000.h
-header-test-			+= linux/mtd/flashchip.h
-header-test-			+= linux/mtd/ftl.h
-header-test-			+= linux/mtd/gen_probe.h
-header-test-			+= linux/mtd/jedec.h
-header-test-			+= linux/mtd/nand_bch.h
-header-test-			+= linux/mtd/nand_ecc.h
-header-test-			+= linux/mtd/ndfc.h
-header-test-			+= linux/mtd/onenand.h
-header-test-			+= linux/mtd/pismo.h
-header-test-			+= linux/mtd/plat-ram.h
-header-test-			+= linux/mtd/spi-nor.h
-header-test-			+= linux/mv643xx.h
-header-test-			+= linux/mv643xx_eth.h
-header-test-			+= linux/mvebu-pmsu.h
-header-test-			+= linux/mxm-wmi.h
-header-test-			+= linux/n_r3964.h
-header-test-			+= linux/ndctl.h
-header-test-			+= linux/netfilter/ipset/ip_set.h
-header-test-			+= linux/netfilter/ipset/ip_set_bitmap.h
-header-test-			+= linux/netfilter/ipset/ip_set_comment.h
-header-test-			+= linux/netfilter/ipset/ip_set_counter.h
-header-test-			+= linux/netfilter/ipset/ip_set_getport.h
-header-test-			+= linux/netfilter/ipset/ip_set_hash.h
-header-test-			+= linux/netfilter/ipset/ip_set_list.h
-header-test-			+= linux/netfilter/ipset/ip_set_skbinfo.h
-header-test-			+= linux/netfilter/ipset/ip_set_timeout.h
-header-test-			+= linux/netfilter/nf_conntrack_amanda.h
-header-test-			+= linux/netfilter/nf_conntrack_ftp.h
-header-test-			+= linux/netfilter/nf_conntrack_h323.h
-header-test-			+= linux/netfilter/nf_conntrack_h323_asn1.h
-header-test-			+= linux/netfilter/nf_conntrack_irc.h
-header-test-			+= linux/netfilter/nf_conntrack_pptp.h
-header-test-			+= linux/netfilter/nf_conntrack_proto_gre.h
-header-test-			+= linux/netfilter/nf_conntrack_sip.h
-header-test-			+= linux/netfilter/nf_conntrack_snmp.h
-header-test-			+= linux/netfilter/nf_conntrack_tftp.h
-header-test-			+= linux/netfilter/x_tables.h
-header-test-			+= linux/netfilter_arp/arp_tables.h
-header-test-			+= linux/netfilter_bridge/ebtables.h
-header-test-			+= linux/netfilter_ipv4/ip4_tables.h
-header-test-			+= linux/netfilter_ipv4/ip_tables.h
-header-test-			+= linux/netfilter_ipv6/ip6_tables.h
-header-test-			+= linux/nfs.h
-header-test-			+= linux/nfs_fs_i.h
-header-test-			+= linux/nfs_fs_sb.h
-header-test-			+= linux/nfs_page.h
-header-test-			+= linux/nfs_xdr.h
-header-test-			+= linux/nfsacl.h
-header-test-			+= linux/nl802154.h
-header-test-			+= linux/ns_common.h
-header-test-			+= linux/nsc_gpio.h
-header-test-			+= linux/ntb_transport.h
-header-test-			+= linux/nubus.h
-header-test-			+= linux/nvme-fc-driver.h
-header-test-			+= linux/nvme-fc.h
-header-test-			+= linux/nvme-rdma.h
-header-test-			+= linux/nvram.h
-header-test-			+= linux/objagg.h
-header-test-			+= linux/of_clk.h
-header-test-			+= linux/of_net.h
-header-test-			+= linux/of_pdt.h
-header-test-			+= linux/olpc-ec.h
-header-test-			+= linux/omap-dma.h
-header-test-			+= linux/omap-dmaengine.h
-header-test-			+= linux/omap-gpmc.h
-header-test-			+= linux/omap-iommu.h
-header-test-			+= linux/omap-mailbox.h
-header-test-			+= linux/once.h
-header-test-			+= linux/osq_lock.h
-header-test-			+= linux/overflow.h
-header-test-			+= linux/page-flags-layout.h
-header-test-			+= linux/page-isolation.h
-header-test-			+= linux/page_ext.h
-header-test-			+= linux/page_owner.h
-header-test-			+= linux/parport_pc.h
-header-test-			+= linux/parser.h
-header-test-			+= linux/pci-acpi.h
-header-test-			+= linux/pci-dma-compat.h
-header-test-			+= linux/pci_hotplug.h
-header-test-			+= linux/pda_power.h
-header-test-			+= linux/perf/arm_pmu.h
-header-test-			+= linux/perf_regs.h
-header-test-			+= linux/phy/omap_control_phy.h
-header-test-			+= linux/phy/tegra/xusb.h
-header-test-			+= linux/phy/ulpi_phy.h
-header-test-			+= linux/phy_fixed.h
-header-test-			+= linux/pipe_fs_i.h
-header-test-			+= linux/pktcdvd.h
-header-test-			+= linux/pl320-ipc.h
-header-test-			+= linux/pl353-smc.h
-header-test-			+= linux/platform_data/ad5449.h
-header-test-			+= linux/platform_data/ad5755.h
-header-test-			+= linux/platform_data/ad7266.h
-header-test-			+= linux/platform_data/ad7291.h
-header-test-			+= linux/platform_data/ad7298.h
-header-test-			+= linux/platform_data/ad7303.h
-header-test-			+= linux/platform_data/ad7791.h
-header-test-			+= linux/platform_data/ad7793.h
-header-test-			+= linux/platform_data/ad7887.h
-header-test-			+= linux/platform_data/adau17x1.h
-header-test-			+= linux/platform_data/adp8870.h
-header-test-			+= linux/platform_data/ads1015.h
-header-test-			+= linux/platform_data/ads7828.h
-header-test-			+= linux/platform_data/apds990x.h
-header-test-			+= linux/platform_data/arm-ux500-pm.h
-header-test-			+= linux/platform_data/asoc-s3c.h
-header-test-			+= linux/platform_data/at91_adc.h
-header-test-			+= linux/platform_data/ata-pxa.h
-header-test-			+= linux/platform_data/atmel.h
-header-test-			+= linux/platform_data/bh1770glc.h
-header-test-			+= linux/platform_data/brcmfmac.h
-header-test-			+= linux/platform_data/clk-u300.h
-header-test-			+= linux/platform_data/cyttsp4.h
-header-test-			+= linux/platform_data/dma-coh901318.h
-header-test-			+= linux/platform_data/dma-imx-sdma.h
-header-test-			+= linux/platform_data/dma-mcf-edma.h
-header-test-			+= linux/platform_data/dma-s3c24xx.h
-header-test-			+= linux/platform_data/dmtimer-omap.h
-header-test-			+= linux/platform_data/dsa.h
-header-test-			+= linux/platform_data/edma.h
-header-test-			+= linux/platform_data/elm.h
-header-test-			+= linux/platform_data/emif_plat.h
-header-test-			+= linux/platform_data/fsa9480.h
-header-test-			+= linux/platform_data/g762.h
-header-test-			+= linux/platform_data/gpio-ath79.h
-header-test-			+= linux/platform_data/gpio-davinci.h
-header-test-			+= linux/platform_data/gpio-dwapb.h
-header-test-			+= linux/platform_data/gpio-htc-egpio.h
-header-test-			+= linux/platform_data/gpmc-omap.h
-header-test-			+= linux/platform_data/hsmmc-omap.h
-header-test-			+= linux/platform_data/hwmon-s3c.h
-header-test-			+= linux/platform_data/i2c-davinci.h
-header-test-			+= linux/platform_data/i2c-imx.h
-header-test-			+= linux/platform_data/i2c-mux-reg.h
-header-test-			+= linux/platform_data/i2c-ocores.h
-header-test-			+= linux/platform_data/i2c-xiic.h
-header-test-			+= linux/platform_data/intel-spi.h
-header-test-			+= linux/platform_data/invensense_mpu6050.h
-header-test-			+= linux/platform_data/irda-pxaficp.h
-header-test-			+= linux/platform_data/irda-sa11x0.h
-header-test-			+= linux/platform_data/itco_wdt.h
-header-test-			+= linux/platform_data/jz4740/jz4740_nand.h
-header-test-			+= linux/platform_data/keyboard-pxa930_rotary.h
-header-test-			+= linux/platform_data/keypad-omap.h
-header-test-			+= linux/platform_data/leds-lp55xx.h
-header-test-			+= linux/platform_data/leds-omap.h
-header-test-			+= linux/platform_data/lp855x.h
-header-test-			+= linux/platform_data/lp8727.h
-header-test-			+= linux/platform_data/max197.h
-header-test-			+= linux/platform_data/max3421-hcd.h
-header-test-			+= linux/platform_data/max732x.h
-header-test-			+= linux/platform_data/mcs.h
-header-test-			+= linux/platform_data/mdio-bcm-unimac.h
-header-test-			+= linux/platform_data/mdio-gpio.h
-header-test-			+= linux/platform_data/media/si4713.h
-header-test-			+= linux/platform_data/mlxreg.h
-header-test-			+= linux/platform_data/mmc-omap.h
-header-test-			+= linux/platform_data/mmc-sdhci-s3c.h
-header-test-			+= linux/platform_data/mmp_audio.h
-header-test-			+= linux/platform_data/mtd-orion_nand.h
-header-test-			+= linux/platform_data/mv88e6xxx.h
-header-test-			+= linux/platform_data/net-cw1200.h
-header-test-			+= linux/platform_data/omap-twl4030.h
-header-test-			+= linux/platform_data/omapdss.h
-header-test-			+= linux/platform_data/pcf857x.h
-header-test-			+= linux/platform_data/pixcir_i2c_ts.h
-header-test-			+= linux/platform_data/pwm_omap_dmtimer.h
-header-test-			+= linux/platform_data/pxa2xx_udc.h
-header-test-			+= linux/platform_data/pxa_sdhci.h
-header-test-			+= linux/platform_data/remoteproc-omap.h
-header-test-			+= linux/platform_data/sa11x0-serial.h
-header-test-			+= linux/platform_data/sc18is602.h
-header-test-			+= linux/platform_data/sdhci-pic32.h
-header-test-			+= linux/platform_data/serial-sccnxp.h
-header-test-			+= linux/platform_data/sht3x.h
-header-test-			+= linux/platform_data/shtc1.h
-header-test-			+= linux/platform_data/si5351.h
-header-test-			+= linux/platform_data/sky81452-backlight.h
-header-test-			+= linux/platform_data/spi-davinci.h
-header-test-			+= linux/platform_data/spi-ep93xx.h
-header-test-			+= linux/platform_data/spi-mt65xx.h
-header-test-			+= linux/platform_data/spi-nuc900.h
-header-test-			+= linux/platform_data/st_sensors_pdata.h
-header-test-			+= linux/platform_data/ti-sysc.h
-header-test-			+= linux/platform_data/timer-ixp4xx.h
-header-test-			+= linux/platform_data/touchscreen-s3c2410.h
-header-test-			+= linux/platform_data/tsc2007.h
-header-test-			+= linux/platform_data/tsl2772.h
-header-test-			+= linux/platform_data/uio_pruss.h
-header-test-			+= linux/platform_data/usb-davinci.h
-header-test-			+= linux/platform_data/usb-ehci-mxc.h
-header-test-			+= linux/platform_data/usb-ehci-orion.h
-header-test-			+= linux/platform_data/usb-mx2.h
-header-test-			+= linux/platform_data/usb-ohci-s3c2410.h
-header-test-			+= linux/platform_data/usb-omap.h
-header-test-			+= linux/platform_data/usb-s3c2410_udc.h
-header-test-			+= linux/platform_data/usb3503.h
-header-test-			+= linux/platform_data/ux500_wdt.h
-header-test-			+= linux/platform_data/video-clcd-versatile.h
-header-test-			+= linux/platform_data/video-imxfb.h
-header-test-			+= linux/platform_data/video-nuc900fb.h
-header-test-			+= linux/platform_data/video-pxafb.h
-header-test-			+= linux/platform_data/video_s3c.h
-header-test-			+= linux/platform_data/voltage-omap.h
-header-test-			+= linux/platform_data/x86/apple.h
-header-test-			+= linux/platform_data/x86/clk-pmc-atom.h
-header-test-			+= linux/platform_data/x86/pmc_atom.h
-header-test-			+= linux/platform_data/xtalk-bridge.h
-header-test-			+= linux/pm2301_charger.h
-header-test-			+= linux/pm_wakeirq.h
-header-test-			+= linux/pm_wakeup.h
-header-test-			+= linux/pmbus.h
-header-test-			+= linux/pmu.h
-header-test-			+= linux/posix_acl.h
-header-test-			+= linux/posix_acl_xattr.h
-header-test-			+= linux/power/ab8500.h
-header-test-			+= linux/power/bq27xxx_battery.h
-header-test-			+= linux/power/generic-adc-battery.h
-header-test-			+= linux/power/jz4740-battery.h
-header-test-			+= linux/power/max17042_battery.h
-header-test-			+= linux/power/max8903_charger.h
-header-test-			+= linux/ppp-comp.h
-header-test-			+= linux/pps-gpio.h
-header-test-			+= linux/pr.h
-header-test-			+= linux/proc_ns.h
-header-test-			+= linux/processor.h
-header-test-			+= linux/psi.h
-header-test-			+= linux/psp-sev.h
-header-test-			+= linux/pstore.h
-header-test-			+= linux/ptr_ring.h
-header-test-			+= linux/ptrace.h
-header-test-			+= linux/qcom-geni-se.h
-header-test-			+= linux/qed/eth_common.h
-header-test-			+= linux/qed/fcoe_common.h
-header-test-			+= linux/qed/iscsi_common.h
-header-test-			+= linux/qed/iwarp_common.h
-header-test-			+= linux/qed/qed_eth_if.h
-header-test-			+= linux/qed/qed_fcoe_if.h
-header-test-			+= linux/qed/rdma_common.h
-header-test-			+= linux/qed/storage_common.h
-header-test-			+= linux/qed/tcp_common.h
-header-test-			+= linux/qnx6_fs.h
-header-test-			+= linux/quicklist.h
-header-test-			+= linux/ramfs.h
-header-test-			+= linux/range.h
-header-test-			+= linux/rcu_node_tree.h
-header-test-			+= linux/rculist_bl.h
-header-test-			+= linux/rculist_nulls.h
-header-test-			+= linux/rcutiny.h
-header-test-			+= linux/rcutree.h
-header-test-			+= linux/reboot-mode.h
-header-test-			+= linux/regulator/fixed.h
-header-test-			+= linux/regulator/gpio-regulator.h
-header-test-			+= linux/regulator/max8973-regulator.h
-header-test-			+= linux/regulator/of_regulator.h
-header-test-			+= linux/regulator/tps51632-regulator.h
-header-test-			+= linux/regulator/tps62360.h
-header-test-			+= linux/regulator/tps6507x.h
-header-test-			+= linux/regulator/userspace-consumer.h
-header-test-			+= linux/remoteproc/st_slim_rproc.h
-header-test-			+= linux/reset/socfpga.h
-header-test-			+= linux/reset/sunxi.h
-header-test-			+= linux/rtc/m48t59.h
-header-test-			+= linux/rtc/rtc-omap.h
-header-test-			+= linux/rtc/sirfsoc_rtciobrg.h
-header-test-			+= linux/rwlock.h
-header-test-			+= linux/rwlock_types.h
-header-test-			+= linux/scc.h
-header-test-			+= linux/sched/deadline.h
-header-test-			+= linux/sched/smt.h
-header-test-			+= linux/sched/sysctl.h
-header-test-			+= linux/sched_clock.h
-header-test-			+= linux/scpi_protocol.h
-header-test-			+= linux/scx200_gpio.h
-header-test-			+= linux/seccomp.h
-header-test-			+= linux/sed-opal.h
-header-test-			+= linux/seg6_iptunnel.h
-header-test-			+= linux/selection.h
-header-test-			+= linux/set_memory.h
-header-test-			+= linux/shrinker.h
-header-test-			+= linux/sirfsoc_dma.h
-header-test-			+= linux/skb_array.h
-header-test-			+= linux/slab_def.h
-header-test-			+= linux/slub_def.h
-header-test-			+= linux/sm501.h
-header-test-			+= linux/smc91x.h
-header-test-			+= linux/static_key.h
-header-test-			+= linux/soc/actions/owl-sps.h
-header-test-			+= linux/soc/amlogic/meson-canvas.h
-header-test-			+= linux/soc/brcmstb/brcmstb.h
-header-test-			+= linux/soc/ixp4xx/npe.h
-header-test-			+= linux/soc/mediatek/infracfg.h
-header-test-			+= linux/soc/qcom/smd-rpm.h
-header-test-			+= linux/soc/qcom/smem.h
-header-test-			+= linux/soc/qcom/smem_state.h
-header-test-			+= linux/soc/qcom/wcnss_ctrl.h
-header-test-			+= linux/soc/renesas/rcar-rst.h
-header-test-			+= linux/soc/samsung/exynos-pmu.h
-header-test-			+= linux/soc/sunxi/sunxi_sram.h
-header-test-			+= linux/soc/ti/ti-msgmgr.h
-header-test-			+= linux/soc/ti/ti_sci_inta_msi.h
-header-test-			+= linux/soc/ti/ti_sci_protocol.h
-header-test-			+= linux/soundwire/sdw.h
-header-test-			+= linux/soundwire/sdw_intel.h
-header-test-			+= linux/soundwire/sdw_type.h
-header-test-			+= linux/spi/ad7877.h
-header-test-			+= linux/spi/ads7846.h
-header-test-			+= linux/spi/at86rf230.h
-header-test-			+= linux/spi/ds1305.h
-header-test-			+= linux/spi/libertas_spi.h
-header-test-			+= linux/spi/lms283gf05.h
-header-test-			+= linux/spi/max7301.h
-header-test-			+= linux/spi/mcp23s08.h
-header-test-			+= linux/spi/rspi.h
-header-test-			+= linux/spi/s3c24xx.h
-header-test-			+= linux/spi/sh_msiof.h
-header-test-			+= linux/spi/spi-fsl-dspi.h
-header-test-			+= linux/spi/spi_bitbang.h
-header-test-			+= linux/spi/spi_gpio.h
-header-test-			+= linux/spi/xilinx_spi.h
-header-test-			+= linux/spinlock_api_smp.h
-header-test-			+= linux/spinlock_api_up.h
-header-test-			+= linux/spinlock_types.h
-header-test-			+= linux/splice.h
-header-test-			+= linux/sram.h
-header-test-			+= linux/srcutiny.h
-header-test-			+= linux/srcutree.h
-header-test-			+= linux/ssb/ssb_driver_chipcommon.h
-header-test-			+= linux/ssb/ssb_driver_extif.h
-header-test-			+= linux/ssb/ssb_driver_mips.h
-header-test-			+= linux/ssb/ssb_driver_pci.h
-header-test-			+= linux/ssbi.h
-header-test-			+= linux/stackdepot.h
-header-test-			+= linux/stmp3xxx_rtc_wdt.h
-header-test-			+= linux/string_helpers.h
-header-test-			+= linux/sungem_phy.h
-header-test-			+= linux/sunrpc/msg_prot.h
-header-test-			+= linux/sunrpc/rpc_pipe_fs.h
-header-test-			+= linux/sunrpc/xprtmultipath.h
-header-test-			+= linux/sunrpc/xprtsock.h
-header-test-			+= linux/sunxi-rsb.h
-header-test-			+= linux/svga.h
-header-test-			+= linux/sw842.h
-header-test-			+= linux/swapfile.h
-header-test-			+= linux/swapops.h
-header-test-			+= linux/swiotlb.h
-header-test-			+= linux/sysv_fs.h
-header-test-			+= linux/t10-pi.h
-header-test-			+= linux/task_io_accounting.h
-header-test-			+= linux/tick.h
-header-test-			+= linux/timb_dma.h
-header-test-			+= linux/timekeeping.h
-header-test-			+= linux/timekeeping32.h
-header-test-			+= linux/ts-nbus.h
-header-test-			+= linux/tsacct_kern.h
-header-test-			+= linux/tty_flip.h
-header-test-			+= linux/tty_ldisc.h
-header-test-			+= linux/ucb1400.h
-header-test-			+= linux/usb/association.h
-header-test-			+= linux/usb/cdc-wdm.h
-header-test-			+= linux/usb/cdc_ncm.h
-header-test-			+= linux/usb/ezusb.h
-header-test-			+= linux/usb/gadget_configfs.h
-header-test-			+= linux/usb/gpio_vbus.h
-header-test-			+= linux/usb/hcd.h
-header-test-			+= linux/usb/iowarrior.h
-header-test-			+= linux/usb/irda.h
-header-test-			+= linux/usb/isp116x.h
-header-test-			+= linux/usb/isp1362.h
-header-test-			+= linux/usb/musb.h
-header-test-			+= linux/usb/net2280.h
-header-test-			+= linux/usb/ohci_pdriver.h
-header-test-			+= linux/usb/otg-fsm.h
-header-test-			+= linux/usb/pd_ado.h
-header-test-			+= linux/usb/r8a66597.h
-header-test-			+= linux/usb/rndis_host.h
-header-test-			+= linux/usb/serial.h
-header-test-			+= linux/usb/sl811.h
-header-test-			+= linux/usb/storage.h
-header-test-			+= linux/usb/uas.h
-header-test-			+= linux/usb/usb338x.h
-header-test-			+= linux/usb/usbnet.h
-header-test-			+= linux/usb/wusb-wa.h
-header-test-			+= linux/usb/xhci-dbgp.h
-header-test-			+= linux/usb_usual.h
-header-test-			+= linux/user-return-notifier.h
-header-test-			+= linux/userfaultfd_k.h
-header-test-			+= linux/verification.h
-header-test-			+= linux/vgaarb.h
-header-test-			+= linux/via_core.h
-header-test-			+= linux/via_i2c.h
-header-test-			+= linux/virtio_byteorder.h
-header-test-			+= linux/virtio_ring.h
-header-test-			+= linux/visorbus.h
-header-test-			+= linux/vme.h
-header-test-			+= linux/vmstat.h
-header-test-			+= linux/vmw_vmci_api.h
-header-test-			+= linux/vmw_vmci_defs.h
-header-test-			+= linux/vringh.h
-header-test-			+= linux/vt_buffer.h
-header-test-			+= linux/zorro.h
-header-test-			+= linux/zpool.h
-header-test-			+= math-emu/double.h
-header-test-			+= math-emu/op-common.h
-header-test-			+= math-emu/quad.h
-header-test-			+= math-emu/single.h
-header-test-			+= math-emu/soft-fp.h
-header-test-			+= media/davinci/dm355_ccdc.h
-header-test-			+= media/davinci/dm644x_ccdc.h
-header-test-			+= media/davinci/isif.h
-header-test-			+= media/davinci/vpbe_osd.h
-header-test-			+= media/davinci/vpbe_types.h
-header-test-			+= media/davinci/vpif_types.h
-header-test-			+= media/demux.h
-header-test-			+= media/drv-intf/soc_mediabus.h
-header-test-			+= media/dvb_net.h
-header-test-			+= media/fwht-ctrls.h
-header-test-			+= media/i2c/ad9389b.h
-header-test-			+= media/i2c/adv7343.h
-header-test-			+= media/i2c/adv7511.h
-header-test-			+= media/i2c/adv7842.h
-header-test-			+= media/i2c/m5mols.h
-header-test-			+= media/i2c/mt9m032.h
-header-test-			+= media/i2c/mt9t112.h
-header-test-			+= media/i2c/mt9v032.h
-header-test-			+= media/i2c/ov2659.h
-header-test-			+= media/i2c/ov7670.h
-header-test-			+= media/i2c/rj54n1cb0c.h
-header-test-			+= media/i2c/saa6588.h
-header-test-			+= media/i2c/saa7115.h
-header-test-			+= media/i2c/sr030pc30.h
-header-test-			+= media/i2c/tc358743.h
-header-test-			+= media/i2c/tda1997x.h
-header-test-			+= media/i2c/ths7303.h
-header-test-			+= media/i2c/tvaudio.h
-header-test-			+= media/i2c/tvp514x.h
-header-test-			+= media/i2c/tvp7002.h
-header-test-			+= media/i2c/wm8775.h
-header-test-			+= media/imx.h
-header-test-			+= media/media-dev-allocator.h
-header-test-			+= media/mpeg2-ctrls.h
-header-test-			+= media/rcar-fcp.h
-header-test-			+= media/tuner-types.h
-header-test-			+= media/tveeprom.h
-header-test-			+= media/v4l2-flash-led-class.h
-header-test-			+= misc/altera.h
-header-test-			+= misc/cxl-base.h
-header-test-			+= misc/cxllib.h
-header-test-			+= net/9p/9p.h
-header-test-			+= net/9p/client.h
-header-test-			+= net/9p/transport.h
-header-test-			+= net/af_vsock.h
-header-test-			+= net/ax88796.h
-header-test-			+= net/bluetooth/hci.h
-header-test-			+= net/bluetooth/hci_core.h
-header-test-			+= net/bluetooth/hci_mon.h
-header-test-			+= net/bluetooth/hci_sock.h
-header-test-			+= net/bluetooth/l2cap.h
-header-test-			+= net/bluetooth/mgmt.h
-header-test-			+= net/bluetooth/rfcomm.h
-header-test-			+= net/bluetooth/sco.h
-header-test-			+= net/bond_options.h
-header-test-			+= net/caif/cfsrvl.h
-header-test-			+= net/codel_impl.h
-header-test-			+= net/codel_qdisc.h
-header-test-			+= net/compat.h
-header-test-			+= net/datalink.h
-header-test-			+= net/dcbevent.h
-header-test-			+= net/dcbnl.h
-header-test-			+= net/dn_dev.h
-header-test-			+= net/dn_fib.h
-header-test-			+= net/dn_neigh.h
-header-test-			+= net/dn_nsp.h
-header-test-			+= net/dn_route.h
-header-test-			+= net/erspan.h
-header-test-			+= net/esp.h
-header-test-			+= net/ethoc.h
-header-test-			+= net/firewire.h
-header-test-			+= net/flow_offload.h
-header-test-			+= net/fq.h
-header-test-			+= net/fq_impl.h
-header-test-			+= net/garp.h
-header-test-			+= net/gtp.h
-header-test-			+= net/gue.h
-header-test-			+= net/hwbm.h
-header-test-			+= net/ila.h
-header-test-			+= net/inet6_connection_sock.h
-header-test-			+= net/inet_common.h
-header-test-			+= net/inet_frag.h
-header-test-			+= net/ip6_route.h
-header-test-			+= net/ip_vs.h
-header-test-			+= net/ipcomp.h
-header-test-			+= net/ipconfig.h
-header-test-			+= net/iucv/af_iucv.h
-header-test-			+= net/iucv/iucv.h
-header-test-			+= net/lapb.h
-header-test-			+= net/llc_c_ac.h
-header-test-			+= net/llc_c_st.h
-header-test-			+= net/llc_s_ac.h
-header-test-			+= net/llc_s_ev.h
-header-test-			+= net/llc_s_st.h
-header-test-			+= net/mpls_iptunnel.h
-header-test-			+= net/mrp.h
-header-test-			+= net/ncsi.h
-header-test-			+= net/netevent.h
-header-test-			+= net/netfilter/br_netfilter.h
-header-test-			+= net/netfilter/ipv4/nf_dup_ipv4.h
-header-test-			+= net/netfilter/ipv6/nf_defrag_ipv6.h
-header-test-			+= net/netfilter/ipv6/nf_dup_ipv6.h
-header-test-			+= net/netfilter/nf_conntrack.h
-header-test-			+= net/netfilter/nf_conntrack_acct.h
-header-test-			+= net/netfilter/nf_conntrack_bridge.h
-header-test-			+= net/netfilter/nf_conntrack_core.h
-header-test-			+= net/netfilter/nf_conntrack_count.h
-header-test-			+= net/netfilter/nf_conntrack_ecache.h
-header-test-			+= net/netfilter/nf_conntrack_expect.h
-header-test-			+= net/netfilter/nf_conntrack_extend.h
-header-test-			+= net/netfilter/nf_conntrack_helper.h
-header-test-			+= net/netfilter/nf_conntrack_l4proto.h
-header-test-			+= net/netfilter/nf_conntrack_labels.h
-header-test-			+= net/netfilter/nf_conntrack_seqadj.h
-header-test-			+= net/netfilter/nf_conntrack_synproxy.h
-header-test-			+= net/netfilter/nf_conntrack_timeout.h
-header-test-			+= net/netfilter/nf_conntrack_timestamp.h
-header-test-			+= net/netfilter/nf_conntrack_tuple.h
-header-test-			+= net/netfilter/nf_dup_netdev.h
-header-test-			+= net/netfilter/nf_flow_table.h
-header-test-			+= net/netfilter/nf_nat.h
-header-test-			+= net/netfilter/nf_nat_helper.h
-header-test-			+= net/netfilter/nf_nat_masquerade.h
-header-test-			+= net/netfilter/nf_nat_redirect.h
-header-test-			+= net/netfilter/nf_queue.h
-header-test-			+= net/netfilter/nf_reject.h
-header-test-			+= net/netfilter/nf_synproxy.h
-header-test-$(CONFIG_NF_TABLES)	+= net/netfilter/nf_tables.h
-header-test-$(CONFIG_NF_TABLES)	+= net/netfilter/nf_tables_core.h
-header-test-$(CONFIG_NF_TABLES)	+= net/netfilter/nf_tables_ipv4.h
-header-test-			+= net/netfilter/nf_tables_ipv6.h
-header-test-$(CONFIG_NF_TABLES)	+= net/netfilter/nf_tables_offload.h
-header-test-			+= net/netfilter/nft_fib.h
-header-test-			+= net/netfilter/nft_meta.h
-header-test-			+= net/netfilter/nft_reject.h
-header-test-			+= net/netns/can.h
-header-test-			+= net/netns/generic.h
-header-test-			+= net/netns/ieee802154_6lowpan.h
-header-test-			+= net/netns/ipv4.h
-header-test-			+= net/netns/ipv6.h
-header-test-			+= net/netns/mpls.h
-header-test-			+= net/netns/nftables.h
-header-test-			+= net/netns/sctp.h
-header-test-			+= net/netrom.h
-header-test-			+= net/p8022.h
-header-test-			+= net/phonet/pep.h
-header-test-			+= net/phonet/phonet.h
-header-test-			+= net/phonet/pn_dev.h
-header-test-			+= net/pptp.h
-header-test-			+= net/psample.h
-header-test-			+= net/psnap.h
-header-test-			+= net/regulatory.h
-header-test-			+= net/rose.h
-header-test-			+= net/sctp/auth.h
-header-test-			+= net/sctp/stream_interleave.h
-header-test-			+= net/sctp/stream_sched.h
-header-test-			+= net/sctp/tsnmap.h
-header-test-			+= net/sctp/ulpevent.h
-header-test-			+= net/sctp/ulpqueue.h
-header-test-			+= net/secure_seq.h
-header-test-			+= net/smc.h
-header-test-			+= net/stp.h
-header-test-			+= net/transp_v6.h
-header-test-			+= net/tun_proto.h
-header-test-			+= net/udplite.h
-header-test-			+= net/xdp.h
-header-test-			+= net/xdp_priv.h
-header-test-			+= pcmcia/cistpl.h
-header-test-			+= pcmcia/ds.h
-header-test-			+= rdma/ib.h
-header-test-			+= rdma/iw_portmap.h
-header-test-			+= rdma/opa_port_info.h
-header-test-			+= rdma/rdmavt_cq.h
-header-test-			+= rdma/restrack.h
-header-test-			+= rdma/signature.h
-header-test-			+= rdma/tid_rdma_defs.h
-header-test-			+= scsi/fc/fc_encaps.h
-header-test-			+= scsi/fc/fc_fc2.h
-header-test-			+= scsi/fc/fc_fcoe.h
-header-test-			+= scsi/fc/fc_fip.h
-header-test-			+= scsi/fc_encode.h
-header-test-			+= scsi/fc_frame.h
-header-test-			+= scsi/iser.h
-header-test-			+= scsi/libfc.h
-header-test-			+= scsi/libfcoe.h
-header-test-			+= scsi/libsas.h
-header-test-			+= scsi/sas_ata.h
-header-test-			+= scsi/scsi_cmnd.h
-header-test-			+= scsi/scsi_dbg.h
-header-test-			+= scsi/scsi_device.h
-header-test-			+= scsi/scsi_dh.h
-header-test-			+= scsi/scsi_eh.h
-header-test-			+= scsi/scsi_host.h
-header-test-			+= scsi/scsi_ioctl.h
-header-test-			+= scsi/scsi_request.h
-header-test-			+= scsi/scsi_tcq.h
-header-test-			+= scsi/scsi_transport.h
-header-test-			+= scsi/scsi_transport_fc.h
-header-test-			+= scsi/scsi_transport_sas.h
-header-test-			+= scsi/scsi_transport_spi.h
-header-test-			+= scsi/scsi_transport_srp.h
-header-test-			+= scsi/scsicam.h
-header-test-			+= scsi/sg.h
-header-test-			+= soc/arc/aux.h
-header-test-			+= soc/arc/mcip.h
-header-test-			+= soc/arc/timers.h
-header-test-			+= soc/brcmstb/common.h
-header-test-			+= soc/fsl/bman.h
-header-test-			+= soc/fsl/qe/qe.h
-header-test-			+= soc/fsl/qe/qe_ic.h
-header-test-			+= soc/fsl/qe/qe_tdm.h
-header-test-			+= soc/fsl/qe/ucc.h
-header-test-			+= soc/fsl/qe/ucc_fast.h
-header-test-			+= soc/fsl/qe/ucc_slow.h
-header-test-			+= soc/fsl/qman.h
-header-test-			+= soc/nps/common.h
-header-test-$(CONFIG_ARC)	+= soc/nps/mtm.h
-header-test-			+= soc/qcom/cmd-db.h
-header-test-			+= soc/qcom/rpmh.h
-header-test-			+= soc/qcom/tcs.h
-header-test-			+= soc/tegra/ahb.h
-header-test-			+= soc/tegra/bpmp-abi.h
-header-test-			+= soc/tegra/common.h
-header-test-			+= soc/tegra/flowctrl.h
-header-test-			+= soc/tegra/fuse.h
-header-test-			+= soc/tegra/mc.h
-header-test-			+= sound/ac97/compat.h
-header-test-			+= sound/aci.h
-header-test-			+= sound/ad1843.h
-header-test-			+= sound/adau1373.h
-header-test-			+= sound/ak4113.h
-header-test-			+= sound/ak4114.h
-header-test-			+= sound/ak4117.h
-header-test-			+= sound/cs35l33.h
-header-test-			+= sound/cs35l34.h
-header-test-			+= sound/cs35l35.h
-header-test-			+= sound/cs35l36.h
-header-test-			+= sound/cs4271.h
-header-test-			+= sound/cs42l52.h
-header-test-			+= sound/cs8427.h
-header-test-			+= sound/da7218.h
-header-test-			+= sound/da7219-aad.h
-header-test-			+= sound/da7219.h
-header-test-			+= sound/da9055.h
-header-test-			+= sound/emu8000.h
-header-test-			+= sound/emux_synth.h
-header-test-			+= sound/hda_component.h
-header-test-			+= sound/hda_hwdep.h
-header-test-			+= sound/hda_i915.h
-header-test-			+= sound/hwdep.h
-header-test-			+= sound/i2c.h
-header-test-			+= sound/l3.h
-header-test-			+= sound/max98088.h
-header-test-			+= sound/max98095.h
-header-test-			+= sound/mixer_oss.h
-header-test-			+= sound/omap-hdmi-audio.h
-header-test-			+= sound/pcm_drm_eld.h
-header-test-			+= sound/pcm_iec958.h
-header-test-			+= sound/pcm_oss.h
-header-test-			+= sound/pxa2xx-lib.h
-header-test-			+= sound/rt286.h
-header-test-			+= sound/rt298.h
-header-test-			+= sound/rt5645.h
-header-test-			+= sound/rt5659.h
-header-test-			+= sound/rt5660.h
-header-test-			+= sound/rt5665.h
-header-test-			+= sound/rt5670.h
-header-test-			+= sound/s3c24xx_uda134x.h
-header-test-			+= sound/seq_device.h
-header-test-			+= sound/seq_kernel.h
-header-test-			+= sound/seq_midi_emul.h
-header-test-			+= sound/seq_oss.h
-header-test-			+= sound/soc-acpi-intel-match.h
-header-test-			+= sound/soc-dai.h
-header-test-			+= sound/soc-dapm.h
-header-test-			+= sound/soc-dpcm.h
-header-test-			+= sound/sof/control.h
-header-test-			+= sound/sof/dai-intel.h
-header-test-			+= sound/sof/dai.h
-header-test-			+= sound/sof/header.h
-header-test-			+= sound/sof/info.h
-header-test-			+= sound/sof/pm.h
-header-test-			+= sound/sof/stream.h
-header-test-			+= sound/sof/topology.h
-header-test-			+= sound/sof/trace.h
-header-test-			+= sound/sof/xtensa.h
-header-test-			+= sound/spear_spdif.h
-header-test-			+= sound/sta32x.h
-header-test-			+= sound/sta350.h
-header-test-			+= sound/tea6330t.h
-header-test-			+= sound/tlv320aic32x4.h
-header-test-			+= sound/tlv320dac33-plat.h
-header-test-			+= sound/uda134x.h
-header-test-			+= sound/wavefront.h
-header-test-			+= sound/wm8903.h
-header-test-			+= sound/wm8904.h
-header-test-			+= sound/wm8960.h
-header-test-			+= sound/wm8962.h
-header-test-			+= sound/wm8993.h
-header-test-			+= sound/wm8996.h
-header-test-			+= sound/wm9081.h
-header-test-			+= sound/wm9090.h
-header-test-			+= target/iscsi/iscsi_target_stat.h
-header-test-			+= trace/bpf_probe.h
-header-test-			+= trace/events/9p.h
-header-test-			+= trace/events/afs.h
-header-test-			+= trace/events/asoc.h
-header-test-			+= trace/events/bcache.h
-header-test-			+= trace/events/block.h
-header-test-			+= trace/events/cachefiles.h
-header-test-			+= trace/events/cgroup.h
-header-test-			+= trace/events/clk.h
-header-test-			+= trace/events/cma.h
-header-test-			+= trace/events/ext4.h
-header-test-			+= trace/events/f2fs.h
-header-test-			+= trace/events/fs_dax.h
-header-test-			+= trace/events/fscache.h
-header-test-			+= trace/events/fsi.h
-header-test-			+= trace/events/fsi_master_ast_cf.h
-header-test-			+= trace/events/fsi_master_gpio.h
-header-test-			+= trace/events/huge_memory.h
-header-test-			+= trace/events/ib_mad.h
-header-test-			+= trace/events/ib_umad.h
-header-test-			+= trace/events/iscsi.h
-header-test-			+= trace/events/jbd2.h
-header-test-			+= trace/events/kvm.h
-header-test-			+= trace/events/kyber.h
-header-test-			+= trace/events/libata.h
-header-test-			+= trace/events/mce.h
-header-test-			+= trace/events/mdio.h
-header-test-			+= trace/events/migrate.h
-header-test-			+= trace/events/mmflags.h
-header-test-			+= trace/events/nbd.h
-header-test-			+= trace/events/nilfs2.h
-header-test-			+= trace/events/pwc.h
-header-test-			+= trace/events/rdma.h
-header-test-			+= trace/events/rpcgss.h
-header-test-			+= trace/events/rpcrdma.h
-header-test-			+= trace/events/rxrpc.h
-header-test-			+= trace/events/scsi.h
-header-test-			+= trace/events/siox.h
-header-test-			+= trace/events/spi.h
-header-test-			+= trace/events/swiotlb.h
-header-test-			+= trace/events/syscalls.h
-header-test-			+= trace/events/target.h
-header-test-			+= trace/events/thermal_power_allocator.h
-header-test-			+= trace/events/timer.h
-header-test-			+= trace/events/wbt.h
-header-test-			+= trace/events/xen.h
-header-test-			+= trace/perf.h
-header-test-			+= trace/trace_events.h
-header-test-			+= uapi/drm/vmwgfx_drm.h
-header-test-			+= uapi/linux/a.out.h
-header-test-			+= uapi/linux/coda.h
-header-test-			+= uapi/linux/coda_psdev.h
-header-test-			+= uapi/linux/errqueue.h
-header-test-			+= uapi/linux/eventpoll.h
-header-test-			+= uapi/linux/hdlc/ioctl.h
-header-test-			+= uapi/linux/input.h
-header-test-			+= uapi/linux/kvm.h
-header-test-			+= uapi/linux/kvm_para.h
-header-test-			+= uapi/linux/lightnvm.h
-header-test-			+= uapi/linux/mic_common.h
-header-test-			+= uapi/linux/mman.h
-header-test-			+= uapi/linux/netfilter/ipset/ip_set_bitmap.h
-header-test-			+= uapi/linux/netfilter/ipset/ip_set_hash.h
-header-test-			+= uapi/linux/netfilter/ipset/ip_set_list.h
-header-test-			+= uapi/linux/netfilter/nf_synproxy.h
-header-test-			+= uapi/linux/netfilter/xt_policy.h
-header-test-			+= uapi/linux/netfilter/xt_set.h
-header-test-			+= uapi/linux/netfilter_arp/arp_tables.h
-header-test-			+= uapi/linux/netfilter_arp/arpt_mangle.h
-header-test-			+= uapi/linux/netfilter_ipv4/ip_tables.h
-header-test-			+= uapi/linux/netfilter_ipv4/ipt_LOG.h
-header-test-			+= uapi/linux/netfilter_ipv6/ip6_tables.h
-header-test-			+= uapi/linux/netfilter_ipv6/ip6t_LOG.h
-header-test-			+= uapi/linux/nilfs2_ondisk.h
-header-test-			+= uapi/linux/patchkey.h
-header-test-			+= uapi/linux/ptrace.h
-header-test-			+= uapi/linux/scc.h
-header-test-			+= uapi/linux/seg6_iptunnel.h
-header-test-			+= uapi/linux/smc_diag.h
-header-test-			+= uapi/linux/timex.h
-header-test-			+= uapi/linux/videodev2.h
-header-test-			+= uapi/scsi/scsi_bsg_fc.h
-header-test-			+= uapi/sound/asound.h
-header-test-			+= uapi/sound/sof/eq.h
-header-test-			+= uapi/sound/sof/fw.h
-header-test-			+= uapi/sound/sof/header.h
-header-test-			+= uapi/sound/sof/manifest.h
-header-test-			+= uapi/sound/sof/trace.h
-header-test-			+= uapi/xen/evtchn.h
-header-test-			+= uapi/xen/gntdev.h
-header-test-			+= uapi/xen/privcmd.h
-header-test-			+= vdso/vsyscall.h
-header-test-			+= video/broadsheetfb.h
-header-test-			+= video/cvisionppc.h
-header-test-			+= video/gbe.h
-header-test-			+= video/kyro.h
-header-test-			+= video/maxinefb.h
-header-test-			+= video/metronomefb.h
-header-test-			+= video/neomagic.h
-header-test-			+= video/of_display_timing.h
-header-test-			+= video/omapvrfb.h
-header-test-			+= video/s1d13xxxfb.h
-header-test-			+= video/sstfb.h
-header-test-			+= video/tgafb.h
-header-test-			+= video/udlfb.h
-header-test-			+= video/uvesafb.h
-header-test-			+= video/vga.h
-header-test-			+= video/w100fb.h
-header-test-			+= xen/acpi.h
-header-test-			+= xen/arm/hypercall.h
-header-test-			+= xen/arm/page-coherent.h
-header-test-			+= xen/arm/page.h
-header-test-			+= xen/balloon.h
-header-test-			+= xen/events.h
-header-test-			+= xen/features.h
-header-test-			+= xen/grant_table.h
-header-test-			+= xen/hvm.h
-header-test-			+= xen/interface/callback.h
-header-test-			+= xen/interface/event_channel.h
-header-test-			+= xen/interface/grant_table.h
-header-test-			+= xen/interface/hvm/dm_op.h
-header-test-			+= xen/interface/hvm/hvm_op.h
-header-test-			+= xen/interface/hvm/hvm_vcpu.h
-header-test-			+= xen/interface/hvm/params.h
-header-test-			+= xen/interface/hvm/start_info.h
-header-test-			+= xen/interface/io/9pfs.h
-header-test-			+= xen/interface/io/blkif.h
-header-test-			+= xen/interface/io/console.h
-header-test-			+= xen/interface/io/displif.h
-header-test-			+= xen/interface/io/fbif.h
-header-test-			+= xen/interface/io/kbdif.h
-header-test-			+= xen/interface/io/netif.h
-header-test-			+= xen/interface/io/pciif.h
-header-test-			+= xen/interface/io/protocols.h
-header-test-			+= xen/interface/io/pvcalls.h
-header-test-			+= xen/interface/io/ring.h
-header-test-			+= xen/interface/io/sndif.h
-header-test-			+= xen/interface/io/tpmif.h
-header-test-			+= xen/interface/io/vscsiif.h
-header-test-			+= xen/interface/io/xs_wire.h
-header-test-			+= xen/interface/memory.h
-header-test-			+= xen/interface/nmi.h
-header-test-			+= xen/interface/physdev.h
-header-test-			+= xen/interface/platform.h
-header-test-			+= xen/interface/sched.h
-header-test-			+= xen/interface/vcpu.h
-header-test-			+= xen/interface/version.h
-header-test-			+= xen/interface/xen-mca.h
-header-test-			+= xen/interface/xen.h
-header-test-			+= xen/interface/xenpmu.h
-header-test-			+= xen/mem-reservation.h
-header-test-			+= xen/page.h
-header-test-			+= xen/platform_pci.h
-header-test-			+= xen/swiotlb-xen.h
-header-test-			+= xen/xen-front-pgdir-shbuf.h
-header-test-			+= xen/xen-ops.h
-header-test-			+= xen/xen.h
-header-test-			+= xen/xenbus.h
-
-# Do not include directly
-header-test- += linux/compiler-clang.h
-header-test- += linux/compiler-gcc.h
-header-test- += linux/patchkey.h
-header-test- += linux/rwlock_api_smp.h
-header-test- += linux/spinlock_types_up.h
-header-test- += linux/spinlock_up.h
-header-test- += linux/wimax/debug.h
-header-test- += rdma/uverbs_named_ioctl.h
-
-# asm-generic/*.h is used by asm/*.h, and should not be included directly
-header-test- += asm-generic/% uapi/asm-generic/%
-
-# Timestamp files touched by Kconfig
-header-test- += config/%
-
-# Timestamp files touched by scripts/adjust_autoksyms.sh
-header-test- += ksym/%
-
-# You could compile-test these, but maybe not so useful...
-header-test- += dt-bindings/%
-
-# Do not test generated headers. Stale headers are often left over when you
-# traverse the git history without cleaning.
-header-test- += generated/%
-
-# The rest are compile-tested
-header-test-pattern-y += */*.h */*/*.h */*/*/*.h */*/*/*/*.h
+subdir-y += acpi
+subdir-y += clocksource
+subdir-y += crypto
+subdir-y += drm
+subdir-y += keys
+subdir-y += kvm
+subdir-y += linux
+subdir-y += math-emu
+subdir-y += media
+subdir-y += misc
+subdir-y += net
+subdir-y += pcmcia
+subdir-y += ras
+subdir-y += rdma
+subdir-y += scsi
+subdir-y += soc
+subdir-y += sound
+subdir-y += target
+subdir-y += trace
+subdir-y += vdso
+subdir-y += video
+subdir-y += xen
diff --git a/include/acpi/Kbuild b/include/acpi/Kbuild
new file mode 100644
index 000000000000..2c3f8226b574
--- /dev/null
+++ b/include/acpi/Kbuild
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= acconfig.h
+header-test-y			+= acexcep.h
+header-test-y			+= acnames.h
+header-test-y			+= acoutput.h
+header-test-y			+= acpi_numa.h
+header-test-y			+= acuuid.h
+header-test-y			+= apei.h
+header-test-y			+= button.h
+header-test-y			+= ghes.h
+header-test-y			+= hed.h
+header-test-y			+= pcc.h
+header-test-y			+= pdc_intel.h
+header-test-y			+= platform/acgcc.h
+header-test-y			+= platform/acgccex.h
+header-test-y			+= reboot.h
+header-test-y			+= video.h
diff --git a/include/clocksource/Kbuild b/include/clocksource/Kbuild
new file mode 100644
index 000000000000..a9b7b5b756b1
--- /dev/null
+++ b/include/clocksource/Kbuild
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= arm_arch_timer.h
+header-test-$(CONFIG_X86)	+= hyperv_timer.h
+header-test-y			+= pxa.h
+header-test-y			+= samsung_pwm.h
+header-test-y			+= timer-davinci.h
+header-test-y			+= timer-ti-dm.h
diff --git a/include/crypto/Kbuild b/include/crypto/Kbuild
new file mode 100644
index 000000000000..b4c594d7d62d
--- /dev/null
+++ b/include/crypto/Kbuild
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= acompress.h
+header-test-y			+= aead.h
+header-test-y			+= aes.h
+header-test-y			+= akcipher.h
+header-test-y			+= algapi.h
+header-test-y			+= arc4.h
+header-test-y			+= asym_tpm_subtype.h
+header-test-y			+= authenc.h
+header-test-y			+= b128ops.h
+header-test-y			+= blowfish.h
+header-test-y			+= cast5.h
+header-test-y			+= cast6.h
+header-test-y			+= cbc.h
+header-test-y			+= chacha.h
+header-test-y			+= cryptd.h
+header-test-y			+= ctr.h
+header-test-y			+= des.h
+header-test-y			+= dh.h
+header-test-y			+= drbg.h
+header-test-y			+= ecdh.h
+header-test-y			+= engine.h
+header-test-y			+= gcm.h
+header-test-y			+= gf128mul.h
+header-test-y			+= ghash.h
+header-test-y			+= hash.h
+header-test-y			+= hash_info.h
+header-test-y			+= hmac.h
+header-test-y			+= if_alg.h
+header-test-y			+= internal/acompress.h
+header-test-y			+= internal/aead.h
+header-test-y			+= internal/akcipher.h
+header-test-y			+= internal/geniv.h
+header-test-y			+= internal/hash.h
+header-test-y			+= internal/kpp.h
+header-test-y			+= internal/rng.h
+header-test-y			+= internal/rsa.h
+header-test-y			+= internal/scompress.h
+header-test-y			+= internal/simd.h
+header-test-y			+= internal/skcipher.h
+header-test-y			+= kpp.h
+header-test-y			+= md5.h
+header-test-y			+= morus1280_glue.h
+header-test-y			+= morus640_glue.h
+header-test-y			+= morus_common.h
+header-test-y			+= nhpoly1305.h
+header-test-y			+= null.h
+header-test-y			+= padlock.h
+header-test-y			+= pcrypt.h
+header-test-y			+= public_key.h
+header-test-y			+= rng.h
+header-test-y			+= scatterwalk.h
+header-test-y			+= serpent.h
+header-test-y			+= sha.h
+header-test-y			+= skcipher.h
+header-test-y			+= sm3.h
+header-test-y			+= sm4.h
+header-test-y			+= streebog.h
+header-test-y			+= twofish.h
+header-test-y			+= xts.h
diff --git a/include/drm/Kbuild b/include/drm/Kbuild
new file mode 100644
index 000000000000..7431a3065089
--- /dev/null
+++ b/include/drm/Kbuild
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= amd_asic_type.h
+header-test-y			+= bridge/analogix_dp.h
+header-test-y			+= bridge/mhl.h
+header-test-y			+= drmP.h
+header-test-y			+= drm_agpsupport.h
+header-test-y			+= drm_atomic.h
+header-test-y			+= drm_atomic_helper.h
+header-test-y			+= drm_atomic_state_helper.h
+header-test-y			+= drm_atomic_uapi.h
+header-test-y			+= drm_blend.h
+header-test-y			+= drm_bridge.h
+header-test-y			+= drm_cache.h
+header-test-y			+= drm_client.h
+header-test-y			+= drm_color_mgmt.h
+header-test-y			+= drm_connector.h
+header-test-y			+= drm_crtc.h
+header-test-y			+= drm_crtc_helper.h
+header-test-y			+= drm_damage_helper.h
+header-test-y			+= drm_device.h
+header-test-y			+= drm_dp_dual_mode_helper.h
+header-test-y			+= drm_dp_helper.h
+header-test-y			+= drm_dp_mst_helper.h
+header-test-y			+= drm_drv.h
+header-test-y			+= drm_dsc.h
+header-test-y			+= drm_edid.h
+header-test-y			+= drm_encoder.h
+header-test-y			+= drm_file.h
+header-test-y			+= drm_flip_work.h
+header-test-y			+= drm_fourcc.h
+header-test-y			+= drm_framebuffer.h
+header-test-y			+= drm_gem.h
+header-test-y			+= drm_gem_cma_helper.h
+header-test-y			+= drm_gem_framebuffer_helper.h
+header-test-y			+= drm_gem_shmem_helper.h
+header-test-y			+= drm_hashtab.h
+header-test-y			+= drm_hdcp.h
+header-test-y			+= drm_ioctl.h
+header-test-y			+= drm_irq.h
+header-test-y			+= drm_mipi_dsi.h
+header-test-y			+= drm_mm.h
+header-test-y			+= drm_mode_config.h
+header-test-y			+= drm_mode_object.h
+header-test-y			+= drm_modes.h
+header-test-y			+= drm_modeset_helper.h
+header-test-y			+= drm_modeset_helper_vtables.h
+header-test-y			+= drm_modeset_lock.h
+header-test-y			+= drm_of.h
+header-test-y			+= drm_os_linux.h
+header-test-y			+= drm_pci.h
+header-test-y			+= drm_pciids.h
+header-test-y			+= drm_plane.h
+header-test-y			+= drm_prime.h
+header-test-y			+= drm_print.h
+header-test-y			+= drm_probe_helper.h
+header-test-y			+= drm_property.h
+header-test-y			+= drm_scdc_helper.h
+header-test-y			+= drm_simple_kms_helper.h
+header-test-y			+= drm_syncobj.h
+header-test-y			+= drm_sysfs.h
+header-test-y			+= drm_util.h
+header-test-y			+= drm_utils.h
+header-test-y			+= drm_vblank.h
+header-test-y			+= drm_vma_manager.h
+header-test-y			+= drm_writeback.h
+header-test-y			+= gma_drm.h
+header-test-y			+= gpu_scheduler.h
+header-test-y			+= i2c/ch7006.h
+header-test-y			+= i2c/sil164.h
+header-test-y			+= i2c/tda998x.h
+header-test-y			+= i915_drm.h
+header-test-y			+= i915_mei_hdcp_interface.h
+header-test-y			+= i915_pciids.h
+header-test-y			+= intel_lpe_audio.h
+header-test-y			+= spsc_queue.h
+header-test-y			+= tinydrm/mipi-dbi.h
+header-test-y			+= ttm/ttm_bo_api.h
+header-test-y			+= ttm/ttm_bo_driver.h
+header-test-y			+= ttm/ttm_execbuf_util.h
+header-test-y			+= ttm/ttm_memory.h
+header-test-y			+= ttm/ttm_module.h
+header-test-y			+= ttm/ttm_page_alloc.h
+header-test-y			+= ttm/ttm_placement.h
+header-test-y			+= ttm/ttm_set_memory.h
+header-test-y			+= ttm/ttm_tt.h
diff --git a/include/keys/Kbuild b/include/keys/Kbuild
new file mode 100644
index 000000000000..a93a67e476f1
--- /dev/null
+++ b/include/keys/Kbuild
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ceph-type.h
+header-test-y			+= dns_resolver-type.h
+header-test-y			+= encrypted-type.h
+header-test-y			+= keyring-type.h
+header-test-y			+= rxrpc-type.h
+header-test-y			+= system_keyring.h
+header-test-y			+= trusted-type.h
+header-test-y			+= user-type.h
diff --git a/include/kvm/Kbuild b/include/kvm/Kbuild
new file mode 100644
index 000000000000..37bde19631bc
--- /dev/null
+++ b/include/kvm/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-$(CONFIG_ARM)	+= arm_psci.h
+header-test-$(CONFIG_ARM64)	+= arm_psci.h
+header-test-y			+= iodev.h
diff --git a/include/linux/Kbuild b/include/linux/Kbuild
new file mode 100644
index 000000000000..f3040811d8f0
--- /dev/null
+++ b/include/linux/Kbuild
@@ -0,0 +1,1135 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= acct.h
+header-test-y			+= acpi.h
+header-test-y			+= acpi_dma.h
+header-test-y			+= acpi_iort.h
+header-test-y			+= acpi_pmtmr.h
+header-test-y			+= adb.h
+header-test-y			+= adfs_fs.h
+header-test-y			+= aer.h
+header-test-y			+= agp_backend.h
+header-test-y			+= ahci-remap.h
+header-test-y			+= ahci_platform.h
+header-test-y			+= aio.h
+header-test-y			+= alarmtimer.h
+header-test-y			+= altera_jtaguart.h
+header-test-y			+= altera_uart.h
+header-test-y			+= amba/bus.h
+header-test-y			+= amba/clcd-regs.h
+header-test-y			+= amba/kmi.h
+header-test-y			+= amba/mmci.h
+header-test-y			+= amba/pl022.h
+header-test-y			+= amba/pl08x.h
+header-test-y			+= amba/pl093.h
+header-test-y			+= amba/serial.h
+header-test-y			+= amba/sp810.h
+header-test-y			+= anon_inodes.h
+header-test-y			+= apm-emulation.h
+header-test-y			+= apm_bios.h
+header-test-y			+= apple-gmux.h
+header-test-y			+= apple_bl.h
+header-test-y			+= arch_topology.h
+header-test-$(CONFIG_ARM)	+= arm-cci.h
+header-test-$(CONFIG_ARM64)	+= arm-cci.h
+header-test-y			+= arm-smccc.h
+header-test-y			+= armada-37xx-rwtm-mailbox.h
+header-test-y			+= ascii85.h
+header-test-y			+= asn1.h
+header-test-y			+= asn1_ber_bytecode.h
+header-test-y			+= assoc_array.h
+header-test-y			+= assoc_array_priv.h
+header-test-y			+= async.h
+header-test-y			+= async_tx.h
+header-test-y			+= ata.h
+header-test-y			+= atalk.h
+header-test-y			+= atm.h
+header-test-y			+= atm_suni.h
+header-test-y			+= atmdev.h
+header-test-y			+= atmel-mci.h
+header-test-y			+= atmel-ssc.h
+header-test-y			+= atmel_pdc.h
+header-test-y			+= atomic.h
+header-test-y			+= attribute_container.h
+header-test-y			+= audit.h
+header-test-y			+= auto_dev-ioctl.h
+header-test-y			+= auto_fs.h
+header-test-y			+= auxvec.h
+header-test-y			+= average.h
+header-test-y			+= b1pcmcia.h
+header-test-y			+= backing-dev-defs.h
+header-test-y			+= backing-dev.h
+header-test-y			+= backlight.h
+header-test-y			+= badblocks.h
+header-test-y			+= balloon_compaction.h
+header-test-y			+= bcd.h
+header-test-y			+= bch.h
+header-test-y			+= bcm47xx_nvram.h
+header-test-y			+= bcm47xx_wdt.h
+header-test-y			+= bcm963xx_nvram.h
+header-test-y			+= bcm963xx_tag.h
+header-test-y			+= bcma/bcma.h
+header-test-y			+= bcma/bcma_driver_arm_c9.h
+header-test-y			+= bcma/bcma_driver_chipcommon.h
+header-test-y			+= bcma/bcma_regs.h
+header-test-y			+= bcma/bcma_soc.h
+header-test-y			+= binfmts.h
+header-test-y			+= bio.h
+header-test-y			+= bitfield.h
+header-test-y			+= bitmap.h
+header-test-y			+= bitops.h
+header-test-y			+= bitrev.h
+header-test-y			+= bits.h
+header-test-y			+= blk-cgroup.h
+header-test-y			+= blk-mq-pci.h
+header-test-y			+= blk-mq-virtio.h
+header-test-y			+= blk-pm.h
+header-test-y			+= blk_types.h
+header-test-y			+= blkdev.h
+header-test-y			+= blkpg.h
+header-test-y			+= bottom_half.h
+header-test-y			+= bpf-cgroup.h
+header-test-y			+= bpf.h
+header-test-y			+= bpf_trace.h
+header-test-y			+= bpf_verifier.h
+header-test-y			+= bpfilter.h
+header-test-y			+= brcmphy.h
+header-test-y			+= bsearch.h
+header-test-y			+= btree.h
+header-test-y			+= btrfs.h
+header-test-y			+= buffer_head.h
+header-test-y			+= bug.h
+header-test-y			+= build-salt.h
+header-test-y			+= build_bug.h
+header-test-y			+= bvec.h
+subdir-y			+= byteorder
+header-test-y			+= cache.h
+header-test-y			+= cacheinfo.h
+header-test-y			+= can/core.h
+header-test-y			+= can/dev.h
+header-test-y			+= can/led.h
+header-test-y			+= can/platform/mcp251x.h
+header-test-y			+= can/platform/rcar_can.h
+header-test-y			+= can/rx-offload.h
+header-test-y			+= can/skb.h
+header-test-y			+= capability.h
+header-test-y			+= cb710.h
+header-test-y			+= cciss_ioctl.h
+header-test-y			+= ccp.h
+header-test-y			+= cdev.h
+header-test-y			+= cdrom.h
+subdir-y			+= ceph
+header-test-y			+= cfag12864b.h
+header-test-y			+= cgroup-defs.h
+header-test-y			+= cgroup.h
+header-test-y			+= cgroup_rdma.h
+header-test-y			+= circ_buf.h
+header-test-y			+= cleancache.h
+header-test-y			+= clk-provider.h
+header-test-y			+= clk.h
+header-test-y			+= clk/analogbits-wrpll-cln28hpc.h
+header-test-y			+= clk/at91_pmc.h
+header-test-y			+= clk/davinci.h
+header-test-y			+= clk/mmp.h
+header-test-y			+= clk/mxs.h
+header-test-y			+= clk/renesas.h
+header-test-y			+= clk/tegra.h
+header-test-y			+= clk/zynq.h
+header-test-y			+= clkdev.h
+header-test-y			+= clock_cooling.h
+header-test-y			+= clockchips.h
+header-test-y			+= clocksource.h
+header-test-y			+= cm4000_cs.h
+header-test-y			+= cma.h
+header-test-y			+= cmdline-parser.h
+header-test-y			+= cnt32_to_63.h
+header-test-y			+= coda.h
+header-test-y			+= compat.h
+header-test-y			+= compiler-intel.h
+header-test-y			+= compiler.h
+header-test-y			+= compiler_attributes.h
+header-test-y			+= compiler_types.h
+header-test-y			+= completion.h
+header-test-y			+= component.h
+header-test-y			+= configfs.h
+header-test-y			+= connector.h
+header-test-y			+= console.h
+header-test-y			+= consolemap.h
+header-test-y			+= const.h
+header-test-y			+= context_tracking.h
+header-test-y			+= context_tracking_state.h
+header-test-y			+= cordic.h
+header-test-y			+= coredump.h
+header-test-y			+= coresight-pmu.h
+header-test-y			+= coresight-stm.h
+header-test-y			+= coresight.h
+header-test-y			+= counter.h
+header-test-y			+= counter_enum.h
+header-test-y			+= cper.h
+header-test-y			+= cpu.h
+header-test-y			+= cpu_cooling.h
+header-test-y			+= cpu_pm.h
+header-test-y			+= cpu_rmap.h
+header-test-y			+= cpufeature.h
+header-test-y			+= cpufreq.h
+header-test-y			+= cpuhotplug.h
+header-test-y			+= cpuidle.h
+header-test-y			+= cpumask.h
+header-test-y			+= cpuset.h
+header-test-y			+= crash_core.h
+header-test-y			+= crash_dump.h
+header-test-y			+= crc-ccitt.h
+header-test-y			+= crc-itu-t.h
+header-test-y			+= crc-t10dif.h
+header-test-y			+= crc16.h
+header-test-y			+= crc32.h
+header-test-y			+= crc32c.h
+header-test-y			+= crc32poly.h
+header-test-y			+= crc4.h
+header-test-y			+= crc64.h
+header-test-y			+= crc7.h
+header-test-y			+= crc8.h
+header-test-y			+= cred.h
+header-test-y			+= crush/crush.h
+header-test-y			+= crush/hash.h
+header-test-y			+= crush/mapper.h
+header-test-y			+= crypto.h
+header-test-y			+= cryptohash.h
+header-test-y			+= ctype.h
+header-test-y			+= davinci_emac.h
+header-test-y			+= dax.h
+header-test-y			+= dca.h
+header-test-y			+= dcache.h
+header-test-y			+= dccp.h
+header-test-y			+= debug_locks.h
+header-test-y			+= debugfs.h
+header-test-y			+= debugobjects.h
+header-test-y			+= decompress/bunzip2.h
+header-test-y			+= decompress/generic.h
+header-test-y			+= decompress/inflate.h
+header-test-y			+= decompress/mm.h
+header-test-y			+= decompress/unlz4.h
+header-test-y			+= decompress/unlzma.h
+header-test-y			+= decompress/unlzo.h
+header-test-y			+= decompress/unxz.h
+header-test-y			+= delay.h
+header-test-y			+= devcoredump.h
+header-test-y			+= devfreq-event.h
+header-test-y			+= devfreq.h
+header-test-y			+= devfreq_cooling.h
+header-test-y			+= device.h
+header-test-y			+= digsig.h
+header-test-y			+= dim.h
+header-test-y			+= dlm.h
+header-test-y			+= dm-bufio.h
+header-test-y			+= dm-io.h
+header-test-y			+= dm-kcopyd.h
+header-test-y			+= dm9000.h
+header-test-y			+= dma-buf.h
+header-test-y			+= dma-contiguous.h
+header-test-y			+= dma-direct.h
+header-test-y			+= dma-direction.h
+header-test-y			+= dma-fence-array.h
+header-test-y			+= dma-fence-chain.h
+header-test-y			+= dma-fence.h
+header-test-y			+= dma-iommu.h
+header-test-y			+= dma-mapping.h
+header-test-y			+= dma-noncoherent.h
+header-test-y			+= dma/dw.h
+header-test-y			+= dma/hsu.h
+header-test-y			+= dma/idma64.h
+header-test-y			+= dma/ipu-dma.h
+header-test-y			+= dma/mxs-dma.h
+header-test-y			+= dma/pxa-dma.h
+header-test-y			+= dma/qcom_bam_dma.h
+header-test-y			+= dma/xilinx_dma.h
+header-test-y			+= dmaengine.h
+header-test-y			+= dmapool.h
+header-test-y			+= dmar.h
+header-test-y			+= dmi.h
+header-test-y			+= dnotify.h
+header-test-y			+= dqblk_qtree.h
+header-test-y			+= dqblk_v1.h
+header-test-y			+= dqblk_v2.h
+header-test-y			+= drbd.h
+header-test-y			+= drbd_limits.h
+header-test-y			+= ds2782_battery.h
+header-test-y			+= dsa/8021q.h
+header-test-y			+= dsa/sja1105.h
+header-test-y			+= earlycpio.h
+header-test-y			+= edac.h
+header-test-y			+= edd.h
+header-test-y			+= efi-bgrt.h
+header-test-y			+= efi.h
+header-test-y			+= eisa.h
+header-test-y			+= elf-fdpic.h
+header-test-y			+= elf-randomize.h
+header-test-y			+= elf.h
+header-test-y			+= elfcore.h
+header-test-y			+= elfnote.h
+header-test-y			+= enclosure.h
+header-test-y			+= energy_model.h
+header-test-y			+= err.h
+header-test-y			+= errno.h
+header-test-y			+= errqueue.h
+header-test-y			+= etherdevice.h
+header-test-y			+= ethtool.h
+header-test-y			+= eventfd.h
+header-test-y			+= evm.h
+header-test-y			+= export.h
+header-test-y			+= exportfs.h
+header-test-y			+= extable.h
+header-test-y			+= extcon-provider.h
+header-test-y			+= extcon.h
+header-test-y			+= extcon/extcon-adc-jack.h
+header-test-y			+= f2fs_fs.h
+header-test-y			+= fanotify.h
+header-test-y			+= fb.h
+header-test-y			+= fcdevice.h
+header-test-y			+= fcntl.h
+header-test-y			+= fd.h
+header-test-y			+= fddidevice.h
+header-test-y			+= fdtable.h
+header-test-y			+= fec.h
+header-test-y			+= file.h
+header-test-y			+= filter.h
+header-test-y			+= fips.h
+header-test-y			+= firewire.h
+header-test-y			+= firmware-map.h
+header-test-y			+= firmware.h
+header-test-y			+= firmware/imx/ipc.h
+header-test-y			+= firmware/imx/sci.h
+header-test-y			+= firmware/imx/svc/misc.h
+header-test-y			+= firmware/imx/svc/pm.h
+header-test-y			+= firmware/imx/types.h
+header-test-y			+= firmware/intel/stratix10-smc.h
+header-test-y			+= flex_proportions.h
+header-test-y			+= font.h
+header-test-y			+= fpga/altera-pr-ip-core.h
+header-test-y			+= fpga/fpga-bridge.h
+header-test-y			+= fpga/fpga-mgr.h
+header-test-y			+= fpga/fpga-region.h
+header-test-y			+= frame.h
+header-test-y			+= freezer.h
+header-test-y			+= frontswap.h
+header-test-y			+= fs.h
+header-test-y			+= fs_context.h
+header-test-y			+= fs_enet_pd.h
+header-test-y			+= fs_parser.h
+header-test-y			+= fs_stack.h
+header-test-y			+= fs_struct.h
+header-test-y			+= fscache-cache.h
+header-test-y			+= fscache.h
+header-test-y			+= fscrypt.h
+header-test-y			+= fsi.h
+header-test-y			+= fsl-diu-fb.h
+header-test-y			+= fsl/edac.h
+header-test-y			+= fsl/ftm.h
+header-test-y			+= fsl/guts.h
+header-test-y			+= fsl/mc.h
+header-test-y			+= fsl/ptp_qoriq.h
+header-test-y			+= fsl_devices.h
+header-test-y			+= fsl_ifc.h
+header-test-y			+= fsnotify.h
+header-test-y			+= fsnotify_backend.h
+header-test-y			+= ftrace.h
+header-test-y			+= futex.h
+header-test-y			+= fwnode.h
+header-test-y			+= gcd.h
+header-test-y			+= genalloc.h
+header-test-y			+= generic-radix-tree.h
+header-test-y			+= genetlink.h
+header-test-y			+= genhd.h
+header-test-y			+= getcpu.h
+header-test-y			+= gfp.h
+header-test-y			+= glob.h
+header-test-y			+= gnss.h
+header-test-y			+= goldfish.h
+header-test-y			+= gpio-pxa.h
+header-test-y			+= gpio.h
+header-test-y			+= gpio/consumer.h
+header-test-y			+= gpio/driver.h
+header-test-y			+= gpio/machine.h
+header-test-y			+= gpio_keys.h
+header-test-y			+= hardirq.h
+header-test-y			+= hash.h
+header-test-y			+= hashtable.h
+header-test-y			+= hdlc.h
+header-test-y			+= hdlcdrv.h
+header-test-y			+= hdmi.h
+header-test-y			+= hid-roccat.h
+header-test-y			+= hid-sensor-hub.h
+header-test-y			+= hid-sensor-ids.h
+header-test-y			+= hid.h
+header-test-y			+= hidraw.h
+header-test-y			+= highmem.h
+header-test-y			+= highuid.h
+header-test-y			+= hil.h
+header-test-y			+= host1x.h
+header-test-y			+= hpet.h
+header-test-y			+= hrtimer.h
+header-test-y			+= hrtimer_defs.h
+header-test-y			+= hsi/hsi.h
+header-test-y			+= hsi/ssi_protocol.h
+header-test-y			+= htcpld.h
+header-test-y			+= hugetlb.h
+header-test-y			+= hw_breakpoint.h
+header-test-y			+= hw_random.h
+header-test-y			+= hwmon-sysfs.h
+header-test-y			+= hwmon.h
+header-test-y			+= hwspinlock.h
+header-test-y			+= hypervisor.h
+header-test-y			+= i2c-algo-bit.h
+header-test-y			+= i2c-dev.h
+header-test-y			+= i2c-mux.h
+header-test-y			+= i2c-pxa.h
+header-test-y			+= i2c-smbus.h
+header-test-y			+= i2c.h
+subdir-$(CONFIG_I3C)		+= i3c
+header-test-y			+= i8253.h
+header-test-y			+= icmp.h
+header-test-y			+= icmpv6.h
+header-test-y			+= idr.h
+header-test-y			+= ieee80211.h
+header-test-y			+= ieee802154.h
+header-test-y			+= if_arp.h
+header-test-y			+= if_bridge.h
+header-test-y			+= if_eql.h
+header-test-y			+= if_ether.h
+header-test-y			+= if_fddi.h
+header-test-y			+= if_link.h
+header-test-y			+= if_ltalk.h
+header-test-y			+= if_macvlan.h
+header-test-y			+= if_phonet.h
+header-test-y			+= if_pppol2tp.h
+header-test-y			+= if_pppox.h
+header-test-y			+= if_team.h
+header-test-y			+= if_tun.h
+header-test-y			+= if_tunnel.h
+header-test-y			+= if_vlan.h
+header-test-y			+= igmp.h
+header-test-y			+= ihex.h
+subdir-y			+= iio
+header-test-y			+= ima.h
+header-test-y			+= in.h
+header-test-y			+= in6.h
+header-test-y			+= indirect_call_wrapper.h
+header-test-y			+= inet.h
+header-test-y			+= inetdevice.h
+header-test-y			+= init.h
+header-test-y			+= init_task.h
+header-test-y			+= inotify.h
+header-test-y			+= input-polldev.h
+header-test-y			+= input.h
+header-test-y			+= input/ad714x.h
+header-test-y			+= input/adxl34x.h
+header-test-y			+= input/as5011.h
+header-test-y			+= input/auo-pixcir-ts.h
+header-test-y			+= input/cy8ctmg110_pdata.h
+header-test-y			+= input/cyttsp.h
+header-test-y			+= input/elan-i2c-ids.h
+header-test-y			+= input/gp2ap002a00f.h
+header-test-y			+= input/matrix_keypad.h
+header-test-y			+= input/mt.h
+header-test-y			+= input/samsung-keypad.h
+header-test-y			+= input/sh_keysc.h
+header-test-y			+= integrity.h
+header-test-$(CONFIG_X86)	+= intel-iommu.h
+header-test-y			+= interconnect.h
+header-test-y			+= interrupt.h
+header-test-y			+= interval_tree.h
+header-test-y			+= interval_tree_generic.h
+header-test-y			+= io-64-nonatomic-hi-lo.h
+header-test-y			+= io-64-nonatomic-lo-hi.h
+header-test-y			+= io-mapping.h
+header-test-y			+= io-pgtable.h
+header-test-y			+= io.h
+header-test-y			+= ioc4.h
+header-test-y			+= iocontext.h
+header-test-$(CONFIG_BLOCK)	+= iomap.h
+header-test-y			+= iommu-helper.h
+header-test-y			+= iommu.h
+header-test-y			+= iopoll.h
+header-test-y			+= ioport.h
+header-test-y			+= ioprio.h
+header-test-y			+= iova.h
+header-test-y			+= ip.h
+header-test-y			+= ipc.h
+header-test-y			+= ipc_namespace.h
+header-test-y			+= ipmi-fru.h
+header-test-y			+= ipmi.h
+header-test-y			+= ipmi_smi.h
+header-test-y			+= ipv6.h
+header-test-y			+= ipv6_route.h
+header-test-y			+= irq.h
+header-test-y			+= irq_sim.h
+header-test-y			+= irq_work.h
+header-test-y			+= irqbypass.h
+header-test-y			+= irqchip.h
+header-test-y			+= irqchip/arm-gic-common.h
+header-test-y			+= irqchip/arm-gic.h
+header-test-y			+= irqchip/arm-vic.h
+header-test-y			+= irqchip/chained_irq.h
+header-test-y			+= irqchip/ingenic.h
+header-test-y			+= irqchip/irq-bcm2836.h
+header-test-y			+= irqchip/irq-davinci-aintc.h
+header-test-y			+= irqchip/irq-davinci-cp-intc.h
+header-test-y			+= irqchip/irq-ixp4xx.h
+header-test-y			+= irqchip/irq-omap-intc.h
+header-test-y			+= irqchip/mmp.h
+header-test-y			+= irqchip/xtensa-mx.h
+header-test-y			+= irqchip/xtensa-pic.h
+header-test-y			+= irqdomain.h
+header-test-y			+= irqhandler.h
+header-test-y			+= irqnr.h
+header-test-y			+= irqreturn.h
+header-test-y			+= isa.h
+header-test-y			+= isapnp.h
+header-test-y			+= iscsi_ibft.h
+header-test-y			+= isdn/capilli.h
+header-test-y			+= isicom.h
+header-test-y			+= iversion.h
+header-test-y			+= jhash.h
+header-test-y			+= jiffies.h
+header-test-y			+= journal-head.h
+header-test-y			+= joystick.h
+header-test-y			+= jz4780-nemc.h
+header-test-y			+= kallsyms.h
+header-test-y			+= kasan-checks.h
+header-test-y			+= kbd_diacr.h
+header-test-y			+= kbd_kern.h
+header-test-y			+= kbuild.h
+header-test-y			+= kcov.h
+header-test-y			+= kd.h
+header-test-y			+= kdb.h
+header-test-y			+= kdebug.h
+header-test-y			+= kern_levels.h
+header-test-y			+= kernel-page-flags.h
+header-test-y			+= kernel.h
+header-test-y			+= kernel_stat.h
+header-test-y			+= kernfs.h
+header-test-y			+= kexec.h
+header-test-y			+= key-type.h
+header-test-y			+= key.h
+header-test-y			+= keyboard.h
+header-test-y			+= keyctl.h
+header-test-y			+= kfifo.h
+header-test-y			+= kgdb.h
+header-test-y			+= klist.h
+header-test-y			+= kmemleak.h
+header-test-y			+= kmod.h
+header-test-y			+= kmsg_dump.h
+header-test-y			+= kobject.h
+header-test-y			+= kprobes.h
+header-test-y			+= kref.h
+header-test-y			+= ks0108.h
+header-test-y			+= ks8842.h
+header-test-y			+= ks8851_mll.h
+header-test-y			+= ksm.h
+header-test-y			+= kthread.h
+header-test-y			+= ktime.h
+header-test-y			+= kvm_types.h
+header-test-y			+= l2tp.h
+header-test-y			+= lcd.h
+header-test-y			+= lcm.h
+header-test-y			+= led-class-flash.h
+header-test-y			+= leds-pca9532.h
+header-test-y			+= leds-regulator.h
+header-test-y			+= leds-tca6507.h
+header-test-y			+= leds-ti-lmu-common.h
+header-test-y			+= leds.h
+header-test-y			+= libfdt.h
+header-test-y			+= libfdt_env.h
+header-test-y			+= libgcc.h
+header-test-y			+= libnvdimm.h
+header-test-y			+= libps2.h
+header-test-y			+= limits.h
+header-test-y			+= linkage.h
+header-test-y			+= linkmode.h
+header-test-y			+= linux_logo.h
+header-test-y			+= list.h
+header-test-y			+= list_sort.h
+header-test-y			+= livepatch.h
+header-test-y			+= llc.h
+header-test-y			+= llist.h
+header-test-y			+= lockd/bind.h
+header-test-y			+= lockd/debug.h
+header-test-y			+= lockd/lockd.h
+header-test-y			+= lockd/nlm.h
+header-test-y			+= lockd/xdr.h
+header-test-y			+= lockd/xdr4.h
+header-test-y			+= lockdep.h
+header-test-y			+= lockref.h
+header-test-y			+= log2.h
+header-test-y			+= logic_pio.h
+header-test-y			+= lp.h
+header-test-y			+= lru_cache.h
+header-test-y			+= lsm_audit.h
+header-test-y			+= lsm_hooks.h
+header-test-y			+= lz4.h
+header-test-y			+= mISDNdsp.h
+header-test-y			+= mISDNhw.h
+header-test-y			+= mISDNif.h
+header-test-y			+= mailbox/brcm-message.h
+header-test-y			+= mailbox/mtk-cmdq-mailbox.h
+header-test-y			+= mailbox_client.h
+header-test-y			+= mailbox_controller.h
+header-test-y			+= marvell_phy.h
+header-test-y			+= math64.h
+header-test-y			+= max17040_battery.h
+header-test-y			+= mcb.h
+header-test-y			+= mdio-bitbang.h
+header-test-y			+= mdio-gpio.h
+header-test-y			+= mdio-mux.h
+header-test-y			+= mdio.h
+header-test-y			+= mei_cl_bus.h
+header-test-y			+= memblock.h
+header-test-y			+= memcontrol.h
+header-test-y			+= memory.h
+header-test-y			+= memory_hotplug.h
+header-test-y			+= mempolicy.h
+header-test-y			+= mempool.h
+header-test-y			+= memremap.h
+header-test-y			+= memstick.h
+subdir-y			+= mfd
+header-test-y			+= mic_bus.h
+header-test-y			+= micrel_phy.h
+header-test-y			+= microchipphy.h
+header-test-y			+= migrate.h
+header-test-y			+= migrate_mode.h
+header-test-y			+= mii.h
+header-test-y			+= miscdevice.h
+header-test-y			+= mlx4/cmd.h
+header-test-y			+= mlx4/cq.h
+header-test-y			+= mlx4/device.h
+header-test-y			+= mlx4/driver.h
+header-test-y			+= mlx4/qp.h
+header-test-y			+= mlx5/accel.h
+header-test-y			+= mlx5/cmd.h
+header-test-y			+= mlx5/cq.h
+header-test-y			+= mlx5/device.h
+header-test-y			+= mlx5/driver.h
+header-test-y			+= mlx5/eswitch.h
+header-test-y			+= mlx5/fs.h
+header-test-y			+= mlx5/port.h
+header-test-y			+= mlx5/qp.h
+header-test-y			+= mlx5/transobj.h
+header-test-y			+= mlx5/vport.h
+header-test-y			+= mm.h
+header-test-y			+= mm_types.h
+header-test-y			+= mm_types_task.h
+header-test-y			+= mman.h
+subdir-y			+= mmc
+header-test-y			+= mmdebug.h
+header-test-y			+= mmiotrace.h
+header-test-y			+= mmu_notifier.h
+header-test-y			+= mmzone.h
+header-test-y			+= mnt_namespace.h
+header-test-y			+= mod_devicetable.h
+header-test-y			+= module.h
+header-test-y			+= moduleloader.h
+header-test-y			+= moduleparam.h
+header-test-y			+= mount.h
+header-test-y			+= mpi.h
+header-test-y			+= mpls.h
+header-test-y			+= mpls_iptunnel.h
+header-test-y			+= mroute.h
+header-test-y			+= mroute6.h
+header-test-y			+= mroute_base.h
+header-test-y			+= msdos_fs.h
+header-test-y			+= msg.h
+header-test-y			+= msi.h
+subdir-y			+= mtd
+header-test-y			+= mutex.h
+header-test-y			+= mux/consumer.h
+header-test-y			+= mux/driver.h
+header-test-y			+= mv643xx_i2c.h
+header-test-y			+= namei.h
+header-test-y			+= nd.h
+header-test-y			+= net.h
+header-test-y			+= netdev_features.h
+header-test-y			+= netdevice.h
+header-test-y			+= netfilter.h
+header-test-y			+= netfilter/ipset/pfxlen.h
+header-test-y			+= netfilter/nf_conntrack_common.h
+header-test-y			+= netfilter/nf_conntrack_dccp.h
+header-test-y			+= netfilter/nf_conntrack_sane.h
+header-test-y			+= netfilter/nf_conntrack_sctp.h
+header-test-y			+= netfilter/nf_conntrack_tcp.h
+header-test-y			+= netfilter/nf_conntrack_zones_common.h
+header-test-y			+= netfilter/nfnetlink.h
+header-test-y			+= netfilter/nfnetlink_acct.h
+header-test-y			+= netfilter/nfnetlink_osf.h
+header-test-y			+= netfilter/xt_hashlimit.h
+header-test-y			+= netfilter/xt_physdev.h
+header-test-y			+= netfilter_bridge.h
+header-test-y			+= netfilter_bridge/ebt_802_3.h
+header-test-y			+= netfilter_defs.h
+header-test-y			+= netfilter_ingress.h
+header-test-y			+= netfilter_ipv4.h
+header-test-y			+= netfilter_ipv6.h
+header-test-y			+= netlink.h
+header-test-y			+= netpoll.h
+header-test-y			+= nfs3.h
+header-test-y			+= nfs4.h
+header-test-y			+= nfs_fs.h
+header-test-y			+= nfs_iostat.h
+header-test-y			+= nls.h
+header-test-y			+= nmi.h
+header-test-y			+= node.h
+header-test-y			+= nodemask.h
+header-test-y			+= nospec.h
+header-test-y			+= notifier.h
+header-test-y			+= nsproxy.h
+header-test-y			+= ntb.h
+header-test-y			+= numa.h
+header-test-y			+= nvme-tcp.h
+header-test-y			+= nvme.h
+header-test-y			+= nvmem-consumer.h
+header-test-y			+= nvmem-provider.h
+header-test-y			+= of.h
+header-test-y			+= of_address.h
+header-test-y			+= of_device.h
+header-test-y			+= of_dma.h
+header-test-y			+= of_fdt.h
+header-test-y			+= of_gpio.h
+header-test-y			+= of_graph.h
+header-test-y			+= of_iommu.h
+header-test-y			+= of_irq.h
+header-test-y			+= of_mdio.h
+header-test-y			+= of_pci.h
+header-test-y			+= of_platform.h
+header-test-y			+= of_reserved_mem.h
+header-test-y			+= oid_registry.h
+header-test-y			+= omapfb.h
+header-test-y			+= oom.h
+header-test-y			+= openvswitch.h
+header-test-y			+= oprofile.h
+header-test-y			+= packing.h
+header-test-y			+= padata.h
+header-test-y			+= page-flags.h
+header-test-y			+= page_counter.h
+header-test-y			+= page_idle.h
+header-test-y			+= page_ref.h
+header-test-y			+= pageblock-flags.h
+header-test-y			+= pagemap.h
+header-test-y			+= pagevec.h
+header-test-y			+= parman.h
+header-test-y			+= parport.h
+header-test-y			+= pata_arasan_cf_data.h
+header-test-y			+= path.h
+header-test-y			+= pch_dma.h
+header-test-y			+= pci-aspm.h
+header-test-y			+= pci-ats.h
+header-test-y			+= pci-ecam.h
+header-test-y			+= pci-ep-cfs.h
+header-test-y			+= pci-epc.h
+header-test-y			+= pci-epf.h
+header-test-y			+= pci-p2pdma.h
+header-test-y			+= pci.h
+header-test-y			+= pci_ids.h
+header-test-y			+= pe.h
+header-test-y			+= percpu-defs.h
+header-test-y			+= percpu-refcount.h
+header-test-y			+= percpu-rwsem.h
+header-test-y			+= percpu.h
+header-test-y			+= percpu_counter.h
+header-test-y			+= perf_event.h
+header-test-y			+= personality.h
+header-test-y			+= pfn.h
+header-test-y			+= pfn_t.h
+header-test-y			+= phonet.h
+header-test-y			+= phy.h
+header-test-y			+= phy/omap_usb.h
+header-test-y			+= phy/phy-mipi-dphy.h
+header-test-y			+= phy/phy-sun4i-usb.h
+header-test-y			+= phy/phy.h
+header-test-y			+= phy_led_triggers.h
+header-test-y			+= phylink.h
+header-test-y			+= pid.h
+header-test-y			+= pid_namespace.h
+header-test-y			+= pim.h
+subdir-y			+= pinctrl
+header-test-y			+= pkeys.h
+subdir-y			+= platform_data
+header-test-y			+= platform_device.h
+header-test-y			+= plist.h
+header-test-y			+= pm-trace.h
+header-test-y			+= pm.h
+header-test-y			+= pm_clock.h
+header-test-y			+= pm_domain.h
+header-test-y			+= pm_opp.h
+header-test-y			+= pm_qos.h
+header-test-y			+= pm_runtime.h
+header-test-y			+= pnfs_osd_xdr.h
+header-test-y			+= pnp.h
+header-test-y			+= poison.h
+header-test-y			+= poll.h
+header-test-y			+= posix-clock.h
+header-test-y			+= posix-timers.h
+header-test-y			+= power/bq2415x_charger.h
+header-test-y			+= power/bq24190_charger.h
+header-test-y			+= power/bq24735-charger.h
+header-test-y			+= power/charger-manager.h
+header-test-y			+= power/gpio-charger.h
+header-test-y			+= power/sbs-battery.h
+header-test-y			+= power/smartreflex.h
+header-test-y			+= power/smb347-charger.h
+header-test-y			+= power/twl4030_madc_battery.h
+header-test-y			+= power_supply.h
+header-test-y			+= powercap.h
+header-test-y			+= ppp_channel.h
+header-test-y			+= ppp_defs.h
+header-test-y			+= pps_kernel.h
+header-test-y			+= preempt.h
+header-test-y			+= prefetch.h
+header-test-y			+= prime_numbers.h
+header-test-y			+= printk.h
+header-test-y			+= proc_fs.h
+header-test-y			+= profile.h
+header-test-y			+= projid.h
+header-test-y			+= property.h
+header-test-y			+= psci.h
+header-test-y			+= psi_types.h
+header-test-y			+= pstore_ram.h
+header-test-y			+= pti.h
+header-test-y			+= ptp_classify.h
+header-test-y			+= ptp_clock_kernel.h
+header-test-y			+= purgatory.h
+header-test-y			+= pvclock_gtod.h
+header-test-y			+= pwm.h
+header-test-y			+= pwm_backlight.h
+header-test-y			+= pxa168_eth.h
+header-test-y			+= pxa2xx_ssp.h
+header-test-y			+= qcom_scm.h
+header-test-y			+= qed/common_hsi.h
+header-test-y			+= qed/qed_chain.h
+header-test-y			+= qed/qed_if.h
+header-test-y			+= qed/qed_iov_if.h
+header-test-y			+= qed/qed_iscsi_if.h
+header-test-y			+= qed/qed_ll2_if.h
+header-test-y			+= qed/qed_rdma_if.h
+header-test-y			+= qed/qede_rdma.h
+header-test-y			+= qed/roce_common.h
+header-test-y			+= quota.h
+header-test-y			+= quotaops.h
+header-test-y			+= radix-tree.h
+header-test-y			+= raid/md_u.h
+header-test-y			+= raid/pq.h
+header-test-y			+= raid/xor.h
+header-test-y			+= random.h
+header-test-y			+= ras.h
+header-test-y			+= ratelimit.h
+header-test-y			+= rational.h
+header-test-y			+= rbtree.h
+header-test-y			+= rbtree_augmented.h
+header-test-y			+= rbtree_latch.h
+header-test-y			+= rcu_segcblist.h
+header-test-y			+= rcu_sync.h
+header-test-y			+= rculist.h
+header-test-y			+= rcupdate.h
+header-test-y			+= rcupdate_wait.h
+header-test-y			+= rcuwait.h
+header-test-y			+= reboot.h
+header-test-y			+= reciprocal_div.h
+header-test-y			+= refcount.h
+header-test-y			+= regmap.h
+header-test-y			+= regset.h
+subdir-y			+= regulator
+header-test-y			+= relay.h
+header-test-y			+= remoteproc.h
+header-test-y			+= remoteproc/qcom_rproc.h
+header-test-y			+= reservation.h
+header-test-y			+= reset-controller.h
+header-test-y			+= reset.h
+header-test-y			+= reset/bcm63xx_pmb.h
+header-test-y			+= resource.h
+header-test-y			+= resource_ext.h
+header-test-y			+= restart_block.h
+header-test-y			+= rfkill.h
+header-test-y			+= rhashtable-types.h
+header-test-y			+= rhashtable.h
+header-test-y			+= ring_buffer.h
+header-test-y			+= rio.h
+header-test-y			+= rio_drv.h
+header-test-y			+= rio_ids.h
+header-test-y			+= rio_regs.h
+header-test-y			+= rmap.h
+header-test-y			+= rmi.h
+header-test-y			+= rndis.h
+header-test-y			+= rodata_test.h
+header-test-y			+= root_dev.h
+header-test-y			+= rpmsg.h
+header-test-y			+= rpmsg/qcom_glink.h
+header-test-y			+= rpmsg/qcom_smd.h
+header-test-y			+= rslib.h
+header-test-y			+= rtc.h
+header-test-y			+= rtc/ds1286.h
+header-test-y			+= rtc/ds1307.h
+header-test-y			+= rtc/ds1685.h
+header-test-y			+= rtmutex.h
+header-test-y			+= rtnetlink.h
+header-test-y			+= rtsx_common.h
+header-test-y			+= rtsx_pci.h
+header-test-y			+= rtsx_usb.h
+header-test-y			+= rwsem.h
+header-test-y			+= s3c_adc_battery.h
+header-test-y			+= sbitmap.h
+header-test-y			+= scatterlist.h
+subdir-y			+= sched
+header-test-y			+= sched.h
+header-test-y			+= scif.h
+header-test-y			+= screen_info.h
+header-test-y			+= sctp.h
+header-test-y			+= scx200.h
+header-test-y			+= sdb.h
+header-test-y			+= sdla.h
+header-test-y			+= securebits.h
+header-test-y			+= security.h
+header-test-y			+= seg6.h
+header-test-y			+= seg6_genl.h
+header-test-y			+= seg6_hmac.h
+header-test-y			+= seg6_local.h
+header-test-y			+= sem.h
+header-test-y			+= semaphore.h
+header-test-y			+= seq_buf.h
+header-test-y			+= seq_file.h
+header-test-y			+= seq_file_net.h
+header-test-y			+= seqlock.h
+header-test-y			+= seqno-fence.h
+header-test-y			+= serdev.h
+header-test-y			+= serial.h
+header-test-y			+= serial_8250.h
+header-test-y			+= serial_bcm63xx.h
+header-test-y			+= serial_core.h
+header-test-y			+= serial_max3100.h
+header-test-y			+= serial_pnx8xxx.h
+header-test-y			+= serial_s3c.h
+header-test-y			+= serial_sci.h
+header-test-y			+= serio.h
+header-test-y			+= sfi.h
+header-test-y			+= sfi_acpi.h
+header-test-y			+= sfp.h
+header-test-y			+= sh_clk.h
+header-test-y			+= sh_dma.h
+header-test-y			+= sh_eth.h
+header-test-y			+= sh_intc.h
+header-test-y			+= sh_timer.h
+header-test-y			+= sha256.h
+header-test-y			+= shdma-base.h
+header-test-y			+= shm.h
+header-test-y			+= shmem_fs.h
+header-test-y			+= signal.h
+header-test-y			+= signal_types.h
+header-test-y			+= signalfd.h
+header-test-y			+= siphash.h
+header-test-y			+= sizes.h
+header-test-y			+= skbuff.h
+header-test-y			+= skmsg.h
+header-test-y			+= slab.h
+header-test-y			+= slimbus.h
+header-test-y			+= sm501-regs.h
+header-test-y			+= smc911x.h
+header-test-y			+= smp.h
+header-test-y			+= smpboot.h
+header-test-y			+= smsc911x.h
+header-test-y			+= smscphy.h
+header-test-y			+= soc/cirrus/ep93xx.h
+header-test-y			+= soc/dove/pmu.h
+header-test-y			+= soc/ixp4xx/qmgr.h
+header-test-y			+= soc/mediatek/mtk-cmdq.h
+header-test-y			+= soc/qcom/apr.h
+header-test-y			+= soc/qcom/llcc-qcom.h
+header-test-y			+= soc/qcom/mdt_loader.h
+header-test-y			+= soc/qcom/qmi.h
+header-test-y			+= soc/renesas/rcar-sysc.h
+header-test-y			+= soc/samsung/exynos-regs-pmu.h
+header-test-y			+= soc/ti/knav_dma.h
+header-test-y			+= soc/ti/knav_qmss.h
+header-test-y			+= sock_diag.h
+header-test-y			+= socket.h
+header-test-y			+= sonet.h
+header-test-y			+= sony-laptop.h
+header-test-y			+= sonypi.h
+header-test-y			+= sort.h
+header-test-y			+= sound.h
+header-test-y			+= soundcard.h
+header-test-y			+= soundwire/sdw_registers.h
+subdir-y			+= spi
+header-test-y			+= spinlock.h
+header-test-y			+= spmi.h
+header-test-y			+= srcu.h
+header-test-y			+= ssb/ssb.h
+header-test-y			+= ssb/ssb_driver_gige.h
+header-test-y			+= ssb/ssb_embedded.h
+header-test-y			+= ssb/ssb_regs.h
+header-test-y			+= stackleak.h
+header-test-y			+= stackprotector.h
+header-test-y			+= stacktrace.h
+header-test-y			+= start_kernel.h
+header-test-y			+= stat.h
+header-test-y			+= statfs.h
+header-test-y			+= stddef.h
+header-test-y			+= stm.h
+header-test-y			+= stmmac.h
+header-test-y			+= stmp_device.h
+header-test-y			+= stop_machine.h
+header-test-y			+= string.h
+header-test-y			+= stringhash.h
+header-test-y			+= stringify.h
+subdir-y			+= sunrpc
+header-test-y			+= sunserialcore.h
+header-test-y			+= superhyway.h
+header-test-y			+= suspend.h
+header-test-y			+= swab.h
+header-test-y			+= swait.h
+header-test-y			+= swap.h
+header-test-y			+= swap_cgroup.h
+header-test-y			+= swap_slots.h
+header-test-y			+= switchtec.h
+header-test-y			+= sxgbe_platform.h
+header-test-y			+= sync_core.h
+header-test-y			+= sync_file.h
+header-test-y			+= synclink.h
+header-test-y			+= sys.h
+header-test-y			+= sys_soc.h
+header-test-y			+= syscalls.h
+header-test-y			+= syscore_ops.h
+header-test-y			+= sysctl.h
+header-test-y			+= sysfs.h
+header-test-y			+= syslog.h
+header-test-y			+= sysrq.h
+header-test-y			+= task_io_accounting_ops.h
+header-test-y			+= task_work.h
+header-test-y			+= taskstats_kern.h
+header-test-y			+= tboot.h
+header-test-y			+= tc.h
+header-test-y			+= tca6416_keypad.h
+header-test-y			+= tcp.h
+header-test-y			+= tee_drv.h
+header-test-y			+= textsearch.h
+header-test-y			+= textsearch_fsm.h
+header-test-y			+= tfrc.h
+header-test-y			+= thermal.h
+header-test-y			+= thread_info.h
+header-test-y			+= threads.h
+header-test-y			+= thunderbolt.h
+header-test-y			+= ti-emif-sram.h
+header-test-y			+= ti_wilink_st.h
+header-test-y			+= tifm.h
+header-test-y			+= timb_gpio.h
+header-test-y			+= time.h
+header-test-y			+= time32.h
+header-test-y			+= time64.h
+header-test-y			+= timecounter.h
+header-test-y			+= timekeeper_internal.h
+header-test-y			+= timer.h
+header-test-y			+= timerfd.h
+header-test-y			+= timerqueue.h
+header-test-y			+= timex.h
+header-test-y			+= topology.h
+header-test-y			+= torture.h
+header-test-y			+= toshiba.h
+header-test-y			+= tpm.h
+header-test-y			+= tpm_command.h
+header-test-y			+= tpm_eventlog.h
+header-test-y			+= trace.h
+header-test-y			+= trace_clock.h
+header-test-y			+= trace_events.h
+header-test-y			+= trace_seq.h
+header-test-y			+= tracefs.h
+header-test-y			+= tracehook.h
+header-test-y			+= tracepoint-defs.h
+header-test-y			+= tracepoint.h
+header-test-y			+= transport_class.h
+header-test-y			+= tty.h
+header-test-y			+= tty_driver.h
+header-test-y			+= typecheck.h
+header-test-y			+= types.h
+header-test-y			+= u64_stats_sync.h
+header-test-y			+= uaccess.h
+header-test-y			+= ucs2_string.h
+header-test-y			+= udp.h
+header-test-y			+= uidgid.h
+header-test-y			+= uio.h
+header-test-y			+= uio_driver.h
+header-test-y			+= ulpi/driver.h
+header-test-y			+= ulpi/interface.h
+header-test-y			+= ulpi/regs.h
+header-test-y			+= umh.h
+header-test-y			+= unaligned/access_ok.h
+header-test-y			+= unaligned/be_byteshift.h
+header-test-y			+= unaligned/be_memmove.h
+header-test-y			+= unaligned/be_struct.h
+header-test-y			+= unaligned/generic.h
+header-test-y			+= unaligned/le_byteshift.h
+header-test-y			+= unaligned/le_memmove.h
+header-test-y			+= unaligned/le_struct.h
+header-test-y			+= unaligned/memmove.h
+header-test-y			+= unaligned/packed_struct.h
+header-test-y			+= unicode.h
+header-test-y			+= uprobes.h
+subdir-y			+= usb
+header-test-y			+= usb.h
+header-test-y			+= usbdevice_fs.h
+header-test-y			+= user.h
+header-test-y			+= user_namespace.h
+header-test-y			+= util_macros.h
+header-test-y			+= uts.h
+header-test-y			+= utsname.h
+header-test-y			+= uuid.h
+header-test-y			+= uwb.h
+header-test-y			+= uwb/debug-cmd.h
+header-test-y			+= uwb/spec.h
+header-test-y			+= uwb/umc.h
+header-test-y			+= uwb/whci.h
+header-test-y			+= vbox_utils.h
+header-test-y			+= vermagic.h
+header-test-y			+= vexpress.h
+header-test-y			+= vfio.h
+header-test-y			+= vfs.h
+header-test-y			+= vga_switcheroo.h
+header-test-y			+= via-core.h
+header-test-y			+= via-gpio.h
+header-test-y			+= via.h
+header-test-y			+= videodev2.h
+header-test-y			+= virtio.h
+header-test-y			+= virtio_caif.h
+header-test-y			+= virtio_config.h
+header-test-y			+= virtio_console.h
+header-test-y			+= virtio_net.h
+header-test-y			+= virtio_vsock.h
+header-test-y			+= vlynq.h
+header-test-y			+= vm_event_item.h
+header-test-y			+= vm_sockets.h
+header-test-y			+= vmacache.h
+header-test-y			+= vmalloc.h
+header-test-y			+= vmpressure.h
+header-test-y			+= vt.h
+header-test-y			+= vt_kern.h
+header-test-y			+= vtime.h
+header-test-y			+= w1-gpio.h
+header-test-y			+= w1.h
+header-test-y			+= wait.h
+header-test-y			+= wait_bit.h
+header-test-y			+= watchdog.h
+header-test-y			+= win_minmax.h
+header-test-y			+= wireless.h
+header-test-y			+= wkup_m3_ipc.h
+header-test-y			+= wl12xx.h
+header-test-y			+= wm97xx.h
+header-test-y			+= wmi.h
+header-test-y			+= workqueue.h
+header-test-y			+= writeback.h
+header-test-y			+= ww_mutex.h
+header-test-y			+= xarray.h
+header-test-y			+= xattr.h
+header-test-y			+= xxhash.h
+header-test-y			+= xz.h
+header-test-y			+= z2_battery.h
+header-test-y			+= zbud.h
+header-test-y			+= zconf.h
+header-test-y			+= zlib.h
+header-test-y			+= zsmalloc.h
+header-test-y			+= zstd.h
+header-test-y			+= zutil.h
diff --git a/include/linux/byteorder/Kbuild b/include/linux/byteorder/Kbuild
new file mode 100644
index 000000000000..6ae647255b83
--- /dev/null
+++ b/include/linux/byteorder/Kbuild
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-$(CONFIG_CPU_BIG_ENDIAN)	+= big_endian.h
+header-test-$(CONFIG_CPU_LITTLE_ENDIAN)	+= little_endian.h
diff --git a/include/linux/ceph/Kbuild b/include/linux/ceph/Kbuild
new file mode 100644
index 000000000000..55ca6b501635
--- /dev/null
+++ b/include/linux/ceph/Kbuild
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= auth.h
+header-test-y			+= buffer.h
+header-test-y			+= ceph_debug.h
+header-test-y			+= ceph_hash.h
+header-test-y			+= cls_lock_client.h
+header-test-y			+= decode.h
+header-test-y			+= libceph.h
+header-test-y			+= mdsmap.h
+header-test-y			+= messenger.h
+header-test-y			+= mon_client.h
+header-test-y			+= msgpool.h
+header-test-y			+= osd_client.h
+header-test-y			+= osdmap.h
+header-test-y			+= pagelist.h
+header-test-y			+= string_table.h
+header-test-y			+= striper.h
+header-test-y			+= types.h
diff --git a/include/linux/i3c/Kbuild b/include/linux/i3c/Kbuild
new file mode 100644
index 000000000000..eda6c6c121f6
--- /dev/null
+++ b/include/linux/i3c/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ccc.h
+header-test-y			+= device.h
+header-test-y			+= master.h
diff --git a/include/linux/iio/Kbuild b/include/linux/iio/Kbuild
new file mode 100644
index 000000000000..570778642164
--- /dev/null
+++ b/include/linux/iio/Kbuild
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= adc/stm32-dfsdm-adc.h
+header-test-y			+= buffer-dmaengine.h
+header-test-y			+= buffer.h
+header-test-y			+= common/cros_ec_sensors_core.h
+header-test-y			+= common/ssp_sensors.h
+header-test-y			+= configfs.h
+header-test-y			+= consumer.h
+header-test-y			+= driver.h
+header-test-y			+= events.h
+header-test-y			+= gyro/itg3200.h
+header-test-y			+= iio.h
+header-test-y			+= kfifo_buf.h
+header-test-y			+= machine.h
+header-test-y			+= magnetometer/ak8975.h
+header-test-y			+= sw_device.h
+header-test-y			+= sw_trigger.h
+header-test-y			+= timer/stm32-lptim-trigger.h
+header-test-y			+= trigger_consumer.h
+header-test-y			+= triggered_buffer.h
+header-test-y			+= types.h
diff --git a/include/linux/mfd/Kbuild b/include/linux/mfd/Kbuild
new file mode 100644
index 000000000000..585397410777
--- /dev/null
+++ b/include/linux/mfd/Kbuild
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= aat2870.h
+header-test-y			+= ab3100.h
+header-test-y			+= abx500.h
+header-test-y			+= abx500/ab8500-codec.h
+header-test-y			+= abx500/ab8500-sysctrl.h
+header-test-y			+= abx500/ab8500.h
+header-test-y			+= abx500/ux500_chargalg.h
+header-test-y			+= ac100.h
+header-test-y			+= altera-a10sr.h
+header-test-y			+= altera-sysmgr.h
+header-test-y			+= arizona/core.h
+header-test-y			+= arizona/registers.h
+header-test-y			+= asic3.h
+header-test-y			+= atmel-hlcdc.h
+header-test-y			+= axp20x.h
+header-test-y			+= bcm2835-pm.h
+header-test-y			+= bcm590xx.h
+header-test-y			+= bd9571mwv.h
+header-test-y			+= core.h
+header-test-y			+= cros_ec.h
+header-test-y			+= da8xx-cfgchip.h
+header-test-y			+= da9052/da9052.h
+header-test-y			+= da9052/pdata.h
+header-test-y			+= da9052/reg.h
+header-test-y			+= da9055/core.h
+header-test-y			+= da9055/reg.h
+header-test-y			+= da9062/core.h
+header-test-y			+= da9062/registers.h
+header-test-y			+= da9063/core.h
+header-test-y			+= da9063/registers.h
+header-test-y			+= da9150/core.h
+header-test-y			+= da9150/registers.h
+header-test-y			+= davinci_voicecodec.h
+header-test-y			+= hi6421-pmic.h
+header-test-y			+= hi655x-pmic.h
+header-test-y			+= htc-pasic3.h
+header-test-y			+= imx25-tsadc.h
+header-test-y			+= ingenic-tcu.h
+header-test-y			+= intel_soc_pmic.h
+header-test-y			+= intel_soc_pmic_bxtwc.h
+header-test-y			+= ipaq-micro.h
+header-test-y			+= lochnagar.h
+header-test-y			+= lochnagar1_regs.h
+header-test-y			+= lochnagar2_regs.h
+header-test-y			+= lp3943.h
+header-test-y			+= lp873x.h
+header-test-y			+= lp87565.h
+header-test-y			+= lp8788.h
+header-test-y			+= madera/core.h
+header-test-y			+= madera/pdata.h
+header-test-y			+= madera/registers.h
+header-test-y			+= max14577-private.h
+header-test-y			+= max14577.h
+header-test-y			+= max77620.h
+header-test-y			+= max77650.h
+header-test-y			+= max77686-private.h
+header-test-y			+= max77686.h
+header-test-y			+= max77693-common.h
+header-test-y			+= max77693-private.h
+header-test-y			+= max77843-private.h
+header-test-y			+= max8907.h
+header-test-y			+= max8925.h
+header-test-y			+= max8997-private.h
+header-test-y			+= max8997.h
+header-test-y			+= max8998.h
+header-test-y			+= mc13783.h
+header-test-y			+= mc13892.h
+header-test-y			+= mc13xxx.h
+header-test-y			+= mcp.h
+header-test-y			+= mt6323/core.h
+header-test-y			+= mt6323/registers.h
+header-test-y			+= mt6397/registers.h
+header-test-y			+= mxs-lradc.h
+header-test-y			+= pcf50633/adc.h
+header-test-y			+= pcf50633/core.h
+header-test-y			+= pcf50633/gpio.h
+header-test-y			+= pcf50633/mbc.h
+header-test-y			+= pcf50633/pmic.h
+header-test-y			+= qcom_rpm.h
+header-test-y			+= rave-sp.h
+header-test-y			+= rdc321x.h
+header-test-y			+= rk808.h
+header-test-y			+= rn5t618.h
+header-test-y			+= rohm-bd718x7.h
+header-test-y			+= rt5033-private.h
+header-test-y			+= rt5033.h
+header-test-y			+= samsung/irq.h
+header-test-y			+= samsung/rtc.h
+header-test-y			+= samsung/s2mpa01.h
+header-test-y			+= samsung/s2mps11.h
+header-test-y			+= samsung/s2mps13.h
+header-test-y			+= samsung/s2mps14.h
+header-test-y			+= samsung/s2mps15.h
+header-test-y			+= samsung/s2mpu02.h
+header-test-y			+= samsung/s5m8763.h
+header-test-y			+= samsung/s5m8767.h
+header-test-y			+= si476x-core.h
+header-test-y			+= stm32-lptimer.h
+header-test-y			+= stm32-timers.h
+header-test-y			+= stmpe.h
+header-test-y			+= stpmic1.h
+header-test-y			+= stw481x.h
+header-test-y			+= sun4i-gpadc.h
+header-test-y			+= syscon.h
+header-test-y			+= syscon/atmel-matrix.h
+header-test-y			+= syscon/atmel-mc.h
+header-test-y			+= syscon/atmel-smc.h
+header-test-y			+= syscon/atmel-st.h
+header-test-y			+= syscon/clps711x.h
+header-test-y			+= syscon/imx6q-iomuxc-gpr.h
+header-test-y			+= syscon/imx7-iomuxc-gpr.h
+header-test-y			+= t7l66xb.h
+header-test-y			+= ti-lmu-register.h
+header-test-y			+= ti-lmu.h
+header-test-y			+= ti_am335x_tscadc.h
+header-test-y			+= tmio.h
+header-test-y			+= tps6105x.h
+header-test-y			+= tps65010.h
+header-test-y			+= tps6507x.h
+header-test-y			+= tps65086.h
+header-test-y			+= tps65217.h
+header-test-y			+= tps65218.h
+header-test-y			+= tps65912.h
+header-test-y			+= tps68470.h
+header-test-y			+= twl.h
+header-test-y			+= twl4030-audio.h
+header-test-y			+= twl6040.h
+header-test-y			+= wl1273-core.h
+header-test-y			+= wm831x/auxadc.h
+header-test-y			+= wm831x/gpio.h
+header-test-y			+= wm831x/irq.h
+header-test-y			+= wm831x/pmu.h
+header-test-y			+= wm831x/regulator.h
+header-test-y			+= wm831x/status.h
+header-test-y			+= wm831x/watchdog.h
+header-test-y			+= wm8350/audio.h
+header-test-y			+= wm8350/comparator.h
+header-test-y			+= wm8350/core.h
+header-test-y			+= wm8350/gpio.h
+header-test-y			+= wm8350/pmic.h
+header-test-y			+= wm8350/rtc.h
+header-test-y			+= wm8350/supply.h
+header-test-y			+= wm8350/wdt.h
+header-test-y			+= wm8400-audio.h
+header-test-y			+= wm8400-private.h
+header-test-y			+= wm8400.h
+header-test-y			+= wm8994/gpio.h
+header-test-y			+= wm8994/registers.h
+header-test-y			+= wm97xx.h
diff --git a/include/linux/mmc/Kbuild b/include/linux/mmc/Kbuild
new file mode 100644
index 000000000000..34e9b2b55f7a
--- /dev/null
+++ b/include/linux/mmc/Kbuild
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= card.h
+header-test-y			+= core.h
+header-test-y			+= host.h
+header-test-y			+= mmc.h
+header-test-y			+= pm.h
+header-test-y			+= sd.h
+header-test-y			+= sdhci-pci-data.h
+header-test-y			+= sdio.h
+header-test-y			+= sdio_func.h
+header-test-y			+= sdio_ids.h
+header-test-y			+= sh_mmcif.h
+header-test-y			+= slot-gpio.h
diff --git a/include/linux/mtd/Kbuild b/include/linux/mtd/Kbuild
new file mode 100644
index 000000000000..eedbbe81d72d
--- /dev/null
+++ b/include/linux/mtd/Kbuild
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= blktrans.h
+header-test-y			+= cfi_endian.h
+header-test-y			+= concat.h
+header-test-y			+= hyperbus.h
+header-test-y			+= inftl.h
+header-test-y			+= latch-addr-flash.h
+header-test-y			+= lpc32xx_mlc.h
+header-test-y			+= lpc32xx_slc.h
+header-test-y			+= map.h
+header-test-y			+= mtd.h
+header-test-y			+= mtdram.h
+header-test-y			+= nand-gpio.h
+header-test-y			+= nand.h
+header-test-y			+= nftl.h
+header-test-y			+= onenand_regs.h
+header-test-y			+= onfi.h
+header-test-y			+= partitions.h
+header-test-y			+= pfow.h
+header-test-y			+= physmap.h
+header-test-y			+= platnand.h
+header-test-y			+= qinfo.h
+header-test-y			+= rawnand.h
+header-test-y			+= sh_flctl.h
+header-test-y			+= spear_smi.h
+header-test-y			+= spinand.h
+header-test-y			+= super.h
+header-test-y			+= ubi.h
+header-test-y			+= xip.h
diff --git a/include/linux/pinctrl/Kbuild b/include/linux/pinctrl/Kbuild
new file mode 100644
index 000000000000..9d79aabe3fb5
--- /dev/null
+++ b/include/linux/pinctrl/Kbuild
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= consumer.h
+header-test-y			+= devinfo.h
+header-test-y			+= machine.h
+header-test-y			+= pinconf-generic.h
+header-test-y			+= pinconf.h
+header-test-y			+= pinctrl-state.h
+header-test-y			+= pinctrl.h
+header-test-y			+= pinmux.h
diff --git a/include/linux/platform_data/Kbuild b/include/linux/platform_data/Kbuild
new file mode 100644
index 000000000000..10fe56c5bcdd
--- /dev/null
+++ b/include/linux/platform_data/Kbuild
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ad5761.h
+header-test-y			+= adau1977.h
+header-test-y			+= adp5588.h
+header-test-y			+= adp8860.h
+header-test-y			+= ams-delta-fiq.h
+header-test-y			+= asoc-imx-ssi.h
+header-test-y			+= asoc-kirkwood.h
+header-test-y			+= asoc-mx27vis.h
+header-test-y			+= asoc-palm27x.h
+header-test-y			+= asoc-ti-mcbsp.h
+header-test-y			+= asoc-ux500-msp.h
+header-test-y			+= ata-samsung_cf.h
+header-test-y			+= b53.h
+header-test-y			+= bcmgenet.h
+header-test-y			+= bd6107.h
+header-test-y			+= clk-da8xx-cfgchip.h
+header-test-y			+= clk-davinci-pll.h
+header-test-y			+= clk-integrator.h
+header-test-y			+= clk-st.h
+header-test-y			+= cpuidle-exynos.h
+header-test-y			+= crypto-atmel.h
+header-test-y			+= crypto-ux500.h
+header-test-y			+= davinci-cpufreq.h
+header-test-y			+= davinci_asp.h
+header-test-y			+= db8500_thermal.h
+header-test-y			+= dma-atmel.h
+header-test-y			+= dma-dw.h
+header-test-y			+= dma-ep93xx.h
+header-test-y			+= dma-hsu.h
+header-test-y			+= dma-imx.h
+header-test-y			+= dma-mmp_tdma.h
+header-test-y			+= dma-mv_xor.h
+header-test-y			+= dma-ste-dma40.h
+header-test-y			+= ds620.h
+header-test-y			+= efm32-spi.h
+header-test-y			+= efm32-uart.h
+header-test-y			+= ehci-sh.h
+header-test-y			+= eth-ep93xx.h
+header-test-y			+= eth-netx.h
+header-test-y			+= gpio-omap.h
+header-test-y			+= gpio/gpio-amd-fch.h
+header-test-y			+= gpio_backlight.h
+header-test-y			+= i2c-designware.h
+header-test-y			+= i2c-gpio.h
+header-test-y			+= i2c-hid.h
+header-test-y			+= i2c-mux-gpio.h
+header-test-y			+= i2c-omap.h
+header-test-y			+= i2c-pca-platform.h
+header-test-y			+= i2c-pxa.h
+header-test-y			+= i2c-s3c2410.h
+header-test-y			+= intel-mid_wdt.h
+header-test-y			+= isl9305.h
+header-test-y			+= keyboard-spear.h
+header-test-y			+= keypad-ep93xx.h
+header-test-y			+= keypad-nomadik-ske.h
+header-test-y			+= keypad-pxa27x.h
+header-test-y			+= keypad-w90p910.h
+header-test-y			+= keyscan-davinci.h
+header-test-y			+= lcd-mipid.h
+header-test-y			+= leds-kirkwood-ns2.h
+header-test-y			+= leds-lm3642.h
+header-test-y			+= leds-pca963x.h
+header-test-y			+= leds-s3c24xx.h
+header-test-y			+= lm3630a_bl.h
+header-test-y			+= lm3639_bl.h
+header-test-y			+= lm8323.h
+header-test-y			+= lp8755.h
+header-test-y			+= ltc4245.h
+header-test-y			+= lv5207lp.h
+header-test-y			+= macb.h
+header-test-y			+= max6639.h
+header-test-y			+= max6697.h
+header-test-y			+= media/camera-mx2.h
+header-test-y			+= media/camera-mx3.h
+header-test-y			+= media/camera-pxa.h
+header-test-y			+= media/coda.h
+header-test-y			+= media/omap1_camera.h
+header-test-y			+= media/omap4iss.h
+header-test-y			+= media/s5p_hdmi.h
+header-test-y			+= media/timb_radio.h
+header-test-y			+= media/timb_video.h
+header-test-y			+= mfd-mcp-sa11x0.h
+header-test-y			+= microchip-ksz.h
+header-test-y			+= mmc-davinci.h
+header-test-y			+= mmc-esdhc-imx.h
+header-test-y			+= mmc-mxcmmc.h
+header-test-y			+= mmc-pxamci.h
+header-test-y			+= mmc-s3cmci.h
+header-test-y			+= mmp_dma.h
+header-test-y			+= mouse-pxa930_trkball.h
+header-test-y			+= mtd-davinci-aemif.h
+header-test-y			+= mtd-davinci.h
+header-test-y			+= mtd-mxc_nand.h
+header-test-y			+= mtd-nand-omap2.h
+header-test-y			+= mtd-nand-pxa3xx.h
+header-test-y			+= mtd-nand-s3c2410.h
+header-test-y			+= mv_usb.h
+header-test-y			+= nfcmrvl.h
+header-test-y			+= ntc_thermistor.h
+header-test-y			+= nxp-nci.h
+header-test-y			+= omap-wd-timer.h
+header-test-y			+= omap1_bl.h
+header-test-y			+= pca953x.h
+header-test-y			+= pcmcia-pxa2xx_viper.h
+header-test-y			+= phy-da8xx-usb.h
+header-test-y			+= pm33xx.h
+header-test-y			+= regulator-haptic.h
+header-test-y			+= rtc-ds2404.h
+header-test-y			+= rtc-v3020.h
+header-test-y			+= s3c-hsotg.h
+header-test-y			+= s3c-hsudc.h
+header-test-y			+= serial-imx.h
+header-test-y			+= serial-omap.h
+header-test-y			+= shmob_drm.h
+header-test-y			+= simplefb.h
+header-test-y			+= spi-ath79.h
+header-test-y			+= spi-clps711x.h
+header-test-y			+= spi-imx.h
+header-test-y			+= spi-omap2-mcspi.h
+header-test-y			+= spi-s3c64xx.h
+header-test-y			+= ssm2518.h
+header-test-y			+= st33zp24.h
+header-test-y			+= syscon.h
+header-test-y			+= tc35876x.h
+header-test-y			+= tda9950.h
+header-test-y			+= ti-aemif.h
+header-test-y			+= tsl2563.h
+header-test-y			+= txx9/ndfmc.h
+header-test-y			+= uio_dmem_genirq.h
+header-test-y			+= usb-musb-ux500.h
+header-test-y			+= usb-ohci-pxa27x.h
+header-test-y			+= usb-omap1.h
+header-test-y			+= usb-pxa3xx-ulpi.h
+header-test-y			+= video-ep93xx.h
+header-test-y			+= video-mx3fb.h
+header-test-y			+= wilco-ec.h
+header-test-y			+= wiznet.h
+header-test-y			+= wkup_m3.h
+header-test-y			+= x86/asus-wmi.h
+header-test-y			+= x86/clk-lpss.h
+header-test-y			+= x86/mlxcpld.h
+header-test-y			+= xilinx-ll-temac.h
+header-test-y			+= zforce_ts.h
diff --git a/include/linux/regulator/Kbuild b/include/linux/regulator/Kbuild
new file mode 100644
index 000000000000..bfcce893092c
--- /dev/null
+++ b/include/linux/regulator/Kbuild
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ab8500.h
+header-test-y			+= act8865.h
+header-test-y			+= arizona-ldo1.h
+header-test-y			+= arizona-micsupp.h
+header-test-y			+= consumer.h
+header-test-y			+= coupler.h
+header-test-y			+= da9211.h
+header-test-y			+= db8500-prcmu.h
+header-test-y			+= driver.h
+header-test-y			+= fan53555.h
+header-test-y			+= lp3971.h
+header-test-y			+= lp3972.h
+header-test-y			+= lp872x.h
+header-test-y			+= machine.h
+header-test-y			+= max1586.h
+header-test-y			+= max8649.h
+header-test-y			+= max8660.h
+header-test-y			+= max8952.h
+header-test-y			+= mt6311.h
+header-test-y			+= mt6323-regulator.h
+header-test-y			+= mt6380-regulator.h
+header-test-y			+= mt6397-regulator.h
+header-test-y			+= pfuze100.h
diff --git a/include/linux/sched/Kbuild b/include/linux/sched/Kbuild
new file mode 100644
index 000000000000..d6d87b0b8e59
--- /dev/null
+++ b/include/linux/sched/Kbuild
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= autogroup.h
+header-test-y			+= clock.h
+header-test-y			+= coredump.h
+header-test-y			+= cpufreq.h
+header-test-y			+= cputime.h
+header-test-y			+= debug.h
+header-test-y			+= hotplug.h
+header-test-y			+= idle.h
+header-test-y			+= init.h
+header-test-y			+= isolation.h
+header-test-y			+= jobctl.h
+header-test-y			+= loadavg.h
+header-test-y			+= mm.h
+header-test-y			+= nohz.h
+header-test-y			+= numa_balancing.h
+header-test-y			+= prio.h
+header-test-y			+= rt.h
+header-test-y			+= signal.h
+header-test-y			+= stat.h
+header-test-y			+= task.h
+header-test-y			+= task_stack.h
+header-test-y			+= topology.h
+header-test-y			+= user.h
+header-test-y			+= wake_q.h
+header-test-y			+= xacct.h
diff --git a/include/linux/spi/Kbuild b/include/linux/spi/Kbuild
new file mode 100644
index 000000000000..be0f37771169
--- /dev/null
+++ b/include/linux/spi/Kbuild
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= at73c213.h
+header-test-y			+= cc2520.h
+header-test-y			+= corgi_lcd.h
+header-test-y			+= eeprom.h
+header-test-y			+= flash.h
+header-test-y			+= ifx_modem.h
+header-test-y			+= l4f00242t03.h
+header-test-y			+= mc33880.h
+header-test-y			+= mmc_spi.h
+header-test-y			+= mxs-spi.h
+header-test-y			+= pxa2xx_spi.h
+header-test-y			+= sh_hspi.h
+header-test-y			+= spi-mem.h
+header-test-y			+= spi.h
+header-test-y			+= spi_oc_tiny.h
+header-test-y			+= tdo24m.h
diff --git a/include/linux/sunrpc/Kbuild b/include/linux/sunrpc/Kbuild
new file mode 100644
index 000000000000..0f38657e3ce8
--- /dev/null
+++ b/include/linux/sunrpc/Kbuild
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= addr.h
+header-test-y			+= auth.h
+header-test-y			+= auth_gss.h
+header-test-y			+= bc_xprt.h
+header-test-y			+= cache.h
+header-test-y			+= clnt.h
+header-test-y			+= debug.h
+header-test-y			+= gss_api.h
+header-test-y			+= gss_asn1.h
+header-test-y			+= gss_err.h
+header-test-y			+= gss_krb5_enctypes.h
+header-test-y			+= metrics.h
+header-test-y			+= rpc_rdma.h
+header-test-y			+= sched.h
+header-test-y			+= stats.h
+header-test-y			+= svc.h
+header-test-y			+= svc_rdma.h
+header-test-y			+= svc_xprt.h
+header-test-y			+= svcauth.h
+header-test-y			+= svcauth_gss.h
+header-test-y			+= svcsock.h
+header-test-y			+= timer.h
+header-test-y			+= types.h
+header-test-y			+= xdr.h
+header-test-y			+= xprt.h
+header-test-y			+= xprtrdma.h
diff --git a/include/linux/usb/Kbuild b/include/linux/usb/Kbuild
new file mode 100644
index 000000000000..9afb886fc4ca
--- /dev/null
+++ b/include/linux/usb/Kbuild
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= audio-v2.h
+header-test-y			+= audio-v3.h
+header-test-y			+= audio.h
+header-test-y			+= c67x00.h
+header-test-y			+= ccid.h
+header-test-y			+= cdc.h
+header-test-y			+= ch9.h
+header-test-y			+= chipidea.h
+header-test-y			+= composite.h
+header-test-y			+= ehci-dbgp.h
+header-test-y			+= ehci_def.h
+header-test-y			+= ehci_pdriver.h
+header-test-y			+= functionfs.h
+header-test-y			+= g_hid.h
+header-test-y			+= gadget.h
+header-test-y			+= input.h
+header-test-y			+= isp1301.h
+header-test-y			+= isp1760.h
+header-test-y			+= m66592.h
+header-test-y			+= musb-ux500.h
+header-test-y			+= of.h
+header-test-y			+= otg.h
+header-test-y			+= pd.h
+header-test-y			+= pd_bdo.h
+header-test-y			+= pd_ext_sdb.h
+header-test-y			+= pd_vdo.h
+header-test-y			+= phy.h
+header-test-y			+= phy_companion.h
+header-test-y			+= quirks.h
+header-test-y			+= renesas_usbhs.h
+header-test-y			+= role.h
+header-test-y			+= tcpm.h
+header-test-y			+= tegra_usb_phy.h
+header-test-y			+= typec.h
+header-test-y			+= typec_altmode.h
+header-test-y			+= typec_dp.h
+header-test-y			+= typec_mux.h
+header-test-y			+= ulpi.h
+header-test-y			+= usb_phy_generic.h
+header-test-y			+= wusb.h
diff --git a/include/math-emu/Kbuild b/include/math-emu/Kbuild
new file mode 100644
index 000000000000..1c5a0a72ea12
--- /dev/null
+++ b/include/math-emu/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= op-1.h
+header-test-y			+= op-2.h
+header-test-y			+= op-4.h
+header-test-y			+= op-8.h
diff --git a/include/media/Kbuild b/include/media/Kbuild
new file mode 100644
index 000000000000..4cde1d6ba656
--- /dev/null
+++ b/include/media/Kbuild
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= cec-notifier.h
+header-test-y			+= cec-pin.h
+header-test-y			+= cec.h
+header-test-y			+= davinci/ccdc_types.h
+header-test-y			+= davinci/vpbe.h
+header-test-y			+= davinci/vpbe_display.h
+header-test-y			+= davinci/vpbe_venc.h
+header-test-y			+= davinci/vpfe_capture.h
+header-test-y			+= davinci/vpfe_types.h
+header-test-y			+= davinci/vpss.h
+header-test-y			+= dmxdev.h
+header-test-y			+= drv-intf/cx2341x.h
+header-test-y			+= drv-intf/cx25840.h
+header-test-y			+= drv-intf/exynos-fimc.h
+header-test-y			+= drv-intf/msp3400.h
+header-test-y			+= drv-intf/renesas-ceu.h
+header-test-y			+= drv-intf/s3c_camif.h
+header-test-y			+= drv-intf/saa7146.h
+header-test-y			+= drv-intf/saa7146_vv.h
+header-test-y			+= drv-intf/sh_vou.h
+header-test-y			+= drv-intf/si476x.h
+header-test-y			+= drv-intf/tea575x.h
+header-test-y			+= dvb-usb-ids.h
+header-test-y			+= dvb_ca_en50221.h
+header-test-y			+= dvb_demux.h
+header-test-y			+= dvb_frontend.h
+header-test-y			+= dvb_math.h
+header-test-y			+= dvb_ringbuffer.h
+header-test-y			+= dvb_vb2.h
+header-test-y			+= dvbdev.h
+header-test-y			+= h264-ctrls.h
+header-test-y			+= i2c/adp1653.h
+header-test-y			+= i2c/adv7183.h
+header-test-y			+= i2c/adv7393.h
+header-test-y			+= i2c/adv7604.h
+header-test-y			+= i2c/ak881x.h
+header-test-y			+= i2c/bt819.h
+header-test-y			+= i2c/cs5345.h
+header-test-y			+= i2c/cs53l32a.h
+header-test-y			+= i2c/ir-kbd-i2c.h
+header-test-y			+= i2c/lm3560.h
+header-test-y			+= i2c/lm3646.h
+header-test-y			+= i2c/m52790.h
+header-test-y			+= i2c/mt9p031.h
+header-test-y			+= i2c/mt9t001.h
+header-test-y			+= i2c/mt9v011.h
+header-test-y			+= i2c/mt9v022.h
+header-test-y			+= i2c/noon010pc30.h
+header-test-y			+= i2c/ov772x.h
+header-test-y			+= i2c/ov9650.h
+header-test-y			+= i2c/s5c73m3.h
+header-test-y			+= i2c/s5k4ecgx.h
+header-test-y			+= i2c/s5k6aa.h
+header-test-y			+= i2c/saa7127.h
+header-test-y			+= i2c/smiapp.h
+header-test-y			+= i2c/tw9910.h
+header-test-y			+= i2c/uda1342.h
+header-test-y			+= i2c/upd64031a.h
+header-test-y			+= i2c/upd64083.h
+header-test-y			+= media-device.h
+header-test-y			+= media-devnode.h
+header-test-y			+= media-entity.h
+header-test-y			+= media-request.h
+header-test-y			+= rc-core.h
+header-test-y			+= soc_camera.h
+header-test-y			+= tpg/v4l2-tpg.h
+header-test-y			+= tuner.h
+header-test-y			+= v4l2-async.h
+header-test-y			+= v4l2-clk.h
+header-test-y			+= v4l2-common.h
+header-test-y			+= v4l2-ctrls.h
+header-test-y			+= v4l2-dev.h
+header-test-y			+= v4l2-device.h
+header-test-y			+= v4l2-dv-timings.h
+header-test-y			+= v4l2-event.h
+header-test-y			+= v4l2-fh.h
+header-test-y			+= v4l2-fwnode.h
+header-test-y			+= v4l2-image-sizes.h
+header-test-y			+= v4l2-ioctl.h
+header-test-y			+= v4l2-mc.h
+header-test-y			+= v4l2-mediabus.h
+header-test-y			+= v4l2-mem2mem.h
+header-test-y			+= v4l2-rect.h
+header-test-y			+= v4l2-subdev.h
+header-test-y			+= videobuf-core.h
+header-test-y			+= videobuf-dma-contig.h
+header-test-y			+= videobuf-dma-sg.h
+header-test-y			+= videobuf-vmalloc.h
+header-test-y			+= videobuf2-core.h
+header-test-y			+= videobuf2-dma-contig.h
+header-test-y			+= videobuf2-dma-sg.h
+header-test-y			+= videobuf2-dvb.h
+header-test-y			+= videobuf2-memops.h
+header-test-y			+= videobuf2-v4l2.h
+header-test-y			+= videobuf2-vmalloc.h
+header-test-y			+= vsp1.h
diff --git a/include/misc/Kbuild b/include/misc/Kbuild
new file mode 100644
index 000000000000..31d3de3f35ef
--- /dev/null
+++ b/include/misc/Kbuild
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= cxl.h
+header-test-y			+= ocxl-config.h
+header-test-y			+= ocxl.h
diff --git a/include/net/Kbuild b/include/net/Kbuild
new file mode 100644
index 000000000000..e4aedfe6b240
--- /dev/null
+++ b/include/net/Kbuild
@@ -0,0 +1,206 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= 6lowpan.h
+header-test-y			+= Space.h
+header-test-y			+= act_api.h
+header-test-y			+= addrconf.h
+header-test-y			+= af_ieee802154.h
+header-test-y			+= af_rxrpc.h
+header-test-y			+= af_unix.h
+header-test-y			+= ah.h
+header-test-y			+= arp.h
+header-test-y			+= atmclip.h
+header-test-y			+= ax25.h
+header-test-y			+= bluetooth/bluetooth.h
+header-test-y			+= bond_3ad.h
+header-test-y			+= bond_alb.h
+header-test-y			+= bonding.h
+header-test-y			+= bpf_sk_storage.h
+header-test-y			+= busy_poll.h
+header-test-y			+= caif/caif_dev.h
+header-test-y			+= caif/caif_device.h
+header-test-y			+= caif/caif_hsi.h
+header-test-y			+= caif/caif_layer.h
+header-test-y			+= caif/caif_spi.h
+header-test-y			+= caif/cfcnfg.h
+header-test-y			+= caif/cfctrl.h
+header-test-y			+= caif/cffrml.h
+header-test-y			+= caif/cfmuxl.h
+header-test-y			+= caif/cfpkt.h
+header-test-y			+= caif/cfserl.h
+header-test-y			+= calipso.h
+header-test-y			+= cfg80211-wext.h
+header-test-y			+= cfg80211.h
+header-test-y			+= cfg802154.h
+header-test-y			+= checksum.h
+header-test-y			+= cipso_ipv4.h
+header-test-y			+= cls_cgroup.h
+header-test-y			+= codel.h
+header-test-y			+= devlink.h
+header-test-y			+= dn.h
+header-test-y			+= dsa.h
+header-test-y			+= dsfield.h
+header-test-y			+= dst.h
+header-test-y			+= dst_cache.h
+header-test-y			+= dst_metadata.h
+header-test-y			+= dst_ops.h
+header-test-y			+= failover.h
+header-test-y			+= fib_notifier.h
+header-test-y			+= fib_rules.h
+header-test-y			+= flow.h
+header-test-y			+= flow_dissector.h
+header-test-y			+= fou.h
+header-test-y			+= gen_stats.h
+header-test-y			+= genetlink.h
+header-test-y			+= geneve.h
+header-test-y			+= gre.h
+header-test-y			+= gro_cells.h
+header-test-y			+= icmp.h
+header-test-y			+= ieee80211_radiotap.h
+header-test-y			+= ieee802154_netdev.h
+header-test-y			+= if_inet6.h
+header-test-y			+= ife.h
+header-test-y			+= inet6_hashtables.h
+header-test-y			+= inet_connection_sock.h
+header-test-y			+= inet_ecn.h
+header-test-y			+= inet_hashtables.h
+header-test-y			+= inet_sock.h
+header-test-y			+= inet_timewait_sock.h
+header-test-y			+= inetpeer.h
+header-test-y			+= ip.h
+header-test-y			+= ip6_checksum.h
+header-test-y			+= ip6_fib.h
+header-test-y			+= ip6_tunnel.h
+header-test-y			+= ip_fib.h
+header-test-y			+= ip_tunnels.h
+header-test-y			+= ipv6.h
+header-test-y			+= ipv6_frag.h
+header-test-y			+= ipv6_stubs.h
+header-test-y			+= ipx.h
+header-test-y			+= iw_handler.h
+header-test-y			+= kcm.h
+header-test-y			+= l3mdev.h
+header-test-y			+= lag.h
+header-test-y			+= lib80211.h
+header-test-y			+= llc.h
+header-test-y			+= llc_c_ev.h
+header-test-y			+= llc_conn.h
+header-test-y			+= llc_if.h
+header-test-y			+= llc_pdu.h
+header-test-y			+= llc_sap.h
+header-test-y			+= lwtunnel.h
+header-test-y			+= mac80211.h
+header-test-y			+= mac802154.h
+header-test-y			+= mip6.h
+header-test-y			+= mld.h
+header-test-y			+= mpls.h
+header-test-y			+= ndisc.h
+header-test-y			+= neighbour.h
+header-test-y			+= net_failover.h
+header-test-y			+= net_namespace.h
+header-test-y			+= net_ratelimit.h
+header-test-y			+= netfilter/ipv4/nf_conntrack_ipv4.h
+header-test-y			+= netfilter/ipv4/nf_defrag_ipv4.h
+header-test-y			+= netfilter/ipv4/nf_reject.h
+header-test-y			+= netfilter/ipv6/nf_conntrack_icmpv6.h
+header-test-y			+= netfilter/ipv6/nf_conntrack_ipv6.h
+header-test-y			+= netfilter/ipv6/nf_reject.h
+header-test-y			+= netfilter/nf_conntrack_zones.h
+header-test-y			+= netfilter/nf_log.h
+header-test-y			+= netfilter/nf_socket.h
+header-test-$(CONFIG_NF_TABLES)	+= netfilter/nf_tables.h
+header-test-$(CONFIG_NF_TABLES)	+= netfilter/nf_tables_core.h
+header-test-$(CONFIG_NF_TABLES)	+= netfilter/nf_tables_ipv4.h
+header-test-$(CONFIG_NF_TABLES)	+= netfilter/nf_tables_offload.h
+header-test-y			+= netfilter/nf_tproxy.h
+header-test-y			+= netfilter/xt_rateest.h
+header-test-y			+= netlabel.h
+header-test-y			+= netlink.h
+header-test-y			+= netns/conntrack.h
+header-test-y			+= netns/core.h
+header-test-y			+= netns/dccp.h
+header-test-y			+= netns/hash.h
+header-test-y			+= netns/mib.h
+header-test-y			+= netns/netfilter.h
+header-test-y			+= netns/nexthop.h
+header-test-y			+= netns/packet.h
+header-test-y			+= netns/unix.h
+header-test-y			+= netns/x_tables.h
+header-test-y			+= netns/xdp.h
+header-test-y			+= netns/xfrm.h
+header-test-y			+= netprio_cgroup.h
+header-test-y			+= nexthop.h
+header-test-y			+= nfc/digital.h
+header-test-y			+= nfc/hci.h
+header-test-y			+= nfc/llc.h
+header-test-y			+= nfc/nci.h
+header-test-y			+= nfc/nci_core.h
+header-test-y			+= nfc/nfc.h
+header-test-y			+= nl802154.h
+header-test-y			+= nsh.h
+header-test-y			+= page_pool.h
+header-test-y			+= phonet/gprs.h
+header-test-y			+= ping.h
+header-test-y			+= pkt_cls.h
+header-test-y			+= pkt_sched.h
+header-test-y			+= protocol.h
+header-test-y			+= raw.h
+header-test-y			+= rawv6.h
+header-test-y			+= red.h
+header-test-y			+= request_sock.h
+header-test-y			+= route.h
+header-test-y			+= rsi_91x.h
+header-test-y			+= rtnetlink.h
+header-test-y			+= rtnh.h
+header-test-y			+= sch_generic.h
+header-test-y			+= scm.h
+header-test-y			+= sctp/checksum.h
+header-test-y			+= sctp/command.h
+header-test-y			+= sctp/constants.h
+header-test-y			+= sctp/sctp.h
+header-test-y			+= sctp/sm.h
+header-test-y			+= sctp/structs.h
+header-test-y			+= seg6.h
+header-test-y			+= seg6_hmac.h
+header-test-y			+= seg6_local.h
+header-test-y			+= slhc_vj.h
+header-test-y			+= snmp.h
+header-test-y			+= sock.h
+header-test-y			+= sock_reuseport.h
+header-test-y			+= strparser.h
+header-test-y			+= switchdev.h
+header-test-y			+= tc_act/tc_bpf.h
+header-test-y			+= tc_act/tc_connmark.h
+header-test-y			+= tc_act/tc_csum.h
+header-test-y			+= tc_act/tc_ct.h
+header-test-y			+= tc_act/tc_ctinfo.h
+header-test-y			+= tc_act/tc_defact.h
+header-test-y			+= tc_act/tc_gact.h
+header-test-y			+= tc_act/tc_ife.h
+header-test-y			+= tc_act/tc_ipt.h
+header-test-y			+= tc_act/tc_mirred.h
+header-test-y			+= tc_act/tc_mpls.h
+header-test-y			+= tc_act/tc_nat.h
+header-test-y			+= tc_act/tc_pedit.h
+header-test-y			+= tc_act/tc_police.h
+header-test-y			+= tc_act/tc_sample.h
+header-test-y			+= tc_act/tc_skbedit.h
+header-test-y			+= tc_act/tc_skbmod.h
+header-test-y			+= tc_act/tc_tunnel_key.h
+header-test-y			+= tc_act/tc_vlan.h
+header-test-y			+= tcp.h
+header-test-y			+= tcp_states.h
+header-test-y			+= timewait_sock.h
+header-test-y			+= tipc.h
+header-test-y			+= tls.h
+header-test-y			+= tso.h
+header-test-y			+= udp.h
+header-test-y			+= udp_tunnel.h
+header-test-y			+= vsock_addr.h
+header-test-y			+= vxlan.h
+header-test-y			+= wext.h
+header-test-y			+= wimax.h
+header-test-y			+= x25.h
+header-test-y			+= x25device.h
+header-test-y			+= xdp_sock.h
+header-test-y			+= xfrm.h
diff --git a/include/pcmcia/Kbuild b/include/pcmcia/Kbuild
new file mode 100644
index 000000000000..8d0690c0752f
--- /dev/null
+++ b/include/pcmcia/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ciscode.h
+header-test-y			+= cisreg.h
+header-test-y			+= device_id.h
+header-test-y			+= ss.h
diff --git a/include/ras/Kbuild b/include/ras/Kbuild
new file mode 100644
index 000000000000..2e731fae0189
--- /dev/null
+++ b/include/ras/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ras_event.h
diff --git a/include/rdma/Kbuild b/include/rdma/Kbuild
new file mode 100644
index 000000000000..fd1ea98d93de
--- /dev/null
+++ b/include/rdma/Kbuild
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ib_addr.h
+header-test-y			+= ib_cache.h
+header-test-y			+= ib_cm.h
+header-test-y			+= ib_fmr_pool.h
+header-test-y			+= ib_hdrs.h
+header-test-y			+= ib_mad.h
+header-test-y			+= ib_marshall.h
+header-test-y			+= ib_pack.h
+header-test-y			+= ib_pma.h
+header-test-y			+= ib_sa.h
+header-test-y			+= ib_smi.h
+header-test-y			+= ib_umem.h
+header-test-y			+= ib_umem_odp.h
+header-test-y			+= ib_verbs.h
+header-test-y			+= iw_cm.h
+header-test-y			+= mr_pool.h
+header-test-y			+= opa_addr.h
+header-test-y			+= opa_smi.h
+header-test-y			+= opa_vnic.h
+header-test-y			+= rdma_cm.h
+header-test-y			+= rdma_cm_ib.h
+header-test-y			+= rdma_counter.h
+header-test-y			+= rdma_netlink.h
+header-test-y			+= rdma_vt.h
+header-test-y			+= rdmavt_mr.h
+header-test-y			+= rdmavt_qp.h
+header-test-y			+= rw.h
+header-test-y			+= uverbs_ioctl.h
+header-test-y			+= uverbs_std_types.h
+header-test-y			+= uverbs_types.h
diff --git a/include/scsi/Kbuild b/include/scsi/Kbuild
new file mode 100644
index 000000000000..606d83e81e6f
--- /dev/null
+++ b/include/scsi/Kbuild
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= fc/fc_fcp.h
+header-test-y			+= fc/fc_ms.h
+header-test-y			+= fcoe_sysfs.h
+header-test-y			+= iscsi_if.h
+header-test-y			+= iscsi_proto.h
+header-test-y			+= libiscsi.h
+header-test-y			+= libiscsi_tcp.h
+header-test-y			+= sas.h
+header-test-y			+= scsi.h
+header-test-y			+= scsi_bsg_iscsi.h
+header-test-y			+= scsi_common.h
+header-test-y			+= scsi_devinfo.h
+header-test-y			+= scsi_driver.h
+header-test-y			+= scsi_proto.h
+header-test-y			+= scsi_transport_iscsi.h
+header-test-y			+= srp.h
+header-test-y			+= viosrp.h
diff --git a/include/soc/Kbuild b/include/soc/Kbuild
new file mode 100644
index 000000000000..290321ea7ce7
--- /dev/null
+++ b/include/soc/Kbuild
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= at91/at91sam9_ddrsdr.h
+header-test-y			+= at91/at91sam9_sdramc.h
+header-test-y			+= at91/atmel-secumod.h
+header-test-y			+= at91/atmel-sfr.h
+header-test-y			+= at91/atmel_tcb.h
+header-test-y			+= bcm2835/raspberrypi-firmware.h
+header-test-y			+= fsl/dpaa2-fd.h
+header-test-y			+= fsl/dpaa2-global.h
+header-test-y			+= fsl/dpaa2-io.h
+header-test-y			+= fsl/qe/immap_qe.h
+header-test-y			+= imx/cpuidle.h
+header-test-y			+= imx/revision.h
+header-test-y			+= imx/timer.h
+header-test-y			+= mediatek/smi.h
+header-test-y			+= mscc/ocelot_hsio.h
+header-test-$(CONFIG_ARC)	+= nps/mtm.h
+header-test-y			+= rockchip/rk3399_grf.h
+header-test-y			+= rockchip/rockchip_sip.h
+header-test-y			+= sa1100/pwer.h
+header-test-y			+= tegra/bpmp.h
+header-test-y			+= tegra/cpuidle.h
+header-test-y			+= tegra/emc.h
+header-test-y			+= tegra/pm.h
+header-test-y			+= tegra/pmc.h
diff --git a/include/sound/Kbuild b/include/sound/Kbuild
new file mode 100644
index 000000000000..aa0dae306381
--- /dev/null
+++ b/include/sound/Kbuild
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= ac97/codec.h
+header-test-y			+= ac97/controller.h
+header-test-y			+= ac97/regs.h
+header-test-y			+= ac97_codec.h
+header-test-y			+= ad1816a.h
+header-test-y			+= aess.h
+header-test-y			+= ak4531_codec.h
+header-test-y			+= ak4641.h
+header-test-y			+= ak4xxx-adda.h
+header-test-y			+= alc5623.h
+header-test-y			+= asequencer.h
+header-test-y			+= asound.h
+header-test-y			+= asoundef.h
+header-test-y			+= compress_driver.h
+header-test-y			+= control.h
+header-test-y			+= core.h
+header-test-y			+= cs4231-regs.h
+header-test-y			+= cs42l56.h
+header-test-y			+= cs42l73.h
+header-test-y			+= cs8403.h
+header-test-y			+= da7213.h
+header-test-y			+= designware_i2s.h
+header-test-y			+= dmaengine_pcm.h
+header-test-y			+= emu10k1.h
+header-test-y			+= emu10k1_synth.h
+header-test-y			+= emu8000_reg.h
+header-test-y			+= emux_legacy.h
+header-test-y			+= es1688.h
+header-test-y			+= gus.h
+header-test-y			+= hda_chmap.h
+header-test-y			+= hda_codec.h
+header-test-y			+= hda_register.h
+header-test-y			+= hda_regmap.h
+header-test-y			+= hda_verbs.h
+header-test-y			+= hdaudio.h
+header-test-y			+= hdaudio_ext.h
+header-test-y			+= hdmi-codec.h
+header-test-y			+= info.h
+header-test-y			+= initval.h
+header-test-y			+= jack.h
+header-test-y			+= madera-pdata.h
+header-test-y			+= max9768.h
+header-test-y			+= max98090.h
+header-test-y			+= memalloc.h
+header-test-y			+= minors.h
+header-test-y			+= mpu401.h
+header-test-y			+= opl3.h
+header-test-y			+= opl4.h
+header-test-y			+= pcm-indirect.h
+header-test-y			+= pcm.h
+header-test-y			+= pcm_params.h
+header-test-y			+= pt2258.h
+header-test-y			+= rawmidi.h
+header-test-y			+= rt5514.h
+header-test-y			+= rt5663.h
+header-test-y			+= rt5668.h
+header-test-y			+= rt5682.h
+header-test-y			+= sb.h
+header-test-y			+= sb16_csp.h
+header-test-y			+= seq_midi_event.h
+header-test-y			+= seq_oss_legacy.h
+header-test-y			+= seq_virmidi.h
+header-test-y			+= sh_dac_audio.h
+header-test-y			+= sh_fsi.h
+header-test-y			+= simple_card.h
+header-test-y			+= simple_card_utils.h
+header-test-y			+= snd_wavefront.h
+header-test-y			+= soc-acpi.h
+header-test-y			+= soc-topology.h
+header-test-y			+= soc.h
+header-test-y			+= sof.h
+header-test-y			+= soundfont.h
+header-test-y			+= spear_dma.h
+header-test-y			+= tas2552-plat.h
+header-test-y			+= tas5086.h
+header-test-y			+= timer.h
+header-test-y			+= tlv.h
+header-test-y			+= tlv320aic3x.h
+header-test-y			+= tpa6130a2-plat.h
+header-test-y			+= uda1380.h
+header-test-y			+= util_mem.h
+header-test-y			+= vx_core.h
+header-test-y			+= wm0010.h
+header-test-y			+= wm1250-ev1.h
+header-test-y			+= wm2000.h
+header-test-y			+= wm2200.h
+header-test-y			+= wm5100.h
+header-test-y			+= wm8955.h
+header-test-y			+= wss.h
diff --git a/include/target/Kbuild b/include/target/Kbuild
new file mode 100644
index 000000000000..c647925ea497
--- /dev/null
+++ b/include/target/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= iscsi/iscsi_target_core.h
+header-test-y			+= target_core_backend.h
+header-test-y			+= target_core_base.h
+header-test-y			+= target_core_fabric.h
diff --git a/include/trace/Kbuild b/include/trace/Kbuild
new file mode 100644
index 000000000000..6e2fb07bd73e
--- /dev/null
+++ b/include/trace/Kbuild
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= define_trace.h
+header-test-y			+= events/alarmtimer.h
+header-test-y			+= events/bpf_test_run.h
+header-test-y			+= events/bridge.h
+header-test-y			+= events/btrfs.h
+header-test-y			+= events/compaction.h
+header-test-y			+= events/context_tracking.h
+header-test-y			+= events/cpuhp.h
+header-test-y			+= events/devfreq.h
+header-test-y			+= events/devlink.h
+header-test-y			+= events/fib.h
+header-test-y			+= events/fib6.h
+header-test-y			+= events/filelock.h
+header-test-y			+= events/filemap.h
+header-test-y			+= events/gpio.h
+header-test-y			+= events/host1x.h
+header-test-y			+= events/hswadsp.h
+header-test-y			+= events/hwmon.h
+header-test-y			+= events/i2c.h
+header-test-y			+= events/initcall.h
+header-test-y			+= events/intel-sst.h
+header-test-y			+= events/intel_ish.h
+header-test-y			+= events/iommu.h
+header-test-y			+= events/ipi.h
+header-test-y			+= events/irq.h
+header-test-y			+= events/irq_matrix.h
+header-test-y			+= events/kmem.h
+header-test-y			+= events/lock.h
+header-test-y			+= events/mlxsw.h
+header-test-y			+= events/mmc.h
+header-test-y			+= events/module.h
+header-test-y			+= events/neigh.h
+header-test-y			+= events/net.h
+header-test-y			+= events/net_probe_common.h
+header-test-y			+= events/nmi.h
+header-test-y			+= events/objagg.h
+header-test-y			+= events/oom.h
+header-test-y			+= events/page_isolation.h
+header-test-y			+= events/page_pool.h
+header-test-y			+= events/page_ref.h
+header-test-y			+= events/pagemap.h
+header-test-y			+= events/percpu.h
+header-test-y			+= events/power.h
+header-test-y			+= events/power_cpu_migrate.h
+header-test-y			+= events/preemptirq.h
+header-test-y			+= events/printk.h
+header-test-y			+= events/random.h
+header-test-y			+= events/rcu.h
+header-test-y			+= events/regulator.h
+header-test-y			+= events/rpm.h
+header-test-y			+= events/rseq.h
+header-test-y			+= events/rtc.h
+header-test-y			+= events/sched.h
+header-test-y			+= events/sctp.h
+header-test-y			+= events/signal.h
+header-test-y			+= events/skb.h
+header-test-y			+= events/smbus.h
+header-test-y			+= events/sock.h
+header-test-y			+= events/spmi.h
+header-test-y			+= events/sunrpc.h
+header-test-y			+= events/sunvnet.h
+header-test-y			+= events/task.h
+header-test-y			+= events/tcp.h
+header-test-y			+= events/thermal.h
+header-test-y			+= events/thp.h
+header-test-y			+= events/tlb.h
+header-test-y			+= events/udp.h
+header-test-y			+= events/ufs.h
+header-test-y			+= events/v4l2.h
+header-test-y			+= events/vb2.h
+header-test-y			+= events/vmscan.h
+header-test-y			+= events/vsock_virtio_transport_common.h
+header-test-y			+= events/workqueue.h
+header-test-y			+= events/writeback.h
+header-test-y			+= events/xdp.h
+header-test-y			+= syscall.h
diff --git a/include/vdso/Kbuild b/include/vdso/Kbuild
new file mode 100644
index 000000000000..579ba8e4ecc4
--- /dev/null
+++ b/include/vdso/Kbuild
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= datapage.h
+header-test-y			+= helpers.h
diff --git a/include/video/Kbuild b/include/video/Kbuild
new file mode 100644
index 000000000000..b4ba2e7fe9fd
--- /dev/null
+++ b/include/video/Kbuild
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= atmel_lcdc.h
+header-test-y			+= aty128.h
+header-test-y			+= cirrus.h
+header-test-y			+= da8xx-fb.h
+header-test-y			+= display_timing.h
+header-test-y			+= edid.h
+header-test-y			+= hecubafb.h
+header-test-y			+= imx-ipu-image-convert.h
+header-test-y			+= imx-ipu-v3.h
+header-test-y			+= mach64.h
+header-test-y			+= mbxfb.h
+header-test-y			+= mipi_display.h
+header-test-y			+= mmp_disp.h
+header-test-y			+= newport.h
+header-test-y			+= of_videomode.h
+header-test-y			+= omap-panel-data.h
+header-test-y			+= omapfb_dss.h
+header-test-y			+= permedia2.h
+header-test-y			+= pm3fb.h
+header-test-y			+= pmag-ba-fb.h
+header-test-y			+= pmagb-b-fb.h
+header-test-y			+= pxa168fb.h
+header-test-y			+= radeon.h
+header-test-y			+= sa1100fb.h
+header-test-y			+= samsung_fimd.h
+header-test-y			+= sh_mobile_lcdc.h
+header-test-y			+= sisfb.h
+header-test-y			+= tdfx.h
+header-test-y			+= trident.h
+header-test-y			+= videomode.h
diff --git a/include/xen/Kbuild b/include/xen/Kbuild
new file mode 100644
index 000000000000..cbd92f132d97
--- /dev/null
+++ b/include/xen/Kbuild
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+header-test-y			+= arm/hypervisor.h
+header-test-y			+= arm/interface.h
+header-test-y			+= hvc-console.h
+header-test-y			+= interface/elfnote.h
+header-test-y			+= interface/features.h
+header-test-y			+= interface/io/xenbus.h
+header-test-y			+= xenbus_dev.h
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5241d0751eb0..564174f46ca4 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -68,16 +68,6 @@ endif
 
 # Test self-contained headers
 
-# Wildcard searches in $(srctree)/$(src)/, but not in $(objtree)/$(obj)/.
-# Stale generated headers are often left over, so pattern matching should
-# be avoided. Please notice $(srctree)/$(src)/ and $(objtree)/$(obj) point
-# to the same location for in-tree building. So, header-test-pattern-y should
-# be used with care.
-header-test-y	+= $(filter-out $(header-test-), \
-		$(patsubst $(srctree)/$(src)/%, %, \
-		$(wildcard $(addprefix $(srctree)/$(src)/, \
-		$(header-test-pattern-y)))))
-
 extra-$(CONFIG_HEADER_TEST) += $(addsuffix .s, $(header-test-y) $(header-test-m))
 
 # Add subdir path
-- 
2.17.1

