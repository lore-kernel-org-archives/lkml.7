Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AECC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184E2239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfGWGdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:33:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:48394 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfGWGdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:33:50 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hpoMs-0005VG-JK; Tue, 23 Jul 2019 09:33:46 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: BUG_ON's correction in fuse_dev_splice_write()
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d99f78a7-31c4-582e-17f5-93e1f0d0e4c2@virtuozzo.com>
Date:   Tue, 23 Jul 2019 09:33:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 963545357202 ("fuse: reduce allocation size for splice_write")
changed size of bufs array, so first BUG_ON should be corrected too.
Second BUG_ON become useless, first one also includes the second check:
any unsigned nbuf value cannot be less than 0.

Fixes: 963545357202 ("fuse: reduce allocation size for splice_write")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..311c7911271c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2064,8 +2064,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 		struct pipe_buffer *ibuf;
 		struct pipe_buffer *obuf;
 
-		BUG_ON(nbuf >= pipe->buffers);
-		BUG_ON(!pipe->nrbufs);
+		BUG_ON(nbuf >= pipe->nrbufs);
 		ibuf = &pipe->bufs[pipe->curbuf];
 		obuf = &bufs[nbuf];
 
-- 
2.17.1

