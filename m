Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35243CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D8920659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571924919;
	bh=RQMzVNw4kzFN6wUn6kLrrGE7G+986jjD0QQVGYy78Bk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hKoCFx2vf08nzgvLkqvc/Dywp+lLTsdI+/QtZnlgbcegBqDHEa03R0IJODyyghlxq
	 noyJHlBr1q6bWimJKSXv+5B6K2L7k3KXWIEz5DkiaKM2pLrWhe9/qtqmcTiOrhkjAg
	 ltZxqnZX13e9eBj1OaD7g0Bvm/URlKqDo+xGtVCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502008AbfJXNsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:48:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45875 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbfJXNsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:48:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id v8so18626013lfa.12;
        Thu, 24 Oct 2019 06:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eh3QeCRU+KbLxpJwL2S7uImfmKPlDkY/EBxciS/9vrY=;
        b=VpbZ19QjrvdBp+Yp9H58aK9ZIlx0JFpcl15OdjIFnRPII+GxZwvuippqg4mUgTqKZM
         lZJHTCmC04JPSP8pd/b6tO5EIaCZ3fSunswB7ZwXhyS2DbULmd9PHsdJyi7muqkfadHh
         Naiu2nZlUJVuj1btOvZebSkJS12fRBvO1Dp2UvGaKmGhoCPT5k37TVzOxBkQtFxVadtB
         p4EmetHtomv/7d3hhVCJ2t1ZtikElKN9UGmL20kCbZXRrigdyRkUxh1je/r3Fh9dxAL+
         avZ8vSmxm4jDrIZ6BCRniEa6PlszP76M95v+e9VklbUJ6uQ72Elxa+13WItDkY3oZi7Y
         oCbQ==
X-Gm-Message-State: APjAAAVRzTjT6wOqTZ0hekgSbPuznkhNvC11FZ5Q5tsCjl9PEYDMsEvC
        aWCfx2hHU6A+ynuvOSfYS1s=
X-Google-Smtp-Source: APXvYqxrb3tBc+jJCOQUd4Kwz9IyKrxbM/t0vGxQuf45osYcRN06U8doVPUfI30LiERriv5ZqHFlhg==
X-Received: by 2002:a19:7b16:: with SMTP id w22mr10635721lfc.114.1571924915467;
        Thu, 24 Oct 2019 06:48:35 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id j7sm11907086lfc.16.2019.10.24.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:48:34 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH] imx214: Remove redundant code
Date:   Thu, 24 Oct 2019 15:48:32 +0200
Message-Id: <20191024134832.14061-1-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pad is now checked by v4l2_subdev_call_wappers

call_g_frame_interval-> check_frame_interval-> check_pad

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
---
 drivers/media/i2c/imx214.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index adcaaa8c86d1..4175d06ffd47 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -803,7 +803,6 @@ static int imx214_s_stream(struct v4l2_subdev *subdev, int enable)
 static int imx214_g_frame_interval(struct v4l2_subdev *subdev,
 				   struct v4l2_subdev_frame_interval *fival)
 {
-	fival->pad = 0;
 	fival->interval.numerator = 1;
 	fival->interval.denominator = IMX214_FPS;
 
-- 
2.23.0

