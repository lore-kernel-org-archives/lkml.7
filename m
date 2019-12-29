Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7B3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975CE207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640774;
	bh=37GhvsGRf9iOwK6d9QDIImLR2MRH5h+lFXgn8HZGWhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtN5xCa/63iTbqsFDshfEWZvdhYlyYg2i+/LheCZ4qIG5nRbot7ehzcNJWdxZHWUN
	 +ZvOm34CoVz7WobCJ8Vp2B6BjhoY8MqZrl9EJBBUNAzGHHzxYFEOY+8vau4emCJdRb
	 zCKAC4V60qhClsYP0aeJskSufK/z/RUyGwTEOARU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfL2Rcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfL2Rcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:32:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0009220409;
        Sun, 29 Dec 2019 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640767;
        bh=37GhvsGRf9iOwK6d9QDIImLR2MRH5h+lFXgn8HZGWhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/bi9PJMWvP5H56GIrD+VCDZ7C2oVNZ0apZk1UT/Js1dYeUeIDk9yr5ricp4xXuH7
         7i8uz9PtFJReIJbSDMn7r+zZMG+jYcJfNqph1O+TUw+ADFMAcbrjWxTBLdqrM0n/++
         +qyPlfsfK9F2RFbG1NvhUIuA32RGgHli37C2yyn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/219] media: smiapp: Register sensor after enabling runtime PM on the device
Date:   Sun, 29 Dec 2019 18:18:13 +0100
Message-Id: <20191229162521.188293750@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 90c9e4a4dba9f4de331372e745fb1991c1faa598 ]

Earlier it was possible that the parts of the driver that assumed runtime
PM was enabled were being called before runtime PM was enabled in the
driver's probe function. So enable runtime PM before registering the
sub-device.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 1236683da8f7..4731e1c72f96 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -3108,19 +3108,23 @@ static int smiapp_probe(struct i2c_client *client,
 	if (rval < 0)
 		goto out_media_entity_cleanup;
 
-	rval = v4l2_async_register_subdev_sensor_common(&sensor->src->sd);
-	if (rval < 0)
-		goto out_media_entity_cleanup;
-
 	pm_runtime_set_active(&client->dev);
 	pm_runtime_get_noresume(&client->dev);
 	pm_runtime_enable(&client->dev);
+
+	rval = v4l2_async_register_subdev_sensor_common(&sensor->src->sd);
+	if (rval < 0)
+		goto out_disable_runtime_pm;
+
 	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
 	pm_runtime_use_autosuspend(&client->dev);
 	pm_runtime_put_autosuspend(&client->dev);
 
 	return 0;
 
+out_disable_runtime_pm:
+	pm_runtime_disable(&client->dev);
+
 out_media_entity_cleanup:
 	media_entity_cleanup(&sensor->src->sd.entity);
 
-- 
2.20.1



