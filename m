Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA444C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C8820663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCGAD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:03:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39960 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVI-00086l-VW; Thu, 07 Mar 2019 00:03:17 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 1/8] aio: make sure file is pinned
Date:   Thu,  7 Mar 2019 00:03:09 +0000
Message-Id: <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

"aio: remove the extra get_file/fput pair in io_submit_one" was
too optimistic - not dereferencing file pointer after e.g.
->write_iter() returns is not enough; that reference might've been
the only thing that kept alive objects that are referenced
*before* the method returns.  Such as inode, for example...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 3d9669d011b9..ea30b78187ed 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1790,6 +1790,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 			   struct iocb __user *user_iocb, bool compat)
 {
 	struct aio_kiocb *req;
+	struct file *file;
 	ssize_t ret;
 
 	/* enforce forwards compatibility on users */
@@ -1844,6 +1845,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 
 	req->ki_user_iocb = user_iocb;
 	req->ki_user_data = iocb->aio_data;
+	file = get_file(req->ki_filp);	/* req can die too early */
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
@@ -1872,6 +1874,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		ret = -EINVAL;
 		break;
 	}
+	fput(file);
 
 	/*
 	 * If ret is 0, we'd either done aio_complete() ourselves or have
-- 
2.11.0

