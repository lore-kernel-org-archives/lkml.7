Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588C1C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3292A204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099630;
	bh=X04IEbNJPOfhPp1sT0SF3+yHhr4QYk5f5IFuC6ckLEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMH+xpKf6tyaxPWKmgAY4J48kKE93lt+j9WdwRO2GqAnG+L2TVSNI/7FdSMWlVxgy
	 iGmtd4y5M65fLyquPYKfevcFT63qSR0VxRVsqOk74iKrDDSPgT5G3ZYjul4fFV5EEA
	 Y7MNNrFCzQrattEmrXfJloBKE37vO7x34WAN10II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbfFIRA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbfFIRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:00:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F37204EC;
        Sun,  9 Jun 2019 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099625;
        bh=X04IEbNJPOfhPp1sT0SF3+yHhr4QYk5f5IFuC6ckLEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXMwduZE2lHaJmr60ZuDFa9q2I2WANS2LbNfr7fAhV17VXFhEJtH1NZ5ugt3yvOaa
         9z1eNqDm9QKOPR7+7Ijqgjfa0HVpmhfI/IlEOxGN+JfgNDuDwuoAJLAdV82/phEANo
         TMnvlNZ2yM/wQNLVMhYjo+HsLpjq6SfBwFEtVCbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Dennis Schridde <devurandom@gmx.net>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 108/241] bcache: fix failure in journal relplay
Date:   Sun,  9 Jun 2019 18:40:50 +0200
Message-Id: <20190609164150.910801904@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 631207314d88e9091be02fbdd1fdadb1ae2ed79a ]

journal replay failed with messages:
Sep 10 19:10:43 ceph kernel: bcache: error on
bb379a64-e44e-4812-b91d-a5599871a3b1: bcache: journal entries
2057493-2057567 missing! (replaying 2057493-2076601), disabling
caching

The reason is in journal_reclaim(), when discard is enabled, we send
discard command and reclaim those journal buckets whose seq is old
than the last_seq_now, but before we write a journal with last_seq_now,
the machine is restarted, so the journal with the last_seq_now is not
written to the journal bucket, and the last_seq_wrote in the newest
journal is old than last_seq_now which we expect to be, so when we doing
replay, journals from last_seq_wrote to last_seq_now are missing.

It's hard to write a journal immediately after journal_reclaim(),
and it harmless if those missed journal are caused by discarding
since those journals are already wrote to btree node. So, if miss
seqs are started from the beginning journal, we treat it as normal,
and only print a message to show the miss journal, and point out
it maybe caused by discarding.

Patch v2 add a judgement condition to ignore the missed journal
only when discard enabled as Coly suggested.

(Coly Li: rebase the patch with other changes in bch_journal_replay())

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
Tested-by: Dennis Schridde <devurandom@gmx.net>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/journal.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 3a102f88eb326..6f9db98f2dfd7 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -309,6 +309,18 @@ void bch_journal_mark(struct cache_set *c, struct list_head *list)
 	}
 }
 
+bool is_discard_enabled(struct cache_set *s)
+{
+	struct cache *ca;
+	unsigned int i;
+
+	for_each_cache(ca, s, i)
+		if (ca->discard)
+			return true;
+
+	return false;
+}
+
 int bch_journal_replay(struct cache_set *s, struct list_head *list)
 {
 	int ret = 0, keys = 0, entries = 0;
@@ -323,10 +335,15 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 		BUG_ON(i->pin && atomic_read(i->pin) != 1);
 
 		if (n != i->j.seq) {
-			pr_err("bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
-			n, i->j.seq - 1, start, end);
-			ret = -EIO;
-			goto err;
+			if (n == start && is_discard_enabled(s))
+				pr_info("bcache: journal entries %llu-%llu may be discarded! (replaying %llu-%llu)",
+					n, i->j.seq - 1, start, end);
+			else {
+				pr_err("bcache: journal entries %llu-%llu missing! (replaying %llu-%llu)",
+					n, i->j.seq - 1, start, end);
+				ret = -EIO;
+				goto err;
+			}
 		}
 
 		for (k = i->j.start;
-- 
2.20.1



