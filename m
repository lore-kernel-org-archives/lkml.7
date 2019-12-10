Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605FF2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017607;
	bh=Sk1k1orUaMqbGnLm5dbkcNZRPwqQ4lz1wzAXISBDG/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NfY9ss9OAlyeC88WbihxB6P89G72S/r0hBClmkchfGqwazSL6xE7+ZNQh/zh+U6ri
	 ADeJUnyIwK62GjhsftPHpMwyKYRtDKPZCeiuErjKA5v9wRN9AUak7yi11S67nuT1yJ
	 zttWljQcvuNt35iGG19KsDFaZ0YAT2fGupVcMvf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfLJWcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbfLJWby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209ED21D7D;
        Tue, 10 Dec 2019 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017113;
        bh=Sk1k1orUaMqbGnLm5dbkcNZRPwqQ4lz1wzAXISBDG/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPzwxT9pKvhz7KKmVq2AJm+Zd20Wo8ey8umZKpAwc1yObbVobzPRovvICsg7FFrBS
         xE4uO2JNFj8XnV5+It0ZB+U7w1Cvx0NDJd/C6R9Yy1FjTiezV3TXmk6F6QNm8zOccs
         2V+WpChiRgnYCBz59zuY5pAHRBR58+9lY7do7y7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 66/91] media: si470x-i2c: add missed operations in remove
Date:   Tue, 10 Dec 2019 17:30:10 -0500
Message-Id: <20191210223035.14270-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
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
index f218886c504d9..fb69534a8b56f 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -460,6 +460,8 @@ static int si470x_i2c_remove(struct i2c_client *client)
 	video_unregister_device(&radio->videodev);
 	kfree(radio);
 
+	v4l2_ctrl_handler_free(&radio->hdl);
+	v4l2_device_unregister(&radio->v4l2_dev);
 	return 0;
 }
 
-- 
2.20.1

