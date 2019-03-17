Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC1BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F92120896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnS9BA7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCQUAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfCQT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so10611873wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5k6jzC6rE0OKFBANkxFQnz4b88hZD9ZPqEtH1OIP/LQ=;
        b=jnS9BA7g+F05yo2R/btW1qFtdWDlOdyrAg2IPT2WmWOI5JJrGx31pzb8wlHZXHUtr6
         mzxpOIJgtEOJHVMW5RSOPsk1WkUx1BQjEg5wTQe3oYzzz+qotOox3S79YByVyKbkOuOB
         7GuI8T+n59If3IYZukEroXgRnxS0C8E9gqHJmbsyArLoVrCg9dN+wG4F5eBHdiDnEHEq
         0/Ps17b8JBUsvnM+bBLm2MUSih3amlpl2CeAhPB3VtLi7LIsMlXvNVj6tln1OVYh9hgP
         6JuNL4sx65lGseY9xvRHRP0NJYBWg4421kwv1+7Cq0VojHNgPKoeunL4mZtRp2IwvSdt
         skuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5k6jzC6rE0OKFBANkxFQnz4b88hZD9ZPqEtH1OIP/LQ=;
        b=qw6lC+B962qzUw1rZAtuUnpuS3xWxjRPc85d2qtopagAwZfITaoGpM788a1HbGasCY
         4cV2ZPf+RXQIvLTPXWwJD1nikgBZia0DsTovnnF1AVS9fsgtTiUmk8hSeRZB7NPaQgju
         0GOQtBRAWxrZ7c1I52ngVcBXZDEUSpjSZJlry+i5h2h4wn0dHyRiBli4PCc+EJ4Qn2d0
         VjGXdNATlwR6MhtAQuzezvm+pFeJFmM9U+G7QsQIWTTLS9YJZ5/8rvWCUZh+njxVpaOi
         d0sUNEkKO/YTebrwS+uYoth+RepnhhnqA6mfS20SsU0iIx3fJ15MUX4crgq69BAyUYmW
         euyg==
X-Gm-Message-State: APjAAAX6Rws+az78yMfqvTpYIM+pR5dBLzpjHOAAvyD+zjWe4/Q/ZGAM
        C7v2xT9kl6sikvs9JRs/EAfothpr
X-Google-Smtp-Source: APXvYqxw8pRlA7p4hVbOkj/U+gRvevN6NNCaxdPmiclyphRuK3oR9sUsKOCvKxXbvG/q0qvnRn0Xbg==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr8187735wmj.130.1552852795663;
        Sun, 17 Mar 2019 12:59:55 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 12/15] habanalabs: Allow accessing DRAM virtual addresses via debugfs
Date:   Sun, 17 Mar 2019 21:59:24 +0200
Message-Id: <20190317195927.26238-13-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The addr/data32 debugfs nodes currently permit the access to only physical
addresses of a device. This patch extends it and allows accessing also
device's DRAM virtual addresses.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c | 96 +++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 974a87789bd8..a4447699ff4e 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -505,22 +505,97 @@ static ssize_t mmu_write(struct file *file, const char __user *buf,
 	return -EINVAL;
 }
 
+static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
+				u64 *phys_addr)
+{
+	struct hl_ctx *ctx = hdev->user_ctx;
+	u64 hop_addr, hop_pte_addr, hop_pte;
+	int rc = 0;
+
+	if (!ctx) {
+		dev_err(hdev->dev, "no ctx available\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&ctx->mmu_lock);
+
+	/* hop 0 */
+	hop_addr = get_hop0_addr(ctx);
+	hop_pte_addr = get_hop0_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
+
+	/* hop 1 */
+	hop_addr = get_next_hop_addr(hop_pte);
+	if (hop_addr == ULLONG_MAX)
+		goto not_mapped;
+	hop_pte_addr = get_hop1_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
+
+	/* hop 2 */
+	hop_addr = get_next_hop_addr(hop_pte);
+	if (hop_addr == ULLONG_MAX)
+		goto not_mapped;
+	hop_pte_addr = get_hop2_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
+
+	/* hop 3 */
+	hop_addr = get_next_hop_addr(hop_pte);
+	if (hop_addr == ULLONG_MAX)
+		goto not_mapped;
+	hop_pte_addr = get_hop3_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
+
+	if (!(hop_pte & LAST_MASK)) {
+		/* hop 4 */
+		hop_addr = get_next_hop_addr(hop_pte);
+		if (hop_addr == ULLONG_MAX)
+			goto not_mapped;
+		hop_pte_addr = get_hop4_pte_addr(ctx, hop_addr, virt_addr);
+		hop_pte = hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
+	}
+
+	if (!(hop_pte & PAGE_PRESENT_MASK))
+		goto not_mapped;
+
+	*phys_addr = (hop_pte & PTE_PHYS_ADDR_MASK) | (virt_addr & OFFSET_MASK);
+
+	goto out;
+
+not_mapped:
+	dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
+			virt_addr);
+	rc = -EINVAL;
+out:
+	mutex_unlock(&ctx->mmu_lock);
+	return rc;
+}
+
 static ssize_t hl_data_read32(struct file *f, char __user *buf,
 					size_t count, loff_t *ppos)
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	char tmp_buf[32];
+	u64 addr = entry->addr;
 	u32 val;
 	ssize_t rc;
 
 	if (*ppos)
 		return 0;
 
-	rc = hdev->asic_funcs->debugfs_read32(hdev, entry->addr, &val);
+	if (addr >= prop->va_space_dram_start_address &&
+			addr < prop->va_space_dram_end_address &&
+			hdev->mmu_enable &&
+			hdev->dram_supports_virtual_memory) {
+		rc = device_va_to_pa(hdev, entry->addr, &addr);
+		if (rc)
+			return rc;
+	}
+
+	rc = hdev->asic_funcs->debugfs_read32(hdev, addr, &val);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to read from 0x%010llx\n",
-			entry->addr);
+		dev_err(hdev->dev, "Failed to read from 0x%010llx\n", addr);
 		return rc;
 	}
 
@@ -536,6 +611,8 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 addr = entry->addr;
 	u32 value;
 	ssize_t rc;
 
@@ -543,10 +620,19 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	if (rc)
 		return rc;
 
-	rc = hdev->asic_funcs->debugfs_write32(hdev, entry->addr, value);
+	if (addr >= prop->va_space_dram_start_address &&
+			addr < prop->va_space_dram_end_address &&
+			hdev->mmu_enable &&
+			hdev->dram_supports_virtual_memory) {
+		rc = device_va_to_pa(hdev, entry->addr, &addr);
+		if (rc)
+			return rc;
+	}
+
+	rc = hdev->asic_funcs->debugfs_write32(hdev, addr, value);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to write 0x%08x to 0x%010llx\n",
-			value, entry->addr);
+			value, addr);
 		return rc;
 	}
 
-- 
2.17.1

