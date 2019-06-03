Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C23C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0753D27B84
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 04:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQSvUzIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFCEeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 00:34:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34317 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfFCEd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:33:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so4277798pgg.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pFTY68CYf0vqkaIF9RkUPvim3fj+DjvxB3baTxp4Mk=;
        b=RQSvUzIgUKgIsNlQFm+7zwJeVC5MSGMQ7g3/DtHR16ldFiUtk0+JARXtgZwEjl9tbN
         9hWW1p5DfY6fy/aBLs4Yymn5h3QUKDGbkoEPEt1I/+q7XpVzAK46qrqE/1RGqPuPtlv2
         oTdErhd/k+QH1OsnOMAFqzaVQi6I8u9i9UvY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pFTY68CYf0vqkaIF9RkUPvim3fj+DjvxB3baTxp4Mk=;
        b=ar8hn8kQkFqGHhqNpxQE5xzOLAzS6k8OYoBUecu1H+kx+eWUmA1uKSqNmllaCIKMUN
         LO7D0NbctoIRv++y7eUVZ58h2ytlFmssQLMOkOpGjYYKgqFbz22Xm8gWRx5/aVBMQ83K
         uER+EX/VaRo1UnvV91UdGUHUdzwAvak75gYwyLGWqsaq15AtT4U3qOH40IX/MtFlHwhD
         W29lZHQFJZB8rg36TG+xE2Ai0Q8xOPMfkY0GXr48EO82EI2bxU3uN2TeKBGx3SBo8KM6
         hKpxAK9X3XSGU89xhnFL9abNawXqGfiX0k7XQq/x/fERIFKPMiHuYAoi+28AHn6Fqv+u
         szfw==
X-Gm-Message-State: APjAAAWUuUkzv3enJoMdRyOkAUXqJnY1rU9q8BMVPXyT/LBQrvc/t0Zw
        m7ZUcR0sN3L1hSzp9jYJ2esJUd0/Tog=
X-Google-Smtp-Source: APXvYqzy0pOcm1foPAUC6fqZXlzM7mUcjUylak9ZglBCN1Q2GIU98tYWPiPis4kHfvZEn5RQOneLLw==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr27194254pjk.89.1559536438112;
        Sun, 02 Jun 2019 21:33:58 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id j23sm13509733pff.90.2019.06.02.21.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 21:33:57 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-media@vger.kernel.org, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 5/7] ASoC: rockchip: rockchip-max98090: Add node for HDMI
Date:   Mon,  3 Jun 2019 12:32:49 +0800
Message-Id: <20190603043251.226549-6-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190603043251.226549-1-cychiang@chromium.org>
References: <20190603043251.226549-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let user specify HDMI node so machine driver can use it to let codec
driver register callback on correct hdmi-notifier.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Documentation/devicetree/bindings/sound/rockchip-max98090.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
index a805aa99ad75..dae57c14864e 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
@@ -7,6 +7,7 @@ Required properties:
   connected to the CODEC
 - rockchip,audio-codec: The phandle of the MAX98090 audio codec
 - rockchip,headset-codec: The phandle of Ext chip for jack detection
+- rockchip,hdmi: The phandle of HDMI node for HDMI jack detection
 
 Example:
 
@@ -16,4 +17,5 @@ sound {
 	rockchip,i2s-controller = <&i2s>;
 	rockchip,audio-codec = <&max98090>;
 	rockchip,headset-codec = <&headsetcodec>;
+	rockchip,hdmi= <&hdmi>;
 };
-- 
2.22.0.rc1.257.g3120a18244-goog

