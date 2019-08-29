Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC26C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8374F2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtDj5xCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfH2J3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:29:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfH2J3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:29:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so2927320wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gReQ7CjJRAhm4L6Tiz8Y9x8ZLQilV94lsV5veC3IIc=;
        b=PtDj5xCzFk2wfuU6zYpS9GCEDFNAdkqEJTun597to8/wlUXA2ovkmt2++lgNbddgWj
         nghCcmSOy88teYBBZJklqSkpkrGk0u7G46HXOPF8zXasJG7NYAM4xbl+IrqiDHsa4a0t
         Us1d9idE5Oe+d+yY46bKYHNlylT6HBA1I4f9ZwezXwkD49LPzyQsGAN7eAW+RkSJIfrX
         oFM8uxkVTyFTRc9rtET54Bn2IAabx2x7VgSIL6F2u1KCjd6gCSJJ11GQ/KNwG/jIsSzh
         Zlf6IL+bUikvtRslDtQAgaYAJGHhijvgZ0U1TiJIxLjlZ0DTgAmlBZZXglO3NV/qtQoq
         2AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gReQ7CjJRAhm4L6Tiz8Y9x8ZLQilV94lsV5veC3IIc=;
        b=d5sn+FJr6RVohQfD9AGNrL7CaM0TzE3y8GFb98ul2kLpR3lH6bsvSj59hlRj2+8pir
         0skhC5Q0/WptMASWGZB2I5LQ2GaOOcDCfTiLG+ZJNJiNmHTCHHMk6UWzXJiAumDAmML1
         cTiCm/VfdrxckIiDL8bMcK1pLmaefRIQfcSVHCRGqRJNikHmGu5ZUKYnNERF1ixZ+BJ+
         byQOUqwZYR30L5Ir0NiAAhpazzg+plUJq0J7F65DQIdSKioTgs4j1ztrHucPcNspq1Yo
         LIVp8Kda+29Zq/4HGTBqjxVwIM1V277DO/IEN9jkZEd9IBEop96X+Wg7sOazsDEAXJ+g
         v5fA==
X-Gm-Message-State: APjAAAWkYR49d6lHlsML7ASjlJZLivuYI74pYpehQEuYwvBZJFFib2/I
        ZkdUJNUZEtKTGrrUd0IR/WLBiw==
X-Google-Smtp-Source: APXvYqzOYofeicG26OGoFyHrHuKzsT2ky6ZgtQ05RxJCwCRhZ+vIGCCRk1RVQrAARSynZ2t5y03Taw==
X-Received: by 2002:a7b:cc0f:: with SMTP id f15mr10002879wmh.39.1567070976668;
        Thu, 29 Aug 2019 02:29:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f197sm3609512wme.22.2019.08.29.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:29:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>,
        Abhinav Asati <asatiabhi@codeaurora.org>,
        Vamsi Singamsetty <vamssi@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] misc: fastrpc: Don't reference rpmsg_device after remove
Date:   Thu, 29 Aug 2019 10:29:23 +0100
Message-Id: <20190829092926.12037-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
References: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

As fastrpc_rpmsg_remove() returns the rpdev of the channel context is no
longer a valid object, so ensure to update the channel context to no
longer reference the old object and guard in the invoke code path
against dereferencing it.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Mayank Chopra <mak.chopra@codeaurora.org>
Signed-off-by: Abhinav Asati <asatiabhi@codeaurora.org>
Signed-off-by: Vamsi Singamsetty <vamssi@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c019e867e7fa..59ee6de26229 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -913,6 +913,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (!fl->sctx)
 		return -EINVAL;
 
+	if (!fl->cctx->rpdev)
+		return -EPIPE;
+
 	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -1495,6 +1498,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	misc_deregister(&cctx->miscdev);
 	of_platform_depopulate(&rpdev->dev);
 
+	cctx->rpdev = NULL;
 	fastrpc_channel_ctx_put(cctx);
 }
 
-- 
2.21.0

