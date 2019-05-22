Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB58C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F112173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="WtPMFVf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfEVU7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:59:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34070 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfEVU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id j24so3421831ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0VeuFD/Da6X42kP1jd0Ruvpg6qBgEbjHndZrYVj8Wo=;
        b=WtPMFVf05FvcCAnpiK9FtZJ+yVhsB/KWfnp1ziiY3npcr8Mav3V0XU47nSJHzOnUQp
         mb/8/7OOsirYx7iiObwkIPdTPmftA7ysXnydIojfOWQh7HjSMQdhLeqisXdKt4E+6zck
         7hOwkKFsA+Bc+D4wcWcIv9vvzMAV3wF91GNMF5lfHc+ccCIuZY491MccPHCVXNghTe8D
         6puSNZ8oj67/LHK8lSKtchZHk1EhquwlhI+1FpDpyQeiuBrpVSf8twXPnjbvLz1Oa5GT
         xZT5SLvhAPNZYI+N644iJKELQ8KNG+W2+EGP0D3TJg5uqSCGVKMcejmGMaDjQ0StQTqY
         1fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G0VeuFD/Da6X42kP1jd0Ruvpg6qBgEbjHndZrYVj8Wo=;
        b=f3oHB1giYYriPvJ+qX4Q4pmrjhycZzhhZi14UBIBtei3M4UdGx988STmzMzedHu2eq
         Z3Wg58HE4BGJkxvidL4vf6r/3DGU6smRtgDqOPMYe7VQ8rrLM/sd2vf+g4E/XxYXZGOB
         ztkPYr0HAUNqyUnUMQe7Nmo5PXTzi5Lj09Id0NJ5VwiHA3FI+4Btr08oE5BCzY3Pf4Ip
         D4x5N3iv8B5tFw/pDriW7Tt97N/dxjiAjEJtUJNbZr16SUzZm4U2mIGV4GsQ7XCW3cxn
         icJnu21TKVINSTPEsU5MNwsgobdDx0V/DCrN5rWm0C/MdjR68MpJb1m0ayFyEuy7SHWr
         wLBg==
X-Gm-Message-State: APjAAAWEmsZ/I/6uOHzAYz2mYn1KLqNFvyU6yDGSBozVcD+1tOJeIrSU
        Wf+1BxhFXk62CxMwQBmFWoDgBQ==
X-Google-Smtp-Source: APXvYqyQ/00hVW+0SnRGHwMegiy5vyLC2Yot/HAnRXe/ecT7f7m4kEpn3PKlXMHHx2iNLSNb01DaxQ==
X-Received: by 2002:a2e:9e14:: with SMTP id e20mr30868527ljk.172.1558558750525;
        Wed, 22 May 2019 13:59:10 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:10 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 1/6] staging: kpc2000: fix indent in cell_probe.c
Date:   Wed, 22 May 2019 22:58:44 +0200
Message-Id: <20190522205849.17444-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522205849.17444-1-simon@nikanor.nu>
References: <20190522205849.17444-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs instead of spaces for indentation.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 574 +++++++++----------
 1 file changed, 287 insertions(+), 287 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 0181b0a8ff82..6e034d115b47 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -25,7 +25,7 @@
  *                                                              D                   C2S DMA Present
  *                                                               DDD                C2S DMA Channel Number    [up to 8 channels]
  *                                                                  II              IRQ Count [0 to 3 IRQs per core]
-                                                                      1111111000
+ *                                                                    1111111000
  *                                                                    IIIIIII       IRQ Base Number [up to 128 IRQs per card]
  *                                                                           ___    Spare
  *
