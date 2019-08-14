Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DD2214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2Wq7/qU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfHNKqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:46:09 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50764 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfHNKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:46:07 -0400
Received: by mail-vk1-f201.google.com with SMTP id s80so5417439vkb.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ip9lF/U/ATkDBCN52xa8MDYElKkFg+n6UubAPvcwdoQ=;
        b=F2Wq7/qUI6063Ggfg3uy2V3WIYVkgW+HoapIrUNMvS/Au5Ol/B3SFcoj9sFM+0KgCc
         gQE4un4mzyXTwEQwzAcnUBqN9C+SR18fqVsQngsR7F4KNXrZvBjhZTdhpkxLn/izafXm
         BhC5HxllnxCQutzM3IO0JMWrPSAIlFmQslLTovcX2NXXe1wqmkL6r6wdgsBlpQILWXHo
         2ViQHXy2254GlWPNkq8h0euVbw3X1Y1tQ8euOn7iCvdz76QpJ24vR+Z94ANGtN9E/uwi
         W3fA0elafMMJGCcfZANHXF+xR8IoeRlkM0tMATTs0LOmj482BenDoUea4hWpgQ9uM/GA
         iH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ip9lF/U/ATkDBCN52xa8MDYElKkFg+n6UubAPvcwdoQ=;
        b=nbZd+vvre/ZMnPFUapBzmk6c1rjpS6/MS9lB0OB+9XCpmbkXbxDpg1ByUXNaj40IId
         SJjJcGZBPbeD2w3JuweRqGFnssPmE7uJ6+Wh+wMkHSpdlDrWVF4ViTOGlDk2Xy3qzHxK
         43vBIAdbyFXZb9FhJtRSp29qiVzDwZEafjVRZPORjAhGVWgLZTWUnHNgNBYKj6mG2ATc
         3T0uIetT33Hg77NDYt6jz8A6zybMIt+ADD6qLCMySHJEYO+XtUTLgCcHIxcW8fDjBTNn
         fz/SMqOYyLYnEn2TS8F0Y8tiPKLLBYd/ETAYka8RHO+5ltZIyLlK6QMwe2UA2cDACkMA
         CaoQ==
X-Gm-Message-State: APjAAAVv3H3K4ZUEH69+FQ69g3ZyIFPSBg8NQH3wOZRuxum+wvV2SHx5
        MWavf8yfTO5lOp3kxQX5/C3w2JYxnMU=
X-Google-Smtp-Source: APXvYqwGg7hw59XwQ3AoqIYTskYl0MYRgXJ3/2BQi9vOdN3sJqPR7IXY8Z+n4jhAc2KsrudW5ux/QIYpifE=
X-Received: by 2002:a9f:31cb:: with SMTP id w11mr1312328uad.40.1565779566021;
 Wed, 14 Aug 2019 03:46:06 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:45:04 +0200
In-Reply-To: <20190814104520.6001-1-darekm@google.com>
Message-Id: <20190814104520.6001-7-darekm@google.com>
Mime-Version: 1.0
References: <20190814104520.6001-1-darekm@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v7 6/9] drm: sti: use cec_notifier_conn_(un)register
From:   Dariusz Marcinkiewicz <darekm@google.com>
To:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     Dariusz Marcinkiewicz <darekm@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new cec_notifier_conn_(un)register() functions to
(un)register the notifier for the HDMI connector, and fill
in the cec_connector_info.

Changes since v2:
	Don't invalidate physical address before unregistering the
	notifier.

Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 9862c322f0c4a..bd15902b825ad 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1256,6 +1256,7 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	struct drm_encoder *encoder;
 	struct sti_hdmi_connector *connector;
+	struct cec_connector_info conn_info;
 	struct drm_connector *drm_connector;
 	struct drm_bridge *bridge;
 	int err;
@@ -1318,6 +1319,14 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 		goto err_sysfs;
 	}
 
+	cec_fill_conn_info_from_drm(&conn_info, drm_connector);
+	hdmi->notifier = cec_notifier_conn_register(&hdmi->dev, NULL,
+						    &conn_info);
+	if (!hdmi->notifier) {
+		hdmi->drm_connector = NULL;
+		return -ENOMEM;
+	}
+
 	/* Enable default interrupts */
 	hdmi_write(hdmi, HDMI_DEFAULT_INT, HDMI_INT_EN);
 
@@ -1331,6 +1340,9 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 static void sti_hdmi_unbind(struct device *dev,
 		struct device *master, void *data)
 {
+	struct sti_hdmi *hdmi = dev_get_drvdata(dev);
+
+	cec_notifier_conn_unregister(hdmi->notifier);
 }
 
 static const struct component_ops sti_hdmi_ops = {
@@ -1436,10 +1448,6 @@ static int sti_hdmi_probe(struct platform_device *pdev)
 		goto release_adapter;
 	}
 
-	hdmi->notifier = cec_notifier_get(&pdev->dev);
-	if (!hdmi->notifier)
-		goto release_adapter;
-
 	hdmi->reset = devm_reset_control_get(dev, "hdmi");
 	/* Take hdmi out of reset */
 	if (!IS_ERR(hdmi->reset))
@@ -1459,14 +1467,11 @@ static int sti_hdmi_remove(struct platform_device *pdev)
 {
 	struct sti_hdmi *hdmi = dev_get_drvdata(&pdev->dev);
 
-	cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID);
-
 	i2c_put_adapter(hdmi->ddc_adapt);
 	if (hdmi->audio_pdev)
 		platform_device_unregister(hdmi->audio_pdev);
 	component_del(&pdev->dev, &sti_hdmi_ops);
 
-	cec_notifier_put(hdmi->notifier);
 	return 0;
 }
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

