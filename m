Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD26EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FDF20811
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfCPDi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:38:56 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40632 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCPDiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:38:55 -0400
Received: by mail-vk1-f195.google.com with SMTP id l17so2668189vke.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 20:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKY4SfoN1o2abmLOALnMoPhrtC0qkrLCkyRwPEN99yo=;
        b=ZU0BuY8hPlty8Iu5Xu99OrHIUmRUeCYcy1lgHveCgN/ehQgLN1Asxzz6wqEtnjx2ng
         2ndElJ11qxeQkygpB/w9y06hZxcaZ4Z/IaWDQ4gkJyOvjWMxwxN02XBqlUd4ga6fJes4
         VkTQSRKmpw3sB3JUf58b2XcEpeIGvcDCfJhIcxBJd/xaOj7O7G7kCLKXijBEvTkNI8Eh
         Cn9rj1QcsoGPye1p6ChHiVc6c2jCjm0JHX5VScjtiAlplHNUMZWGOoWg0UalMhxFqbKy
         F3SOsoDhTw6rKYmG10sREAWlrNqWPJMqLtZ75jx1rO7qLONuB5YuTP3dXmVGCpYfx0Im
         yz5Q==
X-Gm-Message-State: APjAAAVetLH3jdCeHL+KUo2W1sWio5iO46O5PdjnmU6Xgrce+Jlug+qd
        7HumwuoTY+zEc6tze7jjMynOleAtbmSPNw==
X-Google-Smtp-Source: APXvYqwrGwiWYx9g6VIOxnEUifMu2x+ed8ixJQSsjR8ILC9s+1Vd2D6FCFNXruCdNX0m8qiosv1i8Q==
X-Received: by 2002:a1f:d007:: with SMTP id h7mr3719848vkg.35.1552707527291;
        Fri, 15 Mar 2019 20:38:47 -0700 (PDT)
Received: from localhost.localdomain ([190.219.163.13])
        by smtp.gmail.com with ESMTPSA id r72sm1161852vsc.26.2019.03.15.20.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 20:38:46 -0700 (PDT)
From:   Shawn Landden <shawn@git.icu>
To:     linux-kernel@vger.kernel.org
Cc:     "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Shawn Landden <shawn@git.icu>
Subject: [PATCH] Use fall-through attribute rather than magic comments
Date:   Fri, 15 Mar 2019 21:38:41 -0600
Message-Id: <20190316033841.7659-1-shawn@git.icu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -Wimplicit-fallthrough warning recognizes magic comments
https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
It is my opinion that magic comments are a bad idea. Comments should not
change the interpretation (even regarding errors) of C code.
(It also happens to break distcc as distcc compiles pre-processed .i files.)

I am aware this can cause some merge pain.

Also, if my style is OK, then needs some changes to checkpatch.pl. (CCed)

Signed-off-by: Shawn Landden <shawn@git.icu>
---
 arch/alpha/kernel/signal.c                    |  2 +-
 arch/arc/kernel/signal.c                      |  2 +-
 arch/arm/mach-omap2/id.c                      | 24 ++----
 arch/arm/mm/proc-v7-bugs.c                    |  2 +-
 arch/c6x/kernel/signal.c                      |  4 +-
 arch/h8300/kernel/signal.c                    |  2 +-
 arch/hexagon/kernel/module.c                  |  2 +-
 arch/m68k/kernel/signal.c                     |  2 +-
 arch/microblaze/kernel/signal.c               |  4 +-
 arch/mips/alchemy/devboards/db1550.c          |  2 +-
 arch/mips/kernel/signal.c                     |  2 +-
 arch/parisc/kernel/signal.c                   |  2 +-
 arch/riscv/kernel/signal.c                    |  2 +-
 arch/s390/kernel/signal.c                     |  4 +-
 arch/s390/kernel/topology.c                   |  2 +-
 arch/s390/kvm/gaccess.c                       | 15 ++--
 arch/s390/mm/fault.c                          |  6 +-
 arch/s390/mm/pgalloc.c                        |  2 +-
 arch/sh/kernel/signal_32.c                    |  2 +-
 arch/sh/kernel/signal_64.c                    |  2 +-
 arch/sparc/include/asm/pgtable_64.h           |  4 +-
 arch/sparc/kernel/pcr.c                       |  2 +-
 arch/sparc/kernel/signal32.c                  |  2 +-
 arch/sparc/kernel/signal_32.c                 |  2 +-
 arch/sparc/kernel/signal_64.c                 |  2 +-
 arch/um/kernel/signal.c                       |  2 +-
 arch/unicore32/kernel/signal.c                |  2 +-
 arch/x86/kernel/cpu/mce/intel.c               |  2 +-
 arch/x86/kernel/signal.c                      |  2 +-
 arch/x86/kvm/vmx/vmx.c                        |  2 +-
 arch/xtensa/kernel/signal.c                   |  2 +-
 block/blk-wbt.c                               |  2 +-
 drivers/acpi/acpica/utprint.c                 |  2 +-
 drivers/ata/sata_promise.c                    |  8 +-
 drivers/ata/sata_sx4.c                        |  2 +-
 drivers/atm/lanai.c                           |  2 +-
 drivers/base/firmware_loader/fallback.c       |  4 +-
 drivers/char/agp/ali-agp.c                    |  2 +-
 drivers/clk/davinci/pll.c                     |  2 +-
 drivers/crypto/ccree/cc_cipher.c              |  2 +-
 drivers/gpu/drm/ast/ast_main.c                |  2 +-
 drivers/gpu/drm/drm_bufs.c                    |  2 +-
 drivers/gpu/drm/i915/icl_dsi.c                |  6 +-
 drivers/gpu/drm/i915/intel_bios.c             |  4 +-
 drivers/gpu/drm/i915/intel_ddi.c              |  2 +-
 drivers/gpu/drm/i915/intel_psr.c              |  2 +-
 drivers/gpu/drm/meson/meson_crtc.c            |  4 +-
 drivers/gpu/drm/meson/meson_overlay.c         |  4 +-
 drivers/gpu/drm/tegra/dc.c                    |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c          |  2 +-
 drivers/hid/hid-wiimote-core.c                |  4 +-
 drivers/hv/hv_kvp.c                           |  2 +-
 drivers/hv/vmbus_drv.c                        |  2 +-
 drivers/i2c/busses/i2c-omap.c                 |  2 +-
 drivers/i2c/busses/scx200_acb.c               |  2 +-
 drivers/i2c/i2c-slave-eeprom.c                |  2 +-
 drivers/iio/adc/cpcap-adc.c                   |  2 +-
 drivers/iio/light/si1145.c                    |  2 +-
 drivers/infiniband/hw/cxgb3/iwch_cm.c         |  2 +-
 drivers/infiniband/hw/cxgb4/cm.c              |  2 +-
 drivers/infiniband/hw/cxgb4/qp.c              |  2 +-
 drivers/infiniband/hw/hfi1/mad.c              |  8 +-
 drivers/infiniband/hw/hfi1/platform.c         | 10 +--
 drivers/infiniband/hw/hfi1/rc.c               | 18 ++---
 drivers/infiniband/hw/hfi1/sdma.c             |  2 +-
 drivers/infiniband/hw/hfi1/uc.c               |  8 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c      |  6 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c      | 24 +++---
 drivers/infiniband/hw/i40iw/i40iw_puda.c      |  2 +-
 drivers/infiniband/hw/qib/qib_mad.c           | 10 +--
 drivers/infiniband/hw/qib/qib_rc.c            | 16 ++--
 drivers/infiniband/hw/qib/qib_uc.c            |  8 +-
 drivers/infiniband/hw/qib/qib_verbs.c         |  2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c      |  2 +-
 drivers/input/mouse/navpoint.c                |  2 +-
 drivers/input/touchscreen/edt-ft5x06.c        | 14 ++--
 drivers/md/bcache/journal.c                   |  2 +-
 drivers/media/dvb-core/dvb_net.c              |  2 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c   | 75 +++++++++++--------
 drivers/media/dvb-frontends/drxk_hard.c       |  6 +-
 drivers/media/dvb-frontends/lgdt3306a.c       |  2 +-
 drivers/media/pci/cx88/cx88-cards.c           |  2 +-
 drivers/media/pci/ddbridge/ddbridge-core.c    | 15 ++--
 drivers/media/platform/coda/coda-bit.c        |  4 +-
 drivers/media/platform/coda/coda-common.c     |  6 +-
 drivers/media/tuners/fc0011.c                 |  2 +-
 drivers/memstick/core/ms_block.c              | 12 +--
 drivers/mfd/rave-sp.c                         |  4 +-
 drivers/mmc/host/davinci_mmc.c                |  2 +-
 drivers/mmc/host/dw_mmc-k3.c                  |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
 drivers/mmc/host/sdhci.c                      |  2 +-
 drivers/mtd/spi-nor/aspeed-smc.c              |  2 +-
 drivers/net/bonding/bond_3ad.c                |  2 +-
 drivers/net/can/at91_can.c                    |  4 +-
 drivers/net/can/sja1000/sja1000_platform.c    |  2 +-
 drivers/net/can/slcan.c                       |  4 +-
 drivers/net/can/spi/mcp251x.c                 |  2 +-
 drivers/net/dsa/b53/b53_common.c              |  2 +-
 drivers/net/dsa/b53/b53_serdes.c              |  2 +-
 drivers/net/dsa/bcm_sf2.c                     |  2 +-
 drivers/net/ethernet/alacritech/slicoss.c     | 12 +--
 drivers/net/ethernet/broadcom/bgmac-bcma.c    |  2 +-
 drivers/net/ethernet/broadcom/tg3.c           | 10 +--
 .../net/ethernet/cavium/liquidio/lio_main.c   | 28 +++----
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 24 +++---
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  2 +-
 .../net/ethernet/freescale/fman/fman_memac.c  |  2 +-
 drivers/net/ethernet/freescale/ucc_geth.c     |  2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 +-
 .../ethernet/netronome/nfp/flower/action.c    |  2 +-
 .../netronome/nfp/nfpcore/nfp6000_pcie.c      |  4 +-
 drivers/net/ethernet/sfc/ef10.c               |  2 +-
 drivers/net/ethernet/ti/cpsw-phy-sel.c        |  4 +-
 drivers/net/ethernet/toshiba/spider_net.c     | 26 +++----
 drivers/net/phy/sfp-bus.c                     |  2 +-
 drivers/net/phy/sfp.c                         |  2 +-
 drivers/net/usb/lan78xx.c                     |  6 +-
 drivers/net/usb/usbnet.c                      |  2 +-
 drivers/net/wimax/i2400m/usb.c                |  2 +-
 drivers/net/wireless/ath/ath5k/reset.c        |  2 +-
 drivers/net/wireless/broadcom/b43/dma.c       |  2 +-
 drivers/net/wireless/broadcom/b43/main.c      |  6 +-
 drivers/net/wireless/broadcom/b43/pio.c       |  2 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c |  2 +-
 .../net/wireless/broadcom/b43legacy/main.c    |  4 +-
 .../net/wireless/ralink/rt2x00/rt2800lib.c    |  8 +-
 .../net/wireless/ralink/rt2x00/rt2800mmio.c   |  2 +-
 .../net/wireless/ralink/rt2x00/rt2800usb.c    |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c  |  2 +-
 drivers/net/wireless/ralink/rt2x00/rt73usb.c  |  2 +-
 drivers/nfc/trf7970a.c                        |  4 +-
 drivers/nvme/host/tcp.c                       |  2 +-
 drivers/nvme/target/rdma.c                    |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c      |  2 +-
 drivers/platform/x86/thinkpad_acpi.c          |  4 +-
 drivers/reset/reset-imx7.c                    | 14 ++--
 drivers/rpmsg/qcom_glink_native.c             |  4 +-
 drivers/rtc/rtc-ds1374.c                      |  2 +-
 drivers/s390/crypto/ap_queue.c                |  2 +-
 drivers/s390/net/qeth_core_main.c             |  2 +-
 drivers/s390/net/qeth_l2_main.c               |  2 +-
 drivers/scsi/aic7xxx/aic79xx_core.c           | 24 +++---
 drivers/scsi/aic7xxx/aic7xxx_core.c           | 18 ++---
 drivers/scsi/aic94xx/aic94xx_tmf.c            |  2 +-
 drivers/scsi/arm/fas216.c                     |  2 +-
 drivers/scsi/libsas/sas_expander.c            |  2 +-
 drivers/scsi/libsas/sas_scsi_host.c           |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c                  |  6 +-
 drivers/scsi/scsi_error.c                     | 22 +++---
 drivers/scsi/scsi_ioctl.c                     |  2 +-
 drivers/scsi/ufs/ufshcd.c                     |  6 +-
 drivers/spi/spi-bcm2835aux.c                  |  6 +-
 drivers/ssb/driver_mipscore.c                 |  2 +-
 drivers/staging/erofs/unzip_vle.c             |  6 +-
 drivers/staging/vt6655/channel.c              |  9 +--
 drivers/staging/vt6656/channel.c              |  7 +-
 drivers/tty/n_r3964.c                         |  2 +-
 drivers/tty/serial/8250/8250_pci.c            |  2 +-
 drivers/tty/serial/omap-serial.c              |  4 +-
 drivers/tty/vt/vt.c                           |  2 +-
 drivers/usb/c67x00/c67x00-sched.c             |  3 +-
 drivers/usb/core/config.c                     |  2 +-
 drivers/usb/core/hcd.c                        |  6 +-
 drivers/usb/core/urb.c                        |  2 +-
 drivers/usb/dwc3/core.c                       |  4 +-
 drivers/usb/gadget/composite.c                |  8 +-
 drivers/usb/gadget/function/f_hid.c           |  2 +-
 drivers/usb/gadget/function/f_loopback.c      |  2 +-
 drivers/usb/gadget/function/f_printer.c       |  4 +-
 drivers/usb/gadget/function/f_rndis.c         |  2 +-
 drivers/usb/gadget/function/u_ether.c         |  4 +-
 drivers/usb/gadget/function/u_serial.c        |  2 +-
 drivers/usb/gadget/legacy/inode.c             |  2 +-
 drivers/usb/gadget/udc/dummy_hcd.c            |  2 +-
 drivers/usb/host/ehci-dbg.c                   |  2 +-
 drivers/usb/host/ehci-hcd.c                   |  2 +-
 drivers/usb/host/fotg210-hcd.c                |  2 +-
 drivers/usb/host/ohci-hcd.c                   |  4 +-
 drivers/usb/host/ohci-q.c                     |  6 +-
 drivers/usb/host/xhci-dbgcap.c                |  2 +-
 drivers/usb/misc/usbtest.c                    |  8 +-
 drivers/usb/musb/cppi_dma.c                   |  2 +-
 drivers/usb/musb/musb_core.c                  | 10 +--
 drivers/usb/musb/musb_gadget_ep0.c            |  6 +-
 drivers/usb/musb/musb_host.c                  |  4 +-
 drivers/usb/musb/musb_virthub.c               |  2 +-
 drivers/usb/musb/tusb6010.c                   |  2 +-
 drivers/usb/phy/phy-isp1301-omap.c            | 16 ++--
 drivers/usb/serial/cypress_m8.c               |  2 +-
 drivers/usb/usbip/stub_rx.c                   |  2 +-
 drivers/usb/usbip/vudc_transfer.c             |  4 +-
 drivers/video/fbdev/nvidia/nv_hw.c            |  2 +-
 drivers/video/fbdev/omap/lcdc.c               |  4 +-
 .../video/fbdev/omap2/omapfb/omapfb-ioctl.c   |  2 +-
 drivers/video/fbdev/savage/savagefb_driver.c  |  2 +-
 drivers/watchdog/ath79_wdt.c                  |  2 +-
 drivers/watchdog/wdrtas.c                     |  2 +-
 fs/nfsd/nfsproc.c                             |  2 +-
 fs/notify/fanotify/fanotify_user.c            |  2 +-
 fs/quota/quota.c                              |  2 +-
 fs/xfs/libxfs/xfs_alloc.c                     |  2 +-
 fs/xfs/xfs_inode.c                            |  2 +-
 include/linux/compiler_attributes.h           | 10 +++
 kernel/bpf/verifier.c                         |  2 +-
 kernel/kallsyms.c                             |  4 +-
 lib/glob.c                                    |  2 +-
 mm/ksm.c                                      |  2 +-
 mm/shmem.c                                    |  2 +-
 net/bridge/netfilter/ebtables.c               |  2 +-
 net/ipv4/udp.c                                |  2 +-
 net/ipv6/addrconf.c                           |  2 +-
 net/ipv6/ndisc.c                              |  2 +-
 net/ipv6/route.c                              |  2 +-
 net/netfilter/nf_conntrack_core.c             |  2 +-
 net/netfilter/nf_conntrack_standalone.c       |  2 +-
 net/netfilter/nf_nat_core.c                   | 12 +--
 net/netfilter/nfnetlink_cttimeout.c           |  2 +-
 net/netfilter/nft_ct.c                        |  4 +-
 net/netfilter/nft_fib.c                       |  2 +-
 net/packet/af_packet.c                        |  2 +-
 net/rds/rdma_transport.c                      |  2 +-
 net/sunrpc/xprtrdma/verbs.c                   |  2 +-
 sound/pci/hda/patch_realtek.c                 |  2 +-
 sound/soc/codecs/adau1761.c                   |  2 +-
 sound/soc/rockchip/rockchip_pdm.c             |  6 +-
 tools/lib/subcmd/parse-options.c              |  4 +-
 tools/objtool/arch/x86/decode.c               |  2 +-
 tools/objtool/check.c                         |  2 +-
 tools/testing/selftests/rtc/rtctest.c         |  2 +-
 tools/testing/selftests/rtc/setdate.c         |  2 +-
 tools/testing/selftests/timers/rtcpie.c       |  2 +-
 238 files changed, 541 insertions(+), 529 deletions(-)

diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index 33e904a05881..1feffef3d01e 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -453,7 +453,7 @@ syscall_restart(unsigned long r0, unsigned long r19,
 			regs->r0 = EINTR;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case ERESTARTNOINTR:
 		regs->r0 = r0;	/* reset v0 and a3 and replay syscall */
 		regs->r19 = r19;
diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
index 1bfb7de696bd..f0b56eb7218b 100644
--- a/arch/arc/kernel/signal.c
+++ b/arch/arc/kernel/signal.c
@@ -324,7 +324,7 @@ static void arc_restart_syscall(struct k_sigaction *ka, struct pt_regs *regs)
 			regs->r0 = -EINTR;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 
 	case -ERESTARTNOINTR:
 		/*
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 859c71c4e932..bf40b29dc460 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -398,8 +398,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = OMAP3430_REV_ES3_1;
 			cpu_rev = "3.1";
 			break;
-		case 7:
-		/* FALLTHROUGH */
+		case 7: __fallthrough;
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1_2;
@@ -418,8 +417,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = AM35XX_REV_ES1_0;
 			cpu_rev = "1.0";
 			break;
-		case 1:
-		/* FALLTHROUGH */
+		case 1: __fallthrough;
 		default:
 			omap_revision = AM35XX_REV_ES1_1;
 			cpu_rev = "1.1";
@@ -437,8 +435,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = OMAP3630_REV_ES1_1;
 			cpu_rev = "1.1";
 			break;
-		case 2:
-		/* FALLTHROUGH */
+		case 2: __fallthrough;
 		default:
 			omap_revision = OMAP3630_REV_ES1_2;
 			cpu_rev = "1.2";
@@ -458,8 +455,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = TI8168_REV_ES2_0;
 			cpu_rev = "2.0";
 			break;
-		case 3:
-			/* FALLTHROUGH */
+		case 3: __fallthrough;
 		default:
 			omap_revision = TI8168_REV_ES2_1;
 			cpu_rev = "2.1";
@@ -475,8 +471,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = AM335X_REV_ES2_0;
 			cpu_rev = "2.0";
 			break;
-		case 2:
-		/* FALLTHROUGH */
+		case 2: __fallthrough;
 		default:
 			omap_revision = AM335X_REV_ES2_1;
 			cpu_rev = "2.1";
@@ -493,8 +488,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = AM437X_REV_ES1_1;
 			cpu_rev = "1.1";
 			break;
-		case 2:
-		/* FALLTHROUGH */
+		case 2: __fallthrough;
 		default:
 			omap_revision = AM437X_REV_ES1_2;
 			cpu_rev = "1.2";
@@ -504,8 +498,7 @@ void __init omap3xxx_check_revision(void)
 	case 0xb8f2:
 	case 0xb968:
 		switch (rev) {
-		case 0:
-		/* FALLTHROUGH */
+		case 0: __fallthrough;
 		case 1:
 			omap_revision = TI8148_REV_ES1_0;
 			cpu_rev = "1.0";
@@ -514,8 +507,7 @@ void __init omap3xxx_check_revision(void)
 			omap_revision = TI8148_REV_ES2_0;
 			cpu_rev = "2.0";
 			break;
-		case 3:
-		/* FALLTHROUGH */
+		case 3: __fallthrough;
 		default:
 			omap_revision = TI8148_REV_ES2_1;
 			cpu_rev = "2.1";
diff --git a/arch/arm/mm/proc-v7-bugs.c b/arch/arm/mm/proc-v7-bugs.c
index 9a07916af8dd..6aafbd1727da 100644
--- a/arch/arm/mm/proc-v7-bugs.c
+++ b/arch/arm/mm/proc-v7-bugs.c
@@ -69,7 +69,7 @@ static void cpu_v7_spectre_init(void)
 		/* Other ARM CPUs require no workaround */
 		if (read_cpuid_implementor() == ARM_CPU_IMP_ARM)
 			break;
-		/* fallthrough */
+		__fallthrough;
 		/* Cortex A57/A72 require firmware workaround */
 	case ARM_CPU_PART_CORTEX_A57:
 	case ARM_CPU_PART_CORTEX_A72: {
diff --git a/arch/c6x/kernel/signal.c b/arch/c6x/kernel/signal.c
index 33b9f69c38f7..b527e404957f 100644
--- a/arch/c6x/kernel/signal.c
+++ b/arch/c6x/kernel/signal.c
@@ -223,7 +223,7 @@ handle_restart(struct pt_regs *regs, struct k_sigaction *ka, int has_handler)
 			regs->a4 = -EINTR;
 			break;
 		}
-	/* fallthrough */
+		__fallthrough;
 	case -ERESTARTNOINTR:
 do_restart:
 		regs->a4 = regs->orig_a4;
@@ -255,7 +255,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs,
 				break;
 			}
 
-			/* fallthrough */
+			__fallthrough;
 		case -ERESTARTNOINTR:
 			regs->a4 = regs->orig_a4;
 			regs->pc -= 4;
diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
index e0f2b708e5d9..063e8c8a53bb 100644
--- a/arch/h8300/kernel/signal.c
+++ b/arch/h8300/kernel/signal.c
@@ -228,7 +228,7 @@ handle_restart(struct pt_regs *regs, struct k_sigaction *ka)
 			regs->er0 = -EINTR;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case -ERESTARTNOINTR:
 do_restart:
 		regs->er0 = regs->orig_er0;
diff --git a/arch/hexagon/kernel/module.c b/arch/hexagon/kernel/module.c
index 477d07a5646c..696a0072eb00 100644
--- a/arch/hexagon/kernel/module.c
+++ b/arch/hexagon/kernel/module.c
@@ -133,7 +133,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		}
 		case R_HEXAGON_HI16:
 			value = (value>>16) & 0xffff;