@@ -40,45 +40,45 @@
 #define KP_CORE_ID_SPI          5
 
 struct core_table_entry {
-    u16     type;
-    u32     offset;
-    u32     length;
-    bool    s2c_dma_present;
-    u8      s2c_dma_channel_num;
-    bool    c2s_dma_present;
-    u8      c2s_dma_channel_num;
-    u8      irq_count;
-    u8      irq_base_num;
+	u16  type;
+	u32  offset;
+	u32  length;
+	bool s2c_dma_present;
+	u8   s2c_dma_channel_num;
+	bool c2s_dma_present;
+	u8   c2s_dma_channel_num;
+	u8   irq_count;
+	u8   irq_base_num;
 };
 
 static
 void  parse_core_table_entry_v0(struct core_table_entry *cte, const u64 read_val)
 {
-    cte->type                = ((read_val & 0xFFF0000000000000) >> 52);
-    cte->offset              = ((read_val & 0x00000000FFFF0000) >> 16) * 4096;
-    cte->length              = ((read_val & 0x0000FFFF00000000) >> 32) * 8;
-    cte->s2c_dma_present     = ((read_val & 0x0008000000000000) >> 51);
-    cte->s2c_dma_channel_num = ((read_val & 0x0007000000000000) >> 48);
-    cte->c2s_dma_present     = ((read_val & 0x0000000000008000) >> 15);
-    cte->c2s_dma_channel_num = ((read_val & 0x0000000000007000) >> 12);
-    cte->irq_count           = ((read_val & 0x0000000000000C00) >> 10);
-    cte->irq_base_num        = ((read_val & 0x00000000000003F8) >>  3);
+	cte->type                = ((read_val & 0xFFF0000000000000) >> 52);
+	cte->offset              = ((read_val & 0x00000000FFFF0000) >> 16) * 4096;
+	cte->length              = ((read_val & 0x0000FFFF00000000) >> 32) * 8;
+	cte->s2c_dma_present     = ((read_val & 0x0008000000000000) >> 51);
+	cte->s2c_dma_channel_num = ((read_val & 0x0007000000000000) >> 48);
+	cte->c2s_dma_present     = ((read_val & 0x0000000000008000) >> 15);
+	cte->c2s_dma_channel_num = ((read_val & 0x0000000000007000) >> 12);
+	cte->irq_count           = ((read_val & 0x0000000000000C00) >> 10);
+	cte->irq_base_num        = ((read_val & 0x00000000000003F8) >>  3);
 }
 
 static
 void dbg_cte(struct kp2000_device *pcard, struct core_table_entry *cte)
 {
-    dev_dbg(&pcard->pdev->dev, "CTE: type:%3d  offset:%3d (%3d)  length:%3d (%3d)  s2c:%d  c2s:%d  irq_count:%d  base_irq:%d\n",
-        cte->type,
-        cte->offset,
-        cte->offset / 4096,
-        cte->length,
-        cte->length / 8,
-        (cte->s2c_dma_present ? cte->s2c_dma_channel_num : -1),
-        (cte->c2s_dma_present ? cte->c2s_dma_channel_num : -1),
-        cte->irq_count,
-        cte->irq_base_num
-    );
+	dev_dbg(&pcard->pdev->dev, "CTE: type:%3d  offset:%3d (%3d)  length:%3d (%3d)  s2c:%d  c2s:%d  irq_count:%d  base_irq:%d\n",
+		cte->type,
+		cte->offset,
+		cte->offset / 4096,
+		cte->length,
+		cte->length / 8,
+		(cte->s2c_dma_present ? cte->s2c_dma_channel_num : -1),
+		(cte->c2s_dma_present ? cte->c2s_dma_channel_num : -1),
+		cte->irq_count,
+		cte->irq_base_num
+	);
 }
 
 static
