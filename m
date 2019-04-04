Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B61C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4242183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368755;
	bh=TI+36p123s+UiQlX1xPRxGtzKRGZ3KxJxDmIpery5Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bWZ1PXGvVtmqy1+Wd/v5ibhxNZJlVckE0n+prdazkXQV2o8WJMiMAy8Mza6J3MsFL
	 brdof0cgMcue7toyRh+/rLVtoNejpsEjQY0IyU0Hwwg+4CoXQFqywq2WfnpXU5VJLt
	 D+1nBZHQJ9qp3n6IrUHCVOGI1AP1099XsD4OZifs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfDDJFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732207AbfDDJFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7864A21741;
        Thu,  4 Apr 2019 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368751;
        bh=TI+36p123s+UiQlX1xPRxGtzKRGZ3KxJxDmIpery5Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATD9nvlmJRFWlXzMig8gadQNnm3Rq19DgqtxATVntMOoytvVytOlq/lOHDB22x+1D
         B+mTEGpA+QcP4h6cCvTdOGmL7ZPLdxa1vb6N6KJoTFEE7wTNVTKjAi8NPl9BlZD/eI
         G4jCFdgvUlPsQK4TUTjfQBt34B6DNWHLYquZjgVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 156/187] media: mt9m111: set initial frame size other than 0x0
Date:   Thu,  4 Apr 2019 10:48:13 +0200
Message-Id: <20190404084610.468155599@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 29856308137de1c21eda89411695f4fc6e9780ff ]

This driver sets initial frame width and height to 0x0, which is invalid.
So set it to selection rectangle bounds instead.

This is detected by v4l2-compliance detected.

Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/mt9m111.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index efda1aa95ca0..7a7d3969af20 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -1014,6 +1014,8 @@ static int mt9m111_probe(struct i2c_client *client,
 	mt9m111->rect.top	= MT9M111_MIN_DARK_ROWS;
 	mt9m111->rect.width	= MT9M111_MAX_WIDTH;
 	mt9m111->rect.height	= MT9M111_MAX_HEIGHT;
+	mt9m111->width		= mt9m111->rect.width;
+	mt9m111->height		= mt9m111->rect.height;
 	mt9m111->fmt		= &mt9m111_colour_fmts[0];
 	mt9m111->lastpage	= -1;
 	mutex_init(&mt9m111->power_lock);
-- 
2.19.1



