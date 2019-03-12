Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFC92173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412896;
	bh=0JvHPP//cXlqDXAg9KMU65RjY5rAPgDPMr4nTbHmqew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TQ5JsvZvlDBQ2Zwa//Rz+2YNKT+GMZvCbEaPUgRa/XQjOymnqSRo2apMTZQ0/iCh+
	 EwAA9M2JCNzRSgAoJdUNSgVWeO+0acRbu+Hw3c2lHuEbOy/ESY7I3X2ft3+BCIPnek
	 7L9n04CSJtAg0Ea7MOC5+ogYxmL7edbn/5nsJXU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCLRsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbfCLRPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:04 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C979206DF;
        Tue, 12 Mar 2019 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410903;
        bh=0JvHPP//cXlqDXAg9KMU65RjY5rAPgDPMr4nTbHmqew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVY91zSDyU6RzvKvcttSEGzRg2K72jEll7BPvrmnL5vMedAPIQt6NCofYE6BLojK6
         nJZYJh00yB9d4gpmJKWDm0gS9vJ9hzRY8lESg+1kuToA62dvt0IPInl3aRtPqSfthh
         Z6U4GyK6WUoJNlzITJ01jc8MiEJeA5CecUubcjfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 117/149] fs: ratelimit __find_get_block_slow() failure message.
Date:   Tue, 12 Mar 2019 10:08:55 -0700
Message-Id: <20190312170359.275220975@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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
index 6f1ae3ac9789..c083c4b3c1e7 100644
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



