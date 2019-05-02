Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F25C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BE820449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810836;
	bh=ZnbOD2K9O2375a4FDRGPeFIFshZDPFGH+/6kgXnTawY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yV/MytZLZVTJ9u+favE3xiRMItSfEHHAPGLnTn0xm48khkiZLPhdOvyxpPMc0QSIt
	 7zdWYscB8ilfz6hdApU/kiFj/LZQERQqZ9pDxuXcYTRvJhjUdvKhafV+cPBQEnQgE2
	 Nq52IovJjVlEb4v6axiejYOW4OjUI7QPoMyfX61Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfEBP1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfEBP1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:27:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776ED20675;
        Thu,  2 May 2019 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810830;
        bh=ZnbOD2K9O2375a4FDRGPeFIFshZDPFGH+/6kgXnTawY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c31FlmT0g+oFyRJPiVQPPyt5lTrSsdsYT2B2B+aXnVa94UZX6I3iUvQ96zgEZZH4V
         qS5ZJWIF/r/DlYdV6eSNjnD3Naas67mbFshp/C79ye8fpkiWTLS3PmabTsM0rVNnMR
         Tn+IyW/A0ktW3l1jVIODDQEFvHuXYb7fSTzodAYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <treding@nvidia.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 44/72] drm/tegra: hub: Fix dereference before check
Date:   Thu,  2 May 2019 17:21:06 +0200
Message-Id: <20190502143336.984820665@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



