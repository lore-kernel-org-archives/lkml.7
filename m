Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F357CCA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A8820818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfKEFvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:51:17 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:50753 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbfKEFvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:51:17 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 2BF163C0591;
        Tue,  5 Nov 2019 06:51:15 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vcDgZBvjmmhC; Tue,  5 Nov 2019 06:51:09 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id BD2323C0585;
        Tue,  5 Nov 2019 06:51:09 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 5 Nov 2019
 06:51:09 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-mmc@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH 2/3] mmc: host: Compress 'fixed-emmc-driver-type' handling
Date:   Tue, 5 Nov 2019 06:50:14 +0100
Message-ID: <20191105055015.23656-2-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105055015.23656-1-erosca@de.adit-jv.com>
References: <20191105055015.23656-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for reading two additional OF properties (inspired from
"fixed-emmc-driver-type"):
 - fixed-emmc-driver-type-hs200
 - fixed-emmc-driver-type-hs400

The parsing mechanism is common too all three, thus factored out.
The only functional change is a tiny update in the error message.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/mmc/core/host.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 105b7a7c0251..54abfdfc69ba 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -161,6 +161,20 @@ static void mmc_retune_timer(struct timer_list *t)
 	mmc_retune_needed(host);
 }
 
+static void mmc_of_read_drv_type(struct mmc_host *host, char *prop, u32 *val)
+{
+	struct device *dev = host->parent;
+	u32 drv_type;
+
+	if (device_property_read_u32(dev, prop, &drv_type))
+		return;
+
+	if (host->caps & MMC_CAP_NONREMOVABLE)
+		*val = drv_type;
+	else
+		dev_err(dev, "can't use %s, media is removable\n", prop);
+}
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
@@ -173,7 +187,7 @@ static void mmc_retune_timer(struct timer_list *t)
 int mmc_of_parse(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
-	u32 bus_width, drv_type, cd_debounce_delay_ms;
+	u32 bus_width, cd_debounce_delay_ms;
 	int ret;
 	bool cd_cap_invert, cd_gpio_invert = false;
 	bool ro_cap_invert, ro_gpio_invert = false;
@@ -321,13 +335,7 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_NO_MMC;
 
 	/* Must be after "non-removable" check */
-	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
-		if (host->caps & MMC_CAP_NONREMOVABLE)
-			host->fixed_drv_type = drv_type;
-		else
-			dev_err(host->parent,
-				"can't use fixed driver type, media is removable\n");
-	}
+	mmc_of_read_drv_type(host, "fixed-emmc-driver-type", &host->fixed_drv_type);
 
 	host->dsr_req = !device_property_read_u32(dev, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
-- 
2.23.0

