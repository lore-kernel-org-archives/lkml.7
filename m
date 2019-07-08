Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D10C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37350204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599601;
	bh=IOJigquZYqTOVBc2a1Km/+TbA60nJuBD4nps1zfUfvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAslGj8l3Vu67okxNnbGBjNQrJMQm9+VgbERgJf2iOP48DjWmCtANWVZtreCcxWZ+
	 HY0qziht713tl3D3Gshr5IIiG1SYNX1ykf2iGmwBE1o03n7Svjpdq+j6KtkEiRdp6t
	 KEmA5XoplAraX9SbywjEyXO4stSjljmJ1LMpKH0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfGHP0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388866AbfGHP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:26:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728F421707;
        Mon,  8 Jul 2019 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599596;
        bh=IOJigquZYqTOVBc2a1Km/+TbA60nJuBD4nps1zfUfvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+nSyKxUXRfSL0Z4+dIv4dzRrdJCmeAdYTkp3whLd4GYUlwnPSb7va9vwj9C+n68y
         JJiAFvzLQZf6ZnfmFQmTthNyY7UWlypr5p/fSn9LeMykdQENXuyG4gjVFH8HV7HFE9
         xlPx3Ymk46y7RhvIry6xdCxVbOCoPTtz9FoNl7PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/90] drm/mediatek: fix unbind functions
Date:   Mon,  8 Jul 2019 17:12:40 +0200
Message-Id: <20190708150523.266519638@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8fd7a37b191f93737f6280a9b5de65f98acc12c9 ]

detatch panel in mtk_dsi_destroy_conn_enc(), since .bind will try to
attach it again.

Fixes: 2e54c14e310f ("drm/mediatek: Add DSI sub driver")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 66df1b177959..84bb66866631 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -841,6 +841,8 @@ static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi)
 	/* Skip connector cleanup if creation was delegated to the bridge */
 	if (dsi->conn.dev)
 		drm_connector_cleanup(&dsi->conn);
+	if (dsi->panel)
+		drm_panel_detach(dsi->panel);
 }
 
 static void mtk_dsi_ddp_start(struct mtk_ddp_comp *comp)
-- 
2.20.1



