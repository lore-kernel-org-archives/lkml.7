Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A1C71142
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4700420651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGJNHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:07:13 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:07:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLyvH-1i2SBE1UBd-00HsN9; Wed, 10 Jul 2019 15:07:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikhil Rao <nikhil.rao@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] mic: avoid statically declaring a 'struct device'.
Date:   Wed, 10 Jul 2019 15:06:51 +0200
Message-Id: <20190710130703.1857586-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jlp5HbZlYtlqeQlfRLIR2LNMe8ikaGeZKn+52+/lu7tLBb8CrDK
 bNyusGUbKd7lc/EDCVMRnEg1w6+F623UaEq1dJLZO8Trdzn+R7wS53MNQ8kUY+MX3SvF5QJ
 Iua3Z/mJ27JIsvGbRhGEPzY8IXTIEktTfbeg83B5jF0EuFScwLt7ua7TGyFdSQfLbYR7Zzo
 guBZAFxHa8Lck/P+rXcIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/PKaBcLQ5uw=:BKj+GPJWRP2HDjTWeurCwN
 NazYhplis81Xc5m5vtS5yoG+WRsJzJpRp6GxS1HqVoBbtu2OGV6hRxFxWRLChg5XkBdQV4ee/
 U4PYnYeHoyvcT0FzjWet609oDReuwe9OH9461aA2l+OQ9YF4TNG2i8NhNYM1Z2z+9dIRZgrcB
 AATyg9MXag5hWDRg6at2RRhSMqYBDiXdO2IBx+1CxuOD2uKr+UAdmp6oB+sz5b4FxAWb/bhcx
 TVKsKCBTwzNMveWehiBS+pJ55CNoL6vNyVlP/tV6X6A30p1JIbpC07bRE+rxTha93uEaE83nU
 URbiRrNlvVxK+w7lqONF0TeUL7Me0ts+b+jAKcC0tsnuSzBR5p/NOs95AlToSq9s2Bl+EmSih
 oisNcU9o/G2X6ymAfkrt2seOXUk40UzPJY2o965umbs+kC+3naBv6xyi/E2v3wIQkHy7KMlf7
 nQLQk7UBuAeJvxzvTehtW/jm7sQvopmRurcTDrRVb4Z3VUsTXHO5wYuNJvP5Dk+0jCTTQU791
 Gu9rWiw+4KV1lu9PdpZV9qDTOFYdXCoWIPvzo60nPX8v2ZaC1XIUBVSzp67wHB6HIGg5GOxqx
 NQi/7pW38voEwhQjPVCFLqhBbF3BBL/s4JV6jkjxaD6jFKuKw5k+ZxLl9EttfB/Hq2Fef0Usf
 v/1hWXZdeWf9IQL5H7swFNCIGTXWMnGgNa1o4azMtf44T755jDCdEOq5eJQe8qDEzgs6LeXJz
 IEimy+kqRAHNJXtt1eEuDsLnWIN2nr0QrHDyWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, declaring a platform device as a static variable is
a bad idea and can cause all kinds of problems, in particular
with the DMA configuration and lifetime rules.

A specific problem we hit here is from a bug in clang that warns
about certain (otherwise valid) macros when used in static variables:

drivers/misc/mic/card/mic_x100.c:285:27: warning: shift count >= width of type [-Wshift-count-overflow]
static u64 mic_dma_mask = DMA_BIT_MASK(64);
                          ^~~~~~~~~~~~~~~~
include/linux/dma-mapping.h:141:54: note: expanded from macro 'DMA_BIT_MASK'
 #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                     ^ ~~~

A slightly better way here is to create the platform device from
a platform_device_info. This avoids the warning and some other problems,
but is still not ideal because the device creation should really be
separated from the driver.

Fixes: dd8d8d44df64 ("misc: mic: MIC card driver specific changes to enable SCIF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/mic/card/mic_x100.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/mic/card/mic_x100.c b/drivers/misc/mic/card/mic_x100.c
index 266ffb6f6c44..a5821166f943 100644
--- a/drivers/misc/mic/card/mic_x100.c
+++ b/drivers/misc/mic/card/mic_x100.c
@@ -282,18 +282,6 @@ static void mic_platform_shutdown(struct platform_device *pdev)
 	mic_remove(pdev);
 }
 
-static u64 mic_dma_mask = DMA_BIT_MASK(64);
-
-static struct platform_device mic_platform_dev = {
-	.name = mic_driver_name,
-	.id   = 0,
-	.num_resources = 0,
-	.dev = {
-		.dma_mask = &mic_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
-	},
-};
-
 static struct platform_driver __refdata mic_platform_driver = {
 	.probe = mic_probe,
 	.remove = mic_remove,
@@ -307,6 +295,12 @@ static int __init mic_init(void)
 {
 	int ret;
 	struct cpuinfo_x86 *c = &cpu_data(0);
+	struct platform_device_info mic_platform_info = {
+		.name = mic_driver_name,
+		.dma_mask = DMA_BIT_MASK(64),
+	};
+	struct platform_device *pdev;
+
 
 	if (!(c->x86 == 11 && c->x86_model == 1)) {
 		ret = -ENODEV;
@@ -316,9 +310,11 @@ static int __init mic_init(void)
 
 	request_module("mic_x100_dma");
 	mic_init_card_debugfs();
-	ret = platform_device_register(&mic_platform_dev);
+
+	pdev = platform_device_register_full(&mic_platform_info);
+	ret = PTR_ERR_OR_ZERO(pdev);
 	if (ret) {
-		pr_err("platform_device_register ret %d\n", ret);
+		pr_err("platform_device_register_full ret %d\n", ret);
 		goto cleanup_debugfs;
 	}
 	ret = platform_driver_register(&mic_platform_driver);
-- 
2.20.0

