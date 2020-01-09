Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C38CC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2805720673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgAIHfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:35:01 -0500
Received: from mail.manjaro.org ([176.9.38.148]:40564 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgAIHfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:35:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 90B2136E4E25;
        Thu,  9 Jan 2020 08:34:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hxXOWBz9kZNY; Thu,  9 Jan 2020 08:34:56 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 1/1] drm/rockchip: fix integer type used for storing dp data rate
Date:   Thu,  9 Jan 2020 08:31:29 +0100
Message-Id: <20200109073129.378507-2-t.schramm@manjaro.org>
In-Reply-To: <20200109073129.378507-1-t.schramm@manjaro.org>
References: <20200109073129.378507-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commmit 2589c4025f13 ("drm/rockchip: Avoid drm_dp_link helpers") changes
the type of variables used to store the display port data rate and
number of lanes to u8. However u8 is not sufficient to store the link
data rate of the display port.
This commit reverts the type of data rate to unsigned int.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 83c4586665b4..81ac9b658a70 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -95,7 +95,7 @@ struct cdn_dp_device {
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 max_lanes;
-	u8 max_rate;
+	unsigned int max_rate;
 	u8 lanes;
 	int active_port;
 
-- 
2.24.1

