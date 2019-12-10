Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B27C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25EB2465C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576011903;
	bh=OnbJqA0+frurLx+b+snX4US2vZhw+RxCrJhg7CIcF2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kzlcGfk/dI2ua0wj/2wJlhxlJ7ki8+iR8T1DiGaHb+Cyt/Ip/LgsxztsiFrKz0P+b
	 OkcPI78zp80L9jQazVB3PEd+Y/RbPnAocQgzNM0gd4EkKEki0NyYAaNsDP9j7iZp1v
	 +rcmBrB5X5KKdXdypx+pa45mlVNnrb4SnE5QbMYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLJVEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfLJVEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29532468A;
        Tue, 10 Dec 2019 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011884;
        bh=OnbJqA0+frurLx+b+snX4US2vZhw+RxCrJhg7CIcF2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGH0r0roU+BMV17w7ah5yIiDmRVV9xNK+w4oijGgHq7Y8mHrArMTa/0Lhu8jmBS7q
         SGewc1MyO3+uEK3fxY+IZT427yjDOW4lOTB9a792FrytVhe6FcKPJQNK4WiK1lDnwh
         0GgLWl9kNpuFudWxd8M9lx2tenggMJskmi8Y43qs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 035/350] media: cedrus: fill in bus_info for media device
Date:   Tue, 10 Dec 2019 15:58:47 -0500
Message-Id: <20191210210402.8367-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit ae0688f659adb17ae6ae5710c886b20b5406e5c4 ]

Fixes this compliance warning:

$ v4l2-compliance -m0
v4l2-compliance SHA: b514d615166bdc0901a4c71261b87db31e89f464, 32 bits

Compliance test for cedrus device /dev/media0:

Media Driver Info:
        Driver name      : cedrus
        Model            : cedrus
        Serial           :
        Bus info         :
        Media version    : 5.3.0
        Hardware revision: 0x00000000 (0)
        Driver version   : 5.3.0

Required ioctls:
                warn: v4l2-test-media.cpp(51): empty bus_info
        test MEDIA_IOC_DEVICE_INFO: OK

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 2d3ea8b74dfdc..3439f6ad63380 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -357,6 +357,8 @@ static int cedrus_probe(struct platform_device *pdev)
 
 	dev->mdev.dev = &pdev->dev;
 	strscpy(dev->mdev.model, CEDRUS_NAME, sizeof(dev->mdev.model));
+	strscpy(dev->mdev.bus_info, "platform:" CEDRUS_NAME,
+		sizeof(dev->mdev.bus_info));
 
 	media_device_init(&dev->mdev);
 	dev->mdev.ops = &cedrus_m2m_media_ops;
-- 
2.20.1

