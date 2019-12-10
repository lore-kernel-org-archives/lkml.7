Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D3BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427272053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017729;
	bh=gYXfXuxRY9mg/QgwO8RreWgUOh9JEFtJ4kuEz0sHxng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuOzxGprRhAIdP6nhlWP07C7aEAv0mP/8H7RFRJ2E/uM/sfuO81V05qxCZ6JMfud7
	 XKtwFwV78RyIVHe1cmgMoOg1oSi4Mn3kMDYt4S+JpADMyysyQb6SVyA4pX1e/WZbrO
	 vRGOe1SW0HZYzETfc5nR07Xqxa3aYEV4teQuTCs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfLJWbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:31:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfLJWbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:31:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A9C2077B;
        Tue, 10 Dec 2019 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017081;
        bh=gYXfXuxRY9mg/QgwO8RreWgUOh9JEFtJ4kuEz0sHxng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghNbuEkXpFmnCRa3WVCFk/sB8bZjR3OY+Gfrw8TKyF/CtnLCN7hAROClrM/VX7nrn
         LfvcRyMwmRAMF5ZghzCyFJGtCH64bwz4/r5KS4BJIgI4R27GFYLpazKesjBVcf2W9Y
         YyZWyw4XkB9aVpQQdLsuENT2OUxlAom2fIHcK5jY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 38/91] drm/gma500: fix memory disclosures due to uninitialized bytes
Date:   Tue, 10 Dec 2019 17:29:42 -0500
Message-Id: <20191210223035.14270-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index da9fd34b95505..caa6da02206aa 100644
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

