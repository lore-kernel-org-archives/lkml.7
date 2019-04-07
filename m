Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF1C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3201520B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDGDVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 23:21:13 -0400
Received: from www.osadl.org ([62.245.132.105]:39362 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfDGDVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 23:21:12 -0400
X-Greylist: delayed 3874 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2019 23:21:06 EDT
Received: from localhost.localdomain (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x372GCs0021361;
        Sun, 7 Apr 2019 04:16:12 +0200
From:   Nicholas Mc Guire <hofrat@opentech.at>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH 1/3] media: smiapp: core: add range to usleep_range
Date:   Sun,  7 Apr 2019 04:16:02 +0200
Message-Id: <1554603364-10500-1-git-send-email-hofrat@opentech.at>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the hrtimer subsystem to coalesce delay timers of lower accuracy
by providing a suitable range

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located by an experimental coccinelle script

hrtimers in atomic context have limited accuracy due to possible
context-switching and interruption so the accuracy is limited 
anyway. Giving the hrtimer subsystem a reasonable range for merging
hrtimers helps to reduce the load on the hrtimer subsystem. As this
delays do not seem to mandate high accuracy the range of a factor
two seems acceptable.

Patch was compile tested with: x86_64_defconfig + MEDIA_SUPPORT=m,
MEDIA_CAMERA_SUPPORT=y, MEDIA_CONTROLLER=y, VIDEO_V4L2_SUBDEV_API=y,
VIDEO_SMIAPP=m                                                                                               
(with a number of sparse warnings on sizeof() usage)

Patch is against 5.1-rc3 (localversion-next is next-20190405)

 drivers/media/i2c/smiapp/smiapp-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 58a45c3..c0c29ec 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -1222,19 +1222,19 @@ static int smiapp_power_on(struct device *dev)
 		dev_err(&client->dev, "failed to enable vana regulator\n");
 		return rval;
 	}
-	usleep_range(1000, 1000);
+	usleep_range(1000, 2000);
 
 	rval = clk_prepare_enable(sensor->ext_clk);
 	if (rval < 0) {
 		dev_dbg(&client->dev, "failed to enable xclk\n");
 		goto out_xclk_fail;
 	}
-	usleep_range(1000, 1000);
+	usleep_range(1000, 2000);
 
 	gpiod_set_value(sensor->xshutdown, 1);
 
 	sleep = SMIAPP_RESET_DELAY(sensor->hwcfg->ext_clk);
-	usleep_range(sleep, sleep);
+	usleep_range(sleep, sleep*2);
 
 	mutex_lock(&sensor->mutex);
 
@@ -1381,7 +1381,7 @@ static int smiapp_power_off(struct device *dev)
 
 	gpiod_set_value(sensor->xshutdown, 0);
 	clk_disable_unprepare(sensor->ext_clk);
-	usleep_range(5000, 5000);
+	usleep_range(5000, 10000);
 	regulator_disable(sensor->vana);
 	sensor->streaming = false;
 
-- 
2.1.4

