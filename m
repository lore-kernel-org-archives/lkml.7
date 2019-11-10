Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F095022794
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354302;
	bh=p/RmlmT67lAOqkWvbQoRuTpPBUPePImcyuLhOl2dT7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eCD2bwZrBCUlHWzHZBF0DX/z15ED9CjPaClAKh/ZlAgqhV9ec9OlRKFCCqTfvXp9h
	 +1QRdk/YwD//oFiryoqcBcHtv4qByewItMLv9YcN9xTLmRgnha7NAxMSWAj5SfoNMx
	 JumVR+aOjWv4RCEPymLH3aLthaB6nOGY92AN2Yvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfKJCvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfKJCvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:51:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52585227C3;
        Sun, 10 Nov 2019 02:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354283;
        bh=p/RmlmT67lAOqkWvbQoRuTpPBUPePImcyuLhOl2dT7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrR6MvKv43u1p10I2UZcKBMJXCNLprXiegfieOb6rFK5HHF1S0RiJA9kK2lquqzIP
         YYdS4gCIDO5635ONfHupdbtj+Zk5alER1WuoySC3XiktewXAikpV03U2YUpyuOkdzS
         iPRuap8ttcDyWtvNMy8SyzUro1rI4EvoCQAUBTw8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.4 25/40] media: davinci: Fix implicit enum conversion warning
Date:   Sat,  9 Nov 2019 21:50:17 -0500
Message-Id: <20191110025032.827-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 4158757395b300b6eb308fc20b96d1d231484413 ]

Clang warns when one enumerated type is implicitly converted to another.

drivers/media/platform/davinci/vpbe_display.c:524:24: warning: implicit
conversion from enumeration type 'enum osd_v_exp_ratio' to different
enumeration type 'enum osd_h_exp_ratio' [-Wenum-conversion]
                        layer_info->h_exp = V_EXP_6_OVER_5;
                                          ~ ^~~~~~~~~~~~~~
1 warning generated.

This appears to be a copy and paste error judging from the couple of
lines directly above this statement and the way that height is handled
in the if block above this one.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpbe_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index 6d91422c4e4c7..a9cd8c7a7b347 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -520,7 +520,7 @@ vpbe_disp_calculate_scale_factor(struct vpbe_display *disp_dev,
 		else if (v_scale == 4)
 			layer_info->v_zoom = ZOOM_X4;
 		if (v_exp)
-			layer_info->h_exp = V_EXP_6_OVER_5;
+			layer_info->v_exp = V_EXP_6_OVER_5;
 	} else {
 		/* no scaling, only cropping. Set display area to crop area */
 		cfg->ysize = expected_ysize;
-- 
2.20.1

