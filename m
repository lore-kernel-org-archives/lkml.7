Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D37C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A22208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CAnw5e6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfF1P74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:59:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1P7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=izxz5nC/qtyZ9QwCfqpvt5YmFbj082YYhRsLq9SxpRg=; b=CAnw5e6gmPF7jVgsrdO3efJzb
        Q6GmvsffYeMqfxrW2zx0OohMEBwuwayobzhsnEztDjldZiog2VvI3vjnJ5Y5Bw8lP2Xj628mRkcle
        4wwE24mYtZyxVW45d7kU6CF9QyolwHDQHJY1lBAmt6mY+pHfj+sQyhGpx2pZZ+hasIgjZqavaucTT
        kGTBDpatn4u6eYlsivjzp1035x6ysYg9Uqt+EVFLy9GoWMVx3rOJmZXQxdpbGKGHVvPweS6xNQF61
        LooFZyO9Odqaksp5jfTdhlluENGvqVFxlTYqKTfmjZa1VKLMJE2Q5SLsqfY4/zpI7qUls9wp3dZe+
        N/WXA7+HQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgtHu-0004yo-B4; Fri, 28 Jun 2019 15:59:46 +0000
Date:   Fri, 28 Jun 2019 08:59:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>, brian.brooks@linaro.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        nadavh@marvell.com, stefanc@marvell.com,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] driver core: platform: Allow using a dedicated dma_mask
 for platform_device
Message-ID: <20190628155946.GA16956@infradead.org>
References: <20190628141550.22938-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628141550.22938-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd much rather bite the bullet and make dev->dma_mask a scalar
instead of a pointer.  The pointer causes way to much boiler plate code,
and the semantics are way to subtile.  Below is a POV patch that
compiles and boots with my usual x86 test config, and at least compiles
with the arm and pmac32 defconfigs.  It probably breaks just about
everything else, but should give us an idea what is involve in the
switch:

---
From ea73ba2d29f56ff6413066b10f018a671f2b26ac Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 28 Jun 2019 16:24:01 +0200
Subject: device.h: make dma_mask a scalar instead of a pointer

Kill the dma_mask indirection to clean up the mess we acquired around
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/common/locomo.c                  |  5 +-
 arch/arm/common/sa1111.c                  |  5 +-
 arch/arm/include/asm/dma-direct.h         |  2 +-
 arch/arm/include/asm/dma-mapping.h        |  2 +-
 arch/arm/include/asm/ecard.h              |  1 -
 arch/arm/include/asm/hardware/locomo.h    |  2 -
 arch/arm/include/asm/hardware/sa1111.h    |  1 -
 arch/arm/mach-davinci/devices.c           | 12 +---
 arch/arm/mach-davinci/dm355.c             | 17 ++---
 arch/arm/mach-davinci/dm365.c             |  4 +-
 arch/arm/mach-iop13xx/setup.c             |  7 +-
 arch/arm/mach-ixp4xx/common.c             |  9 ++-
 arch/arm/mach-mmp/pxa168.c                |  3 +-
 arch/arm/mach-pxa/devices.c               | 80 +++++++----------------
 arch/arm/mach-rpc/ecard.c                 |  3 +-
 arch/arm/mach-s3c24xx/common.c            | 10 ++-
 arch/arm/mach-s3c64xx/dev-audio.c         |  4 +-
 arch/arm/mach-sa1100/badge4.c             |  4 +-
 arch/arm/mach-sa1100/generic.c            | 16 ++---
 arch/arm/mach-sa1100/jornada720.c         |  4 +-
 arch/arm/mach-w90x900/dev.c               | 10 +--
 arch/arm/plat-iop/adma.c                  |  8 +--
 arch/m68k/coldfire/device.c               |  6 +-
 arch/m68k/kernel/dma.c                    |  7 +-
 arch/mips/alchemy/common/platform.c       | 12 ++--
 arch/mips/bcm63xx/dev-enet.c              |  8 +--
 arch/mips/jz4740/platform.c               |  6 +-
 arch/mips/loongson32/common/platform.c    |  4 +-
 arch/mips/pmcs-msp71xx/msp_usb.c          |  8 +--
 arch/mips/sgi-ip22/ip22-platform.c        | 12 +---
 arch/parisc/include/asm/parisc-device.h   |  1 -
 arch/parisc/kernel/drivers.c              |  6 +-
 arch/powerpc/include/asm/device.h         |  1 -
 arch/powerpc/include/asm/dma-direct.h     |  2 +-
 arch/powerpc/include/asm/iommu.h          |  8 ---
 arch/powerpc/kernel/dma-iommu.c           |  4 +-
 arch/powerpc/kernel/pci_of_scan.c         |  3 +-
 arch/powerpc/kernel/setup-common.c        |  3 +-
 arch/powerpc/platforms/pseries/vio.c      |  6 +-
 arch/sh/boards/mach-ecovec24/setup.c      |  8 +--
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c    |  5 +-
 arch/sparc/kernel/of_device_32.c          |  2 +-
 arch/sparc/kernel/of_device_64.c          |  2 +-
 drivers/acpi/arm64/iort.c                 | 17 +----
 drivers/amba/bus.c                        |  2 +-
 drivers/ata/ahci.c                        |  2 +-
 drivers/base/isa.c                        |  2 +-
 drivers/base/platform.c                   | 20 +-----
 drivers/bcma/main.c                       |  6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c           |  5 +-
 drivers/crypto/ccree/cc_driver.c          |  3 -
 drivers/dma/bcm2835-dma.c                 |  3 -
 drivers/eisa/eisa-bus.c                   |  5 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c     |  2 +-
 drivers/gpu/host1x/bus.c                  |  2 +-
 drivers/iommu/amd_iommu.c                 | 10 +--
 drivers/iommu/intel-iommu.c               |  8 +--
 drivers/macintosh/macio_asic.c            |  5 +-
 drivers/media/platform/via-camera.c       |  2 +-
 drivers/misc/mic/bus/mic_bus.c            |  2 +-
 drivers/misc/mic/bus/scif_bus.c           |  2 +-
 drivers/misc/mic/bus/vop_bus.c            |  2 +-
 drivers/misc/mic/card/mic_x100.c          |  4 +-
 drivers/mmc/core/queue.c                  |  2 +-
 drivers/mmc/host/mtk-sd.c                 |  6 +-
 drivers/mmc/host/sdhci-sprd.c             |  3 +-
 drivers/mmc/host/sdhci.c                  |  6 +-
 drivers/mmc/host/sdhci.h                  |  1 -
 drivers/nubus/bus.c                       |  3 +-
 drivers/of/device.c                       | 13 +---
 drivers/of/platform.c                     |  4 +-
 drivers/pci/pci-sysfs.c                   |  2 +-
 drivers/pci/probe.c                       |  3 +-
 drivers/pcmcia/ds.c                       |  3 +-
 drivers/pnp/card.c                        |  2 +-
 drivers/pnp/core.c                        |  5 +-
 drivers/rapidio/rio-scan.c                |  3 +-
 drivers/s390/virtio/virtio_ccw.c          |  2 -
 drivers/scsi/megaraid/megaraid_sas_base.c |  4 +-
 drivers/spi/spi-mt65xx.c                  |  3 -
 drivers/ssb/main.c                        |  1 -
 drivers/staging/media/omap4iss/iss.c      |  3 +-
 drivers/staging/media/omap4iss/iss.h      |  2 -
 drivers/tc/tc.c                           |  3 +-
 drivers/tty/goldfish.c                    |  5 --
 drivers/usb/core/hcd.c                    |  2 +-
 drivers/usb/dwc2/platform.c               |  2 -
 drivers/usb/gadget/udc/lpc32xx_udc.c      |  4 +-
 drivers/usb/host/bcma-hcd.c               |  1 -
 drivers/usb/host/ehci-grlib.c             |  2 -
 drivers/usb/host/ehci-ps3.c               |  6 +-
 drivers/usb/host/fsl-mph-dr-of.c          |  6 +-
 drivers/usb/host/ohci-ps3.c               |  6 +-
 drivers/usb/host/ssb-hcd.c                |  1 -
 drivers/usb/host/uhci-grlib.c             |  2 -
 drivers/usb/misc/ftdi-elan.c              |  2 +-
 drivers/zorro/zorro.c                     |  3 +-
 include/linux/device.h                    |  2 +-
 include/linux/dma-direct.h                |  2 +-
 include/linux/dma-mapping.h               | 12 ++--
 include/linux/eisa.h                      |  1 -
 include/linux/fsl/mc.h                    |  2 -
 include/linux/pci.h                       |  6 --
 include/linux/pnp.h                       |  1 -
 include/linux/rio.h                       |  2 -
 include/linux/tc.h                        |  1 -
 include/pcmcia/ds.h                       |  1 -
 include/trace/events/swiotlb.h            |  2 +-
 kernel/dma/direct.c                       |  4 +-
 kernel/dma/mapping.c                      |  2 +-
 sound/aoa/soundbus/i2sbus/core.c          |  3 +-
 sound/ppc/snd_ps3.c                       |  6 +-
 sound/soc/bcm/cygnus-pcm.c                |  5 +-
 113 files changed, 184 insertions(+), 411 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 51936bde1eb2..cf138eee9414 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -234,10 +234,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 	 * If the parent device has a DMA mask associated with it,
 	 * propagate it down to the children.
 	 */
-	if (lchip->dev->dma_mask) {
-		dev->dma_mask = *lchip->dev->dma_mask;
-		dev->dev.dma_mask = &dev->dma_mask;
-	}
+	dev->dev.dma_mask = lchip->dev->dma_mask;
 
 	dev_set_name(&dev->dev, "%s", info->name);
 	dev->devid	 = info->devid;
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 179ca8757a74..6c0f292e9617 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -717,7 +717,7 @@ sa1111_configure_smc(struct sa1111 *sachip, int sdram, unsigned int drac,
 	 * Chip Specification Update, June 2000, Erratum #7).
 	 */
 	if (sachip->dev->dma_mask)
-		*sachip->dev->dma_mask &= sa1111_dma_mask[drac >> 2];
+		sachip->dev->dma_mask &= sa1111_dma_mask[drac >> 2];
 
 	sachip->dev->coherent_dma_mask &= sa1111_dma_mask[drac >> 2];
 }
@@ -765,8 +765,7 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	 * this child supports DMA, propagate it down to the children.
 	 */
 	if (info->dma && sachip->dev->dma_mask) {
-		dev->dma_mask = *sachip->dev->dma_mask;
-		dev->dev.dma_mask = &dev->dma_mask;
+		dev->dev.dma_mask = sachip->dev->dma_mask;
 		dev->dev.coherent_dma_mask = sachip->dev->coherent_dma_mask;
 	}
 
diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index b67e5fc1fe43..fcdc509a8d12 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -21,7 +21,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return 0;
 
-	mask = *dev->dma_mask;
+	mask = dev->dma_mask;
 
 	limit = (mask + 1) & ~mask;
 	if (limit && size > limit)
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 03ba90ffc0f8..fe180d380f18 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -92,7 +92,7 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 /* The ARM override for dma_max_pfn() */
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-	return dma_to_pfn(dev, *dev->dma_mask);
+	return dma_to_pfn(dev, dev->dma_mask);
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
index 4befe8d2ae19..0b216bdb7f21 100644
--- a/arch/arm/include/asm/ecard.h
+++ b/arch/arm/include/asm/ecard.h
@@ -163,7 +163,6 @@ struct expansion_card {
 	/* Private internal data */
 	const char		*card_desc;	/* Card description		*/
 	CONST loader_t		loader;		/* loader program */
-	u64			dma_mask;
 };
 
 void ecard_setirq(struct expansion_card *ec, const struct expansion_card_ops *ops, void *irq_data);
diff --git a/arch/arm/include/asm/hardware/locomo.h b/arch/arm/include/asm/hardware/locomo.h
index f8712e3c29cf..a1772280829d 100644
--- a/arch/arm/include/asm/hardware/locomo.h
+++ b/arch/arm/include/asm/hardware/locomo.h
@@ -175,8 +175,6 @@ struct locomo_dev {
 
 	void		*mapbase;
 	unsigned long	length;
-
-	u64		dma_mask;
 };
 
 #define LOCOMO_DEV(_d)	container_of((_d), struct locomo_dev, dev)
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index d134b9a5ff94..05ad72f851c8 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -391,7 +391,6 @@ struct sa1111_dev {
 	void __iomem	*mapbase;
 	unsigned int	skpcr_mask;
 	unsigned int	hwirq[6];
-	u64		dma_mask;
 };
 
 #define to_sa1111_device(x)	container_of(x, struct sa1111_dev, dev)
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 40bd8029e457..768deb6a601f 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -89,15 +89,13 @@ static struct resource ide_resources[] = {
 	},
 };
 
