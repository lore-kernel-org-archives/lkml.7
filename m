Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB5C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBDA20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA/p8iBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfDDTAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:00:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33586 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfDDTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:00:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so5152585wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOz1OmdzQOrel82sMUNuuIJyu/ODztQH13IvPDSDVDM=;
        b=qA/p8iBYWTOCkNWpXuCACDqEHahCcXAwrJDrTCLlKI04hUda/b7fNO1I/2xWnokacA
         jNkQiq67fhIt9qhAvKvNJpizS936id8T2DutBN217iTRUjLdJCZ3pxJdWpBcc95Uz0To
         z0o2UUZL/W2XRLMilYeW/WGtYYzu8I+Q5jMTO6RHNSKv0wBt30N1V8U0Xh2Ffbjh4L8N
         KOB0DWygEad4qjuUXF3MKuGHOWg53wbsPYLXYAfYp6WX/O5n8BXnAyfPE1gl11kFWO7E
         wgTWKFn0iI3U/qXgnDc0eK3HQYzN69NonPVcIb45pHxogQMRtKmjsh+AaewmwfSyoPMr
         v+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOz1OmdzQOrel82sMUNuuIJyu/ODztQH13IvPDSDVDM=;
        b=JLdUaCYx07Lb0aXdM9+PcXBljUiwFvOp0tV3aEWvQUDcWlkTZIXemCOle5QjwEmD1w
         qR4z9Wh9KQFEd4aF4AzWSOvU9aTgcHUjcbH3VpTeOwz7xCPcTLNT9ck7zlYaZo1lqMxt
         9sSK0roigeJzxC1yDaJG2YWj8AVKUjUmgwa/OxSE6e3SRmScJ0JMOSkf7ZBq0wt4nTB5
         OsT1C7wzZJYeP6YpVBLRgL379xUQciywQrTd7aLjk4NJxau7+xiiGKnhYctYt770STPc
         qw4rPIGFz6X+mmjCmELcCNpDP6JQdcSoXpqNXZR9w5pYGZFx0jI/pSUl+Zbksg0+ATt1
         4bHA==
X-Gm-Message-State: APjAAAWQ1sMTC3XIPO6i3lDFh6CgQnXl/POp0Bfq5dZptcvUhyC28YKo
        gmkdbbv0Z1Qws80S7yGMTHJ+C0U6
X-Google-Smtp-Source: APXvYqxLhiv0m0N8ruem4Lzu4asQKkQ/hyY8jLa+73Ln/2/6fNxX0T9fY9XIRE29NV7Lq8YQsMYAdw==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr5146931wro.293.1554404406524;
        Thu, 04 Apr 2019 12:00:06 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm41137280wmo.20.2019.04.04.12.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:00:06 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/3] habanalabs: split mmu/no-mmu code paths in memory ioctl
Date:   Thu,  4 Apr 2019 22:00:01 +0300
Message-Id: <20190404190001.28337-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404190001.28337-1-oded.gabbay@gmail.com>
References: <20190404190001.28337-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the memory ioctl code more readable, this patch moves the
legacy/debug code path of mmu-disabled to a separate function, which is
called (if necessary) from the main memory ioctl function.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/memory.c | 177 ++++++++++++++++---------------
 1 file changed, 92 insertions(+), 85 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index e9e163545584..05919f913300 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1090,6 +1090,64 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 	return rc;
 }
 
+static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_ctx *ctx = hpriv->ctx;
+	u64 device_addr = 0;
+	u32 handle = 0;
+	int rc;
+
+	switch (args->in.op) {
+	case HL_MEM_OP_ALLOC:
+		if (args->in.alloc.mem_size == 0) {
+			dev_err(hdev->dev,
+				"alloc size must be larger than 0\n");
+			rc = -EINVAL;
+			goto out;
+		}
+
+		/* Force contiguous as there are no real MMU
+		 * translations to overcome physical memory gaps
+		 */
+		args->in.flags |= HL_MEM_CONTIGUOUS;
+		rc = alloc_device_memory(ctx, &args->in, &handle);
+
+		memset(args, 0, sizeof(*args));
+		args->out.handle = (__u64) handle;
+		break;
+
+	case HL_MEM_OP_FREE:
+		rc = free_device_memory(ctx, args->in.free.handle);
+		break;
+
+	case HL_MEM_OP_MAP:
+		if (args->in.flags & HL_MEM_USERPTR) {
+			device_addr = args->in.map_host.host_virt_addr;
+			rc = 0;
+		} else {
+			rc = get_paddr_from_handle(ctx, &args->in,
+					&device_addr);
+		}
+
+		memset(args, 0, sizeof(*args));
+		args->out.device_virt_addr = device_addr;
+		break;
+
+	case HL_MEM_OP_UNMAP:
+		rc = 0;
+		break;
+
+	default:
+		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
+		rc = -ENOTTY;
+		break;
+	}
+
+out:
+	return rc;
+}
+
 int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_mem_args *args = data;
