Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95278C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B0221873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260116;
	bh=tW9v3yXAyUF31m3V5Ny9qlvpcwP/fXWE6g+3AW1zyW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B3Rcj6/ifuwugxbVm3+IkDafYlbiHLywKGxtm2Wk0r01ajtRdhGJ0LeZWCXRp5baZ
	 uk7jkQ7x3Gk0zloNg6MYGITARrMZGdStBnUy0jKLd5/AlwOg05d1eUYt8K5hmAGh1a
	 c483UmqWTJxV3rSipjlZqlbi38OYiTz5RWIku/b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfCVNIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfCVLfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 177832183E;
        Fri, 22 Mar 2019 11:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254530;
        bh=tW9v3yXAyUF31m3V5Ny9qlvpcwP/fXWE6g+3AW1zyW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTqMFpSvVa64uTHFO0XrSV4AUra/X8RD1KGhf2o9zU9nc7LLTk7if+tjONOJ2oWdF
         TqLdpFYIMZQMqzkaxsekrs+0Tg4L+rffW5Ncui0FvQe8a/irlQJAePfz03ZtrpTpzf
         dELVB+4ATCi0V6N9ROFKv6zCPjuOu0bH8kTu2Css=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 164/230] assoc_array: Fix shortcut creation
Date:   Fri, 22 Mar 2019 12:15:02 +0100
Message-Id: <20190322111248.231319858@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5cd093589c5a..3b46c5433b7a 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -781,9 +781,11 @@ all_leaves_cluster_together:
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



