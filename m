Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BB1C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCCF20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hifQjile"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfHMKbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:31:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34991 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfHMKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:31:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so863412pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0NWCdqT4V5UAbJ69PpT+e5aSSwzpr+WzSGTZJWoBeqM=;
        b=hifQjileiR3p3jwSsKKPb9Q7eJ0TTYN3bo6jiIVVSx4wJZ6R+jjW8DhiBQSIf6QN7F
         Hcxm9N/gz9TCKVDQt/cHLkxdzzpgpNmiVHmFgWQfK9jp+CHkKIZXzckiv+jCm/eLGbxf
         lUF/urd0KBbwQpfQp4PTeriFS2IShcKfmCcNnIn0Oq/tmDBy9v5DavVbddURKnrkeIU4
         bt9qcI4KcRy31I5H2/6tbqzLY3FbfF370pekWYR3Ipnrt6bcmj+D+jqlSGJohEHDy0Rv
         1l2sv2hlycFr9Dk9Y3K+eoqe/FFTbTQ1cXs/T5OBqFjUcyFECgTLMSFiUwr/Cb2VA44P
         l/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0NWCdqT4V5UAbJ69PpT+e5aSSwzpr+WzSGTZJWoBeqM=;
        b=QceMmpgJnnbp71oaU58SsdMEjxGmAaxat7eAISTA6Jwei+R7sfbHmdvGsvQwYyAEgf
         w7IilUYdWuzVNI0J9nvk8lnLQH0KqZxnCzNNd/mQ/Mz4XU7FSe20PPhVuYidFGsNcEbg
         JZZqiO8DNUtNHn/rU7OLADw4FjDit1Sd9or2mAOlfV8leO1l0tSucOTU7dZeKma+vCF7
         zy5j5QBxRnMjZ0KrYOb05PeJ8ID8JycsBTPWlPSvyocktiR8uI1KXq3wkS/7zs+BsyNt
         4TZvhMT9/8TXYblJt3wIQzh/6SnDKVmQf2ggFi+CtiqgWJs0SrbB9O3xhbR8EJLaM1PC
         gKlg==
X-Gm-Message-State: APjAAAWxpSQsa8++Q+cik0NOrKsmetIedqDAEBdp5mF/wZeKepUaYOGZ
        LNJG01KamF8tt6i5Y+TLDNs=
X-Google-Smtp-Source: APXvYqxwy5Km+CGd4bpPhAynHyGF4fxl7Eeu+FR9MFctgymMF+Lj+Z8eJJCc96ElHRUaNQi3msrhyg==
X-Received: by 2002:a63:1310:: with SMTP id i16mr33397577pgl.187.1565692309804;
        Tue, 13 Aug 2019 03:31:49 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id d6sm95420544pgf.55.2019.08.13.03.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 03:31:49 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH] mfd: ezx-pcap: replace mutex_lock with spin_lock
