Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF534C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF2A21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfLQPa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:30:57 -0500
Received: from ns.iliad.fr ([212.27.33.1]:56708 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbfLQPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:30:57 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id C170821560;
        Tue, 17 Dec 2019 16:30:54 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 9CFC02155B;
        Tue, 17 Dec 2019 16:30:54 +0100 (CET)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
Message-ID: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
Date:   Tue, 17 Dec 2019 16:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Dec 17 16:30:54 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a66d972465d15 ("devres: Align data[] to ARCH_KMALLOC_MINALIGN")
increased the alignment of devres.data unconditionally.

Some platforms have very strict alignment requirements for DMA-safe
addresses, e.g. 128 bytes on arm64. There, struct devres amounts to:
	3 pointers + pad_to_128 + data + pad_to_256
i.e. ~220 bytes of padding.

Let's enforce the alignment only for devm_kmalloc().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
I had not been aware that dynamic allocation granularity on arm64 was
128 bytes. This means there's a lot of waste on small allocations.
I suppose there's no easy solution, though.
---
 drivers/base/devres.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..bf39188613d9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -26,14 +26,7 @@ struct devres_node {
 
 struct devres {
 	struct devres_node		node;
-	/*
-	 * Some archs want to perform DMA into kmalloc caches
-	 * and need a guaranteed alignment larger than
-	 * the alignment of a 64-bit integer.
-	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
-	 * buffer alignment as if it was allocated by plain kmalloc().
-	 */
-	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
+	u8				data[];
 };
 
 struct devres_group {
@@ -789,9 +782,16 @@ static void devm_kmalloc_release(struct device *dev, void *res)
 	/* noop */
 }
 
+#define DEVM_KMALLOC_PADDING_SIZE \
+	(ARCH_KMALLOC_MINALIGN - sizeof(struct devres) % ARCH_KMALLOC_MINALIGN)
+
 static int devm_kmalloc_match(struct device *dev, void *res, void *data)
 {
-	return res == data;
+	/*
+	 * 'res' is dr->data (not DMA-safe)
+	 * 'data' is the hand-aligned address from devm_kmalloc
+	 */
+	return res + DEVM_KMALLOC_PADDING_SIZE == data;
 }
 
 /**
@@ -811,6 +811,9 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 {
 	struct devres *dr;
 
+	/* Add enough padding to provide a DMA-safe address */
+	size += DEVM_KMALLOC_PADDING_SIZE;
+
 	/* use raw alloc_dr for kmalloc caller tracing */
 	dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
 	if (unlikely(!dr))
@@ -822,7 +825,7 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 	 */
 	set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
 	devres_add(dev, dr->data);
-	return dr->data;
+	return dr->data + DEVM_KMALLOC_PADDING_SIZE;
 }
 EXPORT_SYMBOL_GPL(devm_kmalloc);
 
-- 
2.17.1
