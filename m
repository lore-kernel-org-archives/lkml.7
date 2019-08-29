Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CEFC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A472080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CH3Z10dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfH2UAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:00:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfH2UAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:00:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so2132929pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S9d3dFoh7F6gGH5LTQyJ8UyxGo/MvVuvj+hyEE/NkTM=;
        b=CH3Z10dMKFNa5EUmXWfmO9kVZYBLmTzxs99xBrQZa34CnaWlLZ/e/TJGcWMmfgsVB6
         fbGWYVF61zStU3OZ3c4J09h572gEWcekJS9a9s1STntCydJRS4S+bJjKr1GFFPevhKjB
         uZXZuULcjvP9TNWnWZ5gUtJuhXkCpGo5Q1FylX1MGpXn4QIk5JEjXSX1Q1MWBWAsfSZh
         Y3XGxXaszNMDvWfih8zVS5X6l5P1jhp0JnKuzXXsLsas1cnOI0l6wWvsEjPjBR0TMyLp
         ZP5J3Hy4nDNsUH7UsCts6P9CduZTxfhth9z6VwRWe6YZX49SH0wun0MhB+e7V7D2e2kT
         LlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S9d3dFoh7F6gGH5LTQyJ8UyxGo/MvVuvj+hyEE/NkTM=;
        b=I4XLV+WJ0bbNnNvRLsHPtmESOTsG2/setGe0saP7cwBq29ie4N8CGP6mzeAdAKstQ3
         RrRWIVtSzi5/NsRrfp09r3Jg18Zvm3c1u7Ib6VHLwZ+IQtBCGyd6VpOpw61DP/XrZrGG
         REN6jQ2HMo0867XAo4sJMX5o1gGMVpMsCSMf2a+PTAaKPgkW+K4jkYnLsl80/4euQPeM
         DGsPsAu2/2ZuKfCzYTzkUl/kYLalL0ncgvyiD+KdcIP//5L1VStjFGbpfjL/u8+B4B8p
         U/r35xCeE1LiPlb2O0soXeHIeMP+wpNNqcoelFmp3xC8UaNjfdTRSvSr2FHTyPYKV1F5
         RgRg==
X-Gm-Message-State: APjAAAVUk1bTlcmmu8W7O3umjKOfnPoKXBtmfygCM8u18DdC+XuWhDOE
        XRId+G1auUxxYNSMEUaMTNnkrg==
X-Google-Smtp-Source: APXvYqwgfpvBc6rpBf/WbtITtoaWYyjizOJiXzMZpQhfc76Y+pvPxSdoJdzus+CAnHFnfaEjre9aBw==
X-Received: by 2002:a63:5951:: with SMTP id j17mr9734953pgm.143.1567108805398;
        Thu, 29 Aug 2019 13:00:05 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u7sm3053766pgr.94.2019.08.29.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:00:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie, jsarha@ti.com,
        tomi.valkeinen@ti.com, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [BACKPORT 4.19.y 1/3] drm/bridge: tfp410: fix memleak in get_modes()
Date:   Thu, 29 Aug 2019 13:59:59 -0600
Message-Id: <20190829200001.17092-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190829200001.17092-1-mathieu.poirier@linaro.org>
References: <20190829200001.17092-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

commit c08f99c39083ab55a9c93b3e93cef48711294dad upstream

We don't free the edid blob allocated by the call to drm_get_edid(),
causing a memleak. Fix this by calling kfree(edid) at the end of the
get_modes().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190610135739.6077-1-tomi.valkeinen@ti.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index c3e32138c6bb..9dc109df0808 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -64,7 +64,12 @@ static int tfp410_get_modes(struct drm_connector *connector)
 
 	drm_connector_update_edid_property(connector, edid);
 
-	return drm_add_edid_modes(connector, edid);
+	ret = drm_add_edid_modes(connector, edid);
+
+	kfree(edid);
+
+	return ret;
+
 fallback:
 	/* No EDID, fallback on the XGA standard modes */
 	ret = drm_add_modes_noedid(connector, 1920, 1200);
-- 
2.17.1

