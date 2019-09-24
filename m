Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D52C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EADE2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344286;
	bh=71Teq/z3em+Gqxx4C3IM9Ovs6Uia6I4586LFWmnZh5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epam6NhqfrpbDa5nRi3gmHSkq4qwdjJUBkK9tK64aIBpE/ZQs0pjDvkqZEsXnRk37
	 w6jIwBk3E5cVnJVWB65B8cAZQAeOedqPi0ujZKR+/M80/J+U5jj7B3fo4iFK6edqFv
	 4aIBP3BHxciUbeLeCOibYfoSd3JFelK5WXyP/O9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404475AbfIXQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfIXQqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:46:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB86217D9;
        Tue, 24 Sep 2019 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343572;
        bh=71Teq/z3em+Gqxx4C3IM9Ovs6Uia6I4586LFWmnZh5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BtUk10vi9CZwYYELaIeSChEUTJUrzE8zN/H9CkunJkYndFZ8LAsJGR2D3qKt6cQAH
         C8OwREUq1xiodPmNEYS1cM9tMNFUUm0JiJOWCy2F5y6UyRjKDAmcz+OqjcdaXusDhD
         buc+eS1LJuKZS9Yhm0mkvOtSIdsm/i9T+Q4qM1Ws=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 10/70] drm/stm: attach gem fence to atomic state
Date:   Tue, 24 Sep 2019 12:44:49 -0400
Message-Id: <20190924164549.27058-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164549.27058-1-sashal@kernel.org>
References: <20190924164549.27058-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit 8fabc9c3109a71b3577959a05408153ae69ccd8d ]

To properly synchronize with other devices the fence from the GEM
object backing the framebuffer needs to be attached to the atomic
state, so the commit work can wait on fence signaling.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Philippe Cornu <philippe.cornu@st.com>
Tested-by: Philippe Cornu <philippe.cornu@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190712084228.8338-1-l.stach@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/stm/ltdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 32fd6a3b37fb1..6f1fef76671c8 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -25,6 +25,7 @@
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
@@ -875,6 +876,7 @@ static const struct drm_plane_funcs ltdc_plane_funcs = {
 };
 
 static const struct drm_plane_helper_funcs ltdc_plane_helper_funcs = {
+	.prepare_fb = drm_gem_fb_prepare_fb,
 	.atomic_check = ltdc_plane_atomic_check,
 	.atomic_update = ltdc_plane_atomic_update,
 	.atomic_disable = ltdc_plane_atomic_disable,
-- 
2.20.1

