Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C92C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3663208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640684;
	bh=iIbgYyeAtn9m4ueo+kqpRMfwoTsJ+Wzgvr5+qD/h8Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IyBwwTUAG6qg+28o3wOJNKZ8wPMsm8rzvucjnD9eYJxrAMp3rtmagoSlWwnhQY3Tw
	 cKt87YnZH3U+ES4Un7n1g9ymM4vE197ErhToPJnEpD0GG5TZWeyPI/532dsU07pqFx
	 9oB1CxpNT2S6uNVOMWzLQBQHWAsc1ikAFguGzMLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfL2RbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:31:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfL2RbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:31:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B65520722;
        Sun, 29 Dec 2019 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640679;
        bh=iIbgYyeAtn9m4ueo+kqpRMfwoTsJ+Wzgvr5+qD/h8Ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msB9iMXGCEl7YjTCsQbaidTtvVgMw9c/4XEE2MK9q20I2oEaYAk7sGoPrj4tfgZPs
         +cx45F4baC8qdzOZDPrFql+nRIjW7yhcDY7bz5car+w1/RVt4Nw5c5wM45BCAsrDpO
         uAIe/E9ubne9tFqR8GcsFeOULTGvceZIWfUuIuno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/219] drm/gma500: fix memory disclosures due to uninitialized bytes
Date:   Sun, 29 Dec 2019 18:18:09 +0100
Message-Id: <20191229162519.136037105@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
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
index 1b7fd6a9d8a5..f73a02a2a5b3 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -139,6 +139,7 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
 	s32 freq_error, min_error = 100000;
 
 	memset(best_clock, 0, sizeof(*best_clock));
+	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.n = limit->n.min; clock.n <= limit->n.max;
@@ -195,6 +196,7 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
 	int err = target;
 
 	memset(best_clock, 0, sizeof(*best_clock));
+	memset(&clock, 0, sizeof(clock));
 
 	for (clock.m = limit->m.min; clock.m <= limit->m.max; clock.m++) {
 		for (clock.p1 = limit->p1.min; clock.p1 <= limit->p1.max;
-- 
2.20.1