Date:   Tue, 13 Aug 2019 18:31:33 +0800
Message-Id: <20190813103133.8354-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mutex_lock might sleep.
Function pcap_adc_irq is an interrupt handler.
The use of mutex_lock in pcap_adc_irq may cause sleep
in IRQ context.
Replace mutex_lock with spin_lock to avoid this.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/mfd/ezx-pcap.c | 53 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index f505e3e1274b..70fa18b04ad2 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -35,7 +35,7 @@ struct pcap_chip {
 
 	/* IO */
 	u32 buf;
-	struct mutex io_mutex;
+	spinlock_t io_lock;
 
 	/* IRQ */
 	unsigned int irq_base;
@@ -48,7 +48,7 @@ struct pcap_chip {
 	struct pcap_adc_request *adc_queue[PCAP_ADC_MAXQ];
 	u8 adc_head;
 	u8 adc_tail;
-	struct mutex adc_mutex;
+	spinlock_t adc_lock;
 };
 
 /* IO */
@@ -76,14 +76,15 @@ static int ezx_pcap_putget(struct pcap_chip *pcap, u32 *data)
 
 int ezx_pcap_write(struct pcap_chip *pcap, u8 reg_num, u32 value)
 {
+	unsigned long flags;
 	int ret;
 
-	mutex_lock(&pcap->io_mutex);
+	spin_lock_irqsave(&pcap->io_lock, flags);
 	value &= PCAP_REGISTER_VALUE_MASK;
 	value |= PCAP_REGISTER_WRITE_OP_BIT
 		| (reg_num << PCAP_REGISTER_ADDRESS_SHIFT);
 	ret = ezx_pcap_putget(pcap, &value);
-	mutex_unlock(&pcap->io_mutex);
+	spin_unlock_irqrestore(&pcap->io_lock, flags);
 
 	return ret;
 }
@@ -91,14 +92,15 @@ EXPORT_SYMBOL_GPL(ezx_pcap_write);
 
 int ezx_pcap_read(struct pcap_chip *pcap, u8 reg_num, u32 *value)
 {
+	unsigned long flags;
 	int ret;
 
-	mutex_lock(&pcap->io_mutex);
+	spin_lock_irqsave(&pcap->io_lock, flags);
 	*value = PCAP_REGISTER_READ_OP_BIT
 		| (reg_num << PCAP_REGISTER_ADDRESS_SHIFT);
 
 	ret = ezx_pcap_putget(pcap, value);
-	mutex_unlock(&pcap->io_mutex);
+	spin_unlock_irqrestore(&pcap->io_lock, flags);
 
 	return ret;
 }
@@ -106,11 +108,12 @@ EXPORT_SYMBOL_GPL(ezx_pcap_read);
 
 int ezx_pcap_set_bits(struct pcap_chip *pcap, u8 reg_num, u32 mask, u32 val)
 {
+	unsigned long flags;
 	int ret;
 	u32 tmp = PCAP_REGISTER_READ_OP_BIT |
 		(reg_num << PCAP_REGISTER_ADDRESS_SHIFT);
 
-	mutex_lock(&pcap->io_mutex);
+	spin_lock_irqsave(&pcap->io_lock, flags);
 	ret = ezx_pcap_putget(pcap, &tmp);
 	if (ret)
 		goto out_unlock;
@@ -121,7 +124,7 @@ int ezx_pcap_set_bits(struct pcap_chip *pcap, u8 reg_num, u32 mask, u32 val)
 
 	ret = ezx_pcap_putget(pcap, &tmp);
 out_unlock:
-	mutex_unlock(&pcap->io_mutex);
+	spin_unlock_irqrestore(&pcap->io_lock, flags);
 
 	return ret;
 }
@@ -212,14 +215,15 @@ static void pcap_irq_handler(struct irq_desc *desc)
 /* ADC */
 void pcap_set_ts_bits(struct pcap_chip *pcap, u32 bits)
 {
+	unsigned long flags;
 	u32 tmp;
 
-	mutex_lock(&pcap->adc_mutex);
+	spin_lock_irqsave(&pcap->adc_lock, flags);
 	ezx_pcap_read(pcap, PCAP_REG_ADC, &tmp);
 	tmp &= ~(PCAP_ADC_TS_M_MASK | PCAP_ADC_TS_REF_LOWPWR);
 	tmp |= bits & (PCAP_ADC_TS_M_MASK | PCAP_ADC_TS_REF_LOWPWR);
 	ezx_pcap_write(pcap, PCAP_REG_ADC, tmp);
-	mutex_unlock(&pcap->adc_mutex);
+	spin_unlock_irqrestore(&pcap->adc_lock, flags);
 }
 EXPORT_SYMBOL_GPL(pcap_set_ts_bits);
 
@@ -234,15 +238,16 @@ static void pcap_disable_adc(struct pcap_chip *pcap)
 
 static void pcap_adc_trigger(struct pcap_chip *pcap)
 {
+	unsigned long flags;
 	u32 tmp;
 	u8 head;
 
-	mutex_lock(&pcap->adc_mutex);
+	spin_lock_irqsave(&pcap->adc_lock, flags);
 	head = pcap->adc_head;
 	if (!pcap->adc_queue[head]) {
 		/* queue is empty, save power */
 		pcap_disable_adc(pcap);
-		mutex_unlock(&pcap->adc_mutex);
+		spin_unlock_irqrestore(&pcap->adc_lock, flags);
 		return;
 	}
 	/* start conversion on requested bank, save TS_M bits */
@@ -254,7 +259,7 @@ static void pcap_adc_trigger(struct pcap_chip *pcap)
 		tmp |= PCAP_ADC_AD_SEL1;
 
 	ezx_pcap_write(pcap, PCAP_REG_ADC, tmp);
-	mutex_unlock(&pcap->adc_mutex);
+	spin_unlock_irqrestore(&pcap->adc_lock, flags);
 	ezx_pcap_write(pcap, PCAP_REG_ADR, PCAP_ADR_ASC);
 }
 
@@ -265,11 +270,11 @@ static irqreturn_t pcap_adc_irq(int irq, void *_pcap)
 	u16 res[2];
 	u32 tmp;
 
-	mutex_lock(&pcap->adc_mutex);
+	spin_lock(&pcap->adc_lock);
 	req = pcap->adc_queue[pcap->adc_head];
 
 	if (WARN(!req, "adc irq without pending request\n")) {
-		mutex_unlock(&pcap->adc_mutex);
+		spin_unlock(&pcap->adc_lock);
 		return IRQ_HANDLED;
 	}
 
@@ -285,7 +290,7 @@ static irqreturn_t pcap_adc_irq(int irq, void *_pcap)
 
 	pcap->adc_queue[pcap->adc_head] = NULL;
 	pcap->adc_head = (pcap->adc_head + 1) & (PCAP_ADC_MAXQ - 1);
-	mutex_unlock(&pcap->adc_mutex);
+	spin_unlock(&pcap->adc_lock);
 
 	/* pass the results and release memory */
 	req->callback(req->data, res);
@@ -301,6 +306,7 @@ int pcap_adc_async(struct pcap_chip *pcap, u8 bank, u32 flags, u8 ch[],
 						void *callback, void *data)
 {
 	struct pcap_adc_request *req;
+	unsigned long irq_flags;
 
 	/* This will be freed after we have a result */
 	req = kmalloc(sizeof(struct pcap_adc_request), GFP_KERNEL);
@@ -314,15 +320,15 @@ int pcap_adc_async(struct pcap_chip *pcap, u8 bank, u32 flags, u8 ch[],
 	req->callback = callback;
 	req->data = data;
 
-	mutex_lock(&pcap->adc_mutex);
+	spin_lock_irqsave(&pcap->adc_lock, irq_flags);
 	if (pcap->adc_queue[pcap->adc_tail]) {
-		mutex_unlock(&pcap->adc_mutex);
+		spin_unlock_irqrestore(&pcap->adc_lock, irq_flags);
 		kfree(req);
 		return -EBUSY;
 	}
 	pcap->adc_queue[pcap->adc_tail] = req;
 	pcap->adc_tail = (pcap->adc_tail + 1) & (PCAP_ADC_MAXQ - 1);
-	mutex_unlock(&pcap->adc_mutex);
+	spin_unlock_irqrestore(&pcap->adc_lock, irq_flags);
 
 	/* start conversion */
 	pcap_adc_trigger(pcap);
@@ -389,16 +395,17 @@ static int pcap_add_subdev(struct pcap_chip *pcap,
 static int ezx_pcap_remove(struct spi_device *spi)
 {
 	struct pcap_chip *pcap = spi_get_drvdata(spi);
+	unsigned long flags;
 	int i;
 
 	/* remove all registered subdevs */
 	device_for_each_child(&spi->dev, NULL, pcap_remove_subdev);
 
 	/* cleanup ADC */
-	mutex_lock(&pcap->adc_mutex);
+	spin_lock_irqsave(&pcap->adc_lock, flags);
 	for (i = 0; i < PCAP_ADC_MAXQ; i++)
 		kfree(pcap->adc_queue[i]);
-	mutex_unlock(&pcap->adc_mutex);
+	spin_unlock_irqrestore(&pcap->adc_lock, flags);
 
 	/* cleanup irqchip */
 	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++)
@@ -426,8 +433,8 @@ static int ezx_pcap_probe(struct spi_device *spi)
 		goto ret;
 	}
 
-	mutex_init(&pcap->io_mutex);
-	mutex_init(&pcap->adc_mutex);
+	spin_lock_init(&pcap->io_lock);
+	spin_lock_init(&pcap->adc_lock);
 	INIT_WORK(&pcap->isr_work, pcap_isr_work);
 	INIT_WORK(&pcap->msr_work, pcap_msr_work);
 	spi_set_drvdata(spi, pcap);
-- 
2.11.0

