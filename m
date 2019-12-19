Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248302465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781145;
	bh=IzNdT/9xwp0qGFxu72g8aNt1brIix4kd4JLAcacDTXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKGGWxxnJnyLULkFq+3BY3+CFWtkx/d3ercTHNHyDwM8nGM48vlHWG415ukXkRtsu
	 aPjVEvP2mG7ekHntrAGn991+/S5ccbfk6/bgoQ86jY1M7ElewyB6XJL1UnEv+fgqS/
	 iP+0IrZuHhe/SKuJ9ghxd7g+ZYWmhXAtC+d2yC/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfLSSpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:45:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbfLSSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:45:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75317206D7;
        Thu, 19 Dec 2019 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781140;
        bh=IzNdT/9xwp0qGFxu72g8aNt1brIix4kd4JLAcacDTXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1GzAGODn6nwLpbM2jRE3MjpRJI22UaqH3bTHxbS1bzoHbnaa3dqhm+E/YtKoZSOYE
         jiQ9avfQA93uQwFpdlfRwUl2z3/n/hELshPngFhOs2UXeDIZtkKgXKhw0U4iYi4lXC
         E9k8yIgjGtrt9fEGtSupk2s+QNj72Tdop/Ri27Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.9 082/199] jbd2: Fix possible overflow in jbd2_log_space_left()
Date:   Thu, 19 Dec 2019 19:32:44 +0100
Message-Id: <20191219183219.496834979@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
@@ -1560,7 +1560,7 @@ static inline int jbd2_space_needed(jour
 static inline unsigned long jbd2_log_space_left(journal_t *journal)
 {
 	/* Allow for rounding errors */
-	unsigned long free = journal->j_free - 32;
+	long free = journal->j_free - 32;
 
 	if (journal->j_committing_transaction) {
 		unsigned long committing = atomic_read(&journal->
@@ -1569,7 +1569,7 @@ static inline unsigned long jbd2_log_spa
 		/* Transaction + control blocks */
 		free -= committing + (committing >> JBD2_CONTROL_BLOCKS_SHIFT);
 	}
-	return free;
+	return max_t(long, free, 0);
 }
 
 /*


