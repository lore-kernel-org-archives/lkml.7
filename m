Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6639C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3075218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbfGWHpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:45:04 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2579 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfGWHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:45:04 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d36baee828-f8d46; Tue, 23 Jul 2019 15:44:46 +0800 (CST)
X-RM-TRANSID: 2ee35d36baee828-f8d46
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d36baed58e-84ede;
        Tue, 23 Jul 2019 15:44:45 +0800 (CST)
X-RM-TRANSID: 2ee15d36baed58e-84ede
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ac97: Fix double free of ac97_codec_device
Date:   Tue, 23 Jul 2019 15:44:41 +0800
Message-Id: <1563867881-2554-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_device will call ac97_codec_release to free
ac97_codec_device and other resources, so remove the kfree
and other redundant code.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 sound/ac97/bus.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 7b977b7..7985dd8 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -122,17 +122,12 @@ static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
 						      vendor_id);
 
 	ret = device_add(&codec->dev);
-	if (ret)
-		goto err_free_codec;
+	if (ret) {
+		put_device(&codec->dev);
+		return ret;
+	}
 
 	return 0;
-err_free_codec:
-	of_node_put(codec->dev.of_node);
-	put_device(&codec->dev);
-	kfree(codec);
-	ac97_ctrl->codecs[idx] = NULL;
-
-	return ret;
 }
 
 unsigned int snd_ac97_bus_scan_one(struct ac97_controller *adrv,
-- 
1.9.1



