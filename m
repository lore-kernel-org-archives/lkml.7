Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ADE2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKKWPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:15:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:55802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbfKKWPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:15:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0439DAC52;
        Mon, 11 Nov 2019 22:15:29 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] soc: amlogic: socinfo: Avoid soc_device_to_device()
Date:   Mon, 11 Nov 2019 23:15:21 +0100
Message-Id: <20191111221521.1587-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper soc_device_to_device() is considered deprecated.
For a driver __init function the predictable prefix text
"soc soc0:" from dev_info() does not add real value, so use
pr_info() to emit the info text without such prefix.

While at it, normalize the casing of "detected" for GX.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 4 +---
 drivers/soc/amlogic/meson-mx-socinfo.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 01fc0d20a70d..105b819bbd5f 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -129,7 +129,6 @@ static int __init meson_gx_socinfo_init(void)
 	struct device_node *np;
 	struct regmap *regmap;
 	unsigned int socinfo;
-	struct device *dev;
 	int ret;
 
 	/* look up for chipid node */
@@ -192,9 +191,8 @@ static int __init meson_gx_socinfo_init(void)
 		kfree(soc_dev_attr);
 		return PTR_ERR(soc_dev);
 	}
-	dev = soc_device_to_device(soc_dev);
 
-	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected\n",
+	pr_info("Amlogic Meson %s Revision %x:%x (%x:%x) detected\n",
 			soc_dev_attr->soc_id,
 			socinfo_to_major(socinfo),
 			socinfo_to_minor(socinfo),
diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic/meson-mx-socinfo.c
index 78f0f1aeca57..7db2c94a7130 100644
--- a/drivers/soc/amlogic/meson-mx-socinfo.c
+++ b/drivers/soc/amlogic/meson-mx-socinfo.c
@@ -167,8 +167,8 @@ static int __init meson_mx_socinfo_init(void)
 		return PTR_ERR(soc_dev);
 	}
 
-	dev_info(soc_device_to_device(soc_dev), "Amlogic %s %s detected\n",
-		 soc_dev_attr->soc_id, soc_dev_attr->revision);
+	pr_info("Amlogic %s %s detected\n",
+		soc_dev_attr->soc_id, soc_dev_attr->revision);
 
 	return 0;
 }
-- 
2.16.4

