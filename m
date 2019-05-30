Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C3BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEBC24FF1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189007;
	bh=yrcTPUnbn2kN1pX3seegK0EaYW5Bd5gzW9TAm7gkSCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wDJmXKvKnMVTUpTnB0IuxF0d6M5VSkhhswFWQvsx/eb44+K0RCAvJAHXKq97t3MGT
	 KefU6BF4fHrdpe2fm/U2vZJtpgbihAFP2M1Lvumitz98zmfKDHXa6y6E2gL9UCuEJc
	 vrSqeGo+0vnqdRLQ4z6uCkvHEnPyIrpDLffAo8x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfE3EDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbfE3DR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:17:57 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C272E24747;
        Thu, 30 May 2019 03:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186276;
        bh=yrcTPUnbn2kN1pX3seegK0EaYW5Bd5gzW9TAm7gkSCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/J6J0+MnunfmxA7H/woN05Ik4oRkgosb/gKfcxuWFVbrNYtE9ttrIiOkzg4PNCEV
         zvixV2eUK/OsBal52t8WfaaVLoEzOUYJah+bd+jh0t/qI/WTOTh6lkx6WqvYMozIPh
         dF45V9clacucJvUCtMiDTsAKimR+iO0V5Eza/54Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 220/276] media: video-mux: fix null pointer dereferences
Date:   Wed, 29 May 2019 20:06:18 -0700
Message-Id: <20190530030538.876996420@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aeb0d0f581e2079868e64a2e5ee346d340376eae ]

devm_kcalloc may fail and return a null pointer. The fix returns
-ENOMEM upon failures to avoid null pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/video-mux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index c01e1592ad0a8..c8ffe7bff77f1 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -365,9 +365,14 @@ static int video_mux_probe(struct platform_device *pdev)
 	vmux->active = -1;
 	vmux->pads = devm_kcalloc(dev, num_pads, sizeof(*vmux->pads),
 				  GFP_KERNEL);
+	if (!vmux->pads)
+		return -ENOMEM;
+
 	vmux->format_mbus = devm_kcalloc(dev, num_pads,
 					 sizeof(*vmux->format_mbus),
 					 GFP_KERNEL);
+	if (!vmux->format_mbus)
+		return -ENOMEM;
 
 	for (i = 0; i < num_pads; i++) {
 		vmux->pads[i].flags = (i < num_pads - 1) ? MEDIA_PAD_FL_SINK
-- 
2.20.1



