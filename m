Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E2BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B932A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEETyHeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfHLSGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:06:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfHLSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9LTr0mkdiIxl5wzdZ+E9Oacb1k7T0QqWsD3ymwcyxX8=; b=nEETyHeJHFNpuLKHauAui0iNk
        KOzrv90WtX1lao9U6E+hDhmqtWRNYIYfNQsxtTx0Y3yUUb6qhVlD+HJTR4zHFb7L/LleKfvRyZ+zl
        vnvOiXL72auBqwJq7mrWQbEQMgZdp+Gfv9JgcRF4HZNCMwjICnbXTOQqI4m/71x5vEU1Qyx+q/k/r
        /+vGiPA/73Fv8IfVc9QwFPEjrLuGIyDB44fr3sUsCBP8gTYFRBJ+A25QiZlTy1BEueRahuO+4KTdE
        lu1nRZrqdyQZk+yR2c+LHjslQnUfCivdR7PChHZFlJe4MKIqfmC/qRlxsxku4u1uPqQUeAG0+8m1f
        7OEafj2AQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxEhx-0006aQ-8z; Mon, 12 Aug 2019 18:06:13 +0000
Date:   Mon, 12 Aug 2019 11:06:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Message-ID: <20190812180613.GA18377@infradead.org>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:49:29PM +0000, Stephen Douthit wrote:
> Does anyone know the background of the original PCS workaround?

Based on a few git-blame iterations on history.git the original PCS
handling (just when initializing) goes back to this BK commit:

--
From c0835b838e76c9500facad05dc305170a1a577a8 Mon Sep 17 00:00:00 2001
From: Jeff Garzik <jgarzik@pobox.com>
Date: Thu, 14 Oct 2004 16:11:44 -0400
Subject: [libata ahci] fix several bugs

* PCI IDs from test version didn't make it into mainline... doh
* do all command setup in ->qc_prep
* phy_reset routine that does signature check
* check SATA phy for errors
* reset hardware from scratch, in case card BIOS didn't run
* implement staggered spinup by default
* adding additional debugging output
---
 drivers/scsi/ahci.c | 150 ++++++++++++++++++++++++++++++++------------
 1 file changed, 109 insertions(+), 41 deletions(-)

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e2fdeb8b857e..408ecc527b59 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -38,7 +38,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"0.10"
+#define DRV_VERSION	"0.11"
 
 
 enum {
@@ -52,6 +52,7 @@ enum {
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
 				  AHCI_RX_FIS_SZ,
 	AHCI_IRQ_ON_SG		= (1 << 31),
+	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
@@ -82,8 +83,10 @@ enum {
 	PORT_IRQ_MASK		= 0x14, /* interrupt enable/disable mask */
 	PORT_CMD		= 0x18, /* port command */
 	PORT_TFDATA		= 0x20,	/* taskfile data */
+	PORT_SIG		= 0x24,	/* device TF signature */
 	PORT_CMD_ISSUE		= 0x38, /* command issue */
 	PORT_SCR		= 0x28, /* SATA phy register block */
+	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
 	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
 	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
 
@@ -161,9 +164,9 @@ struct ahci_port_priv {
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void ahci_dma_setup(struct ata_queued_cmd *qc);
-static void ahci_dma_start(struct ata_queued_cmd *qc);
+static int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static void ahci_phy_reset(struct ata_port *ap);
 static void ahci_irq_clear(struct ata_port *ap);
 static void ahci_eng_timeout(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
@@ -202,13 +205,12 @@ static struct ata_port_operations ahci_ops = {
 	.tf_read		= ahci_tf_read,
 	.check_status		= ahci_check_status,
 	.exec_command		= ahci_exec_command,
+	.dev_select		= ata_noop_dev_select,
 
-	.phy_reset		= sata_phy_reset,
+	.phy_reset		= ahci_phy_reset,
 
-	.bmdma_setup            = ahci_dma_setup,
-	.bmdma_start            = ahci_dma_start,
 	.qc_prep		= ahci_qc_prep,
-	.qc_issue		= ata_qc_issue_prot,
+	.qc_issue		= ahci_qc_issue,
 
 	.eng_timeout		= ahci_eng_timeout,
 
@@ -236,7 +238,9 @@ static struct ata_port_info ahci_port_info[] = {
 };
 
 static struct pci_device_id ahci_pci_tbl[] = {
-	{ PCI_VENDOR_ID_INTEL, 0x0000, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci },
+	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci },
 	{ }	/* terminate list */
 };
@@ -292,6 +296,7 @@ static int ahci_port_start(struct ata_port *ap)
 		rc = -ENOMEM;
 		goto err_out_kfree;
 	}
+	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
 	pp->rx_fis = mem;
 	pp->rx_fis_dma = mem_dma;
@@ -302,7 +307,7 @@ static int ahci_port_start(struct ata_port *ap)
 	pp->cmd_tbl = mem;
 	pp->cmd_tbl_dma = mem_dma;
 
-	mem2 = mem + 128;
+	mem2 = mem + 0x80;
 	pp->cmd_tbl_sg = mem2;
 
 	mem += AHCI_CMD_TBL_SZ;
@@ -398,6 +403,29 @@ static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
 	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
+static void ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	struct ata_taskfile tf;
+	struct ata_device *dev = &ap->device[0];
+	u32 tmp;
+
+	__sata_phy_reset(ap);
+
+	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+		return;
+
+	tmp = readl(port_mmio + PORT_SIG);
+	tf.lbah		= (tmp >> 24)	& 0xff;
+	tf.lbam		= (tmp >> 16)	& 0xff;
+	tf.lbal		= (tmp >> 8)	& 0xff;
+	tf.nsect	= (tmp)		& 0xff;
+
+	dev->class = ata_dev_classify(&tf);
+	if (!ata_dev_present(dev))
+		ata_port_disable(ap);
+}
+
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void *mmio = (void *) ap->ioaddr.cmd_addr;
@@ -424,7 +452,7 @@ static void ahci_fill_sg(struct ata_queued_cmd *qc)
 
 		pp->cmd_tbl_sg[i].addr = cpu_to_le32(addr & 0xffffffff);
 		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len);
+		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
 	}
 }
 
