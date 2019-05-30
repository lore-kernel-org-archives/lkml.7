Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA2C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DD225D4C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLAFkJTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfE3Eu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:50:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46316 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388949AbfE3Eu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:50:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so1213430pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 21:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNjFOui7vuFEtKzXwg5aNy6ZEm6jbdXBcZyq2T1si6M=;
        b=bLAFkJTIqPVDEut/wCVyU9k9uP9Dw1+jlD0akLvS9pLrMPMZksl5uHLJxCejeJdj27
         fdNCSAOKaQXtEbTCqgxLC96UX8hw8IWJTpfh3VeQscE8J+eOi5A46oWEmZzVDb5gO9Yu
         tv7gM97I5IOUlSQXxfAwAs+GLLp054KalnBrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNjFOui7vuFEtKzXwg5aNy6ZEm6jbdXBcZyq2T1si6M=;
        b=YyB2gktr/2fNAz71YhRIDBrf5ZHniJVfM+Z30VQspVBIaEltd4zxkiI3jx6LbiY3p3
         cshnf3KdKI/qwyVfWhI63M0meCaKz2AdsRGnXCYY43us5N60Qvr9WigJ2RF/9ns1Cdit
         r/mcV5bMhSxUb47AmsWgmk7wMrL5Hn0LL0w75aAlMHkBwgbNCdUjn2k3d1bTDLQGWXBD
         1EQfdnsNhABPU/vPKFePrkmbn7dc+deXzSD0RIf/2Wy5BagGoe391oDEmeZ/6qTqY8VB
         Rp93hINMA7ZqG/xNvp9lUSiF2E/HXLFteDft7yMl5msNjn/a62qzfQ6ItvsdpmRP6VVw
         6CAw==
X-Gm-Message-State: APjAAAWdS4KJXHOKdmCiOq6jqaELG3NqozKvRCIcO8aB7xDlmB3RVT63
        UeEnm26pwJW86BquOZ79qRen+g==
X-Google-Smtp-Source: APXvYqwP1CnFb/IRU8rVAJZSvTa5RJy0wsDR52/J/PPPSfS2jQkTxAG7Qw8Es+UFK9RLME6W5S2T5g==
X-Received: by 2002:aa7:9095:: with SMTP id i21mr156634pfa.119.1559191826897;
        Wed, 29 May 2019 21:50:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w12sm1361214pfj.41.2019.05.29.21.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 21:50:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3] mm/slab: Validate cache membership under freelist hardening
Date:   Wed, 29 May 2019 21:50:15 -0700
Message-Id: <20190530045017.15252-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530045017.15252-1-keescook@chromium.org>
References: <20190530045017.15252-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building under CONFIG_SLAB_FREELIST_HARDENING, it makes
sense to perform sanity-checking on the assumed slab cache during
kmem_cache_free() to make sure the kernel doesn't mix freelists across
slab caches and corrupt memory (as seen in the exploitation of flaws like
CVE-2018-9568[1]). Note that the prior code might WARN() but still corrupt
memory (i.e. return the assumed cache instead of the owned cache).

There is no noticeable performance impact (changes are within noise).
Measuring parallel kernel builds, I saw the following with
CONFIG_SLAB_FREELIST_HARDENED, before and after this patch:

before:

	Run times: 288.85 286.53 287.09 287.07 287.21
	Min: 286.53 Max: 288.85 Mean: 287.35 Std Dev: 0.79

after:

	Run times: 289.58 287.40 286.97 287.20 287.01
	Min: 286.97 Max: 289.58 Mean: 287.63 Std Dev: 0.99

Delta: 0.1% which is well below the standard deviation

[1] https://github.com/ThomasKing2014/slides/raw/master/Building%20universal%20Android%20rooting%20with%20a%20type%20confusion%20vulnerability.pdf

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slab.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 43ac818b8592..4dafae2c8620 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -310,7 +310,7 @@ static inline bool is_root_cache(struct kmem_cache *s)
 static inline bool slab_equal_or_root(struct kmem_cache *s,
 				      struct kmem_cache *p)
 {
-	return true;
+	return s == p;
 }
 
 static inline const char *cache_name(struct kmem_cache *s)
@@ -363,18 +363,16 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 	 * will also be a constant.
 	 */
 	if (!memcg_kmem_enabled() &&
+	    !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
 	    !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
 		return s;
 
 	page = virt_to_head_page(x);
 	cachep = page->slab_cache;
-	if (slab_equal_or_root(cachep, s))
-		return cachep;
-
-	pr_err("%s: Wrong slab cache. %s but object is from %s\n",
-	       __func__, s->name, cachep->name);
-	WARN_ON_ONCE(1);
-	return s;
+	WARN_ONCE(!slab_equal_or_root(cachep, s),
+		  "%s: Wrong slab cache. %s but object is from %s\n",
+		  __func__, s->name, cachep->name);
+	return cachep;
 }
 
 static inline size_t slab_ksize(const struct kmem_cache *s)
-- 
2.17.1

