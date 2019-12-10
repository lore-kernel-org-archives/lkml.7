Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C76B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012841;
	bh=aoGwtzeudb6z/V4Ipb9WWzgYaui7dppJKVndwpmTc8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F94ri+7iK3EB1OeWP8Nd5jKqwh36UH16bOd7Gf6DWRHcLy5TfUEUayqYVCTCa4+g6
	 6OaJGncxuQ0BlXD+99pMtDc0UcrHFN/NXwJi3EcpwBu4pb/5glV/3Sn3LMgW1HUKDq
	 Az1kJciM2vL8RxRHNjqXCUgfb1W0k6oGPoVI6uL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfLJVUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbfLJVME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:12:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B162246AA;
        Tue, 10 Dec 2019 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012324;
        bh=aoGwtzeudb6z/V4Ipb9WWzgYaui7dppJKVndwpmTc8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiRA0dx0Ao71Mv7+KEO8fso+6QPqOl0Ip7ZV2PXDTwRao6EMnJXeNOOZF8QOC5VBp
         tWwbI+GK/9cnKApLyTzhRKJX5DhT1zh1mREPJZlKftI/UXUUJNFJCZHAgyMf5J+uXo
         0yiWLdfe2/OsZDm0Ry5+6PBAAl7cpqbXErfFrE5Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 257/350] media: si470x-i2c: add missed operations in remove
Date:   Tue, 10 Dec 2019 16:06:02 -0500
Message-Id: <20191210210735.9077-218-sashal@kernel.org>
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

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 2df200ab234a86836a8879a05a8007d6b884eb14 ]

The driver misses calling v4l2_ctrl_handler_free and
v4l2_device_unregister in remove like what is done in probe failure.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/radio/si470x/radio-si470x-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index 7541698a0be11..f491420d7b538 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -482,6 +482,8 @@ static int si470x_i2c_remove(struct i2c_client *client)
 	if (radio->gpio_reset)
 		gpiod_set_value(radio->gpio_reset, 0);
 
+	v4l2_ctrl_handler_free(&radio->hdl);
+	v4l2_device_unregister(&radio->v4l2_dev);
 	return 0;
 }
 
-- 
2.20.1

