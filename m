Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F029217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfCNSuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:50:04 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:18996 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNSuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:50:03 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2EInxjR047960;
        Fri, 15 Mar 2019 03:49:59 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Fri, 15 Mar 2019 03:49:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2EInt1v047952
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 15 Mar 2019 03:49:58 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] dmaengine: pl330: introduce debugfs interface
Date:   Fri, 15 Mar 2019 03:49:53 +0900
Message-Id: <20190314184953.8129-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds debugfs interface to show the relationship between
DMA threads (hardware resource for transferring data) and DMA
channel ID of DMA slave.

Typically, PL330 has many slaves than number of DMA threads.
So sometimes PL330 cannot allocate DMA threads for all slaves even
if an user specify DMA channel ID in devicetree. This interface will
be useful for checking that DMA threads are allocated or not.

Below is an output sample:

$ sudo cat /sys/kernel/debug/ff1f0000.dmac
PL330 physical channels:
THREAD:         CHANNEL:
--------        -----
0               8
1               9
2               11
3               12
4               14
5               15
6               10
7               --

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/dma/pl330.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index eec79fdf27a5..aab71863757c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -11,6 +11,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/init.h>
@@ -2896,6 +2897,55 @@ static irqreturn_t pl330_irq_handler(int irq, void *data)
 	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
 	BIT(DMA_SLAVE_BUSWIDTH_8_BYTES)
 
+#ifdef CONFIG_DEBUG_FS
+static int pl330_debugfs_show(struct seq_file *s, void *data)
+{
+	struct pl330_dmac *pl330 = s->private;
+	int chans, pchs, ch, pr, found;
+
+	chans = pl330->pcfg.num_chan;
+	pchs = pl330->num_peripherals;
+
+	seq_puts(s, "PL330 physical channels:\n");
+	seq_puts(s, "THREAD:\t\tCHANNEL:\n");
+	seq_puts(s, "--------\t-----\n");
+	for (ch = 0; ch < chans; ch++) {
+		struct pl330_thread *thrd = &pl330->channels[ch];
+
+		found = -1;
+		for (pr = 0; pr < pchs; pr++) {
+			struct dma_pl330_chan *pch = &pl330->peripherals[pr];
+
+			if (!pch->thread || thrd->id != pch->thread->id)
+				continue;
+
+			found = pr;
+		}
+
+		seq_printf(s, "%d\t\t", thrd->id);
+		if (found == -1)
+			seq_puts(s, "--\n");
+		else
+			seq_printf(s, "%d\n", found);
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(pl330_debugfs);
+
+static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
+{
+	debugfs_create_file(dev_name(pl330->ddma.dev),
+			    S_IFREG | S_IRUGO, NULL, pl330,
+			    &pl330_debugfs_fops);
+}
+#else
+static inline void init_pl330_debugfs(struct pl330_dmac *pl330)
+{
+}
+#endif
+
 /*
  * Runtime PM callbacks are provided by amba/bus.c driver.
  *
@@ -3082,6 +3132,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_err(&adev->dev, "unable to set the seg size\n");
 
 
+	init_pl330_debugfs(pl330);
 	dev_info(&adev->dev,
 		"Loaded driver for PL330 DMAC-%x\n", adev->periphid);
 	dev_info(&adev->dev,
-- 
2.20.1

