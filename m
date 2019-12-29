Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BCD206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642865;
	bh=BBoAcQiPnZHiPXh303IzugW4Wqb3de3x7BIvASrqW4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BKYHXObtIYEWnUkVfDZl0Eu+z1LtwZf9XPQqKnSReTj5FFKv9I3ecRIGFpngdj/t
	 V1ykDxQDwdngVhoJVxdSP3UUIxlu4u+5eEQXglZQZkGqq8CI1QQNCRlBATz0ReXg9N
	 +jmEg7X1PaHCVUUkE9+jRD+AgiFnYUMimbAZ9rxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfL2SHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:07:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbfL2RsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:48:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50DA206A4;
        Sun, 29 Dec 2019 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641682;
        bh=BBoAcQiPnZHiPXh303IzugW4Wqb3de3x7BIvASrqW4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8hJdNUf2GprTG3PSGXvqTefenQlK6cJycMd1VQ2BGIrR8PcZPq49qP2G5D9VBzkB
         q0eD4taJPF7uEZ/i4SIfi81yvzazQBUQhtNUUEOwY4C873lG5UAZLndS/o4dcRxzq9
         27EQaj+px7MLGPd6tk0dJ5zjnw1613Xz6GkY+x+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 167/434] drm/gma500: fix memory disclosures due to uninitialized bytes
Date:   Sun, 29 Dec 2019 18:23:40 +0100
Message-Id: <20191229172712.895672993@linuxfoundation.org>
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

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit ec3b7b6eb8c90b52f61adff11b6db7a8db34de19 ]

"clock" may be copied to "best_clock". Initializing best_clock
is not sufficient. The fix initializes clock as well to avoid
memory disclosures and informaiton leaks.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20191018044150.1899-1-kjlu@umn.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 167c10767dd4..900e5499249d 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -129,6 +129,7 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
 	s32 freq_error, min_error = 100000;
 
 	memset(best_clock, 0, sizeof(*best_clock));
+	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.n = limit->n.min; clock.n <= limit->n.max;
@@ -185,6 +186,7 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
 	int err = target;
 
 	memset(best_clock, 0, sizeof(*best_clock));
+	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.p1 = limit->p1.min; clock.p1 <= limit->p1.max;
-- 
2.20.1



