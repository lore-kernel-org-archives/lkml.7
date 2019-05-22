Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3807F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="0njuu7hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfEVU7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:59:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41113 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfEVU7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id q16so3402085ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVlv+HOW1ObMs3EOqU5WzUaoxHb9zn3yPdF2ax6ERWY=;
        b=0njuu7hQP9XzfrhXBHvyuvKNB+aF7JKc7ZtS00wEhgr33vA7gyZq8g80oMpZIyrJRg
         nxX/2YvYSsNefwWIiB8V8n1UDRLMMHFT/4g0Sk8ACK75gdJ+B8i3YeUmqPgLfzEnJZlJ
         CDbVR1uxpUhBFg4YgXYJJif8ddGjuwmzXtJPvBs4zxMWD1tV06YFtRA681ASq97Qb5fF
         c/dH1MaGs8dgAa2NrcP1RvGRMOddvjOQVUafSJP8NsLUYObgryjN0hNrdJHQ7QucXI/P
         8ZihS6WfTxPE+cBlbcPneH3LURT+uXIhRJXKfd68q2EJetCO9b8iRO+dpWO47vzB0tvi
         sbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVlv+HOW1ObMs3EOqU5WzUaoxHb9zn3yPdF2ax6ERWY=;
        b=mve4mXy8ChvVgAZLa0i3MMr7XdHM94KGaWQnUefOuYAMoUkF0bX5cenFf8KhYC8V4M
         Cyga6MB1CaAig4oJc6L/Eo6Mv+Y62LHcU5hmdnUwLcpTuzD4DOHO2l4RjUj8vgfUhV2V
         o5pMtTMMdn6Ha7PbtswPX8LoO9+FDSoEztU1kxlnst29b5G96jqvxO+7txoFl2hDUOuR
         ztW9BFiggRxfgV6bEu8A3IaesPVj6ew4qmFoSt4SUT/B65RzP7oNTxKxT4qZVzOdigQy
         iEw0fM3mxZ1SgaqHZqEiYvZHlPqYUUvafAJYhJijYJ4ieyZvROeEej/3ZKoirw02ojDl
         gBlw==
X-Gm-Message-State: APjAAAWO52IguXvQWBekX1mStk8TiUFi8giI9s5i7auYddbARPAVCOE6
        9imMHAJm85mueWg9RAHDm2F/5Q==
