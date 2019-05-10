Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F87C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062E02182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaPLSmzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEJAAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:00:46 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:53331 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEJAAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:00:44 -0400
Received: by mail-vk1-f202.google.com with SMTP id g12so1679315vkf.20
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qD8P7476YfiQtjv1E6lcuRrJ6WjHMdxq7Sq+F+HQQEQ=;
        b=IaPLSmzKORGLubRZrX1/p4t4QHdGUfNfnAEmoGdLAHRQoPsbSW6uDDBJOb9f3LXHek
         sk+DwsYhcfhq+7j7K45imBSSCNuSDwLYpIRvzQc8+Nu5EJrX/tI4imfG8SYqs9ghzmuM
         EWqHxg0TO7vL6iRBOVhbxCQr9Frq6HSfIio/r8BFcFG3YqICHmpbYug5nLJyKSSuIZnm
         4z9JtbJZ6F/gyewF5ZKdOLsVPObowxwUPTH8fP2+Jab1Q4XT5XJSoLn509G7HlSfKNux
         OQ1pHDC1iRC+lLM1SfCg3g+mij6MB0TAg6QuSwiXXC4ZX3CoHijLVAdRnvhmiGsvI+j4
         5Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qD8P7476YfiQtjv1E6lcuRrJ6WjHMdxq7Sq+F+HQQEQ=;
        b=An/s+uapit1gRN1lNYbpdMN+cMvqA543cWkh3svMTarPBZc0LC0Mw/Omb2j/GJUWD/
         N9iipvle3ALX8lhPgZHrNBajrDFO9yJbXqLwqhMaA1TRKDook+/dVBA6ZSfcUnS5PZTD
         LP6xCIAAYIsoKqAOVPHFNhDf605rEsxKeQukzl16Ibny4Ds+8MrxSXukQRpcDzz9PdrM
         h+R0M38H5ZkKHlc5zzjafC0n8V0Jkdnc9lYV8aHfOkNhRMfJS3+hupmWFbKNjA/IKv5t
         ZCPjBVyU7pW9j2LvVQugqjCAJ+Kj33yCZLfCRl7AkENawY/iCg8cKj39ayHi9Ph2FOkE
         IeIA==
X-Gm-Message-State: APjAAAVAP1J89CA5xI0NEPW4w1J6B00dghULFI01z3EFdsSu2FQxBdcH
        woQn1H4h0VgYlnJrTCkeoN/LNBnt1q/ACJGDLG1AuAGiD1/F9ipVm9W3jLK1N1+2T9oXXVhypab
        mEm2Sxvdei67Rds6FV44Iu55khuszCGT42dx+PSvYJcY6OBmxsqMGfVW7nocFzK7iAdU=
X-Google-Smtp-Source: APXvYqyQxj4h5EKFqbJwstNLfU5pFLcxwQyE6tubj5ad3UX+SHoN3VqGEtU8yaujXV/3yBwO0e+/NOKcuw==
X-Received: by 2002:a67:79ca:: with SMTP id u193mr3938693vsc.20.1557446442991;
 Thu, 09 May 2019 17:00:42 -0700 (PDT)
Date:   Thu,  9 May 2019 17:00:32 -0700
In-Reply-To: <20190510000032.40749-1-fengc@google.com>
Message-Id: <20190510000032.40749-4-fengc@google.com>
Mime-Version: 1.0
References: <20190510000032.40749-1-fengc@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [dma-buf v3 3/3] dma-buf: add show_fdinfo handler
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, erickreyes@google.com,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

The show_fdinfo handler exports the same information available through
debugfs on a per-buffer basis.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Chenbo Feng <fengc@google.com>
---
 drivers/dma-buf/dma-buf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index c1da5f9ce44d..c4efc272fc34 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -381,6 +381,20 @@ static long dma_buf_ioctl(struct file *file,
 	}
 }
 
+static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
+{
+	struct dma_buf *dmabuf = file->private_data;
+
+	seq_printf(m, "size:\t%zu\n", dmabuf->size);
+	/* Don't count the temporary reference taken inside procfs seq_show */
+	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
+	seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
+	mutex_lock(&dmabuf->lock);
+	if (dmabuf->name)
+		seq_printf(m, "name:\t%s\n", dmabuf->name);
+	mutex_unlock(&dmabuf->lock);
+}
+
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_release,
 	.mmap		= dma_buf_mmap_internal,
@@ -390,6 +404,7 @@ static const struct file_operations dma_buf_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= dma_buf_ioctl,
 #endif
+	.show_fdinfo	= dma_buf_show_fdinfo,
 };
 
 /*
-- 
2.21.0.1020.gf2820cf01a-goog

