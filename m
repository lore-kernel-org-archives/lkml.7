Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B326EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCFA206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207298;
	bh=gKDtgsP03yEY7PO5Q/wXskrMtPKLZoMPHgd1k6wtyLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWWWPhUXksQSqfyD1a0PRZ3iL2FpvIlGBIf6sCZ4lZWNhr4ydJ9KJPE0DEo19WLyi
	 +zytcIS0AcGan9udrduJq6lyM7MySFb50WmoZ39l7R3xFopu83TQIoWtkZez/YQ+u9
	 /q5ZW4ZBSN2lV2b4L+CFMZ9wyBfUZl4YH+chQuJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfEGFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfEGFez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:34:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A5F20989;
        Tue,  7 May 2019 05:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207294;
        bh=gKDtgsP03yEY7PO5Q/wXskrMtPKLZoMPHgd1k6wtyLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7APWV2VOW3VA3osh7Jxs5T8Q3qxJlol48EKo4vtKAFVXjfKQdqQdjPNpjIeoEGsx
         N6KBrItpAtSTW/1RZR5rCyqJUH9gTXphX+yS0BGsLLvd0z2MwkEnvh8jwGXAJ9qf2M
         mF4Uxc5R58jSPKm7dB27hga6jPudWtJA0i18bi/E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 69/99] drm/sun4i: Set device driver data at bind time for use in unbind
Date:   Tue,  7 May 2019 01:32:03 -0400
Message-Id: <20190507053235.29900-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit 02b92adbe33e6dbd15dc6e32540b22f47c4ff0a2 ]

Our sun4i_drv_unbind gets the drm device using dev_get_drvdata.
However, that driver data is never set in sun4i_drv_bind.

Set it there to avoid getting a NULL pointer at unbind time.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190418132727.5128-3-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9e4c375ccc96..c6b65a969979 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -85,6 +85,8 @@ static int sun4i_drv_bind(struct device *dev)
 		ret = -ENOMEM;
 		goto free_drm;
 	}
+
+	dev_set_drvdata(dev, drm);
 	drm->dev_private = drv;
 	INIT_LIST_HEAD(&drv->frontend_list);
 	INIT_LIST_HEAD(&drv->engine_list);
-- 
2.20.1

