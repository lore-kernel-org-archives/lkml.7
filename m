Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31FDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A42820726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 05:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAsl82Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLCFXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 00:23:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39518 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLCFXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:23:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so1119055pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 21:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jCnbshc6gwC9Lz7KrpZNRQtAnW1kUNCWIyQg9GLVi8g=;
        b=OAsl82OzpSmTAhx0IKBHZKzsbwj/Z21pQqt+a4HJyo/HZFuWYG9T4G04aGZRPpDabt
         +EEHPB/YWvTT1xhURL6ea6bIVo+plxAXVlqEIbZR06NB9Sh2Wq9iHh9wwy3WlzDu+HTw
         uFjhM186omJhFZh1qp3s9THXC88LAjvd7sLJd4FM4Em2wk/cI/SNy0/OyPbVGovb4Q69
         GJEWRkCGmkBjBwaoIDjgfYabTSvOlon7UJgG4w9P5zJVxHSdgpBOicTCBHw2ZvQPh4M2
         bsPl8engt05uk4jXYpdp992AtjFowJHclWUqfPjTgcuzgsI2DEJPaghc7lXxnn+s0Qvw
         e2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jCnbshc6gwC9Lz7KrpZNRQtAnW1kUNCWIyQg9GLVi8g=;
        b=Kd5GdiEUCb7saxzYW1acOdpFw+JOHvDWum0Jt3XDlaV+rKfl0Y/gFUz59gIJXPE2DN
         Dxl31WQnc2EZAjiXdXhMbmL6d0kx0G5ohg/TrjdEw9vg1Wna/hDWnguA6Hen6Fx0ShlU
         pdFNYEI1IAYZU4gWedxuiAoRss1Chs+K2RpXw3PKOn+qpy9IJdSDkzoRtNZRPV2t0kjk
         O6lKSEEl3anOwHKzNYVTRul59F+qIo73AcFtt0VkT+M5htlFavw88vkJcAkfxCWljGWh
         lcbCNR/VV75EE4E4988BA1s4YIG20U7QzW5kqJktmyQ1r54xYhZNXo5FCp5oZ2SdTnka
         nuTQ==
X-Gm-Message-State: APjAAAWDYmaxihAcJV/Rppia+rha3BbGlAvc22a9pLYf914AtnR1YDEP
        kqZXMlQi6FQqnvBmof0k26vZzDSPuHo8Dw==
X-Google-Smtp-Source: APXvYqw8o/ivZvCeU5FcoWoVFv5gCQhQQbbWRwtLMDtOtVpHS+BJUEGR4dGGFMZkC5woDR2/luVSEg==
X-Received: by 2002:a63:6787:: with SMTP id b129mr3465932pgc.103.1575350627967;
        Mon, 02 Dec 2019 21:23:47 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id z30sm1426685pff.131.2019.12.02.21.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:47 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 3/9] drivers: thermal: tsens: use simpler variables
Date:   Tue,  3 Dec 2019 10:53:24 +0530
Message-Id: <ff9298c401dd95e6c7590a7c882ca61cfbb15e16.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1575349416.git.amit.kucheria@linaro.org>
References: <cover.1575349416.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already dereference the sensor and save it into a variable. Use the
variable directly to make the code easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c2df30a08b9e4..1cbc5a6e5b4fd 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -368,7 +368,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 			tsens_set_interrupt(priv, hw_id, UPPER, disable);
 			if (d.up_thresh > temp) {
 				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
-					priv->sensor[i].hw_id, __func__);
+					hw_id, __func__);
 				tsens_set_interrupt(priv, hw_id, UPPER, enable);
 			} else {
 				trigger = true;
@@ -379,7 +379,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 			tsens_set_interrupt(priv, hw_id, LOWER, disable);
 			if (d.low_thresh < temp) {
 				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
-					priv->sensor[i].hw_id, __func__);
+					hw_id, __func__);
 				tsens_set_interrupt(priv, hw_id, LOWER, enable);
 			} else {
 				trigger = true;
@@ -392,7 +392,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 		if (trigger) {
 			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
 				hw_id, __func__, temp);
-			thermal_zone_device_update(priv->sensor[i].tzd,
+			thermal_zone_device_update(s->tzd,
 						   THERMAL_EVENT_UNSPECIFIED);
 		} else {
 			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
@@ -435,7 +435,7 @@ int tsens_set_trips(void *_sensor, int low, int high)
 	spin_unlock_irqrestore(&priv->ul_lock, flags);
 
 	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
-		s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
+		hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
 
 	return 0;
 }
-- 
2.17.1

