Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E2CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8387E205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208973;
	bh=f0NDxdzF8Nmbe1Jkcm6mj+05ckxOunGYb1y/ulIrGn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dG70mjRaVLTn+7yPeRQ0sx0wGZzXptbgeF65Pv/T9+fnCdcG6h6nTmy9xmc8PJPZX
	 rv0tsD5WMGG0z8BNlHBtjRB5xgui+MEgXx4+fqlbSxnuEAsx90OLfOx7xlqx2uMBZ4
	 u3qbGasU0CZwAXdfDwdiIgQBPa03nwa4ylIDhokA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfEGGCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfEGFfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:35:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC3320C01;
        Tue,  7 May 2019 05:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207324;
        bh=f0NDxdzF8Nmbe1Jkcm6mj+05ckxOunGYb1y/ulIrGn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZjohjuyLsLSlpJen/9gn05TfYwrJPFiHaDT665xtdMt+Tm4yD/nho6PPpgxS1FXo
         a+8qNQD+OBKmFpFMhtVm0AqoxOZkltalXCMg3wIUJnvzPFljtH27F0hjqy7E0MXMK4
         UKQ0naunr1hEp5U+jTlz6xYWcF2KhSMXjRDcogBw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 87/99] drm/sun4i: Unbind components before releasing DRM and memory
Date:   Tue,  7 May 2019 01:32:21 -0400
Message-Id: <20190507053235.29900-87-sashal@kernel.org>
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

[ Upstream commit e02bc29b2cfa7806830d6da8b2322cddd67e8dfe ]

Our components may still be using the DRM device driver (if only to
access our driver's private data), so make sure to unbind them before
the final drm_dev_put.

Also release our reserved memory after component unbind instead of
before to match reverse creation order.

Fixes: f5a9ed867c83 ("drm/sun4i: Fix component unbinding and component master deletion")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190424090413.6918-1-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9a5713fa03b2..f8bf5bbec2df 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -146,10 +146,11 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	drm_mode_config_cleanup(drm);
-	of_reserved_mem_device_release(dev);
-	drm_dev_put(drm);
 
 	component_unbind_all(dev, NULL);
+	of_reserved_mem_device_release(dev);
+
+	drm_dev_put(drm);
 }
 
 static const struct component_master_ops sun4i_drv_master_ops = {
-- 
2.20.1

