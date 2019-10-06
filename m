Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1117C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048D20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382400;
	bh=wykaysPxuwQ0fYQrbjSrqse1BzOP7BsJuJ3GBhpQirg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bFPwgh4tVZ7YmzOThSyh0wWmT7OmDxKwRj2BgupgnTNi/SfDBHsFn9LWIMKrodh3b
	 zRjqcTj4d29Ed2qn6Bk7felWSruW1kBzE96lcTnwj4CG7IrUxRAw26MPkj8dQmpead
	 wvqQl4Pws31YiViB8fr5YaTWmH71qG8i6LxG3ehQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfJFRUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfJFRT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:19:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D671620835;
        Sun,  6 Oct 2019 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382395;
        bh=wykaysPxuwQ0fYQrbjSrqse1BzOP7BsJuJ3GBhpQirg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uuc91WT2SeBN/1o6T5MV4cIqCKmcW8ggSdS9/s5thyv1IHW7nd3JbgbEHHBxQef94
         URvbxmTu9nN8dythrDZ1uCIdbHi9zPYu8R/fun4JjNnuku60CWrx6V6IPjcgPUcJpg
         ZiqYaTGL66CTjTbYfzN4PPPBvTaxt2KoRlI7HsXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 02/36] gpu: drm: radeon: Fix a possible null-pointer dereference in radeon_connector_set_property()
Date:   Sun,  6 Oct 2019 19:18:44 +0200
Message-Id: <20191006171041.813628230@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171038.266461022@linuxfoundation.org>
References: <20191006171038.266461022@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit f3eb9b8f67bc28783eddc142ad805ebdc53d6339 ]

In radeon_connector_set_property(), there is an if statement on line 743
to check whether connector->encoder is NULL:
    if (connector->encoder)

When connector->encoder is NULL, it is used on line 755:
    if (connector->encoder->crtc)

Thus, a possible null-pointer dereference may occur.

To fix this bug, connector->encoder is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index c6bf378534f83..bebcef2ce6b88 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -758,7 +758,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
 
 		radeon_encoder->output_csc = val;
 
-		if (connector->encoder->crtc) {
+		if (connector->encoder && connector->encoder->crtc) {
 			struct drm_crtc *crtc  = connector->encoder->crtc;
 			const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
 			struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
-- 
2.20.1



