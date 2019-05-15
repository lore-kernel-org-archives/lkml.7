Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83674C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55697206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919175;
	bh=rM3Wb2qCqHGGq8V5wW4paFWyDqiCvYc1efac+ZgWVqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17cUg3WcXbSpCzGejGojt9oVrLl1nf37wObDm5q0DgvGxDiCjRj98/whXi9DRj6gj
	 E8QGAvkvumRr0A8+L3U/hzZbbH+scRZy13d+DcseZIhxVXCgr3OILVdLrC4b9Th0OI
	 SjfHToC6sdXcxPypKW8l40cvpbOVBVSBlxgS2qKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfEOLTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730572AbfEOLTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:19:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28EB0206BF;
        Wed, 15 May 2019 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919169;
        bh=rM3Wb2qCqHGGq8V5wW4paFWyDqiCvYc1efac+ZgWVqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMnfXsQFjGdoir38Ku4KLQhGQ1tqzLljIUC+AOhAe7FeTlShUvMXuq66qY0NJZnTQ
         0U+HFpt4C3AcFL0gyKC4/CTjw94DPHzn6D5ExFMQdid70BLxNSyPzZKxrH1ee4cCH0
         R/ehY+dNmhLqHNAK7ViCTK/MXsvHYFQZQJJx0n2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 056/115] media: ov5640: fix auto controls values when switching to manual mode
Date:   Wed, 15 May 2019 12:55:36 +0200
Message-Id: <20190515090703.664617652@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a8f438c684eaa4cbe6c98828eb996d5ec53e24fb ]

When switching from auto to manual mode, V4L2 core is calling
g_volatile_ctrl() in manual mode in order to get the manual initial value.
Remove the manual mode check/return to not break this behaviour.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Tested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/ov5640.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 0366c8dc6ecf7..acf5c8a55bbd2 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1900,16 +1900,12 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_AUTOGAIN:
-		if (!ctrl->val)
-			return 0;
 		val = ov5640_get_gain(sensor);
 		if (val < 0)
 			return val;
 		sensor->ctrls.gain->val = val;
 		break;
 	case V4L2_CID_EXPOSURE_AUTO:
-		if (ctrl->val == V4L2_EXPOSURE_MANUAL)
-			return 0;
 		val = ov5640_get_exposure(sensor);
 		if (val < 0)
 			return val;
-- 
2.20.1



