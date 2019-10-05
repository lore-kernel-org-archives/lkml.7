Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860C8C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 23:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E53222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 23:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfJEXbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 19:31:16 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61938 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEXbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 19:31:16 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id EFCF6A01AE;
        Sun,  6 Oct 2019 01:31:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id bpDC7RlIpyWq; Sun,  6 Oct 2019 01:31:08 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib: test_user_copy: style cleanup
Date:   Sun,  6 Oct 2019 10:30:28 +1100
Message-Id: <20191005233028.18566-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While writing the tests for copy_struct_from_user(), I used a construct
that Linus doesn't appear to be too fond of:

On 2019-10-04, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Hmm. That code is ugly, both before and after the fix.
>
> This just doesn't make sense for so many reasons:
>
>         if ((ret |= test(umem_src == NULL, "kmalloc failed")))
>
> where the insanity comes from
>
>  - why "|=" when you know that "ret" was zero before (and it had to
>    be, for the test to make sense)
>
>  - why do this as a single line anyway?
>
>  - don't do the stupid "double parenthesis" to hide a warning. Make it
>    use an actual comparison if you add a layer of parentheses.

So instead, use a bog-standard check that isn't nearly as ugly.

Fixes: 341115822f88 ("usercopy: Add parentheses around assignment in test_copy_struct_from_user")
Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 lib/test_user_copy.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index e365ace06538..ad2372727b1b 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -52,13 +52,14 @@ static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 	size_t zero_end = size - zero_start;
 
 	/*
-	 * We conduct a series of check_nonzero_user() tests on a block of memory
-	 * with the following byte-pattern (trying every possible [start,end]
-	 * pair):
+	 * We conduct a series of check_nonzero_user() tests on a block of
+	 * memory with the following byte-pattern (trying every possible
+	 * [start,end] pair):
 	 *
 	 *   [ 00 ff 00 ff ... 00 00 00 00 ... ff 00 ff 00 ]
 	 *
-	 * And we verify that check_nonzero_user() acts identically to memchr_inv().
+	 * And we verify that check_nonzero_user() acts identically to
+	 * memchr_inv().
 	 */
 
 	memset(kmem, 0x0, size);
@@ -93,11 +94,13 @@ static int test_copy_struct_from_user(char *kmem, char __user *umem,
 	size_t ksize, usize;
 
 	umem_src = kmalloc(size, GFP_KERNEL);
-	if ((ret |= test(umem_src == NULL, "kmalloc failed")))
+	ret = test(umem_src == NULL, "kmalloc failed");
+	if (ret)
 		goto out_free;
 
 	expected = kmalloc(size, GFP_KERNEL);
-	if ((ret |= test(expected == NULL, "kmalloc failed")))
+	ret = test(expected == NULL, "kmalloc failed");
+	if (ret)
 		goto out_free;
 
 	/* Fill umem with a fixed byte pattern. */
-- 
2.23.0

