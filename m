Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC11C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E8A208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329572;
	bh=cTh2JwGulfqwce2QqUga9l8RsKPms7SUf/crGJOOdgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AgWGwZg18Y2DXtrl4U9SoVTYQ6I+D53xZIJyJAM8QHZ2gS+NgwVb1fgh8PHWKfrEi
	 Y7Ssmw3HqsMKadiIU9KtxPgerdGJVsR4uLfIQwKydp7lVurJKnoobZIDrGW6U44PEy
	 wXfZYNqdSeG1BqfUjaPGC4xFVKRAvsQBF/XcNr04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfD0BqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbfD0Bng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255C7216FD;
        Sat, 27 Apr 2019 01:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329415;
        bh=cTh2JwGulfqwce2QqUga9l8RsKPms7SUf/crGJOOdgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBjOwI0zN8PvG4onKhvLlVibXJJLUUifCSqlR430J90Noiidh0aiZ0AaN7jjDhyVg
         DdC3ukYB6DvuJeVoNnHLCGgMOvyu2ol0O6TAKQSlFCxFNEIPyGxPcsrhcjClZOuyYz
         Xx8dvtfBAsYNMpsKvGHWu37Npj2K5JzqJdAJUiR4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        CK Hu <ck.hu@mediatek.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 07/16] drm/mediatek: Fix an error code in mtk_hdmi_dt_parse_pdata()
Date:   Fri, 26 Apr 2019 21:43:15 -0400
Message-Id: <20190427014325.8704-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014325.8704-1-sashal@kernel.org>
References: <20190427014325.8704-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 2d85978341e6a32e7443d9f28639da254d53f400 ]

We don't want to overwrite "ret", it already holds the correct error
code.  The "regmap" variable might be a valid pointer as this point.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 863d030786e5..200f75e1d619 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1473,7 +1473,6 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	if (IS_ERR(regmap))
 		ret = PTR_ERR(regmap);
 	if (ret) {
-		ret = PTR_ERR(regmap);
 		dev_err(dev,
 			"Failed to get system configuration registers: %d\n",
 			ret);
-- 
2.19.1

