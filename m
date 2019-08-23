Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9972F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8kWpNq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392036AbfHWKHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:07:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55854 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391992AbfHWKHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:07:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so8374227wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bn9fvz5KyheuCTcqtCUPe7LWgeQB+vBp0zLz7BbKyg=;
        b=i8kWpNq1BAp6nGlQ2U0mFfWA7MVPLqzBGVt+JqsdDMretmxZn7KIYxP6lIRF9g+BX8
         2z2PyxyNrujPgUGIezcz3O+35GsB8jeSkw0a5mL+nF/2oxHBrr1VELcwRt6FePii4ISq
         pwlxw7UrQQiAyhOEo7cZwQTW3fKOcfvrv+EgnCPDQKt3Ddiu2mH1GHcfGHULfqgJz5qZ
         BVnkMhj5zHRVnvE7VhbXLFzYTHk33AtBoUO8c61xx3Y5J2dz/9RTbjKZKg+/YjP5epzx
         RV9QnA3mHRhAXuV2ZgfxVOoAovEnXYCGGREzg1MUnZ7LsK4KnGTi58ER4obOcFH6S4XE
         jsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bn9fvz5KyheuCTcqtCUPe7LWgeQB+vBp0zLz7BbKyg=;
        b=HbLXo7usCWyUfHP7DFTJJUJHBfVGsNsTmUofHIZCUr5+8hy+HXyDVixHD2UsDiFGO1
         qwMymIp/IabGsvRSg4RFBi0ajqFyg2F+zRJAzMMq//7v0SzK0ld0PfYLO8IUC0ugwmH4
         JrddGeHmtupJLV/k8yVhqDH0ckMxlYwNExKiaf2Wynyox6fn+baiz+hlNWCLJ/Epm4aV
         9kJWZRxv10MHUPvjAaIWi07xYckyUBWSfUjGzBN18xn2Kgflwuv5up0cRUTk0vyALXbG
         MsUlAwTjBJ8dhszU/SnKmV9G4wGCOdF+K5hmyb25McglW5ECKJD5QV0chBbpxavTu5m7
         3s/w==
X-Gm-Message-State: APjAAAVYVmqkm6rDpEaehp5x2PKepXV+TaxCslIxbHRD62PeWVME0pzi
        9L3vr1LXwvcG5q2ZrVggN58yLg==
X-Google-Smtp-Source: APXvYqyS6o1nQX0Spu3MmMyOf41j4schPD8zXjXi/BNhodtH/EgHaHeiTHgqAqEn8QLfQeA7UfkmRw==
X-Received: by 2002:a1c:7611:: with SMTP id r17mr4181366wmc.117.1566554820260;
        Fri, 23 Aug 2019 03:07:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q124sm2058048wma.33.2019.08.23.03.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 03:06:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: [PATCH 4/5] misc: fastrpc: fix double refcounting on dmabuf
Date:   Fri, 23 Aug 2019 11:06:21 +0100
Message-Id: <20190823100622.3892-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
References: <20190823100622.3892-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma buf refcount has to be done by the driver which is going to use the fd.
This driver already does refcount on the dmabuf fd if its actively using it
but also does an additional refcounting via extra ioctl.
This additional refcount can lead to memory leak in cases where the
applications fail to call the ioctl to decrement the refcount.

So remove this extra refcount in the ioctl

More info of dma buf usage at drivers/dma-buf/dma-buf.c

Reported-by: Mayank Chopra <mak.chopra@codeaurora.org>
Reported-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 38829fa74f28..eee2bb398947 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1198,26 +1198,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int fastrpc_dmabuf_free(struct fastrpc_user *fl, char __user *argp)
-{
-	struct dma_buf *buf;
-	int info;
-
-	if (copy_from_user(&info, argp, sizeof(info)))
-		return -EFAULT;
-
-	buf = dma_buf_get(info);
-	if (IS_ERR_OR_NULL(buf))
-		return -EINVAL;
-	/*
-	 * one for the last get and other for the ALLOC_DMA_BUFF ioctl
-	 */
-	dma_buf_put(buf);
-	dma_buf_put(buf);
-
-	return 0;
-}
-
 static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_alloc_dma_buf bp;
@@ -1253,8 +1233,6 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 		return -EFAULT;
 	}
 
-	get_dma_buf(buf->dmabuf);
-
 	return 0;
 }
 
@@ -1322,9 +1300,6 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
 		break;
-	case FASTRPC_IOCTL_FREE_DMA_BUFF:
-		err = fastrpc_dmabuf_free(fl, argp);
-		break;
 	case FASTRPC_IOCTL_ALLOC_DMA_BUFF:
 		err = fastrpc_dmabuf_alloc(fl, argp);
 		break;
-- 
2.21.0

