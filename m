Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C7520673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gzrZL23T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfJHNlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:41:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42651 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:41:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so16749714qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QnyLnvGAcx9kjpc3HCZ8Vnq/dzsuUJCJ33fI/g9/tOc=;
        b=gzrZL23Tkk1b+YphyrvY/WJDNeV6J40/ra1E3pWhmw/cxEOf6YQFAOYaKXWJFLW1DE
         OzPRrzEhyXzxxmwSY24Kiy94vWfyK8Qb36nCaanYdnnf9YWTacwtD0jIYAXN8rLgA0g/
         0CzFdmgxmzr6GXIsFcjFyEJ8UUaqDk6PaYFWoFMXvzr7UmNstkt6tAwqTuqMBK8ixSU1
         A7QCsgmG6w6qQUSg//n48hL5EHvf2TYOGl/5whJZeP7xB+gSpNRpTkHlR/ptSEGzqRJR
         VY3B6dHqBzL56tndP+WQeXqdZM0yabViZt9NGM/lqgZizpbos45C+EVadqEINVl7OXdv
         vD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QnyLnvGAcx9kjpc3HCZ8Vnq/dzsuUJCJ33fI/g9/tOc=;
        b=fJmvjm6kRO+Xa/A7vjnOpS4rmyxWjf4QPaJjUooMFY2lwFsHc9nuRI12EfPdfdQtJM
         BWCYVVCM9FDPJE3dIq5hugdbS9lvhklgsM9up3gjxV3vRsL9asHn0jRGOGHUby5So1yT
         OdJcnRc7vlD01ECuW1Ruh5y/SnWevMJxMWZxMrTW4M4pvIrC02FaSFeKdkKRLNNsaRmL
         zK/HaK5psKpziVvHlfidtxrOdBqB3KU69FPtZ7rHeZlBo1R06qX8XLcCjlOMEHvwtTUG
         Rcp7aB30vv7g4X/8sFe6Kqj0TVgKfj+CHLs5cXlk12Jl//rVbrd1STcmrUyFyIMyOmgI
         G1Qg==
X-Gm-Message-State: APjAAAUBRvYPuQZ1X38c+eNAkD2RZIerA1QT0UHiTscCC6nMyQrSvpaW
        hlMNLV1JaZOUE0mDVTuLr5WcqA==
X-Google-Smtp-Source: APXvYqwzZmNVMlZftb8sNlA///WKChp/vBiPYVwiSCkAByIzuJ9Fp6ka4j7O0KNiMsuKyA8lSYgJAw==
X-Received: by 2002:a37:52d5:: with SMTP id g204mr29297331qkb.44.1570542073391;
        Tue, 08 Oct 2019 06:41:13 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b1sm7775109qtr.17.2019.10.08.06.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:41:12 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/z3fold: fix -Wunused-but-set-variable warnings
Date:   Tue,  8 Oct 2019 09:41:02 -0400
Message-Id: <1570542062-29144-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "mm/z3fold.c: add inter-page compaction" [1]
introduced a few GCC compilation warnings.

mm/z3fold.c: In function 'compact_single_buddy':
mm/z3fold.c:693:16: warning: variable 'newpage' set but not used
[-Wunused-but-set-variable]
   struct page *newpage;
                ^~~~~~~
mm/z3fold.c:664:13: warning: variable 'bud' set but not used
[-Wunused-but-set-variable]
  enum buddy bud;
             ^~~
Simply remove those seems accidentally left-over code.

[1] http://lkml.kernel.org/r/20191006041457.24113-1-vitalywool@gmail.com

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/z3fold.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 25713a4a7186..d48d0ec3bcdd 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -661,7 +661,6 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
 	void *p = zhdr;
 	unsigned long old_handle = 0;
-	enum buddy bud;
 	size_t sz = 0;
 	struct z3fold_header *new_zhdr = NULL;
 	int first_idx = __idx(zhdr, FIRST);
@@ -673,24 +672,20 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
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
@@ -699,7 +694,6 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		if (!new_zhdr)
 			return NULL;
 
-		newpage = virt_to_page(new_zhdr);
 		if (WARN_ON(new_zhdr == zhdr))
 			goto out_fail;
 
-- 
1.8.3.1