@@ -1105,100 +1163,49 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EBUSY;
 	}
 
-	if (hdev->mmu_enable) {
-		switch (args->in.op) {
-		case HL_MEM_OP_ALLOC:
-			if (!hdev->dram_supports_virtual_memory) {
-				dev_err(hdev->dev,
-					"DRAM alloc is not supported\n");
-				rc = -EINVAL;
-				goto out;
-			}
-			if (args->in.alloc.mem_size == 0) {
-				dev_err(hdev->dev,
-					"alloc size must be larger than 0\n");
-				rc = -EINVAL;
-				goto out;
-			}
-			rc = alloc_device_memory(ctx, &args->in, &handle);
-
-			memset(args, 0, sizeof(*args));
-			args->out.handle = (__u64) handle;
-			break;
-
-		case HL_MEM_OP_FREE:
-			if (!hdev->dram_supports_virtual_memory) {
-				dev_err(hdev->dev,
-					"DRAM free is not supported\n");
-				rc = -EINVAL;
-				goto out;
-			}
-			rc = free_device_memory(ctx, args->in.free.handle);
-			break;
-
-		case HL_MEM_OP_MAP:
-			rc = map_device_va(ctx, &args->in, &device_addr);
-
-			memset(args, 0, sizeof(*args));
-			args->out.device_virt_addr = device_addr;
-			break;
+	if (!hdev->mmu_enable)
+		return mem_ioctl_no_mmu(hpriv, args);
 
-		case HL_MEM_OP_UNMAP:
-			rc = unmap_device_va(ctx,
-					args->in.unmap.device_virt_addr);
-			break;
-
-		default:
-			dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
-			rc = -ENOTTY;
-			break;
+	switch (args->in.op) {
+	case HL_MEM_OP_ALLOC:
+		if (!hdev->dram_supports_virtual_memory) {
+			dev_err(hdev->dev, "DRAM alloc is not supported\n");
+			rc = -EINVAL;
+			goto out;
 		}
-	} else {
-		switch (args->in.op) {
-		case HL_MEM_OP_ALLOC:
-			if (args->in.alloc.mem_size == 0) {
-				dev_err(hdev->dev,
-					"alloc size must be larger than 0\n");
-				rc = -EINVAL;
-				goto out;
-			}
 
-			/* Force contiguous as there are no real MMU
-			 * translations to overcome physical memory gaps
-			 */
-			args->in.flags |= HL_MEM_CONTIGUOUS;
-			rc = alloc_device_memory(ctx, &args->in, &handle);
+		if (args->in.alloc.mem_size == 0) {
+			dev_err(hdev->dev,
+				"alloc size must be larger than 0\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		rc = alloc_device_memory(ctx, &args->in, &handle);
 
-			memset(args, 0, sizeof(*args));
-			args->out.handle = (__u64) handle;
-			break;
+		memset(args, 0, sizeof(*args));
+		args->out.handle = (__u64) handle;
+		break;
 
-		case HL_MEM_OP_FREE:
-			rc = free_device_memory(ctx, args->in.free.handle);
-			break;
+	case HL_MEM_OP_FREE:
+		rc = free_device_memory(ctx, args->in.free.handle);
+		break;
 
-		case HL_MEM_OP_MAP:
-			if (args->in.flags & HL_MEM_USERPTR) {
-				device_addr = args->in.map_host.host_virt_addr;
-				rc = 0;
-			} else {
-				rc = get_paddr_from_handle(ctx, &args->in,
-						&device_addr);
-			}
+	case HL_MEM_OP_MAP:
+		rc = map_device_va(ctx, &args->in, &device_addr);
 
-			memset(args, 0, sizeof(*args));
-			args->out.device_virt_addr = device_addr;
-			break;
+		memset(args, 0, sizeof(*args));
+		args->out.device_virt_addr = device_addr;
+		break;
 
-		case HL_MEM_OP_UNMAP:
-			rc = 0;
-			break;
+	case HL_MEM_OP_UNMAP:
+		rc = unmap_device_va(ctx,
+				args->in.unmap.device_virt_addr);
+		break;
 
-		default:
-			dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
-			rc = -ENOTTY;
-			break;
-		}
+	default:
+		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
+		rc = -ENOTTY;
+		break;
 	}
 
 out:
-- 
2.17.1

