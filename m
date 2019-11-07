Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE47AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00E421D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfKGTOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:14:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfKGTOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:14:53 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9F5F37F73
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 19:14:52 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id h39so3787643qth.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Db1sKYv4li8Fx0mnSJRg6cnhmGpTf7bM9BzTT3nWzCw=;
        b=ap2KMxrj0v7Mic90RBPgPOGPPxQaxCLcgb4sZuFWTtWEFC8cL5sQy2kRUVKdEK2UC2
         PvquAmswYunQ12ltszf1WlrffwqYVYph2m4m3EaWOokekVHZh2m+/JxDQhh5pggwFrOy
         IGSDpzURglInfp8VOVCj4VybwjF8XjtUiuOwCRYF1bmSibEgI/UvNbRt3L3i005R1JiT
         mGKy9xgsZWZMMz9BQq+LvubX4bq8JYkB/uxGkklCY+A9TX1OAS3PMJcGECRnyKFacrj0
         Xj/82JNDTS9FPNy6vUh+QQ/ozAM+BMecxlBTejrvQ/cJimYyxAaxv4WE8aSyRl8/EItF
         X5FQ==
X-Gm-Message-State: APjAAAWFeOc1ZlbY0SiZN0GA21UA642YaNZgrrv+bf7XFbnfeZugssid
        bZGYO24IJ3k3sEo6LCuPMu4i43zgUQUCTGrXEMAtzfrdQAZUmMYcIOG7qupm8ScD71jG9t7ULk7
        wX8UbAaARBBJzpvv6MZZeMKJA
X-Received: by 2002:ac8:22d9:: with SMTP id g25mr5690580qta.238.1573154092087;
        Thu, 07 Nov 2019 11:14:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1HSOtXnTHcrA8WP6hedLySfPxynCtPMQPvXsizGqr/cCfleY+sFvwfvz/I1vijoKir9RTqw==
X-Received: by 2002:ac8:22d9:: with SMTP id g25mr5690533qta.238.1573154091808;
        Thu, 07 Nov 2019 11:14:51 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id l14sm1604372qkj.61.2019.11.07.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:14:50 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/test_meminit.c: Add bulk alloc/free tests
Date:   Thu,  7 Nov 2019 14:14:47 -0500
Message-Id: <20191107191447.23058-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


kmem_cache_alloc_bulk/kmem_cache_free_bulk are used to
make multiple allocations of the same size to avoid the
overhead of multiple kmalloc/kfree calls. Extend the kmem_cache
tests to make some calls to these APIs.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 lib/test_meminit.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 9729f271d150..20f330948b92 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -183,6 +183,9 @@ static bool __init check_buf(void *buf, int size, bool want_ctor,
 	return fail;
 }
 
+#define BULK_SIZE 100
+static void *bulk_array[BULK_SIZE];
+
 /*
  * Test kmem_cache with given parameters:
  *  want_ctor - use a constructor;
@@ -203,9 +206,24 @@ static int __init do_kmem_cache_size(size_t size, bool want_ctor,
 			      want_rcu ? SLAB_TYPESAFE_BY_RCU : 0,
 			      want_ctor ? test_ctor : NULL);
 	for (iter = 0; iter < 10; iter++) {
+		/* Do a test of bulk allocations */
+		if (!want_rcu && !want_ctor) {
+			int ret;
+
+			ret = kmem_cache_alloc_bulk(c, alloc_mask, BULK_SIZE, bulk_array);
+			if (!ret) {
+				fail = true;
+			} else {
+				int i;
+				for (i = 0; i < ret; i++)
+					fail |= check_buf(bulk_array[i], size, want_ctor, want_rcu, want_zero);
+				kmem_cache_free_bulk(c, ret, bulk_array);
+			}
+		}
+
 		buf = kmem_cache_alloc(c, alloc_mask);
 		/* Check that buf is zeroed, if it must be. */
-		fail = check_buf(buf, size, want_ctor, want_rcu, want_zero);
+		fail |= check_buf(buf, size, want_ctor, want_rcu, want_zero);
 		fill_with_garbage_skip(buf, size, want_ctor ? CTOR_BYTES : 0);
 
 		if (!want_rcu) {
-- 
2.21.0