@@ -442,6 +470,19 @@ static void ahci_qc_prep(struct ata_queued_cmd *qc)
 	opts = (qc->n_elem << 16) | cmd_fis_len;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_NODATA:
+	case ATA_PROT_ATAPI_DMA:
+		opts |= AHCI_CMD_ATAPI;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
 	pp->cmd_slot->opts = cpu_to_le32(opts);
 	pp->cmd_slot->status = 0;
 	pp->cmd_slot->tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
@@ -547,11 +588,12 @@ static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
 	void *mmio = ap->host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
-	u32 status, ci;
+	u32 status, serr, ci;
+
+	serr = readl(port_mmio + PORT_SCR_ERR);
+	writel(serr, port_mmio + PORT_SCR_ERR);
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
-	if (!status)
-		return 0;
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
 	ci = readl(port_mmio + PORT_CMD_ISSUE);
@@ -624,18 +666,15 @@ static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *
 	return IRQ_RETVAL(handled);
 }
 
-static void ahci_dma_setup(struct ata_queued_cmd *qc)
-{
-	/* do nothing... for now */
-}
-
-static void ahci_dma_start(struct ata_queued_cmd *qc)
+static int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void *mmio = (void *) ap->ioaddr.cmd_addr;
 
 	writel(1, mmio + PORT_CMD_ISSUE);
 	readl(mmio + PORT_CMD_ISSUE);	/* flush */
+
+	return 0;
 }
 
 static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
@@ -663,20 +702,30 @@ static void ahci_exec_command(struct ata_port *ap, struct ata_taskfile *tf)
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
 			    unsigned int port_idx)
 {
+	VPRINTK("ENTER, base==0x%lx, port_idx %u\n", base, port_idx);
 	base = ahci_port_base_ul(base, port_idx);
+	VPRINTK("base now==0x%lx\n", base);
 
 	port->cmd_addr		= base;
 	port->scr_addr		= base + PORT_SCR;
+
+	VPRINTK("EXIT\n");
 }
 
 static int ahci_host_init(struct ata_probe_ent *probe_ent)
 {
 	struct ahci_host_priv *hpriv = probe_ent->private_data;
 	struct pci_dev *pdev = probe_ent->pdev;
-	void *mmio = probe_ent->mmio_base;
-	u32 tmp;
-	unsigned int i, using_dac;
+	void __iomem *mmio = probe_ent->mmio_base;
+	u32 tmp, cap_save;
+	u16 tmp16;
+	unsigned int i, j, using_dac;
 	int rc;
+	void __iomem *port_mmio;
+
+	cap_save = readl(mmio + HOST_CAP);
+	cap_save &= ( (1<<28) | (1<<17) );
+	cap_save |= (1 << 27);
 
 	/* global controller reset */
 	tmp = readl(mmio + HOST_CTL);
@@ -698,23 +747,22 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 		return -EIO;
 	}
 
