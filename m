Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234302070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121134;
	bh=kmV+YHG6BmNnd6KqVNhoq9PwNagd3wWpcvAWi409cOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1+TkNcJQj+ir3JEM4RdjYmpEzuLW2tdkI81sdLlkP+2oc4Sm3H6mimhvVkIoBq7Fv
	 VtYpp2okfwY7In1nviqdn7GbGYovMGt8jKBVBzdfXWzOi+ygwPI+yiUTSnbsFvNpZo
	 augGUyPxM4BKcbFNzYEMgnygsLAt8LjlKVUZVJM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392814AbfJCQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387508AbfJCQpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:45:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BC620865;
        Thu,  3 Oct 2019 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121124;
        bh=kmV+YHG6BmNnd6KqVNhoq9PwNagd3wWpcvAWi409cOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIpuwphn1edaH05bOtymEME8yUqMmZchkB1Nsaib7Y9/kVmPRPV1yNgJ1deEO1PW5
         28XD+0HGHuSFgRzDyfWOvIL5HnmQD9aMhdPty5VZwRqGyKhBem7ygtLCW9U2+ROs9m
         zGHKuV3eQrVva5pnNfDu1X6No5Yv7o/X0x2z/G+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 163/344] media: aspeed-video: address a protential usage of an unitialized var
Date:   Thu,  3 Oct 2019 17:52:08 +0200
Message-Id: <20191003154556.309327243@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit 31b8b0bd6e55c3ea5a08bb8141fa5d3c90600e3b ]

While this might not occur in practice, if the device is doing
the right thing, it would be teoretically be possible to have
both hsync_counter and vsync_counter negatives.

If this ever happen, ctrl will be undefined, but the driver
will still call:

	aspeed_video_update(video, VE_CTRL, 0, ctrl);

Change the code to prevent this to happen.

This was warned by cppcheck:

	[drivers/media/platform/aspeed-video.c:653]: (error) Uninitialized variable: ctrl

Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/aspeed-video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index f899ac3b4a613..4ef37cfc84467 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -630,7 +630,7 @@ static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
 	}
 
 	if (hsync_counter < 0 || vsync_counter < 0) {
-		u32 ctrl;
+		u32 ctrl = 0;
 
 		if (hsync_counter < 0) {
 			ctrl = VE_CTRL_HSYNC_POL;
@@ -650,7 +650,8 @@ static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
 				V4L2_DV_VSYNC_POS_POL;
 		}
 
-		aspeed_video_update(video, VE_CTRL, 0, ctrl);
+		if (ctrl)
+			aspeed_video_update(video, VE_CTRL, 0, ctrl);
 	}
 }
 
-- 
2.20.1



