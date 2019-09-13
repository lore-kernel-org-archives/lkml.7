Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566DE205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFdL1AcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391601AbfIMPZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:25:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46305 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389457AbfIMPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:25:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so1290437wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOYzS8r6FFCe1w6kMt/c64rHO9y9+Q16CQmrviT721s=;
        b=TFdL1AcNXLVgcVLdgEs8GmnKDUPQYd47eafZmqW1SB0DPG1x0WlYI6j0S78cMxlNuK
         L+0iYzlmdkBL/N6NfA65/iXx3ULpxhxvFF8rUMwsy//9R3VKaI9ZA+SbmBDXQm0bGZu8
         fyA2aXG4bs8iJdTIo6XBFuZwdUU6FGdO5TNEUtIEyeNknU1bNVX1VRGMZkHjjfP8ZOHl
         +eB//bCZ9KdSmLfLAVRDXX1WAh3shOORm5NdZM32zjIgk8uoc9Cj6TEqOw/anaUAFLfw
         CLqGQqSPimZAubkFQs9HnU57zZ2KHcB4E/VkR5VbbFY0RS/d56IBw7ZA9dfDlyRXpNXX
         08MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOYzS8r6FFCe1w6kMt/c64rHO9y9+Q16CQmrviT721s=;
        b=YBZ3PA4O6pOKJU+a9PhbWTFW5Cm7QH2tTe+yQ8JA7ajGE/iy//qo/pXYu9ZRThOi78
         QBnFci+GFLrT27fEl6vC0lPYoTAw86Pl2SERAPCBkZbJp9em9FCr1aYjL1x3Vel5p2g+
         E+2ih/y6SiOQXSSYDaumQfQ+Q/CzVa5QItvFS7Apm/E9W7GjWbMJ4TZRbTSdBVsOQuB8
         RFst7VKqI26SZqdCKpWwRL5cY6nmNadU0r1CSOA1ArF8hspp43UioaKn3DsTComfYeSh
         O/+R8WFzTVuEx1yT104UQ0UsLYSFtHUXODxp5uh/Ra7ZYlVSfOrrz8KqebfdM8nV8rYd
         6XBA==
X-Gm-Message-State: APjAAAV+shl5mCPaFdM5E3LFjR5/+OlY37Xx9JJx40SVbbyxZsliNEzD
        3284JwL8uq2w6lxvUiuNrFTqVZ2oGso=
X-Google-Smtp-Source: APXvYqxQ2Xo0HNP7p67Q+VIHhFA/KOFNvS5Om/sK/H7Q7Uz4IRrqTLaBB3T7XPDGmeFkgGtoKLZGSQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr19578762wrv.55.1568388341124;
        Fri, 13 Sep 2019 08:25:41 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id d9sm48717728wrc.44.2019.09.13.08.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 08:25:40 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/5] misc: fastrpc: handle interrupted contexts
Date:   Fri, 13 Sep 2019 17:25:31 +0200
Message-Id: <20190913152532.24484-5-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
References: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers owned by a context that has been interrupted either by a
signal or a timeout might still be being accessed by the DSP.

delegate returning the associated memory to a later time when the
device is released.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d2b639dfc461..40b48db032b5 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -952,12 +952,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	}
 
 bail:
-	/* We are done with this compute context, remove it from pending list */
-	spin_lock(&fl->lock);
-	list_del(&ctx->node);
-	spin_unlock(&fl->lock);
-	fastrpc_context_put(ctx);
-
+	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
+		/* We are done with this compute context */
+		spin_lock(&fl->lock);
+		list_del(&ctx->node);
+		spin_unlock(&fl->lock);
+		fastrpc_context_put(ctx);
+	}
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
-- 
2.23.0

