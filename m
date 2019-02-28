Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16252171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRxLQX4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfB1Iqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35185 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfB1Iqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so8077821wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=81uTrHGFTZhQGdLbq5DvexH1XjRzW1YVUvPfrlyvge4=;
        b=pRxLQX4mhoei+/tiBZHb0YLUvO9YnwZIUmqNhLIlF3h0vBtTU/YoRXtEmA+MzFBCwh
         Xu1bocdNSybUuU8P0SeC13HgjbFfOL9bR8OvfBF0ksXYZnxX3q2MF1y+PFmaljFwI7IW
         aO/ZmAOJyhbwt/ncUpgLOZptGKxitYMvNNP1yq64+IHkF2rbSFSC2zxO3ROLkZembkaF
         jAudRenXYjfnUrfCrBOZj97nZG+D0l9Wwq6fmcutUnC2PpOY7KaHnyzAZmJuQrPlJhc8
         XHV6NiVSCpqGM5TUiGUa7dembnUDp/Qr4tKOQeIgQzrlfzNUQclMIpGwP4mb30bgobfR
         dVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=81uTrHGFTZhQGdLbq5DvexH1XjRzW1YVUvPfrlyvge4=;
        b=Rc+PkHEnfqfzrKU0pybURAuzX27ydQHA8gF6dJUpmJ4dHUlpi8XqQBDeldNjYeRrem
         V67Kl9nz5NRqT/1aRzznlZRCONKvhaRg6NEbWVSpHepb3aBET/Y8d+n1OFZnB1EsPkZS
         wx87NefAhskQdxSrF5ZwNfdlwe5eGMwov3rU512nm0hcQyvy5dY942biRA7bJjyqu5do
         PTJeWHz3EEElqK0au+YIhGA521mLIfmTa0Slr0HHvvhER1Sst9eUYH4BUJIb0JKOEZc3
         7IQz8ivZP5LG6vynLmBgWP8JdhexhOA0pfyyXR4A6MQFMyQ/0eizU0ulWC75QWRNPJuU
         aw9Q==
X-Gm-Message-State: APjAAAWQzLMNQVekhm1kuEpXHm7r8zYT+/6nIhxW2CaJxxyxHCtxOwQH
        x3M13KdKTQVipf3TNHOszVo=
X-Google-Smtp-Source: AHgI3IZnCJhzcLbijsFJFfVuJgnZvwgKZ15428Ur2QKGuBLhPDq5LKRzKN6H5fgV7gFy6nfDB+YSgQ==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr2097105wma.60.1551343608489;
        Thu, 28 Feb 2019 00:46:48 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:47 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] habanalabs: fix memory leak with CBs with unaligned size
Date:   Thu, 28 Feb 2019 10:46:19 +0200
Message-Id: <20190228084624.25288-11-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228084624.25288-1-oded.gabbay@gmail.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a bug when a command buffer with unaligned size (with
regard to PAGE_SIZE) was used. The accounting for the unmap operation
wasn't done correctly and could result in a memory leak.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index 28e359731fb8..85f75806a9a7 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -236,11 +236,14 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 static void cb_vm_close(struct vm_area_struct *vma)
 {
 	struct hl_cb *cb = (struct hl_cb *) vma->vm_private_data;
+	long new_mmap_size;
 
-	cb->mmap_size -= vma->vm_end - vma->vm_start;
+	new_mmap_size = cb->mmap_size - (vma->vm_end - vma->vm_start);
 
-	if (cb->mmap_size)
+	if (new_mmap_size > 0) {
+		cb->mmap_size = new_mmap_size;
 		return;
+	}
 
 	spin_lock(&cb->lock);
 	cb->mmap = false;
@@ -273,7 +276,7 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	}
 
 	/* Validation check */
-	if ((vma->vm_end - vma->vm_start) != cb->size) {
+	if ((vma->vm_end - vma->vm_start) != ALIGN(cb->size, PAGE_SIZE)) {
 		dev_err(hdev->dev,
 			"CB mmap failed, mmap size 0x%lx != 0x%x cb size\n",
 			vma->vm_end - vma->vm_start, cb->size);
-- 
2.17.1

