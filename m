Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C3920861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZGxR+ugY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfFQVPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:15:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38722 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:15:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so16004614edo.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZDxxaeRX/bbbKQK/+gLiFIFQFTZQDwL7/VO4UlgDCw=;
        b=ZGxR+ugY3+4INr6jRBUTuc5uRXTLTy/Oa9zAb4Qi64XocTYMSTw0OJUJ29g5VcYTtb
         eB8ksK3qLyCehpyCtl1W3L84wX0G7Wfgnq1S01iTki9KcImQVMMyp91P3CTuK5H+LGSJ
         aT5jD1ZL/xRN8yJc+Jh11HDmFx2wZ/sBu3WEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZDxxaeRX/bbbKQK/+gLiFIFQFTZQDwL7/VO4UlgDCw=;
        b=d61+LTMxOmuvtQoVvenwOPAKKdIks7gNDxf+arM0giaT2p6ofCxzqhK6MA+zdnL2Tk
         6p1xBXgKJwD/YMQBLOXBDBzg4b2vE4aOcbesiTuFk+uM2Fyw7QvgHQNDcbj14+n9Yp0U
         FvDYFjTBtNXisTc0bBRPhPS2FFe8doQFYFbZQamu0JT75hbcivLa35Ucr37AFHMH7Qxk
         WoOTZiM67AltrX0jmByykMCvlucUMTSW2s05AAQxNzsnQhMo1lxd/DHV+yjCNKlXYNPL
         IkfbTGyjvjurCk22/gDclj7+jBwHf1KJIROUCBTbIG9YVcbQaJOiAUxWQUKuLlliiver
         53Kg==
X-Gm-Message-State: APjAAAWDmI8VAisgyVscwE0S0pHK7+ylLVQmuHNVht8gO48aCJINN7qS
        mDs6aXbPW30sPAbrlz9VgUkmwEfgN8URE8bc
X-Google-Smtp-Source: APXvYqxt/AjYRR0YDCif3F62Fj+G9sG40nyxgHiFQXB0c5uq+XQBkrmLX5eeacakMEoKtGke8vV38A==
X-Received: by 2002:aa7:d30d:: with SMTP id p13mr38975019edq.292.1560806098144;
        Mon, 17 Jun 2019 14:14:58 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id u9sm2675399edm.71.2019.06.17.14.14.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 14:14:57 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        George Spelvin <lkml@sdf.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/sort.c: implement sort() variant taking context argument
Date:   Mon, 17 Jun 2019 23:14:52 +0200
Message-Id: <20190617211453.31928-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617155125.62da2946@collabora.com>
References: <20190617155125.62da2946@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our list_sort() utility has always supported a context argument that
is passed through to the comparison routine. Now there's a use case
for the similar thing for sort().

This implements sort_r by simply extending the existing sort function
in the obvious way. To avoid code duplication, we want to implement
sort() in terms of sort_r(). The naive way to do that is

static int cmp_wrapper(const void *a, const void *b, const void *ctx)
{
  int (*real_cmp)(const void*, const void*) = ctx;
  return real_cmp(a, b);
}

sort(..., cmp) { sort_r(..., cmp_wrapper, cmp) }

but this would do two indirect calls for each comparison. Instead, do
as is done for the default swap functions - that only adds a cost of a
single easily predicted branch to each comparison call.

Aside from introducing support for the context argument, this also
serves as preparation for patches that will eliminate the indirect
comparison calls in common cases.

Requested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Hi Boris

Sorry, completely dropped the ball on this one. Here's a formal patch
with change log. I won't have time to do the other changes I mention
this side of the merge window, so it's perfectly fine if you carry
this as part of your series. It's only been tested by booting a kernel
in qemu with CONFIG_TEST_SORT=y, and nothing exploded.

 include/linux/sort.h |  5 +++++
 lib/sort.c           | 34 ++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/linux/sort.h b/include/linux/sort.h
index 2b99a5dd073d..61b96d0ebc44 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -4,6 +4,11 @@
 
 #include <linux/types.h>
 
+void sort_r(void *base, size_t num, size_t size,
+	    int (*cmp)(const void *, const void *, const void *),
+	    void (*swap)(void *, void *, int),
+	    const void *priv);
+
 void sort(void *base, size_t num, size_t size,
 	  int (*cmp)(const void *, const void *),
 	  void (*swap)(void *, void *, int));
diff --git a/lib/sort.c b/lib/sort.c
index cf408aec3733..36fcc2040be5 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -144,6 +144,18 @@ static void do_swap(void *a, void *b, size_t size, swap_func_t swap_func)
 		swap_func(a, b, (int)size);
 }
 
+typedef int (*cmp_func_t)(const void *, const void *);
+typedef int (*cmp_r_func_t)(const void *, const void *, const void *);
+#define _CMP_WRAPPER ((cmp_r_func_t)0L)
+
+static int do_cmp(const void *a, const void *b,
+		  cmp_r_func_t cmp, const void *priv)
+{
+	if (cmp == _CMP_WRAPPER)
+		return ((cmp_func_t)(priv))(a, b);
+	return cmp(a, b, priv);
+}
+
 /**
  * parent - given the offset of the child, find the offset of the parent.
  * @i: the offset of the heap element whose parent is sought.  Non-zero.
@@ -171,12 +183,13 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
 }
 
 /**
- * sort - sort an array of elements
+ * sort_r - sort an array of elements
  * @base: pointer to data to sort
  * @num: number of elements
  * @size: size of each element
  * @cmp_func: pointer to comparison function
  * @swap_func: pointer to swap function or NULL
+ * @priv: third argument passed to comparison function
  *
  * This function does a heapsort on the given array.  You may provide
  * a swap_func function if you need to do something more than a memory
@@ -188,9 +201,10 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
  * O(n*n) worst-case behavior and extra memory requirements that make
  * it less suitable for kernel use.
  */
-void sort(void *base, size_t num, size_t size,
-	  int (*cmp_func)(const void *, const void *),
-	  void (*swap_func)(void *, void *, int size))
+void sort_r(void *base, size_t num, size_t size,
+	    int (*cmp_func)(const void *, const void *, const void *),
+	    void (*swap_func)(void *, void *, int size),
+	    const void *priv)
 {
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
@@ -238,12 +252,12 @@ void sort(void *base, size_t num, size_t size,
 		 * average, 3/4 worst-case.)
 		 */
 		for (b = a; c = 2*b + size, (d = c + size) < n;)
-			b = cmp_func(base + c, base + d) >= 0 ? c : d;
+			b = do_cmp(base + c, base + d, cmp_func, priv) >= 0 ? c : d;
 		if (d == n)	/* Special case last leaf with no sibling */
 			b = c;
 
 		/* Now backtrack from "b" to the correct location for "a" */
-		while (b != a && cmp_func(base + a, base + b) >= 0)
+		while (b != a && do_cmp(base + a, base + b, cmp_func, priv) >= 0)
 			b = parent(b, lsbit, size);
 		c = b;			/* Where "a" belongs */
 		while (b != a) {	/* Shift it into place */
@@ -252,4 +266,12 @@ void sort(void *base, size_t num, size_t size,
 		}
 	}
 }
+EXPORT_SYMBOL(sort_r);
+
+void sort(void *base, size_t num, size_t size,
+	    int (*cmp_func)(const void *, const void *),
+	    void (*swap_func)(void *, void *, int size))
+{
+	return sort_r(base, num, size, _CMP_WRAPPER, swap_func, cmp_func);
+}
 EXPORT_SYMBOL(sort);
-- 
2.20.1

