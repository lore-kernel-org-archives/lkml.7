Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DFC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F58920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Smy3Jh0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfFMWeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:34:23 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41195 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfFMWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:34:20 -0400
Received: by mail-qt1-f202.google.com with SMTP id e39so465533qte.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LEbx6Py1LlxNnYNfMUQLEHmXYGAjBktMwzf11o00qiQ=;
        b=Smy3Jh0xPWHxt5WDJ+8KkM+LzEnH7FyKOFRSiuheeGSq98m3pPRdHAqXEezsiMyAbX
         1h4Uqu90fX9XGFJZwaDpIJGGL+QNNxoCI0Jdr6XBxHiS9fCvNMKc+RtJGZbq9JNibFdQ
         Buruwhxy9ly9ARec8g9nh9YNono+ejunCF26DFpBY3UFknHuMr16eMHyiYH/7sHg18xO
         3AcP7YZU7rRfP5sniNezbdqmdA7tNJgEh/s8YmsiPBXOjyzcWAGFHCUmdn1v+yk2Ff+O
         B4pPLKgZuC/08CFWCguu+2yNzdZ8oxCTdJxtBsekaTar8Ydc5dl0iMrnBm9xABuYz7Ei
         Jzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LEbx6Py1LlxNnYNfMUQLEHmXYGAjBktMwzf11o00qiQ=;
        b=bEjJHrIrJKooVCtT4nX1iezr/t3yFHv/TH4aunyCc1NSxFgn2ifKbKl7DEOz0U1YNt
         AJ3N702AEI3KquHy4KYneEwvByQsKSbaKtTukypu229uKGe3RlQq2lAq0MYOV1Fms05h
         Lopo/TItUUltVNg81PIO6reN5UH5m8fQC91sPO2bF0Sptr+cTFg952xlbJPyNd1dV+9P
         8VdC5bK9EQ5fyrO37D7PUZAI3FGyqWNXxOn9zHZHQsUko6EZeUcUwWE9jRiGxxLBUShO
         6aNB0rblXH8TVUNxHVAsHcMs6KnjdG3WntK1Mbn3e3yiyQJ5OtWgpDlzBfyRSt3EopVK
         IISg==
X-Gm-Message-State: APjAAAXKPQl/SYWFHJphF6pJJo/JjcPnXO3OYE2t2x8geDcgaop7/NtG
        3i1dRGf4ipxtNYJj+M5WpTXdzf7dq1zrzKoEdbj7c3h6DjI/uSX1HBxCxaeWYjt0mZs/vfEnF43
        Keh+ADUqxgYsSMDcBOIlOKdtL+M+gbbL+enXv+Ikwu3s8Dul31NZlyFxrkfCbaf4Fetg=
X-Google-Smtp-Source: APXvYqzPVM+hxKCGgOVop12/mUhf51zpio33hHg87tz8aaGPy+G5h7ILBQFuMHAA1crz0uCPLsKvZ9lqaw==
X-Received: by 2002:a0c:d196:: with SMTP id e22mr5472255qvh.75.1560465259477;
 Thu, 13 Jun 2019 15:34:19 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:34:08 -0700
In-Reply-To: <20190613223408.139221-1-fengc@google.com>
Message-Id: <20190613223408.139221-4-fengc@google.com>
Mime-Version: 1.0
References: <20190613223408.139221-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 3/3] dma-buf: add show_fdinfo handler
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"
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
index 2c862e36c947..49a5cb7c705d 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -397,6 +397,20 @@ static long dma_buf_ioctl(struct file *file,
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
@@ -406,6 +420,7 @@ static const struct file_operations dma_buf_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= dma_buf_ioctl,
 #endif
+	.show_fdinfo	= dma_buf_show_fdinfo,
 };
 
 /*
-- 
2.22.0.410.gd8fdbe21b5-goog

