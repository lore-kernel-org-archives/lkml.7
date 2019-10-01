Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62474ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300B92168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948588;
	bh=dlc0JlRrIOsnSsI/+Cz3XpuH095SGIxEnhFSsQV/UwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hx0TZxMkwcwJ3a0duKm5kw3OsJfdvDgYKZO1hHxjZnsH6lxNoCutWT1yrfcRmK04f
	 egQnyn04hcPgRSsf2bqyEkupH7hnkVuQL10purB8gpimyvsR5L4vgbbZvXt9lYBiex
	 RK7VP92vvQWMhc5La4o16szWnqlL/9/4hg8x7aC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfJAQtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfJAQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:44:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0DB720B7C;
        Tue,  1 Oct 2019 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948287;
        bh=dlc0JlRrIOsnSsI/+Cz3XpuH095SGIxEnhFSsQV/UwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1x2NLKDdLADFk93yLCsGh9sJp+6pf2vHQ5H/wJGk7O/rFxH+4/LYtwdWl/R1YLXeE
         IbKlxLnlRagwruSS6ofdOA0MfjhI4xH00lJzKdOYF0aKzpmk3jvWXcQRNUFKuNeLSH
         7gc29VY4lRclmQvNSiCHYOuTwyTzRIlIgD0YMHEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/29] fuse: fix memleak in cuse_channel_open
Date:   Tue,  1 Oct 2019 12:44:13 -0400
Message-Id: <20191001164423.16406-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164423.16406-1-sashal@kernel.org>
References: <20191001164423.16406-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

