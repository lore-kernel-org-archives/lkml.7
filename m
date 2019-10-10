Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C99C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784272064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697634;
	bh=dlc0JlRrIOsnSsI/+Cz3XpuH095SGIxEnhFSsQV/UwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUX8nD2eVykw0zY08a7PRcM6lR8HCcWKOWYa4Ankzg0rM7K8gAl6YevqtEnhuBHKi
	 beW2zyNQXUN8KP+N2Nov+NCWnsW0HmpYAto0JCXnwy3IHtHzQeVYfJzV+XKZA6kQ6y
	 0czXp+Emv+vuWOLk2iBlmopGpHMUSMbBiyUWOwcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbfJJIxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbfJJIvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:51:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D872F21929;
        Thu, 10 Oct 2019 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697471;
        bh=dlc0JlRrIOsnSsI/+Cz3XpuH095SGIxEnhFSsQV/UwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmzF1Gb6IXFZx9DKoesCCL6bEzCsZKM+TzAHT05jyqwMp7Wsd36ZjparsO8vzQlWT
         eCM6CfYrzB+kNHcDQAVWiW2FiwIA9Yg8PyqmLvpb3SPL+nbgTvZ3CHAtLUsWz9ZuxD
         8ete85CbrXRqf3Z7jwFDVAtzqH2v+0gKZODOadS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 40/61] fuse: fix memleak in cuse_channel_open
Date:   Thu, 10 Oct 2019 10:37:05 +0200
Message-Id: <20191010083515.693357951@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
References: <20191010083449.500442342@linuxfoundation.org>
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
index e9e97803442a6..55db06c7c587e 100644
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



