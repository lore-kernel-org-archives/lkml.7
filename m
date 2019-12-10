Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07021C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23B72468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012062;
	bh=lrzcBBv1T8ZDRdmi9EcZnZaNQh8XErX7vko9JTYN4F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WWVTNkYPRZ3GB23DAzkRjpPNwoOdwo4U0Jhl9Eduwr8IhCxIbsyYIzxVGbRZnHev5
	 uwiyAuoBpXvT2K7cM5RiX4JVqVypgXNe3yfIzf81WG/138vJ7puXv1iWAtzRrVUwCg
	 PsC9D0Mh+8M/ZZVWGax5KwzhU6DhJMUygJMwdTNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLJVHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:07:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLJVHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:07:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D5E2077B;
        Tue, 10 Dec 2019 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012058;
        bh=lrzcBBv1T8ZDRdmi9EcZnZaNQh8XErX7vko9JTYN4F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mx0g8K2Xtnrgm/8WquHli4exsFTdml6tU8iSA7RiiRYK8Fd/Erh/1tPCkgNYq5A9N
         eoHB3rf4vFFG0+gEuA9so9QcN3Ob1w4/DbJqW74h/uxtJdlb3e1YPCsa3zElBzs/CF
         vf8PZmNJsW/3P5ejB8aiGsehNFj0amQ8wabS5zNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benoit Parrot <bparrot@ti.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 041/350] media: i2c: ov2659: fix s_stream return value
Date:   Tue, 10 Dec 2019 16:02:26 -0500
Message-Id: <20191210210735.9077-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit 85c4043f1d403c222d481dfc91846227d66663fb ]

In ov2659_s_stream() return value for invoked function should be checked
and propagated.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov2659.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index f4ded0669ff9e..70bf63b9dbd04 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1201,11 +1201,15 @@ static int ov2659_s_stream(struct v4l2_subdev *sd, int on)
 		goto unlock;
 	}
 
-	ov2659_set_pixel_clock(ov2659);
-	ov2659_set_frame_size(ov2659);
-	ov2659_set_format(ov2659);
-	ov2659_set_streaming(ov2659, 1);
-	ov2659->streaming = on;
+	ret = ov2659_set_pixel_clock(ov2659);
+	if (!ret)
+		ret = ov2659_set_frame_size(ov2659);
+	if (!ret)
+		ret = ov2659_set_format(ov2659);
+	if (!ret) {
+		ov2659_set_streaming(ov2659, 1);
+		ov2659->streaming = on;
+	}
 
 unlock:
 	mutex_unlock(&ov2659->lock);
-- 
2.20.1

