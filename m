Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14224C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4EA2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svuswpTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393658AbfFMRPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:15:30 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:40105 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfFLVse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:48:34 -0400
Received: by mail-oi1-f201.google.com with SMTP id j22so4359840oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xFZI9Cn8XQ9WD/uM2zeIjsdArEKjTB6MEJpCpF8H2cY=;
        b=svuswpTBA4Vx+DLei1h+oVomOQmLsZNHTti0CIQZQVpzQDIyHeME0lAHPve5gT8exd
         E79eA8Ev5/qmWH+q1GOZI/aoxL+R3S0AW9XY83rHhXMkYf3xYQNqMgX+ONGiiVasflGI
         eI4w2zUXmOl99uOnNm49b46Ho4C7q5YMdGb57vi+f+sAvCHkeXb/szZbGc1dYp0RHLUX
         Bb7SqaKZDqXDMG/xtvv6j+JphFCnnBeglrzOcsw04pOqmrnqEZOKJYQBPtYglaBDlDdo
         k8HUtS4ismdMPZzP+d61mUgOI2udfdS0JqERvV7uLB3RxgaFRt3+YQiwnIdWGJ5Hgvtl
         5Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xFZI9Cn8XQ9WD/uM2zeIjsdArEKjTB6MEJpCpF8H2cY=;
        b=LE/dO81ipvmEGsFWV3Snt6dE9nkZORHBwGjcCiMAdaJS3bRfeYf1GHSXBWD21jk0bP
         nICclmO+EKW0QxLJw5HXIjy6HlJyr6euS1Y7/R3DM/X/1KenrKchbRoYTgPIvuNK0I0O
         zaJKX72AbAp9/mqdwharmlnU4eTY+0lkvG94X/9Y+5Sh5PS+XjOijfpovBYUrcxbLC3S
         V3KqbYjCcihhCfsIeU53wCyvB64jB/n61WtznwNsMN0ynXi8u5E7JayJlHwkC8/OMeLx
         uureHGc8Gnh4yxHYDy7d2VI7zaOrcoOgLKhO4Qxs2/wsiosHuuMdYKfOnGX2XINRr6by
         g/yQ==
X-Gm-Message-State: APjAAAWH8cOO6qnmVXxQGxRI6lmWUv/tYLCvOiMl0u7snz7Hxz81ave/
        +PDZjmTmNZt8BwjE8gtxSeTIPE21ZKJEq6NBVVuTxpki33u9dV4YB/DXSfEo6xQ5Vr/WrgxZMUM
        DStCEZPTudihJnWED9c58VnNJaQXQIDr1BP+u1HXaWwTqlSVkjsC2UXQZRzJljKjJkV0=
X-Google-Smtp-Source: APXvYqxn5WIL38quMvWm0NFNVoCMoq509G4lVulP6aIh3DMM/7wKweu86NGynkKEkLolsMXyoApH36EYpQ==
X-Received: by 2002:a9d:7650:: with SMTP id o16mr19689292otl.0.1560376114065;
 Wed, 12 Jun 2019 14:48:34 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:48:23 -0700
In-Reply-To: <20190612214823.251491-1-fengc@google.com>
Message-Id: <20190612214823.251491-4-fengc@google.com>
Mime-Version: 1.0
References: <20190612214823.251491-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 3/3] dma-buf: add show_fdinfo handler
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
index 87a928c93c1a..ff8421668331 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -396,6 +396,20 @@ static long dma_buf_ioctl(struct file *file,
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
@@ -405,6 +419,7 @@ static const struct file_operations dma_buf_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= dma_buf_ioctl,
 #endif
+	.show_fdinfo	= dma_buf_show_fdinfo,
 };
 
 /*
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

