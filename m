Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD7EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8BA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505145;
	bh=rwFtV5ZE5ddOjB4kg0Qrxr+WyUXjVHlhrJVkkVD7v3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lX9WbVdzOEYLR7Q0mMJMRuhV/EE7SGpO4lXR/an4EwFfAEqyFvFMu+KNFhlPdA0dN
	 EkhtXd0PwpiASA8uLFIpVsKetu2Xw+B+d8pKyETrDGqOE0cmCmkES8Xm0/0w0DpqNC
	 LwPVsJIO423jg0mVkWW/0y7eJyI3mQH17OyFcu2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCMTPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfCMTP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:15:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F112075C;
        Wed, 13 Mar 2019 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504526;
        bh=rwFtV5ZE5ddOjB4kg0Qrxr+WyUXjVHlhrJVkkVD7v3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fiu1CLRBaWFoQqnMpzlfowdkLS5uUAIADrQLnsB8y7sdeQkpdFOjbW0lBGqBbgrY5
         RxhxcltrSz72g6vq9KplPNWyexybkERVqTzMYt2kT5q9PVDPyOeQUNPymzkplOv/+O
         YLt3wtGGAppUrjIH7tpZbZ9ze5MB3YF/l1MATlWY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 06/33] assoc_array: Fix shortcut creation
Date:   Wed, 13 Mar 2019 15:14:39 -0400
Message-Id: <20190313191506.159677-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
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
index 4e53be8bc590..9463d3445ccd 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -781,9 +781,11 @@ static bool assoc_array_insert_into_terminal_node(struct assoc_array_edit *edit,
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

