Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E6C208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688192;
	bh=ZL/Kz7xpPaLmPB4ldCcNqNTPPLltejwuZdxpCCp0sbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dzrlAaENpNQWFDzYjuRzJFYwH++ue8JaArbUzhZMWOSWpRfYB6bjboL5E7wqblTon
	 so/d8UumnMC0X7E3aS9NoDQ7J05KzG/UVjGi4n3ddCfepHbl5o4YUcx33I1eKRS0gz
	 XHBwYMs5/L3JHzG6upv1TB5Gb7NG5rjwl2HAnVhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfCDI3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfCDI3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48F2D20823;
        Mon,  4 Mar 2019 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688183;
        bh=ZL/Kz7xpPaLmPB4ldCcNqNTPPLltejwuZdxpCCp0sbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e29yrg9PSEckJ9e3a2OeTEryfzTn86MAmilchatMzc67CqtzBYjtO917PB4cjfKP3
         YBXEfdyFI6JdL5dUgztYSfU6M4/MAv9pwfx4cJ3KspdcKAqtOOIHgnBvrpZybJleC+
         WCUcs1F1ETJYHqG5BQyLPYc37g8iN6yAROy6No18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        "Andrew F. Davis" <afd@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 43/78] staging: android: ion: Support cpu access during dma_buf_detach
Date:   Mon,  4 Mar 2019 09:22:26 +0100
Message-Id: <20190304081627.414531051@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 31eb79db420a3f94c4c45a8c0a05cd30e333f981 ]

Often userspace doesn't know when the kernel will be calling dma_buf_detach
on the buffer.
If userpace starts its CPU access at the same time as the sg list is being
freed it could end up accessing the sg list after it has been freed.

Thread A				Thread B
- DMA_BUF_IOCTL_SYNC IOCT
 - ion_dma_buf_begin_cpu_access
  - list_for_each_entry
					- ion_dma_buf_detatch
					 - free_duped_table
   - dma_sync_sg_for_cpu

Fix this by getting the ion_buffer lock before freeing the sg table memory.

Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
Signed-off-by: Liam Mark <lmark@codeaurora.org>
Acked-by: Laura Abbott <labbott@redhat.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/ion/ion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 99073325b0c00..45c7f829e3872 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -237,10 +237,10 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct ion_buffer *buffer = dmabuf->priv;
 
-	free_duped_table(a->table);
 	mutex_lock(&buffer->lock);
 	list_del(&a->list);
 	mutex_unlock(&buffer->lock);
+	free_duped_table(a->table);
 
 	kfree(a);
 }
-- 
2.19.1