X-Google-Smtp-Source: APXvYqzGaqCMW/ftUslWUcCh70GQomsfF4WIT5E7oYzPc0QSzMa+g5jxlvif62NCnhy7g1oe4IW3kw==
X-Received: by 2002:a2e:9acb:: with SMTP id p11mr17230891ljj.129.1558558751524;
        Wed, 22 May 2019 13:59:11 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:10 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 2/6] staging: kpc2000: add space between ) and { in cell_probe.c
Date:   Wed, 22 May 2019 22:58:45 +0200
Message-Id: <20190522205849.17444-3-simon@nikanor.nu>
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

Fixes checkpatch.pl error "space required before the open brace '{'".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 36 ++++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 6e034d115b47..51d32970f025 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -241,8 +241,8 @@ int  kp2000_check_uio_irq(struct kp2000_device *pcard, u32 irq_num)
 	u64 interrupt_active   =  readq(pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE);
 	u64 interrupt_mask_inv = ~readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 	u64 irq_check_mask = (1 << irq_num);
-	if (interrupt_active & irq_check_mask){ // if it's active (interrupt pending)
-		if (interrupt_mask_inv & irq_check_mask){    // and if it's not masked off
+	if (interrupt_active & irq_check_mask) { // if it's active (interrupt pending)
+		if (interrupt_mask_inv & irq_check_mask) {    // and if it's not masked off
 			return 1;
 		}
 	}
@@ -256,7 +256,7 @@ irqreturn_t  kuio_handler(int irq, struct uio_info *uioinfo)
 	if (irq != kudev->pcard->pdev->irq)
 		return IRQ_NONE;
 
-	if (kp2000_check_uio_irq(kudev->pcard, kudev->cte.irq_base_num)){
+	if (kp2000_check_uio_irq(kudev->pcard, kudev->cte.irq_base_num)) {
 		writeq((1 << kudev->cte.irq_base_num), kudev->pcard->sysinfo_regs_base + REG_INTERRUPT_ACTIVE); // Clear the active flag
 		return IRQ_HANDLED;
 	}
@@ -272,7 +272,7 @@ int kuio_irqcontrol(struct uio_info *uioinfo, s32 irq_on)
 
 	mutex_lock(&pcard->sem);
 	mask = readq(pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
-	if (irq_on){
+	if (irq_on) {
 		mask &= ~(1 << (kudev->cte.irq_base_num));
 	} else {
 		mask |= (1 << (kudev->cte.irq_base_num));
@@ -292,7 +292,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	dev_dbg(&pcard->pdev->dev, "Found UIO core:   type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
 	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
-	if (!kudev){
+	if (!kudev) {
 		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
 		return -ENOMEM;
 	}
@@ -305,7 +305,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	kudev->uioinfo.priv = kudev;
 	kudev->uioinfo.name = name;
 	kudev->uioinfo.version = "0.0";
-	if (cte.irq_count > 0){
+	if (cte.irq_count > 0) {
 		kudev->uioinfo.irq_flags = IRQF_SHARED;
 		kudev->uioinfo.irq = pcard->pdev->irq;
 		kudev->uioinfo.handler = kuio_handler;
@@ -328,7 +328,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	dev_set_drvdata(kudev->dev, kudev);
 
 	rv = uio_register_device(kudev->dev, &kudev->uioinfo);
-	if (rv){
+	if (rv) {
 		dev_err(&pcard->pdev->dev, "probe_core_uio failed uio_register_device: %d\n", rv);
 		put_device(kudev->dev);
 		kfree(kudev);
@@ -383,17 +383,17 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 	u64 capabilities_reg;
 
 	// S2C Engines
-	for (i = 0 ; i < 32 ; i++){
+	for (i = 0 ; i < 32 ; i++) {
 		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
-		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK){
+		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
 			err = create_dma_engine_core(pcard, (KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), i,  pcard->pdev->irq);
 			if (err) goto err_out;
 		}
 	}
 	// C2S Engines
-	for (i = 0 ; i < 32 ; i++){
+	for (i = 0 ; i < 32 ; i++) {
 		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
-		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK){
+		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
 			err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32+i,  pcard->pdev->irq);
 			if (err) goto err_out;
 		}
@@ -423,23 +423,23 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	INIT_LIST_HEAD(&pcard->uio_devices_list);
 
 	// First, iterate the core table looking for the highest CORE_ID
-	for (i = 0 ; i < pcard->core_table_length ; i++){
+	for (i = 0 ; i < pcard->core_table_length ; i++) {
 		read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
 		parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
 		dbg_cte(pcard, &cte);
-		if (cte.type > highest_core_id){
+		if (cte.type > highest_core_id) {
 			highest_core_id = cte.type;
 		}
-		if (cte.type == KP_CORE_ID_INVALID){
+		if (cte.type == KP_CORE_ID_INVALID) {
 			dev_info(&pcard->pdev->dev, "Found Invalid core: %016llx\n", read_val);
 		}
 	}
 	// Then, iterate over the possible core types.
-	for (current_type_id = 1 ; current_type_id <= highest_core_id ; current_type_id++){
+	for (current_type_id = 1 ; current_type_id <= highest_core_id ; current_type_id++) {
 		unsigned int core_num = 0;
 		// Foreach core type, iterate the whole table and instantiate subdevices for each core.
 		// Yes, this is O(n*m) but the actual runtime is small enough that it's an acceptable tradeoff.
-		for (i = 0 ; i < pcard->core_table_length ; i++){
+		for (i = 0 ; i < pcard->core_table_length ; i++) {
 			read_val = readq(pcard->sysinfo_regs_base + ((pcard->core_table_offset + i) * 8));
 			parse_core_table_entry(&cte, read_val, pcard->core_table_rev);
 
@@ -482,7 +482,7 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	cte.irq_count           = 0;
 	cte.irq_base_num        = 0;
 	err = probe_core_uio(0, pcard, "kpc_uio", cte);
-	if (err){
+	if (err) {
 		dev_err(&pcard->pdev->dev, "kp2000_probe_cores: failed to add board_info core: %d\n", err);
 		goto error;
 	}
@@ -499,7 +499,7 @@ void  kp2000_remove_cores(struct kp2000_device *pcard)
 {
 	struct list_head *ptr;
 	struct list_head *next;
-	list_for_each_safe(ptr, next, &pcard->uio_devices_list){
+	list_for_each_safe(ptr, next, &pcard->uio_devices_list) {
 		struct kpc_uio_device *kudev = list_entry(ptr, struct kpc_uio_device, list);
 		uio_unregister_device(&kudev->uioinfo);
 		device_unregister(kudev->dev);
-- 
2.20.1

