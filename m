Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7942CA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E1A20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 05:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfKEFvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 00:51:46 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:50763 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKEFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:51:46 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id EC4323C0594;
        Tue,  5 Nov 2019 06:51:42 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NIvBb3uK3IUk; Tue,  5 Nov 2019 06:51:37 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 807E13C0585;
        Tue,  5 Nov 2019 06:51:37 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 5 Nov 2019
 06:51:36 +0100
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
Subject: [PATCH 3/3] mmc: core: Add 'fixed-emmc-driver-type-hs{200,400}'
Date:   Tue, 5 Nov 2019 06:50:15 +0100
Message-ID: <20191105055015.23656-3-erosca@de.adit-jv.com>
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

Add support for two more DT bindings, which stem from the need to
implement below real-life requirement shared by eMMC vendor:

 ---snip---
 Use "drive strength" value of 4 or 1 for HS400 or 0 for HS200.
 ---snip---

Inspire from [Y] and [Z] during implementation and testing (H3ULCB-KF).
Below decision matrix is intended as function of user's input:

      [0]        [2]        [4]
[0]  hs200:[0]  hs200:[2]  hs200:[0]
     hs400:[0]  hs400:[0]  hs400:[4]
[2]  hs200:[2]  hs200:[2]  hs200:[2]
     hs400:[0]  hs400:[R]  hs400:[4]
[4]  hs200:[0]  hs200:[2]  hs200:[R]
     hs400:[4]  hs400:[4]  hs400:[4]

[0] "fixed-emmc-driver-type"
[2] "fixed-emmc-driver-type-hs200"
[4] "fixed-emmc-driver-type-hs400"
[R] RAW/ECSD drive strength as implemented in
    commit cc4f414c885cd0 ("mmc: mmc: Add driver strength selection")
[Y] commit 6186d06c519e21 ("mmc: parse new binding for eMMC fixed driver type")
[Z] https://www.elinux.org/Tests:eMMC-fixed-drive-strength

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/mmc/core/host.c  |  4 ++++
 drivers/mmc/core/mmc.c   | 19 ++++++++++++++++---
 include/linux/mmc/host.h |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 54abfdfc69ba..2a3d3b542e0d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -336,6 +336,8 @@ int mmc_of_parse(struct mmc_host *host)
 
 	/* Must be after "non-removable" check */
 	mmc_of_read_drv_type(host, "fixed-emmc-driver-type", &host->fixed_drv_type);
+	mmc_of_read_drv_type(host, "fixed-emmc-driver-type-hs200", &host->fixed_drv_type_hs200);
+	mmc_of_read_drv_type(host, "fixed-emmc-driver-type-hs400", &host->fixed_drv_type_hs400);
 
 	host->dsr_req = !device_property_read_u32(dev, "dsr", &host->dsr);
 	if (host->dsr_req && (host->dsr & ~0xffff)) {
@@ -455,6 +457,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->max_blk_count = PAGE_SIZE / 512;
 
 	host->fixed_drv_type = -EINVAL;
+	host->fixed_drv_type_hs200 = -EINVAL;
+	host->fixed_drv_type_hs400 = -EINVAL;
 	host->ios.power_delay_ms = 10;
 
 	return host;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c8804895595f..89e6fb9aedeb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -62,6 +62,8 @@ static const unsigned int taac_mant[] = {
 		__res & __mask;						\
 	})
 
+static void mmc_select_driver_type(struct mmc_card *card, int timing);
+
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
@@ -1192,6 +1194,8 @@ static int mmc_select_hs400(struct mmc_card *card)
 		return err;
 	}
 
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS400);
+
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1270,6 +1274,8 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	if (err)
 		goto out_err;
 
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS200);
+
 	/* Switch HS to HS200 */
 	val = EXT_CSD_TIMING_HS200 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
@@ -1304,10 +1310,17 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	return err;
 }
 
-static void mmc_select_driver_type(struct mmc_card *card)
+static void mmc_select_driver_type(struct mmc_card *card, int timing)
 {
 	int card_drv_type, drive_strength, drv_type = 0;
 	int fixed_drv_type = card->host->fixed_drv_type;
+	int fixed_drv_type_hs200 = card->host->fixed_drv_type_hs200;
+	int fixed_drv_type_hs400 = card->host->fixed_drv_type_hs400;
+
+	if (fixed_drv_type_hs200 >= 0 && timing == EXT_CSD_TIMING_HS200)
+		fixed_drv_type = fixed_drv_type_hs200;
+	else if (fixed_drv_type_hs400 >= 0 && timing == EXT_CSD_TIMING_HS400)
+		fixed_drv_type = fixed_drv_type_hs400;
 
 	card_drv_type = card->ext_csd.raw_driver_strength |
 			mmc_driver_type_mask(0);
@@ -1385,7 +1398,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
-	mmc_select_driver_type(card);
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS400);
 
 	/* Switch card to HS400 */
 	val = EXT_CSD_TIMING_HS400 |
@@ -1445,7 +1458,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 	if (err)
 		return err;
 
-	mmc_select_driver_type(card);
+	mmc_select_driver_type(card, EXT_CSD_TIMING_HS200);
 
 	/*
 	 * Set the bus width(4 or 8) with host's support and
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..6960ba98810a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -371,6 +371,8 @@ struct mmc_host {
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
+	int			fixed_drv_type_hs200;	/* HS200-specific fixed_drv_type */
+	int			fixed_drv_type_hs400;	/* HS400-specific fixed_drv_type */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
2.23.0

