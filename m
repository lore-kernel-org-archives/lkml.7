Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE6FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0AA206DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 14:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GDM9D4o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgACOYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 09:24:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgACOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 09:24:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so42626056wru.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 06:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYev97gpHrXWD4cTObTlC4p8ry7Fm20e+8qBStccKgE=;
        b=GDM9D4o4PbDunO0UiTZRzvlOWD8xXQPVcNj72ji4rteRTGok3nKJKbt3APJknXNL2m
         kItNJhDkEISEfBHdY++LrlV+Q35N48uncWIJojH3E0jHflyPkNZwZBa8UUvoeyb8had3
         CVvJ9VVo0rDFV51OEgw17ggM6MKd82yo3/yppUIc3aV8VHVUujl+KjjKV15sSrLxfI4X
         sWB9RZreKdK5kHVPM85DzyMnZY/8nfykKq5IMwt3S938Me1qYgq5GGqCcKB5cPxPI4ch
         KNmKBpQkFBysoJAs4Gwf/Q/wUFpXJEvOSmnMpJH56DpZoKXfEFipPrVWvrIxscH2/e20
         LPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYev97gpHrXWD4cTObTlC4p8ry7Fm20e+8qBStccKgE=;
        b=nGLR9L10w7Gv1rssISsP85+RQtYTo1w6A0b4yqbXKwSr6/CmawR8mym3yv1EdIY0aY
         UDi49mDPNOgVx+H7rlvFTmtlUUF5uK2z05S1AJlR8LfPPrOL8/maPP9o3CCA+WqFK5x/
         w4QRSxbT3IT341MZecDdh3BrOUmknKsAuNC5KRb6BIP8HkXigNiUwiY84TJs6H2sMgyJ
         6m6zjnfEPM70WQlKtlbzUL67Ep+dzT+6wv+5Y3y6xi6PwhOrVOnu5ilvrVUEP/KTPBz/
         YkT/yg71Tt7CVXnkDDCE3W3u9ZwyGbzAFMnIa4Y2xpXhhYtCCTCLcFX8Os8SXEcHHc0H
         daMA==
X-Gm-Message-State: APjAAAXumqQQ4xxG6OZMB54rB038s2w+V5DTlBQmLbr4ouguc+KDomaW
        C397eIU6MFNqCYv+7PcdUHY/4g==
X-Google-Smtp-Source: APXvYqxL3jhMkdKPNrLu2LvJpgrGgBdIz4w8yC2ATLMVXINdK6pccS5GSmwMvcuQFyuqoCukv5pzAw==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr91343474wrs.213.1578061488663;
        Fri, 03 Jan 2020 06:24:48 -0800 (PST)
Received: from radium.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x132sm10311612wmg.0.2020.01.03.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 06:24:47 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] drm/mediatek: fix indentation
Date:   Fri,  3 Jan 2020 15:24:45 +0100
Message-Id: <20200103142445.55036-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.25.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation in the Makefile by replacing spaces with tabs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 8067a4be8311..b2b523913164 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 mediatek-drm-hdmi-objs := mtk_cec.o \
 			  mtk_hdmi.o \
 			  mtk_hdmi_ddc.o \
-                          mtk_mt2701_hdmi_phy.o \
+			  mtk_mt2701_hdmi_phy.o \
 			  mtk_mt8173_hdmi_phy.o \
 			  mtk_hdmi_phy.o
 
-- 
2.25.0.rc0

