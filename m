Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664D0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2834220C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367724;
	bh=2ZQv0lP4SMX7o5mZA8GhGrLz7gHyIZ3QFGGvt/vXxkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XYPOiyhJm4yM1wApQhpSPbv4ydJIuJyl1Iu7u0wXj9JyouevRhoZWjzwS7wa3SdC6
	 2kx7S7Bjy5ssDAU0JgYS4ZIy8qKZSZ1kCUPubXU9AIGqCm8DgOkxLZyicSceKLBDKP
	 PLgdzEwIm8ovbaxW7kzZDu84ZUwhAjJz01EVhE7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbfB1P2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387836AbfB1PK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D882E218C3;
        Thu, 28 Feb 2019 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366658;
        bh=2ZQv0lP4SMX7o5mZA8GhGrLz7gHyIZ3QFGGvt/vXxkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZNglkNcS072SgQqhZOQNhurF9UgA2DHojfzVY6keB3t59hb7UkMAsQymf/EEhZ1u
         +X7igBzTmGl1wGQkzZOQjcPJdLbgkBpCKO3Sym8qScEPnJrVVo85wd+YwNmbvH7qXc
         0SjTEpQVVUqCpcACOmGfRBPX5ALo47VSJk/iszTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 77/81] fs: ratelimit __find_get_block_slow() failure message.
Date:   Thu, 28 Feb 2019 10:08:09 -0500
Message-Id: <20190228150813.10256-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 43636c804df0126da669c261fc820fb22f62bfc2 ]

When something let __find_get_block_slow() hit all_mapped path, it calls
printk() for 100+ times per a second. But there is no need to print same
message with such high frequency; it is just asking for stall warning, or
at least bloating log files.

  [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
  [  399.873324][T15342] b_state=0x00000029, b_size=512
  [  399.878403][T15342] device loop0 blocksize: 4096
  [  399.883296][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
  [  399.890400][T15342] b_state=0x00000029, b_size=512
  [  399.895595][T15342] device loop0 blocksize: 4096
  [  399.900556][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8
  [  399.907471][T15342] b_state=0x00000029, b_size=512
  [  399.912506][T15342] device loop0 blocksize: 4096

This patch reduces frequency to up to once per a second, in addition to
concatenating three lines into one.

  [  399.866302][T15342] __find_get_block_slow() failed. block=1, b_blocknr=8, b_state=0x00000029, b_size=512, device loop0 blocksize: 4096

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/buffer.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 1286c2b95498d..72e33ffa00ff6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -200,6 +200,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	struct buffer_head *head;
 	struct page *page;
 	int all_mapped = 1;
+	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
 	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
 	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
@@ -227,15 +228,15 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	 * file io on the block device and getblk.  It gets dealt with
 	 * elsewhere, don't buffer_error if we had some unmapped buffers
 	 */
-	if (all_mapped) {
-		printk("__find_get_block_slow() failed. "
-			"block=%llu, b_blocknr=%llu\n",
-			(unsigned long long)block,
-			(unsigned long long)bh->b_blocknr);
-		printk("b_state=0x%08lx, b_size=%zu\n",
-			bh->b_state, bh->b_size);
-		printk("device %pg blocksize: %d\n", bdev,
-			1 << bd_inode->i_blkbits);
+	ratelimit_set_flags(&last_warned, RATELIMIT_MSG_ON_RELEASE);
+	if (all_mapped && __ratelimit(&last_warned)) {
+		printk("__find_get_block_slow() failed. block=%llu, "
+		       "b_blocknr=%llu, b_state=0x%08lx, b_size=%zu, "
+		       "device %pg blocksize: %d\n",
+		       (unsigned long long)block,
+		       (unsigned long long)bh->b_blocknr,
+		       bh->b_state, bh->b_size, bdev,
+		       1 << bd_inode->i_blkbits);
 	}
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
-- 
2.19.1

