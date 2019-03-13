Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5804AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D90213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504737;
	bh=XJGc3W5WgIo9OYDLHjACv4k2rDo9omJyRRB1L+VIZm8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fSZEDkQ1H1uSSW4fYYUQ9f2Ul5oQjLVS35mrp+3XwjnACHH5QHod1jh1aY8Q+hruq
	 x/pVuJc2EW8/mBV7bU1bR/CFqBuZGjPcpJppjhOhYCyxMVefGhdJq5X++RyP+ANsr6
	 VLAbQ7Liu+B+w/w12HnAB4anHKqj9ykXyDtSZHfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfCMTSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbfCMTSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:18:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF6C2183F;
        Wed, 13 Mar 2019 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504730;
        bh=XJGc3W5WgIo9OYDLHjACv4k2rDo9omJyRRB1L+VIZm8=;
        h=From:To:Cc:Subject:Date:From;
        b=CMaabPD8zJoECSlbawVSBJ2GZ3dDnK+KdIGg6hnLVY+ql2Zk+0y0dlcfub/2jx/h3
         Q6fTvL3RwcaWeg9NEW/Vopuf1LOpn/Wfjy714m2wFz/UX17cpAI+uN9wbIy9IQzuQV
         2v3nhSFLq5z81cMv5o0qeeyYFG0Mp35wOq7MSBxI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 01/10] assoc_array: Fix shortcut creation
Date:   Wed, 13 Mar 2019 15:18:37 -0400
Message-Id: <20190313191847.160801-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit bb2ba2d75a2d673e76ddaf13a9bd30d6a8b1bb08 ]

Fix the creation of shortcuts for which the length of the index key value
is an exact multiple of the machine word size.  The problem is that the
code that blanks off the unused bits of the shortcut value malfunctions if
the number of bits in the last word equals machine word size.  This is due
to the "<<" operator being given a shift of zero in this case, and so the
mask that should be all zeros is all ones instead.  This causes the
subsequent masking operation to clear everything rather than clearing
nothing.

Ordinarily, the presence of the hash at the beginning of the tree index key
makes the issue very hard to test for, but in this case, it was encountered
due to a development mistake that caused the hash output to be either 0
(keyring) or 1 (non-keyring) only.  This made it susceptible to the
keyctl/unlink/valid test in the keyutils package.

The fix is simply to skip the blanking if the shift would be 0.  For
example, an index key that is 64 bits long would produce a 0 shift and thus
a 'blank' of all 1s.  This would then be inverted and AND'd onto the
index_key, incorrectly clearing the entire last word.

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/assoc_array.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 0d122543bd63..1db287fffb67 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -780,9 +780,11 @@ static bool assoc_array_insert_into_terminal_node(struct assoc_array_edit *edit,
 		new_s0->index_key[i] =
 			ops->get_key_chunk(index_key, i * ASSOC_ARRAY_KEY_CHUNK_SIZE);
 
-	blank = ULONG_MAX << (level & ASSOC_ARRAY_KEY_CHUNK_MASK);
-	pr_devel("blank off [%zu] %d: %lx\n", keylen - 1, level, blank);
-	new_s0->index_key[keylen - 1] &= ~blank;
+	if (level & ASSOC_ARRAY_KEY_CHUNK_MASK) {
+		blank = ULONG_MAX << (level & ASSOC_ARRAY_KEY_CHUNK_MASK);
+		pr_devel("blank off [%zu] %d: %lx\n", keylen - 1, level, blank);
+		new_s0->index_key[keylen - 1] &= ~blank;
+	}
 
 	/* This now reduces to a node splitting exercise for which we'll need
 	 * to regenerate the disparity table.
-- 
2.19.1