-			/* fallthrough */
+			__fallthrough;
 		case R_HEXAGON_LO16:
 			*location &= ~0x00c03fff;
 			*location |= value & 0x3fff;
diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index 87e7f3639839..1d603266670d 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -1068,7 +1068,7 @@ handle_restart(struct pt_regs *regs, struct k_sigaction *ka, int has_handler)
 			regs->d0 = -EINTR;
 			break;
 		}
-	/* fallthrough */
+	__fallthrough;
 	case -ERESTARTNOINTR:
 	do_restart:
 		regs->d0 = regs->orig_d0;
diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index 0685696349bb..8b9ebcd54bf6 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -252,8 +252,8 @@ handle_restart(struct pt_regs *regs, struct k_sigaction *ka, int has_handler)
 		if (has_handler && !(ka->sa.sa_flags & SA_RESTART)) {
 			regs->r3 = -EINTR;
 			break;
-	}
-	/* fallthrough */
+		}
+		__fallthrough;
 	case -ERESTARTNOINTR:
 do_restart:
 		/* offset of 4 bytes to re-execute trap (brki) instruction */
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
index 3e0c75c0ece0..4491daa3b64c 100644
--- a/arch/mips/alchemy/devboards/db1550.c
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -225,7 +225,7 @@ static void __init pb1550_nand_setup(void)
 	case 0: case 2: case 8: case 0xC: case 0xD:
 		/* x16 NAND Flash */
 		pb1550_nand_pd.devwidth = 1;
-		/* fallthrough */
+		__fallthrough;
 	case 1: case 3: case 9: case 0xE: case 0xF:
 		/* x8 NAND, already set up */
 		platform_device_register(&pb1550_nand_dev);
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index d75337974ee9..c46313e69268 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -824,7 +824,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 				regs->regs[2] = EINTR;
 				break;
 			}
-		/* fallthrough */
+		__fallthrough;
 		case ERESTARTNOINTR:
 			regs->regs[7] = regs->regs[26];
 			regs->regs[2] = regs->regs[0];
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
index 848c1934680b..4bfe78d4102f 100644
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -503,7 +503,7 @@ syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
 			regs->gr[28] = -EINTR;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case -ERESTARTNOINTR:
 		check_syscallno_in_delay_branch(regs);
 		break;
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 837e1646091a..90f024569fa9 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -246,7 +246,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 				regs->a0 = -EINTR;
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case -ERESTARTNOINTR:
                         regs->a0 = regs->orig_a0;
 			regs->sepc -= 0x4;
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 22f08245aa5d..b1d5fdfb6645 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -487,7 +487,7 @@ void do_signal(struct pt_regs *regs)
 					regs->gprs[2] = -EINTR;
 					break;
 				}
-			/* fallthrough */
+				__fallthrough;
 			case -ERESTARTNOINTR:
 				regs->gprs[2] = regs->orig_gpr2;
 				regs->psw.addr =
@@ -514,7 +514,7 @@ void do_signal(struct pt_regs *regs)
 		case -ERESTART_RESTARTBLOCK:
 			/* Restart with sys_restart_syscall */
 			regs->int_code = __NR_restart_syscall;
-		/* fallthrough */
+			__fallthrough;
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 8964a3f60aad..81c8b08e0f34 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -86,7 +86,7 @@ static cpumask_t cpu_group_map(struct mask_info *info, unsigned int cpu)
 		cpumask_copy(&mask, cpu_present_mask);
 		break;
 	default:
-		/* fallthrough */
+		__fallthrough;
 	case TOPOLOGY_MODE_SINGLE:
 		cpumask_copy(&mask, cpumask_of(cpu));
 		break;
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 07d30ffcfa41..0a2a7a190094 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -676,8 +676,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		if (edat1)
 			dat_protection |= rfte.p;
 		ptr = rfte.rto * PAGE_SIZE + vaddr.rsx * 8;
+		__fallthrough;
 	}
-		/* fallthrough */
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
@@ -694,8 +694,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		if (edat1)
 			dat_protection |= rste.p;
 		ptr = rste.rto * PAGE_SIZE + vaddr.rtx * 8;
+		__fallthrough;
 	}
-		/* fallthrough */
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
@@ -722,8 +722,8 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		if (edat1)
 			dat_protection |= rtte.fc0.p;
 		ptr = rtte.fc0.sto * PAGE_SIZE + vaddr.sx * 8;
+		__fallthrough;
 	}
-		/* fallthrough */
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
@@ -1050,7 +1050,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		rc = gmap_shadow_r2t(sg, saddr, rfte.val, *fake);
 		if (rc)
 			return rc;
-	} /* fallthrough */
+		 __fallthrough;
+	}
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
@@ -1076,7 +1077,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		rc = gmap_shadow_r3t(sg, saddr, rste.val, *fake);
 		if (rc)
 			return rc;
-	} /* fallthrough */
+		__fallthrough;
+	}
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
@@ -1111,7 +1113,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 		rc = gmap_shadow_sgt(sg, saddr, rtte.val, *fake);
 		if (rc)
 			return rc;
-	} /* fallthrough */
+		__fallthrough;
+	}
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 11613362c4e7..a9a33d7a49ef 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -133,7 +133,7 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 		if (*table & _REGION_ENTRY_INVALID)
 			goto out;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		/* fallthrough */
+		__fallthrough;
 	case _ASCE_TYPE_REGION2:
 		table += (address & _REGION2_INDEX) >> _REGION2_SHIFT;
 		if (bad_address(table))
@@ -142,7 +142,7 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 		if (*table & _REGION_ENTRY_INVALID)
 			goto out;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		/* fallthrough */
+		__fallthrough;
 	case _ASCE_TYPE_REGION3:
 		table += (address & _REGION3_INDEX) >> _REGION3_SHIFT;
 		if (bad_address(table))
@@ -151,7 +151,7 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 		if (*table & (_REGION_ENTRY_INVALID | _REGION3_ENTRY_LARGE))
 			goto out;
 		table = (unsigned long *)(*table & _REGION_ENTRY_ORIGIN);
-		/* fallthrough */
+		__fallthrough;
 	case _ASCE_TYPE_SEGMENT:
 		table += (address & _SEGMENT_INDEX) >> _SEGMENT_SHIFT;
 		if (bad_address(table))
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index db6bb2f97a2c..b15967ab48a1 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -306,7 +306,7 @@ static void __tlb_remove_table(void *_table)
 		mask >>= 24;
 		if (mask != 0)
 			break;
-		/* fallthrough */
+		__fallthrough;
 	case 3:		/* 4K page table with pgstes */
 		if (mask & 3)
 			atomic_xor_bits(&page->_refcount, 3 << 24);
diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index 2a2121ba8ebe..22526b95aaac 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -419,7 +419,7 @@ handle_syscall_restart(unsigned long save_r0, struct pt_regs *regs,
 		case -ERESTARTSYS:
 			if (!(sa->sa_flags & SA_RESTART))
 				goto no_system_call_restart;
-		/* fallthrough */
+		    __fallthrough;
 		case -ERESTARTNOINTR:
 			regs->regs[0] = save_r0;
 			regs->pc -= instruction_size(__raw_readw(regs->pc - 4));
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index f1f1598879c2..9edeb2c6a4ea 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -58,7 +58,7 @@ handle_syscall_restart(struct pt_regs *regs, struct sigaction *sa)
 		case -ERESTARTSYS:
 			if (!(sa->sa_flags & SA_RESTART))
 				goto no_system_call_restart;
-		/* fallthrough */
+			__fallthrough;
 		case -ERESTARTNOINTR:
 			/* Decode syscall # */
 			regs->regs[REG_RET] = regs->syscall_nr;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 1393a8ac596b..111195861ced 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -246,9 +246,9 @@ extern struct page *mem_map_zero;
 									\
 	switch (sizeof(struct page)) {					\
 	case 80:							\
-		_pp[9] = 0;	/* fallthrough */			\
+		_pp[9] = 0;	__fallthrough;		\
 	case 72:							\
-		_pp[8] = 0;	/* fallthrough */			\
+		_pp[8] = 0;	__fallthrough;		\
 	default:							\
 		_pp[7] = 0;						\
 		_pp[6] = 0;						\
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index eb978c77c76a..4aaa1b54f529 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -358,7 +358,7 @@ int __init pcr_arch_init(void)
 		 * counter overflow interrupt so we can't make use of
 		 * their hardware currently.
 		 */
-		/* fallthrough */
+		__fallthrough;
 	default:
 		err = -ENODEV;
 		goto out_unregister;
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e800ce13cc6e..ceb9f1852f09 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -643,7 +643,7 @@ static inline void syscall_restart32(unsigned long orig_i0, struct pt_regs *regs
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		__fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->tpc -= 4;
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 83953780ca01..17345ee31e1b 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -442,7 +442,7 @@ static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		__fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->pc -= 4;
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index ca70787efd8e..164423f3b316 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -462,7 +462,7 @@ static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		__fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->tpc -= 4;
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 57acbd67d85d..973c9002be7e 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -42,7 +42,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 				PT_REGS_SYSCALL_RET(regs) = -EINTR;
 				break;
 			}
-		/* fallthrough */
+			__fallthrough;
 		case -ERESTARTNOINTR:
 			PT_REGS_RESTART_SYSCALL(regs);
 			PT_REGS_ORIG_SYSCALL(regs) = PT_REGS_SYSCALL_NR(regs);
diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index 63be04809d40..a2ca1ccddd70 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -323,7 +323,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs,
 				regs->UCreg_00 = -EINTR;
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case -ERESTARTNOINTR:
 			setup_syscall_restart(regs);
 		}
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index e43eb6732630..acd20281a0bc 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -190,7 +190,7 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval)
 		if (!atomic_sub_return(1, &cmci_storm_on_cpus))
 			pr_notice("CMCI storm subsided: switching to interrupt mode\n");
 
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	case CMCI_STORM_SUBSIDED:
 		/*
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 08dfd4c1a4f9..ede2e95f4985 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -730,7 +730,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 				regs->ax = -EINTR;
 				break;
 			}
-		/* fallthrough */
+		    __fallthrough;
 		case -ERESTARTNOINTR:
 			regs->ax = regs->orig_ax;
 			regs->ip -= 2;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c73375e01ab8..64069d1ff42e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1775,7 +1775,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
 			return 1;
-		/* Else, falls through */
+		_fallsthrough_;
 	default:
 		msr = find_msr_entry(vmx, msr_info->index);
 		if (msr) {
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index dc22a238ed9c..b342d5a5e49b 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -438,7 +438,7 @@ static void do_signal(struct pt_regs *regs)
 						regs->areg[2] = -EINTR;
 						break;
 					}
-					/* fallthrough */
+					__fallthrough;
 				case -ERESTARTNOINTR:
 					regs->areg[2] = regs->syscall;
 					regs->pc -= 3;
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index fd166fbb0f65..a433d945666b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -533,7 +533,7 @@ static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
 		if ((bio->bi_opf & (REQ_SYNC | REQ_IDLE)) ==
 		    (REQ_SYNC | REQ_IDLE))
 			return false;
-		/* fallthrough */
+		__fallthrough;
 	case REQ_OP_DISCARD:
 		return true;
 	default:
diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 5839f2fa7400..7a4a2b4485d3 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -470,7 +470,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 		case 'X':
 
 			type |= ACPI_FORMAT_UPPER;
-			/* FALLTHROUGH */
+			__fallthrough;
 
 		case 'x':
 
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index d032bf657f70..550ae4c0011e 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -659,7 +659,7 @@ static void pdc_qc_prep(struct ata_queued_cmd *qc)
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 		pdc_fill_sg(qc);
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case ATA_PROT_NODATA:
 		i = pdc_pkt_header(&qc->tf, qc->ap->bmdma_prd_dma,
 				   qc->dev->devno, pp->pkt);
@@ -674,7 +674,7 @@ static void pdc_qc_prep(struct ata_queued_cmd *qc)
 		break;
 	case ATAPI_PROT_DMA:
 		pdc_fill_sg(qc);
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case ATAPI_PROT_NODATA:
 		pdc_atapi_pkt(qc);
 		break;
@@ -1042,11 +1042,11 @@ static unsigned int pdc_qc_issue(struct ata_queued_cmd *qc)
 	case ATAPI_PROT_NODATA:
 		if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
 			break;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case ATA_PROT_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			break;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case ATAPI_PROT_DMA:
 	case ATA_PROT_DMA:
 		pdc_packet_start(qc);
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 405e606a234d..beb3a996a202 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -683,7 +683,7 @@ static unsigned int pdc20621_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			break;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case ATA_PROT_DMA:
 		pdc20621_packet_start(qc);
 		return 0;
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 5f8e009b2da1..f6addd4c6193 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -2023,7 +2023,7 @@ static int lanai_normalize_ci(struct lanai_dev *lanai,
 	switch (*vpip) {
 		case ATM_VPI_ANY:
 			*vpip = 0;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case 0:
 			break;
 		default:
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index b5c865fe263b..d06ecfe39136 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -306,10 +306,10 @@ static ssize_t firmware_loading_store(struct device *dev,
 			}
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	default:
 		dev_err(dev, "%s: unexpected value (%d)\n", __func__, loading);
-		/* fallthrough */
+		__fallthrough;
 	case -1:
 		fw_load_abort(fw_sysfs);
 		break;
diff --git a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
index 89527bae4602..7e7c6fb61528 100644
--- a/drivers/char/agp/ali-agp.c
+++ b/drivers/char/agp/ali-agp.c
@@ -357,7 +357,7 @@ static int agp_ali_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		default:
 			break;
 		}
-		/*FALLTHROUGH*/
+		__fallthrough;
 	default:
 		bridge->driver = &ali_generic_bridge;
 	}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 1c99e992d638..5dc5b46d95c6 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -651,7 +651,7 @@ static int davinci_pll_sysclk_rate_change(struct notifier_block *nb,
 		pllcmd = readl(pll->base + PLLCMD);
 		pllcmd |= PLLCMD_GOSET;
 		writel(pllcmd, pll->base + PLLCMD);
-		/* fallthrough */
+		__fallthrough;
 	case PRE_RATE_CHANGE:
 		/* Wait until for outstanding changes to take effect */
 		do {
diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index d9c17078517b..38e51f6c4fb0 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -441,7 +441,7 @@ static void cc_setup_cipher_desc(struct crypto_tfm *tfm,
 			set_setup_mode(&desc[*seq_size], SETUP_LOAD_STATE0);
 		}
 		(*seq_size)++;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case DRV_CIPHER_ECB:
 		/* Load key */
 		hw_desc_init(&desc[*seq_size]);
diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 2854399856ba..f9449641b42e 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -243,7 +243,7 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
 					ast->dp501_fw_addr = NULL;
 				}
 			}
-			/* fallthrough */
+			__fallthrough;
 		case 0x0c:
 			ast->tx_chip_type = AST_TX_DP501;
 		}
diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index e407adb033e7..f15cbb4ce315 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -525,7 +525,7 @@ int drm_legacy_rmmap_locked(struct drm_device *dev, struct drm_local_map *map)
 	switch (map->type) {
 	case _DRM_REGISTERS:
 		iounmap(map->handle);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case _DRM_FRAME_BUFFER:
 		arch_phys_wc_del(map->mtrr);
 		break;
diff --git a/drivers/gpu/drm/i915/icl_dsi.c b/drivers/gpu/drm/i915/icl_dsi.c
index 73a7bee24a66..d78bca37c63d 100644
--- a/drivers/gpu/drm/i915/icl_dsi.c
+++ b/drivers/gpu/drm/i915/icl_dsi.c
@@ -645,7 +645,7 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		switch (intel_dsi->pixel_format) {
 		default:
 			MISSING_CASE(intel_dsi->pixel_format);
-			/* fallthrough */
+			__fallthrough;
 		case MIPI_DSI_FMT_RGB565:
 			tmp |= PIX_FMT_RGB565;
 			break;
@@ -666,7 +666,7 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 			switch (intel_dsi->video_mode_format) {
 			default:
 				MISSING_CASE(intel_dsi->video_mode_format);
-				/* fallthrough */
+				__fallthrough;
 			case VIDEO_MODE_NON_BURST_WITH_SYNC_EVENTS:
 				tmp |= VIDEO_MODE_SYNC_EVENT;
 				break;
@@ -705,7 +705,7 @@ gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
 		switch (pipe) {
 		default:
 			MISSING_CASE(pipe);
-			/* fallthrough */
+			__fallthrough;
 		case PIPE_A:
 			tmp |= TRANS_DDI_EDP_INPUT_A_ON;
 			break;
diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel_bios.c
index b508d8a735e0..68aedb106530 100644
--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -732,7 +732,7 @@ parse_psr(struct drm_i915_private *dev_priv, const struct bdb_header *bdb)
 		default:
 			DRM_DEBUG_KMS("VBT tp1 wakeup time value %d is outside range[0-3], defaulting to max value 2500us\n",
 					psr_table->tp1_wakeup_time);
-			/* fallthrough */
+			__fallthrough;
 		case 2:
 			dev_priv->vbt.psr.tp1_wakeup_time_us = 2500;
 			break;
@@ -751,7 +751,7 @@ parse_psr(struct drm_i915_private *dev_priv, const struct bdb_header *bdb)
 		default:
 			DRM_DEBUG_KMS("VBT tp2_tp3 wakeup time value %d is outside range[0-3], defaulting to max value 2500us\n",
 					psr_table->tp2_tp3_wakeup_time);
-			/* fallthrough */
+			__fallthrough;
 		case 2:
 			dev_priv->vbt.psr.tp2_tp3_wakeup_time_us = 2500;
 		break;
diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_ddi.c
index 14d580cdefd3..5465db05ac62 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -1979,7 +1979,7 @@ static void intel_ddi_get_encoder_pipes(struct intel_encoder *encoder,
 		switch (tmp & TRANS_DDI_EDP_INPUT_MASK) {
 		default:
 			MISSING_CASE(tmp & TRANS_DDI_EDP_INPUT_MASK);
-			/* fallthrough */
+			__fallthrough;
 		case TRANS_DDI_EDP_INPUT_A_ON:
 		case TRANS_DDI_EDP_INPUT_A_ONOFF:
 			*pipe_mask = BIT(PIPE_A);
diff --git a/drivers/gpu/drm/i915/intel_psr.c b/drivers/gpu/drm/i915/intel_psr.c
index 84a0fb981561..d1617d6d4455 100644
--- a/drivers/gpu/drm/i915/intel_psr.c
+++ b/drivers/gpu/drm/i915/intel_psr.c
@@ -97,7 +97,7 @@ static int edp_psr_shift(enum transcoder cpu_transcoder)
 		return EDP_PSR_TRANSCODER_C_SHIFT;
 	default:
 		MISSING_CASE(cpu_transcoder);
-		/* fallthrough */
+		__fallthrough;
 	case TRANSCODER_EDP:
 		return EDP_PSR_TRANSCODER_EDP_SHIFT;
 	}
diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 43e29984f8b1..dec8b54b359c 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -254,7 +254,7 @@ void meson_crtc_irq(struct meson_drm *priv)
 						   MESON_CANVAS_WRAP_NONE,
 						   MESON_CANVAS_BLKMODE_LINEAR,
 						   MESON_CANVAS_ENDIAN_SWAP64);
-		/* fallthrough */
+			__fallthrough;
 		case 2:
 			if (priv->canvas)
 				meson_canvas_config(priv->canvas,
@@ -273,7 +273,7 @@ void meson_crtc_irq(struct meson_drm *priv)
 						   MESON_CANVAS_WRAP_NONE,
 						   MESON_CANVAS_BLKMODE_LINEAR,
 						   MESON_CANVAS_ENDIAN_SWAP64);
-		/* fallthrough */
+			__fallthrough;
 		case 1:
 			if (priv->canvas)
 				meson_canvas_config(priv->canvas,
diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 691a9fd16b36..e608983ffaaf 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -480,7 +480,7 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 			 priv->viu.vd1_addr2,
 			 priv->viu.vd1_stride2,
 			 priv->viu.vd1_height2);
-	/* fallthrough */
+		__fallthrough;
 	case 2:
 		gem = drm_fb_cma_get_gem_obj(fb, 1);
 		priv->viu.vd1_addr1 = gem->paddr + fb->offsets[1];
@@ -492,7 +492,7 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 			 priv->viu.vd1_addr1,
 			 priv->viu.vd1_stride1,
 			 priv->viu.vd1_height1);
-	/* fallthrough */
+		__fallthrough;
 	case 1:
 		gem = drm_fb_cma_get_gem_obj(fb, 0);
 		priv->viu.vd1_addr0 = gem->paddr + fb->offsets[0];
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 607a6ea17ecc..de0a009b6a19 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -130,7 +130,7 @@ static inline u32 compute_dda_inc(unsigned int in, unsigned int out, bool v,
 
 		default:
 			WARN_ON_ONCE(1);
-			/* fallthrough */
+			__fallthrough;
 		case 4:
 			max = 4;
 			break;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
index 1067e702c22c..781372c27d4c 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
@@ -393,7 +393,7 @@ static void tilcdc_crtc_set_mode(struct drm_crtc *crtc)
 		case DRM_FORMAT_XBGR8888:
 		case DRM_FORMAT_XRGB8888:
 			reg |= LCDC_V2_TFT_24BPP_UNPACK;
-			/* fallthrough */
+			__fallthrough;
 		case DRM_FORMAT_BGR888:
 		case DRM_FORMAT_RGB888:
 			reg |= LCDC_V2_TFT_24BPP_MODE;
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 7780da4fe897..a5722c746992 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1675,7 +1675,7 @@ static ssize_t wiimote_ext_show(struct device *dev,
 	case WIIMOTE_EXT_GUITAR:
 		return sprintf(buf, "guitar\n");
 	case WIIMOTE_EXT_UNKNOWN:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		return sprintf(buf, "unknown\n");
 	}
@@ -1725,7 +1725,7 @@ static ssize_t wiimote_dev_show(struct device *dev,
 	case WIIMOTE_DEV_PENDING:
 		return sprintf(buf, "pending\n");
 	case WIIMOTE_DEV_UNKNOWN:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		return sprintf(buf, "unknown\n");
 	}
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 5054d1105236..a7040d19e778 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,7 +353,7 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
 
-		/* fallthrough */
+		__fallthrough;
 
 	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 000b53e5a17a..6becc263b244 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1089,7 +1089,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 
 			case HV_CALL_BATCHED:
 				hv_begin_read(&channel->inbound);
-				/* fallthrough */
+				__fallthrough;
 			case HV_CALL_DIRECT:
 				tasklet_schedule(&channel->callback_event);
 			}
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index cd9c65f3d404..ebcde7a504a6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1388,7 +1388,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		major = OMAP_I2C_REV_SCHEME_0_MAJOR(omap->rev);
 		break;
 	case OMAP_I2C_SCHEME_1:
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		omap->regs = (u8 *)reg_map_ip_v2;
 		rev = (rev << 16) |
diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index e0923bee8d1f..60752c630462 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -159,7 +159,7 @@ static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
 
 	case state_repeat_start:
 		outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
-		/* fallthrough */
+		__fallthrough;
 
 	case state_quick:
 		if (iface->address_byte & 1) {
diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index b2039f94c9d8..3a12d7536cfe 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -50,7 +50,7 @@ static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
 	case I2C_SLAVE_READ_PROCESSED:
 		/* The previous byte made it to the bus, get next one */
 		eeprom->buffer_idx++;
-		/* fallthrough */
+		__fallthrough;
 	case I2C_SLAVE_READ_REQUESTED:
 		spin_lock(&eeprom->buffer_lock);
 		*val = eeprom->buffer[eeprom->buffer_idx];
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 9ad60421d360..1c2b12e01b97 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -698,7 +698,7 @@ static void cpcap_adc_phase(struct cpcap_adc_request *req)
 		break;
 	case CPCAP_ADC_BATTI_PI17:
 		index = req->bank_index;
-		/* fallthrough */
+		__fallthrough;
 	default:
 		req->result += conv_tbl[index].cal_offset;
 		req->result += conv_tbl[index].align_offset;
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 76f16f9c7616..297d63df1a03 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1046,7 +1046,7 @@ static int si1145_initialize(struct si1145_data *data)
 						SI1145_LED_CURRENT_45mA);
 		if (ret < 0)
 			return ret;
-		/* fallthrough */
+		__fallthrough;
 	case 2:
 		ret = i2c_smbus_write_byte_data(client,
 						SI1145_REG_PS_LED21,
diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c b/drivers/infiniband/hw/cxgb3/iwch_cm.c
index 1c90c86fc8b8..7c134ad53645 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_cm.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_cm.c
@@ -1576,7 +1576,7 @@ static int peer_abort(struct t3cdev *tdev, struct sk_buff *skb, void *ctx)
 	case MORIBUND:
 	case CLOSING:
 		stop_ep_timer(ep);
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case FPDU_MODE:
 		if (ep->com.cm_id && ep->com.qp) {
 			attrs.next_state = IWCH_QP_STATE_ERROR;
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 4d232bdf9e97..6347354184eb 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2877,7 +2877,7 @@ static int peer_abort(struct c4iw_dev *dev, struct sk_buff *skb)
 	case MORIBUND:
 	case CLOSING:
 		stop_ep_timer(ep);
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case FPDU_MODE:
 		if (ep->com.qp && ep->com.qp->srq) {
 			srqidx = ABORT_RSS_SRQIDX_G(
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index d3a82839f5ea..ef0beb88e12b 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1192,7 +1192,7 @@ int c4iw_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 				break;
 			}
 			fw_flags |= FW_RI_RDMA_WRITE_WITH_IMMEDIATE;
-			/*FALLTHROUGH*/
+			__fallthrough;
 		case IB_WR_RDMA_WRITE:
 			fw_opcode = FW_RI_RDMA_WRITE_WR;
 			swsqe->opcode = FW_RI_RDMA_WRITE;
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 4228393e6c4c..f1c7870355c4 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -1272,7 +1272,7 @@ static int set_port_states(struct hfi1_pportdata *ppd, struct opa_smp *smp,
 	case IB_PORT_NOP:
 		if (phys_state == IB_PORTPHYSSTATE_NOP)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case IB_PORT_DOWN:
 		if (phys_state == IB_PORTPHYSSTATE_NOP) {
 			link_state = HLS_DN_DOWNDEF;
@@ -2300,7 +2300,7 @@ static int __subn_set_opa_vl_arb(struct opa_smp *smp, u32 am, u8 *data,
 	 * can be changed from the default values
 	 */
 	case OPA_VLARB_PREEMPT_ELEMENTS:
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OPA_VLARB_PREEMPT_MATRIX:
 		smp->status |= IB_SMP_UNSUP_METH_ATTR;
 		break;
@@ -4180,7 +4180,7 @@ static int subn_get_opa_sma(__be16 attr_id, struct opa_smp *smp, u32 am,
 			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
 		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
 			return IB_MAD_RESULT_SUCCESS;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		smp->status |= IB_SMP_UNSUP_METH_ATTR;
 		ret = reply((struct ib_mad_hdr *)smp);
@@ -4250,7 +4250,7 @@ static int subn_set_opa_sma(__be16 attr_id, struct opa_smp *smp, u32 am,
 			return IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_CONSUMED;
 		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
 			return IB_MAD_RESULT_SUCCESS;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		smp->status |= IB_SMP_UNSUP_METH_ATTR;
 		ret = reply((struct ib_mad_hdr *)smp);
diff --git a/drivers/infiniband/hw/hfi1/platform.c b/drivers/infiniband/hw/hfi1/platform.c
index cbf7faa5038c..3c2cda894b33 100644
--- a/drivers/infiniband/hw/hfi1/platform.c
+++ b/drivers/infiniband/hw/hfi1/platform.c
@@ -668,8 +668,8 @@ static u8 aoc_low_power_setting(struct hfi1_pportdata *ppd)
 
 	/* active optical cables only */
 	switch ((cache[QSFP_MOD_TECH_OFFS] & 0xF0) >> 4) {
-	case 0x0 ... 0x9: /* fallthrough */
-	case 0xC: /* fallthrough */
+	case 0x0 ... 0x9: __fallthrough;
+	case 0xC: __fallthrough;
 	case 0xE:
 		/* active AOC */
 		power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
@@ -899,8 +899,8 @@ static int tune_qsfp(struct hfi1_pportdata *ppd,
 
 		*ptr_tuning_method = OPA_PASSIVE_TUNING;
 		break;
-	case 0x0 ... 0x9: /* fallthrough */
-	case 0xC: /* fallthrough */
+	case 0x0 ... 0x9: __fallthrough;
+	case 0xC: __fallthrough;
 	case 0xE:
 		ret = tune_active_qsfp(ppd, ptr_tx_preset, ptr_rx_preset,
 				       ptr_total_atten);
@@ -909,7 +909,7 @@ static int tune_qsfp(struct hfi1_pportdata *ppd,
 
 		*ptr_tuning_method = OPA_ACTIVE_TUNING;
 		break;
-	case 0xD: /* fallthrough */
+	case 0xD: __fallthrough;
 	case 0xF:
 	default:
 		dd_dev_warn(ppd->dd, "%s: Unknown/unsupported cable\n",
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index e6726c1ab866..ce49b25a3672 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -144,7 +144,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 			rvt_put_mr(e->rdma_sge.mr);
 			e->rdma_sge.mr = NULL;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(ATOMIC_ACKNOWLEDGE):
 		/*
 		 * We can increment the tail pointer now that the last
@@ -163,7 +163,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 			qp->s_acked_ack_queue = next;
 		qp->s_tail_ack_queue = next;
 		trace_hfi1_rsp_make_rc_ack(qp, e->psn);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_ONLY):
 	case OP(ACKNOWLEDGE):
 		/* Check for no next entry in the queue. */
@@ -270,7 +270,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 
 	case OP(RDMA_READ_RESPONSE_FIRST):
 		qp->s_ack_state = OP(RDMA_READ_RESPONSE_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_READ_RESPONSE_MIDDLE):
 		ps->s_txreq->ss = &qp->s_ack_rdma_sge;
 		ps->s_txreq->mr = qp->s_ack_rdma_sge.sge.mr;
@@ -890,7 +890,7 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			}
 			qp->s_num_rd_atomic++;
 
-			/* FALLTHROUGH */
+			__fallthrough;
 		case IB_WR_OPFN:
 			if (newreq && !(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
 				qp->s_lsn++;
@@ -954,10 +954,10 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		 * See restart_rc().
 		 */
 		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_FIRST):
 		qp->s_state = OP(SEND_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 		bth2 = mask_psn(qp->s_psn++);
 		ss = &qp->s_sge;
@@ -999,10 +999,10 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		 * See restart_rc().
 		 */
 		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_FIRST):
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		bth2 = mask_psn(qp->s_psn++);
 		ss = &qp->s_sge;
@@ -2916,7 +2916,7 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 		if (!ret)
 			goto rnr_nak;
 		qp->r_rcv_len = 0;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 	case OP(RDMA_WRITE_MIDDLE):
 send_middle:
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index b0110728f541..8308a4b6086c 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3235,7 +3235,7 @@ void _sdma_txreq_ahgadd(
 		tx->num_desc++;
 		tx->descs[2].qw[0] = 0;
 		tx->descs[2].qw[1] = 0;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case SDMA_AHG_APPLY_UPDATE2:
 		tx->num_desc++;
 		tx->descs[1].qw[0] = 0;
diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 4ed4fcfabd6c..13fb4aa74b67 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -216,7 +216,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 
 	case OP(SEND_FIRST):
 		qp->s_state = OP(SEND_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 		len = qp->s_len;
 		if (len > pmtu) {
@@ -241,7 +241,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 
 	case OP(RDMA_WRITE_FIRST):
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		len = qp->s_len;
 		if (len > pmtu) {
@@ -414,7 +414,7 @@ void hfi1_uc_rcv(struct hfi1_packet *packet)
 			goto no_immediate_data;
 		else if (opcode == OP(SEND_ONLY_WITH_IMMEDIATE))
 			goto send_last_imm;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 		/* Check for invalid length PMTU or posted rwqe len. */
 		/*
@@ -516,7 +516,7 @@ void hfi1_uc_rcv(struct hfi1_packet *packet)
 			wc.ex.imm_data = ohdr->u.rc.imm_data;
 			goto rdma_last_imm;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		/* Check for invalid length PMTU or posted rwqe len. */
 		if (unlikely(tlen != (hdrsize + pmtu + 4)))
diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 4d841a3c68f3..e362c8226036 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -1875,7 +1875,7 @@ static enum i40iw_status_code i40iw_sc_get_next_aeqe(struct i40iw_sc_aeq *aeq,
 		info->out_rdrsp = true;
 		break;
 	case I40IW_AE_SOURCE_RSVD:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		break;
 	}
@@ -3673,14 +3673,14 @@ static enum i40iw_status_code cqp_sds_wqe_fill(struct i40iw_sc_cqp *cqp,
 					LS_64(1, I40IW_CQPSQ_UPESD_ENTRY_VALID)));
 
 		set_64bit_val(wqe, 56, info->entry[2].data);
-		/* fallthrough */
+		__fallthrough;
 	case 2:
 		set_64bit_val(wqe, 32,
 			      (LS_64(info->entry[1].cmd, I40IW_CQPSQ_UPESD_SDCMD) |
 					LS_64(1, I40IW_CQPSQ_UPESD_ENTRY_VALID)));
 
 		set_64bit_val(wqe, 40, info->entry[1].data);
-		/* fallthrough */
+		__fallthrough;
 	case 1:
 		set_64bit_val(wqe, 0,
 			      LS_64(info->entry[0].cmd, I40IW_CQPSQ_UPESD_SDCMD));
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 68095f00d08f..2512679ed4e6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1491,36 +1491,36 @@ static void i40iw_deinit_device(struct i40iw_device *iwdev)
 		iwdev->iw_status = 0;
 		i40iw_port_ibevent(iwdev);
 		i40iw_destroy_rdma_device(iwdev->iwibdev);
-		/* fallthrough */
+		__fallthrough;
 	case IP_ADDR_REGISTERED:
 		if (!iwdev->reset)
 			i40iw_del_macip_entry(iwdev, (u8)iwdev->mac_ip_table_idx);
-		/* fallthrough */
-		/* fallthrough */
+		__fallthrough;
+		__fallthrough;
 	case PBLE_CHUNK_MEM:
 		i40iw_destroy_pble_pool(dev, iwdev->pble_rsrc);
-		/* fallthrough */
+		__fallthrough;
 	case CEQ_CREATED:
 		i40iw_dele_ceqs(iwdev);
-		/* fallthrough */
+		__fallthrough;
 	case AEQ_CREATED:
 		i40iw_destroy_aeq(iwdev);
-		/* fallthrough */
+		__fallthrough;
 	case IEQ_CREATED:
 		i40iw_puda_dele_resources(&iwdev->vsi, I40IW_PUDA_RSRC_TYPE_IEQ, iwdev->reset);
-		/* fallthrough */
+		__fallthrough;
 	case ILQ_CREATED:
 		i40iw_puda_dele_resources(&iwdev->vsi, I40IW_PUDA_RSRC_TYPE_ILQ, iwdev->reset);
-		/* fallthrough */
+		__fallthrough;
 	case CCQ_CREATED:
 		i40iw_destroy_ccq(iwdev);
-		/* fallthrough */
+		__fallthrough;
 	case HMC_OBJS_CREATED:
 		i40iw_del_hmc_objects(dev, dev->hmc_info, true, iwdev->reset);
-		/* fallthrough */
+		__fallthrough;
 	case CQP_CREATED:
 		i40iw_destroy_cqp(iwdev, true);
-		/* fallthrough */
+		__fallthrough;
 	case INITIAL_STATE:
 		i40iw_cleanup_cm_core(&iwdev->cm_core);
 		if (iwdev->vsi.pestat) {
@@ -1530,7 +1530,7 @@ static void i40iw_deinit_device(struct i40iw_device *iwdev)
 		i40iw_del_init_mem(iwdev);
 		break;
 	case INVALID_STATE:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		i40iw_pr_err("bad init_state = %d\n", iwdev->init_state);
 		break;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.c b/drivers/infiniband/hw/i40iw/i40iw_puda.c
index d9c7ae6a7030..7085ce6e5c38 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -820,7 +820,7 @@ void i40iw_puda_dele_resources(struct i40iw_sc_vsi *vsi,
 			i40iw_puda_free_qp(rsrc);
 
 		i40iw_free_dma_mem(dev->hw, &rsrc->qpmem);
-		/* fallthrough */
+		__fallthrough;
 	case PUDA_CQ_CREATED:
 		if (!reset)
 			i40iw_puda_free_cq(rsrc);
diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index f92faf5ec369..f07b0556da42 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -828,7 +828,7 @@ static int subn_set_portinfo(struct ib_smp *smp, struct ib_device *ibdev,
 	case IB_PORT_NOP:
 		if (lstate == 0)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case IB_PORT_DOWN:
 		if (lstate == 0)
 			lstate = QIB_IB_LINKDOWN_ONLY;
@@ -1928,7 +1928,7 @@ static int process_subn(struct ib_device *ibdev, int mad_flags,
 				ret = IB_MAD_RESULT_SUCCESS;
 				goto bail;
 			}
-			/* FALLTHROUGH */
+			__fallthrough;
 		default:
 			smp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply(smp);
@@ -1962,7 +1962,7 @@ static int process_subn(struct ib_device *ibdev, int mad_flags,
 				ret = IB_MAD_RESULT_SUCCESS;
 				goto bail;
 			}
-			/* FALLTHROUGH */
+			__fallthrough;
 		default:
 			smp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply(smp);
@@ -2341,7 +2341,7 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			ret = cc_get_congestion_control_table(ccp, ibdev, port);
 			goto bail;
 
-			/* FALLTHROUGH */
+			__fallthrough;
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply((struct ib_smp *) ccp);
@@ -2358,7 +2358,7 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			ret = cc_set_congestion_control_table(ccp, ibdev, port);
 			goto bail;
 
-			/* FALLTHROUGH */
+			__fallthrough;
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply((struct ib_smp *) ccp);
diff --git a/drivers/infiniband/hw/qib/qib_rc.c b/drivers/infiniband/hw/qib/qib_rc.c
index 50dd9811b088..c1eecf3bb565 100644
--- a/drivers/infiniband/hw/qib/qib_rc.c
+++ b/drivers/infiniband/hw/qib/qib_rc.c
@@ -83,7 +83,7 @@ static int qib_make_rc_ack(struct qib_ibdev *dev, struct rvt_qp *qp,
 			rvt_put_mr(e->rdma_sge.mr);
 			e->rdma_sge.mr = NULL;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(ATOMIC_ACKNOWLEDGE):
 		/*
 		 * We can increment the tail pointer now that the last
@@ -92,7 +92,7 @@ static int qib_make_rc_ack(struct qib_ibdev *dev, struct rvt_qp *qp,
 		 */
 		if (++qp->s_tail_ack_queue > QIB_MAX_RDMA_ATOMIC)
 			qp->s_tail_ack_queue = 0;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_ONLY):
 	case OP(ACKNOWLEDGE):
 		/* Check for no next entry in the queue. */
@@ -149,7 +149,7 @@ static int qib_make_rc_ack(struct qib_ibdev *dev, struct rvt_qp *qp,
 
 	case OP(RDMA_READ_RESPONSE_FIRST):
 		qp->s_ack_state = OP(RDMA_READ_RESPONSE_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_READ_RESPONSE_MIDDLE):
 		qp->s_cur_sge = &qp->s_ack_rdma_sge;
 		qp->s_rdma_mr = qp->s_ack_rdma_sge.sge.mr;
@@ -477,10 +477,10 @@ int qib_make_rc_req(struct rvt_qp *qp, unsigned long *flags)
 		 * See qib_restart_rc().
 		 */
 		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_FIRST):
 		qp->s_state = OP(SEND_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 		bth2 = qp->s_psn++ & QIB_PSN_MASK;
 		ss = &qp->s_sge;
@@ -516,10 +516,10 @@ int qib_make_rc_req(struct rvt_qp *qp, unsigned long *flags)
 		 * See qib_restart_rc().
 		 */
 		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_FIRST):
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		bth2 = qp->s_psn++ & QIB_PSN_MASK;
 		ss = &qp->s_sge;
@@ -1831,7 +1831,7 @@ void qib_rc_rcv(struct qib_ctxtdata *rcd, struct ib_header *hdr,
 		if (!ret)
 			goto rnr_nak;
 		qp->r_rcv_len = 0;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 	case OP(RDMA_WRITE_MIDDLE):
 send_middle:
diff --git a/drivers/infiniband/hw/qib/qib_uc.c b/drivers/infiniband/hw/qib/qib_uc.c
index 30c70ad0f4bf..d1acece68c65 100644
--- a/drivers/infiniband/hw/qib/qib_uc.c
+++ b/drivers/infiniband/hw/qib/qib_uc.c
@@ -161,7 +161,7 @@ int qib_make_uc_req(struct rvt_qp *qp, unsigned long *flags)
 
 	case OP(SEND_FIRST):
 		qp->s_state = OP(SEND_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 		len = qp->s_len;
 		if (len > pmtu) {
@@ -185,7 +185,7 @@ int qib_make_uc_req(struct rvt_qp *qp, unsigned long *flags)
 
 	case OP(RDMA_WRITE_FIRST):
 		qp->s_state = OP(RDMA_WRITE_MIDDLE);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		len = qp->s_len;
 		if (len > pmtu) {
@@ -351,7 +351,7 @@ void qib_uc_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 			goto no_immediate_data;
 		else if (opcode == OP(SEND_ONLY_WITH_IMMEDIATE))
 			goto send_last_imm;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(SEND_MIDDLE):
 		/* Check for invalid length PMTU or posted rwqe len. */
 		if (unlikely(tlen != (hdrsize + pmtu + 4)))
@@ -441,7 +441,7 @@ void qib_uc_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 			wc.ex.imm_data = ohdr->u.rc.imm_data;
 			goto rdma_last_imm;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OP(RDMA_WRITE_MIDDLE):
 		/* Check for invalid length PMTU or posted rwqe len. */
 		if (unlikely(tlen != (hdrsize + pmtu + 4)))
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 5ff32d32c61c..fd13f1fe89ce 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -238,7 +238,7 @@ static void qib_qp_rcv(struct qib_ctxtdata *rcd, struct ib_header *hdr,
 	case IB_QPT_GSI:
 		if (ib_qib_disable_sma)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case IB_QPT_UD:
 		qib_ud_rcv(ibp, hdr, has_grh, data, tlen, qp);
 		break;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 4ff3d98fa6a4..f718c303d2fe 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -906,7 +906,7 @@ static int iser_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_event *eve
 	case RDMA_CM_EVENT_REJECTED:
 		iser_info("Connection rejected: %s\n",
 			 rdma_reject_msg(cma_id, event->status));
-		/* FALLTHROUGH */
+		__fallthrough;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index d6e8f58a1de3..bf9861075968 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -108,7 +108,7 @@ static void navpoint_packet(struct navpoint *navpoint)
 	case 0x19:	/* Module 0, Hello packet */
 		if ((navpoint->data[1] & 0xf0) == 0x10)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		dev_warn(navpoint->dev,
 			 "spurious packet: data=0x%02x,0x%02x,...\n",
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 702bfda7ee77..ee1384df1da4 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -291,10 +291,9 @@ static int edt_ft5x06_register_write(struct edt_ft5x06_ts_data *tsdata,
 		wrbuf[3] = wrbuf[0] ^ wrbuf[1] ^ wrbuf[2];
 		return edt_ft5x06_ts_readwrite(tsdata->client, 4,
 					wrbuf, 0, NULL);
-	/* fallthrough */
-	case EDT_M09:
-	case EDT_M12:
-	case EV_FT:
+	case EDT_M09: __fallthrough;
+	case EDT_M12: __fallthrough;
+	case EV_FT: __fallthrough;
 	case GENERIC_FT:
 		wrbuf[0] = addr;
 		wrbuf[1] = value;
@@ -333,10 +332,9 @@ static int edt_ft5x06_register_read(struct edt_ft5x06_ts_data *tsdata,
 		}
 		break;
 
-	/* fallthrough */
-	case EDT_M09:
-	case EDT_M12:
-	case EV_FT:
+	case EDT_M09: __fallthrough;
+	case EDT_M12: __fallthrough;
+	case EV_FT: __fallthrough;
 	case GENERIC_FT:
 		wrbuf[0] = addr;
 		error = edt_ft5x06_ts_readwrite(tsdata->client, 1,
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index b2fd412715b1..5aa400bccf3e 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -467,7 +467,7 @@ static void do_journal_discard(struct cache *ca)
 			ca->sb.njournal_buckets;
 
 		atomic_set(&ja->discard_in_flight, DISCARD_READY);
-		/* fallthrough */
+		__fallthrough;
 
 	case DISCARD_READY:
 		if (ja->discard_idx == ja->last_idx)
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index 10f78109bb3f..dc0481d292ab 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -557,7 +557,7 @@ static int dvb_net_ule_new_payload(struct dvb_net_ule_handle *h)
 		h->priv->ule_sndu_type_1 = 1;
 		h->ts_remain -= 1;
 		h->from_where += 1;
-		/* fallthrough */
+		__fallthrough;
 	case 0:
 		h->new_ts = 1;
 		h->ts += TS_SZ;
diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index a6876fa48753..1c9c70ac66e3 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -2306,7 +2306,7 @@ hi_command(struct i2c_device_addr *dev_addr, const struct drxj_hi_cmd *cmd, u16
 			pr_err("error %d\n", rc);
 			goto rw_error;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case SIO_HI_RA_RAM_CMD_BRDCTRL:
 		rc = drxj_dap_write_reg16(dev_addr, SIO_HI_RA_RAM_PAR_2__A, cmd->param2, 0);
 		if (rc != 0) {
@@ -2318,7 +2318,7 @@ hi_command(struct i2c_device_addr *dev_addr, const struct drxj_hi_cmd *cmd, u16
 			pr_err("error %d\n", rc);
 			goto rw_error;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case SIO_HI_RA_RAM_CMD_NULL:
 		/* No parameters */
 		break;
@@ -4004,31 +4004,36 @@ static int scu_command(struct i2c_device_addr *dev_addr, struct drxjscu_cmd *cmd
 		if (rc != 0) {
 			pr_err("error %d\n", rc);
 			goto rw_error;
-		}	/* fallthrough */
+		}
+		__fallthrough;
 	case 4:
 		rc = drxj_dap_write_reg16(dev_addr, SCU_RAM_PARAM_3__A, *(cmd->parameter + 3), 0);
 		if (rc != 0) {
 			pr_err("error %d\n", rc);
 			goto rw_error;
-		}	/* fallthrough */
+		}
+		__fallthrough;
 	case 3:
 		rc = drxj_dap_write_reg16(dev_addr, SCU_RAM_PARAM_2__A, *(cmd->parameter + 2), 0);
 		if (rc != 0) {
 			pr_err("error %d\n", rc);
 			goto rw_error;
-		}	/* fallthrough */
+		}
+		__fallthrough;
 	case 2:
 		rc = drxj_dap_write_reg16(dev_addr, SCU_RAM_PARAM_1__A, *(cmd->parameter + 1), 0);
 		if (rc != 0) {
 			pr_err("error %d\n", rc);
 			goto rw_error;
-		}	/* fallthrough */
+		}
+		__fallthrough;
 	case 1:
 		rc = drxj_dap_write_reg16(dev_addr, SCU_RAM_PARAM_0__A, *(cmd->parameter + 0), 0);
 		if (rc != 0) {
 			pr_err("error %d\n", rc);
 			goto rw_error;
-		}	/* fallthrough */
+		}
+		__fallthrough;
 	case 0:
 		/* do nothing */
 		break;
@@ -4068,25 +4073,29 @@ static int scu_command(struct i2c_device_addr *dev_addr, struct drxjscu_cmd *cmd
 			if (rc != 0) {
 				pr_err("error %d\n", rc);
 				goto rw_error;
-			}	/* fallthrough */
+			}
+			__fallthrough;
 		case 3:
 			rc = drxj_dap_read_reg16(dev_addr, SCU_RAM_PARAM_2__A, cmd->result + 2, 0);
 			if (rc != 0) {
 				pr_err("error %d\n", rc);
 				goto rw_error;
-			}	/* fallthrough */
+			}
+			__fallthrough;
 		case 2:
 			rc = drxj_dap_read_reg16(dev_addr, SCU_RAM_PARAM_1__A, cmd->result + 1, 0);
 			if (rc != 0) {
 				pr_err("error %d\n", rc);
 				goto rw_error;
-			}	/* fallthrough */
+			}
+			__fallthrough;
 		case 1:
 			rc = drxj_dap_read_reg16(dev_addr, SCU_RAM_PARAM_0__A, cmd->result + 0, 0);
 			if (rc != 0) {
 				pr_err("error %d\n", rc);
 				goto rw_error;
-			}	/* fallthrough */
+			}
+			__fallthrough;
 		case 0:
 			/* do nothing */
 			break;
@@ -10628,8 +10637,8 @@ ctrl_set_channel(struct drx_demod_instance *demod, struct drx_channel *channel)
 		}
 		break;
 #ifndef DRXJ_VSB_ONLY
-	case DRX_STANDARD_ITU_A:	/* fallthrough */
-	case DRX_STANDARD_ITU_B:	/* fallthrough */
+	case DRX_STANDARD_ITU_A:	__fallthrough;
+	case DRX_STANDARD_ITU_B:	__fallthrough;
 	case DRX_STANDARD_ITU_C:
 		rc = set_qam_channel(demod, channel, tuner_freq_offset);
 		if (rc != 0) {
@@ -10820,7 +10829,7 @@ ctrl_lock_status(struct drx_demod_instance *demod, enum drx_lock_status *lock_st
 		    SCU_RAM_COMMAND_CMD_DEMOD_GET_LOCK;
 		break;
 #endif
-	case DRX_STANDARD_UNKNOWN:	/* fallthrough */
+	case DRX_STANDARD_UNKNOWN:	__fallthrough;
 	default:
 		return -EIO;
 	}
@@ -10888,8 +10897,8 @@ ctrl_set_standard(struct drx_demod_instance *demod, enum drx_standard *standard)
 	 */
 	switch (prev_standard) {
 #ifndef DRXJ_VSB_ONLY
-	case DRX_STANDARD_ITU_A:	/* fallthrough */
-	case DRX_STANDARD_ITU_B:	/* fallthrough */
+	case DRX_STANDARD_ITU_A:	__fallthrough;
+	case DRX_STANDARD_ITU_B:	__fallthrough;
 	case DRX_STANDARD_ITU_C:
 		rc = power_down_qam(demod, false);
 		if (rc != 0) {
@@ -10908,7 +10917,7 @@ ctrl_set_standard(struct drx_demod_instance *demod, enum drx_standard *standard)
 	case DRX_STANDARD_UNKNOWN:
 		/* Do nothing */
 		break;
-	case DRX_STANDARD_AUTO:	/* fallthrough */
+	case DRX_STANDARD_AUTO:	__fallthrough;
 	default:
 		return -EINVAL;
 	}
@@ -10921,8 +10930,8 @@ ctrl_set_standard(struct drx_demod_instance *demod, enum drx_standard *standard)
 
 	switch (*standard) {
 #ifndef DRXJ_VSB_ONLY
-	case DRX_STANDARD_ITU_A:	/* fallthrough */
-	case DRX_STANDARD_ITU_B:	/* fallthrough */
+	case DRX_STANDARD_ITU_A:	__fallthrough;
+	case DRX_STANDARD_ITU_B:	__fallthrough;
 	case DRX_STANDARD_ITU_C:
 		do {
 			u16 dummy;
@@ -11111,12 +11120,12 @@ ctrl_power_mode(struct drx_demod_instance *demod, enum drx_power_mode *mode)
 				goto rw_error;
 			}
 			break;
-		case DRX_STANDARD_PAL_SECAM_BG:	/* fallthrough */
-		case DRX_STANDARD_PAL_SECAM_DK:	/* fallthrough */
-		case DRX_STANDARD_PAL_SECAM_I:	/* fallthrough */
-		case DRX_STANDARD_PAL_SECAM_L:	/* fallthrough */
-		case DRX_STANDARD_PAL_SECAM_LP:	/* fallthrough */
-		case DRX_STANDARD_NTSC:	/* fallthrough */
+		case DRX_STANDARD_PAL_SECAM_BG:	__fallthrough;;
+		case DRX_STANDARD_PAL_SECAM_DK:	__fallthrough;;
+		case DRX_STANDARD_PAL_SECAM_I:	__fallthrough;;
+		case DRX_STANDARD_PAL_SECAM_L:	__fallthrough;;
+		case DRX_STANDARD_PAL_SECAM_LP:	__fallthrough;;
+		case DRX_STANDARD_NTSC:	__fallthrough;;
 		case DRX_STANDARD_FM:
 			rc = power_down_atv(demod, ext_attr->standard, true);
 			if (rc != 0) {
@@ -11127,7 +11136,7 @@ ctrl_power_mode(struct drx_demod_instance *demod, enum drx_power_mode *mode)
 		case DRX_STANDARD_UNKNOWN:
 			/* Do nothing */
 			break;
-		case DRX_STANDARD_AUTO:	/* fallthrough */
+		case DRX_STANDARD_AUTO:	__fallthrough;;
 		default:
 			return -EIO;
 		}
@@ -11220,8 +11229,8 @@ ctrl_set_cfg_pre_saw(struct drx_demod_instance *demod, struct drxj_cfg_pre_saw *
 		ext_attr->vsb_pre_saw_cfg = *pre_saw;
 		break;
 #ifndef DRXJ_VSB_ONLY
-	case DRX_STANDARD_ITU_A:	/* fallthrough */
-	case DRX_STANDARD_ITU_B:	/* fallthrough */
+	case DRX_STANDARD_ITU_A:	__fallthrough;;
+	case DRX_STANDARD_ITU_B:	__fallthrough;;
 	case DRX_STANDARD_ITU_C:
 		ext_attr->qam_pre_saw_cfg = *pre_saw;
 		break;
@@ -11264,10 +11273,10 @@ ctrl_set_cfg_afe_gain(struct drx_demod_instance *demod, struct drxj_cfg_afe_gain
 	ext_attr = (struct drxj_data *) demod->my_ext_attr;
 
 	switch (afe_gain->standard) {
-	case DRX_STANDARD_8VSB:	/* fallthrough */
+	case DRX_STANDARD_8VSB:	__fallthrough;;
 #ifndef DRXJ_VSB_ONLY
-	case DRX_STANDARD_ITU_A:	/* fallthrough */
-	case DRX_STANDARD_ITU_B:	/* fallthrough */
+	case DRX_STANDARD_ITU_A:	__fallthrough;;
+	case DRX_STANDARD_ITU_B:	__fallthrough;;
 	case DRX_STANDARD_ITU_C:
 #endif
 		/* Do nothing */
@@ -11301,8 +11310,8 @@ ctrl_set_cfg_afe_gain(struct drx_demod_instance *demod, struct drxj_cfg_afe_gain
 		ext_attr->vsb_pga_cfg = gain * 13 + 140;
 		break;
 #ifndef DRXJ_VSB_ONLY
-	case DRX_STANDARD_ITU_A:	/* fallthrough */
-	case DRX_STANDARD_ITU_B:	/* fallthrough */
+	case DRX_STANDARD_ITU_A:	__fallthrough;;
+	case DRX_STANDARD_ITU_B:	__fallthrough;;
 	case DRX_STANDARD_ITU_C:
 		ext_attr->qam_pga_cfg = gain * 13 + 140;
 		break;
diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 86652a4ef9ce..c27f13437921 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -1779,7 +1779,7 @@ static int setoperation_mode(struct drxk_state *state,
 			goto error;
 		state->m_operation_mode = OM_NONE;
 		break;
-	case OM_QAM_ITU_A:	/* fallthrough */
+	case OM_QAM_ITU_A:	__fallthrough;
 	case OM_QAM_ITU_C:
 		status = mpegts_stop(state);
 		if (status < 0)
@@ -1806,7 +1806,7 @@ static int setoperation_mode(struct drxk_state *state,
 		if (status < 0)
 			goto error;
 		break;
-	case OM_QAM_ITU_A:	/* fallthrough */
+	case OM_QAM_ITU_A:	__fallthrough;
 	case OM_QAM_ITU_C:
 		dprintk(1, ": DVB-C Annex %c\n",
 			(state->m_operation_mode == OM_QAM_ITU_A) ? 'A' : 'C');
@@ -2035,7 +2035,7 @@ static int mpegts_dto_setup(struct drxk_state *state,
 		fec_oc_rcn_ctl_rate = 0xC00000;
 		static_clk = state->m_dvbt_static_clk;
 		break;
-	case OM_QAM_ITU_A:	/* fallthrough */
+	case OM_QAM_ITU_A:	__fallthrough;
 	case OM_QAM_ITU_C:
 		fec_oc_tmd_mode = 0x0004;
 		fec_oc_rcn_ctl_rate = 0xD2B4EE;	/* good for >63 Mb/s */
diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 99c6289ae585..6d534741da5f 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -777,7 +777,7 @@ static int lgdt3306a_set_if(struct lgdt3306a_state *state,
 	default:
 		pr_warn("IF=%d KHz is not supported, 3250 assumed\n",
 			if_freq_khz);
-		/* fallthrough */
+		__fallthrough;
 	case 3250: /* 3.25Mhz */
 		nco1 = 0x34;
 		nco2 = 0x00;
diff --git a/drivers/media/pci/cx88/cx88-cards.c b/drivers/media/pci/cx88/cx88-cards.c
index 382af90fd4a9..f22a03d02f89 100644
--- a/drivers/media/pci/cx88/cx88-cards.c
+++ b/drivers/media/pci/cx88/cx88-cards.c
@@ -3465,7 +3465,7 @@ static void cx88_card_setup(struct cx88_core *core)
 		cx_clear(MO_GP0_IO, 0x00000040);
 		msleep(1000);
 		cx_set(MO_GP0_IO, 0x00004040);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_HYBRID:
diff --git a/drivers/media/pci/ddbridge/ddbridge-core.c b/drivers/media/pci/ddbridge/ddbridge-core.c
index 7a2d19682fe3..f4dac2732c90 100644
--- a/drivers/media/pci/ddbridge/ddbridge-core.c
+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
@@ -1310,7 +1310,7 @@ static void dvb_input_detach(struct ddb_input *input)
 			dvb_unregister_frontend(dvb->fe2);
 		if (dvb->fe)
 			dvb_unregister_frontend(dvb->fe);
-		/* fallthrough */
+		__fallthrough;
 	case 0x30:
 		dvb_module_release(dvb->i2c_client[0]);
 		dvb->i2c_client[0] = NULL;
@@ -1321,22 +1321,22 @@ static void dvb_input_detach(struct ddb_input *input)
 			dvb_frontend_detach(dvb->fe);
 		dvb->fe = NULL;
 		dvb->fe2 = NULL;
-		/* fallthrough */
+		__fallthrough;
 	case 0x20:
 		dvb_net_release(&dvb->dvbnet);
-		/* fallthrough */
+		__fallthrough;
 	case 0x12:
 		dvbdemux->dmx.remove_frontend(&dvbdemux->dmx,
 					      &dvb->hw_frontend);
 		dvbdemux->dmx.remove_frontend(&dvbdemux->dmx,
 					      &dvb->mem_frontend);
-		/* fallthrough */
+		__fallthrough;
 	case 0x11:
 		dvb_dmxdev_release(&dvb->dmxdev);
-		/* fallthrough */
+		__fallthrough;
 	case 0x10:
 		dvb_dmx_release(&dvb->demux);
-		/* fallthrough */
+		__fallthrough;
 	case 0x01:
 		break;
 	}
@@ -2432,7 +2432,8 @@ void ddb_ports_init(struct ddb *dev)
 					ddb_input_init(port, 4 + i, 1, 4 + i);
 					ddb_output_init(port, i);
 					break;
-				} /* fallthrough */
+				}
+				__fallthrough;
 			case DDB_OCTOPUS:
 				ddb_input_init(port, 2 * i, 0, 2 * i);
 				ddb_input_init(port, 2 * i + 1, 1, 2 * i + 1);
diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index b4f396c2e72c..bf19fd147a10 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -931,7 +931,7 @@ static int coda_start_encoding(struct coda_ctx *ctx)
 		break;
 	case CODA_960:
 		coda_write(dev, 0, CODA9_GDI_WPROT_RGN_EN);
-		/* fallthrough */
+		__fallthrough;
 	case CODA_HX4:
 	case CODA_7541:
 		coda_write(dev, CODA7_STREAM_BUF_DYNALLOC_EN |
@@ -971,7 +971,7 @@ static int coda_start_encoding(struct coda_ctx *ctx)
 				 CODA7_PICHEIGHT_MASK) << CODA_PICHEIGHT_OFFSET;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case CODA_960:
 		value = (q_data_src->rect.width & CODA7_PICWIDTH_MASK)
 			<< CODA7_PICWIDTH_OFFSET;
diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index fa0b22fb7991..132bf1f883cf 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -910,7 +910,7 @@ static int coda_g_selection(struct file *file, void *fh,
 	case V4L2_SEL_TGT_CROP_DEFAULT:
 	case V4L2_SEL_TGT_CROP_BOUNDS:
 		rsel = &r;
-		/* fallthrough */
+		__fallthrough;
 	case V4L2_SEL_TGT_CROP:
 		if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
 			return -EINVAL;
@@ -918,7 +918,7 @@ static int coda_g_selection(struct file *file, void *fh,
 	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
 	case V4L2_SEL_TGT_COMPOSE_PADDED:
 		rsel = &r;
-		/* fallthrough */
+		__fallthrough;
 	case V4L2_SEL_TGT_COMPOSE:
 	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
 		if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
@@ -2208,7 +2208,7 @@ static int coda_open(struct file *file)
 		 */
 		if (enable_bwb || ctx->inst_type == CODA_INST_ENCODER)
 			ctx->frame_mem_ctrl = CODA9_FRAME_ENABLE_BWB;
-		/* fallthrough */
+		__fallthrough;
 	case CODA_HX4:
 	case CODA_7541:
 		ctx->reg_idx = 0;
diff --git a/drivers/media/tuners/fc0011.c b/drivers/media/tuners/fc0011.c
index a983899c6b0b..4f2ab7d8d75f 100644
--- a/drivers/media/tuners/fc0011.c
+++ b/drivers/media/tuners/fc0011.c
@@ -259,7 +259,7 @@ static int fc0011_set_params(struct dvb_frontend *fe)
 		dev_warn(&priv->i2c->dev, "Unsupported bandwidth %u kHz. Using 6000 kHz.\n",
 			 bandwidth);
 		bandwidth = 6000;
-		/* fallthrough */
+		__fallthrough;
 	case 6000:
 		regs[FC11_REG_VCOSEL] |= FC11_VCOSEL_BW6M;
 		break;
diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 82daccc9ea62..93146e00ebf5 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -375,7 +375,7 @@ static int h_msb_read_page(struct memstick_dev *card,
 			serial mode), then just fall through */
 		if (msb_read_int_reg(msb, -1))
 			return 0;
-		/* fallthrough */
+		__fallthrough;
 
 	case MSB_RP_RECEIVE_INT_REQ_RESULT:
 		intreg = mrq->data[0];
@@ -407,7 +407,7 @@ static int h_msb_read_page(struct memstick_dev *card,
 	case MSB_RP_RECEIVE_STATUS_REG:
 		msb->regs.status = *(struct ms_status_register *)mrq->data;
 		msb->state = MSB_RP_SEND_OOB_READ;
-		/* fallthrough */
+		__fallthrough;
 
 	case MSB_RP_SEND_OOB_READ:
 		if (!msb_read_regs(msb,
@@ -422,7 +422,7 @@ static int h_msb_read_page(struct memstick_dev *card,
 		msb->regs.extra_data =
 			*(struct ms_extra_data_register *) mrq->data;
 		msb->state = MSB_RP_SEND_READ_DATA;
-		/* fallthrough */
+		__fallthrough;
 
 	case MSB_RP_SEND_READ_DATA:
 		/* Skip that state if we only read the oob */
@@ -522,7 +522,7 @@ static int h_msb_write_block(struct memstick_dev *card,
 		msb->state = MSB_WB_RECEIVE_INT_REQ;
 		if (msb_read_int_reg(msb, -1))
 			return 0;
-		/* fallthrough */
+		__fallthrough;
 
 	case MSB_WB_RECEIVE_INT_REQ:
 		intreg = mrq->data[0];
@@ -553,7 +553,7 @@ static int h_msb_write_block(struct memstick_dev *card,
 
 		msb->int_polling = false;
 		msb->state = MSB_WB_SEND_WRITE_DATA;
-		/* fallthrough */
+		__fallthrough;
 
 	case MSB_WB_SEND_WRITE_DATA:
 		sg_init_table(sg, ARRAY_SIZE(sg));
@@ -632,7 +632,7 @@ static int h_msb_send_command(struct memstick_dev *card,
 		msb->state = MSB_SC_RECEIVE_INT_REQ;
 		if (msb_read_int_reg(msb, -1))
 			return 0;
-		/* fallthrough */
+		__fallthrough;
 
 	case MSB_SC_RECEIVE_INT_REQ:
 		intreg = mrq->data[0];
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 26c7b63e008a..7f97703d54d9 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -270,7 +270,7 @@ static void *stuff(unsigned char *dest, const unsigned char *src, size_t n)
 		case RAVE_SP_ETX:
 		case RAVE_SP_DLE:
 			*dest++ = RAVE_SP_DLE;
-			/* FALLTHROUGH */
+			__fallthrough;
 		default:
 			*dest++ = byte;
 		}
@@ -541,7 +541,7 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
 			 * deframer buffer
 			 */
 
-			/* FALLTHROUGH */
+			__fallthrough;
 
 		case RAVE_SP_EXPECT_ESCAPED_DATA:
 			if (deframer->length == sizeof(deframer->data)) {
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 49e0daf2ef5e..fb1f4bd07751 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -313,7 +313,7 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 		 * then it's harmless for us to allow it.
 		 */
 		cmd_reg |= MMCCMD_BSYEXP;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MMC_RSP_R1:		/* 48 bits, CRC */
 		cmd_reg |= MMCCMD_RSPFMT_R1456;
 		break;
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 89cdb3d533bb..981babe445d9 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -242,7 +242,7 @@ static void dw_mci_hs_set_timing(struct dw_mci *host, int timing,
 		if (smpl_phase >= USE_DLY_MIN_SMPL &&
 				smpl_phase <= USE_DLY_MAX_SMPL)
 			use_smpl_dly = 1;
-			/* fallthrough */
+			__fallthrough;
 	case MMC_TIMING_UHS_SDR50:
 		if (smpl_phase >= ENABLE_SHIFT_MIN_SMPL &&
 				smpl_phase <= ENABLE_SHIFT_MAX_SMPL)
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 71e13844df6c..1379883f94f5 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -575,7 +575,7 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	case HOST_MODE:
 		if (host->pdata->flags & TMIO_MMC_HAVE_CBSY)
 			bit = TMIO_STAT_CMD_BUSY;
-		/* fallthrough */
+		__fallthrough;
 	case CTL_SD_CARD_CLK_CTL:
 		return renesas_sdhi_wait_idle(host, bit);
 	}
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..03cd0304e5e3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2443,7 +2443,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	case MMC_TIMING_UHS_SDR50:
 		if (host->flags & SDHCI_SDR50_NEEDS_TUNING)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	default:
 		goto out;
diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 95e54468cf7d..b62bcfc8001b 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -357,7 +357,7 @@ static void aspeed_smc_send_cmd_addr(struct spi_nor *nor, u8 cmd, u32 addr)
 	default:
 		WARN_ONCE(1, "Unexpected address width %u, defaulting to 3\n",
 			  nor->addr_width);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 3:
 		cmdaddr = addr & 0xFFFFFF;
 		cmdaddr |= cmd << 24;
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 9274dcc6e9b0..8d94d8832fb9 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1609,7 +1609,7 @@ static struct aggregator *ad_agg_selection_test(struct aggregator *best,
 		if (__agg_active_ports(curr) < __agg_active_ports(best))
 			return best;
 
-		/*FALLTHROUGH*/
+		__fallthrough;
 	case BOND_AD_STABLE:
 	case BOND_AD_BANDWIDTH:
 		if (__get_agg_bandwidth(curr) > __get_agg_bandwidth(best))
diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index d98c69045b17..3d2ffa2055b0 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -902,7 +902,7 @@ static void at91_irq_err_state(struct net_device *dev,
 				CAN_ERR_CRTL_TX_WARNING :
 				CAN_ERR_CRTL_RX_WARNING;
 		}
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+	case CAN_STATE_ERROR_WARNING:	__fallthrough;
 		/*
 		 * from: ERROR_ACTIVE, ERROR_WARNING
 		 * to  : ERROR_PASSIVE, BUS_OFF
@@ -951,7 +951,7 @@ static void at91_irq_err_state(struct net_device *dev,
 		netdev_dbg(dev, "Error Active\n");
 		cf->can_id |= CAN_ERR_PROT;
 		cf->data[2] = CAN_ERR_PROT_ACTIVE;
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+	case CAN_STATE_ERROR_WARNING:	__fallthrough;
 		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
 		reg_ier = AT91_IRQ_ERRP;
 		break;
diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index dc9c6db96c3c..ed9ba2c1ddf0 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -161,7 +161,7 @@ static void sp_populate_of(struct sja1000_priv *priv, struct device_node *of)
 		priv->read_reg = sp_read_reg16;
 		priv->write_reg = sp_write_reg16;
 		break;
-	case 1:	/* fallthrough */
+	case 1:	__fallthrough;
 	default:
 		priv->read_reg = sp_read_reg8;
 		priv->write_reg = sp_write_reg8;
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index aa97dbc797b6..3e5df89e1127 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -152,7 +152,7 @@ static void slc_bump(struct slcan *sl)
 	switch (*cmd) {
 	case 'r':
 		cf.can_id = CAN_RTR_FLAG;
-		/* fallthrough */
+		__fallthrough;
 	case 't':
 		/* store dlc ASCII value and terminate SFF CAN ID string */
 		cf.can_dlc = sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
@@ -162,7 +162,7 @@ static void slc_bump(struct slcan *sl)
 		break;
 	case 'R':
 		cf.can_id = CAN_RTR_FLAG;
-		/* fallthrough */
+		__fallthrough;
 	case 'T':
 		cf.can_id |= CAN_EFF_FLAG;
 		/* store dlc ASCII value and terminate EFF CAN ID string */
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index e90817608645..66cded750244 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -875,7 +875,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 			if (new_state >= CAN_STATE_ERROR_WARNING &&
 			    new_state <= CAN_STATE_BUS_OFF)
 				priv->can.can_stats.error_warning++;
-		case CAN_STATE_ERROR_WARNING:	/* fallthrough */
+		case CAN_STATE_ERROR_WARNING:	__fallthrough;
 			if (new_state >= CAN_STATE_ERROR_PASSIVE &&
 			    new_state <= CAN_STATE_BUS_OFF)
 				priv->can.can_stats.error_passive++;
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 0852e5e08177..3ebc5c603c50 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1015,7 +1015,7 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 	switch (speed) {
 	case 2000:
 		reg |= PORT_OVERRIDE_SPEED_2000M;
-		/* fallthrough */
+		__fallthrough;
 	case SPEED_1000:
 		reg |= PORT_OVERRIDE_SPEED_1000M;
 		break;
diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index 629bf14128a2..b678fb611646 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -170,7 +170,7 @@ void b53_serdes_phylink_validate(struct b53_device *dev, int port,
 	switch (lane) {
 	case 0:
 		phylink_set(supported, 2500baseX_Full);
-		/* fallthrough */
+		__fallthrough;
 	case 1:
 		phylink_set(supported, 1000baseX_Full);
 		break;
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index c8e3f05e1d72..1b6ff17b9c50 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -538,7 +538,7 @@ static void bcm_sf2_sw_mac_config(struct dsa_switch *ds, int port,
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		id_mode_dis = 1;
-		/* fallthrough */
+		__fallthrough;
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		port_mode = EXT_GPHY;
 		break;
diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 16477aa6d61f..24615e37746f 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1727,13 +1727,13 @@ static bool slic_is_fiber(unsigned short subdev)
 {
 	switch (subdev) {
 	/* Mojave */
-	case PCI_SUBDEVICE_ID_ALACRITECH_1000X1F: /* fallthrough */
-	case PCI_SUBDEVICE_ID_ALACRITECH_SES1001F: /* fallthrough */
+	case PCI_SUBDEVICE_ID_ALACRITECH_1000X1F: __fallthrough;
+	case PCI_SUBDEVICE_ID_ALACRITECH_SES1001F: __fallthrough;
 	/* Oasis */
-	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2002XF: /* fallthrough */
-	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2001XF: /* fallthrough */
-	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2104EF: /* fallthrough */
-	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2102EF: /* fallthrough */
+	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2002XF: __fallthrough;
+	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2001XF: __fallthrough;
+	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2104EF: __fallthrough;
+	case PCI_SUBDEVICE_ID_ALACRITECH_SEN2102EF: __fallthrough;
 		return true;
 	}
 	return false;
diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
index 6fe074c1588b..51fb023392a9 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -217,7 +217,7 @@ static int bgmac_probe(struct bcma_device *core)
 	/* BCM 471X/535X family */
 	case BCMA_CHIP_ID_BCM4716:
 		bgmac->feature_flags |= BGMAC_FEAT_CLKCTLST;
-		/* fallthrough */
+		__fallthrough;
 	case BCMA_CHIP_ID_BCM47162:
 		bgmac->feature_flags |= BGMAC_FEAT_FLW_CTRL2;
 		bgmac->feature_flags |= BGMAC_FEAT_SET_RXQ_CLK;
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 328373e0578f..dc29d7f267f9 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17147,7 +17147,7 @@ static u32 tg3_calc_dma_bndry(struct tg3 *tp, u32 val)
 				val |= DMA_RWCTRL_WRITE_BNDRY_64_PCIE;
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case 128:
 		default:
 			val &= ~DMA_RWCTRL_WRITE_BNDRY_DISAB_PCIE;
@@ -17162,28 +17162,28 @@ static u32 tg3_calc_dma_bndry(struct tg3 *tp, u32 val)
 					DMA_RWCTRL_WRITE_BNDRY_16);
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case 32:
 			if (goal == BOUNDARY_SINGLE_CACHELINE) {
 				val |= (DMA_RWCTRL_READ_BNDRY_32 |
 					DMA_RWCTRL_WRITE_BNDRY_32);
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case 64:
 			if (goal == BOUNDARY_SINGLE_CACHELINE) {
 				val |= (DMA_RWCTRL_READ_BNDRY_64 |
 					DMA_RWCTRL_WRITE_BNDRY_64);
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case 128:
 			if (goal == BOUNDARY_SINGLE_CACHELINE) {
 				val |= (DMA_RWCTRL_READ_BNDRY_128 |
 					DMA_RWCTRL_WRITE_BNDRY_128);
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case 256:
 			val |= (DMA_RWCTRL_READ_BNDRY_256 |
 				DMA_RWCTRL_WRITE_BNDRY_256);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index fb6f813cff65..698d74aedea9 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -999,15 +999,15 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 
 		schedule_timeout_uninterruptible(HZ / 10);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_HOST_OK:
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_CONSOLE_INIT_DONE:
 		/* Remove any consoles */
 		octeon_remove_consoles(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_IO_QUEUES_DONE:
 		if (lio_wait_for_instr_fetch(oct))
 			dev_err(&oct->pci_dev->dev, "IQ had pending instructions\n");
@@ -1049,7 +1049,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		octeon_free_sc_done_list(oct);
 		octeon_free_sc_zombie_list(oct);
 
-	/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_INTR_SET_DONE:
 		/* Disable interrupts  */
 		oct->fn_list.disable_interrupt(oct, OCTEON_ALL_INTR);
@@ -1084,17 +1084,17 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		kfree(oct->irq_name_storage);
 		oct->irq_name_storage = NULL;
 
-	/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_MSIX_ALLOC_VECTOR_DONE:
 		if (OCTEON_CN23XX_PF(oct))
 			octeon_free_ioq_vector(oct);
 
-	/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_MBOX_SETUP_DONE:
 		if (OCTEON_CN23XX_PF(oct))
 			oct->fn_list.free_mbox(oct);
 
-	/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_IN_RESET:
 	case OCT_DEV_DROQ_INIT_DONE:
 		/* Wait for any pending operations */
@@ -1117,11 +1117,11 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			}
 		}
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_RESP_LIST_INIT_DONE:
 		octeon_delete_response_list(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_INSTR_QUEUE_INIT_DONE:
 		for (i = 0; i < MAX_OCTEON_INSTR_QUEUES(oct); i++) {
 			if (!(oct->io_qmask.iq & BIT_ULL(i)))
@@ -1132,16 +1132,16 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		if (oct->sriov_info.sriov_enabled)
 			pci_disable_sriov(oct->pci_dev);
 #endif
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_SC_BUFF_POOL_INIT_DONE:
 		octeon_free_sc_buffer_pool(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_DISPATCH_INIT_DONE:
 		octeon_delete_dispatch_list(oct);
 		cancel_delayed_work_sync(&oct->nic_poll_work.work);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_PCI_MAP_DONE:
 		refcount = octeon_deregister_device(oct);
 
@@ -1159,13 +1159,13 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		octeon_unmap_pci_barx(oct, 0);
 		octeon_unmap_pci_barx(oct, 1);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_PCI_ENABLE_DONE:
 		pci_clear_master(oct->pci_dev);
 		/* Disable the device, releasing the PCI INT */
 		pci_disable_device(oct->pci_dev);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_BEGIN_STATE:
 		/* Nothing to be done here either */
 		break;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 54b245797d2e..88af627d2e55 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -461,9 +461,9 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 
 		schedule_timeout_uninterruptible(HZ / 10);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_HOST_OK:
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_IO_QUEUES_DONE:
 		if (lio_wait_for_instr_fetch(oct))
 			dev_err(&oct->pci_dev->dev, "IQ had pending instructions\n");
@@ -534,15 +534,15 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		else
 			cn23xx_vf_ask_pf_to_do_flr(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_MSIX_ALLOC_VECTOR_DONE:
 		octeon_free_ioq_vector(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_MBOX_SETUP_DONE:
 		oct->fn_list.free_mbox(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_IN_RESET:
 	case OCT_DEV_DROQ_INIT_DONE:
 		mdelay(100);
@@ -552,11 +552,11 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			octeon_delete_droq(oct, i);
 		}
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_RESP_LIST_INIT_DONE:
 		octeon_delete_response_list(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_INSTR_QUEUE_INIT_DONE:
 		for (i = 0; i < MAX_OCTEON_INSTR_QUEUES(oct); i++) {
 			if (!(oct->io_qmask.iq & BIT_ULL(i)))
@@ -564,27 +564,27 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 			octeon_delete_instr_queue(oct, i);
 		}
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_SC_BUFF_POOL_INIT_DONE:
 		octeon_free_sc_buffer_pool(oct);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_DISPATCH_INIT_DONE:
 		octeon_delete_dispatch_list(oct);
 		cancel_delayed_work_sync(&oct->nic_poll_work.work);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_PCI_MAP_DONE:
 		octeon_unmap_pci_barx(oct, 0);
 		octeon_unmap_pci_barx(oct, 1);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_PCI_ENABLE_DONE:
 		pci_clear_master(oct->pci_dev);
 		/* Disable the device, releasing the PCI INT */
 		pci_disable_device(oct->pci_dev);
 
-		/* fallthrough */
+		__fallthrough;
 	case OCT_DEV_BEGIN_STATE:
 		/* Nothing to be done here either */
 		break;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index adc4d481815b..51bc118ac844 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -518,7 +518,7 @@ static int fwevtq_handler(struct sge_rspq *rspq, const __be64 *rsp,
 			break;
 		}
 		cpl = (void *)p;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	}
 
 	case CPL_SGE_EGR_UPDATE: {
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 41c6fa200e74..abe9cf44c204 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -528,7 +528,7 @@ static void setup_sgmii_internal_phy(struct fman_mac *memac,
 		case 100:
 			tmp_reg16 |= IF_MODE_SGMII_SPEED_100M;
 		break;
-		case 1000: /* fallthrough */
+		case 1000: __fallthrough;
 		default:
 			tmp_reg16 |= IF_MODE_SGMII_SPEED_1G;
 		break;
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index eb3e65e8868f..6e6616aa9453 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1352,7 +1352,7 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 		switch (ugeth->max_speed) {
 		case SPEED_10:
 			upsmr |= UCC_GETH_UPSMR_R10M;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case SPEED_100:
 			if (ugeth->phy_interface != PHY_INTERFACE_MODE_RTBI)
 				upsmr |= UCC_GETH_UPSMR_RMM;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index acba067cc15a..d7305fb47fe5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2509,11 +2509,11 @@ static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
 	switch (cmd->flow_type) {
 	case TCP_V4_FLOW:
 		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-		/* fallthrough */
+		__fallthrough;
 	case UDP_V4_FLOW:
 		if (adapter->flags2 & IXGBE_FLAG2_RSS_FIELD_IPV4_UDP)
 			cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-		/* fallthrough */
+		__fallthrough;
 	case SCTP_V4_FLOW:
 	case AH_ESP_V4_FLOW:
 	case AH_V4_FLOW:
@@ -2523,11 +2523,11 @@ static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
 		break;
 	case TCP_V6_FLOW:
 		cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-		/* fallthrough */
+		__fallthrough;
 	case UDP_V6_FLOW:
 		if (adapter->flags2 & IXGBE_FLAG2_RSS_FIELD_IPV6_UDP)
 			cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-		/* fallthrough */
+		__fallthrough;
 	case SCTP_V6_FLOW:
 	case AH_ESP_V6_FLOW:
 	case AH_V6_FLOW:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e100054a3765..88ff968d66dc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2228,7 +2228,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
-		/* fallthrough */
+		__fallthrough;
 	case XDP_ABORTED:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		/* fallthrough -- handle aborts by dropping packet */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index d81a50dc9535..8eebe12d37de 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1131,7 +1131,7 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 			cc.mult = 3;
 			cc.shift = 2;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
 		cc.read = ixgbe_ptp_read_X550;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index bfe95ce0bd7f..eded09edcc30 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -219,7 +219,7 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
-		/* fallthrough */
+		__fallthrough;
 	case XDP_ABORTED:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		/* fallthrough -- handle aborts by dropping packet */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 49e23afa05a2..fcbe4adde1c8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1080,7 +1080,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(act);
-		/* fallthrough */
+		__fallthrough;
 	case XDP_ABORTED:
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		/* fallthrough -- handle aborts by dropping packet */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index a0987cc5fe4a..be74cad7ae0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -228,7 +228,7 @@ int mlx5e_ethtool_get_sset_count(struct mlx5e_priv *priv, int sset)
 		return MLX5E_NUM_PFLAGS;
 	case ETH_SS_TEST:
 		return mlx5e_self_test_num(priv);
-	/* fallthrough */
+	__fallthrough;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/netronome/nfp/flower/action.c b/drivers/net/ethernet/netronome/nfp/flower/action.c
index eeda4ed98333..ba0f1d35410b 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -166,7 +166,7 @@ nfp_fl_get_tun_from_act_l4_port(struct nfp_app *app,
 	case htons(NFP_FL_GENEVE_PORT):
 		if (priv->flower_ext_feats & NFP_FL_FEATS_GENEVE)
 			return NFP_FL_TUNNEL_GENEVE;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		return NFP_FL_TUNNEL_NONE;
 	}
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index 85d46f206b3c..53afaea9e4fb 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -340,12 +340,12 @@ static int matching_bar(struct nfp_bar *bar, u32 tgt, u32 act, u32 tok,
 	switch (maptype) {
 	case NFP_PCIE_BAR_PCIE2CPP_MapType_TARGET:
 		bartok = -1;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case NFP_PCIE_BAR_PCIE2CPP_MapType_BULK:
 		baract = NFP_CPP_ACTION_RW;
 		if (act == 0)
 			act = NFP_CPP_ACTION_RW;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case NFP_PCIE_BAR_PCIE2CPP_MapType_FIXED:
 		break;
 	default:
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index e888b479c596..da276c986c8d 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -4096,7 +4096,7 @@ efx_ef10_filter_push_prep_set_match_fields(struct efx_nic *efx,
 		switch (encap_type & EFX_ENCAP_TYPES_MASK) {
 		case EFX_ENCAP_TYPE_VXLAN:
 			vni_type = MC_CMD_FILTER_OP_EXT_IN_VNI_TYPE_VXLAN;
-			/* fallthrough */
+			__fallthrough;
 		case EFX_ENCAP_TYPE_GENEVE:
 			COPY_VALUE(ether_type, ETHER_TYPE);
 			outer_ip_proto = IPPROTO_UDP;
diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index fec275e2208d..b06a0df46bbf 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -74,7 +74,7 @@ static void cpsw_gmii_sel_am3352(struct cpsw_phy_sel_priv *priv,
 		dev_warn(priv->dev,
 			 "Unsupported PHY mode: \"%s\". Defaulting to MII.\n",
 			phy_modes(phy_mode));
-		/* fallthrough */
+		__fallthrough;
 	case PHY_INTERFACE_MODE_MII:
 		mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
@@ -129,7 +129,7 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_phy_sel_priv *priv,
 		dev_warn(priv->dev,
 			 "Unsupported PHY mode: \"%s\". Defaulting to MII.\n",
 			phy_modes(phy_mode));
-		/* fallthrough */
+		__fallthrough;
 	case PHY_INTERFACE_MODE_MII:
 		mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 23417266b7ec..56ca410ae84b 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -1411,9 +1411,9 @@ spider_net_handle_error_irq(struct spider_net_card *card, u32 status_reg,
 		show_error = 0;
 		break;
 
-	case SPIDER_NET_GDDDEN0INT: /* fallthrough */
-	case SPIDER_NET_GDCDEN0INT: /* fallthrough */
-	case SPIDER_NET_GDBDEN0INT: /* fallthrough */
+	case SPIDER_NET_GDDDEN0INT: __fallthrough;
+	case SPIDER_NET_GDCDEN0INT: __fallthrough;
+	case SPIDER_NET_GDBDEN0INT: __fallthrough;
 	case SPIDER_NET_GDADEN0INT:
 		/* someone has set RX_DMA_EN to 0 */
 		show_error = 0;
@@ -1463,10 +1463,10 @@ spider_net_handle_error_irq(struct spider_net_card *card, u32 status_reg,
 		 * Logging is not needed. */
 		show_error = 0;
 		break;
-	case SPIDER_NET_GRFDFLLINT: /* fallthrough */
-	case SPIDER_NET_GRFCFLLINT: /* fallthrough */
-	case SPIDER_NET_GRFBFLLINT: /* fallthrough */
-	case SPIDER_NET_GRFAFLLINT: /* fallthrough */
+	case SPIDER_NET_GRFDFLLINT: __fallthrough;
+	case SPIDER_NET_GRFCFLLINT: __fallthrough;
+	case SPIDER_NET_GRFBFLLINT: __fallthrough;
+	case SPIDER_NET_GRFAFLLINT: __fallthrough;
 	case SPIDER_NET_GRMFLLINT:
 		/* Could happen when rx chain is full */
 		if (card->ignore_rx_ramfull == 0) {
@@ -1487,9 +1487,9 @@ spider_net_handle_error_irq(struct spider_net_card *card, u32 status_reg,
 		break;
 
 	/* chain end */
-	case SPIDER_NET_GDDDCEINT: /* fallthrough */
-	case SPIDER_NET_GDCDCEINT: /* fallthrough */
-	case SPIDER_NET_GDBDCEINT: /* fallthrough */
+	case SPIDER_NET_GDDDCEINT: __fallthrough;
+	case SPIDER_NET_GDCDCEINT: __fallthrough;
+	case SPIDER_NET_GDBDCEINT: __fallthrough;
 	case SPIDER_NET_GDADCEINT:
 		spider_net_resync_head_ptr(card);
 		spider_net_refill_rx_chain(card);
@@ -1500,9 +1500,9 @@ spider_net_handle_error_irq(struct spider_net_card *card, u32 status_reg,
 		break;
 
 	/* invalid descriptor */
-	case SPIDER_NET_GDDINVDINT: /* fallthrough */
-	case SPIDER_NET_GDCINVDINT: /* fallthrough */
-	case SPIDER_NET_GDBINVDINT: /* fallthrough */
+	case SPIDER_NET_GDDINVDINT: __fallthrough;
+	case SPIDER_NET_GDCINVDINT: __fallthrough;
+	case SPIDER_NET_GDBINVDINT: __fallthrough;
 	case SPIDER_NET_GDAINVDINT:
 		/* Could happen when rx chain is full */
 		spider_net_resync_head_ptr(card);
diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index fef701bfad62..6dae22e8d9e2 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -73,7 +73,7 @@ int sfp_parse_port(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 			port = PORT_TP;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case SFP_CONNECTOR_SG: /* guess */
 	case SFP_CONNECTOR_MPO_1X12:
 	case SFP_CONNECTOR_MPO_2X16:
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index d4635c2178d1..835c285cab70 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1505,7 +1505,7 @@ static void sfp_sm_event(struct sfp *sfp, unsigned int event)
 			sfp_sm_ins_next(sfp, SFP_MOD_PRESENT, 0);
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case SFP_MOD_PRESENT:
 	case SFP_MOD_ERROR:
 		if (event == SFP_E_REMOVE) {
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 3d92ea6fcc02..573bb25c7794 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2896,7 +2896,7 @@ lan78xx_get_endpoints(struct lan78xx_net *dev, struct usb_interface *intf)
 				if (!usb_endpoint_dir_in(&e->desc))
 					continue;
 				intr = 1;
-				/* FALLTHROUGH */
+				__fallthrough;
 			case USB_ENDPOINT_XFER_BULK:
 				break;
 			default:
@@ -3275,7 +3275,7 @@ static void rx_complete(struct urb *urb)
 	case -EPIPE:
 		dev->net->stats.rx_errors++;
 		lan78xx_defer_kevent(dev, EVENT_RX_HALT);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case -ECONNRESET:				/* async unlink */
 	case -ESHUTDOWN:				/* hardware gone */
 		netif_dbg(dev, ifdown, dev->net,
@@ -3296,7 +3296,7 @@ static void rx_complete(struct urb *urb)
 	/* data overrun ... flush fifo? */
 	case -EOVERFLOW:
 		dev->net->stats.rx_over_errors++;
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	default:
 		state = rx_cleanup;
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 504282af27e5..6633ee038f42 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -117,7 +117,7 @@ int usbnet_get_endpoints(struct usbnet *dev, struct usb_interface *intf)
 				if (!usb_endpoint_dir_in(&e->desc))
 					continue;
 				intr = 1;
-				/* FALLTHROUGH */
+				__fallthrough;
 			case USB_ENDPOINT_XFER_BULK:
 				break;
 			default:
diff --git a/drivers/net/wimax/i2400m/usb.c b/drivers/net/wimax/i2400m/usb.c
index 73842a830645..88cdbc9af3c6 100644
--- a/drivers/net/wimax/i2400m/usb.c
+++ b/drivers/net/wimax/i2400m/usb.c
@@ -204,7 +204,7 @@ int __i2400mu_send_barker(struct i2400mu *i2400mu,
 			dev_err(dev, "E: %s: too many stalls in "
 				"URB; resetting device\n", __func__);
 			usb_queue_reset_device(i2400mu->usb_iface);
-			/* fallthrough */
+			__fallthrough;
 		} else {
 			usb_clear_halt(i2400mu->usb_dev, pipe);
 			msleep(10);	/* give the device some time */
diff --git a/drivers/net/wireless/ath/ath5k/reset.c b/drivers/net/wireless/ath/ath5k/reset.c
index 56d7925a0c2c..9ec653a06511 100644
--- a/drivers/net/wireless/ath/ath5k/reset.c
+++ b/drivers/net/wireless/ath/ath5k/reset.c
@@ -522,7 +522,7 @@ ath5k_hw_set_power_mode(struct ath5k_hw *ah, enum ath5k_power_mode mode,
 	switch (mode) {
 	case AR5K_PM_AUTO:
 		staid &= ~AR5K_STA_ID1_DEFAULT_ANTENNA;
-		/* fallthrough */
+		__fallthrough;
 	case AR5K_PM_NETWORK_SLEEP:
 		if (set_chip)
 			ath5k_hw_reg_write(ah,
diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index b34e51933257..138c960e7083 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1379,7 +1379,7 @@ static struct b43_dmaring *select_ring_by_priority(struct b43_wldev *dev,
 		switch (queue_prio) {
 		default:
 			B43_WARN_ON(1);
-			/* fallthrough */
+			__fallthrough;
 		case 0:
 			ring = dev->dma.tx_ring_AC_VO;
 			break;
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 74be3c809225..5b08554bb8bd 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -1891,7 +1891,7 @@ static void b43_handle_firmware_panic(struct b43_wldev *dev)
 	switch (reason) {
 	default:
 		b43dbg(dev->wl, "The panic reason is unknown.\n");
-		/* fallthrough */
+		__fallthrough;
 	case B43_FWPANIC_DIE:
 		/* Do not restart the controller or firmware.
 		 * The device is nonfunctional from now on.
@@ -2286,7 +2286,7 @@ int b43_do_request_fw(struct b43_request_fw_context *ctx,
 		size = be32_to_cpu(hdr->size);
 		if (size != ctx->blob->size - sizeof(struct b43_fw_header))
 			goto err_format;
-		/* fallthrough */
+		__fallthrough;
 	case B43_FW_TYPE_IV:
 		if (hdr->ver != 1)
 			goto err_format;
@@ -3203,7 +3203,7 @@ static void b43_rate_memory_init(struct b43_wldev *dev)
 		b43_rate_memory_write(dev, B43_OFDM_RATE_36MB, 1);
 		b43_rate_memory_write(dev, B43_OFDM_RATE_48MB, 1);
 		b43_rate_memory_write(dev, B43_OFDM_RATE_54MB, 1);
-		/* fallthrough */
+		__fallthrough;
 	case B43_PHYTYPE_B:
 		b43_rate_memory_write(dev, B43_CCK_RATE_1MB, 0);
 		b43_rate_memory_write(dev, B43_CCK_RATE_2MB, 0);
diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless/broadcom/b43/pio.c
index a4ff5e2a42b9..7a96a7e68db7 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -307,7 +307,7 @@ static struct b43_pio_txqueue *select_queue_by_priority(struct b43_wldev *dev,
 		switch (queue_prio) {
 		default:
 			B43_WARN_ON(1);
-			/* fallthrough */
+			__fallthrough;
 		case 0:
 			q = dev->pio.tx_queue_AC_VO;
 			break;
diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index 2ce1537d983c..2eb9ff5bfb23 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -202,7 +202,7 @@ return dev->dma.tx_ring1;
 	switch (queue_priority) {
 	default:
 		B43legacy_WARN_ON(1);
-		/* fallthrough */
+		__fallthrough;
 	case 0:
 		ring = dev->dma.tx_ring3;
 		break;
diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index 55f411925960..758d5a22e15f 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -1568,7 +1568,7 @@ static int do_request_fw(struct b43legacy_wldev *dev,
 		size = be32_to_cpu(hdr->size);
 		if (size != (*fw)->size - sizeof(struct b43legacy_fw_header))
 			goto err_format;
-		/* fallthrough */
+		__fallthrough;
 	case B43legacy_FW_TYPE_IV:
 		if (hdr->ver != 1)
 			goto err_format;
@@ -2107,7 +2107,7 @@ static void b43legacy_rate_memory_init(struct b43legacy_wldev *dev)
 		b43legacy_rate_memory_write(dev, B43legacy_OFDM_RATE_36MB, 1);
 		b43legacy_rate_memory_write(dev, B43legacy_OFDM_RATE_48MB, 1);
 		b43legacy_rate_memory_write(dev, B43legacy_OFDM_RATE_54MB, 1);
-		/* fallthrough */
+		__fallthrough;
 	case B43legacy_PHYTYPE_B:
 		b43legacy_rate_memory_write(dev, B43legacy_CCK_RATE_1MB, 0);
 		b43legacy_rate_memory_write(dev, B43legacy_CCK_RATE_2MB, 0);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index a03b5284a050..51d708fca448 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -2683,10 +2683,10 @@ static void rt2800_config_channel_rf3053(struct rt2x00_dev *rt2x00dev,
 	switch (rt2x00dev->default_ant.tx_chain_num) {
 	case 3:
 		rt2x00_set_field8(&rfcsr, RFCSR1_TX2_PD, 1);
-		/* fallthrough */
+		__fallthrough;
 	case 2:
 		rt2x00_set_field8(&rfcsr, RFCSR1_TX1_PD, 1);
-		/* fallthrough */
+		__fallthrough;
 	case 1:
 		rt2x00_set_field8(&rfcsr, RFCSR1_TX0_PD, 1);
 		break;
@@ -2695,10 +2695,10 @@ static void rt2800_config_channel_rf3053(struct rt2x00_dev *rt2x00dev,
 	switch (rt2x00dev->default_ant.rx_chain_num) {
 	case 3:
 		rt2x00_set_field8(&rfcsr, RFCSR1_RX2_PD, 1);
-		/* fallthrough */
+		__fallthrough;
 	case 2:
 		rt2x00_set_field8(&rfcsr, RFCSR1_RX1_PD, 1);
-		/* fallthrough */
+		__fallthrough;
 	case 1:
 		rt2x00_set_field8(&rfcsr, RFCSR1_RX0_PD, 1);
 		break;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
index ddb88cfeace2..948e2f1e06e2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800mmio.c
@@ -586,7 +586,7 @@ void rt2800mmio_queue_init(struct data_queue *queue)
 		break;
 
 	case QID_ATIM:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		BUG();
 		break;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index 19eabf16147b..1f69c6094e2d 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -761,7 +761,7 @@ static void rt2800usb_queue_init(struct data_queue *queue)
 		break;
 
 	case QID_ATIM:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		BUG();
 		break;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index 52b9fc480f8b..b6f5c72d0a16 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2964,7 +2964,7 @@ static void rt61pci_queue_init(struct data_queue *queue)
 		break;
 
 	case QID_ATIM:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		BUG();
 		break;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt73usb.c b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
index 319ec4f2d9d2..8f4928f62a32 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt73usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt73usb.c
@@ -2384,7 +2384,7 @@ static void rt73usb_queue_init(struct data_queue *queue)
 		break;
 
 	case QID_ATIM:
-		/* fallthrough */
+		__fallthrough;
 	default:
 		BUG();
 		break;
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index eee5cc1a9220..c1f198e09178 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1156,7 +1156,7 @@ static int trf7970a_switch_rf(struct nfc_digital_dev *ddev, bool on)
 			dev_err(trf->dev, "%s - Invalid request: %d %d\n",
 				__func__, trf->state, on);
 			ret = -EINVAL;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case TRF7970A_ST_IDLE:
 		case TRF7970A_ST_IDLE_RX_BLOCKED:
 		case TRF7970A_ST_WAIT_FOR_RX_DATA:
@@ -1963,7 +1963,7 @@ static void trf7970a_shutdown(struct trf7970a *trf)
 	case TRF7970A_ST_WAIT_TO_ISSUE_EOF:
 	case TRF7970A_ST_LISTENING:
 		trf7970a_send_err_upstream(trf, -ECANCELED);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case TRF7970A_ST_IDLE:
 	case TRF7970A_ST_IDLE_RX_BLOCKED:
 		trf7970a_switch_rf_off(trf);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 208ee518af65..3d358fb60e36 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -794,7 +794,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 	case TCP_LAST_ACK:
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
-		/* fallthrough */
+		__fallthrough;
 		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 		break;
 	default:
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ef893addf341..c82d068a57de 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1468,7 +1468,7 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_REJECTED:
 		pr_debug("Connection rejected: %s\n",
 			 rdma_reject_msg(cm_id, event->status));
-		/* FALLTHROUGH */
+		__fallthrough;
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 		nvmet_rdma_queue_connect_fail(cm_id, queue);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3d627f94a166..6d10b3cbb03f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -444,7 +444,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
-	case IMX6QP:		/* FALLTHROUGH */
+	case IMX6QP:		__fallthrough;
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -653,7 +653,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 08dd62b5cebe..d68be2bf6e42 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -359,7 +359,7 @@ static int pm8xxx_pin_config_set(struct pinctrl_dev *pctldev,
 				return -EINVAL;
 			}
 			pin->pull_up_strength = arg;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case PIN_CONFIG_BIAS_PULL_UP:
 			pin->bias = pin->pull_up_strength;
 			banks |= BIT(2);
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 726341f2b638..93942b116122 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4096,7 +4096,7 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 		 * AC status changed; can be triggered by plugging or
 		 * unplugging AC adapter, docking or undocking. */
 
-		/* fallthrough */
+		__fallthrough;
 
 	case TP_HKEY_EV_KEY_NUMLOCK:
 	case TP_HKEY_EV_KEY_FN:
@@ -6249,7 +6249,7 @@ static int thermal_get_sensor(int idx, s32 *value)
 			t = TP_EC_THERMAL_TMP8;
 			idx -= 8;
 		}
-		/* fallthrough */
+		__fallthrough;
 #endif
 	case TPACPI_THERMAL_TPEC_8:
 		if (idx <= 7) {
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index aed76e33a0a9..fd47928206c5 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -217,7 +217,7 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
 
 	switch (id) {
 	case IMX8MQ_RESET_PCIEPHY:
-	case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
+	case IMX8MQ_RESET_PCIEPHY2: __fallthrough;
 		/*
 		 * wait for more than 10us to release phy g_rst and
 		 * btnrst
@@ -227,12 +227,12 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
-	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
-	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
+	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	__fallthrough;
+	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	__fallthrough;
+	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	__fallthrough;
+	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	__fallthrough;
+	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	__fallthrough;
+	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	__fallthrough;
 		value = assert ? 0 : bit;
 		break;
 	}
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index f46c787733e8..01aaba558bd1 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -532,7 +532,7 @@ static void qcom_glink_receive_version(struct qcom_glink *glink,
 		break;
 	case GLINK_VERSION_1:
 		glink->features &= features;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		qcom_glink_send_version_ack(glink);
 		break;
@@ -563,7 +563,7 @@ static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
 			break;
 
 		glink->features &= features;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		qcom_glink_send_version(glink);
 		break;
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 38a2e9e684df..dcd315daf814 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -535,7 +535,7 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
 		wdt_margin = new_margin;
 		ds1374_wdt_settimeout(new_margin);
 		ds1374_wdt_ping();
-		/* fallthrough */
+		__fallthrough;
 	case WDIOC_GETTIMEOUT:
 		/* when returning ... inverse is true */
 		return put_user((wdt_margin >> 12), (int __user *)arg);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index ba261210c6da..2cce6f0767b1 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -379,7 +379,7 @@ static enum ap_wait ap_sm_setirq_wait(struct ap_queue *aq)
 	case AP_RESPONSE_NORMAL:
 		if (aq->queue_count > 0)
 			return AP_WAIT_AGAIN;
-		/* fallthrough */
+		__fallthrough;
 	case AP_RESPONSE_NO_PENDING_REPLY:
 		return AP_WAIT_TIMEOUT;
 	default:
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 197b0f5b63e7..d43ec9a0e0fa 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2606,7 +2606,7 @@ void qeth_print_status_message(struct qeth_card *card)
 				card->info.mcl_level[3]);
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case QETH_CARD_TYPE_IQD:
 		if ((card->info.guestlan) ||
 		    (card->info.mcl_level[0] & 0x80)) {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8efb2e8ff8f4..597d09ba6345 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1839,7 +1839,7 @@ static int qeth_l2_vnicc_request(struct qeth_card *card,
 		break;
 	case IPA_VNICC_SET_TIMEOUT:
 		req->getset_timeout.timeout = cbctl->param.timeout;
-		/* fallthrough */
+		__fallthrough;
 	case IPA_VNICC_GET_TIMEOUT:
 		req->sub_hdr.data_length += sizeof(req->getset_timeout);
 		req->getset_timeout.vnic_char = cbctl->param.vnic_char;
diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 7e5044bf05c0..9391e92cdade 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -3817,7 +3817,7 @@ ahd_validate_width(struct ahd_softc *ahd, struct ahd_initiator_tinfo *tinfo,
 			*bus_width = MSG_EXT_WDTR_BUS_16_BIT;
 			break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MSG_EXT_WDTR_BUS_8_BIT:
 		*bus_width = MSG_EXT_WDTR_BUS_8_BIT;
 		break;
@@ -5132,7 +5132,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 		break;
 	case MSG_MESSAGE_REJECT:
 		response = ahd_handle_msg_reject(ahd, devinfo);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MSG_NOOP:
 		done = MSGLOOP_MSGCOMPLETE;
 		break;
@@ -5482,7 +5482,7 @@ ahd_parse_msg(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
 			       ahd_name(ahd), ahd_inb(ahd, SCSISIGI));
 #endif
 		ahd->msg_flags |= MSG_FLAG_EXPECT_QASREJ_BUSFREE;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MSG_TERM_IO_PROC:
 	default:
 		reject = TRUE;
@@ -6152,17 +6152,17 @@ ahd_free(struct ahd_softc *ahd)
 	default:
 	case 5:
 		ahd_shutdown(ahd);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 4:
 		ahd_dmamap_unload(ahd, ahd->shared_data_dmat,
 				  ahd->shared_data_map.dmamap);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 3:
 		ahd_dmamem_free(ahd, ahd->shared_data_dmat, ahd->qoutfifo,
 				ahd->shared_data_map.dmamap);
 		ahd_dmamap_destroy(ahd, ahd->shared_data_dmat,
 				   ahd->shared_data_map.dmamap);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 2:
 		ahd_dma_tag_destroy(ahd, ahd->shared_data_dmat);
 	case 1:
@@ -6582,7 +6582,7 @@ ahd_fini_scbdata(struct ahd_softc *ahd)
 			kfree(hscb_map);
 		}
 		ahd_dma_tag_destroy(ahd, scb_data->hscb_dmat);
-		/* FALLTHROUGH */
+		__fallthrough;
 	}
 	case 4:
 	case 3:
@@ -8215,12 +8215,12 @@ ahd_search_qinfifo(struct ahd_softc *ahd, int target, char channel,
 				if ((scb->flags & SCB_ACTIVE) == 0)
 					printk("Inactive SCB in qinfifo\n");
 				ahd_done_with_status(ahd, scb, status);
-				/* FALLTHROUGH */
+				__fallthrough;
 			case SEARCH_REMOVE:
 				break;
 			case SEARCH_PRINT:
 				printk(" 0x%x", ahd->qinfifo[qinpos]);
-				/* FALLTHROUGH */
+				__fallthrough;
 			case SEARCH_COUNT:
 				ahd_qinfifo_requeue(ahd, prev_scb, scb);
 				prev_scb = scb;
@@ -8311,7 +8311,7 @@ ahd_search_qinfifo(struct ahd_softc *ahd, int target, char channel,
 				if ((mk_msg_scb->flags & SCB_ACTIVE) == 0)
 					printk("Inactive SCB pending MK_MSG\n");
 				ahd_done_with_status(ahd, mk_msg_scb, status);
-				/* FALLTHROUGH */
+				__fallthrough;
 			case SEARCH_REMOVE:
 			{
 				u_int tail_offset;
@@ -8335,7 +8335,7 @@ ahd_search_qinfifo(struct ahd_softc *ahd, int target, char channel,
 			}
 			case SEARCH_PRINT:
 				printk(" 0x%x", SCB_GET_TAG(scb));
-				/* FALLTHROUGH */
+				__fallthrough;
 			case SEARCH_COUNT:
 				break;
 			}
@@ -9063,7 +9063,7 @@ ahd_handle_scsi_status(struct ahd_softc *ahd, struct scb *scb)
 	case SCSI_STATUS_OK:
 		printk("%s: Interrupted for status of 0???\n",
 		       ahd_name(ahd));
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		ahd_done(ahd, scb);
 		break;
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index f3362f4ab16e..feeb52b63165 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -2420,7 +2420,7 @@ ahc_validate_width(struct ahc_softc *ahc, struct ahc_initiator_tinfo *tinfo,
 			*bus_width = MSG_EXT_WDTR_BUS_16_BIT;
 			break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MSG_EXT_WDTR_BUS_8_BIT:
 		*bus_width = MSG_EXT_WDTR_BUS_8_BIT;
 		break;
@@ -3615,7 +3615,7 @@ ahc_parse_msg(struct ahc_softc *ahc, struct ahc_devinfo *devinfo)
 		break;
 	case MSG_MESSAGE_REJECT:
 		response = ahc_handle_msg_reject(ahc, devinfo);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MSG_NOOP:
 		done = MSGLOOP_MSGCOMPLETE;
 		break;
@@ -4488,17 +4488,17 @@ ahc_free(struct ahc_softc *ahc)
 	default:
 	case 5:
 		ahc_shutdown(ahc);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 4:
 		ahc_dmamap_unload(ahc, ahc->shared_data_dmat,
 				  ahc->shared_data_dmamap);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 3:
 		ahc_dmamem_free(ahc, ahc->shared_data_dmat, ahc->qoutfifo,
 				ahc->shared_data_dmamap);
 		ahc_dmamap_destroy(ahc, ahc->shared_data_dmat,
 				   ahc->shared_data_dmamap);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 2:
 		ahc_dma_tag_destroy(ahc, ahc->shared_data_dmat);
 	case 1:
@@ -5890,7 +5890,7 @@ ahc_search_qinfifo(struct ahc_softc *ahc, int target, char channel,
 					printk("Inactive SCB in qinfifo\n");
 				ahc_done(ahc, scb);
 
-				/* FALLTHROUGH */
+				__fallthrough;
 			}
 			case SEARCH_REMOVE:
 				break;
@@ -6002,7 +6002,7 @@ ahc_search_qinfifo(struct ahc_softc *ahc, int target, char channel,
 				if ((scb->flags & SCB_ACTIVE) == 0)
 					printk("Inactive SCB in Waiting List\n");
 				ahc_done(ahc, scb);
-				/* FALLTHROUGH */
+				__fallthrough;
 			}
 			case SEARCH_REMOVE:
 				next = ahc_rem_wscb(ahc, next, prev);
@@ -7008,7 +7008,7 @@ ahc_download_instr(struct ahc_softc *ahc, u_int instrptr, uint8_t *dconsts)
 		}
 		address -= address_offset;
 		fmt3_ins->address = address;
-		/* FALLTHROUGH */
+		__fallthrough;
 	}
 	case AIC_OP_OR:
 	case AIC_OP_AND:
@@ -7035,7 +7035,7 @@ ahc_download_instr(struct ahc_softc *ahc, u_int instrptr, uint8_t *dconsts)
 			fmt1_ins->opcode = AIC_OP_AND;
 			fmt1_ins->immediate = 0xff;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case AIC_OP_ROL:
 		if ((ahc->features & AHC_ULTRA2) != 0) {
 			int i, count;
diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 2a01702d5ba7..2e8581893a19 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -508,7 +508,7 @@ int asd_abort_task(struct sas_task *task)
 		switch (tcs.dl_opcode) {
 		default:
 			res = asd_clear_nexus(task);
-			/* fallthrough */
+			__fallthrough;
 		case TC_NO_ERROR:
 			break;
 			/* The task hasn't been sent to the device xor
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 27bda2b05de6..078a207064e0 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -1476,7 +1476,7 @@ static void fas216_busservice_intr(FAS216_Info *info, unsigned int stat, unsigne
 
 		if (msgqueue_msglength(&info->scsi.msgs) > 1)
 			fas216_cmd(info, CMD_SETATN);
-		/*FALLTHROUGH*/
+		__fallthrough;
 
 	/*
 	 * Any          -> Message Out
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 17b45a0c7bc3..e6f2183366a6 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -1103,7 +1103,7 @@ static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
 		} else
 			memcpy(dev->port->disc.fanout_sas_addr,
 			       ex_phy->attached_sas_addr, SAS_ADDR_SIZE);
-		/* fallthrough */
+		__fallthrough;
 	case SAS_EDGE_EXPANDER_DEVICE:
 		child = sas_ex_discover_expander(dev, phy_id);
 		break;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index b775445892af..e50d4038c639 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -640,7 +640,7 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *shost, struct list_head *
 				sas_scsi_clear_queue_lu(work_q, cmd);
 				goto Again;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case TASK_IS_NOT_AT_LU:
 		case TASK_ABORT_FAILED:
 			pr_notice("task 0x%p is not at LU: I_T recover\n",
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index d0817facdae3..ae2c8c8eb689 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9098,7 +9098,7 @@ __lpfc_sli_issue_iocb_s3(struct lpfc_hba *phba, uint32_t ring_number,
 			 */
 			if (piocb->iocb_cmpl)
 				piocb->iocb_cmpl = NULL;
-			/*FALLTHROUGH*/
+			__fallthrough;
 		case CMD_CREATE_XRI_CR:
 		case CMD_CLOSE_XRI_CN:
 		case CMD_CLOSE_XRI_CX:
@@ -13521,7 +13521,7 @@ lpfc_sli4_sp_handle_rcqe(struct lpfc_hba *phba, struct lpfc_rcqe *rcqe)
 					atomic_read(&tgtp->rcv_fcp_cmd_out),
 					atomic_read(&tgtp->xmt_fcp_release));
 		}
-		/* fallthrough */
+		__fallthrough;
 
 	case FC_STATUS_INSUFF_BUF_NEED_BUF:
 		hrq->RQ_no_posted_buf++;
@@ -14033,7 +14033,7 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 					atomic_read(&tgtp->rcv_fcp_cmd_out),
 					atomic_read(&tgtp->xmt_fcp_release));
 		}
-		/* fallthrough */
+		__fallthrough;
 
 	case FC_STATUS_INSUFF_BUF_NEED_BUF:
 		hrq->RQ_no_posted_buf++;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 1b8378f36139..41fd6bb04faf 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -598,7 +598,7 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 			set_host_byte(scmd, DID_ALLOC_FAILURE);
 			return SUCCESS;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case COPY_ABORTED:
 	case VOLUME_OVERFLOW:
 	case MISCOMPARE:
@@ -620,7 +620,7 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 			return ADD_TO_MLQUEUE;
 		else
 			set_host_byte(scmd, DID_TARGET_FAILURE);
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	case ILLEGAL_REQUEST:
 		if (sshdr.asc == 0x20 || /* Invalid command operation code */
@@ -733,7 +733,7 @@ static int scsi_eh_completed_normally(struct scsi_cmnd *scmd)
 	switch (status_byte(scmd->result)) {
 	case GOOD:
 		scsi_handle_queue_ramp_up(scmd->device);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case COMMAND_TERMINATED:
 		return SUCCESS;
 	case CHECK_CONDITION:
@@ -1782,7 +1782,7 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 			set_host_byte(scmd, DID_TIME_OUT);
 			return SUCCESS;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case DID_NO_CONNECT:
 	case DID_BAD_TARGET:
 		/*
@@ -1826,7 +1826,7 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 			 * lower down
 			 */
 			break;
-		/* fallthrough */
+		__fallthrough;
 	case DID_BUS_BUSY:
 	case DID_PARITY:
 		goto maybe_retry;
@@ -1864,7 +1864,7 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 		 * the case of trying to send too many commands to a
 		 * tagged queueing device.
 		 */
-		/* FALLTHROUGH */
+		__fallthrough;
 	case BUSY:
 		/*
 		 * device can't talk to us at the moment.  Should only
@@ -1877,7 +1877,7 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 		if (scmd->cmnd[0] == REPORT_LUNS)
 			scmd->device->sdev_target->expecting_lun_change = 0;
 		scsi_handle_queue_ramp_up(scmd->device);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case COMMAND_TERMINATED:
 		return SUCCESS;
 	case TASK_ABORTED:
@@ -2348,22 +2348,22 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 		rtn = scsi_try_bus_device_reset(scmd);
 		if (rtn == SUCCESS || (val & SG_SCSI_RESET_NO_ESCALATE))
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case SG_SCSI_RESET_TARGET:
 		rtn = scsi_try_target_reset(scmd);
 		if (rtn == SUCCESS || (val & SG_SCSI_RESET_NO_ESCALATE))
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case SG_SCSI_RESET_BUS:
 		rtn = scsi_try_bus_reset(scmd);
 		if (rtn == SUCCESS || (val & SG_SCSI_RESET_NO_ESCALATE))
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case SG_SCSI_RESET_HOST:
 		rtn = scsi_try_host_reset(scmd);
 		if (rtn == SUCCESS)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		rtn = FAILED;
 		break;
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 840d96fe81bc..89b7ce40e271 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -116,7 +116,7 @@ static int ioctl_internal_command(struct scsi_device *sdev, char *cmd,
 		case NOT_READY:	/* This happens if there is no disc in drive */
 			if (sdev->removable)
 				break;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case UNIT_ATTENTION:
 			if (sdev->removable) {
 				sdev->changed = 1;
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e040f9dd9ff3..bf9904e99761 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1555,7 +1555,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * currently running. Hence, fall through to cancel gating
 		 * work and to enable clocks.
 		 */
-		/* fallthrough */
+		__fallthrough;
 	case CLKS_OFF:
 		ufshcd_scsi_block_requests(hba);
 		hba->clk_gating.state = REQ_CLKS_ON;
@@ -1567,7 +1567,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * fall through to check if we should wait for this
 		 * work to be done or not.
 		 */
-		/* fallthrough */
+		__fallthrough;
 	case REQ_CLKS_ON:
 		if (async) {
 			rc = -EAGAIN;
@@ -4625,7 +4625,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
 	switch (scsi_status) {
 	case SAM_STAT_CHECK_CONDITION:
 		ufshcd_copy_sense_data(lrbp);
-		/* fallthrough */
+		__fallthrough;
 	case SAM_STAT_GOOD:
 		result |= DID_OK << 16 |
 			  COMMAND_COMPLETE << 8 |
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index f7e054848ca5..ea8088926cec 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -125,13 +125,13 @@ static inline void bcm2835aux_rd_fifo(struct bcm2835aux_spi *bs)
 		switch (count) {
 		case 4:
 			*bs->rx_buf++ = (data >> 24) & 0xff;
-			/* fallthrough */
+			__fallthrough;
 		case 3:
 			*bs->rx_buf++ = (data >> 16) & 0xff;
-			/* fallthrough */
+			__fallthrough;
 		case 2:
 			*bs->rx_buf++ = (data >> 8) & 0xff;
-			/* fallthrough */
+			__fallthrough;
 		case 1:
 			*bs->rx_buf++ = (data >> 0) & 0xff;
 			/* fallthrough - no default */
diff --git a/drivers/ssb/driver_mipscore.c b/drivers/ssb/driver_mipscore.c
index 1ca2ac5ef2b8..549ee82a21d8 100644
--- a/drivers/ssb/driver_mipscore.c
+++ b/drivers/ssb/driver_mipscore.c
@@ -342,7 +342,7 @@ void ssb_mipscore_init(struct ssb_mipscore *mcore)
 				set_irq(dev, irq++);
 				break;
 			}
-			/* fallthrough */
+			__fallthrough;
 		case SSB_DEV_EXTIF:
 			set_irq(dev, 0);
 			break;
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8715bc50e09c..393c710fc8e4 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1705,7 +1705,7 @@ vle_get_logical_extent_head(const struct vle_map_blocks_iter_ctx *ctx,
 			lcn - delta0, ofs, pblk, flags);
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		*flags ^= EROFS_MAP_ZIPPED;
-		/* fallthrough */
+		__fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		/* clustersize should be a power of two */
 		*ofs = ((u64)lcn << ctx->clusterbits) +
@@ -1814,7 +1814,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (ofs_rem >= logical_cluster_ofs)
 			map->m_flags ^= EROFS_MAP_ZIPPED;
-		/* fallthrough */
+		__fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		if (ofs_rem == logical_cluster_ofs) {
 			pblk = le32_to_cpu(di->di_u.blkaddr);
@@ -1835,7 +1835,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			goto unmap_out;
 		}
 		end = ((u64)lcn-- * clustersize) | logical_cluster_ofs;
-		/* fallthrough */
+		__fallthrough;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		err = vle_get_logical_extent_head(&ctx, lcn, &ofs,
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index dec6f0f23b88..ff3fe1826456 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -133,11 +133,10 @@ void vnt_init_bands(struct vnt_private *priv)
 
 		priv->hw->wiphy->bands[NL80211_BAND_5GHZ] =
 						&vnt_supported_5ghz_band;
-	/* fallthrough */
-	case RF_RFMD2959:
-	case RF_AIROHA:
-	case RF_AL2230S:
-	case RF_UW2451:
+	case RF_RFMD2959: __fallthrough;
+	case RF_AIROHA: __fallthrough;
+	case RF_AL2230S: __fallthrough;
+	case RF_UW2451: __fallthrough;
 	case RF_VT3226:
 		ch = vnt_channels_2ghz;
 
diff --git a/drivers/staging/vt6656/channel.c b/drivers/staging/vt6656/channel.c
index 5d57d34577f5..5642fc90b6c2 100644
--- a/drivers/staging/vt6656/channel.c
+++ b/drivers/staging/vt6656/channel.c
@@ -145,10 +145,9 @@ void vnt_init_bands(struct vnt_private *priv)
 
 		priv->hw->wiphy->bands[NL80211_BAND_5GHZ] =
 						&vnt_supported_5ghz_band;
-	/* fallthrough */
-	case RF_AL2230:
-	case RF_AL2230S:
-	case RF_VT3226:
+	case RF_AL2230: __fallthrough;
+	case RF_AL2230S: __fallthrough;
+	case RF_VT3226: __fallthrough;
 	case RF_VT3226D0:
 		ch = vnt_channels_2ghz;
 
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index f75696f0ee2d..08dedec94539 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -605,7 +605,7 @@ static void receive_char(struct r3964_info *pInfo, const unsigned char c)
 		}
 		break;
 	case R3964_WAIT_FOR_RX_REPEAT:
-		/* FALLTHROUGH */
+		__fallthrough;
 	case R3964_IDLE:
 		if (c == STX) {
 			/* Prevent rx_queue from overflow: */
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index df41397de478..955359932464 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -618,7 +618,7 @@ pci_timedia_setup(struct serial_private *priv,
 		break;
 	case 3:
 		offset = board->uart_offset;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 4: /* BAR 2 */
 	case 5: /* BAR 3 */
 	case 6: /* BAR 4 */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6420ae581a80..ea93c1e58b9f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -591,7 +591,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 			transmit_chars(up, lsr);
 			break;
 		case UART_IIR_RX_TIMEOUT:
-			/* FALLTHROUGH */
+			__fallthrough;
 		case UART_IIR_RDI:
 			serial_omap_rdi(up, lsr);
 			break;
@@ -602,7 +602,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 			/* simply try again */
 			break;
 		case UART_IIR_XOFF:
-			/* FALLTHROUGH */
+			__fallthrough;
 		default:
 			break;
 		}
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d34984aa646d..d82bfe7ae8dd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1510,7 +1510,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 			break;
 		case 3: /* include scrollback */
 			flush_scrollback(vc);
-			/* fallthrough */
+			__fallthrough;
 		case 2: /* erase whole display */
 			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
 			count = vc->vc_cols * vc->vc_rows;
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index 633c52de3bb3..071dc6692908 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -710,7 +710,8 @@ static int c67x00_add_ctrl_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 			if (ret)
 				return ret;
 			break;
-		}		/* else fallthrough */
+		}
+		__fallthrough;
 	case STATUS_STAGE:
 		pid = !usb_pipeout(urb->pipe) ? USB_PID_OUT : USB_PID_IN;
 		ret = c67x00_create_td(c67x00, urb, NULL, 0, pid, 1,
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 20ff036b4c22..92ad534abc8c 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -364,7 +364,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno, int inum,
 			i = maxp & (BIT(12) | BIT(11));
 			maxp &= ~i;
 		}
-		/* fallthrough */
+		__fallthrough;
 	default:
 		maxpacket_maxes = high_speed_maxpacket_maxes;
 		break;
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 3189181bb628..b18b903ab511 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -566,7 +566,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 	case DeviceRequest | USB_REQ_GET_CONFIGURATION:
 		tbuf[0] = 1;
 		len = 1;
-			/* FALLTHROUGH */
+		__fallthrough;
 	case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
 		break;
 	case DeviceRequest | USB_REQ_GET_DESCRIPTOR:
@@ -635,7 +635,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 	case DeviceRequest | USB_REQ_GET_INTERFACE:
 		tbuf[0] = 0;
 		len = 1;
-			/* FALLTHROUGH */
+			__fallthrough;
 	case DeviceOutRequest | USB_REQ_SET_INTERFACE:
 		break;
 	case DeviceOutRequest | USB_REQ_SET_ADDRESS:
@@ -653,7 +653,7 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 		tbuf[0] = 0;
 		tbuf[1] = 0;
 		len = 2;
-			/* FALLTHROUGH */
+			__fallthrough;
 	case EndpointOutRequest | USB_REQ_CLEAR_FEATURE:
 	case EndpointOutRequest | USB_REQ_SET_FEATURE:
 		dev_dbg (hcd->self.controller, "no endpoint features yet\n");
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 0eab79f82ce4..3502ff0a1109 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -485,7 +485,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 	case USB_ENDPOINT_XFER_INT:
 		if (is_out)
 			allowed |= URB_ZERO_PACKET;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:			/* all non-iso endpoints */
 		if (!is_out)
 			allowed |= URB_SHORT_NOT_OK;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f90261..903ebdf2eef1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -624,9 +624,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
 				break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		break;
 	}
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index b8a15840b4ff..3f50cff96a7e 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -72,17 +72,17 @@ function_descriptors(struct usb_function *f,
 		descriptors = f->ssp_descriptors;
 		if (descriptors)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case USB_SPEED_SUPER:
 		descriptors = f->ss_descriptors;
 		if (descriptors)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case USB_SPEED_HIGH:
 		descriptors = f->hs_descriptors;
 		if (descriptors)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		descriptors = f->fs_descriptors;
 	}
@@ -1628,7 +1628,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			if (!gadget_is_dualspeed(gadget) ||
 			    gadget->speed >= USB_SPEED_SUPER)
 				break;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case USB_DT_CONFIG:
 			value = config_desc(cdev, w_value);
 			if (value >= 0)
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 75b113a5b25c..abf518151d0a 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -483,7 +483,7 @@ static void hidg_set_report_complete(struct usb_ep *ep, struct usb_request *req)
 		break;
 	default:
 		ERROR(cdev, "Set report failed %d\n", req->status);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case -ECONNABORTED:		/* hardware forced ep reset */
 	case -ECONNRESET:		/* request dequeued */
 	case -ESHUTDOWN:		/* disconnect from host */
diff --git a/drivers/usb/gadget/function/f_loopback.c b/drivers/usb/gadget/function/f_loopback.c
index 1803646b3678..c1e0c966a003 100644
--- a/drivers/usb/gadget/function/f_loopback.c
+++ b/drivers/usb/gadget/function/f_loopback.c
@@ -274,7 +274,7 @@ static void loopback_complete(struct usb_ep *ep, struct usb_request *req)
 	default:
 		ERROR(cdev, "%s loop complete --> %d, %d/%d\n", ep->name,
 				status, req->actual, req->length);
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	/* NOTE:  since this driver doesn't maintain an explicit record
 	 * of requests it submitted (just maintains qlen count), we
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 9c7ed2539ff7..d8154c5c0cff 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -285,7 +285,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 
 	/* data overrun */
 	case -EOVERFLOW:
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	default:
 		DBG(dev, "rx status %d\n", status);
@@ -304,7 +304,7 @@ static void tx_complete(struct usb_ep *ep, struct usb_request *req)
 	switch (req->status) {
 	default:
 		VDBG(dev, "tx err %d\n", req->status);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case -ECONNRESET:		/* unlink */
 	case -ESHUTDOWN:		/* disconnect etc */
 		break;
diff --git a/drivers/usb/gadget/function/f_rndis.c b/drivers/usb/gadget/function/f_rndis.c
index d48df36622b7..8c40443b46f9 100644
--- a/drivers/usb/gadget/function/f_rndis.c
+++ b/drivers/usb/gadget/function/f_rndis.c
@@ -426,7 +426,7 @@ static void rndis_response_complete(struct usb_ep *ep, struct usb_request *req)
 		DBG(cdev, "RNDIS %s response error %d, %d/%d\n",
 			ep->name, status,
 			req->actual, req->length);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 0:
 		if (ep != rndis->notify)
 			break;
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 737bd77a575d..fdbbc33602d7 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -319,7 +319,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 	/* data overrun */
 	case -EOVERFLOW:
 		dev->net->stats.rx_over_errors++;
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	default:
 		dev->net->stats.rx_errors++;
@@ -442,7 +442,7 @@ static void tx_complete(struct usb_ep *ep, struct usb_request *req)
 	default:
 		dev->net->stats.tx_errors++;
 		VDBG(dev, "tx err %d\n", req->status);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case -ECONNRESET:		/* unlink */
 	case -ESHUTDOWN:		/* disconnect etc */
 		dev_kfree_skb_any(skb);
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 65f634ec7fc2..0316e8c3ad23 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -383,7 +383,7 @@ static void gs_rx_push(struct work_struct *work)
 			/* presumably a transient fault */
 			pr_warn("ttyGS%d: unexpected RX status %d\n",
 				port->port_num, req->status);
-			/* FALLTHROUGH */
+			__fallthrough;
 		case 0:
 			/* normal completion */
 			break;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 249277d0e53f..708b6f2fba5d 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1718,7 +1718,7 @@ gadgetfs_suspend (struct usb_gadget *gadget)
 	case STATE_DEV_UNCONNECTED:
 		next_event (dev, GADGETFS_SUSPEND);
 		ep0_readable (dev);
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		break;
 	}
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index baf72f95f0f1..18ac78759c0e 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1944,7 +1944,7 @@ static void dummy_timer(struct timer_list *t)
 			 * this almost certainly polls too fast.
 			 */
 			limit = max(limit, periodic_bytes(dum, ep));
-			/* FALLTHROUGH */
+			__fallthrough;
 
 		default:
 treat_control_like_bulk:
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index 7619cfb06883..53dfd02f5956 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -823,7 +823,7 @@ static ssize_t fill_registers_buffer(struct debug_buffer *buf)
 				break;
 			case 0:		/* illegal reserved capability */
 				cap = 0;
-				/* FALLTHROUGH */
+				__fallthrough;
 			default:		/* unknown */
 				break;
 			}
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index cdafa97f632d..bbde8dbfaa5b 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -866,7 +866,7 @@ static int ehci_urb_enqueue (
 		 */
 		if (urb->transfer_buffer_length > (16 * 1024))
 			return -EMSGSIZE;
-		/* FALLTHROUGH */
+		__fallthrough;
 	/* case PIPE_BULK: */
 	default:
 		if (!qh_urb_transaction (ehci, urb, &qtd_list, mem_flags))
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 0da68df259c8..14355777e686 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5274,7 +5274,7 @@ static int fotg210_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 		 */
 		if (urb->transfer_buffer_length > (16 * 1024))
 			return -EMSGSIZE;
-		/* FALLTHROUGH */
+		__fallthrough;
 	/* case PIPE_BULK: */
 	default:
 		if (!qh_urb_transaction(fotg210, urb, &qtd_list, mem_flags))
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 210181fd98d2..8f50de930a6b 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -170,7 +170,7 @@ static int ohci_urb_enqueue (
 
 			/* 1 TD for setup, 1 for ACK, plus ... */
 			size = 2;
-			/* FALLTHROUGH */
+			__fallthrough;
 		// case PIPE_INTERRUPT:
 		// case PIPE_BULK:
 		default:
@@ -1029,7 +1029,7 @@ int ohci_restart(struct ohci_hcd *ohci)
 			ed->ed_next = ohci->ed_rm_list;
 			ed->ed_prev = NULL;
 			ohci->ed_rm_list = ed;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case ED_UNLINK:
 			break;
 		default:
diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index 4ccb85a67bb3..a6743372bbc8 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -647,7 +647,7 @@ static void td_submit_urb (
 		/* ... and periodic urbs have extra accounting */
 		periodic = ohci_to_hcd(ohci)->self.bandwidth_int_reqs++ == 0
 			&& ohci_to_hcd(ohci)->self.bandwidth_isoc_reqs == 0;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case PIPE_BULK:
 		info = is_out
 			? TD_T_TOGGLE | TD_CC | TD_DP_OUT
@@ -879,11 +879,11 @@ static void ed_halted(struct ohci_hcd *ohci, struct td *td, int cc)
 	case TD_DATAUNDERRUN:
 		if ((urb->transfer_flags & URB_SHORT_NOT_OK) == 0)
 			break;
-		/* fallthrough */
+		__fallthrough;
 	case TD_CC_STALL:
 		if (usb_pipecontrol (urb->pipe))
 			break;
-		/* fallthrough */
+		__fallthrough;
 	default:
 		ohci_dbg (ohci,
 			"urb %p path %s ep%d%s %08x cc %d --> status %d\n",
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index c78be578abb0..a9c9d90561ba 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -609,7 +609,7 @@ static void dbc_handle_xfer_event(struct xhci_hcd *xhci, union xhci_trb *event)
 	switch (comp_code) {
 	case COMP_SUCCESS:
 		remain_length = 0;
-	/* FALLTHROUGH */
+		__fallthrough;
 	case COMP_SHORT_PACKET:
 		status = 0;
 		break;
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 98ada1a3425c..9176f56d437b 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -182,7 +182,7 @@ get_endpoints(struct usbtest_dev *dev, struct usb_interface *intf)
 			case USB_ENDPOINT_XFER_ISOC:
 				if (dev->info->iso)
 					endpoint_update(edi, &iso_in, &iso_out, e);
-				/* FALLTHROUGH */
+				__fallthrough;
 			default:
 				continue;
 			}
@@ -364,7 +364,7 @@ static void simple_fill_buf(struct urb *urb)
 
 	switch (pattern) {
 	default:
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 0:
 		memset(buf, 0, len);
 		break;
@@ -681,7 +681,7 @@ static int get_altsetting(struct usbtest_dev *dev)
 		return dev->buf[0];
 	case 0:
 		retval = -ERANGE;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		return retval;
 	}
@@ -1951,7 +1951,7 @@ static void complicated_callback(struct urb *urb)
 			dev_err(&ctx->dev->intf->dev,
 					"resubmit err %d\n",
 					status);
-			/* FALLTHROUGH */
+			__fallthrough;
 		case -ENODEV:			/* disconnected */
 		case -ESHUTDOWN:		/* endpoint disabled */
 			ctx->submit_error = 1;
diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index b4d6d9bb3239..d7042ee98c84 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -975,7 +975,7 @@ static int cppi_channel_program(struct dma_channel *ch,
 		musb_dbg(musb, "%cX DMA%d not allocated!",
 				cppi_ch->transmit ? 'T' : 'R',
 				cppi_ch->index);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MUSB_DMA_STATUS_FREE:
 		break;
 	}
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b7d56272f9d1..25fc7166066f 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -831,9 +831,9 @@ static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
 	case OTG_STATE_A_PERIPHERAL:
 		musb_hnp_stop(musb);
 		musb_root_disconnect(musb);
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OTG_STATE_B_WAIT_ACON:
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_g_disconnect(musb);
@@ -868,7 +868,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 		switch (musb->xceiv->otg->state) {
 		case OTG_STATE_A_SUSPEND:
 			musb_g_reset(musb);
-			/* FALLTHROUGH */
+			__fallthrough;
 		case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
 			/* never use invalid T(a_wait_bcon) */
 			musb_dbg(musb, "HNP: in %s, %d msec timeout",
@@ -889,7 +889,7 @@ static void musb_handle_intr_reset(struct musb *musb)
 			break;
 		case OTG_STATE_B_IDLE:
 			musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case OTG_STATE_B_PERIPHERAL:
 			musb_g_reset(musb);
 			break;
@@ -1332,7 +1332,7 @@ static int ep_config_from_table(struct musb *musb)
 	switch (fifo_mode) {
 	default:
 		fifo_mode = 0;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 0:
 		cfg = mode_0_cfg;
 		n = ARRAY_SIZE(mode_0_cfg);
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 91a5027b5c1f..2f80ac0e0420 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -739,7 +739,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			musb_writeb(mbase, MUSB_TESTMODE,
 					musb->test_mode_nr);
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	case MUSB_EP0_STAGE_STATUSOUT:
 		/* end of sequence #1: write to host (TX state) */
@@ -771,7 +771,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		 */
 		retval = IRQ_HANDLED;
 		musb->ep0_state = MUSB_EP0_STAGE_SETUP;
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	case MUSB_EP0_STAGE_SETUP:
 setup:
@@ -1028,7 +1028,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 	case MUSB_EP0_STAGE_ACKWAIT:	/* STALL for zero-length data */
 	case MUSB_EP0_STAGE_RX:		/* control-OUT data */
 		csr = musb_readw(regs, MUSB_CSR0);
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	/* It's also OK to issue stalls during callbacks when a non-empty
 	 * DATA stage buffer has been read (or even written).
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index eb308ec35c66..c9b8804b793e 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1045,7 +1045,7 @@ static bool musb_h_ep0_continue(struct musb *musb, u16 len, struct urb *urb)
 			musb->ep0_stage = MUSB_EP0_OUT;
 			more = true;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case MUSB_EP0_OUT:
 		fifo_count = min_t(size_t, qh->maxpacket,
 				   urb->transfer_buffer_length -
@@ -2249,7 +2249,7 @@ static int musb_urb_enqueue(
 			interval = max_t(u8, epd->bInterval, 1);
 			break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case USB_ENDPOINT_XFER_ISOC:
 		/* ISO always uses logarithmic encoding */
 		interval = min_t(u8, epd->bInterval, 16);
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index a84ec27c4c12..e830fe1d30bf 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -211,7 +211,7 @@ void musb_root_disconnect(struct musb *musb)
 			musb->g.is_a_peripheral = 1;
 			break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OTG_STATE_A_HOST:
 		musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
 		musb->is_active = 0;
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 39453287b5c3..f965728e33aa 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -464,7 +464,7 @@ static void musb_do_idle(struct timer_list *t)
 			dev_dbg(musb->controller, "Nothing connected %s, turning off VBUS\n",
 					usb_otg_state_string(musb->xceiv->otg->state));
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OTG_STATE_A_IDLE:
 		tusb_musb_set_vbus(musb, 0);
 	default:
diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 7041ba030052..67ca86e94752 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -555,7 +555,7 @@ static void otg_update_isp(struct isp1301 *isp)
 	case OTG_STATE_A_PERIPHERAL:
 		if (otg_ctrl & OTG_PULLUP)
 			goto pullup;
-		/* FALLTHROUGH */
+		__fallthrough;
 	// case OTG_STATE_B_WAIT_ACON:
 	default:
 pulldown:
@@ -581,11 +581,11 @@ static void otg_update_isp(struct isp1301 *isp)
 		/* HNP failed for some reason (A_AIDL_BDIS timeout) */
 		notresponding(isp);
 
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OTG_STATE_A_VBUS_ERR:
 		isp->phy.otg->state = OTG_STATE_A_WAIT_VFALL;
 		pr_debug("  --> a_wait_vfall\n");
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OTG_STATE_A_WAIT_VFALL:
 		/* FIXME usbcore thinks port power is still on ... */
 		clr |= OTG1_VBUS_DRV;
@@ -595,7 +595,7 @@ static void otg_update_isp(struct isp1301 *isp)
 			isp->phy.otg->state = OTG_STATE_A_WAIT_VRISE;
 			pr_debug("  --> a_wait_vrise\n");
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		toggle(OTG_DRV_VBUS, OTG1_VBUS_DRV);
 	}
@@ -945,10 +945,10 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
 			switch (state) {
 			case OTG_STATE_B_IDLE:
 				a_idle(isp, "idle");
-				/* FALLTHROUGH */
+				__fallthrough;
 			case OTG_STATE_A_IDLE:
 				enable_vbus_source(isp);
-				/* FALLTHROUGH */
+				__fallthrough;
 			case OTG_STATE_A_WAIT_VRISE:
 				/* we skip over OTG_STATE_A_WAIT_BCON, since
 				 * the HC will transition to A_HOST (or
@@ -1032,12 +1032,12 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
 						OTG1_DP_PULLUP);
 			dump_regs(isp, __func__);
 #endif
-			/* FALLTHROUGH */
+			__fallthrough;
 		case OTG_STATE_B_SRP_INIT:
 			b_idle(isp, __func__);
 			l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
 			omap_writel(l, OTG_CTRL);
-			/* FALLTHROUGH */
+			__fallthrough;
 		case OTG_STATE_B_IDLE:
 			if (otg->gadget && (isp_bstat & OTG_B_SESS_VLD)) {
 #ifdef	CONFIG_USB_OTG
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index ed51bc48eea6..647eb57844bd 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1228,7 +1228,7 @@ static void cypress_write_int_callback(struct urb *urb)
 		return;
 	case -EPIPE:
 		/* Cannot call usb_clear_halt while in_interrupt */
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:
 		dev_err(dev, "%s - unexpected nonzero write status received: %d\n",
 			__func__, status);
diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 97b09a42a10c..5ada07114929 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -427,7 +427,7 @@ static void masking_bogus_flags(struct urb *urb)
 	case USB_ENDPOINT_XFER_BULK:
 		if (is_out)
 			allowed |= URB_ZERO_PACKET;
-		/* FALLTHROUGH */
+		__fallthrough;
 	default:			/* all non-iso endpoints */
 		if (!is_out)
 			allowed |= URB_SHORT_NOT_OK;
diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
index c9db846ee4f6..7e3d6f92ac43 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -404,7 +404,7 @@ static void v_timer(struct timer_list *t)
 			 * for now, give unlimited bandwidth
 			 */
 			limit += urb->transfer_buffer_length;
-			/* fallthrough */
+			__fallthrough;
 		default:
 treat_control_like_bulk:
 			total -= transfer(udc, urb, ep, limit);
@@ -479,7 +479,7 @@ void v_kick_timer(struct vudc *udc, unsigned long time)
 		return;
 	case VUDC_TR_IDLE:
 		t->state = VUDC_TR_RUNNING;
-		/* fallthrough */
+		__fallthrough;
 	case VUDC_TR_STOPPED:
 		/* we may want to kick timer to unqueue urbs */
 		mod_timer(&t->timer, time);
diff --git a/drivers/video/fbdev/nvidia/nv_hw.c b/drivers/video/fbdev/nvidia/nv_hw.c
index 8335da4ca30e..d05dd631a4b1 100644
--- a/drivers/video/fbdev/nvidia/nv_hw.c
+++ b/drivers/video/fbdev/nvidia/nv_hw.c
@@ -896,7 +896,7 @@ void NVCalcStateExt(struct nvidia_par *par,
 		if (!par->FlatPanel)
 			state->control = NV_RD32(par->PRAMDAC0, 0x0580) &
 				0xeffffeff;
-		/* fallthrough */
+		__fallthrough;
 	case NV_ARCH_10:
 	case NV_ARCH_20:
 	case NV_ARCH_30:
diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index 938cba0d24ae..85c1497d2b2e 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -341,13 +341,13 @@ static int omap_lcdc_setup_plane(int plane, int channel_out,
 			lcdc.bpp = 12;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	case OMAPFB_COLOR_YUV422:
 		if (lcdc.ext_mode) {
 			lcdc.bpp = 16;
 			break;
 		}
-		/* fallthrough */
+		__fallthrough;
 	default:
 		/* FIXME: other BPPs.
 		 * bpp1: code  0,     size 256
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index 8e23160ec59f..b8d52fe04b64 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -774,7 +774,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			r = -ENODEV;
 			break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 
 	case OMAPFB_WAITFORVSYNC:
 		DBG("ioctl WAITFORVSYNC\n");
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c09d7426cd92..d86ea03f2ef5 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -1861,7 +1861,7 @@ static int savage_init_hw(struct savagefb_par *par)
 		if ((vga_in8(0x3d5, par) & 0xC0) == (0x01 << 6))
 			RamSavage4[1] = 8;
 
-		/*FALLTHROUGH*/
+		__fallthrough;
 
 	case S3_SAVAGE2000:
 		videoRam = RamSavage4[(config1 & 0xE0) >> 5] * 1024;
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e2209bf5fa8a..7d10999a8847 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -220,7 +220,7 @@ static long ath79_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (err)
 			break;
 
-		/* fallthrough */
+		__fallthrough;
 	case WDIOC_GETTIMEOUT:
 		err = put_user(timeout, p);
 		break;
diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index 0240c60d14e3..86b78cf85bce 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -345,7 +345,7 @@ static long wdrtas_ioctl(struct file *file, unsigned int cmd,
 			wdrtas_interval = i;
 		else
 			wdrtas_interval = wdrtas_get_interval(i);
-		/* fallthrough */
+		__fallthrough;
 
 	case WDIOC_GETTIMEOUT:
 		return put_user(wdrtas_interval, argp);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 0d20fd161225..f3b9ddb33687 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -312,7 +312,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 					rdev = inode->i_rdev;
 					attr->ia_valid |= ATTR_SIZE;
 
-					/* FALLTHROUGH */
+					__fallthrough;
 				case S_IFIFO:
 					/* this is probably a permission check..
 					 * at least IRIX implements perm checking on
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 56992b32c6bb..5fa369eeb8f5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -943,7 +943,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	switch (flags & (FAN_MARK_ADD | FAN_MARK_REMOVE | FAN_MARK_FLUSH)) {
-	case FAN_MARK_ADD:		/* fallthrough */
+	case FAN_MARK_ADD:		__fallthrough;
 	case FAN_MARK_REMOVE:
 		if (!mask)
 			return -EINVAL;
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index fd5dd806f1b9..2fc49a9162cf 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -38,7 +38,7 @@ static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
 		if ((type == USRQUOTA && uid_eq(current_euid(), make_kuid(current_user_ns(), id))) ||
 		    (type == GRPQUOTA && in_egroup_p(make_kgid(current_user_ns(), id))))
 			break;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	default:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index bc3367b8b7bb..f170c9b8fc61 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2850,7 +2850,7 @@ xfs_alloc_vextent(
 		}
 		args->agbno = XFS_FSB_TO_AGBNO(mp, args->fsbno);
 		args->type = XFS_ALLOCTYPE_NEAR_BNO;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case XFS_ALLOCTYPE_FIRST_AG:
 		/*
 		 * Rotate through the allocation groups looking for a winner.
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index f643a9295179..9007c75d8279 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -923,7 +923,7 @@ xfs_ialloc(
 
 			ip->i_d.di_flags2 |= di_flags2;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case S_IFLNK:
 		ip->i_d.di_format = XFS_DINODE_FMT_EXTENTS;
 		ip->i_df.if_flags = XFS_IFEXTENTS;
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..bfa56983d5ee 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -253,4 +253,14 @@
  */
 #define __weak                          __attribute__((__weak__))
 
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-fallthrough
+ *   gcc: https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
+ */
+#if __has_attribute(__fallthrough__)
+# define __fallthrough                    __attribute__((__fallthrough__))
+#else
+# define __fallthrough
+#endif
+
 #endif /* __LINUX_COMPILER_ATTRIBUTES_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ce166a002d16..ee38b51a2da4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1531,7 +1531,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		if (t == BPF_WRITE)
 			return false;
-		/* fallthrough */
+		__fallthrough;
 
 	/* Program types with direct read + write access go here! */
 	case BPF_PROG_TYPE_SCHED_CLS:
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 14934afa9e68..fd1c17b47215 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -648,11 +648,11 @@ int kallsyms_show_value(void)
 	case 0:
 		if (kallsyms_for_perf())
 			return 1;
-	/* fallthrough */
+		__fallthrough;
 	case 1:
 		if (has_capability_noaudit(current, CAP_SYSLOG))
 			return 1;
-	/* fallthrough */
+		__fallthrough;
 	default:
 		return 0;
 	}
diff --git a/lib/glob.c b/lib/glob.c
index 0ba3ea86b546..2a29459018f4 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -102,7 +102,7 @@ bool __pure glob_match(char const *pat, char const *str)
 			break;
 		case '\\':
 			d = *pat++;
-			/*FALLTHROUGH*/
+			__fallthrough;
 		default:	/* Literal character */
 literal:
 			if (c == d) {
diff --git a/mm/ksm.c b/mm/ksm.c
index fc64874dc6f4..c18f5a6ed545 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2829,7 +2829,7 @@ static int ksm_memory_callback(struct notifier_block *self,
 		 */
 		ksm_check_stable_tree(mn->start_pfn,
 				      mn->start_pfn + mn->nr_pages);
-		/* fallthrough */
+		__fallthrough;
 
 	case MEM_CANCEL_OFFLINE:
 		mutex_lock(&ksm_thread_mutex);
diff --git a/mm/shmem.c b/mm/shmem.c
index b3db3779a30a..6b818e9cde00 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1810,7 +1810,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		if (i_size >= HPAGE_PMD_SIZE &&
 		    i_size >> PAGE_SHIFT >= off)
 			goto alloc_huge;
-		/* fallthrough */
+		__fallthrough;
 	case SHMEM_HUGE_ADVISE:
 		if (sgp_huge == SGP_HUGE)
 			goto alloc_huge;
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index eb15891f8b9f..2897c88cb0c8 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1940,7 +1940,7 @@ static int compat_mtw_from_user(struct compat_ebt_entry_mwt *mwt,
 			size_kern = match_size;
 		module_put(match->me);
 		break;
-	case EBT_COMPAT_WATCHER: /* fallthrough */
+	case EBT_COMPAT_WATCHER: __fallthrough;
 	case EBT_COMPAT_TARGET:
 		wt = xt_request_find_target(NFPROTO_BRIDGE, name,
 					    mwt->u.revision);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 372fdc5381a9..d4c473dbb56a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2538,7 +2538,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case UDP_ENCAP_ESPINUDP:
 		case UDP_ENCAP_ESPINUDP_NON_IKE:
 			up->encap_rcv = xfrm4_udp_encap_rcv;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
 			up->encap_type = val;
 			lock_sock(sk);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4ae17a966ae3..b026ce59a557 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3296,7 +3296,7 @@ static void addrconf_addr_gen(struct inet6_dev *idev, bool prefix_route)
 	switch (idev->cnf.addr_gen_mode) {
 	case IN6_ADDR_GEN_MODE_RANDOM:
 		ipv6_gen_mode_random_init(idev);
-		/* fallthrough */
+		__fallthrough;
 	case IN6_ADDR_GEN_MODE_STABLE_PRIVACY:
 		if (!ipv6_generate_stable_address(&addr, 0, idev))
 			addrconf_add_linklocal(idev, &addr,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 659ecf4e4b3c..d5101e047222 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1769,7 +1769,7 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 	case NETDEV_CHANGEADDR:
 		neigh_changeaddr(&nd_tbl, dev);
 		fib6_run_gc(0, net, false);
-		/* fallthrough */
+		__fallthrough;
 	case NETDEV_UP:
 		idev = in6_dev_get(dev);
 		if (!idev)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 4ef4bbdb49d4..9a3f8dbd43de 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3673,7 +3673,7 @@ static int ip6_pkt_drop(struct sk_buff *skb, u8 code, int ipstats_mib_noroutes)
 				      IPSTATS_MIB_INADDRERRORS);
 			break;
 		}
-		/* FALLTHROUGH */
+		__fallthrough;
 	case IPSTATS_MIB_OUTNOROUTES:
 		IP6_INC_STATS(dev_net(dst->dev), ip6_dst_idev(dst),
 			      ipstats_mib_noroutes);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 82bfbeef46af..34b15ff48928 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -298,7 +298,7 @@ nf_ct_get_tuple(const struct sk_buff *skb,
 		return gre_pkt_to_tuple(skb, dataoff, net, tuple);
 #endif
 	case IPPROTO_TCP:
-	case IPPROTO_UDP: /* fallthrough */
+	case IPPROTO_UDP: __fallthrough;
 		return nf_ct_get_tuple_ports(skb, dataoff, tuple);
 #ifdef CONFIG_NF_CT_PROTO_UDPLITE
 	case IPPROTO_UDPLITE:
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index c2ae14c720b4..3e52b2df509d 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -60,7 +60,7 @@ print_tuple(struct seq_file *s, const struct nf_conntrack_tuple *tuple,
 			   ntohs(tuple->src.u.tcp.port),
 			   ntohs(tuple->dst.u.tcp.port));
 		break;
-	case IPPROTO_UDPLITE: /* fallthrough */
+	case IPPROTO_UDPLITE: __fallthrough;
 	case IPPROTO_UDP:
 		seq_printf(s, "sport=%hu dport=%hu ",
 			   ntohs(tuple->src.u.udp.port),
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index af7dc6537758..52e503feef2f 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -411,7 +411,7 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 	static const unsigned int max_attempts = 128;
 
 	switch (tuple->dst.protonum) {
-	case IPPROTO_ICMP: /* fallthrough */
+	case IPPROTO_ICMP: __fallthrough;
 	case IPPROTO_ICMPV6:
 		/* id is same for either direction... */
 		keyptr = &tuple->src.u.icmp.id;
@@ -440,11 +440,11 @@ static void nf_nat_l4proto_unique_tuple(struct nf_conntrack_tuple *tuple,
 		}
 		goto find_free_id;
 #endif
-	case IPPROTO_UDP:	/* fallthrough */
-	case IPPROTO_UDPLITE:	/* fallthrough */
-	case IPPROTO_TCP:	/* fallthrough */
-	case IPPROTO_SCTP:	/* fallthrough */
-	case IPPROTO_DCCP:	/* fallthrough */
+	case IPPROTO_UDP:	__fallthrough;
+	case IPPROTO_UDPLITE:	__fallthrough;
+	case IPPROTO_TCP:	__fallthrough;
+	case IPPROTO_SCTP:	__fallthrough;
+	case IPPROTO_DCCP:	__fallthrough;
 		if (maniptype == NF_NAT_MANIP_SRC)
 			keyptr = &tuple->src.u.all;
 		else
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index c69b11ca5aad..391cdd8f4f41 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -451,7 +451,7 @@ static int cttimeout_default_get(struct net *net, struct sock *ctnl,
 	case IPPROTO_TCP:
 		timeouts = nf_tcp_pernet(net)->timeouts;
 		break;
-	case IPPROTO_UDP: /* fallthrough */
+	case IPPROTO_UDP: __fallthrough;
 	case IPPROTO_UDPLITE:
 		timeouts = nf_udp_pernet(net)->timeouts;
 		break;
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 7b717fad6cdc..205e5aef346b 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -131,7 +131,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 		return;
 	}
 #endif
-	case NFT_CT_BYTES: /* fallthrough */
+	case NFT_CT_BYTES: __fallthrough;
 	case NFT_CT_PKTS: {
 		const struct nf_conn_acct *acct = nf_conn_acct_find(ct);
 		u64 count = 0;
@@ -1005,7 +1005,7 @@ static int nft_ct_helper_obj_init(const struct nft_ctx *ctx,
 		help6 = nf_conntrack_helper_try_module_get(name, family,
 							   priv->l4proto);
 		break;
-	case NFPROTO_NETDEV: /* fallthrough */
+	case NFPROTO_NETDEV: __fallthrough;
 	case NFPROTO_BRIDGE: /* same */
 	case NFPROTO_INET:
 		help4 = nf_conntrack_helper_try_module_get(name, NFPROTO_IPV4,
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 21df8cccea65..515b1dc5d1ca 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -34,7 +34,7 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	unsigned int hooks;
 
 	switch (priv->result) {
-	case NFT_FIB_RESULT_OIF: /* fallthrough */
+	case NFT_FIB_RESULT_OIF: __fallthrough;
 	case NFT_FIB_RESULT_OIFNAME:
 		hooks = (1 << NF_INET_PRE_ROUTING);
 		break;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8376bc1c1508..ee5c215343fd 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4016,7 +4016,7 @@ static int packet_notifier(struct notifier_block *this,
 		case NETDEV_UNREGISTER:
 			if (po->mclist)
 				packet_dev_mclist_delete(dev, &po->mclist);
-			/* fallthrough */
+			__fallthrough;
 
 		case NETDEV_DOWN:
 			if (dev->ifindex == po->ifindex) {
diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index 46bce8389066..bed087d16caa 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -122,7 +122,7 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		rdsdebug("Connection rejected: %s\n",
 			 rdma_reject_msg(cm_id, event->status));
 		break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case RDMA_CM_EVENT_ADDR_ERROR:
 	case RDMA_CM_EVENT_ROUTE_ERROR:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 89a63391d4d4..07a953051610 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -383,7 +383,7 @@ rpcrdma_ia_open(struct rpcrdma_xprt *xprt)
 	case RPCRDMA_FRWR:
 		if (frwr_is_supported(ia))
 			break;
-		/*FALLTHROUGH*/
+		__fallthrough;
 	default:
 		pr_err("rpcrdma: Device %s does not support memreg mode %d\n",
 		       ia->ri_device->name, xprt_rdma_memreg_strategy);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 384719d5c44e..fd75dacc728b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -375,7 +375,7 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0299:
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x3000);
-		/* fallthrough */
+		__fallthrough;
 	case 0x10ec0215:
 	case 0x10ec0233:
 	case 0x10ec0235:
diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index bef3e9e74c26..95d7146e3086 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -569,7 +569,7 @@ static int adau1761_setup_headphone_mode(struct snd_soc_component *component)
 			ADAU1761_PLAY_MONO_OUTPUT_VOL_UNMUTE,
 			ADAU1761_PLAY_MONO_OUTPUT_VOL_MODE_HP |
 			ADAU1761_PLAY_MONO_OUTPUT_VOL_UNMUTE);
-		/* fallthrough */
+		__fallthrough;
 	case ADAU1761_OUTPUT_MODE_HEADPHONE:
 		regmap_update_bits(adau->regmap, ADAU1761_PLAY_HP_RIGHT_VOL,
 			ADAU1761_PLAY_HP_RIGHT_VOL_MODE_HP,
diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 400e29edb1c9..4fefc08ec043 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -160,13 +160,13 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	switch (params_channels(params)) {
 	case 8:
 		val |= PDM_PATH3_EN;
-		/* fallthrough */
+		__fallthrough;
 	case 6:
 		val |= PDM_PATH2_EN;
-		/* fallthrough */
+		__fallthrough;
 	case 4:
 		val |= PDM_PATH1_EN;
-		/* fallthrough */
+		__fallthrough;
 	case 2:
 		val |= PDM_PATH0_EN;
 		break;
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index dbb9efbf718a..88e9873fe9a8 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -102,7 +102,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		case OPTION_CALLBACK:
 			if (!(opt->flags & PARSE_OPT_NOARG))
 				break;
-			/* FALLTHROUGH */
+			__fallthrough;
 		case OPTION_BOOLEAN:
 		case OPTION_INCR:
 		case OPTION_BIT:
@@ -736,7 +736,7 @@ static void print_option_help(const struct option *opts, int full)
 	case OPTION_CALLBACK:
 		if (opts->flags & PARSE_OPT_NOARG)
 			break;
-		/* FALLTHROUGH */
+		__fallthrough;
 	case OPTION_STRING:
 		if (opts->argh) {
 			if (opts->flags & PARSE_OPT_OPTARG)
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 540a209b78ab..0dc45c32a3f6 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -230,7 +230,7 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 			break;
 		}
 
-		/* fallthrough */
+		__fallthrough;
 	case 0x88:
 		if (!rex_b &&
 		    (modrm_mod == 1 || modrm_mod == 2) && modrm_rm == 5) {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..77cdcbba1d90 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1926,7 +1926,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			if (ret == -1)
 				return 1;
 
-			/* fallthrough */
+			__fallthrough;
 		case INSN_CALL_DYNAMIC:
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index b2065536d407..552d9908667d 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -325,7 +325,7 @@ int main(int argc, char **argv)
 	switch (argc) {
 	case 2:
 		rtc_file = argv[1];
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 1:
 		break;
 	default:
diff --git a/tools/testing/selftests/rtc/setdate.c b/tools/testing/selftests/rtc/setdate.c
index 2cb78489eca4..2c91322dfa8c 100644
--- a/tools/testing/selftests/rtc/setdate.c
+++ b/tools/testing/selftests/rtc/setdate.c
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
 	switch (argc) {
 	case 4:
 		time = argv[3];
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 3:
 		date = argv[2];
 		rtc = argv[1];
diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 47b5bad1b393..1aecb0069b59 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -35,7 +35,7 @@ int main(int argc, char **argv)
 	switch (argc) {
 	case 2:
 		rtc = argv[1];
-		/* FALLTHROUGH */
+		__fallthrough;
 	case 1:
 		break;
 	default:
-- 
2.20.1

