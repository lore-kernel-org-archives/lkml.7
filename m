Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4DDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB73233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiVT9zLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfH2J37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:29:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34180 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfH2J3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:29:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so2706953wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7K2iZxOhWYqdpgu+ftGX/anH+28e+S9dJx0eG5WBrFs=;
        b=oiVT9zLmf1h4t60P+I9CdvSij40tIxqhF78DG2hIgxWZ5HKvR0HrJISlbt6lpEsCG5
         fC+esGCCHY34XbPFe1pyBtp+Tvn2h3uf4qdcm0cUCom7AxdwXYpYD/zDkq3x6lLo5YU5
         5YXxHItF+lOOR2mqLSIeA7402VJFl250EKAhM9Wo4iuNf5Z54WKxqAEbuyQzQjAdEOx3
         GEXbr6w6bfk6hOFmFZ9klwRBzqw9EIFHZyMVzW7O+COGimlsjq1L5u2mdXfkzu6/p85M
         nadOZG8Dvj7AwH+BDwuyFr9TdmBsDlnc7Ct4okKhHKUiW+c2L4sq7Ks+SkPhHPN7asUz
         fPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K2iZxOhWYqdpgu+ftGX/anH+28e+S9dJx0eG5WBrFs=;
        b=L2XNSwhJh8l7rKkV4B7yv/9Qu7vSF63KTbYrBwdzrnQzMuF0EsawIwPQA9WsQm/qu/
         uorSeh52tMSkpHw9/ukQQ9poWsq80sdDnud+NS/iA8gSwjSB6H0rnOnrDMnf/rW1CPSA
         CoYn6DcnciR+CCPuoHdoYb8kmlLnDuVCSkx0YTl5mkLNEgia6MpNoluTo/H112sXGumD
         sC6bBuWomuwPt/oaX5St9RvvKJsqUqpMFgCYWm/9uQ+B5LSEHS7u3DGHb949nXYEDwsU
         LwHJdC75WPZDkdwHZ3sLpNa5Nz3rb3MGlubiDy2rh3NdJNZNOTunA8dlnYYHWvRG/w4z
         bplA==
X-Gm-Message-State: APjAAAVulDWZXBl4lnzHO1+O6IvGJmPhOBTTY79eFq1WpOXuZtdQqpm0
        2EUEAfcT2wMG0nI0oJ4QrFlBEg==
X-Google-Smtp-Source: APXvYqznwpsrQltLkUtPFiJRDC7Xelm8Yr3Kqqj9ti4s9kus+fNVdkfvo7yIAh0QBXcij46RIIfw1A==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr10359603wro.302.1567070978988;
        Thu, 29 Aug 2019 02:29:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f197sm3609512wme.22.2019.08.29.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 02:29:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mayank Chopra <mak.chopra@codeaurora.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: [PATCH v2 4/5] misc: fastrpc: fix double refcounting on dmabuf
Date:   Thu, 29 Aug 2019 10:29:25 +0100
Message-Id: <20190829092926.12037-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
References: <20190829092926.12037-1-srinivas.kandagatla@linaro.org>
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
Tested-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
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

