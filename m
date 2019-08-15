Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8141FC32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562D9216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="GNUjU00q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfHOAtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:49:22 -0400
Received: from onstation.org ([52.200.56.107]:44380 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfHOAtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:49:15 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1D6D03EA1D;
        Thu, 15 Aug 2019 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1565830154;
        bh=vvUbQvnJ/4OGyTU3jR+k5h+lF40i8YqgCaHr7dOl1Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNUjU00qmOaQpH/H6nGA9HmdDwtETr0KGIReNXp+26ch2MMd1z4kyfQvyaMbZt+HT
         xecw9TYCY+UOayRIlV9u0VzL3URggiPjeSxlavZeF0NQM+UJ3yXYsIJO+ZD9DOLJ5d
         AYCIS3i/+uvfkd3WekVOviCLXubzK8/+7Khmrp0Y=
From:   Brian Masney <masneyb@onstation.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com, robdclark@gmail.com,
        sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, linus.walleij@linaro.org,
        enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 05/11] drm/bridge: analogix-anx78xx: correct value of TX_P0
Date:   Wed, 14 Aug 2019 20:48:48 -0400
Message-Id: <20190815004854.19860-6-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815004854.19860-1-masneyb@onstation.org>
References: <20190815004854.19860-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to configure this driver on a Nexus 5 phone (msm8974),
setting up the dummy i2c bus for TX_P0 would fail due to an -EBUSY
error. The downstream MSM kernel sources [1] shows that the proper value
for TX_P0 is 0x78, not 0x70, so correct the value to allow device
probing to succeed.

[1] https://github.com/AICP/kernel_lge_hammerhead/blob/n7.1/drivers/video/slimport/slimport_tx_reg.h

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h b/drivers/gpu/drm/bridge/analogix-anx78xx.h
index 25e063bcecbc..bc511fc605c9 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.h
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.h
@@ -6,7 +6,7 @@
 #ifndef __ANX78xx_H
 #define __ANX78xx_H
 
-#define TX_P0				0x70
+#define TX_P0				0x78
 #define TX_P1				0x7a
 #define TX_P2				0x72
 
-- 
2.21.0

