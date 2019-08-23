Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFCBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1199221726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1xW6LLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392175AbfHWKHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:07:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53353 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391917AbfHWKG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:06:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so8363000wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaF1NgI3/tCvQBGNuV2Ozkr5swOUz9Q1YNoph3dPfCA=;
        b=G1xW6LLifBzrZM98pMoqJppw5kCp9ljlnOSzFRZtPclDF6fw8Cd2RUQbL0e+HEm3Vh
         XX47d4h6nOFaDu8xJVs81qT+pZ+mIy7lRkoybJ7YhLjSgksA+EHlJsTjucE5uYSVAZvo
         +maJ1dWGYioVbSCriunnxWS+VkjLwTXWXByvsLbX0bDs9OJaHQFzEhMuBh8ecp61O0fp
         jZVCvAk73YWOGRf70F/tbiI2HeEnsfYcO/0xZjti62IB6C9kIYLIC/r+QNPhKKbJ21zv
         TM0sAUn4q+jETQpBFdyuPj7eFjqls67JbdbpT3rW6taBVOyeCNlkgILM5x1fMUnJlyaO
         dEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaF1NgI3/tCvQBGNuV2Ozkr5swOUz9Q1YNoph3dPfCA=;
        b=A5rkSuV61Epzf9c7YQ+W7zkk6gFFLqXxKvDGemSXKkrL+lM2GXhnmsgMlPBsqenf6c
         eeoO5VZKp4RgPqwNas67Qaljeim4/HcFEGydZ5qezD8BuGZxhpznjkM1In6lsQPojJrE
         cvu+F5S3pfHJ4+58+J4OQqDuYgnroaN2aoTywJBbZ846M084E28/3OZOSTinXEOfs3jX
         43lKAib6Bct32so4L92GFJg1nEsriHSbRiIxhFj+8k6qVE5EFDMRLhMPgYzKtyYcT6Ex
         riHPi6FHHbWQ/6Cpg+HaaIlmx2qeHhlcqVKgSQ/8vlI0CVEwgMWJs8LJ4Un0Z/KVJwyv
         UXqQ==
X-Gm-Message-State: APjAAAVDgN3/Cr0ADy1XCdcedZglBeEzqlpdbetX7SaNyc8J4obx4fJS
        2+pFWTg82MnilGAxs9Lb6Pvd6A==
X-Google-Smtp-Source: APXvYqxr6Ve5WHV7MVzIMJCJhqJK17mYKT2gjF4J7C7qQDdftl2ahoRPHgxRAJkI418O2EeBBSReLQ==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr4100755wmg.33.1566554817994;
        Fri, 23 Aug 2019 03:06:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q124sm2058048wma.33.2019.08.23.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 03:06:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>,
        Abhinav Asati <asatiabhi@codeaurora.org>,
        Vamsi Singamsetty <vamssi@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] misc: fastrpc: Don't reference rpmsg_device after remove
Date:   Fri, 23 Aug 2019 11:06:19 +0100
Message-Id: <20190823100622.3892-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
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

TEST=stop and start remote proc1 using sysfs

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

