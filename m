Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBF3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E2D21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888533;
	bh=qgKnA8ercINp8dTih9WIGTCvC7aWFs7CarrmJcobrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OdbXVLuo8WhhXqTtwzibmNTl0PcwAoxFePT5uI+9J2vzHXAgF+tlx3DeS7lMqh8pw
	 Rb758ybvyzCnUQmSjaQKBaq3kCZvMUUR5cq7LI+nYUVEtjrtYYewcdZei/vnMzbnue
	 ByLcg8X6VsC3q6DQm2XfHyr4jmcgQUYAP6CLXRXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfK0VCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbfK0VCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:02:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EAA2158C;
        Wed, 27 Nov 2019 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888528;
        bh=qgKnA8ercINp8dTih9WIGTCvC7aWFs7CarrmJcobrQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJNbUGRA+HnRNtLz/JfcsCnQp4g0SzS1RE8fQUZzRlcdK0hUMnxI11g+fg8D1ysPt
         qusVJv1iY1wDglGfZl+6aeI80wRwbCuGNdNldZ41rZ1yKqkRYrsbEqW+1BiF32LcdJ
         +KWjqRzHLSjHKa7TmdVY33ge6z+7QmyyFG6C32Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 169/306] lib/bitmap.c: fix remaining space computation in bitmap_print_to_pagebuf
Date:   Wed, 27 Nov 2019 21:30:19 +0100
Message-Id: <20191127203127.754467394@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit ce1091d471107dbf6f91db66a480a25950c9b9ff ]

For various alignments of buf, the current expression computes

4096 ok
4095 ok
8190
8189
...
4097

i.e., if the caller has already written two bytes into the page buffer,
len is 8190 rather than 4094, because PTR_ALIGN aligns up to the next
boundary.  So if the printed version of the bitmap is huge, scnprintf()
ends up writing beyond the page boundary.

I don't think any current callers actually write anything before
bitmap_print_to_pagebuf, but the API seems to be designed to allow it.

[akpm@linux-foundation.org: use offset_in_page(), per Andy]
[akpm@linux-foundation.org: include mm.h for offset_in_page()]
Link: http://lkml.kernel.org/r/20180818131623.8755-7-linux@rasmusvillemoes.dk
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/bitmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2fd07f6df0b85..c4ca9ceb09fe3 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -466,14 +467,15 @@ EXPORT_SYMBOL(bitmap_parse_user);
  * ranges if list is specified or hex digits grouped into comma-separated
  * sets of 8 digits/set. Returns the number of characters written to buf.
  *
- * It is assumed that @buf is a pointer into a PAGE_SIZE area and that
- * sufficient storage remains at @buf to accommodate the
- * bitmap_print_to_pagebuf() output.
+ * It is assumed that @buf is a pointer into a PAGE_SIZE, page-aligned
+ * area and that sufficient storage remains at @buf to accommodate the
+ * bitmap_print_to_pagebuf() output. Returns the number of characters
+ * actually printed to @buf, excluding terminating '\0'.
  */
 int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
 			    int nmaskbits)
 {
-	ptrdiff_t len = PTR_ALIGN(buf + PAGE_SIZE - 1, PAGE_SIZE) - buf;
+	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
 	int n = 0;
 
 	if (len > 1)
-- 
2.20.1



