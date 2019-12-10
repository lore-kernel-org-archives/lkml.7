Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45DEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F64A2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017795;
	bh=Jyk/8Z7EqHQ3KcmekHNr/pL8PUHTTZ/qsM16FHYsvX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdzLImZshl37lF1JJtFRRJu2PD8RAIJCmGPcbT4wLgxvMWDfMbodX7j0GfpwmSJIu
	 paYi7rs4M96w6xOm0cUpneVCBg5wgpTKLbgFPSjLd2B/Mt2a0VsgzwACY06Yu9fcWY
	 TCi+pT/NtadpAgLmSGAAMEaPm5VMWjKRAhWW4vgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfLJWnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfLJWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A612077B;
        Tue, 10 Dec 2019 22:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017068;
        bh=Jyk/8Z7EqHQ3KcmekHNr/pL8PUHTTZ/qsM16FHYsvX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtR1XkAq+VVt981oKpgQHUFeJ/WEAFh5J/BcvO5jEkT+WuRiKO0+7LnHgyYgfWjhJ
         xdPokCRxYefBAg6pES9oUSD+06MSFy+UIoxtPTSAHV6A80J27N1pVqeJ+MSbyApT49
         K/Hs9jQQbGsiOOmqrRMjF2EFHA6ZkOnKi3wk+GZY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benoit Parrot <bparrot@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 27/91] media: ti-vpe: vpe: Make sure YUYV is set as default format
Date:   Tue, 10 Dec 2019 17:29:31 -0500
Message-Id: <20191210223035.14270-27-sashal@kernel.org>
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

From: Benoit Parrot <bparrot@ti.com>

[ Upstream commit e20b248051ca0f90d84b4d9378e4780bc31f16c6 ]

v4l2-compliance fails with this message:

   fail: v4l2-test-formats.cpp(672): \
	Video Capture Multiplanar: TRY_FMT(G_FMT) != G_FMT
   fail: v4l2-test-formats.cpp(672): \
	Video Output Multiplanar: TRY_FMT(G_FMT) != G_FMT
	...
   test VIDIOC_TRY_FMT: FAIL

The default pixel format was setup as pointing to a specific offset in
the vpe_formats table assuming it was pointing to the V4L2_PIX_FMT_YUYV
entry. This became false after the addition on the NV21 format (see
above commid-id)

So instead of hard-coding an offset which might change over time we need
to use a lookup helper instead so we know the default will always be what
we intended.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Fixes: 40cc823f7005 ("media: ti-vpe: Add support for NV21 format")
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti-vpe/vpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 067548e14e113..dbb4829acc438 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1998,7 +1998,7 @@ static int vpe_open(struct file *file)
 	v4l2_ctrl_handler_setup(hdl);
 
 	s_q_data = &ctx->q_data[Q_DATA_SRC];
-	s_q_data->fmt = &vpe_formats[2];
+	s_q_data->fmt = __find_format(V4L2_PIX_FMT_YUYV);
 	s_q_data->width = 1920;
 	s_q_data->height = 1080;
 	s_q_data->bytesperline[VPE_LUMA] = (s_q_data->width *
-- 
2.20.1

