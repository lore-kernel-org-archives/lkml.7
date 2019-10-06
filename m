Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5EECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46BF21835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570382786;
	bh=6ns37Ob8BZRTnowWqkz997jdBf9E9CsNqMDuyBEwcRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vj3Gos0p15lLgmLQML6GVSu4KsoYkAlrLi9g4NyJv6ebdoAwB8EK1U2hA14KqqZfE
	 NwuPQ4CH8q6LHGNtDFKs92ZAZIlO+PaRkBaZWHwRr7sehe5+AF3hFlMXxQOELnCndp
	 YR1rr+a7oqsQWLx/ik8QnIkmecZseaiCYXfbe1w0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfJFR00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfJFR0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:26:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A70D2080F;
        Sun,  6 Oct 2019 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382783;
        bh=6ns37Ob8BZRTnowWqkz997jdBf9E9CsNqMDuyBEwcRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4z/OxHEPO69EjKe4s+35K9431zLSYEP8M5DN+ULJyAwJ8yRWPNXxhY4dM+FyOuZq
         oVwnhX5SuRZndVDztSSZenekjAw/FU3Xt+CvPQiZleN2Ob1ZsfxCCUlF88zlT7E1mM
         bHsZROBEqttg+fpajDmI3Oy0WPCmDpK2CMDeVk7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 05/68] drm/panel: simple: fix AUO g185han01 horizontal blanking
Date:   Sun,  6 Oct 2019 19:20:41 +0200
Message-Id: <20191006171111.113263768@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7a0fd4e4e78d5..c1daed3fe8428 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -614,9 +614,9 @@ static const struct panel_desc auo_g133han01 = {
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



