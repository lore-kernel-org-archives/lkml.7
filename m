Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8015C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A530F20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCGAEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:04:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39976 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCGADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVJ-000870-Ey; Thu, 07 Mar 2019 00:03:17 +0000
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
Subject: [PATCH 5/8] make aio_read()/aio_write() return int
Date:   Thu,  7 Mar 2019 00:03:13 +0000
Message-Id: <20190307000316.31133-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

that ssize_t is a rudiment of earlier calling conventions; it's been
used only to pass 0 and -E... since last autumn.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ee062253e303..5dd5f35d054c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1508,13 +1508,13 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
-static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
+static int aio_read(struct kiocb *req, const struct iocb *iocb,
 			bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
 	struct file *file;
-	ssize_t ret;
+	int ret;
 
 	ret = aio_prep_rw(req, iocb);
 	if (ret)
@@ -1536,13 +1536,13 @@ static ssize_t aio_read(struct kiocb *req, const struct iocb *iocb,
 	return ret;
 }
 
-static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
+static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			 bool vectored, bool compat)
 {
 	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
 	struct iov_iter iter;
 	struct file *file;
-	ssize_t ret;
+	int ret;
 
 	ret = aio_prep_rw(req, iocb);
 	if (ret)
@@ -1716,7 +1716,7 @@ aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->iocb->poll.wait);
 }
 
-static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
+static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 {
 	struct kioctx *ctx = aiocb->ki_ctx;
 	struct poll_iocb *req = &aiocb->poll;
@@ -1787,7 +1787,7 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 {
 	struct aio_kiocb *req;
 	struct file *file;
-	ssize_t ret;
+	int ret;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved2)) {
-- 
2.11.0

