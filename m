Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D8ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E16215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDl7kJK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfJAS3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:29:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45440 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJAS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:29:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so5900189pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xnyZjNCbO2ap2oxzis7QRBMw3/itYSPcHMr8ypFsW4s=;
        b=EDl7kJK+Gu6PPzl7r1r30j5jzkLc7XveE/hrfDIc7KKwn7fy7suEKGSogHMdKjOd00
         yzcV94dCp+XLbLJis3rCbnPcYAS711/Ww8/+QjGhEg0kSJZ5iz/d5tdK6bX9JBBoUX9O
         yc4DDEUpP8g1EQg/LtRUKyG10i2hRG9v/Ap4b2HKb+/JnAuNq0Mk+/OYuuTIes0uU1Lf
         rEtVzLU3kBNTfc4URdkmz5wkQd50NZqtmJVf0z6lIEhKfOQV5WM9QmYblnsbcJfLVIH1
         SIa1r+a+Ujn/fcA1PgwtC/5T80nlbwOZi0CVKOBHlBjdcJJFRGu7rPo84QIE0r31U2Gx
         mS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xnyZjNCbO2ap2oxzis7QRBMw3/itYSPcHMr8ypFsW4s=;
        b=Iu8CpnSNNdxEFXmLJ/7JPjlC+xFwPeyEFnTR7vAKqZuKRsWK9rB8MHzqP2pgrWh0V9
         PmaIe0d5EOV4/XN2ESr5QM4cn/B/LsTAj9+fr1T2ljGNKWCmnsgIzANEeIGfchI/sRcC
         tdkO/mr+OPMMfvU0yOOLpwcDGCMacwTQv395vSaWtSUNnXpsJahfYmX6KyU3aGw1a89a
         TZ9Vaz2cYo3GBkYVyaZO0tpdGTO7ESfDCk7JDfHW8PCwKZn8243gR/bZ52JJ3W0c7dEi
         qN0PrMoqebgObjNybd7RZsJRBYk/6Z3eBbIY8sJpOg7iqALCFjVXBfTI3iQ8+q8Kj15r
         Alpw==
X-Gm-Message-State: APjAAAXbwF5jZ5LO5vTCVEy8zA5HHogzTGpiK1pLfwJxX5/y7QwtOlBH
        ZyeHl6wqRl5q+4YI8BOJqx344ukDePM=
X-Google-Smtp-Source: APXvYqyRbXISq3SO34OqGRk8drfBkKPU3mD55VSiIQPo3ZwrS0eL4A9EHXkMC5c+SdGyZCp4LNxRBQ==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr25389237plq.210.1569954579845;
        Tue, 01 Oct 2019 11:29:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id e10sm18189221pfh.77.2019.10.01.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:29:39 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] drm: lima: Add support for multiple reset lines
Date:   Tue,  1 Oct 2019 18:29:27 +0000
Message-Id: <20191001182927.70448-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

Some SoCs like HiKey have 2 reset lines, so update
to use the devm_reset_control_array_* variant of the
API so that multiple resets can be specified in DT.

Cc: Qiang Yu <yuq825@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: lima@lists.freedesktop.org
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/lima/lima_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index d86b8d81a483..e3e0ca11382e 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -105,7 +105,8 @@ static int lima_clk_init(struct lima_device *dev)
 	if (err)
 		goto error_out0;
 
-	dev->reset = devm_reset_control_get_optional(dev->dev, NULL);
+	dev->reset = devm_reset_control_array_get_optional_shared(dev->dev);
+
 	if (IS_ERR(dev->reset)) {
 		err = PTR_ERR(dev->reset);
 		if (err != -EPROBE_DEFER)
-- 
2.17.1

