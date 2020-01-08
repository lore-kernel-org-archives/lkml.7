Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BECC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE4A2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgAHLn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:43:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:44631 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbgAHLmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 03:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="246319757"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jan 2020 03:42:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 971254E9; Wed,  8 Jan 2020 13:42:02 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/36] watchdog: intel-mid_wdt: Convert to use new SCU IPC API
Date:   Wed,  8 Jan 2020 14:41:41 +0300
Message-Id: <20200108114201.27908-17-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the Intel MID watchdog driver over the new SCU IPC API
where the SCU IPC instance is passed to the functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 53 ++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 470213abfd3d..1ae03b64ef8b 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -33,14 +33,24 @@ enum {
 	SCU_WATCHDOG_KEEPALIVE,
 };
 
-static inline int wdt_command(int sub, u32 *in, int inlen)
+struct mid_wdt {
+	struct watchdog_device wd;
+	struct device *dev;
+	struct intel_scu_ipc_dev *scu;
+};
+
+static inline int
+wdt_command(struct mid_wdt *mid, int sub, const void *in, size_t inlen, size_t size)
 {
-	return intel_scu_ipc_command(IPC_WATCHDOG, sub, in, inlen, NULL, 0);
+	struct intel_scu_ipc_dev *scu = mid->scu;
+
+	return intel_scu_ipc_dev_command_with_size(scu, IPC_WATCHDOG, sub, in,
+						   inlen, size, NULL, 0);
 }
 
 static int wdt_start(struct watchdog_device *wd)
 {
-	struct device *dev = watchdog_get_drvdata(wd);
+	struct mid_wdt *mid = watchdog_get_drvdata(wd);
 	int ret, in_size;
 	int timeout = wd->timeout;
 	struct ipc_wd_start {
@@ -49,38 +59,41 @@ static int wdt_start(struct watchdog_device *wd)
 	} ipc_wd_start = { timeout - MID_WDT_PRETIMEOUT, timeout };
 
 	/*
-	 * SCU expects the input size for watchdog IPC to
-	 * be based on 4 bytes
+	 * SCU expects the input size for watchdog IPC to be 2 which is the
+	 * size of the structure in dwords. SCU IPC normally takes bytes
+	 * but this is a special case where we specify size to be different
+	 * than inlen.
 	 */
 	in_size = DIV_ROUND_UP(sizeof(ipc_wd_start), 4);
 
-	ret = wdt_command(SCU_WATCHDOG_START, (u32 *)&ipc_wd_start, in_size);
+	ret = wdt_command(mid, SCU_WATCHDOG_START, &ipc_wd_start,
+			  sizeof(ipc_wd_start), in_size);
 	if (ret)
-		dev_crit(dev, "error starting watchdog: %d\n", ret);
+		dev_crit(mid->dev, "error starting watchdog: %d\n", ret);
 
 	return ret;
 }
 
 static int wdt_ping(struct watchdog_device *wd)
 {
-	struct device *dev = watchdog_get_drvdata(wd);
+	struct mid_wdt *mid = watchdog_get_drvdata(wd);
 	int ret;
 
-	ret = wdt_command(SCU_WATCHDOG_KEEPALIVE, NULL, 0);
+	ret = wdt_command(mid, SCU_WATCHDOG_KEEPALIVE, NULL, 0, 0);
 	if (ret)
-		dev_crit(dev, "Error executing keepalive: %d\n", ret);
+		dev_crit(mid->dev, "Error executing keepalive: %d\n", ret);
 
 	return ret;
 }
 
 static int wdt_stop(struct watchdog_device *wd)
 {
-	struct device *dev = watchdog_get_drvdata(wd);
+	struct mid_wdt *mid = watchdog_get_drvdata(wd);
 	int ret;
 
-	ret = wdt_command(SCU_WATCHDOG_STOP, NULL, 0);
+	ret = wdt_command(mid, SCU_WATCHDOG_STOP, NULL, 0, 0);
 	if (ret)
-		dev_crit(dev, "Error stopping watchdog: %d\n", ret);
+		dev_crit(mid->dev, "Error stopping watchdog: %d\n", ret);
 
 	return ret;
 }
@@ -110,6 +123,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdt_dev;
 	struct intel_mid_wdt_pdata *pdata = dev->platform_data;
+	struct mid_wdt *mid;
 	int ret;
 
 	if (!pdata) {
@@ -123,10 +137,13 @@ static int mid_wdt_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	wdt_dev = devm_kzalloc(dev, sizeof(*wdt_dev), GFP_KERNEL);
-	if (!wdt_dev)
+	mid = devm_kzalloc(dev, sizeof(*mid), GFP_KERNEL);
+	if (!mid)
 		return -ENOMEM;
 
+	mid->dev = dev;
+	wdt_dev = &mid->wd;
+
 	wdt_dev->info = &mid_wdt_info;
 	wdt_dev->ops = &mid_wdt_ops;
 	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
@@ -135,7 +152,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	wdt_dev->parent = dev;
 
 	watchdog_set_nowayout(wdt_dev, WATCHDOG_NOWAYOUT);
-	watchdog_set_drvdata(wdt_dev, dev);
+	watchdog_set_drvdata(wdt_dev, mid);
 
 	ret = devm_request_irq(dev, pdata->irq, mid_wdt_irq,
 			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
@@ -145,6 +162,10 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	mid->scu = devm_intel_scu_ipc_dev_get(dev);
+	if (!mid->scu)
+		return -EPROBE_DEFER;
+
 	/*
 	 * The firmware followed by U-Boot leaves the watchdog running
 	 * with the default threshold which may vary. When we get here
-- 
2.24.1

