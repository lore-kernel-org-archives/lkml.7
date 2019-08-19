Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAEDC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSFsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:48:32 -0400
Received: from relay.sw.ru ([185.231.240.75]:38052 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSFsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:48:32 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hzaWq-0008BZ-FZ; Mon, 19 Aug 2019 08:48:28 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: redundant get_fuse_inode() calls in
 fuse_writepages_fill()
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Message-ID: <c09509ef-982e-d4bd-ed0b-da8389a7d066@virtuozzo.com>
Date:   Mon, 19 Aug 2019 08:48:26 +0300
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

Currently fuse_writepages_fill() calls get_fuse_inode() few times with
the same argument.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e076c2cf65b0..bc9b64ef7b5d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1874,7 +1874,7 @@ static int fuse_writepages_fill(struct page *page,
 
 	if (!data->ff) {
 		err = -EIO;
-		data->ff = fuse_write_file_get(fc, get_fuse_inode(inode));
+		data->ff = fuse_write_file_get(fc, fi);
 		if (!data->ff)
 			goto out_unlock;
 	}
@@ -1919,8 +1919,6 @@ static int fuse_writepages_fill(struct page *page,
 	 * under writeback, so we can release the page lock.
 	 */
 	if (data->req == NULL) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
 		err = -ENOMEM;
 		req = fuse_request_alloc_nofs(FUSE_REQ_INLINE_PAGES);
 		if (!req) {
-- 
2.17.1

