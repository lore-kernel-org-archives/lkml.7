Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55EFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68749204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963736;
	bh=YGxkt0rV6dMxKx3IUMwxgVKjZMOjYt5Py07gE+y8MC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGqBjcEc3e+uZfSpn1nBroXuvuxdbqUnw8vf1MGgI/z8Ai2MorGJsZaGuzsJnR5wy
	 OsOXnhdPv+YcMYesC/C517g0ys94PcxSvLkmqFa8jigwO4+h2MID5asSo+NiSWXR9a
	 6S3XWnU+6X+GE+khQl61b0hqkr5i1czHKm2hadP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfDVUIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:08:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbfDVTns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB1F21905;
        Mon, 22 Apr 2019 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962228;
        bh=YGxkt0rV6dMxKx3IUMwxgVKjZMOjYt5Py07gE+y8MC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKmkVnfVes2gwHqihfBnfx/fTGo1uhfe6bc2gsz5t4c87Fm8dIEqOFMCJ0XQnuHee
         KFjcF3M5myE7G2GV0lR2qY10k0TS2em8fznVIoQaFW2HJL3c4qcyuZnTxLLTdRhKSW
         FbefW0bRzgySH0dj1d7jLZ9E/vhu3JGyeKgs+Upc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 49/98] drm/tegra: hub: Fix dereference before check
Date:   Mon, 22 Apr 2019 15:41:16 -0400
Message-Id: <20190422194205.10404-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
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
index 922a48d5a483..c7c612579270 100644
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

