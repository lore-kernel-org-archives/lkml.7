Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF29C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F2321775
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfLWOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:19:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:18205 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfLWORZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="249500509"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2019 06:17:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 76EC1720; Mon, 23 Dec 2019 16:17:17 +0200 (EET)
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
Subject: [PATCH 07/37] platform/x86: intel_scu_ipc: Sleeping is fine when polling
Date:   Mon, 23 Dec 2019 17:16:46 +0300
Message-Id: <20191223141716.13727-8-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why the driver would need to block other threads from
running the CPU while it is waiting for the SCU IPC to complete its
work. For this reason switch the driver to use usleep_range() instead
with a bit more relaxed polling loop.

Also add constant for the timeout and use the same value for both
polling and interrupt modes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 29 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 43eaf9400c67..8db0644900a3 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -79,6 +79,9 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 #define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
+/* Timeout in jiffies */
+#define IPC_TIMEOUT		(3 * HZ)
+
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
 
 /*
@@ -132,24 +135,20 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 /* Wait till scu status is busy */
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
-	u32 status = ipc_read_status(scu);
-	u32 loop_count = 100000;
+	unsigned long end = jiffies + msecs_to_jiffies(IPC_TIMEOUT);
 
-	/* break if scu doesn't reset busy bit after huge retry */
-	while ((status & IPC_STATUS_BUSY) && --loop_count) {
-		udelay(1); /* scu processing time is in few u secods */
-		status = ipc_read_status(scu);
-	}
+	do {
+		u32 status;
 
-	if (status & IPC_STATUS_BUSY) {
-		dev_err(scu->dev, "IPC timed out");
-		return -ETIMEDOUT;
-	}
+		status = ipc_read_status(scu);
+		if (!(status & IPC_STATUS_BUSY))
+			return (status & IPC_STATUS_ERR) ? -EIO : 0;
 
-	if (status & IPC_STATUS_ERR)
-		return -EIO;
+		usleep_range(50, 100);
+	} while (time_before(jiffies, end));
 
-	return 0;
+	dev_err(scu->dev, "IPC timed out");
+	return -ETIMEDOUT;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
@@ -157,7 +156,7 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
 
-	if (!wait_for_completion_timeout(&scu->cmd_complete, 3 * HZ)) {
+	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT)) {
 		dev_err(scu->dev, "IPC timed out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.24.0

