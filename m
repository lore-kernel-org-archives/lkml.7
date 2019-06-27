Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326BDC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EFD2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfF0MwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:52:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:36562 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfF0MwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:52:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 05:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; 
   d="scan'208";a="245806010"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2019 05:52:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 9/9] intel_th: msu: Preserve pre-existing buffer configuration
Date:   Thu, 27 Jun 2019 15:51:52 +0300
Message-Id: <20190627125152.54905-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSU configuration registers may contain buffer address/size set by
the BIOS or an external hardware debugger, which may want to take over
tracing from the driver when the driver is not actively tracing.

Preserve these settings when not actively tracing.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 58dd381debd2..9b6ef4edf09e 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -116,6 +116,8 @@ struct msc {
 	unsigned int		single_wrap : 1;
 	void			*base;
 	dma_addr_t		base_addr;
+	u32			orig_addr;
+	u32			orig_sz;
 
 	/* <0: no buffer, 0: no users, >0: active users */
 	atomic_t		user_count;
@@ -736,6 +738,9 @@ static int msc_configure(struct msc *msc)
 		msc_buffer_clear_hw_header(msc);
 	}
 
+	msc->orig_addr = ioread32(msc->reg_base + REG_MSU_MSC0BAR);
+	msc->orig_sz   = ioread32(msc->reg_base + REG_MSU_MSC0SIZE);
+
 	reg = msc->base_addr >> PAGE_SHIFT;
 	iowrite32(reg, msc->reg_base + REG_MSU_MSC0BAR);
 
@@ -810,8 +815,8 @@ static void msc_disable(struct msc *msc)
 
 	msc->enabled = 0;
 
-	iowrite32(0, msc->reg_base + REG_MSU_MSC0BAR);
-	iowrite32(0, msc->reg_base + REG_MSU_MSC0SIZE);
+	iowrite32(msc->orig_addr, msc->reg_base + REG_MSU_MSC0BAR);
+	iowrite32(msc->orig_sz, msc->reg_base + REG_MSU_MSC0SIZE);
 
 	dev_dbg(msc_dev(msc), "MSCnNWSA: %08x\n",
 		ioread32(msc->reg_base + REG_MSU_MSC0NWSA));
-- 
2.20.1

