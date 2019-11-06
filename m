Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFDC47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17AC217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbfKFJuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:50:52 -0500
Received: from sauhun.de ([88.99.104.3]:50228 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731691AbfKFJul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:50:41 -0500
Received: from localhost (p54B33505.dip0.t-ipconnect.de [84.179.53.5])
        by pokefinder.org (Postfix) with ESMTPSA id 62C1E2C054E;
        Wed,  6 Nov 2019 10:50:40 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/12] media: v4l2-core: convert to i2c_new_scanned_device
Date:   Wed,  6 Nov 2019 10:50:30 +0100
Message-Id: <20191106095033.25182-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. RFC, please comment and/or ack, but don't apply yet.

 drivers/media/v4l2-core/v4l2-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-i2c.c b/drivers/media/v4l2-core/v4l2-i2c.c
index 5bf99e7c0c09..25ddda3b7ce6 100644
--- a/drivers/media/v4l2-core/v4l2-i2c.c
+++ b/drivers/media/v4l2-core/v4l2-i2c.c
@@ -74,10 +74,10 @@ struct v4l2_subdev
 
 	/* Create the i2c client */
 	if (info->addr == 0 && probe_addrs)
-		client = i2c_new_probed_device(adapter, info, probe_addrs,
-					       NULL);
+		client = i2c_new_scanned_device(adapter, info, probe_addrs,
+					        NULL);
 	else
-		client = i2c_new_device(adapter, info);
+		client = i2c_new_client_device(adapter, info);
 
 	/*
 	 * Note: by loading the module first we are certain that c->driver
@@ -88,7 +88,7 @@ struct v4l2_subdev
 	 * want to use the i2c device, so explicitly loading the module
 	 * is the best alternative.
 	 */
-	if (!client || !client->dev.driver)
+	if (IS_ERR(client) || !client->dev.driver)
 		goto error;
 
 	/* Lock the module so we can safely get the v4l2_subdev pointer */
@@ -110,7 +110,7 @@ struct v4l2_subdev
 	 * If we have a client but no subdev, then something went wrong and
 	 * we must unregister the client.
 	 */
-	if (client && !sd)
+	if (!IS_ERR(client) && !sd)
 		i2c_unregister_device(client);
 	return sd;
 }
-- 
2.20.1

