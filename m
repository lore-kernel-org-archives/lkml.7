Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1521479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383254;
	bh=71Teq/z3em+Gqxx4C3IM9Ovs6Uia6I4586LFWmnZh5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NALrb5QLtxUwKn4EOxMzFpqYao8rhS7lyoPXP1RxGAxPeeu8u3l3bNb51qaf67Buv
	 tMtrBd+jJ8vjXJ5ibLH0h/A4gmdE+kd3xXa+If7ZYAeGv0qF+iYTFufb1ghDD3v7HR
	 g0ho9fNPPCyCt+QCgJg6HwmGUZwhqliII8+vRUMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfJFReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfJFReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:34:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7DA02080F;
        Sun,  6 Oct 2019 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383249;
        bh=71Teq/z3em+Gqxx4C3IM9Ovs6Uia6I4586LFWmnZh5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcbGaHbK2EPJRvdsCHedNgM2DZWVZHTXZbH7FvbfZ/s5FOq63my48ZP75mSc17mLX
         fpqbpa/IwlWCm3e46Nt2H5FClN7DDJzElAbdoVbD7jQH/j3offF/5F0VxU6NG72Eo1
         gzr2oa2KKwj6IB1qUjqXwBxJ3m/szq9dBOMxEpBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 033/137] drm/stm: attach gem fence to atomic state
Date:   Sun,  6 Oct 2019 19:20:17 +0200
Message-Id: <20191006171211.782273431@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