-static u64 ide_dma_mask = DMA_BIT_MASK(32);
-
 static struct platform_device ide_device = {
 	.name           = "palm_bk3710",
 	.id             = -1,
 	.resource       = ide_resources,
 	.num_resources  = ARRAY_SIZE(ide_resources),
 	.dev = {
-		.dma_mask		= &ide_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
 	},
 };
@@ -121,8 +119,6 @@ void __init davinci_init_ide(void)
 
 #if IS_ENABLED(CONFIG_MMC_DAVINCI)
 
-static u64 mmcsd0_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource mmcsd0_resources[] = {
 	{
 		/* different on dm355 */
@@ -145,15 +141,13 @@ static struct platform_device davinci_mmcsd0_device = {
 	.name = "dm6441-mmc",
 	.id = 0,
 	.dev = {
-		.dma_mask = &mmcsd0_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources = ARRAY_SIZE(mmcsd0_resources),
 	.resource = mmcsd0_resources,
 };
 
-static u64 mmcsd1_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource mmcsd1_resources[] = {
 	{
 		.start = DM355_MMCSD1_BASE,
@@ -174,7 +168,7 @@ static struct platform_device davinci_mmcsd1_device = {
 	.name = "dm6441-mmc",
 	.id = 1,
 	.dev = {
-		.dma_mask = &mmcsd1_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources = ARRAY_SIZE(mmcsd1_resources),
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index c6073326be2e..0368c538ccf2 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -46,8 +46,6 @@
  */
 #define DM355_REF_FREQ		24000000	/* 24 or 36 MHz */
 
-static u64 dm355_spi0_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource dm355_spi0_resources[] = {
 	{
 		.start = 0x01c66000,
@@ -71,7 +69,7 @@ static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
 	.id = 0,
 	.dev = {
-		.dma_mask = &dm355_spi0_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &dm355_spi0_pdata,
 	},
@@ -371,7 +369,6 @@ static struct resource vpfe_resources[] = {
 	},
 };
 
-static u64 vpfe_capture_dma_mask = DMA_BIT_MASK(32);
 static struct resource dm355_ccdc_resource[] = {
 	/* CCDC Base address */
 	{
@@ -386,7 +383,7 @@ static struct platform_device dm355_ccdc_dev = {
 	.num_resources  = ARRAY_SIZE(dm355_ccdc_resource),
 	.resource       = dm355_ccdc_resource,
 	.dev = {
-		.dma_mask               = &vpfe_capture_dma_mask,
+		.dma_mask               = DMA_BIT_MASK(32),
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data		= dm355_ccdc_setup_pinmux,
 	},
@@ -398,7 +395,7 @@ static struct platform_device vpfe_capture_dev = {
 	.num_resources	= ARRAY_SIZE(vpfe_resources),
 	.resource	= vpfe_resources,
 	.dev = {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -417,7 +414,7 @@ static struct platform_device dm355_osd_dev = {
 	.num_resources	= ARRAY_SIZE(dm355_osd_resources),
 	.resource	= dm355_osd_resources,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -511,7 +508,7 @@ static struct platform_device dm355_vpbe_display = {
 	.num_resources	= ARRAY_SIZE(dm355_v4l2_disp_resources),
 	.resource	= dm355_v4l2_disp_resources,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -527,7 +524,7 @@ static struct platform_device dm355_venc_dev = {
 	.num_resources	= ARRAY_SIZE(dm355_venc_resources),
 	.resource	= dm355_venc_resources,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= (void *)&dm355_venc_pdata,
 	},
@@ -537,7 +534,7 @@ static struct platform_device dm355_vpbe_dev = {
 	.name		= "vpbe_controller",
 	.id		= -1,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2f9ae6431bf5..2af26aa2e01d 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -210,8 +210,6 @@ EVT_CFG(DM365,	EVT3_VC_RX,          1,     1,    1,     false)
 #endif
 };
 
-static u64 dm365_spi0_dma_mask = DMA_BIT_MASK(32);
-
 static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
@@ -235,7 +233,7 @@ static struct platform_device dm365_spi0_device = {
 	.name = "spi_davinci",
 	.id = 0,
 	.dev = {
-		.dma_mask = &dm365_spi0_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &dm365_spi0_pdata,
 	},
diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
index fe4932fda01d..3832ceb2ce1a 100644
--- a/arch/arm/mach-iop13xx/setup.c
+++ b/arch/arm/mach-iop13xx/setup.c
@@ -300,7 +300,6 @@ static struct resource iop13xx_adma_2_resources[] = {
 	}
 };
 
-static u64 iop13xx_adma_dmamask = DMA_BIT_MASK(32);
 static struct iop_adma_platform_data iop13xx_adma_0_data = {
 	.hw_id = 0,
 	.pool_size = PAGE_SIZE,
@@ -323,7 +322,7 @@ static struct platform_device iop13xx_adma_0_channel = {
 	.num_resources = 4,
 	.resource = iop13xx_adma_0_resources,
 	.dev = {
-		.dma_mask = &iop13xx_adma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop13xx_adma_0_data,
 	},
@@ -335,7 +334,7 @@ static struct platform_device iop13xx_adma_1_channel = {
 	.num_resources = 4,
 	.resource = iop13xx_adma_1_resources,
 	.dev = {
-		.dma_mask = &iop13xx_adma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop13xx_adma_1_data,
 	},
@@ -347,7 +346,7 @@ static struct platform_device iop13xx_adma_2_channel = {
 	.num_resources = 4,
 	.resource = iop13xx_adma_2_resources,
 	.dev = {
-		.dma_mask = &iop13xx_adma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop13xx_adma_2_data,
 	},
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 381f452de28d..3402512fc166 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -300,17 +300,16 @@ static int ixp4xx_platform_notify_remove(struct device *dev)
  */
 static int ixp4xx_platform_notify(struct device *dev)
 {
-	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->dma_mask = DMA_BIT_MASK(32);
 
 #ifdef CONFIG_PCI
 	if (dev_is_pci(dev)) {
-		dev->coherent_dma_mask = DMA_BIT_MASK(28); /* 64 MB */
+		dev->dma_mask = DMA_BIT_MASK(28); /* 64 MB */
 		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
-		return 0;
-	}
+	} else
 #endif
 
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->coherent_dma_mask = dev->dma_mask;
 	return 0;
 }
 
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index cdcf65ace3f9..28f7f6caef14 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -154,12 +154,11 @@ struct resource pxa168_usb_host_resources[] = {
 	},
 };
 
-static u64 pxa168_usb_host_dmamask = DMA_BIT_MASK(32);
 struct platform_device pxa168_device_usb_host = {
 	.name = "pxa-sph",
 	.id   = -1,
 	.dev  = {
-		.dma_mask = &pxa168_usb_host_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 524d6093e0c7..061426410428 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -63,13 +63,11 @@ static struct resource pxamci_resources[] = {
 	},
 };
 
-static u64 pxamci_dmamask = 0xffffffffUL;
-
 struct platform_device pxa_device_mci = {
 	.name		= "pxa2xx-mci",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &pxamci_dmamask,
+		.dma_mask = 0xffffffff,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(pxamci_resources),
@@ -104,8 +102,6 @@ static struct resource pxa2xx_udc_resources[] = {
 	},
 };
 
-static u64 udc_dma_mask = ~(u32)0;
-
 struct platform_device pxa25x_device_udc = {
 	.name		= "pxa25x-udc",
 	.id		= -1,
@@ -113,7 +109,7 @@ struct platform_device pxa25x_device_udc = {
 	.num_resources	= ARRAY_SIZE(pxa2xx_udc_resources),
 	.dev		=  {
 		.platform_data	= &pxa_udc_info,
-		.dma_mask	= &udc_dma_mask,
+		.dma_mask	= ~(u32)0,
 	}
 };
 
@@ -124,7 +120,7 @@ struct platform_device pxa27x_device_udc = {
 	.num_resources	= ARRAY_SIZE(pxa2xx_udc_resources),
 	.dev		=  {
 		.platform_data	= &pxa_udc_info,
-		.dma_mask	= &udc_dma_mask,
+		.dma_mask	= ~(u32)0,
 	}
 };
 
@@ -168,13 +164,11 @@ static struct resource pxafb_resources[] = {
 	},
 };
 
-static u64 fb_dma_mask = ~(u64)0;
-
 struct platform_device pxa_device_fb = {
 	.name		= "pxa2xx-fb",
 	.id		= -1,
 	.dev		= {
-		.dma_mask	= &fb_dma_mask,
+		.dma_mask	= ~(u64)0,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(pxafb_resources),
@@ -375,8 +369,6 @@ struct platform_device pxa_device_asoc_platform = {
 	.id		= -1,
 };
 
-static u64 pxaficp_dmamask = ~(u32)0;
-
 static struct resource pxa_ir_resources[] = {
 	[0] = {
 		.start  = IRQ_STUART,
@@ -406,7 +398,7 @@ struct platform_device pxa_device_ficp = {
 	.num_resources	= ARRAY_SIZE(pxa_ir_resources),
 	.resource	= pxa_ir_resources,
 	.dev		= {
-		.dma_mask = &pxaficp_dmamask,
+		.dma_mask = ~(u32)0,
 		.coherent_dma_mask = 0xffffffff,
 	},
 };
@@ -463,13 +455,11 @@ static struct resource pxa_ac97_resources[] = {
 	},
 };
 
-static u64 pxa_ac97_dmamask = 0xffffffffUL;
-
 struct platform_device pxa_device_ac97 = {
 	.name           = "pxa2xx-ac97",
 	.id             = -1,
 	.dev            = {
-		.dma_mask = &pxa_ac97_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources  = ARRAY_SIZE(pxa_ac97_resources),
@@ -525,8 +515,6 @@ struct platform_device pxa25x_device_pwm1 = {
 	.num_resources	= ARRAY_SIZE(pxa25x_resource_pwm1),
 };
 
-static u64 pxa25x_ssp_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa25x_resource_ssp[] = {
 	[0] = {
 		.start	= 0x41000000,
@@ -544,15 +532,13 @@ struct platform_device pxa25x_device_ssp = {
 	.name		= "pxa25x-ssp",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &pxa25x_ssp_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa25x_resource_ssp,
 	.num_resources	= ARRAY_SIZE(pxa25x_resource_ssp),
 };
 
-static u64 pxa25x_nssp_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa25x_resource_nssp[] = {
 	[0] = {
 		.start	= 0x41400000,
@@ -570,15 +556,13 @@ struct platform_device pxa25x_device_nssp = {
 	.name		= "pxa25x-nssp",
 	.id		= 1,
 	.dev		= {
-		.dma_mask = &pxa25x_nssp_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa25x_resource_nssp,
 	.num_resources	= ARRAY_SIZE(pxa25x_resource_nssp),
 };
 
-static u64 pxa25x_assp_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa25x_resource_assp[] = {
 	[0] = {
 		.start	= 0x41500000,
@@ -597,7 +581,7 @@ struct platform_device pxa25x_device_assp = {
 	.name		= "pxa25x-nssp",
 	.id		= 2,
 	.dev		= {
-		.dma_mask = &pxa25x_assp_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa25x_resource_assp,
@@ -619,13 +603,11 @@ static struct resource pxa27x_resource_camera[] = {
 	},
 };
 
-static u64 pxa27x_dma_mask_camera = DMA_BIT_MASK(32);
-
 static struct platform_device pxa27x_device_camera = {
 	.name		= "pxa27x-camera",
 	.id		= 0, /* This is used to put cameras on this interface */
 	.dev		= {
-		.dma_mask      		= &pxa27x_dma_mask_camera,
+		.dma_mask      		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(pxa27x_resource_camera),
@@ -637,8 +619,6 @@ void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
 	pxa_register_device(&pxa27x_device_camera, info);
 }
 
-static u64 pxa27x_ohci_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa27x_resource_ohci[] = {
 	[0] = {
 		.start  = 0x4C000000,
@@ -656,7 +636,7 @@ struct platform_device pxa27x_device_ohci = {
 	.name		= "pxa27x-ohci",
 	.id		= -1,
 	.dev		= {
-		.dma_mask = &pxa27x_ohci_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources  = ARRAY_SIZE(pxa27x_resource_ohci),
@@ -695,8 +675,6 @@ void __init pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info)
 	pxa_register_device(&pxa27x_device_keypad, info);
 }
 
-static u64 pxa27x_ssp1_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa27x_resource_ssp1[] = {
 	[0] = {
 		.start	= 0x41000000,
@@ -714,15 +692,13 @@ struct platform_device pxa27x_device_ssp1 = {
 	.name		= "pxa27x-ssp",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &pxa27x_ssp1_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa27x_resource_ssp1,
 	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp1),
 };
 
-static u64 pxa27x_ssp2_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa27x_resource_ssp2[] = {
 	[0] = {
 		.start	= 0x41700000,
@@ -740,15 +716,13 @@ struct platform_device pxa27x_device_ssp2 = {
 	.name		= "pxa27x-ssp",
 	.id		= 1,
 	.dev		= {
-		.dma_mask = &pxa27x_ssp2_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa27x_resource_ssp2,
 	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp2),
 };
 
-static u64 pxa27x_ssp3_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa27x_resource_ssp3[] = {
 	[0] = {
 		.start	= 0x41900000,
@@ -766,7 +740,7 @@ struct platform_device pxa27x_device_ssp3 = {
 	.name		= "pxa27x-ssp",
 	.id		= 2,
 	.dev		= {
-		.dma_mask = &pxa27x_ssp3_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa27x_resource_ssp3,
@@ -822,7 +796,7 @@ struct platform_device pxa3xx_device_mci2 = {
 	.name		= "pxa2xx-mci",
 	.id		= 1,
 	.dev		= {
-		.dma_mask = &pxamci_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask =	0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(pxa3xx_resources_mci2),
@@ -851,7 +825,7 @@ struct platform_device pxa3xx_device_mci3 = {
 	.name		= "pxa2xx-mci",
 	.id		= 2,
 	.dev		= {
-		.dma_mask = &pxamci_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(pxa3xx_resources_mci3),
@@ -876,15 +850,13 @@ static struct resource pxa3xx_resources_gcu[] = {
 	},
 };
 
-static u64 pxa3xx_gcu_dmamask = DMA_BIT_MASK(32);
-
 struct platform_device pxa3xx_device_gcu = {
 	.name		= "pxa3xx-gcu",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa3xx_resources_gcu),
 	.resource	= pxa3xx_resources_gcu,
 	.dev		= {
-		.dma_mask = &pxa3xx_gcu_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = 0xffffffff,
 	},
 };
@@ -924,13 +896,11 @@ static struct resource pxa3xx_resources_nand[] = {
 	},
 };
 
-static u64 pxa3xx_nand_dma_mask = DMA_BIT_MASK(32);
-
 struct platform_device pxa3xx_device_nand = {
 	.name		= "pxa3xx-nand",
 	.id		= -1,
 	.dev		= {
-		.dma_mask = &pxa3xx_nand_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(pxa3xx_resources_nand),
@@ -942,8 +912,6 @@ void __init pxa3xx_set_nand_info(struct pxa3xx_nand_platform_data *info)
 	pxa_register_device(&pxa3xx_device_nand, info);
 }
 
-static u64 pxa3xx_ssp4_dma_mask = DMA_BIT_MASK(32);
-
 static struct resource pxa3xx_resource_ssp4[] = {
 	[0] = {
 		.start	= 0x41a00000,
@@ -967,7 +935,7 @@ struct platform_device pxa3xx_device_ssp1 = {
 	.name		= "pxa3xx-ssp",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &pxa27x_ssp1_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa27x_resource_ssp1,
@@ -978,7 +946,7 @@ struct platform_device pxa3xx_device_ssp2 = {
 	.name		= "pxa3xx-ssp",
 	.id		= 1,
 	.dev		= {
-		.dma_mask = &pxa27x_ssp2_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa27x_resource_ssp2,
@@ -989,7 +957,7 @@ struct platform_device pxa3xx_device_ssp3 = {
 	.name		= "pxa3xx-ssp",
 	.id		= 2,
 	.dev		= {
-		.dma_mask = &pxa27x_ssp3_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa27x_resource_ssp3,
@@ -1000,7 +968,7 @@ struct platform_device pxa3xx_device_ssp4 = {
 	.name		= "pxa3xx-ssp",
 	.id		= 3,
 	.dev		= {
-		.dma_mask = &pxa3xx_ssp4_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.resource	= pxa3xx_resource_ssp4,
@@ -1093,13 +1061,11 @@ static struct resource pxa_dma_resource[] = {
 	},
 };
 
-static u64 pxadma_dmamask = 0xffffffffUL;
-
 static struct platform_device pxa2xx_pxa_dma = {
 	.name		= "pxa-dma",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &pxadma_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(pxa_dma_resource),
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 04b2f22c2739..e9964db14894 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -704,8 +704,7 @@ static struct expansion_card *__init ecard_alloc_card(int type, int slot)
 	dev_set_name(&ec->dev, "ecard%d", slot);
 	ec->dev.parent = NULL;
 	ec->dev.bus = &ecard_bus_type;
-	ec->dev.dma_mask = &ec->dma_mask;
-	ec->dma_mask = (u64)0xffffffff;
+	ec->dev.dma_mask = (u64)0xffffffff;
 	ec->dev.coherent_dma_mask = ec->dma_mask;
 
 	if (slot < 4) {
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 3dc029c2d2cb..1d61bb718741 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -290,8 +290,6 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 	},
 };
 
-#define s3c24xx_device_dma_mask (*((u64[]) { DMA_BIT_MASK(32) }))
-
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
 	defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
 static struct resource s3c2410_dma_resource[] = {
@@ -372,7 +370,7 @@ struct platform_device s3c2410_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
-		.dma_mask = &s3c24xx_device_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s3c2410_dma_platdata,
 	},
@@ -441,7 +439,7 @@ struct platform_device s3c2412_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
-		.dma_mask = &s3c24xx_device_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s3c2412_dma_platdata,
 	},
@@ -533,7 +531,7 @@ struct platform_device s3c2440_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
-		.dma_mask = &s3c24xx_device_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s3c2440_dma_platdata,
 	},
@@ -607,7 +605,7 @@ struct platform_device s3c2443_device_dma = {
 	.num_resources	= ARRAY_SIZE(s3c2443_dma_resource),
 	.resource	= s3c2443_dma_resource,
 	.dev	= {
-		.dma_mask = &s3c24xx_device_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &s3c2443_dma_platdata,
 	},
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index e3c49b5d1355..823de054d85f 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -189,8 +189,6 @@ static struct resource s3c64xx_ac97_resource[] = {
 static struct s3c_audio_pdata s3c_ac97_pdata = {
 };
 
-static u64 s3c64xx_ac97_dmamask = DMA_BIT_MASK(32);
-
 struct platform_device s3c64xx_device_ac97 = {
 	.name		  = "samsung-ac97",
 	.id		  = -1,
@@ -198,7 +196,7 @@ struct platform_device s3c64xx_device_ac97 = {
 	.resource	  = s3c64xx_ac97_resource,
 	.dev = {
 		.platform_data = &s3c_ac97_pdata,
-		.dma_mask = &s3c64xx_ac97_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6d04e9..3e930890a465 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -64,13 +64,11 @@ static struct sa1111_platform_data sa1111_info = {
 	.disable	= badge4_sa1111_disable,
 };
 
-static u64 sa1111_dmamask = 0xffffffffUL;
-
 static struct platform_device sa1111_device = {
 	.name		= "sa1111",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &sa1111_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 		.platform_data = &sa1111_info,
 	},
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 755290bf658b..5bc51afe445b 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -126,13 +126,11 @@ static struct resource sa11x0udc_resources[] = {
 	[1] = DEFINE_RES_IRQ(IRQ_Ser0UDC),
 };
 
-static u64 sa11x0udc_dma_mask = 0xffffffffUL;
-
 static struct platform_device sa11x0udc_device = {
 	.name		= "sa11x0-udc",
 	.id		= -1,
 	.dev		= {
-		.dma_mask = &sa11x0udc_dma_mask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(sa11x0udc_resources),
@@ -169,13 +167,11 @@ static struct resource sa11x0mcp_resources[] = {
 	[2] = DEFINE_RES_IRQ(IRQ_Ser4MCP),
 };
 
-static u64 sa11x0mcp_dma_mask = 0xffffffffUL;
-
 static struct platform_device sa11x0mcp_device = {
 	.name		= "sa11x0-mcp",
 	.id		= -1,
 	.dev = {
-		.dma_mask = &sa11x0mcp_dma_mask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(sa11x0mcp_resources),
@@ -202,13 +198,11 @@ static struct resource sa11x0ssp_resources[] = {
 	[1] = DEFINE_RES_IRQ(IRQ_Ser4SSP),
 };
 
-static u64 sa11x0ssp_dma_mask = 0xffffffffUL;
-
 static struct platform_device sa11x0ssp_device = {
 	.name		= "sa11x0-ssp",
 	.id		= -1,
 	.dev = {
-		.dma_mask = &sa11x0ssp_dma_mask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(sa11x0ssp_resources),
@@ -298,13 +292,11 @@ static struct resource sa11x0dma_resources[] = {
 	DEFINE_RES_IRQ(IRQ_DMA5),
 };
 
-static u64 sa11x0dma_dma_mask = DMA_BIT_MASK(32);
-
 static struct platform_device sa11x0dma_device = {
 	.name		= "sa11x0-dma",
 	.id		= -1,
 	.dev = {
-		.dma_mask = &sa11x0dma_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(sa11x0dma_resources),
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 6298bad09ef3..7e2b3f95903f 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -210,13 +210,11 @@ static struct sa1111_platform_data sa1111_info = {
 	.disable_devs	= SA1111_DEVID_PS2_MSE,
 };
 
-static u64 sa1111_dmamask = 0xffffffffUL;
-
 static struct platform_device sa1111_device = {
 	.name		= "sa1111",
 	.id		= 0,
 	.dev		= {
-		.dma_mask = &sa1111_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffff,
 		.platform_data = &sa1111_info,
 	},
diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index e65a80a1ac75..5e4ce1cbd8ec 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -107,15 +107,13 @@ static struct resource nuc900_usb_ehci_resource[] = {
 	}
 };
 
-static u64 nuc900_device_usb_ehci_dmamask = 0xffffffffUL;
-
 static struct platform_device nuc900_device_usb_ehci = {
 	.name		  = "nuc900-ehci",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(nuc900_usb_ehci_resource),
 	.resource	  = nuc900_usb_ehci_resource,
 	.dev              = {
-		.dma_mask = &nuc900_device_usb_ehci_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffffUL
 	}
 };
@@ -135,14 +133,13 @@ static struct resource nuc900_usb_ohci_resource[] = {
 	}
 };
 
-static u64 nuc900_device_usb_ohci_dmamask = 0xffffffffUL;
 static struct platform_device nuc900_device_usb_ohci = {
 	.name		  = "nuc900-ohci",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(nuc900_usb_ohci_resource),
 	.resource	  = nuc900_usb_ohci_resource,
 	.dev              = {
-		.dma_mask = &nuc900_device_usb_ohci_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffffUL
 	}
 };
@@ -189,14 +186,13 @@ static struct resource nuc900_emc_resource[] = {
 	}
 };
 
-static u64 nuc900_device_emc_dmamask = 0xffffffffUL;
 static struct platform_device nuc900_device_emc = {
 	.name		= "nuc900-emc",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(nuc900_emc_resource),
 	.resource	= nuc900_emc_resource,
 	.dev              = {
-		.dma_mask = &nuc900_device_emc_dmamask,
+		.dma_mask = 0xffffffffUL,
 		.coherent_dma_mask = 0xffffffffUL
 	}
 };
diff --git a/arch/arm/plat-iop/adma.c b/arch/arm/plat-iop/adma.c
index d9612221e484..37accc9f5030 100644
--- a/arch/arm/plat-iop/adma.c
+++ b/arch/arm/plat-iop/adma.c
@@ -119,8 +119,6 @@ static struct resource iop3xx_aau_resources[] = {
 	}
 };
 
-static u64 iop3xx_adma_dmamask = DMA_BIT_MASK(32);
-
 static struct iop_adma_platform_data iop3xx_dma_0_data = {
 	.hw_id = DMA0_ID,
 	.pool_size = PAGE_SIZE,
@@ -142,7 +140,7 @@ struct platform_device iop3xx_dma_0_channel = {
 	.num_resources = 4,
 	.resource = iop3xx_dma_0_resources,
 	.dev = {
-		.dma_mask = &iop3xx_adma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop3xx_dma_0_data,
 	},
@@ -154,7 +152,7 @@ struct platform_device iop3xx_dma_1_channel = {
 	.num_resources = 4,
 	.resource = iop3xx_dma_1_resources,
 	.dev = {
-		.dma_mask = &iop3xx_adma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop3xx_dma_1_data,
 	},
@@ -166,7 +164,7 @@ struct platform_device iop3xx_aau_channel = {
 	.num_resources = 4,
 	.resource = iop3xx_aau_resources,
 	.dev = {
-		.dma_mask = &iop3xx_adma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop3xx_aau_data,
 	},
diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index b4103b6bfdeb..aa77392dc8b6 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -139,7 +139,7 @@ static struct platform_device mcf_fec0 = {
 	.num_resources		= ARRAY_SIZE(mcf_fec0_resources),
 	.resource		= mcf_fec0_resources,
 	.dev = {
-		.dma_mask		= &mcf_fec0.dev.coherent_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= FEC_PDATA,
 	}
@@ -175,7 +175,7 @@ static struct platform_device mcf_fec1 = {
 	.num_resources		= ARRAY_SIZE(mcf_fec1_resources),
 	.resource		= mcf_fec1_resources,
 	.dev = {
-		.dma_mask		= &mcf_fec1.dev.coherent_dma_mask,
+		.dma_mask		= DMA_BIT_MASK(32),
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= FEC_PDATA,
 	}
@@ -546,7 +546,7 @@ static struct platform_device mcf_edma = {
 	.num_resources		= ARRAY_SIZE(mcf_edma_resources),
 	.resource		= mcf_edma_resources,
 	.dev = {
-		.dma_mask = &mcf_edma_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &mcf_edma_data,
 	}
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index b4aa853051bd..a5a6afe23954 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -78,7 +78,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 {
 	void *ret;
 
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
+	if (dev == NULL || (dev->dma_mask < 0xffffffff))
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
@@ -117,9 +117,8 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t handle,
 
 void arch_setup_pdev_archdata(struct platform_device *pdev)
 {
-	if (pdev->dev.coherent_dma_mask == DMA_MASK_NONE &&
-	    pdev->dev.dma_mask == NULL) {
+	if (!pdev->dev.coherent_dma_mask && !pdev->dev.dma_mask) {
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+		pdev->dev.dma_mask = DMA_BIT_MASK(32);
 	}
 }
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index b8f3397c59c9..b82ae9b38e37 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -131,8 +131,6 @@ static void __init alchemy_setup_uarts(int ctype)
 }
 
 
-static u64 alchemy_all_dmamask = DMA_BIT_MASK(32);
-
 /* Power on callback for the ehci platform driver */
 static int alchemy_ehci_power_on(struct platform_device *pdev)
 {
@@ -229,7 +227,7 @@ static void __init alchemy_setup_usb(int ctype)
 	res[1].flags = IORESOURCE_IRQ;
 	pdev->name = "ohci-platform";
 	pdev->id = 0;
-	pdev->dev.dma_mask = &alchemy_all_dmamask;
+	pdev->dev.dma_mask = DMA_BIT_MASK(32);
 	pdev->dev.platform_data = &alchemy_ohci_pdata;
 
 	if (platform_device_register(pdev))
@@ -249,7 +247,7 @@ static void __init alchemy_setup_usb(int ctype)
 		res[1].flags = IORESOURCE_IRQ;
 		pdev->name = "ehci-platform";
 		pdev->id = 0;
-		pdev->dev.dma_mask = &alchemy_all_dmamask;
+		pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		pdev->dev.platform_data = &alchemy_ehci_pdata;
 
 		if (platform_device_register(pdev))
@@ -269,7 +267,7 @@ static void __init alchemy_setup_usb(int ctype)
 		res[1].flags = IORESOURCE_IRQ;
 		pdev->name = "ohci-platform";
 		pdev->id = 1;
-		pdev->dev.dma_mask = &alchemy_all_dmamask;
+		pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		pdev->dev.platform_data = &alchemy_ohci_pdata;
 
 		if (platform_device_register(pdev))
@@ -337,7 +335,7 @@ static struct platform_device au1xxx_eth0_device = {
 	.id		= 0,
 	.num_resources	= MAC_RES_COUNT,
 	.dev = {
-		.dma_mask               = &alchemy_all_dmamask,
+		.dma_mask               = DMA_BIT_MASK(32),
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &au1xxx_eth0_platform_data,
 	},
@@ -373,7 +371,7 @@ static struct platform_device au1xxx_eth1_device = {
 	.id		= 1,
 	.num_resources	= MAC_RES_COUNT,
 	.dev = {
-		.dma_mask               = &alchemy_all_dmamask,
+		.dma_mask               = DMA_BIT_MASK(32),
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &au1xxx_eth1_platform_data,
 	},
diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 8e73d65f3480..8bc070a1afff 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -70,8 +70,6 @@ static struct platform_device bcm63xx_enet_shared_device = {
 
 static int shared_device_registered;
 
-static u64 enet_dmamask = DMA_BIT_MASK(32);
-
 static struct resource enet0_res[] = {
 	{
 		.start		= -1, /* filled at runtime */
@@ -101,7 +99,7 @@ static struct platform_device bcm63xx_enet0_device = {
 	.resource	= enet0_res,
 	.dev		= {
 		.platform_data = &enet0_pd,
-		.dma_mask = &enet_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
@@ -135,7 +133,7 @@ static struct platform_device bcm63xx_enet1_device = {
 	.resource	= enet1_res,
 	.dev		= {
 		.platform_data = &enet1_pd,
-		.dma_mask = &enet_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
@@ -163,7 +161,7 @@ static struct platform_device bcm63xx_enetsw_device = {
 	.resource	= enetsw_res,
 	.dev		= {
 		.platform_data = &enetsw_pd,
-		.dma_mask = &enet_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index cbc5f8e87230..b1e0bc3aae7d 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -56,7 +56,7 @@ struct platform_device jz4740_udc_device = {
 	.name = "musb-jz4740",
 	.id   = -1,
 	.dev  = {
-		.dma_mask          = &jz4740_udc_device.dev.coherent_dma_mask,
+		.dma_mask          = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources = ARRAY_SIZE(jz4740_udc_resources),
@@ -81,7 +81,7 @@ struct platform_device jz4740_mmc_device = {
 	.name		= "jz4740-mmc",
 	.id		= 0,
 	.dev = {
-		.dma_mask = &jz4740_mmc_device.dev.coherent_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(jz4740_mmc_resources),
@@ -164,7 +164,7 @@ struct platform_device jz4740_framebuffer_device = {
 	.num_resources	= ARRAY_SIZE(jz4740_framebuffer_resources),
 	.resource	= jz4740_framebuffer_resources,
 	.dev = {
-		.dma_mask = &jz4740_framebuffer_device.dev.coherent_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 0bf355c8bcb2..06e6454c4709 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -256,8 +256,6 @@ struct platform_device ls1x_gpio1_pdev = {
 };
 
 /* USB EHCI */
-static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
-
 static struct resource ls1x_ehci_resources[] = {
 	[0] = {
 		.start	= LS1X_EHCI_BASE,
@@ -279,7 +277,7 @@ struct platform_device ls1x_ehci_pdev = {
 	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
 	.resource	= ls1x_ehci_resources,
 	.dev		= {
-		.dma_mask = &ls1x_ehci_dmamask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &ls1x_ehci_pdata,
 	},
 };
diff --git a/arch/mips/pmcs-msp71xx/msp_usb.c b/arch/mips/pmcs-msp71xx/msp_usb.c
index d38ac70b5a2e..3bdc3d626795 100644
--- a/arch/mips/pmcs-msp71xx/msp_usb.c
+++ b/arch/mips/pmcs-msp71xx/msp_usb.c
@@ -61,14 +61,12 @@ static struct resource msp_usbhost0_resources[] = {
 	},
 };
 
-static u64 msp_usbhost0_dma_mask = 0xffffffffUL;
-
 static struct mspusb_device msp_usbhost0_device = {
 	.dev	= {
 		.name	= "pmcmsp-ehci",
 		.id	= 0,
 		.dev	= {
-			.dma_mask = &msp_usbhost0_dma_mask,
+			.dma_mask = 0xffffffffUL,
 			.coherent_dma_mask = 0xffffffffUL,
 		},
 		.num_resources	= ARRAY_SIZE(msp_usbhost0_resources),
@@ -101,15 +99,13 @@ static struct resource msp_usbdev0_resources[] = {
 	},
 };
 
-static u64 msp_usbdev_dma_mask = 0xffffffffUL;
-
 /* This may need to be converted to a mspusb_device, too. */
 static struct mspusb_device msp_usbdev0_device = {
 	.dev	= {
 		.name	= "msp71xx_udc",
 		.id	= 0,
 		.dev	= {
-			.dma_mask = &msp_usbdev_dma_mask,
+			.dma_mask = 0xffffffffUL,
 			.coherent_dma_mask = 0xffffffffUL,
 		},
 		.num_resources	= ARRAY_SIZE(msp_usbdev0_resources),
diff --git a/arch/mips/sgi-ip22/ip22-platform.c b/arch/mips/sgi-ip22/ip22-platform.c
index 0b2002e02a47..4381a0d1e89f 100644
--- a/arch/mips/sgi-ip22/ip22-platform.c
+++ b/arch/mips/sgi-ip22/ip22-platform.c
@@ -26,8 +26,6 @@ static struct sgiwd93_platform_data sgiwd93_0_pd = {
 	.irq	= SGI_WD93_0_IRQ,
 };
 
-static u64 sgiwd93_0_dma_mask = DMA_BIT_MASK(32);
-
 static struct platform_device sgiwd93_0_device = {
 	.name		= "sgiwd93",
 	.id		= 0,
@@ -35,7 +33,7 @@ static struct platform_device sgiwd93_0_device = {
 	.resource	= sgiwd93_0_resources,
 	.dev = {
 		.platform_data = &sgiwd93_0_pd,
-		.dma_mask = &sgiwd93_0_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
@@ -54,8 +52,6 @@ static struct sgiwd93_platform_data sgiwd93_1_pd = {
 	.irq	= SGI_WD93_1_IRQ,
 };
 
-static u64 sgiwd93_1_dma_mask = DMA_BIT_MASK(32);
-
 static struct platform_device sgiwd93_1_device = {
 	.name		= "sgiwd93",
 	.id		= 1,
@@ -63,7 +59,7 @@ static struct platform_device sgiwd93_1_device = {
 	.resource	= sgiwd93_1_resources,
 	.dev = {
 		.platform_data = &sgiwd93_1_pd,
-		.dma_mask = &sgiwd93_1_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
@@ -105,8 +101,6 @@ static struct resource sgiseeq_0_resources[] = {
 
 static struct sgiseeq_platform_data eth0_pd;
 
-static u64 sgiseeq_dma_mask = DMA_BIT_MASK(32);
-
 static struct platform_device eth0_device = {
 	.name		= "sgiseeq",
 	.id		= 0,
@@ -114,7 +108,7 @@ static struct platform_device eth0_device = {
 	.resource	= sgiseeq_0_resources,
 	.dev = {
 		.platform_data = &eth0_pd,
-		.dma_mask = &sgiseeq_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
diff --git a/arch/parisc/include/asm/parisc-device.h b/arch/parisc/include/asm/parisc-device.h
index d02d144c6012..b20bde6db465 100644
--- a/arch/parisc/include/asm/parisc-device.h
+++ b/arch/parisc/include/asm/parisc-device.h
@@ -26,7 +26,6 @@ struct parisc_device {
 	unsigned long	pmod_loc;	/* physical Module location */
 	unsigned long	mod0;
 #endif
-	u64		dma_mask;	/* DMA mask for I/O */
 	struct device 	dev;
 };
 
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 00a181f1ecc6..8c1d81941112 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -432,11 +432,9 @@ struct parisc_device * __init create_tree_node(char id, struct device *parent)
 	setup_bus_id(dev);
 
 	dev->dev.bus = &parisc_bus_type;
-	dev->dma_mask = 0xffffffffUL;	/* PARISC devices are 32-bit */
 
-	/* make the generic dma mask a pointer to the parisc one */
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->dev.coherent_dma_mask = dev->dma_mask;
+	dev->dev.dma_mask = 0xffffffffUL;   /* PARISC devices are 32-bit */
+	dev->dev.coherent_dma_mask = 0xffffffffUL;
 	if (device_register(&dev->dev)) {
 		kfree(dev);
 		return NULL;
diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index a130be13ee83..3f396a6250e8 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -53,7 +53,6 @@ struct dev_archdata {
 };
 
 struct pdev_archdata {
-	u64 dma_mask;
 };
 
 #endif /* _ASM_POWERPC_DEVICE_H */
diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index a2912b47102c..337042f07b1d 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -8,7 +8,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 		return false;
 
 	return addr + size - 1 <=
-		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
+		min_not_zero(dev->dma_mask, dev->bus_dma_mask);
 }
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 0ac52392ed99..f98f2864b66a 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -327,13 +327,5 @@ extern bool iommu_fixed_is_weak;
 
 extern const struct dma_map_ops dma_iommu_ops;
 
-static inline unsigned long device_to_mask(struct device *dev)
-{
-	if (dev->dma_mask && *dev->dma_mask)
-		return *dev->dma_mask;
-	/* Assume devices without mask can take 32 bit addresses */
-	return 0xfffffffful;
-}
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_IOMMU_H */
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 09231ef06d01..168af3a5b4b1 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -71,7 +71,7 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 		return dma_direct_map_page(dev, page, offset, size, direction,
 				attrs);
 	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
-			      size, device_to_mask(dev), direction, attrs);
+			      size, dma_get_mask(dev), direction, attrs);
 }
 
 
@@ -92,7 +92,7 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 	if (dma_iommu_map_bypass(dev, attrs))
 		return dma_direct_map_sg(dev, sglist, nelems, direction, attrs);
 	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
-				device_to_mask(dev), direction, attrs);
+				dma_get_mask(dev), direction, attrs);
 }
 
 static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 24191ea2d9a7..4d397aa05515 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -159,7 +159,8 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
 	dev->error_state = pci_channel_io_normal;
-	dev->dma_mask = 0xffffffff;
+	dev->dev.dma_mask = 0xffffffff;
+	dev->dev.coherent_dma_mask = 0xffffffff;
 
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index aad9f5df6ab6..e9bec23d5ce1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -784,8 +784,7 @@ void ppc_printk_progress(char *s, unsigned short hex)
 
 void arch_setup_pdev_archdata(struct platform_device *pdev)
 {
-	pdev->archdata.dma_mask = DMA_BIT_MASK(32);
-	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
+	pdev->dev.dma_mask = DMA_BIT_MASK(32);
 }
 
 static __init void print_system_info(void)
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 141795275ccb..f510aa5778ce 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -524,7 +524,7 @@ static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
 
 	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl))))
 		goto out_fail;
-	ret = iommu_map_page(dev, tbl, page, offset, size, device_to_mask(dev),
+	ret = iommu_map_page(dev, tbl, page, offset, size, dma_get_mask(dev),
 			direction, attrs);
 	if (unlikely(ret == DMA_MAPPING_ERROR))
 		goto out_deallocate;
@@ -564,7 +564,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 
 	if (vio_cmo_alloc(viodev, alloc_size))
 		goto out_fail;
-	ret = ppc_iommu_map_sg(dev, tbl, sglist, nelems, device_to_mask(dev),
+	ret = ppc_iommu_map_sg(dev, tbl, sglist, nelems, dma_get_mask(dev),
 			direction, attrs);
 	if (unlikely(!ret))
 		goto out_deallocate;
@@ -1430,7 +1430,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
 		viodev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
-		viodev->dev.dma_mask = &viodev->dev.coherent_dma_mask;
+		viodev->dev.dma_mask = DMA_BIT_MASK(64);
 	}
 
 	/* register with generic device framework */
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index f402aa741bf3..3dc6f1be2efc 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -205,7 +205,7 @@ static struct platform_device usb0_host_device = {
 	.name		= "r8a66597_hcd",
 	.id		= 0,
 	.dev = {
-		.dma_mask		= NULL,         /*  not use dma */
+		.dma_mask		= 0,         /*  not use dma */
 		.coherent_dma_mask	= 0xffffffff,
 		.platform_data		= &usb0_host_data,
 	},
@@ -241,7 +241,7 @@ static struct platform_device usb1_common_device = {
 	/* .name will be added in arch_setup */
 	.id		= 1,
 	.dev = {
-		.dma_mask		= NULL,         /*  not use dma */
+		.dma_mask		= 0,         /*  not use dma */
 		.coherent_dma_mask	= 0xffffffff,
 		.platform_data		= &usb1_common_data,
 	},
@@ -298,7 +298,7 @@ static struct platform_device usbhs_device = {
 	.name	= "renesas_usbhs",
 	.id	= 1,
 	.dev = {
-		.dma_mask		= NULL,         /*  not use dma */
+		.dma_mask		= 0,         /*  not use dma */
 		.coherent_dma_mask	= 0xffffffff,
 		.platform_data		= &usbhs_info,
 	},
@@ -887,7 +887,7 @@ static struct platform_device fsi_da7210_device = {
 	.dev	= {
 		.platform_data	= &fsi_da7210_info,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
-		.dma_mask = &fsi_da7210_device.dev.coherent_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 2501ce656511..ddc9e6f0ea57 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -639,7 +639,6 @@ static struct platform_device spi0_device = {
 	.name	= "sh_spi",
 	.id	= 0,
 	.dev	= {
-		.dma_mask		= NULL,
 		.coherent_dma_mask	= 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(spi0_resources),
@@ -701,7 +700,7 @@ static struct platform_device usb_ehci_device = {
 	.name		= "sh_ehci",
 	.id		= -1,
 	.dev = {
-		.dma_mask = &usb_ehci_device.dev.coherent_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
@@ -727,7 +726,7 @@ static struct platform_device usb_ohci_device = {
 	.name		= "ohci-platform",
 	.id		= -1,
 	.dev = {
-		.dma_mask = &usb_ohci_device.dev.coherent_dma_mask,
+		.dma_mask = DMA_BIT_MASK(32),
 		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data	= &usb_ohci_pdata,
 	},
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4ebf51e6e78e..b1baec7e921d 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -383,7 +383,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 
 	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	op->dev.dma_mask = &op->dev.coherent_dma_mask;
+	op->dev.dma_mask = DMA_BIT_MASK(32);
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 5a9f86b1d4e7..2817699a14d7 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -676,7 +676,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	op->dev.dma_mask = &op->dev.coherent_dma_mask;
+	op->dev.dma_mask = DMA_BIT_MASK(32);
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index b5390b4c9ade..26455d6ce514 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1068,17 +1068,6 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	u64 mask, dmaaddr = 0, size = 0, offset = 0;
 	int ret, msb;
 
-	/*
-	 * If @dev is expected to be DMA-capable then the bus code that created
-	 * it should have initialised its dma_mask pointer by this point. For
-	 * now, we'll continue the legacy behaviour of coercing it to the
-	 * coherent mask if not, but we'll no longer do so quietly.
-	 */
-	if (!dev->dma_mask) {
-		dev_warn(dev, "DMA mask not set\n");
-		dev->dma_mask = &dev->coherent_dma_mask;
-	}
-
 	if (dev->coherent_dma_mask)
 		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	else
@@ -1107,7 +1096,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 		 */
 		dev->bus_dma_mask = mask;
 		dev->coherent_dma_mask = mask;
-		*dev->dma_mask = mask;
+		dev->dma_mask = mask;
 	}
 
 	*dma_addr = dmaaddr;
@@ -1247,7 +1236,7 @@ static void __init arm_smmu_v3_dma_configure(struct device *dev,
 			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
 
 	/* We expect the dma masks to be equivalent for all SMMUv3 set-ups */
-	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->dma_mask = dev->coherent_dma_mask;
 
 	/* Configure DMA for the page table walker */
 	acpi_dma_configure(dev, attr);
@@ -1345,7 +1334,7 @@ static void __init arm_smmu_dma_configure(struct device *dev,
 			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
 
 	/* We expect the dma masks to be equivalent for SMMU set-ups */
-	dev->dma_mask = &dev->coherent_dma_mask;
+	dev->dma_mask = dev->coherent_dma_mask;
 
 	/* Configure DMA for the page table walker */
 	acpi_dma_configure(dev, attr);
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index b4dae624b9af..1950d9642a95 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -559,6 +559,7 @@ amba_aphb_device_add(struct device *parent, const char *name,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	dev->dev.dma_mask = dma_mask;
 	dev->dev.coherent_dma_mask = dma_mask;
 	dev->irq[0] = irq1;
 	dev->irq[1] = irq2;
@@ -625,7 +626,6 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
 		dev_set_name(&dev->dev, "%s", name);
 	dev->dev.release = amba_device_release;
 	dev->dev.bus = &amba_bustype;
-	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 	dev->res.name = dev_name(&dev->dev);
 }
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f7652baa6337..28062d5e7375 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -907,7 +907,7 @@ static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 	 * If the device fixup already set the dma_mask to some non-standard
 	 * value, don't extend it here. This happens on STA2X11, for example.
 	 */
-	if (pdev->dma_mask && pdev->dma_mask < DMA_BIT_MASK(32))
+	if (pdev->dev.dma_mask && pdev->dev.dma_mask < DMA_BIT_MASK(32))
 		return 0;
 
 	if (using_dac &&
diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 2772f5d1948a..d6e8b85743ce 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -143,7 +143,7 @@ int isa_register_driver(struct isa_driver *isa_driver, unsigned int ndev)
 		isa_dev->id			= id;
 
 		isa_dev->dev.coherent_dma_mask = DMA_BIT_MASK(24);
-		isa_dev->dev.dma_mask = &isa_dev->dev.coherent_dma_mask;
+		isa_dev->dev.dma_mask = DMA_BIT_MASK(24);
 
 		error = device_register(&isa_dev->dev);
 		if (error) {
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d1729853d1a..21d90d16e01d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -550,23 +550,8 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
 	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
-	if (pdevinfo->dma_mask) {
-		/*
-		 * This memory isn't freed when the device is put,
-		 * I don't have a nice idea for that though.  Conceptually
-		 * dma_mask in struct device should not be a pointer.
-		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
-		 */
-		pdev->dev.dma_mask =
-			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask)
-			goto err;
-
-		kmemleak_ignore(pdev->dev.dma_mask);
-
-		*pdev->dev.dma_mask = pdevinfo->dma_mask;
-		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
-	}
+	if (dma_set_mask_and_coherent(&pdev->dev, pdevinfo->dma_mask) < 0)
+		WARN_ON_ONCE(1);
 
 	ret = platform_device_add_resources(pdev,
 			pdevinfo->res, pdevinfo->num_res);
@@ -589,7 +574,6 @@ struct platform_device *platform_device_register_full(
 	if (ret) {
 err:
 		ACPI_COMPANION_SET(&pdev->dev, NULL);
-		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 6535614a7dc1..7448ca098cc5 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -249,12 +249,10 @@ void bcma_prepare_core(struct bcma_bus *bus, struct bcma_device *core)
 		core->irq = bus->host_pci->irq;
 		break;
 	case BCMA_HOSTTYPE_SOC:
-		if (IS_ENABLED(CONFIG_OF) && bus->dev) {
+		if (IS_ENABLED(CONFIG_OF) && bus->dev)
 			core->dma_dev = bus->dev;
-		} else {
-			core->dev.dma_mask = &core->dev.coherent_dma_mask;
+		else
 			core->dma_dev = &core->dev;
-		}
 		break;
 	case BCMA_HOSTTYPE_SDIO:
 		break;
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index f0404c6d1ff4..997def12fadb 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -630,9 +630,8 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		 * parent's ICID and interrupt domain.
 		 */
 		mc_dev->icid = parent_mc_dev->icid;
-		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
-		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
-		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
+		mc_dev->dev.dma_mask = FSL_MC_DEFAULT_DMA_MASK;
+		mc_dev->dev.coherent_dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 86ac7b443355..1f8020603fbe 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -326,9 +326,6 @@ static int init_cc_resources(struct platform_device *plat_dev)
 
 	init_completion(&new_drvdata->hw_queue_avail);
 
-	if (!plat_dev->dev.dma_mask)
-		plat_dev->dev.dma_mask = &plat_dev->dev.coherent_dma_mask;
-
 	dma_mask = DMA_BIT_MASK(DMA_BIT_MASK_LEN);
 	while (dma_mask > 0x7fffffffUL) {
 		if (dma_supported(&plat_dev->dev, dma_mask)) {
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 8101ff2f05c1..696c1fdf7a5d 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -867,9 +867,6 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	uint32_t chans_available;
 	char chan_name[BCM2835_DMA_CHAN_NAME_SIZE];
 
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		return rc;
diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 1e8062f6dbfc..1dd4ef1681cc 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -204,12 +204,11 @@ static int __init eisa_init_device(struct eisa_root_device *root,
 	edev->state = inb(SLOT_ADDRESS(root, slot) + EISA_CONFIG_OFFSET)
 		      & EISA_CONFIG_ENABLED;
 	edev->base_addr = SLOT_ADDRESS(root, slot);
-	edev->dma_mask = root->dma_mask; /* Default DMA mask */
 	eisa_name_device(edev);
 	edev->dev.parent = root->dev;
 	edev->dev.bus = &eisa_bus_type;
-	edev->dev.dma_mask = &edev->dma_mask;
-	edev->dev.coherent_dma_mask = edev->dma_mask;
+	edev->dev.dma_mask = root->dma_mask;
+	edev->dev.coherent_dma_mask = root->dma_mask;
 	dev_set_name(&edev->dev, "%02X:%02X", root->bus_nr, slot);
 
 	for (i = 0; i < EISA_MAX_RESOURCES; i++) {
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 7eb7cf9c3fa8..889cfe5e7405 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -653,7 +653,7 @@ static int __init etnaviv_init(void)
 			goto unregister_platform_driver;
 		}
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(40);
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+		pdev->dev.dma_mask = DMA_BIT_MASK(40);
 
 		/*
 		 * Apply the same DMA configuration to the virtual etnaviv
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 103fffc1904b..a5b768cdd214 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -416,7 +416,7 @@ static int host1x_device_add(struct host1x *host1x,
 	device->driver = driver;
 
 	device->dev.coherent_dma_mask = host1x->dev->coherent_dma_mask;
-	device->dev.dma_mask = &device->dev.coherent_dma_mask;
+	device->dev.dma_mask = device->dev.coherent_dma_mask;
 	dev_set_name(&device->dev, "%s", driver->driver.name);
 	device->dev.release = host1x_device_release;
 	device->dev.of_node = host1x->dev->of_node;
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 09c9e45f7fa2..4d140fd698a3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2454,7 +2454,6 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
-	u64 dma_mask;
 
 	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL)
@@ -2462,10 +2461,9 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	else if (IS_ERR(domain))
 		return DMA_MAPPING_ERROR;
 
-	dma_mask = *dev->dma_mask;
 	dma_dom = to_dma_ops_domain(domain);
 
-	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	return __map_single(dev, dma_dom, paddr, size, dir, dev->dma_mask);
 }
 
 /*
@@ -2525,7 +2523,6 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	struct dma_ops_domain *dma_dom;
 	struct scatterlist *s;
 	unsigned long address;
-	u64 dma_mask;
 	int ret;
 
 	domain = get_domain(dev);
@@ -2533,11 +2530,10 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		return 0;
 
 	dma_dom  = to_dma_ops_domain(domain);
-	dma_mask = *dev->dma_mask;
 
 	npages = sg_num_pages(dev, sglist, nelems);
 
-	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
+	address = dma_ops_alloc_iova(dev, dma_dom, npages, dev->dma_mask);
 	if (address == DMA_MAPPING_ERROR)
 		goto out_err;
 
@@ -2660,7 +2656,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	}
 
 	if (!dma_mask)
-		dma_mask = *dev->dma_mask;
+		dma_mask = dev->dma_mask;
 
 	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
 				 size, DMA_BIDIRECTIONAL, dma_mask);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..68f9f58b3775 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2999,7 +2999,7 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		 * If the device's dma_mask is less than the system's memory
 		 * size then this is not a candidate for identity mapping.
 		 */
-		u64 dma_mask = *dev->dma_mask;
+		u64 dma_mask = dev->dma_mask;
 
 		if (dev->coherent_dma_mask &&
 		    dev->coherent_dma_mask < dma_mask)
@@ -3717,7 +3717,7 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 {
 	if (iommu_need_mapping(dev))
 		return __intel_map_single(dev, page_to_phys(page) + offset,
-				size, dir, *dev->dma_mask);
+				size, dir, dev->dma_mask);
 	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
 }
 
@@ -3727,7 +3727,7 @@ static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 {
 	if (iommu_need_mapping(dev))
 		return __intel_map_single(dev, phys_addr, size, dir,
-				*dev->dma_mask);
+				dev->dma_mask);
 	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 }
 
@@ -3892,7 +3892,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		size += aligned_nrpages(sg->offset, sg->length);
 
 	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size),
-				*dev->dma_mask);
+				dev->dma_mask);
 	if (!iova_pfn) {
 		sglist->dma_length = 0;
 		return 0;
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 3543a82081de..8eaff903c732 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -374,9 +374,8 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 	dev->bus = &chip->lbus;
 	dev->media_bay = in_bay;
 	dev->ofdev.dev.of_node = np;
-	dev->ofdev.archdata.dma_mask = 0xffffffffUL;
-	dev->ofdev.dev.dma_mask = &dev->ofdev.archdata.dma_mask;
-	dev->ofdev.dev.coherent_dma_mask = dev->ofdev.archdata.dma_mask;
+	dev->ofdev.dev.dma_mask = 0xffffffffUL;
+	dev->ofdev.dev.coherent_dma_mask = 0xffffffffUL;
 	dev->ofdev.dev.parent = parent;
 	dev->ofdev.dev.bus = &macio_bus_type;
 	dev->ofdev.dev.release = macio_release_dev;
diff --git a/drivers/media/platform/via-camera.c b/drivers/media/platform/via-camera.c
index 24d5759501a5..e6488d41a764 100644
--- a/drivers/media/platform/via-camera.c
+++ b/drivers/media/platform/via-camera.c
@@ -1386,7 +1386,7 @@ static int viacam_probe(struct platform_device *pdev)
 	/*
 	 * Convince the system that we can do DMA.
 	 */
-	pdev->dev.dma_mask = &viadev->pdev->dma_mask;
+	pdev->dev.dma_mask = viadev->pdev->dev.dma_mask;
 	dma_set_mask(&pdev->dev, 0xffffffff);
 	/*
 	 * Fire up the capture port.  The write to 0x78 looks purely
diff --git a/drivers/misc/mic/bus/mic_bus.c b/drivers/misc/mic/bus/mic_bus.c
index 77b16ca66846..7da6fedc61c2 100644
--- a/drivers/misc/mic/bus/mic_bus.c
+++ b/drivers/misc/mic/bus/mic_bus.c
@@ -159,7 +159,7 @@ mbus_register_device(struct device *pdev, int id, const struct dma_map_ops *dma_
 	mbdev->id.device = id;
 	mbdev->id.vendor = MBUS_DEV_ANY_ID;
 	mbdev->dev.dma_ops = dma_ops;
-	mbdev->dev.dma_mask = &mbdev->dev.coherent_dma_mask;
+	mbdev->dev.dma_mask = DMA_BIT_MASK(64);
 	dma_set_mask(&mbdev->dev, DMA_BIT_MASK(64));
 	mbdev->dev.release = mbus_release_dev;
 	mbdev->hw_ops = hw_ops;
diff --git a/drivers/misc/mic/bus/scif_bus.c b/drivers/misc/mic/bus/scif_bus.c
index a444db5f61fe..2506d9792350 100644
--- a/drivers/misc/mic/bus/scif_bus.c
+++ b/drivers/misc/mic/bus/scif_bus.c
@@ -165,7 +165,7 @@ scif_register_device(struct device *pdev, int id, const struct dma_map_ops *dma_
 	sdev->aper = aper;
 	sdev->dp = dp;
 	sdev->rdp = rdp;
-	sdev->dev.dma_mask = &sdev->dev.coherent_dma_mask;
+	sdev->dev.dma_mask = DMA_BIT_MASK(64);
 	dma_set_mask(&sdev->dev, DMA_BIT_MASK(64));
 	sdev->dma_ch = chan;
 	sdev->num_dma_ch = num_chan;
diff --git a/drivers/misc/mic/bus/vop_bus.c b/drivers/misc/mic/bus/vop_bus.c
index e5bb9c749b5d..2d1db0aef60a 100644
--- a/drivers/misc/mic/bus/vop_bus.c
+++ b/drivers/misc/mic/bus/vop_bus.c
@@ -157,7 +157,7 @@ vop_register_device(struct device *pdev, int id,
 	vdev->id.device = id;
 	vdev->id.vendor = VOP_DEV_ANY_ID;
 	vdev->dev.dma_ops = dma_ops;
-	vdev->dev.dma_mask = &vdev->dev.coherent_dma_mask;
+	vdev->dev.dma_mask = DMA_BIT_MASK(64);
 	dma_set_mask(&vdev->dev, DMA_BIT_MASK(64));
 	vdev->dev.release = vop_release_dev;
 	vdev->hw_ops = hw_ops;
diff --git a/drivers/misc/mic/card/mic_x100.c b/drivers/misc/mic/card/mic_x100.c
index b9f0710ffa6b..f672f653caba 100644
--- a/drivers/misc/mic/card/mic_x100.c
+++ b/drivers/misc/mic/card/mic_x100.c
@@ -294,14 +294,12 @@ static void mic_platform_shutdown(struct platform_device *pdev)
 	mic_remove(pdev);
 }
 
-static u64 mic_dma_mask = DMA_BIT_MASK(64);
-
 static struct platform_device mic_platform_dev = {
 	.name = mic_driver_name,
 	.id   = 0,
 	.num_resources = 0,
 	.dev = {
-		.dma_mask = &mic_dma_mask,
+		.dma_mask = DMA_BIT_MASK(64),
 		.coherent_dma_mask = DMA_BIT_MASK(64),
 	},
 };
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b5b9c6142f08..fe294abff643 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -357,7 +357,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	u64 limit = BLK_BOUNCE_HIGH;
 	unsigned block_size = 512;
 
-	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
+	if (mmc_dev(host)->dma_mask && mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c518cc208a1f..ea5e87ce8c80 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -407,7 +407,6 @@ struct msdc_host {
 	void __iomem *top_base;		/* host top register base address */
 
 	struct msdc_dma dma;	/* dma channel */
-	u64 dma_mask;
 
 	u32 timeout_ns;		/* data timeout ns */
 	u32 timeout_clks;	/* data timeout clks */
@@ -2283,10 +2282,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc->max_req_size = 512 * 1024;
 	mmc->max_blk_count = mmc->max_req_size / 512;
 	if (host->dev_comp->support_64g)
-		host->dma_mask = DMA_BIT_MASK(36);
+		mmc_dev(mmc)->dma_mask = DMA_BIT_MASK(36);
 	else
-		host->dma_mask = DMA_BIT_MASK(32);
-	mmc_dev(mmc)->dma_mask = &host->dma_mask;
+		 mmc_dev(mmc)->dma_mask = DMA_BIT_MASK(32);
 
 	host->timeout_clks = 3 * 1048576;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 9a822e2e9f0b..521edf04d30e 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -335,8 +335,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	host->dma_mask = DMA_BIT_MASK(64);
-	pdev->dev.dma_mask = &host->dma_mask;
+	pdev->dev.dma_mask = DMA_BIT_MASK(64);
 	host->mmc_host_ops.request = sdhci_sprd_request;
 
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 97158344b862..a7a7ddb505a5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3834,10 +3834,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * mask, but PIO does not need the hw shim so we set a new
 	 * mask here in that case.
 	 */
-	if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
-		host->dma_mask = DMA_BIT_MASK(64);
-		mmc_dev(mmc)->dma_mask = &host->dma_mask;
-	}
+	if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)))
+		mmc_dev(mmc)->dma_mask = DMA_BIT_MASK(64);
 
 	if (host->version >= SDHCI_SPEC_300)
 		host->max_clk = (host->caps & SDHCI_CLOCK_V3_BASE_MASK)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d6bcc584c92b..a39fba0cfc8a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -497,7 +497,6 @@ struct sdhci_host {
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
 	struct mmc_host_ops mmc_host_ops;	/* MMC host ops */
-	u64 dma_mask;		/* custom DMA mask */
 
 #if IS_ENABLED(CONFIG_LEDS_CLASS)
 	struct led_classdev led;	/* LED control */
diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index ad3d17c42e23..a44e92d6ac63 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -94,8 +94,7 @@ int nubus_device_register(struct nubus_board *board)
 	board->dev.release = nubus_device_release;
 	board->dev.bus = &nubus_bus_type;
 	dev_set_name(&board->dev, "slot.%X", board->slot);
-	board->dev.dma_mask = &board->dev.coherent_dma_mask;
-	dma_set_mask(&board->dev, DMA_BIT_MASK(32));
+	dma_set_mask_and_coherent(&board->dev, DMA_BIT_MASK(32));
 	return device_register(&board->dev);
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index da8158392010..dda258d8d166 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -126,17 +126,6 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
-	/*
-	 * If @dev is expected to be DMA-capable then the bus code that created
-	 * it should have initialised its dma_mask pointer by this point. For
-	 * now, we'll continue the legacy behaviour of coercing it to the
-	 * coherent mask if not, but we'll no longer do so quietly.
-	 */
-	if (!dev->dma_mask) {
-		dev_warn(dev, "DMA mask not set\n");
-		dev->dma_mask = &dev->coherent_dma_mask;
-	}
-
 	if (!size && dev->coherent_dma_mask)
 		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	else if (!size)
@@ -150,7 +139,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
 	dev->coherent_dma_mask &= mask;
-	*dev->dma_mask &= mask;
+	dev->dma_mask &= mask;
 	/* ...but only set bus mask if we found valid dma-ranges earlier */
 	if (!ret)
 		dev->bus_dma_mask = mask;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..8786830a397e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -187,7 +187,7 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	if (!dev->dev.dma_mask)
-		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+		dev->dev.dma_mask = dev->dev.coherent_dma_mask;
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 	of_msi_configure(&dev->dev, dev->dev.of_node);
@@ -243,7 +243,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 
 	/* AMBA devices only support a single DMA mask */
 	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+	dev->dev.dma_mask = DMA_BIT_MASK(32);
 
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d27475e39b2..9ee382b6e8cb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -353,7 +353,7 @@ static ssize_t dma_mask_bits_show(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%d\n", fls64(pdev->dma_mask));
+	return sprintf(buf, "%d\n", fls64(pdev->dev.dma_mask));
 }
 static DEVICE_ATTR_RO(dma_mask_bits);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0e8e2c186f50..78ed92d72d3e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1731,7 +1731,7 @@ int pci_setup_device(struct pci_dev *dev)
 	 * Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	 * set this higher, assuming the system even supports it.
 	 */
-	dev->dma_mask = 0xffffffff;
+	dev->dev.dma_mask = 0xffffffff;
 
 	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
 		     dev->bus->number, PCI_SLOT(dev->devfn),
@@ -2664,7 +2664,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.release = pci_release_dev;
 
 	set_dev_node(&dev->dev, pcibus_to_node(bus));
-	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
 
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index a9258f641cee..4f4e96d2f813 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -519,8 +519,7 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	p_dev->dev.parent = s->dev.parent;
 	p_dev->dev.release = pcmcia_release_dev;
 	/* by default don't allow DMA */
-	p_dev->dma_mask = DMA_MASK_NONE;
-	p_dev->dev.dma_mask = &p_dev->dma_mask;
+	p_dev->dev.dma_mask = DMA_MASK_NONE;
 	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
 	if (!dev_name(&p_dev->dev))
 		goto err_free;
diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index c2464ee08e4a..beca34f0e549 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -170,7 +170,7 @@ struct pnp_card *pnp_alloc_card(struct pnp_protocol *protocol, int id, char *pnp
 	dev_set_name(&card->dev, "%02x:%02x", card->protocol->number, card->number);
 
 	card->dev.coherent_dma_mask = DMA_BIT_MASK(24);
-	card->dev.dma_mask = &card->dev.coherent_dma_mask;
+	card->dev.dma_mask = DMA_BIT_MASK(24);
 
 	dev_id = pnp_add_card_id(card, pnpid);
 	if (!dev_id) {
diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 3bf18d718975..7c52b39cefa5 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -152,12 +152,11 @@ struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id,
 	INIT_LIST_HEAD(&dev->options);
 	dev->protocol = protocol;
 	dev->number = id;
-	dev->dma_mask = DMA_BIT_MASK(24);
 
 	dev->dev.parent = &dev->protocol->dev;
 	dev->dev.bus = &pnp_bus_type;
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->dev.coherent_dma_mask = dev->dma_mask;
+	dev->dev.dma_mask = DMA_BIT_MASK(24);
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(24);
 	dev->dev.release = &pnp_release_device;
 
 	dev_set_name(&dev->dev, "%02x:%02x", dev->protocol->number, dev->number);
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index fd7b517132ac..e0af6b83fe05 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -452,8 +452,7 @@ static struct rio_dev *rio_setup_device(struct rio_net *net,
 	rio_attach_device(rdev);
 	rdev->dev.release = rio_release_dev;
 	rdev->dma_mask = DMA_BIT_MASK(32);
-	rdev->dev.dma_mask = &rdev->dma_mask;
-	rdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	rdev->dev.dma_mask = DMA_BIT_MASK(32);
 
 	if (rdev->dst_ops & RIO_DST_OPS_DOORBELL)
 		rio_init_dbell_res(&rdev->riores[RIO_DOORBELL_RESOURCE],
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 6a3076881321..35729b7a4d25 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -66,7 +66,6 @@ struct virtio_ccw_device {
 	bool device_lost;
 	unsigned int config_ready;
 	void *airq_info;
-	u64 dma_mask;
 };
 
 struct vq_info_block_legacy {
@@ -1257,7 +1256,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	}
 
 	vcdev->vdev.dev.parent = &cdev->dev;
-	cdev->dev.dma_mask = &vcdev->dma_mask;
 	/* we are fine with common virtio infrastructure using 64 bit DMA */
 	ret = dma_set_mask_and_coherent(&cdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..c8a1454636cf 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6344,7 +6344,7 @@ megasas_set_dma_mask(struct megasas_instance *instance)
 		    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))
 			goto fail_set_dma_mask;
 
-		if ((*pdev->dev.dma_mask == DMA_BIT_MASK(63)) &&
+		if ((pdev->dev.dma_mask == DMA_BIT_MASK(63)) &&
 		    (dma_set_coherent_mask(&pdev->dev, consistent_mask) &&
 		     dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)))) {
 			/*
@@ -6369,7 +6369,7 @@ megasas_set_dma_mask(struct megasas_instance *instance)
 		instance->consistent_mask_64bit = true;
 
 	dev_info(&pdev->dev, "%s bit DMA mask and %s bit consistent mask\n",
-		 ((*pdev->dev.dma_mask == DMA_BIT_MASK(63)) ? "63" : "32"),
+		 ((pdev->dev.dma_mask == DMA_BIT_MASK(63)) ? "63" : "32"),
 		 (instance->consistent_mask_64bit ? "63" : "32"));
 
 	return 0;
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0cce6f0ba824..a8d8520c61ab 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -680,9 +680,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-
 	ret = devm_request_irq(&pdev->dev, irq, mtk_spi_interrupt,
 			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), master);
 	if (ret) {
diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 0a26984acb2c..c551f8fd636c 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -511,7 +511,6 @@ static int ssb_devices_register(struct ssb_bus *bus)
 #endif
 			break;
 		case SSB_BUSTYPE_SSB:
-			dev->dma_mask = &dev->coherent_dma_mask;
 			sdev->dma_dev = dev;
 			break;
 		}
diff --git a/drivers/staging/media/omap4iss/iss.c b/drivers/staging/media/omap4iss/iss.c
index c8be1db532ab..f806b3fd2c8b 100644
--- a/drivers/staging/media/omap4iss/iss.c
+++ b/drivers/staging/media/omap4iss/iss.c
@@ -1215,8 +1215,7 @@ static int iss_probe(struct platform_device *pdev)
 	iss->dev = &pdev->dev;
 	iss->pdata = pdata;
 
-	iss->raw_dmamask = DMA_BIT_MASK(32);
-	iss->dev->dma_mask = &iss->raw_dmamask;
+	iss->dev->dma_mask = DMA_BIT_MASK(32);
 	iss->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	platform_set_drvdata(pdev, iss);
diff --git a/drivers/staging/media/omap4iss/iss.h b/drivers/staging/media/omap4iss/iss.h
index b88f9529683c..e1cc51b27afd 100644
--- a/drivers/staging/media/omap4iss/iss.h
+++ b/drivers/staging/media/omap4iss/iss.h
@@ -96,8 +96,6 @@ struct iss_device {
 	void __iomem *regs[OMAP4_ISS_MEM_LAST];
 	struct regmap *syscon;
 
-	u64 raw_dmamask;
-
 	struct mutex iss_mutex;	/* For handling ref_count field */
 	struct media_entity_enum crashed;
 	int has_context;
diff --git a/drivers/tc/tc.c b/drivers/tc/tc.c
index cf3fad2cb871..eb3963d5609b 100644
--- a/drivers/tc/tc.c
+++ b/drivers/tc/tc.c
@@ -94,8 +94,7 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
 		tdev->slot = slot;
 
 		/* TURBOchannel has 34-bit DMA addressing (16GiB space). */
-		tdev->dma_mask = DMA_BIT_MASK(34);
-		tdev->dev.dma_mask = &tdev->dma_mask;
+		tdev->dev.dma_mask = DMA_BIT_MASK(34);
 		tdev->dev.coherent_dma_mask = DMA_BIT_MASK(34);
 
 		for (i = 0; i < 8; i++) {
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index c8c5cdfc5e19..caab70f536ab 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -364,11 +364,6 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	 * will use DMA for read/write IO operations.
 	 */
 	if (qtty->version > 0) {
-		/*
-		 * Initialize dma_mask to 32-bits.
-		 */
-		if (!pdev->dev.dma_mask)
-			pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_err(&pdev->dev, "No suitable DMA available.\n");
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 88533938ce19..cf31bbdaf3a4 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2554,7 +2554,7 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	hcd->self.controller = dev;
 	hcd->self.sysdev = sysdev;
 	hcd->self.bus_name = bus_name;
-	hcd->self.uses_dma = (sysdev->dma_mask != NULL);
+	hcd->self.uses_dma = (sysdev->dma_mask != 0);
 
 	timer_setup(&hcd->rh_timer, rh_timer_func, 0);
 #ifdef CONFIG_PM
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index d10a7f8daec3..afe6477c1ea0 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -393,8 +393,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	/*
 	 * Use reasonable defaults so platforms don't have to provide these.
 	 */
-	if (!dev->dev.dma_mask)
-		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 	retval = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
 	if (retval) {
 		dev_err(&dev->dev, "can't set coherent DMA mask: %d\n", retval);
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index d8f1c60793ed..bbffc7f4fad3 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -2998,8 +2998,6 @@ struct lpc32xx_usbd_cfg lpc32xx_usbddata = {
 };
 
 
-static u64 lpc32xx_usbd_dmamask = ~(u32) 0x7F;
-
 static int lpc32xx_udc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -3038,7 +3036,7 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	dev_info(udc->dev, "ISP1301 I2C device at address 0x%x\n",
 		 udc->isp1301_i2c_client->addr);
 
-	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
+	pdev->dev.dma_mask = ~(u32)0x7F;
 	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval)
 		return retval;
diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 2400a826397a..3aef13840cdc 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -320,7 +320,6 @@ static struct platform_device *bcma_hcd_create_pdev(struct bcma_device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	hci_dev->dev.parent = &dev->dev;
-	hci_dev->dev.dma_mask = &hci_dev->dev.coherent_dma_mask;
 
 	ret = platform_device_add_resources(hci_dev, hci_res,
 					    ARRAY_SIZE(hci_res));
diff --git a/drivers/usb/host/ehci-grlib.c b/drivers/usb/host/ehci-grlib.c
index 656b8c08efc8..313cd7e14210 100644
--- a/drivers/usb/host/ehci-grlib.c
+++ b/drivers/usb/host/ehci-grlib.c
@@ -88,8 +88,6 @@ static int ehci_hcd_grlib_probe(struct platform_device *op)
 	if (rv)
 		return rv;
 
-	/* usb_create_hcd requires dma_mask != NULL */
-	op->dev.dma_mask = &op->dev.coherent_dma_mask;
 	hcd = usb_create_hcd(&ehci_grlib_hc_driver, &op->dev,
 			"GRUSBHC EHCI USB");
 	if (!hcd)
diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
index 454d8c624a3f..53366a852dda 100644
--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -86,7 +86,6 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
 	int result;
 	struct usb_hcd *hcd;
 	unsigned int virq;
-	static u64 dummy_mask;
 
 	if (usb_disabled()) {
 		result = -ENODEV;
@@ -131,9 +130,8 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
 		goto fail_irq;
 	}
 
-	dummy_mask = DMA_BIT_MASK(32);
-	dev->core.dma_mask = &dummy_mask;
-	dma_set_coherent_mask(&dev->core, dummy_mask);
+	dev->core.dma_mask = DMA_BIT_MASK(32);
+	dma_set_coherent_mask(&dev->core, DMA_BIT_MASK(32));
 
 	hcd = usb_create_hcd(&ps3_ehci_hc_driver, &dev->core, dev_name(&dev->core));
 
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 4f8b8a08c914..17147e98a4b0 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -93,11 +93,7 @@ static struct platform_device *fsl_usb2_device_register(
 	pdev->dev.parent = &ofdev->dev;
 
 	pdev->dev.coherent_dma_mask = ofdev->dev.coherent_dma_mask;
-
-	if (!pdev->dev.dma_mask)
-		pdev->dev.dma_mask = &ofdev->dev.coherent_dma_mask;
-	else
-		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 
 	retval = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 	if (retval)
diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
index 395f9d3bc849..5e7b6e33d138 100644
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -69,7 +69,6 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
 	int result;
 	struct usb_hcd *hcd;
 	unsigned int virq;
-	static u64 dummy_mask;
 
 	if (usb_disabled()) {
 		result = -ENODEV;
@@ -115,9 +114,8 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
 		goto fail_irq;
 	}
 
-	dummy_mask = DMA_BIT_MASK(32);
-	dev->core.dma_mask = &dummy_mask;
-	dma_set_coherent_mask(&dev->core, dummy_mask);
+	dev->core.dma_mask = DMA_BIT_MASK(32);
+	dma_set_coherent_mask(&dev->core, DMA_BIT_MASK(32));
 
 	hcd = usb_create_hcd(&ps3_ohci_hc_driver, &dev->core, dev_name(&dev->core));
 
diff --git a/drivers/usb/host/ssb-hcd.c b/drivers/usb/host/ssb-hcd.c
index 016987764afb..b56ed5ddeb44 100644
--- a/drivers/usb/host/ssb-hcd.c
+++ b/drivers/usb/host/ssb-hcd.c
@@ -121,7 +121,6 @@ static struct platform_device *ssb_hcd_create_pdev(struct ssb_device *dev, bool
 		return ERR_PTR(-ENOMEM);
 
 	hci_dev->dev.parent = dev->dev;
-	hci_dev->dev.dma_mask = &hci_dev->dev.coherent_dma_mask;
 
 	ret = platform_device_add_resources(hci_dev, hci_res,
 					    ARRAY_SIZE(hci_res));
diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index 2103b1ed0f8f..93271eae1a56 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -105,8 +105,6 @@ static int uhci_hcd_grlib_probe(struct platform_device *op)
 	if (rv)
 		return rv;
 
-	/* usb_create_hcd requires dma_mask != NULL */
-	op->dev.dma_mask = &op->dev.coherent_dma_mask;
 	hcd = usb_create_hcd(&uhci_grlib_hc_driver, &op->dev,
 			"GRUSBHC UHCI USB");
 	if (!hcd)
diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 257efacf3551..bf92829c35ee 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -313,7 +313,7 @@ static int ftdi_elan_hcd_init(struct usb_ftdi *ftdi)
 	ftdi->platform_dev.dev.platform_data = &ftdi->platform_data;
 	ftdi->platform_dev.dev.parent = NULL;
 	ftdi->platform_dev.dev.release = ftdi_release_platform_dev;
-	ftdi->platform_dev.dev.dma_mask = NULL;
+	ftdi->platform_dev.dev.dma_mask = 0;
 	snprintf(ftdi->device_name, sizeof(ftdi->device_name), "u132_hcd");
 	ftdi->platform_dev.name = ftdi->device_name;
 	dev_info(&ftdi->udev->dev, "requesting module '%s'\n", "u132_hcd");
diff --git a/drivers/zorro/zorro.c b/drivers/zorro/zorro.c
index 8eeb84c239db..205e8e08e436 100644
--- a/drivers/zorro/zorro.c
+++ b/drivers/zorro/zorro.c
@@ -190,15 +190,16 @@ static int __init amiga_zorro_probe(struct platform_device *pdev)
 		z->dev.id = i;
 		switch (z->rom.er_Type & ERT_TYPEMASK) {
 		case ERT_ZORROIII:
+			z->dev.dma_mask = DMA_BIT_MASK(32);
 			z->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 			break;
 
 		case ERT_ZORROII:
 		default:
+			z->dev.dma_mask = DMA_BIT_MASK(24);
 			z->dev.coherent_dma_mask = DMA_BIT_MASK(24);
 			break;
 		}
-		z->dev.dma_mask = &z->dev.coherent_dma_mask;
 	}
 
 	/* ... then register them */
diff --git a/include/linux/device.h b/include/linux/device.h
index e85264fb6616..0c2a1193660e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1010,7 +1010,7 @@ struct device {
 #endif
 
 	const struct dma_map_ops *dma_ops;
-	u64		*dma_mask;	/* dma mask (if dma'able device) */
+	u64		dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
 					     alloc_coherent mappings as
 					     not all hardware supports
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b7338702592a..a215793206fa 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -28,7 +28,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 		return false;
 
 	return addr + size - 1 <=
-		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
+		min_not_zero(dev->dma_mask, dev->bus_dma_mask);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6309a721394b..12993bf5e63d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -151,7 +151,7 @@ static inline int valid_dma_direction(int dma_direction)
 
 static inline int is_device_dma_capable(struct device *dev)
 {
-	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
+	return dev->dma_mask != DMA_MASK_NONE;
 }
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
@@ -650,8 +650,8 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 
 static inline u64 dma_get_mask(struct device *dev)
 {
-	if (dev->dma_mask && *dev->dma_mask)
-		return *dev->dma_mask;
+	if (dev->dma_mask)
+		return dev->dma_mask;
 	return DMA_BIT_MASK(32);
 }
 
@@ -670,12 +670,10 @@ static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
 }
 
 /*
- * Similar to the above, except it deals with the case where the device
- * does not have dev->dma_mask appropriately setup.
+ * Don't use in new code.
  */
 static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 {
-	dev->dma_mask = &dev->coherent_dma_mask;
 	return dma_set_mask_and_coherent(dev, mask);
 }
 
@@ -732,7 +730,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
+	return (dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
 }
 #endif
 
diff --git a/include/linux/eisa.h b/include/linux/eisa.h
index b012e30afebd..0281f60daf91 100644
--- a/include/linux/eisa.h
+++ b/include/linux/eisa.h
@@ -38,7 +38,6 @@ struct eisa_device {
 	int                   state;
 	unsigned long         base_addr;
 	struct resource       res[EISA_MAX_RESOURCES];
-	u64                   dma_mask;
 	struct device         dev; /* generic device */
 #ifdef CONFIG_EISA_NAMES
 	char		      pretty_name[50];
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 975553a9f75d..8f6aa1bd4720 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -151,7 +151,6 @@ struct fsl_mc_obj_desc {
 /**
  * struct fsl_mc_device - MC object device object
  * @dev: Linux driver model device object
- * @dma_mask: Default DMA mask
  * @flags: MC object device flags
  * @icid: Isolation context ID for the device
  * @mc_handle: MC handle for the corresponding MC object opened
@@ -184,7 +183,6 @@ struct fsl_mc_obj_desc {
  */
 struct fsl_mc_device {
 	struct device dev;
-	u64 dma_mask;
 	u16 flags;
 	u16 icid;
 	u16 mc_handle;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4a5a84d7bdd4..34ee806bf0d6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -315,12 +315,6 @@ struct pci_dev {
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* Driver bound to this device */
-	u64		dma_mask;	/* Mask of the bits of bus address this
-					   device implements.  Normally this is
-					   0xffffffff.  You only need to change
-					   this if your device has broken DMA
-					   or supports 64-bit transfers.  */
-
 	struct device_dma_parameters dma_parms;
 
 	pci_power_t	current_state;	/* Current operating state. In ACPI,
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 3b12fd28af78..bc6a596c46ed 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -244,7 +244,6 @@ static inline void pnp_set_card_drvdata(struct pnp_card_link *pcard, void *data)
 
 struct pnp_dev {
 	struct device dev;		/* Driver Model device interface */
-	u64 dma_mask;
 	unsigned int number;		/* used as an index, must be unique */
 	int status;
 
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 37b95c4af99d..e972b418384e 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -165,7 +165,6 @@ enum rio_device_state {
  * @phys_efptr: RIO device extended features pointer
  * @phys_rmap: LP-Serial Register Map Type (1 or 2)
  * @em_efptr: RIO Error Management features pointer
- * @dma_mask: Mask of bits of RIO address this device implements
  * @driver: Driver claiming this device
  * @dev: Device model device
  * @riores: RIO resources this device owns
@@ -196,7 +195,6 @@ struct rio_dev {
 	u32 phys_efptr;
 	u32 phys_rmap;
 	u32 em_efptr;
-	u64 dma_mask;
 	struct rio_driver *driver;	/* RIO driver claiming this device */
 	struct device dev;	/* LDM device structure */
 	struct resource riores[RIO_MAX_DEV_RESOURCES];
diff --git a/include/linux/tc.h b/include/linux/tc.h
index a60639f37963..f92511e57cdb 100644
--- a/include/linux/tc.h
+++ b/include/linux/tc.h
@@ -84,7 +84,6 @@ struct tc_dev {
 					   device. */
 	struct device	dev;		/* Generic device interface. */
 	struct resource	resource;	/* Address space of this device. */
-	u64		dma_mask;	/* DMA addressable range. */
 	char		vendor[9];
 	char		name[9];
 	char		firmware[9];
diff --git a/include/pcmcia/ds.h b/include/pcmcia/ds.h
index 3037157855f0..e7cd89adc841 100644
--- a/include/pcmcia/ds.h
+++ b/include/pcmcia/ds.h
@@ -143,7 +143,6 @@ struct pcmcia_device {
 
 	char			*prod_id[4];
 
-	u64			dma_mask;
 	struct device		dev;
 
 	/* data private to drivers */
diff --git a/include/trace/events/swiotlb.h b/include/trace/events/swiotlb.h
index 705be43b71ab..58cf67251e0a 100644
--- a/include/trace/events/swiotlb.h
+++ b/include/trace/events/swiotlb.h
@@ -26,7 +26,7 @@ TRACE_EVENT(swiotlb_bounced,
 
 	TP_fast_assign(
 		__assign_str(dev_name, dev_name(dev));
-		__entry->dma_mask = (dev->dma_mask ? *dev->dma_mask : 0);
+		__entry->dma_mask = dev->dma_mask;
 		__entry->dev_addr = dev_addr;
 		__entry->size = size;
 		__entry->swiotlb_force = swiotlb_force;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b90e1aede743..af405067e020 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -35,10 +35,10 @@ static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
 	if (!dev->dma_mask) {
 		dev_err_once(dev, "DMA map on device without dma_mask\n");
-	} else if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
+	} else if (dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
 		dev_err_once(dev,
 			"overflow %pad+%zu of DMA mask %llx bus mask %llx\n",
-			&dma_addr, size, *dev->dma_mask, dev->bus_dma_mask);
+			&dma_addr, size, dev->dma_mask, dev->bus_dma_mask);
 	}
 	WARN_ON_ONCE(1);
 }
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 1f628e7ac709..5f12cbced98c 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -328,7 +328,7 @@ int dma_set_mask(struct device *dev, u64 mask)
 
 	arch_dma_set_mask(dev, mask);
 	dma_check_mask(dev, mask);
-	*dev->dma_mask = mask;
+	dev->dma_mask = mask;
 	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 904659d14988..3213a8e6edd1 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -219,9 +219,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 
 	mutex_init(&dev->lock);
 	spin_lock_init(&dev->low_lock);
-	dev->sound.ofdev.archdata.dma_mask = macio->ofdev.archdata.dma_mask;
 	dev->sound.ofdev.dev.of_node = np;
-	dev->sound.ofdev.dev.dma_mask = &dev->sound.ofdev.archdata.dma_mask;
+	dev->sound.ofdev.dev.dma_mask = macio->ofdev.dev.dma_mask;
 	dev->sound.ofdev.dev.parent = &macio->ofdev.dev;
 	dev->sound.ofdev.dev.release = i2sbus_release_dev;
 	dev->sound.attach_codec = i2sbus_attach_codec;
diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index f77a0d5c0385..1862dae1a524 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -926,7 +926,6 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 {
 	int i, ret;
 	u64 lpar_addr, lpar_size;
-	static u64 dummy_mask;
 
 	if (WARN_ON(!firmware_has_feature(FW_FEATURE_PS3_LV1)))
 		return -ENODEV;
@@ -967,9 +966,8 @@ static int snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 		goto clean_mmio;
 	}
 
-	dummy_mask = DMA_BIT_MASK(32);
-	dev->core.dma_mask = &dummy_mask;
-	dma_set_coherent_mask(&dev->core, dummy_mask);
+	dev->core.dma_mask = DMA_BIT_MASK(32);
+	dma_set_coherent_mask(&dev->core, DMA_BIT_MASK(32));
 
 	snd_ps3_audio_set_base_addr(dev->d_region->bus_addr);
 
diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index 123ecf5479d7..6fdfbc06066c 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -202,8 +202,6 @@ static const struct snd_pcm_hardware cygnus_pcm_hw = {
 	.buffer_bytes_max = 4 * 0x8000,
 };
 
-static u64 cygnus_dma_dmamask = DMA_BIT_MASK(32);
-
 static struct cygnus_aio_port *cygnus_dai_get_dma_data(
 				struct snd_pcm_substream *substream)
 {
@@ -796,8 +794,9 @@ static int cygnus_dma_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
+	/* XXX: this should really use dma_set_mask_and_coherent().. */
 	if (!card->dev->dma_mask)
-		card->dev->dma_mask = &cygnus_dma_dmamask;
+		card->dev->dma_mask = DMA_BIT_MASK(32);
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-- 
2.20.1

