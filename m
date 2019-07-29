Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF93C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032B2205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431310;
	bh=v6739TFzCD0dCWBYvQaUHrFGQhMc3tYKA8SZNCnX6Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1YC+xtRsHu2MOjqKk9ckLtek3YnUNb/QMrR5vEe0DH2PPmgvIEIw202VFfdn8SJTm
	 +O9s5bIkoNcYLvT2MriWnnu3imE9wsNLA0MO7SVeaCf/plicDS2JI5OcGjzcnZKVZ1
	 yDrSt79SINOJ/3FtwmpBvfAnlVZuXcaKd8SNF3/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfG2T1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729850AbfG2T06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:26:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E8421655;
        Mon, 29 Jul 2019 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428417;
        bh=v6739TFzCD0dCWBYvQaUHrFGQhMc3tYKA8SZNCnX6Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufImxB2RGPrzcpEgqlLYfRHyECCRd0A0NljkmByI2yG6H5vboGoBrmhssBYHg0Xd/
         Lqpa7UPgxpGOgXOExcotV9aN3fN2eiKkpCff2LaAC+B1hL2OwODvYkAW4CBmf0+4DT
         8EPoPYMLlpcP3B8yU7r9WB8MaSTCJBP4Azivmwd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 070/293] media: vimc: cap: check v4l2_fill_pixfmt return value
Date:   Mon, 29 Jul 2019 21:19:21 +0200
Message-Id: <20190729190830.038735151@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 77ae46e11df5c96bb4582633851f838f5d954df4 ]

v4l2_fill_pixfmt() returns -EINVAL if the pixelformat used as parameter is
invalid or if the user is trying to use a multiplanar format with the
singleplanar API. Currently, the vimc_cap_try_fmt_vid_cap() returns such
value, but vimc_cap_s_fmt_vid_cap() is ignoring it. Fix that and returns
an error value if vimc_cap_try_fmt_vid_cap() has failed.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Suggested-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vimc/vimc-capture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vimc/vimc-capture.c b/drivers/media/platform/vimc/vimc-capture.c
index a078ad18909a..091921ed09dd 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -131,12 +131,15 @@ static int vimc_cap_s_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
 	struct vimc_cap_device *vcap = video_drvdata(file);
+	int ret;
 
 	/* Do not change the format while stream is on */
 	if (vb2_is_busy(&vcap->queue))
 		return -EBUSY;
 
-	vimc_cap_try_fmt_vid_cap(file, priv, f);
+	ret = vimc_cap_try_fmt_vid_cap(file, priv, f);
+	if (ret)
+		return ret;
 
 	dev_dbg(vcap->dev, "%s: format update: "
 		"old:%dx%d (0x%x, %d, %d, %d, %d) "
-- 
2.20.1



