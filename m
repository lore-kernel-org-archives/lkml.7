Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A8BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EC42177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM7UM775"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfEWPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:46:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51778 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfEWPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:46:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id c77so6377280wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qrctY6UlwvZSSLcwbTDwUkuDUQQP9VVX4afFKiNDkdU=;
        b=fM7UM775yCnBpiE36t4mQ/gBip8zhKjyW6Bl4brF2h29R1JQ3m+d6ayYXyikxA+MwJ
         fATJrUEV2FQSoG5aTWL5d0/gENV11wXp62Dqju9rtBfB7NoC44FVNjnyR4sUTA6wJI3o
         csnczgz71NfheQOf3VC5ZawaX4lt5s1PU5LGu8AJRzGURItCr75IF03aqRWogxVX/rmL
         xUDwJi2YHLThm922Q2NVKpX+Ic5Wv//H4Xv9LD6lfTXmKxuwMG8AfCkzmCNIWBq1v9pl
         bkOUdboMj0gieOEP7Qpd4Y6Y97ojDeQUZtrQQJ5fm5JtPqDH6704MwmVNwV5koqITzI+
         0meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qrctY6UlwvZSSLcwbTDwUkuDUQQP9VVX4afFKiNDkdU=;
        b=jsDry6w3JSxYycDgthtHytRfclEctaASfgFDqCom94nJZ/Ns+O3ohmReBgQM4NW3JX
         jOMMVZ3boP29P0pk1oI5rNptOhstp26wLfpiV4KvjAt5Yfe2K2tzuCl9NpiaHj5DgVhx
         0Xl20Ds2fbLMFWAN9mkZ/hjULTHG+7mbM5lNJQFIlWt7Hpy3yKpVcXKfbk4zVGBY9oT7
         ifKeB6Xb+JMJ8TrDaHK5SvhgCDvBF+6AKWANJwV6MBiDhSKrqk0ncCBbcY0vplqI6+Jv
         njA3JJLTZA4aDsSyukljOKCcpfc02MvYeAxIopoPz1ZbjMlqm8QrgWoQ+6VmWgp9JDAz
         b5dA==
X-Gm-Message-State: APjAAAUeZajhmlfjwu/7f3HDxosycjbjg1qOwkiCR6+VMSAWiQ+Rr6Lo
        6OVa8uEaIGHl4muSzpzODmo=
X-Google-Smtp-Source: APXvYqxTS5Y9Fz7TCCgQvfJCP/+OOFfJh4/vV2wtZP2PgsPS+oDrxHOD1OPV/Dj3IfMRgvDUxnC0UQ==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr12457924wma.48.1558626402813;
        Thu, 23 May 2019 08:46:42 -0700 (PDT)
Received: from localhost.localdomain (ip28.173.mip.uni-hannover.de. [130.75.173.28])
        by smtp.gmail.com with ESMTPSA id q16sm10211415wmj.17.2019.05.23.08.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:46:42 -0700 (PDT)
From:   Tianzheng Li <ltz0302@gmail.com>
To:     rspringer@google.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, benchan@chromium.org,
        toddpoynor@google.com, linux-kernel@i4.cs.fau.de,
        zhangjie.cnde@gmail.com
Subject: [PATCH] staging/gasket: Fix string split
Date:   Thu, 23 May 2019 17:46:39 +0200
Message-Id: <20190523154639.42662-1-ltz0302@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unnecessary quoted string splits.

Reported-by: Jie Zhang <zhangjie.cnde@gmail.com>
Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
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

