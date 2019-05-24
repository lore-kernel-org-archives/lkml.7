Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSZFDW/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbfEXLbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:31:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55367 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390714AbfEXLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:31:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id x64so9001215wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oE1itLvC5WmhyWwJeZjZP8ObQQwm+ffDCAe7rkEgIdQ=;
        b=tSZFDW/ZJoMDRl1sZZeqHVKa6/weNm5U1di6MrU1az4pPQwgUw0RkeMcmsHygvOCdw
         utZe3BElKz+rSVvgTQIquBovDD8XwVAXhU/jPtgGPjeapn65hhom2pFvlH+qv8Sjq9p5
         u1AE1Wc4A81MAWHmkUg0MyABSCuZNGQHhaA7tpjVR4zMYtv9pVi9Cca9abbmpM4QVdtB
         CmNXnjpWupzXIOGzspVoNdkl3to63ZVkqBvXxlHSiasvgN0yQOaTaTXBoqCRkk9ZQISS
         HKZvK0zZaLRthqZalXrXSKi63F02PkZNiYgV/r3HxssQYaZlPFNS43eIXtZmTO5s3NPW
         kaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oE1itLvC5WmhyWwJeZjZP8ObQQwm+ffDCAe7rkEgIdQ=;
        b=o7M21l6KZa73Ywv/wsNyDjm4GLPQgBz/ghnNqMHMpyTSp8hKf2Zltwgd7VPRgf89t+
         4/zg8PfDx/7qfQDShjLar9Hf6SndodkY9PIIvUufzs2Jtgr/qyMyuwd8vllsyFfnx+3f
         9HAkyPtQ0oymH3rXz+2jVPYfQSobuzOKOgnc+Vew4veVA+y+dgnS7pVUKXm19THeWKDi
         1xWc82WNsQJXVGCEAEnLODKoSPpTCL1sfKuVfOi1WSKPeJsZH//uWuEHjlK4qvb3WPgc
         zTeTMIBpThe7MUThagfga59jZF16vM6m79QU7lYQPdlro57xiBybXa5BaPr/22xCTZDP
         THvQ==
X-Gm-Message-State: APjAAAXCFOeV3tvA8E2GHb+KtEjtci3CBD3dsxphRftWi+H4Qvjx9/gV
        w1uDg3YYX75WxTnYBVMfyVg=
X-Google-Smtp-Source: APXvYqzKK1p+x26eZqbINv0WX65scN403Y5WgVOOOVY/7IARiFVHP9vbYUglOAq4HXtG/EeqFLWl4g==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr15553133wmb.13.1558697468915;
        Fri, 24 May 2019 04:31:08 -0700 (PDT)
Received: from localhost.localdomain (ip229.173.mip.uni-hannover.de. [130.75.173.229])
        by smtp.gmail.com with ESMTPSA id r128sm1550142wmf.12.2019.05.24.04.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:31:08 -0700 (PDT)
From:   Tianzheng Li <ltz0302@gmail.com>
To:     rspringer@google.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, benchan@chromium.org,
        toddpoynor@google.com, linux-kernel@i4.cs.fau.de,
        zhangjie.cnde@gmail.com
Subject: [PATCH v2] staging/gasket: Fix string split
Date:   Fri, 24 May 2019 13:31:05 +0200
Message-Id: <20190524113105.44580-1-ltz0302@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary quoted string splits.

Co-developed-by: Jie Zhang <zhangjie.cnde@gmail.com>
Signed-off-by: Jie Zhang <zhangjie.cnde@gmail.com>
Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
---
Changes in v2:
  - Add Co-developed-by: Jie Zhang <zhangjie.cnde@gmail.com>

 drivers/staging/gasket/gasket_core.c       |  6 ++----
 drivers/staging/gasket/gasket_ioctl.c      |  3 +--
 drivers/staging/gasket/gasket_page_table.c | 14 ++++++--------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index a445d58fb399..13179f063a61 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -702,8 +702,7 @@ static bool gasket_mmap_has_permissions(struct gasket_dev *gasket_dev,
 	if ((vma->vm_flags & VM_WRITE) &&
 	    !gasket_owned_by_current_tgid(&gasket_dev->dev_info)) {
 		dev_dbg(gasket_dev->dev,
-			"Attempting to mmap a region for write without owning "
-			"device.\n");
+			"Attempting to mmap a region for write without owning device.\n");
 		return false;
 	}
 
@@ -1054,8 +1053,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 	if (bar_index > 0 && is_coherent_region) {
 		dev_err(gasket_dev->dev,
-			"double matching bar and coherent buffers for address "
-			"0x%lx\n",
+			"double matching bar and coherent buffers for address 0x%lx\n",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
 		return -EINVAL;
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 0ca48e688818..7ecfba4f2b06 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -353,8 +353,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 		 */
 		trace_gasket_ioctl_integer_data(arg);
 		dev_dbg(gasket_dev->dev,
-			"Unknown ioctl cmd=0x%x not caught by "
-			"gasket_is_supported_ioctl\n",
+			"Unknown ioctl cmd=0x%x not caught by gasket_is_supported_ioctl\n",
 			cmd);
 		retval = -EINVAL;
 		break;
diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d35c4fb19e28..f6d715787da8 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -237,8 +237,8 @@ int gasket_page_table_init(struct gasket_page_table **ppg_tbl,
 	 * hardware register that contains the page table size.
 	 */
 	if (total_entries == ULONG_MAX) {
-		dev_dbg(device, "Error reading page table size. "
-			"Initializing page table with size 0\n");
+		dev_dbg(device,
+			"Error reading page table size. Initializing page table with size 0\n");
 		total_entries = 0;
 	}
 
@@ -491,8 +491,7 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 
 			if (ret <= 0) {
 				dev_err(pg_tbl->device,
-					"get user pages failed for addr=0x%lx, "
-					"offset=0x%lx [ret=%d]\n",
+					"get user pages failed for addr=0x%lx, offset=0x%lx [ret=%d]\n",
 					page_addr, offset, ret);
 				return ret ? ret : -ENOMEM;
 			}
@@ -779,8 +778,8 @@ static bool gasket_is_extended_dev_addr_bad(struct gasket_page_table *pg_tbl,
 
 	if (page_lvl0_idx >= pg_tbl->num_extended_entries) {
 		dev_err(pg_tbl->device,
-			"starting level 0 slot at %lu is too large, max is < "
-			"%u\n", page_lvl0_idx, pg_tbl->num_extended_entries);
+			"starting level 0 slot at %lu is too large, max is < %u\n",
+			page_lvl0_idx, pg_tbl->num_extended_entries);
 		return true;
 	}
 
@@ -965,8 +964,7 @@ static int gasket_map_extended_pages(struct gasket_page_table *pg_tbl,
 	if (ret) {
 		dev_addr_end = dev_addr + (num_pages / PAGE_SIZE) - 1;
 		dev_err(pg_tbl->device,
-			"page table slots (%lu,%lu) (@ 0x%lx) to (%lu,%lu) are "
-			"not available\n",
+			"page table slots (%lu,%lu) (@ 0x%lx) to (%lu,%lu) are not available\n",
 			gasket_extended_lvl0_page_idx(pg_tbl, dev_addr),
 			dev_addr,
 			gasket_extended_lvl1_page_idx(pg_tbl, dev_addr),
-- 
2.17.1

