Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E432C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459DE206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAN6/KWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbfFJXwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:52:14 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:38196 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390682AbfFJXwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:52:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id n190so9512660qkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ud/bw4V77SyFt8nVuKDtI0QWt52VBA0pzrjbI+vip8M=;
        b=KAN6/KWKmZUHGkzA9fGRB0gmQg1st991k9TnAZHO0PVnyG/tFwNFeClhlR8QIhgMmc
         ySp4Mjm1oKbocU4TYzPvBXKryJNQRzJs4yKNjRX3Xj626CmIKFKPE1k4/auhPTABTjDm
         bAObuyqNR78lPx6zonAIzf8sku2qHPqRzC7PYxP8BRy7uvvxcKvHFlOMz/Nvi8CbMuyR
         d69Hr+YKWiC/nBr5l7sBAi5IvsgKQH4zr65RTFj8q75fQic4bswDtYm7DjNq741gTMdA
         aWZooTU7blyJslshfe86WWadiZ3w9pNuRcRgtdeQdcsEVrMkJa2d3/KUI9VsQivIV+4W
         +wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ud/bw4V77SyFt8nVuKDtI0QWt52VBA0pzrjbI+vip8M=;
        b=LGZGcLx5e3ZcT1xZFysuTYubFQOOmdIBMk/CWc5URr621im7aIK34SRK8Jy1dsk5ww
         n/Mkd+0X+N8arkYaTyujQ41dtOfoav4tlB36ADwR3qjBD54bCi2jyRnLEzrAdVuNLgA8
         3c/AToOq//PTBWAXKj5a1jYWHC7qdvxM6YJN9xt3paS4mo7dnPNROCAlUa+yjebfeClD
         0peTvcMIA+y1y674hPw5Mwxi5iIMwc02jE4/XCOG9ECtm4b4qy7ftgGK8y8GTR3aWJBu
         1CFItkAfg6ipfQJEc+VwnEb7XE5xhVS6779FWKcQMYt0IHldclSccB5maUhTRvZ2C2zS
         qnPA==
X-Gm-Message-State: APjAAAV7nAv5lTgKJTDK3GRiypIT39i1+OW9wJH6+Fcjmv6UGNHi5Mfx
        MT4z77FasV+gGOJHuAUTg7+W1GH1WBoZ6jjZOnAJPGRW/zIXtL4ePXPGvOgWjDYt25x/xF0BRjs
        TpZs1/or3nq8IzY41WEyY2hYEZRU9F4/Q+NVL1R8J5dGIYId1f2deC7T7vZuf0xZUkZQ=
X-Google-Smtp-Source: APXvYqzmXbzsD3tHKHiIsN5XXzhsSJvjTCuBQqiKTV7myw/rxhDuWjYx7IJNlPfLcNFc2OLFeWBMMGJi/Q==
X-Received: by 2002:a0c:81e7:: with SMTP id 36mr26133271qve.5.1560210731131;
 Mon, 10 Jun 2019 16:52:11 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:52:01 -0700
In-Reply-To: <20190610235201.145457-1-fengc@google.com>
Message-Id: <20190610235201.145457-4-fengc@google.com>
Mime-Version: 1.0
References: <20190610235201.145457-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [RESEND PATCH v3 3/3] dma-buf: add show_fdinfo handler
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        --validate@google.com
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, kernel-team@android.com
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
2.22.0.rc2.383.gf4fbbf30c2-goog

