Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A4ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B52B21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264603;
	bh=x5Dh/lsFvWpy8PJRDAS+pIIwjaN0mNYgFOUG/aDqDhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nhzR59k9ZYWDM+SLaSS8ho+0y7+hSYMT4QNdQuuQEIOUrauaRHo2pcoDRZyLWX+/f
	 IFA/9CuSlV19S+qN7TipHdX3jwYwgU7mvIiyNEw1MzKPlt9l9wHsaT1+8gYMn8Zqq0
	 iBfWl6holALUE4ZmNXG+oEPTmbvP4NzXM6KH1mpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407674AbfJPWXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437094AbfJPVw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:52:58 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1701520872;
        Wed, 16 Oct 2019 21:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262778;
        bh=x5Dh/lsFvWpy8PJRDAS+pIIwjaN0mNYgFOUG/aDqDhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ADQGG74rwagV0B+Qob24NDzkPVMlCPYj4wz8xm4DlxooPzw0loX860VOOSIIn4QhC
         nOzrburxQ3qoLnCi/LWfzbHT59D2ZwUs61aOxS6vDdr6uJ9/Mzem5ii0CgXG72jpZy
         G+oeKdCtM7d7veAJmisZl42OK5dEJo4FR88v37zA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/79] fuse: fix memleak in cuse_channel_open
Date:   Wed, 16 Oct 2019 14:49:54 -0700
Message-Id: <20191016214747.875720830@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 9ad09b1976c562061636ff1e01bfc3a57aebe56b ]

If cuse_send_init fails, need to fuse_conn_put cc->fc.

cuse_channel_open->fuse_conn_init->refcount_set(&fc->count, 1)
                 ->fuse_dev_alloc->fuse_conn_get
                 ->fuse_dev_free->fuse_conn_put

Fixes: cc080e9e9be1 ("fuse: introduce per-instance fuse_dev structure")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/cuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index c5b6b71654893..d9aba97007267 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -513,6 +513,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	rc = cuse_send_init(cc);
 	if (rc) {
 		fuse_dev_free(fud);
+		fuse_conn_put(&cc->fc);
 		return rc;
 	}
 	file->private_data = fud;
-- 
2.20.1



