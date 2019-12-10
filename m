Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE00E214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014132;
	bh=8xCK5ejZJw5JqOCLcC9w9ySdHcu669dw0YnPtDHWbv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYTZG4WP7eXwbktPG1d7B/cV4CQDk424+/As29OwCpXZ9z2nIdlHVl6BDoDIfH4Xo
	 W49KPxUluJKgjaEQluISAal8mMKpNxkWzEiYEOLEPw54QWjM2aK5ov6xEDb0OJ8Erk
	 BVFGAmBNoy7iTbVXS4vinqoqcRX7Y0medO20S0mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfLJVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbfLJVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA93208C3;
        Tue, 10 Dec 2019 21:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013632;
        bh=8xCK5ejZJw5JqOCLcC9w9ySdHcu669dw0YnPtDHWbv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2KdXUbfHopZYViaG28sBaVpe9eNcmWrLcF7lp6K+jbPfABhjHXlnIvDWiZtvaNNB+
         xJlud/yf9wX4qB/1VjdXMCa6zA9MunHSZn4odTIe4xe4MrZ5gQ40prISo/zWPowZM0
         KiCi652TWYZ1zSF05Yg5UNh4StGgGbiE9QSarRxA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 074/177] media: smiapp: Register sensor after enabling runtime PM on the device
Date:   Tue, 10 Dec 2019 16:30:38 -0500
Message-Id: <20191210213221.11921-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 1236683da8f75..4731e1c72f960 100644
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

