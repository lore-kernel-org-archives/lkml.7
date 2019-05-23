Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C60C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3DA20856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hu4ic74M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfEWUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:04:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47076 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfEWUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:04:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so10850799edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R9lnEivA0vSTCYlaSnEP+1dqE4I56DJXM0BNqlsp4vo=;
        b=Hu4ic74MEt+nkeIQo/00GhwVT8ats2qb/xwZDyY1jQKBfbEskxUGyHP0wd2Y9Bpuyo
         fOAOHcvydAiCHdSeKJcPxtJahKGCyyJm8wglHeQ83pSBQMwj+ER7EPSUcdAm4V8ucKeL
         OWaBI0YZl8+bs5Qu55iD7ZA5kxFl7xFSXYRrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R9lnEivA0vSTCYlaSnEP+1dqE4I56DJXM0BNqlsp4vo=;
        b=i13dbkZ3YSKdmUtNSXODH2RPrfdf41ZFNaJlnqT2b/P1yujDFSeTxgBo4s6iJAEK7j
         Anm+gHtN+kNZVaAjpG1z0b7BiDypF3NfN3+dHeeAfg/xrVzYEOGSsCg+qgkxaDvMjZJR
         JBAXIaPwV5Lo3OpIiy1MxscQLDiRCObMZMN+abTGIDm+nbUvKk8aRcKqUxIUAH4wvJj7
         5i7WlC+dXYyZTvNH4omGwhN2B+osiHEW2FUeFgKJ7XtopCR5cB3W5q+V+I0nMZQHg1jX
         Yr7fegGuifUoEsHWIdNn8RloCKh/brHzhqTK+lEE57vKUueo5MYAYBT7hhvmKrsQCqpC
         elTg==
X-Gm-Message-State: APjAAAX5RZO0+kpIhIoM8T0bWZPXa5ndCj6SCiRbXgqtTnucBtfcDaYH
        vvfXg0ACaHH+9lhx02Bfb4/8OA==
X-Google-Smtp-Source: APXvYqxcavWV9IkAVIyu4F30EENWDdifmBk61KZW1dvW6KulIOgYeihR97FaCJgaDhG0+dsXGcgtGQ==
X-Received: by 2002:a17:906:1ed1:: with SMTP id m17mr32146998ejj.213.1558641877646;
        Thu, 23 May 2019 13:04:37 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id h9sm130745edb.80.2019.05.23.13.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:04:37 -0700 (PDT)
Subject: Re: [PATCH] lib/sort: Add the sort_r() variant
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     George Spelvin <lkml@sdf.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>, kernel@collabora.com
References: <20190522112550.31814-1-boris.brezillon@collabora.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <bc3f2b9b-627f-bcc7-c16d-391a962258c0@rasmusvillemoes.dk>
Date:   Thu, 23 May 2019 22:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522112550.31814-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2019 13.25, Boris Brezillon wrote:
> Some users might need extra context to compare 2 elements. This patch
> adds the sort_r() which is similar to the qsort_r() variant of qsort().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Hello,
> 
> A few more details about this patch.
> 
> Even though I post it as a standalone patch, I do intend to use it in
> a real driver (v4l2 driver), just didn't want to have it burried in a
> huge patch series.
> 
> Note that sort() and sort_r() are now implemented as wrappers around
> do_sort() so that most of the code can be shared. I initially went for
> a solution that implemented sort() as a wrapper around sort_r() (which
> basically contained the do_sort() logic without the cmp_func arg)
> but realized this was adding one extra indirect call (the compare func
> wrapper), which I know are being chased.

Hm, I don't like the "pass one or the other, but not both". Yes, the
direct way to implement sort() in terms of sort_r would be

cmp_wrapper(void *a, void *b, void *priv)
{ return ((cmp_func_t)priv)(a, b); }

void sort(...) { sort_r(...., cmp_wrapper, cmp_func); }

but it's easy enough to get rid of that extra indirect call similar to
how the swap functions are done: pass a sentinel value, and use a single
(highly predictable) branch to check whether we have an old-style cmp
function.

[Are there actually any architectures where passing a third argument to
a function just expecting two would not Just Work? I.e., could one
simply cast a new-style comparison function to an old-style and pass
NULL as priv? Well, we'd better not go down that road.]

So I propose this somewhat simpler (at least in terms of diffstat)
patch, which also fits nicely with some optimizations I plan on doing to
eliminate "trivial" comparison functions (those that just do a single
integer comparison of some field inside the structs). Sorry if it's
whitespace-damaged. I also wonder if one should make the priv argument
void* instead of const void*, to help avoid mixing up the elements with
the context, but the function should be pure, so I'm inclined to stick
with the three const void* args.

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
index 50855ea8c262..8737d47d87bf 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -141,6 +141,18 @@ static void do_swap(void *a, void *b, size_t size,
swap_func_t swap_func)
 		swap_func(a, b, (int)size);
 }

+typedef int (*cmp_func_t)(const void *, const void *);
+typedef int (*cmp_r_func_t)(const void *, const void *, const void *);
+#define CMP_WRAPPER ((cmp_r_func_t)1L)
+
+static int do_cmp(const void *a, const void *b,
+		  cmp_r_func_t cmp, const void *priv)
+{
+	if (cmp == CMP_WRAPPER)
+		return ((cmp_func_t)(priv))(a, b);
+	return cmp(a, b, priv);
+}
+
 /**
  * parent - given the offset of the child, find the offset of the parent.
  * @i: the offset of the heap element whose parent is sought.  Non-zero.
@@ -168,12 +180,13 @@ static size_t parent(size_t i, unsigned int lsbit,
size_t size)
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
@@ -185,9 +198,10 @@ static size_t parent(size_t i, unsigned int lsbit,
size_t size)
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
@@ -235,12 +249,12 @@ void sort(void *base, size_t num, size_t size,
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
@@ -249,4 +263,12 @@ void sort(void *base, size_t num, size_t size,
 		}
 	}
 }
+EXPORT_SYMBOL(sort_r);
+
+void sort(void *base, size_t num, size_t size,
+	    int (*cmp_func)(const void *, const void *),
+	    void (*swap_func)(void *, void *, int size))
+{
+	return sort_r(base, num, size, CMP_WRAPPER, swap_func, cmp_func);
+}
 EXPORT_SYMBOL(sort);

