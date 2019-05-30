Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F3C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79E258F3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191146;
	bh=DSfh4Z3jAfAWQeCZK9hL19SXw1Ifa5HJzz56/y1/7K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5wnIP2dmFkGxvWMDDqnb5WVZd3QXe2JUimJJuIQ/ZfwyZyQSrquYxxJtcOhwaQVZ
	 NyLKJ+bDP2q6hePo7+LctEmMa2x8pq+t/iltsDR3isaAmB8xxKcDrBrzYGz0oUJBni
	 71KKwTdh6I0Py7xPb7g7nKPeTsTOXv/dppQilb3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfE3EjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbfE3DMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:41 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DA121BE2;
        Thu, 30 May 2019 03:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185960;
        bh=DSfh4Z3jAfAWQeCZK9hL19SXw1Ifa5HJzz56/y1/7K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AwL7R1jYqdFPtIowEHeWeO6TJXS4aMc+//edvcE9G869kJsNX0W19y6gZFgbHgBd6
         y3m8nEA+WSewJzzEULh+5P5yrdE+LPfUBf4xPu4UcvHzp3LKujsuK+DO+trRd6jG1g
         trdopTKwlQ8sWE0gZYhWlxoApJIm7hiIsLoQ0w+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 336/405] media: ov7670: restore default settings after power-up
Date:   Wed, 29 May 2019 20:05:34 -0700
Message-Id: <20190530030557.709730400@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 32ab688b280301f7cee9e547564cb74e33e06322 ]

Since commit 3d6a8fe25605 ("media: ov7670: hook s_power onto v4l2 core"),
the device is actually powered off while the video stream is stopped.

The frame format and framerate are restored right after power-up, but
restoring the default register settings is forgotten.

Fixes: 3d6a8fe25605 ("media: ov7670: hook s_power onto v4l2 core")

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov7670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index a7d26b294eb58..e65693c2aad5f 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -1664,6 +1664,7 @@ static int ov7670_s_power(struct v4l2_subdev *sd, int on)
 
 	if (on) {
 		ov7670_power_on (sd);
+		ov7670_init(sd, 0);
 		ov7670_apply_fmt(sd);
 		ov7675_apply_framerate(sd);
 		v4l2_ctrl_handler_setup(&info->hdl);
-- 
2.20.1



