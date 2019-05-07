Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23202C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D40205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208666;
	bh=gOlTQy3cU0afo36bvjvo/17E1PvEHAhf3sh7wya5gHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qmelmnD18q1yXwdVpfEINhOanjDpppawoUTuk7gTdPXG7GDND0qUZZjUPxeTuc2dL
	 BbutZug/lyoyT57H3cyAmGDT2Kggwuvj5asBNIj9GsNeqUkIGQ9wsaVBwPMQAxLNmC
	 ppElRjVaGF+Na2+c8aMxOO/7Lpf7Z0lHllABbl70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfEGF5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfEGFhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:37:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386EA20675;
        Tue,  7 May 2019 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207453;
        bh=gOlTQy3cU0afo36bvjvo/17E1PvEHAhf3sh7wya5gHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+Ol4hTsB0u/f7irvuTi1MGgUCW5GPTpL0PDDPxgT5nU3vr4Jz7KN9IAmAR9Dnk64
         SEA53KrHqe1m09D4GXxfIvlYWE6KvM+ZitiRsxufPhRs6Rrl+aHHAUX+STiI0vU1Lv
         10trzROAWZcMCLQNYnT+ZNMtpMrzfZgKb3g7e0ZY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 50/81] drm/sun4i: Fix component unbinding and component master deletion
Date:   Tue,  7 May 2019 01:35:21 -0400
Message-Id: <20190507053554.30848-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

[ Upstream commit f5a9ed867c83875546c9aadd4ed8e785e9adcc3c ]

For our component-backed driver to be properly removed, we need to
delete the component master in sun4i_drv_remove and make sure to call
component_unbind_all in the master's unbind so that all components are
unbound when the master is.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190418132727.5128-4-paul.kocialkowski@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 7cac01c72c02..62703630090a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -160,6 +160,8 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	of_reserved_mem_device_release(dev);
 	drm_dev_put(drm);
+
+	component_unbind_all(dev, NULL);
 }
 
 static const struct component_master_ops sun4i_drv_master_ops = {
@@ -407,6 +409,8 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 
 static int sun4i_drv_remove(struct platform_device *pdev)
 {
+	component_master_del(&pdev->dev, &sun4i_drv_master_ops);
+
 	return 0;
 }
 
-- 
2.20.1

