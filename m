Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42872C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB9C2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7kBlMxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfKOWeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfKOWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so7327667pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6V0ioyUbzQMXQMBXE7qcEPEwz5yqv4QBePomZ4UZPqc=;
        b=k7kBlMxXsG6gA/UcmlwTDggZ65v+ipn3YUceSw3Oegz9WKEnqSckQYHfAT76F7fPjN
         s7QKdRMaRPqZFZSI/xOc6FPxjFzbfDiSqxO16UNRWzwpNND4qj7rCnHyntrgf8gWE2+b
         z31khVZDNGGcS5gNaQpHfSp84XhywQ1G5jrK5dsnXgm8xzY2Bttagju6GbfsQCuUz1t1
         a1jGQru7049kf1xVk9PcTip/XRGMTQ3ZDi5E07+5EowNcQ7XYcGxNTDsz6/vv89SFEC4
         rOkGhyiZz4rpSal4odmYlyBahCIUN9rZMet/cta0i71K0Th0xdUbgnAkFRClk3lff4d1
         /chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6V0ioyUbzQMXQMBXE7qcEPEwz5yqv4QBePomZ4UZPqc=;
        b=gtPjIjAIS0RoNd6B7kOaMSlpnGdV22uhzyTogsru+3wyINTwysI/+rG1Ahf/dYoylK
         uIlOMVY2DYoSKtosa3e1Ezy2IrTYo/KiRI/PF8FNQdjpUL4uP8m/1pVCso29Wmwf2bYj
         2JNkM7qX4xmTclwmVTBwYdCM9RoUMnJ+VAdpOCsvXAvFJLRvsZSUFxGDQ1fIaY2yIsNM
         SPf/qJ+bCNOWGRlleHG35Rm1tXfe9E+7eC+PSMIW4j1O9oBj0b4nKoSzvUa19XkOH88q
         MFuWXLuNvvrhPpe1Qr0LBlAzHYStOq2iq0WW2hktmUI0c6TDlO+CnbueubeSMq/VT6+5
         r22w==
X-Gm-Message-State: APjAAAVr4l+K50kXPZLjd9PWRoAbiJHFXK6yb2IWQf3LvEn+9PFDvFqS
        KRnSFAGy08u92o8RBZgzOxeHag==
X-Google-Smtp-Source: APXvYqwPDrxT0ltVk6U0vCs9B/kupiJwArvMyWvfpOn2zdkBUlstoIR7TdNRADNMqnuUZbeIdUbysg==
X-Received: by 2002:a62:1c8:: with SMTP id 191mr20454995pfb.152.1573857242567;
        Fri, 15 Nov 2019 14:34:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:01 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 06/20] media: stm32-dcmi: fix check of pm_runtime_get_sync return value
Date:   Fri, 15 Nov 2019 15:33:42 -0700
Message-Id: <20191115223356.27675-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

commit ab41b99e7e55c85f29ff7b54718ccbbe051905e7 upstream

Start streaming was sometimes failing because of pm_runtime_get_sync()
non-0 return value. In fact return value was not an error but a
positive value (1), indicating that PM was already enabled.
Fix this by going to error path only with negative return value.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index d86944109cbf..18d0b5641789 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -584,9 +584,9 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	int ret;
 
 	ret = pm_runtime_get_sync(dcmi->dev);
-	if (ret) {
-		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync\n",
-			__func__);
+	if (ret < 0) {
+		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync (%d)\n",
+			__func__, ret);
 		goto err_release_buffers;
 	}
 
-- 
2.17.1

