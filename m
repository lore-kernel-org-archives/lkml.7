Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB23C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA92080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiKh1nJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgAIKkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:40:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35854 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgAIKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:40:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2262276wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3trtf9lM60fJYV2i54u9H1wxPq/DFu4YJvlJQYrNEI=;
        b=kiKh1nJ+IkW7bQOS0CmMeCtW3tlF1qpgDIddUuXx2gT9Z9QZ9aRoTx7uu/3gNCog3n
         M0bnNv2JFUxbrx9ovUSTkAVZfSoYIUvNlgJQm08GeTMPfed/I37hkgLYZQes9rXIsxog
         m9GHdkMENwNQpGXjsDW/9yg/h0JIJLZpV7PGhvrlr+FLhsiOPJ2IL5v0CHUAogCp17/h
         4J+gm0/lwHGM4GNC832CiJYTck8GbfOE0X8rBtwIVW/iWFK4tcXI+ambxeFfcar0RDMX
         YtV7BmEfJ67pEMQHwvKuuj4dsPANl4C4yf6/TskpXPr/vllmKls3NgLASjdsnPn6RR6e
         X9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3trtf9lM60fJYV2i54u9H1wxPq/DFu4YJvlJQYrNEI=;
        b=L0Tg33ZxtObYOoMB4zRTfoJ9lRUvVzHphHH8iO/oBpIIxwbQEtMDq3DXUfEZUzli55
         GA7nhQCHBbBdFDVHg6p3TJ3fDYy2IvzyqcwQExmiiKs7QEhpoQI9xJywhWGbECV9C9RR
         XXi3RWiI0C4/bPAQkGpif1r57KpTmXhq/nKs5QK3d1iuKKDhM439X07ynArO2D59Urns
         evIOTmU8+bS6lbtwb8zy+VjR+4tpghDMBECmWnoUTsEV8feF0NJZGy0TKkS7osAtNYgw
         GCrKptO+el0YmklMF4PROWxl2A/TgGfVMoLaBisgN8GfzR+1XeaEgATYdWGbAzoPa+M4
         jH1A==
X-Gm-Message-State: APjAAAWUoP6UwanjGhO94Y4KIyH3FwMroPfFda1En5S8gBuMArv2I2Ih
        j4amx4pjd0hVL9JMsBMxTpVoaA==
X-Google-Smtp-Source: APXvYqzbSCeTNHlj/3vljI1mwvOm40rN/nkLnI3xo2ME1tOg/icMsoJaCnEkG1WF6RJ63339K1jMVg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr4241100wmf.136.1578566432958;
        Thu, 09 Jan 2020 02:40:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b10sm7858576wrt.90.2020.01.09.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:40:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Bitan Biswas <bbiswas@nvidia.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] nvmem: core: fix memory abort in cleanup path
Date:   Thu,  9 Jan 2020 10:40:17 +0000
Message-Id: <20200109104017.6249-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
References: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bitan Biswas <bbiswas@nvidia.com>

nvmem_cell_info_to_nvmem_cell implementation has static
allocation of name. nvmem_add_cells_from_of() call may
return error and kfree name results in memory abort. Use
kstrdup_const() and kfree_const calls for name alloc and free.

Unable to handle kernel paging request at virtual address ffffffffffe44888
Mem abort info:
  ESR = 0x96000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 64k pages, 48-bit VAs, pgdp=00000000815d0000
[ffffffffffe44888] pgd=0000000081d30803, pud=0000000081d30803,
pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 43 Comm: kworker/2:1 Tainted
Hardware name: quill (DT)
Workqueue: events deferred_probe_work_func
pstate: a0000005 (NzCv daif -PAN -UAO)
pc : kfree+0x38/0x278
lr : nvmem_cell_drop+0x68/0x80
sp : ffff80001284f9d0
x29: ffff80001284f9d0 x28: ffff0001f677e830
x27: ffff800011b0b000 x26: ffff0001c36e1008
x25: ffff8000112ad000 x24: ffff8000112c9000
x23: ffffffffffffffea x22: ffff800010adc7f0
x21: ffffffffffe44880 x20: ffff800011b0b068
x19: ffff80001122d380 x18: ffffffffffffffff
x17: 00000000d5cb4756 x16: 0000000070b193b8
x15: ffff8000119538c8 x14: 0720072007200720
x13: 07200720076e0772 x12: 07750762072d0765
x11: 0773077507660765 x10: 072f073007300730
x9 : 0730073207380733 x8 : 0000000000000151
x7 : 07660765072f0720 x6 : ffff0001c00e0f00
x5 : 0000000000000000 x4 : ffff0001c0b43800
x3 : ffff800011b0b068 x2 : 0000000000000000
x1 : 0000000000000000 x0 : ffffffdfffe00000
Call trace:
 kfree+0x38/0x278
 nvmem_cell_drop+0x68/0x80
 nvmem_device_remove_all_cells+0x2c/0x50
 nvmem_register.part.9+0x520/0x628
 devm_nvmem_register+0x48/0xa0
 tegra_fuse_probe+0x140/0x1f0
 platform_drv_probe+0x50/0xa0
 really_probe+0x108/0x348
 driver_probe_device+0x58/0x100
 __device_attach_driver+0x90/0xb0
 bus_for_each_drv+0x64/0xc8
 __device_attach+0xd8/0x138
 device_initial_probe+0x10/0x18
 bus_probe_device+0x90/0x98
 deferred_probe_work_func+0x74/0xb0
 process_one_work+0x1e0/0x358
 worker_thread+0x208/0x488
 kthread+0x118/0x120
 ret_from_fork+0x10/0x18
Code: d350feb5 f2dffbe0 aa1e03f6 8b151815 (f94006a0)
---[ end trace 49b1303c6b83198e ]---

Fixes: badcdff107cbf ("nvmem: Convert to using %pOFn instead of device_node.name")
Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9f1ee9c766ec..1e4a798dce6e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -83,7 +83,7 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
 	of_node_put(cell->np);
-	kfree(cell->name);
+	kfree_const(cell->name);
 	kfree(cell);
 }
 
@@ -110,7 +110,9 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
 	cell->nvmem = nvmem;
 	cell->offset = info->offset;
 	cell->bytes = info->bytes;
-	cell->name = info->name;
+	cell->name = kstrdup_const(info->name, GFP_KERNEL);
+	if (!cell->name)
+		return -ENOMEM;
 
 	cell->bit_offset = info->bit_offset;
 	cell->nbits = info->nbits;
@@ -300,7 +302,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
-			kfree(cell->name);
+			kfree_const(cell->name);
 			kfree(cell);
 			return -EINVAL;
 		}
-- 
2.21.0

