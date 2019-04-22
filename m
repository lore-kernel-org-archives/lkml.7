Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963350;
	bh=xfNqrguB6GXBrK5MUUyIFj8Yp9Dc8/qkxB2w907HwFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZsqlvs+eEYeifJx93H1rTfKLB/g0Fufm+iIKXnZtDNgCSq4pGP9f7B8ZwyGSGAAG
	 seIOAvTvQkkdWQYbIge+ul+m+hiNZ5Ujb0mmvISQeveggQL4/2y3n4Xb3cIK9DgpjI
	 8Ucvj+95h060tOZ0GlXAkM10KPt3DOUb80tDLUT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfDVUC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbfDVTql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA40218B0;
        Mon, 22 Apr 2019 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962400;
        bh=xfNqrguB6GXBrK5MUUyIFj8Yp9Dc8/qkxB2w907HwFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6Cse7DiwNPtc37kvRzLTp/Nt0terCqTiQRbD8OgcSy8Bc3s2DJO0QLKMCbIhDdK1
         jTCneDnnrkqa3CVCtGGlmrYUz+n6PNnEtzcr+Y7/npxd+X+2UeATGUTyexdxSvw8Qw
         NLrZx2uuYj1UwldJJ5EO7SuHQR+p9CWPBoXBXesQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 38/68] drm/tegra: hub: Fix dereference before check
Date:   Mon, 22 Apr 2019 15:44:46 -0400
Message-Id: <20190422194516.11634-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 7cf77b273a8fc51e7de622fa6691abd4436a9a6b ]

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/hub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 8f4fcbb515fb..bb97cad1eb69 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -378,14 +378,16 @@ static int tegra_shared_plane_atomic_check(struct drm_plane *plane,
 static void tegra_shared_plane_atomic_disable(struct drm_plane *plane,
 					      struct drm_plane_state *old_state)
 {
-	struct tegra_dc *dc = to_tegra_dc(old_state->crtc);
 	struct tegra_plane *p = to_tegra_plane(plane);
+	struct tegra_dc *dc;
 	u32 value;
 
 	/* rien ne va plus */
 	if (!old_state || !old_state->crtc)
 		return;
 
+	dc = to_tegra_dc(old_state->crtc);
+
 	/*
 	 * XXX Legacy helpers seem to sometimes call ->atomic_disable() even
 	 * on planes that are already disabled. Make sure we fallback to the
-- 
2.19.1