-	/* make sure we're in AHCI mode, with irq disabled */
-	if ((tmp & (HOST_AHCI_EN | HOST_IRQ_EN)) != HOST_AHCI_EN) {
-		tmp |= HOST_AHCI_EN;
-		tmp &= ~HOST_IRQ_EN;
-		writel(tmp, mmio + HOST_CTL);
-		readl(mmio + HOST_CTL); /* flush */
-	}
-	tmp = readl(mmio + HOST_CTL);
-	if ((tmp & (HOST_AHCI_EN | HOST_IRQ_EN)) != HOST_AHCI_EN) {
-		printk(KERN_ERR DRV_NAME "(%s): AHCI enable failed (0x%x)\n",
-			pci_name(pdev), tmp);
-		return -EIO;
-	}
+	writel(HOST_AHCI_EN, mmio + HOST_CTL);
+	(void) readl(mmio + HOST_CTL);	/* flush */
+	writel(cap_save, mmio + HOST_CAP);
+	writel(0xf, mmio + HOST_PORTS_IMPL);
+	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
+
+	pci_read_config_word(pdev, 0x92, &tmp16);
+	tmp16 |= 0xf;
+	pci_write_config_word(pdev, 0x92, tmp16);
 
 	hpriv->cap = readl(mmio + HOST_CAP);
 	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
-	probe_ent->n_ports = hpriv->cap & 0x1f;
+	probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
+
+	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
+		hpriv->cap, hpriv->port_map, probe_ent->n_ports);
 
 	using_dac = hpriv->cap & HOST_CAP_64;
 	if (using_dac &&
@@ -746,18 +794,18 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 	}
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
-		void *port_mmio;
-
 		if (!(hpriv->port_map & (1 << i)))
 			continue;
 
 		port_mmio = ahci_port_base(mmio, i);
+		VPRINTK("mmio %p  port_mmio %p\n", mmio, port_mmio);
 
 		ahci_setup_port(&probe_ent->port[i],
 				(unsigned long) mmio, i);
 
 		/* make sure port is not active */
 		tmp = readl(port_mmio + PORT_CMD);
+		VPRINTK("PORT_CMD 0x%x\n", tmp);
 		if (tmp & (PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
 			   PORT_CMD_FIS_RX | PORT_CMD_START)) {
 			tmp &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON |
@@ -772,14 +820,27 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 			schedule_timeout((HZ / 2) + 1);
 		}
 
+		writel(PORT_CMD_SPIN_UP, port_mmio + PORT_CMD);
+
+		j = 0;
+		while (j < 100) {
+			msleep(10);
+			tmp = readl(port_mmio + PORT_SCR_STAT);
+			if ((tmp & 0xf) == 0x3)
+				break;
+			j++;
+		}
+
+		tmp = readl(port_mmio + PORT_SCR_ERR);
+		VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
+		writel(tmp, port_mmio + PORT_SCR_ERR);
+
 		/* ack any pending irq events for this port */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
+		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 
-		tmp = readl(port_mmio + PORT_SCR_ERR);
-		writel(tmp, port_mmio + PORT_SCR_ERR);
-
 		writel(1 << i, mmio + HOST_IRQ_STAT);
 
 		/* set irq mask (enables interrupts) */
@@ -787,7 +848,10 @@ static int ahci_host_init(struct ata_probe_ent *probe_ent)
 	}
 
 	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
+	tmp = readl(mmio + HOST_CTL);
+	VPRINTK("HOST_CTL 0x%x\n", tmp);
 
 	pci_set_master(pdev);
 
@@ -830,10 +894,12 @@ static void ahci_print_info(struct ata_probe_ent *probe_ent)
 		"%u slots %u ports %s Gbps 0x%x impl\n"
 	       	,
 	       	pci_name(pdev),
+
 	       	(vers >> 24) & 0xff,
 	       	(vers >> 16) & 0xff,
 	       	(vers >> 8) & 0xff,
 	       	vers & 0xff,
+
 		((cap >> 8) & 0x1f) + 1,
 		(cap & 0x1f) + 1,
 		speed_s,
@@ -872,6 +938,8 @@ static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int rc;
 
+	VPRINTK("ENTER\n");
+
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
-- 
2.20.1

