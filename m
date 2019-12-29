Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15614C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E126E207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641447;
	bh=tIVi2pHfOezUp/y8Sz3RUPHHlYUhRouaMh1e4UmHkB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TER19q+6H1n45rV6H+IRlui/8idksVhmgc59GhqeJzABkFG2Dxk+AquwY+AUxri4O
	 rya4+78Gi7nVKFFUIGLn4AWi1fyfvWP2gHruYsOTDrDe8KRRIshXHoTpUcmTmCXa8v
	 Bq85VVP38knrMR4sjml+bSc6HingfkvLYlaDm5n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfL2RoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbfL2RoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:44:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F3320718;
        Sun, 29 Dec 2019 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641442;
        bh=tIVi2pHfOezUp/y8Sz3RUPHHlYUhRouaMh1e4UmHkB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7Oez4FvdOazaH9C2zKRzHNrnbTP5ZP/ixbrfYGm20ukHukrLiSyDK0bfHfV2m+tO
         xB1w1dR6ugFxyUKxt4EZyxPlvgLdgybBNdkU5sj0ORpSGNtBSmEviCl1t5840mKQSZ
         Vm1NVym6ZJfGdlq+mWvN2kzCFtL4XtS45k867Py0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Tsai <martin.tsai@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/434] drm/amd/display: Handle virtual signal type in disable_link()
Date:   Sun, 29 Dec 2019 18:21:53 +0100
Message-Id: <20191229172705.811086209@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Tsai <martin.tsai@amd.com>

[ Upstream commit 616f5b65f1c02d3d6ae370644670d14c57de2fd8 ]

[Why]
The new implementation changed the behavior to allow process setMode
to DAL when DAL returns empty mode query for unplugged display.
This will trigger additional disable_link().
When unplug HDMI from MST dock, driver will update stream->signal to
"Virtual". disable_link() will call disable_output() if the signal type
is not DP and induce other displays on MST dock show black screen.

[How]
Don't need to process disable_output() if the signal type is virtual.

Signed-off-by: Martin Tsai <martin.tsai@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ca20b150afcc..de1b61595ffb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2169,8 +2169,10 @@ static void disable_link(struct dc_link *link, enum signal_type signal)
 			dp_set_fec_ready(link, false);
 		}
 #endif
-	} else
-		link->link_enc->funcs->disable_output(link->link_enc, signal);
+	} else {
+		if (signal != SIGNAL_TYPE_VIRTUAL)
+			link->link_enc->funcs->disable_output(link->link_enc, signal);
+	}
 
 	if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 		/* MST disable link only when no stream use the link */
-- 
2.20.1



