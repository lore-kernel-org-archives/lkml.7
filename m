Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BCC28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BEE25919
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 12:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="U3p0Rwbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfE3M4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 08:56:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34036 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3M4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 08:56:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id h1so6779227qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=m11j/gNOc1w/3oqxOsmN4bOzC/13TvTUCwPbj99AGq4=;
        b=U3p0Rwbu3DOqRwv1KFoktsVBmhSaEGhbclQX96bGWiPXbTevw90DCpH9+C8OhcOg5c
         R2T0jNdN85kqdEv5h294CX8GDP0nJTdflA2WkjQ6nQoCndHvsDebT5oRxUwQP2rkNm/N
         cZlKArDW975ct+mpI/fb3R0ncTV3ePAs8qu6PBxwkZne1JhNKhw6Kr6oGHUKEDg4RTP4
         vk+xQJw4z19QtHG5f3MRgfFR5p5ZQaRIVkb6fDP+djOPO3lrL+8Kh6ROez/+xtrEMvv6
         ybBxxg6zuZvy7co5sNwvy03NtCoZ0CYjMaln3YfYQX9hrJEm0AfnV1dS4+1xyi9gKNgm
         nyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m11j/gNOc1w/3oqxOsmN4bOzC/13TvTUCwPbj99AGq4=;
        b=S3g89mHiju7qtqzX4bFaMzR84Q7SMkfwSWYWdObUNJUFULCf4h96MCkTauJT+qfCqy
         f74I6aqYAK69y1qvB1l1DXwq8p5V5lZTa1xH16eEBDILRrZUW6W6uyM573yrpsgPEQDq
         0qUxSRjpDEOZw+e+GtWBYWhE/58rvWOXax/t7S3NjfnNLHL8zRQGBABz2k0UVk9JY+By
         UVwG70rN9b38Aic6T++KOf3B4CLvarteW9f/qWJMrdts3sxCBv3fzWeIc1rlLKXs6cae
         S9QyVeKxnDrTvIgi86sm2sqt6673GOL7T34s4RA9U12IO18tlxHjcP6bCbnjbMKaRq1z
         ljIA==
X-Gm-Message-State: APjAAAW8AhEY5jGn0rWRzkT3tV34f6xx9sBbCG8cCt6xDFgaPyshqttZ
        6UYs9tHE2cobuGRunCcguFL9qw==
X-Google-Smtp-Source: APXvYqw/80cpKy1geLrXhFGd8uOHZgCtfnZyLJaTqr/FkVp7JyBWsQ16MRrRQMC9MgVB5/OPyuItfQ==
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr2011877qvo.173.1559220975275;
        Thu, 30 May 2019 05:56:15 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 22sm1532601qto.92.2019.05.30.05.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 05:56:14 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     vitalywool@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/z3fold: fix variable set but not used warnings
Date:   Thu, 30 May 2019 08:55:52 -0400
Message-Id: <1559220952-21081-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit f41a586ddc2d ("z3fold: add inter-page compaction")
introduced a few new compilation warnings.

mm/z3fold.c: In function 'compact_single_buddy':
mm/z3fold.c:781:16: warning: variable 'newpage' set but not used
[-Wunused-but-set-variable]
mm/z3fold.c:752:13: warning: variable 'bud' set but not used
[-Wunused-but-set-variable]

It does not seem those variables are actually used, so just remove them.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/z3fold.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 2bc3dbde6255..67c29101ffc5 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -749,7 +749,6 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
 	void *p = zhdr;
 	unsigned long old_handle = 0;
-	enum buddy bud;
 	size_t sz = 0;
 	struct z3fold_header *new_zhdr = NULL;
 	int first_idx = __idx(zhdr, FIRST);
@@ -761,24 +760,20 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	 * the page lock is already taken
 	 */
 	if (zhdr->first_chunks && zhdr->slots->slot[first_idx]) {
-		bud = FIRST;
 		p += ZHDR_SIZE_ALIGNED;
 		sz = zhdr->first_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[first_idx];
 	} else if (zhdr->middle_chunks && zhdr->slots->slot[middle_idx]) {
-		bud = MIDDLE;
 		p += zhdr->start_middle << CHUNK_SHIFT;
 		sz = zhdr->middle_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[middle_idx];
 	} else if (zhdr->last_chunks && zhdr->slots->slot[last_idx]) {
-		bud = LAST;
 		p += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
 		sz = zhdr->last_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[last_idx];
 	}
 
 	if (sz > 0) {
-		struct page *newpage;
 		enum buddy new_bud = HEADLESS;
 		short chunks = size_to_chunks(sz);
 		void *q;
@@ -787,7 +782,6 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		if (!new_zhdr)
 			return NULL;
 
-		newpage = virt_to_page(new_zhdr);
 		if (WARN_ON(new_zhdr == zhdr))
 			goto out_fail;
 
-- 
1.8.3.1

