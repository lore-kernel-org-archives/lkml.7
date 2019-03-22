Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7755C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980AC20693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255346;
	bh=Zab4TPSCZLXcBCwxf3ppCvf2BTY7dPKKCAGixyBhnWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A/ZrsYX6bWjTwenSW29y9ERE76edMWBBz+Yv2jg4wE8t3U/Nvj4NxJvfylnFcN2Th
	 9FbVVL1nnHa7bAzaBGS7tTsPdDdW+RRjYMOIQLoDkQxtg0J9DJP+b7+nLM3BE4Fi4L
	 /x7sc8H8DV2+dR5vApb+ubNWVnOYsI/+8RZqQasc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfCVLtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732200AbfCVLtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199C720693;
        Fri, 22 Mar 2019 11:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255341;
        bh=Zab4TPSCZLXcBCwxf3ppCvf2BTY7dPKKCAGixyBhnWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQ5mxfi1ScfC3pc8hX8huyWwtlqQuS5vi0JWDXRu66iOhfDlfwreLnwo+915KWyGK
         bVzPpLzNlKNg2yaPh0S3ex4oYSfU3FzXakEawzYD3BwigAI5Id4MKTRgwZ+y1u/Uxq
         6O/5TQs7WgKYmLjCnGZFqtNv4JgfZP5UdlEhItQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 042/183] assoc_array: Fix shortcut creation
Date:   Fri, 22 Mar 2019 12:14:30 +0100
Message-Id: <20190322111244.781451540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 4e53be8bc590..9463d3445ccd 100644
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



