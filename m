Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D35C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE77D217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429051;
	bh=HDtr9Pswu4IuOYjYw5mYDl+rU29gSip/6fkssNdw3ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=knoY5MMWRf6uGaoZVv5/kPP7iKZ8c9Yc8al1y264+k86S9W4BrNqOdIJD5j4fb7L/
	 Z3KtyllhD8rSuxSGhcQzPZJ2EWn7oiPtegmypBW7TK27CXGdQVuENFAZb0UARkG9MG
	 v829VgfdBBy2kkW+FFH1w6K9bSIYyyiDEOBNljhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbfG2Tha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388711AbfG2Th2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:37:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E15217D4;
        Mon, 29 Jul 2019 19:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429046;
        bh=HDtr9Pswu4IuOYjYw5mYDl+rU29gSip/6fkssNdw3ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJoKi8uHqun/LzcbiF4gRcXTMJrgDI7DrF4VVS/1H7YDonSdNLU1eB1QIMWvt5G/b
         cMGObzid3rUPxL6y7BaXv2tk5B1Xhr8TdXCRWiq72/8mft+YXHLcIWYPnios3ESp5C
         mS0meTeTMc0iASNyD/80eYIi5jo2MwiCRr1O6Hhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 230/293] drm/bridge: sii902x: pixel clock unit is 10kHz instead of 1kHz
Date:   Mon, 29 Jul 2019 21:22:01 +0200
Message-Id: <20190729190842.100590728@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8dbfc5b65023b67397aca28e8adb25c819f6398c ]

The pixel clock unit in the first two registers (0x00 and 0x01) of
sii9022 is 10kHz, not 1kHz as in struct drm_display_mode. Division by
10 fixes the issue.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1a2a8eae0b9d6333e7a5841026bf7fd65c9ccd09.1558964241.git.jsarha@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 60373d7eb220..109ab4c3df50 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -261,10 +261,11 @@ static void sii902x_bridge_mode_set(struct drm_bridge *bridge,
 	struct regmap *regmap = sii902x->regmap;
 	u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
 	struct hdmi_avi_infoframe frame;
+	u16 pixel_clock_10kHz = adj->clock / 10;
 	int ret;
 
-	buf[0] = adj->clock;
-	buf[1] = adj->clock >> 8;
+	buf[0] = pixel_clock_10kHz & 0xff;
+	buf[1] = pixel_clock_10kHz >> 8;
 	buf[2] = adj->vrefresh;
 	buf[3] = 0x00;
 	buf[4] = adj->hdisplay;
-- 
2.20.1



