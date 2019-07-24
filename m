Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9BAC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64372206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999493;
	bh=hGM5dwc1nx3svMCBmeXexp4BS03qmOeo5AiQFguF6+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMDO99i1AE9h38Lxhw74bgn6ZMV4N+I6qLapEHJ/E3BOWhgwo0+YR2fbZdOJLLvYq
	 smUJ8YXehS5aLmD66mJVQ52o+RpRht7ktoljxBMg6jE/eLyHytN90ztu88y0aY9+GP
	 Y5umCATcPeSiuEtuNCNSPRTj+vQUTnVzftyURqDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392892AbfGXUSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403764AbfGXTte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:49:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5853A20659;
        Wed, 24 Jul 2019 19:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997773;
        bh=hGM5dwc1nx3svMCBmeXexp4BS03qmOeo5AiQFguF6+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drge6BOzEv/l/7BbzEjC7EhL0zWfIGD1pL1U70ABB2Ireq+aYFDiX9s1A5mNx0gbO
         388+SaBrFde1KxQnv66fO0aCrwuPdjdBNSbX95OPLX/yLaldPzhz6BjcrOrTXz7Pgq
         AZhk57Od9PUNIe4GvJXlpyCa73hfV79PS93JecL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 138/371] media: vimc: cap: check v4l2_fill_pixfmt return value
Date:   Wed, 24 Jul 2019 21:18:10 +0200
Message-Id: <20190724191735.339416272@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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
index ea869631a3f6..bbc16072ec16 100644
--- a/drivers/media/platform/vimc/vimc-capture.c
+++ b/drivers/media/platform/vimc/vimc-capture.c
@@ -130,12 +130,15 @@ static int vimc_cap_s_fmt_vid_cap(struct file *file, void *priv,
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



