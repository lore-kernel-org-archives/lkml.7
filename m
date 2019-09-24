Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F4C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FC121971
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343742;
	bh=TivASpM3/86zANGlVZN2Uu3v/DewE3+KHlZDVvnmyWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lDd+ZyscuDlNvcyUHh0hrq9JMpab85Tticmcz0h2mfu6Mnbjkh0oCLJUOIaR4GnLg
	 sY7kyoKCl4qWbv8yJhYG2BhKBpl3f3PED1VQzsfkMGD5AhVqEMl6NDi3X5NUH3nVBH
	 Lj5xFdVr/kYSsCpzl6a4LK/Mj+m/DluqgluC+3lI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410196AbfIXQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392951AbfIXQsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:48:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BC7222C1;
        Tue, 24 Sep 2019 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343734;
        bh=TivASpM3/86zANGlVZN2Uu3v/DewE3+KHlZDVvnmyWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KpFCRjdfG4wLwOYUarWR+sOoFZkWMiRqsw/Q9KMfOfovDKyBnQWyX5UIRpHvwyW78
         2gxrEeyoKmFAFxNjuDqba15r1UC9GJgg1fTNLMQphIIfDhL+3cyfDBrCR0Tro2s85U
         ptgNAhXfbViVjZ6/i8gOFL2vcJwCWHQD7VT3J2+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 04/50] drm/panel: simple: fix AUO g185han01 horizontal blanking
Date:   Tue, 24 Sep 2019 12:48:01 -0400
Message-Id: <20190924164847.27780-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit f8c6bfc612b56f02e1b8fae699dff12738aaf889 ]

The horizontal blanking periods are too short, as the values are
specified for a single LVDS channel. Since this panel is dual LVDS
they need to be doubled. With this change the panel reaches its
nominal vrefresh rate of 60Fps, instead of the 64Fps with the
current wrong blanking.

Philipp Zabel added:
The datasheet specifies 960 active clocks + 40/128/160 clocks blanking
on each of the two LVDS channels (min/typical/max), so doubled this is
now correct.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/1562764060.23869.12.camel@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5fd94e2060297..654fea2b43124 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -689,9 +689,9 @@ static const struct panel_desc auo_g133han01 = {
 static const struct display_timing auo_g185han01_timings = {
 	.pixelclock = { 120000000, 144000000, 175000000 },
 	.hactive = { 1920, 1920, 1920 },
-	.hfront_porch = { 18, 60, 74 },
-	.hback_porch = { 12, 44, 54 },
-	.hsync_len = { 10, 24, 32 },
+	.hfront_porch = { 36, 120, 148 },
+	.hback_porch = { 24, 88, 108 },
+	.hsync_len = { 20, 48, 64 },
 	.vactive = { 1080, 1080, 1080 },
 	.vfront_porch = { 6, 10, 40 },
 	.vback_porch = { 2, 5, 20 },
-- 
2.20.1

