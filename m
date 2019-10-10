Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA23C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7548C2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570712333;
	bh=JaOYT4xfOvr4kqwSZ9Wq5VVof1A2rGtzlZUoB310AmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K6dMdO71X4XyPhJYNtd7yQU7g/A6CRF7Z3sTRiv27BTiyTYx7IzhEfL9wo/8UBrEp
	 lnqKS8eUzx+wzeJixOA6Jh0YZuKFNfVezNJn0AwpvSfsAQSWeLSmG72TItfxaydlk6
	 cJUAhmopm2lE21zo5nHRXZsClFz+qP5bsogrVAXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfJJM6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:58:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36597 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbfJJM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:58:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so6121554ljj.3;
        Thu, 10 Oct 2019 05:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsKcMQ0kOXYnZnGpbjDTlFoz3bxWZKfaGIfDlmHG+/g=;
        b=Z8MXgmuUU/nvrVbVfpy1YnDJd8c/qmkDd2x76wCLmUHyEpVlDxSQMNgf0y1IS0laId
         sMDAfGv2s0P/dJsMekm/OKElcleDdHR7F6uT2h2caDntPa8fHL8ZK1CBn9hRgOZuMHt2
         hdKXhACVZkQvhphCNZXN3w3a6FRpHadKGR9fLUodIhnqPSBVHL6dIrH+/swzEfaSgrJ6
         JmAhEqITITwvKMM5gzYGWkRPtIVVM/IV9v4l4bNUXPF9n3/Wklqu0Dikapv/BDDSGhuZ
         dRBlldm0PqJxb3wWJOnoFFbkm8oiT71QA6WLj6WS8qWVqfIK6mTewuPKNnhRbBGCUA91
         9wGw==
X-Gm-Message-State: APjAAAWxbm9NQ0X5kCmVRmTY5BdnmtTjpvhnBuQEJLwuxKQKyZjO3crp
        sdetcBkk5oMnghMRcwg2oRE=
X-Google-Smtp-Source: APXvYqyYwfJIZO43Ub4WJDb8ROAYklkPlkhFFphSgKBa72PXTj14GSlJ1q9kJnVRvgIDOOWK8RPvJQ==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr6369540ljg.212.1570712328399;
        Thu, 10 Oct 2019 05:58:48 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id l3sm1247120lfc.31.2019.10.10.05.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:58:46 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iIY1x-00072w-Km; Thu, 10 Oct 2019 14:58:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Stuber <starblue@users.sourceforge.net>,
        Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 2/2] USB: legousbtower: fix memleak on disconnect
Date:   Thu, 10 Oct 2019 14:58:35 +0200
Message-Id: <20191010125835.27031-3-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010125835.27031-1-johan@kernel.org>
References: <20191010125835.27031-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If disconnect() races with release() after a process has been
interrupted, release() could end up returning early and the driver would
fail to free its driver data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/legousbtower.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index 9d4c52a7ebe0..62dab2441ec4 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -419,10 +419,7 @@ static int tower_release (struct inode *inode, struct file *file)
 		goto exit;
 	}
 
-	if (mutex_lock_interruptible(&dev->lock)) {
-	        retval = -ERESTARTSYS;
-		goto exit;
-	}
+	mutex_lock(&dev->lock);
 
 	if (dev->open_count != 1) {
 		dev_dbg(&dev->udev->dev, "%s: device not opened exactly once\n",
-- 
2.23.0

