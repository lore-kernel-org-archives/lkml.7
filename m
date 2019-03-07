Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AD920840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgKi668E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfCGKOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:14:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37025 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCGKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id w6so16710632wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BN3mETDxO7NCrA/T4tG8om1pvyGRKVieStW75qGQ3Gs=;
        b=jgKi668EjRONXhMjHjPq8+3uT7o5yYGkQ9wIoIksWJXOPIpPefAZ1jNU6RZmAqNb1N
         1zAC0UGzSDI1POOztCGLPgVR55cYHcBT7PDR8K6Elp6XjWxqDxoYIVxbchuJx4FEQW8V
         z+3eFNJftGE738LHlkVnfKlG8LAW2lBNqYX8EI13xsv0ubkcsY9QHD1ssQIfU6KbK/0y
         IwgmSItGIf6Nl3pvohJYc+TKqBJGTR0GKN69/RVLKsqW5WVZpMnaXDMqDmuXqn7u3lfZ
         pyPvfuGmWoM/Rb8gszX4NO21kbKRw43BweTajPHpkCRVBJTvNZhpZNeUlheM9GMu0d4i
         k5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BN3mETDxO7NCrA/T4tG8om1pvyGRKVieStW75qGQ3Gs=;
        b=SJw4a1rFIx1ajpBUtYljldEoKZIS8nD2cRgI0J7lP3IeCBd699/iXgE+QxeV+k8Sxp
         vCxbju1yaIoiQxX5x65q33Q978zu0B9aS0INwrR+f92j/QAu3M9XXMO15ECHnpdeEPqx
         7hzHhSUBaFNl79DaiRshSw5TDr6dRQ9lRRX7/GJf3XKQDU4wlRL3nPToyDrZxxV9Eiwj
         OZ83xchww1IRzlmqix5R9FcnZsmLZlUxIY5KkPRMDCjk9SRf9X36WJxRgYisUrAIiYbc
         emLXV9QCfKmJwX+20UavhSl8zKvajalWXd+HuNRCIJuf7HNr6GNvcAf4WJ7cYo5ySEU6
         lQGw==
X-Gm-Message-State: APjAAAXkZDQsbv7s6xyVFbAcdszBvgp7sm8BdLuxSVbRFtdkwYMo2Tfj
        bXmycyucru16ekUOZSrrwgSY+w==
X-Google-Smtp-Source: APXvYqwX04gG6I2J+ra4aXaK7H5PR3FYCj++7Mofa0ETtZaTwg7VBxgAnyQg4A0xUJk3r/Jf0i7L5g==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr6218993wrn.64.1551953597047;
        Thu, 07 Mar 2019 02:13:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Thierry Escande <thierry.escande@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/8] misc: fastrpc: Fix a possible double free
Date:   Thu,  7 Mar 2019 10:12:23 +0000
Message-Id: <20190307101229.7856-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Escande <thierry.escande@linaro.org>

This patch fixes the error exit path of fastrpc_init_create_process().
If the DMA allocation or the DSP invoke fails the fastrpc_map was freed
but not removed from the mapping list leading to a double free once the
mapping list is emptied in fastrpc_device_release().

[srinivas kandagatla]: Cleaned up error path labels and reset init mem
to NULL after free
Fixes: d73f71c7c6ee("misc: fastrpc: Add support for create remote init process")
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 82e7217ae87a..8fbcc607a77e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -853,12 +853,12 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 
 	if (copy_from_user(&init, argp, sizeof(init))) {
 		err = -EFAULT;
-		goto bail;
+		goto err;
 	}
 
 	if (init.filelen > INIT_FILELEN_MAX) {
 		err = -EINVAL;
-		goto bail;
+		goto err;
 	}
 
 	inbuf.pgid = fl->tgid;
@@ -872,17 +872,15 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	if (init.filelen && init.filefd) {
 		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
 		if (err)
-			goto bail;
+			goto err;
 	}
 
 	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
 		       1024 * 1024);
 	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
 				&imem);
-	if (err) {
-		fastrpc_map_put(map);
-		goto bail;
-	}
+	if (err)
+		goto err_alloc;
 
 	fl->init_mem = imem;
 	args[0].ptr = (u64)(uintptr_t)&inbuf;
@@ -918,13 +916,24 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				      sc, args);
+	if (err)
+		goto err_invoke;
 
-	if (err) {
+	kfree(args);
+
+	return 0;
+
+err_invoke:
+	fl->init_mem = NULL;
+	fastrpc_buf_free(imem);
+err_alloc:
+	if (map) {
+		spin_lock(&fl->lock);
+		list_del(&map->node);
+		spin_unlock(&fl->lock);
 		fastrpc_map_put(map);
-		fastrpc_buf_free(imem);
 	}
-
-bail:
+err:
 	kfree(args);
 
 	return err;
-- 
2.21.0

