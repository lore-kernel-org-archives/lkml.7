Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A995AC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710E02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWzXshpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfEUPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:07:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51261 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfEUPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:07:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id c77so3371715wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xW3NTsczgih5h5jOq9JBzpApEgnkf4EsVSIC2Sl+bb8=;
        b=OWzXshpD66HZNTSJ+nPTmCS7NW8XW6pBYFO8eVBZklc+XXcv6cUBi1MrJFtNf1ak/p
         FMBm64fq8ivogk32hmxpMmaHOKCOZCQ+QQ38+ctAczOzP9kZgZptdad/3tTaqzzIjrS9
         cIlqy6JQlePFeOxudBMfZA+HIg2jL0hp8q9gPneqS9LdWCZXZeiV7SHvVLAKs003lAbb
         vjQBknOyMEHpw8GcGcpO1HnQehMzWVtNVeYnc62rmqAnFXBqERbnfU0Ihy7jxzVH3CJX
         0IThlOpsB1EDfjedV/Jv23NRT7nIKbkq+avuKMfjtGUyDwvZf3WSdsVEO1LkoLA2bVpi
         KhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xW3NTsczgih5h5jOq9JBzpApEgnkf4EsVSIC2Sl+bb8=;
        b=YkaM9614LhO2Dy3aA2BOGba3Qatsea86Kv3G4GoGW5UZjrvqSr/l73IwJgILUNkSdO
         j9Sslk0pc5Uceab9OQh4pbvL7fPkJSjcbxIG5DCR/l6Hxp3WHyhdawbB9b704x705Cbn
         GfUbbPGtsEbmDJaNCON/uXpUQdx937NmUUJA3B79Kc1cob7pNdqFGi84CFh+t7rLjH55
         jr6uEqChK3qgzoiTYo7nzNRe39vb5A5+mNOtvAPEYJqNMO9iyj3sjFIS00dnCB/5p9RJ
         Ii2xARG+299QYzr5847X6pT4JtUWjLcPja2QmeMNkDCFdyx0L1X9bDYHukOg7pea/6hw
         LLJA==
X-Gm-Message-State: APjAAAV6nawz3WuPWvApRLkTh2edz3fF64OnPACBUhOeTK/qV4ZaCrCL
        jVnBDBDoMS/NV32cZRvenHk=
X-Google-Smtp-Source: APXvYqyfzyrneNtZwdopu3igH/ZDJAw81OSEEH+Jm+kOX7ayIuQtDxtpMZPgB5s8d2GjRWBLk5ywMQ==
X-Received: by 2002:a1c:254:: with SMTP id 81mr3717119wmc.151.1558451264183;
        Tue, 21 May 2019 08:07:44 -0700 (PDT)
Received: from localhost.localdomain (ip179248.wh.uni-hannover.de. [130.75.179.248])
        by smtp.gmail.com with ESMTPSA id v5sm43046172wra.83.2019.05.21.08.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 08:07:43 -0700 (PDT)
From:   Tianzheng Li <ltz0302@gmail.com>
To:     rspringer@google.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, benchan@chromium.org,
        toddpoynor@google.com, linux-kernel@i4.cs.fau.de,
        zhangjie.cnde@gmail.com
Subject: [PATCH] staging/gasket: Fix string split
Date:   Tue, 21 May 2019 17:07:28 +0200
Message-Id: <20190521150728.25501-1-ltz0302@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary quoted string splits.

Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
Signed-off-by: Jie Zhang <zhangjie.cnde@gmail.com>
---
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

