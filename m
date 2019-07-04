Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC8C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6572C218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2XovPsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGDQZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:25:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53003 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfGDQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:25:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so6280539wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vu3bIjwYWHnqxtGQ7M7Ln0vm9Kv3/gy3iOZGBSVw5C4=;
        b=M2XovPsBg/LoExs9gVhoF6/bha1lZ/rlVY5BfJ+TpN8/kKlJSis3aDOKOtncwbx/3U
         QS8FlbprvGIJfbcieppMZkuUYRGx0UXYku1WjxirlRbehvi/UEnayX6q8BdG4KZ3R3nt
         Lfg61RNOrKMFqVtkHEmWiB7ZPdhWUdHJ/xPkV4qRa3epu7VGPXK6cN7YcFpFXrtz5yBe
         ouF5BS03XcqxfYqSAUucrDX8k7XtwP1aJGDUVASBIMG4lxOwSQUejLSN3Vf+ANViohTW
         wX6v/GHvrZFlbAODmfKDggK4wmX6LMjPcmRUoay8EtIuFABvIKgecek7IEs3EnPnAHcC
         eKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vu3bIjwYWHnqxtGQ7M7Ln0vm9Kv3/gy3iOZGBSVw5C4=;
        b=D0gFVMR11Q/kNK4jRBYQ5/dcpSWSGTfuXuh95W3Zo056p2qiUz6NRrivebnV22rLpk
         5RrIZXGX2DZxCjwQe8adV/+w/KHQSYAonpsHfRN9GxIIO55GV/sTLobPEcMkGtP3KT6T
         JGBWVurqgZpU15vZ+wDaTRFqaBxTqb/MoNTEN3wgmenXEgtQLBMcZe/yp/PW8d4+tx/o
         sKTbXi3A0RSJ4z/kFVXABTh6vM+NYgI78GsK0cnNGxFu1NUNr8WBKErEOyR3EmrInfzk
         +d1gpwFxJSyDDpDy2OaiDCqyZDEZFYIZiCuzhbZ8CbVPR26Q56Lnixu8HZNYuuAlnLLS
         shPw==
X-Gm-Message-State: APjAAAULE7Vix0BgPH101jSLyaCyuhjYuIENhvUJ4yWvmYB3GBpWVePu
        oko8p1K+d+pxzi3WLsXiMFTH2i6QW8A=
X-Google-Smtp-Source: APXvYqyTRbGQ+qv9/HC1ChfBAYz1dpwmAAW33ASF5aGaNMt6W2b/Fgu+oNqQjid94UuvAEjTUTCdSA==
X-Received: by 2002:a1c:6a17:: with SMTP id f23mr233672wmc.91.1562257514827;
        Thu, 04 Jul 2019 09:25:14 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id u6sm5780280wml.9.2019.07.04.09.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Jul 2019 09:25:14 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] misc: fastrpc: fix memory leak
Date:   Thu,  4 Jul 2019 18:25:10 +0200
Message-Id: <20190704162510.23093-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deallocate the buffer when no longer required.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 98603e235cf0..af8fd2101a1d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -279,8 +279,10 @@ static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
 
 	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
 				       GFP_KERNEL);
-	if (!buf->virt)
+	if (!buf->virt) {
+		kfree(buf);
 		return -ENOMEM;
+	}
 
 	if (fl->sctx && fl->sctx->sid)
 		buf->phys += ((u64)fl->sctx->sid << 32);
-- 
2.21.0

