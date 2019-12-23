Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D00C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2908921775
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLWOSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:18:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:58347 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfLWOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="219181102"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 23 Dec 2019 06:17:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2A6C0D49; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/37] platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
Date:   Mon, 23 Dec 2019 17:17:00 +0300
Message-Id: <20191223141716.13727-22-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used anywhere so drop them completely.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h | 12 ------
 drivers/platform/x86/intel_pmc_ipc.c | 59 ----------------------------
 2 files changed, 71 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 966ff2171ff9..e6da1ce26256 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -34,9 +34,7 @@
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen);
 int intel_pmc_s0ix_counter_read(u64 *data);
-int intel_pmc_gcr_read(u32 offset, u32 *data);
 int intel_pmc_gcr_read64(u32 offset, u64 *data);
-int intel_pmc_gcr_write(u32 offset, u32 data);
 
 #else
 
@@ -51,21 +49,11 @@ static inline int intel_pmc_s0ix_counter_read(u64 *data)
 	return -EINVAL;
 }
 
-static inline int intel_pmc_gcr_read(u32 offset, u32 *data)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_gcr_read64(u32 offset, u64 *data)
 {
 	return -EINVAL;
 }
 
-static inline int intel_pmc_gcr_write(u32 offset, u32 data)
-{
-	return -EINVAL;
-}
-
 #endif /*CONFIG_INTEL_PMC_IPC*/
 
 #endif
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 83f47df1c4a5..677ed470e14e 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -210,35 +210,6 @@ static inline int is_gcr_valid(u32 offset)
 	return 0;
 }
 
-/**
- * intel_pmc_gcr_read() - Read a 32-bit PMC GCR register
- * @offset:	offset of GCR register from GCR address base
- * @data:	data pointer for storing the register output
- *
- * Reads the 32-bit PMC GCR register at given offset.
- *
- * Return:	negative value on error or 0 on success.
- */
-int intel_pmc_gcr_read(u32 offset, u32 *data)
-{
-	int ret;
-
-	spin_lock(&ipcdev.gcr_lock);
-
-	ret = is_gcr_valid(offset);
-	if (ret < 0) {
-		spin_unlock(&ipcdev.gcr_lock);
-		return ret;
-	}
-
-	*data = readl(ipcdev.gcr_mem_base + offset);
-
-	spin_unlock(&ipcdev.gcr_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_gcr_read);
-
 /**
  * intel_pmc_gcr_read64() - Read a 64-bit PMC GCR register
  * @offset:	offset of GCR register from GCR address base
@@ -268,36 +239,6 @@ int intel_pmc_gcr_read64(u32 offset, u64 *data)
 }
 EXPORT_SYMBOL_GPL(intel_pmc_gcr_read64);
 
-/**
- * intel_pmc_gcr_write() - Write PMC GCR register
- * @offset:	offset of GCR register from GCR address base
- * @data:	register update value
- *
- * Writes the PMC GCR register of given offset with given
- * value.
- *
- * Return:	negative value on error or 0 on success.
- */
-int intel_pmc_gcr_write(u32 offset, u32 data)
-{
-	int ret;
-
-	spin_lock(&ipcdev.gcr_lock);
-
-	ret = is_gcr_valid(offset);
-	if (ret < 0) {
-		spin_unlock(&ipcdev.gcr_lock);
-		return ret;
-	}
-
-	writel(data, ipcdev.gcr_mem_base + offset);
-
-	spin_unlock(&ipcdev.gcr_lock);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_pmc_gcr_write);
-
 /**
  * intel_pmc_gcr_update() - Update PMC GCR register bits
  * @offset:	offset of GCR register from GCR address base
-- 
2.24.0

