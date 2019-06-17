Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF3EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfFQLyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:54:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:19314 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfFQLyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:54:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:54:06 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2019 04:54:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D4B1162; Mon, 17 Jun 2019 14:54:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] driver core: regmap: Switch to bitmap_zalloc()
Date:   Mon, 17 Jun 2019 14:54:03 +0300
Message-Id: <20190617115403.33241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-lzo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regcache-lzo.c b/drivers/base/regmap/regcache-lzo.c
index fc14e8b9344f..7886303eb026 100644
--- a/drivers/base/regmap/regcache-lzo.c
+++ b/drivers/base/regmap/regcache-lzo.c
@@ -148,20 +148,18 @@ static int regcache_lzo_init(struct regmap *map)
 	 * that register.
 	 */
 	bmp_size = map->num_reg_defaults_raw;
-	sync_bmp = kmalloc_array(BITS_TO_LONGS(bmp_size), sizeof(long),
-				 GFP_KERNEL);
+	sync_bmp = bitmap_zalloc(bmp_size, GFP_KERNEL);
 	if (!sync_bmp) {
 		ret = -ENOMEM;
 		goto err;
 	}
-	bitmap_zero(sync_bmp, bmp_size);
 
 	/* allocate the lzo blocks and initialize them */
 	for (i = 0; i < blkcount; i++) {
 		lzo_blocks[i] = kzalloc(sizeof **lzo_blocks,
 					GFP_KERNEL);
 		if (!lzo_blocks[i]) {
-			kfree(sync_bmp);
+			bitmap_free(sync_bmp);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -213,7 +211,7 @@ static int regcache_lzo_exit(struct regmap *map)
 	 * only once.
 	 */
 	if (lzo_blocks[0])
-		kfree(lzo_blocks[0]->sync_bmp);
+		bitmap_free(lzo_blocks[0]->sync_bmp);
 	for (i = 0; i < blkcount; i++) {
 		if (lzo_blocks[i]) {
 			kfree(lzo_blocks[i]->wmem);
-- 
2.20.1

