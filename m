Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B30C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5107C206DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUjZ+/Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgABOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:54:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46904 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgABOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:54:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so21975321pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjOF1oUSrrO0URh0mj4+ZNJlrmQRUgZsgYN9DFASUmw=;
        b=OUjZ+/Z3trmas3K38X08vZdhWSVxLFcdDC4Vc//HoLDX4rxQqVIf4Tb47d0OzLNuZm
         Bc6LZxRWPBdGnRsSgXqCsD4UAPQbo0QsBAYNby6WycX4c0ykyK3P1NfIIzP/wlyVopec
         4jP+WrTcitu+1Up81c4GyLcsDBl54OWLS1RY3bpXdp0xmhf+5vxMrCiSHGwu5W7j1gNk
         s4xnHuCqEz8RRhamhtFWya22394C75t2zX2d4vCVM65A7T3lkIh2yQS2Mt7KizoUVksf
         mcnbxEbY+Kwx+W+/xGKKfW0mZKdbXO8zUT25WBiJ1d2hMelHiPZZG2F4++H5uLy9lTlN
         EVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjOF1oUSrrO0URh0mj4+ZNJlrmQRUgZsgYN9DFASUmw=;
        b=arN7TfzmEXaZRoZQRrdRMbAbdGVIw6E2sNzkywo5PKYDFMu+jy+6rc5xn7eta60nr8
         D2vivrML/OEHtHjFm8xJOXPMnOGj0peJF1QE/NpUiv/kXEQM2AJoI37fApzS9zJEJ7Pu
         ESaTLCGnM3ti8KMsbz976EosNkRp9v652jG6U5y/Av1mzzvxc//R/bZt+R2gYRcBKUDu
         zyEM/dvG4ixYzqpUNk8RSzPV7NK/E6iwqkV2gz0s7jJQAUV07R0okUCKvwa2ESPc30Wv
         c5mZilMdBiM3tRmEZzKOFSNnGXR3GbKJd4Ja4kn0Hfsyr63nqhHRRR6pv3gIByS5K42c
         IW5Q==
X-Gm-Message-State: APjAAAUg3l4T+N+YzsGLGRY4SiPe2RVG84VR2p8Occ0ZH950qvql7MJ/
        zO2I/p8epPzBIrhuXe83uI4nrVLb9Za6Hg==
X-Google-Smtp-Source: APXvYqwlvaympWHfPGjB6g1AcZQTDfAAvQcu0Ua50SZ5Ouow2P0IMHFFkmzhdtLSzyH2/OMx+0G9jQ==
X-Received: by 2002:a63:d108:: with SMTP id k8mr88808304pgg.434.1577976891078;
        Thu, 02 Jan 2020 06:54:51 -0800 (PST)
Received: from localhost ([103.195.202.148])
        by smtp.gmail.com with ESMTPSA id b42sm11581627pjc.27.2020.01.02.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 06:54:50 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/9] drivers: thermal: tsens: use simpler variables
Date:   Thu,  2 Jan 2020 20:24:28 +0530
Message-Id: <09ac47eea963e84bd3eb630897c2b77f3868b90b.1577976221.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577976221.git.amit.kucheria@linaro.org>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index c2df30a08b9e..1cbc5a6e5b4f 100644
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
2.20.1

