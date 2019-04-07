Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD05C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B09B20B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDGDVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 23:21:08 -0400
Received: from www.osadl.org ([62.245.132.105]:39362 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfDGDVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 23:21:07 -0400
X-Greylist: delayed 3874 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2019 23:21:06 EDT
Received: from localhost.localdomain (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x372GCs1021361;
        Sun, 7 Apr 2019 04:16:17 +0200
From:   Nicholas Mc Guire <hofrat@opentech.at>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH 2/3] media: smiapp: regs: add range to usleep_range
Date:   Sun,  7 Apr 2019 04:16:03 +0200
Message-Id: <1554603364-10500-2-git-send-email-hofrat@opentech.at>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1554603364-10500-1-git-send-email-hofrat@opentech.at>
References: <1554603364-10500-1-git-send-email-hofrat@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this is a retry loop for a sender not responding there is no reason
to mandate a high accuracy delay - extend the sleep range to 2-4ms
so that the hrtimer subsystem can work efficiently.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located by an experimental coccinelle script

Patch was compile tested with: x86_64_defconfig + MEDIA_SUPPORT=m,
MEDIA_CAMERA_SUPPORT=y, MEDIA_CONTROLLER=y, VIDEO_V4L2_SUBDEV_API=y,
VIDEO_SMIAPP=m

Patch is against 5.1-rc3 (localversion-next is next-20190405)

 drivers/media/i2c/smiapp/smiapp-regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-regs.c b/drivers/media/i2c/smiapp/smiapp-regs.c
index 145653d..dfa4f99 100644
--- a/drivers/media/i2c/smiapp/smiapp-regs.c
+++ b/drivers/media/i2c/smiapp/smiapp-regs.c
@@ -276,7 +276,7 @@ int smiapp_write_no_quirk(struct smiapp_sensor *sensor, u32 reg, u32 val)
 			return 0;
 		}
 
-		usleep_range(2000, 2000);
+		usleep_range(2000, 4000);
 	}
 
 	dev_err(&client->dev,
-- 
2.1.4

