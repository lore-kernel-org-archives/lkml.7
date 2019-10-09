Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60EECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CF020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S37KM856"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbfJIOlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:41:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39488 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731570AbfJIOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:41:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so2903758wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6OiJB7EuLtp7p4md9nfqD7cxFgmkO+0cPK10Zj1xY4=;
        b=S37KM856wHDnECg/1FKkIy1yjXEgnkQZyXIgt16MoukNlQDooW2oElREMEGO9tw42c
         AN0H2HND1RtIjiWZr5Fo+xtOP9xOk176a+hD22LrL5O9GSyT4botIELjYdWGET/4hcDF
         MSnQufVUYttCnPzEAqqOarb+lb97gnpLlsqgoN9KOEiH629AypzkAIhnbqv3tknO6SkK
         FRN+R9m1a/e1/sTZ2XFgbsuZdeP8lIROsVWrKCc9X5BLqc22aK4ZCiTbb0gi/H/ZCFF8
         iUyxB5Om0WyMwD3xAeu98dsJPGZ06bln/EFt4pVLcPpPvIdRTLhK3woc13l4ShOYOBVW
         1Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6OiJB7EuLtp7p4md9nfqD7cxFgmkO+0cPK10Zj1xY4=;
        b=Vwemqg0xqYlPJJjomThQE+RO8zjBfHcW3gKrMhK0Ri07yQy2qyea0bTdP47+Ax1A9q
         l1lluopgAGScw4AsBfRb8qO0N7ovaK3aTvf/K3l3eDTrOjKXj3g3dGZco1p6vX9jEBWi
         GtncpguoKHKr4mWlzYqR8ApzjpeKRqM4da1rKVGpvmirZiNJDhq7pKxBlA1B2Mmx9Z3u
         whHaSn8GbAR1N1DNTtHR2bJxICCaMhMilYcEIHhIHUddqr4pxEtntCNB8Mu678PnW+df
         x+TReLRJje8A59NhalU21cp1JEZvaOpY/SINE3unalL0CFdPZhj4wE6Qj0nsdQ1e92Kv
         +30A==
X-Gm-Message-State: APjAAAW6EV1u6u4hvgPZsDWtGr2r1x9ssRej7M3pwdNr8vPoxRo+n7ud
        C97S0eyTrU+G3kVugiNbVHlOJg==
X-Google-Smtp-Source: APXvYqzdoajYxUt+SlTTO0rYrQtFoWl/VHou2VgKvHy8Q2cy4h9n2LvSPVFWSoFcClx2YWzAtQ95gQ==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr2928113wmj.2.1570632095145;
        Wed, 09 Oct 2019 07:41:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm3031770wrx.56.2019.10.09.07.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:41:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/5] misc: fastrpc: handle interrupted contexts
Date:   Wed,  9 Oct 2019 15:41:22 +0100
Message-Id: <20191009144123.24583-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009144123.24583-1-srinivas.kandagatla@linaro.org>
References: <20191009144123.24583-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Buffers owned by a context that has been interrupted either by a
signal or a timeout might still be being accessed by the DSP.

delegate returning the associated memory to a later time when the
device is released.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 666c431380ce..eef2cdc00672 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -984,12 +984,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
2.21.0