@@ -94,55 +94,55 @@ void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, co
 static int probe_core_basic(unsigned int core_num, struct kp2000_device *pcard,
 			    char *name, const struct core_table_entry cte)
 {
-    struct mfd_cell  cell = { .id = core_num, .name = name };
-    struct resource  resources[2];
+	struct mfd_cell  cell = { .id = core_num, .name = name };
+	struct resource resources[2];
 
-    struct kpc_core_device_platdata  core_pdata = {
-        .card_id           = pcard->card_id,
-        .build_version     = pcard->build_version,
-        .hardware_revision = pcard->hardware_revision,
-        .ssid              = pcard->ssid,
-        .ddna              = pcard->ddna,
-    };
+	struct kpc_core_device_platdata core_pdata = {
+		.card_id           = pcard->card_id,
+		.build_version     = pcard->build_version,
+		.hardware_revision = pcard->hardware_revision,
+		.ssid              = pcard->ssid,
+		.ddna              = pcard->ddna,
+	};
 
-    dev_dbg(&pcard->pdev->dev, "Found Basic core: type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
+	dev_dbg(&pcard->pdev->dev, "Found Basic core: type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
 
-    cell.platform_data = &core_pdata;
-    cell.pdata_size = sizeof(struct kpc_core_device_platdata);
-    cell.num_resources = 2;
+	cell.platform_data = &core_pdata;
+	cell.pdata_size = sizeof(struct kpc_core_device_platdata);
+	cell.num_resources = 2;
 
-    memset(&resources, 0, sizeof(resources));
+	memset(&resources, 0, sizeof(resources));
 
-    resources[0].start = cte.offset;
-    resources[0].end   = cte.offset + (cte.length - 1);
-    resources[0].flags = IORESOURCE_MEM;
+	resources[0].start = cte.offset;
+	resources[0].end   = cte.offset + (cte.length - 1);
+	resources[0].flags = IORESOURCE_MEM;
 
-    resources[1].start = pcard->pdev->irq;
-    resources[1].end   = pcard->pdev->irq;
-    resources[1].flags = IORESOURCE_IRQ;
+	resources[1].start = pcard->pdev->irq;
+	resources[1].end   = pcard->pdev->irq;
+	resources[1].flags = IORESOURCE_IRQ;
 
-    cell.resources = resources;
+	cell.resources = resources;
 
-    return mfd_add_devices(
-        PCARD_TO_DEV(pcard),    // parent
-        pcard->card_num * 100,  // id
-        &cell,                  // struct mfd_cell *
-        1,                      // ndevs
-        &pcard->regs_base_resource,
-        0,                      // irq_base
-        NULL                    // struct irq_domain *
-    );
+	return mfd_add_devices(
+		PCARD_TO_DEV(pcard),    // parent
+		pcard->card_num * 100,  // id
+		&cell,                  // struct mfd_cell *
+		1,                      // ndevs
+		&pcard->regs_base_resource,
+		0,                      // irq_base
+		NULL                    // struct irq_domain *
+	);
 }
 
 
 struct kpc_uio_device {
-    struct list_head list;
-    struct kp2000_device *pcard;
-    struct device  *dev;
-    struct uio_info uioinfo;
-    struct core_table_entry cte;
-    u16 core_num;
+	struct list_head list;
+	struct kp2000_device *pcard;
+	struct device  *dev;
+	struct uio_info uioinfo;
+	struct core_table_entry cte;
+	u16 core_num;
 };
 
 static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
@@ -238,273 +238,273 @@ struct attribute *kpc_uio_class_attrs[] = {
 static
 int  kp2000_check_uio_irq(struct kp2000_device *pcard, u32 irq_num)
 {
-    u64 interrupt_active   =  readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
-    u64 interrupt_mask_inv = ~readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
-    u64 irq_check_mask = (1 << irq_num);
-    if (interrupt_active & irq_check_mask){ // if it's active (interrupt pending)
-        if (interrupt_mask_inv & irq_check_mask){    // and if it's not masked off
-            return 1;
-        }
-    }
-    return 0;
+	u64 interrupt_active   =  readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
+	u64 interrupt_mask_inv = ~readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
+	u64 irq_check_mask = (1 << irq_num);
+	if (interrupt_active & irq_check_mask){ // if it's active (interrupt pending)
+		if (interrupt_mask_inv & irq_check_mask){    // and if it's not masked off
+			return 1;
+		}
+	}
+	return 0;
 }
 
 static
 irqreturn_t  kuio_handler(int irq, struct uio_info *uioinfo)
 {
-    struct kpc_uio_device *kudev = uioinfo->priv;
-    if (irq != kudev->pcard->pdev->irq)
-        return IRQ_NONE;
-
-    if (kp2000_check_uio_irq(kudev->pcard, kudev->cte.irq_base_num)){
-        writeq((1 << kudev->cte.irq_base_num), kudev->pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE); // Clear the active flag
-        return IRQ_HANDLED;
-    }
-    return IRQ_NONE;
+	struct kpc_uio_device *kudev = uioinfo->priv;
+	if (irq != kudev->pcard->pdev->irq)
+		return IRQ_NONE;
+
+	if (kp2000_check_uio_irq(kudev->pcard, kudev->cte.irq_base_num)){
+		writeq((1 << kudev->cte.irq_base_num), kudev->pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE); // Clear the active flag
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
 }
 
 static
 int kuio_irqcontrol(struct uio_info *uioinfo, s32 irq_on)
 {
-    struct kpc_uio_device *kudev = uioinfo->priv;
-    struct kp2000_device *pcard = kudev->pcard;
-    u64 mask;
+	struct kpc_uio_device *kudev = uioinfo->priv;
+	struct kp2000_device *pcard = kudev->pcard;
+	u64 mask;
 
 	mutex_lock(&pcard->sem);
-    mask = readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
-    if (irq_on){
-        mask &= ~(1 << (kudev->cte.irq_base_num));
-    } else {
-        mask |= (1 << (kudev->cte.irq_base_num));
-    }
-    writeq(mask, pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
+	mask = readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
+	if (irq_on){
+		mask &= ~(1 << (kudev->cte.irq_base_num));
+	} else {
+		mask |= (1 << (kudev->cte.irq_base_num));
+	}
+	writeq(mask, pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	mutex_unlock(&pcard->sem);
 
-    return 0;
+	return 0;
 }
 
 static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 			  char *name, const struct core_table_entry cte)
 {
-    struct kpc_uio_device  *kudev;
-    int rv;
-
-    dev_dbg(&pcard->pdev->dev, "Found UIO core:   type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
-
-    kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
-    if (!kudev){
-        dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
-        return -ENOMEM;
-    }
-
-    INIT_LIST_HEAD(&kudev->list);
-    kudev->pcard = pcard;
-    kudev->cte = cte;
-    kudev->core_num = core_num;
-
-    kudev->uioinfo.priv = kudev;
-    kudev->uioinfo.name = name;
-    kudev->uioinfo.version = "0.0";
-    if (cte.irq_count > 0){
-        kudev->uioinfo.irq_flags = IRQF_SHARED;
-        kudev->uioinfo.irq = pcard->pdev->irq;
-        kudev->uioinfo.handler = kuio_handler;
-        kudev->uioinfo.irqcontrol = kuio_irqcontrol;
-    } else {
-        kudev->uioinfo.irq = 0;
-    }
-
-    kudev->uioinfo.mem[0].name = "uiomap";
-    kudev->uioinfo.mem[0].addr = pci_resource_start(pcard->pdev, REG_BAR) + cte.offset;
-    kudev->uioinfo.mem[0].size = (cte.length + PAGE_SIZE-1) & ~(PAGE_SIZE-1); // Round up to nearest PAGE_SIZE boundary
-    kudev->uioinfo.mem[0].memtype = UIO_MEM_PHYS;
-
-    kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0,0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
-    if (IS_ERR(kudev->dev)) {
-        dev_err(&pcard->pdev->dev, "probe_core_uio device_create failed!\n");
-        kfree(kudev);
-        return -ENODEV;
-    }
-    dev_set_drvdata(kudev->dev, kudev);
-
-    rv = uio_register_device(kudev->dev, &kudev->uioinfo);
-    if (rv){
-        dev_err(&pcard->pdev->dev, "probe_core_uio failed uio_register_device: %d\n", rv);
-        put_device(kudev->dev);
-        kfree(kudev);
-        return rv;
-    }
-
-    list_add_tail(&kudev->list, &pcard->uio_devices_list);
-
-    return 0;
+	struct kpc_uio_device *kudev;
+	int rv;
+
+	dev_dbg(&pcard->pdev->dev, "Found UIO core:   type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
+
+	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
+	if (!kudev){
+		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&kudev->list);
+	kudev->pcard = pcard;
+	kudev->cte = cte;
+	kudev->core_num = core_num;
+
+	kudev->uioinfo.priv = kudev;
+	kudev->uioinfo.name = name;
+	kudev->uioinfo.version = "0.0";
+	if (cte.irq_count > 0){
+		kudev->uioinfo.irq_flags = IRQF_SHARED;
+		kudev->uioinfo.irq = pcard->pdev->irq;
+		kudev->uioinfo.handler = kuio_handler;
+		kudev->uioinfo.irqcontrol = kuio_irqcontrol;
+	} else {
+		kudev->uioinfo.irq = 0;
+	}
+
+	kudev->uioinfo.mem[0].name = "uiomap";
+	kudev->uioinfo.mem[0].addr = pci_resource_start(pcard->pdev, REG_BAR) + cte.offset;
+	kudev->uioinfo.mem[0].size = (cte.length + PAGE_SIZE-1) & ~(PAGE_SIZE-1); // Round up to nearest PAGE_SIZE boundary
+	kudev->uioinfo.mem[0].memtype = UIO_MEM_PHYS;
+
+	kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0,0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
+	if (IS_ERR(kudev->dev)) {
+		dev_err(&pcard->pdev->dev, "probe_core_uio device_create failed!\n");
+		kfree(kudev);
+		return -ENODEV;
+	}
+	dev_set_drvdata(kudev->dev, kudev);
+
+	rv = uio_register_device(kudev->dev, &kudev->uioinfo);
+	if (rv){
+		dev_err(&pcard->pdev->dev, "probe_core_uio failed uio_register_device: %d\n", rv);
+		put_device(kudev->dev);
+		kfree(kudev);
+		return rv;
+	}
+
+	list_add_tail(&kudev->list, &pcard->uio_devices_list);
+
+	return 0;
 }
 
 
 static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_regs_offset, int engine_num, int irq_num)
 {
-    struct mfd_cell  cell = { .id = engine_num };
-    struct resource  resources[2];
+	struct mfd_cell  cell = { .id = engine_num };
+	struct resource  resources[2];
 
-    dev_dbg(&pcard->pdev->dev, "create_dma_core(pcard = [%p], engine_regs_offset = %zx, engine_num = %d)\n", pcard, engine_regs_offset, engine_num);
+	dev_dbg(&pcard->pdev->dev, "create_dma_core(pcard = [%p], engine_regs_offset = %zx, engine_num = %d)\n", pcard, engine_regs_offset, engine_num);
 
-    cell.platform_data = NULL;
-    cell.pdata_size = 0;
-    cell.name = KP_DRIVER_NAME_DMA_CONTROLLER;
-    cell.num_resources = 2;
+	cell.platform_data = NULL;
+	cell.pdata_size = 0;
+	cell.name = KP_DRIVER_NAME_DMA_CONTROLLER;
+	cell.num_resources = 2;
 
-    memset(&resources, 0, sizeof(resources));
+	memset(&resources, 0, sizeof(resources));
 
-    resources[0].start = engine_regs_offset;
-    resources[0].end   = engine_regs_offset + (KPC_DMA_ENGINE_SIZE - 1);
-    resources[0].flags = IORESOURCE_MEM;
+	resources[0].start = engine_regs_offset;
+	resources[0].end   = engine_regs_offset + (KPC_DMA_ENGINE_SIZE - 1);
+	resources[0].flags = IORESOURCE_MEM;
 
-    resources[1].start = irq_num;
-    resources[1].end   = irq_num;
-    resources[1].flags = IORESOURCE_IRQ;
+	resources[1].start = irq_num;
+	resources[1].end   = irq_num;
+	resources[1].flags = IORESOURCE_IRQ;
 
-    cell.resources = resources;
+	cell.resources = resources;
 
-    return mfd_add_devices(
-        PCARD_TO_DEV(pcard),    // parent
-        pcard->card_num * 100,  // id
-        &cell,                  // struct mfd_cell *
-        1,                      // ndevs
-        &pcard->dma_base_resource,
-        0,                      // irq_base
-        NULL                    // struct irq_domain *
-    );
+	return mfd_add_devices(
+		PCARD_TO_DEV(pcard),    // parent
+		pcard->card_num * 100,  // id
+		&cell,                  // struct mfd_cell *
+		1,                      // ndevs
+		&pcard->dma_base_resource,
+		0,                      // irq_base
+		NULL                    // struct irq_domain *
+	);
 }
 
 static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 {
-    int err;
-    unsigned int i;
-    u64 capabilities_reg;
-
-    // S2C Engines
-    for (i = 0 ; i < 32 ; i++){
-        capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
-        if (capabilities_reg & ENGINE_CAP_PRESENT_MASK){
-            err = create_dma_engine_core(pcard, (KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), i,  pcard->pdev->irq);
-            if (err) goto err_out;
-        }
-    }
-    // C2S Engines
-    for (i = 0 ; i < 32 ; i++){
-        capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
-        if (capabilities_reg & ENGINE_CAP_PRESENT_MASK){
-            err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32+i,  pcard->pdev->irq);
-            if (err) goto err_out;
-        }
-    }
-
-    return 0;
+	int err;
+	unsigned int i;
+	u64 capabilities_reg;
+
+	// S2C Engines
+	for (i = 0 ; i < 32 ; i++){
+		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
+		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK){
+			err = create_dma_engine_core(pcard, (KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), i,  pcard->pdev->irq);
+			if (err) goto err_out;
+		}
+	}
+	// C2S Engines
+	for (i = 0 ; i < 32 ; i++){
+		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
+		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK){
+			err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32+i,  pcard->pdev->irq);
+			if (err) goto err_out;
+		}
+	}
+
+	return 0;
 
 err_out:
-    dev_err(&pcard->pdev->dev, "kp2000_setup_dma_controller: failed to add a DMA Engine: %d\n", err);
-    return err;
+	dev_err(&pcard->pdev->dev, "kp2000_setup_dma_controller: failed to add a DMA Engine: %d\n", err);
+	return err;
 }
 
 int  kp2000_probe_cores(struct kp2000_device *pcard)
 {
-    int err = 0;
-    int i;
-    int current_type_id;
-    u64 read_val;
-    unsigned int highest_core_id = 0;
-    struct core_table_entry cte;
-
-    dev_dbg(&pcard->pdev->dev, "kp2000_probe_cores(pcard = %p / %d)\n", pcard, pcard->card_num);
-
-    err = kp2000_setup_dma_controller(pcard);
-    if (err) return err;
-
-    INIT_LIST_HEAD(&pcard->uio_devices_list);
-
-    // First, iterate the core table looking for the highest CORE_ID
-    for (i = 0 ; i < pcard->core_table_length ; i++){
-        read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
-        parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
-        dbg_cte(pcard, &cte);
-        if (cte.type > highest_core_id){
-            highest_core_id = cte.type;
-        }
-        if (cte.type == KP_CORE_ID_INVALID){
-            dev_info(&pcard->pdev->dev, "Found Invalid core: %016llx\n", read_val);
-        }
-    }
-    // Then, iterate over the possible core types.
-    for (current_type_id = 1 ; current_type_id <= highest_core_id ; current_type_id++){
-        unsigned int core_num = 0;
-        // Foreach core type, iterate the whole table and instantiate subdevices for each core.
-        // Yes, this is O(n*m) but the actual runtime is small enough that it's an acceptable tradeoff.
-        for (i = 0 ; i < pcard->core_table_length ; i++){
-            read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
-            parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
-
-            if (cte.type != current_type_id)
-                continue;
-
-            switch (cte.type) {
-            case KP_CORE_ID_I2C:
-                err = probe_core_basic(core_num, pcard,
-                                       KP_DRIVER_NAME_I2C, cte);
-                break;
-
-            case KP_CORE_ID_SPI:
-                err = probe_core_basic(core_num, pcard,
-                                       KP_DRIVER_NAME_SPI, cte);
-                break;
-
-            default:
-                err = probe_core_uio(core_num, pcard, "kpc_uio", cte);
-                break;
-            }
-            if (err) {
-                dev_err(&pcard->pdev->dev,
-                        "kp2000_probe_cores: failed to add core %d: %d\n",
-                        i, err);
-                goto error;
-            }
-            core_num++;
-        }
-    }
-
-    // Finally, instantiate a UIO device for the core_table.
-    cte.type                = 0; // CORE_ID_BOARD_INFO
-    cte.offset              = 0; // board info is always at the beginning
-    cte.length              = 512*8;
-    cte.s2c_dma_present     = false;
-    cte.s2c_dma_channel_num = 0;
-    cte.c2s_dma_present     = false;
-    cte.c2s_dma_channel_num = 0;
-    cte.irq_count           = 0;
-    cte.irq_base_num        = 0;
-    err = probe_core_uio(0, pcard, "kpc_uio", cte);
-    if (err){
-        dev_err(&pcard->pdev->dev, "kp2000_probe_cores: failed to add board_info core: %d\n", err);
-        goto error;
-    }
-
-    return 0;
+	int err = 0;
+	int i;
+	int current_type_id;
+	u64 read_val;
+	unsigned int highest_core_id = 0;
+	struct core_table_entry cte;
+
+	dev_dbg(&pcard->pdev->dev, "kp2000_probe_cores(pcard = %p / %d)\n", pcard, pcard->card_num);
+
+	err = kp2000_setup_dma_controller(pcard);
+	if (err) return err;
+
+	INIT_LIST_HEAD(&pcard->uio_devices_list);
+
+	// First, iterate the core table looking for the highest CORE_ID
+	for (i = 0 ; i < pcard->core_table_length ; i++){
+		read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
+		parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
+		dbg_cte(pcard, &cte);
+		if (cte.type > highest_core_id){
+			highest_core_id = cte.type;
+		}
+		if (cte.type == KP_CORE_ID_INVALID){
+			dev_info(&pcard->pdev->dev, "Found Invalid core: %016llx\n", read_val);
+		}
+	}
+	// Then, iterate over the possible core types.
+	for (current_type_id = 1 ; current_type_id <= highest_core_id ; current_type_id++){
+		unsigned int core_num = 0;
+		// Foreach core type, iterate the whole table and instantiate subdevices for each core.
+		// Yes, this is O(n*m) but the actual runtime is small enough that it's an acceptable tradeoff.
+		for (i = 0 ; i < pcard->core_table_length ; i++){
+			read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
+			parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
+
+			if (cte.type != current_type_id)
+				continue;
+
+			switch (cte.type) {
+			case KP_CORE_ID_I2C:
+				err = probe_core_basic(core_num, pcard,
+				KP_DRIVER_NAME_I2C, cte);
+				break;
+
+			case KP_CORE_ID_SPI:
+				err = probe_core_basic(core_num, pcard,
+						       KP_DRIVER_NAME_SPI, cte);
+				break;
+
+			default:
+				err = probe_core_uio(core_num, pcard, "kpc_uio", cte);
+				break;
+			}
+			if (err) {
+				dev_err(&pcard->pdev->dev,
+					"kp2000_probe_cores: failed to add core %d: %d\n",
+					i, err);
+				goto error;
+			}
+			core_num++;
+		}
+	}
+
+	// Finally, instantiate a UIO device for the core_table.
+	cte.type                = 0; // CORE_ID_BOARD_INFO
+	cte.offset              = 0; // board info is always at the beginning
+	cte.length              = 512*8;
+	cte.s2c_dma_present     = false;
+	cte.s2c_dma_channel_num = 0;
+	cte.c2s_dma_present     = false;
+	cte.c2s_dma_channel_num = 0;
+	cte.irq_count           = 0;
+	cte.irq_base_num        = 0;
+	err = probe_core_uio(0, pcard, "kpc_uio", cte);
+	if (err){
+		dev_err(&pcard->pdev->dev, "kp2000_probe_cores: failed to add board_info core: %d\n", err);
+		goto error;
+	}
+
+	return 0;
 
 error:
-    kp2000_remove_cores(pcard);
-    mfd_remove_devices(PCARD_TO_DEV(pcard));
-    return err;
+	kp2000_remove_cores(pcard);
+	mfd_remove_devices(PCARD_TO_DEV(pcard));
+	return err;
 }
 
 void  kp2000_remove_cores(struct kp2000_device *pcard)
 {
-    struct list_head *ptr;
-    struct list_head *next;
-    list_for_each_safe(ptr, next, &pcard->uio_devices_list){
-        struct kpc_uio_device *kudev = list_entry(ptr, struct kpc_uio_device, list);
-        uio_unregister_device(&kudev->uioinfo);
-        device_unregister(kudev->dev);
-        list_del(&kudev->list);
-        kfree(kudev);
-    }
+	struct list_head *ptr;
+	struct list_head *next;
+	list_for_each_safe(ptr, next, &pcard->uio_devices_list){
+		struct kpc_uio_device *kudev = list_entry(ptr, struct kpc_uio_device, list);
+		uio_unregister_device(&kudev->uioinfo);
+		device_unregister(kudev->dev);
+		list_del(&kudev->list);
+		kfree(kudev);
+	}
 }
 
-- 
2.20.1

