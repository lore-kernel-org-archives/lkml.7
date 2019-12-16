Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F7D21739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518968;
	bh=z3Kj59tElYDFczXrLzBvFGf3Lq0FVEcXhM0H7/niF5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDxBq+P+8dxwz4vk/roAPTIICfFiDIOkuswiAUa0eqsNLXSfrrANjZOOvFrB4Cvu0
	 B2bUn6an22ZbuutRxM0cRIlegpzidtDBAboT7JLPTvjOWFPk+gj4iGzjafF3Q0lmZ0
	 cLJ8elh+GmBWkjBy+kv4cuARmwf1oad2ms0J7PnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfLPR4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbfLPR4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D36205ED;
        Mon, 16 Dec 2019 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518964;
        bh=z3Kj59tElYDFczXrLzBvFGf3Lq0FVEcXhM0H7/niF5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5REI/HtGV94qLxsBnJg5NaS6jZnHtIsLwWtQqoLlnL0dA08bntKU5rh3xJX5h4O+
         gB4yWCDexksL6moDzMh2XNCZdABGXiqnLKm4BEpg55oU1q0WrKw/dSutfl6iHqFFf1
         bAsfxhVB+y/8BR8UPtsDiG6J7rr2tbqJxawg/p3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 138/267] jbd2: Fix possible overflow in jbd2_log_space_left()
Date:   Mon, 16 Dec 2019 18:47:44 +0100
Message-Id: <20191216174909.393995412@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit add3efdd78b8a0478ce423bb9d4df6bd95e8b335 upstream.

When number of free space in the journal is very low, the arithmetic in
jbd2_log_space_left() could underflow resulting in very high number of
free blocks and thus triggering assertion failure in transaction commit
code complaining there's not enough space in the journal:

J_ASSERT(journal->j_free > 1);

Properly check for the low number of free blocks.

CC: stable@vger.kernel.org
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20191105164437.32602-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/jbd2.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1584,7 +1584,7 @@ static inline int jbd2_space_needed(jour
 static inline unsigned long jbd2_log_space_left(journal_t *journal)
 {
 	/* Allow for rounding errors */
-	unsigned long free = journal->j_free - 32;
+	long free = journal->j_free - 32;
 
 	if (journal->j_committing_transaction) {
 		unsigned long committing = atomic_read(&journal->
@@ -1593,7 +1593,7 @@ static inline unsigned long jbd2_log_spa
 		/* Transaction + control blocks */
 		free -= committing + (committing >> JBD2_CONTROL_BLOCKS_SHIFT);
 	}
-	return free;
+	return max_t(long, free, 0);
 }
 
 /*


