Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE9C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E0220B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfHFJLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:11:36 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52762 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbfHFJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:11:35 -0400
Received: from [167.98.27.226] (helo=ct-lt-765.unassigned)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1huvUu-0005Yh-SW; Tue, 06 Aug 2019 10:11:13 +0100
Received: from ikerpalomar by ct-lt-765.unassigned with local (Exim 4.89)
        (envelope-from <ikerpalomar@ct-lt-765.unassigned>)
        id 1huvUu-0003Tj-AP; Tue, 06 Aug 2019 10:11:12 +0100
From:   Iker Perez <iker.perez@codethink.co.uk>
To:     linux-hwmon@vger.kernel.org, linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>
Subject: [PATCH 3/4] hwmon: (lm75) Add new fields into lm75_params_
Date:   Tue,  6 Aug 2019 10:11:06 +0100
Message-Id: <20190806091107.13322-4-iker.perez@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190806091107.13322-1-iker.perez@codethink.co.uk>
References: <20190806091107.13322-1-iker.perez@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>

The new fields are included to prepare the driver for next patch. The
fields are:

* *resolutions: Stores all the supported resolutions by the device.
* num_sample_times: Stores the number of possible sample times.
* *sample_times: Stores all the possible sample times to be set.
* sample_set_masks: The set_masks for the possible sample times
* sample_clr_mask: Clear mask to set the default sample time.

Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
---
 drivers/hwmon/lm75.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 477ac0732ddf..a8d0a6fb9762 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -58,15 +58,24 @@ enum lm75_type {		/* keep sorted in alphabetical order */
  *			the chip.
  * @resolution:		Number of bits to represent the temperatue value.
  * @resolution_limits:	Resolution range.
+ * @num_sample_times:	Number of possible sample times to be set.
  * default_sample_time:	Sample time to be set by default.
+ * @sample_times:	All the possible sample times to be set.
+ * @sample_set_masks:	All the set_masks for the possible sample times.
+ * @sample_clr_mask:	Clear mask to set the default sample time.
  */
 
 struct lm75_params {
-	u8		set_mask;
-	u8		clr_mask;
-	u8		default_resolution;
-	u8		resolution_limits;
-	unsigned int	default_sample_time;
+	u8			set_mask;
+	u8			clr_mask;
+	u8			default_resolution;
+	u8			resolution_limits;
+	const u8		*resolutions;
+	unsigned int		default_sample_time;
+	u8			num_sample_times;
+	const unsigned int	*sample_times;
+	const u8		*sample_set_masks;
+	u8			sample_clr_mask;
 };
 
 /* Addresses scanned */
@@ -214,7 +223,14 @@ static const struct lm75_params device_params[] = {
 	[tmp75b] = { /* not one-shot mode, Conversion rate 37Hz */
 		.clr_mask = 1 << 7 | 3 << 5,
 		.default_resolution = 12,
+		.sample_set_masks = (u8 []){ 0 << 5, 1 << 5, 2 << 5,
+			3 << 5 },
+		.sample_clr_mask = 3 << 5,
 		.default_sample_time = MSEC_PER_SEC / 37,
+		.sample_times = (unsigned int []){ MSEC_PER_SEC / 37,
+			MSEC_PER_SEC / 18,
+			MSEC_PER_SEC / 9, MSEC_PER_SEC / 4 },
+		.num_sample_times = 4,
 	},
 	[tmp75c] = {
 		.clr_mask = 1 << 5,	/*not one-shot mode*/
-- 
2.11.0

