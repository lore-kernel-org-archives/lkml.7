Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F80C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7892D208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 02:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ma9O5fXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfG0CUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 22:20:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36296 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfG0CUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 22:20:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so25573078pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZrwaYoCn3Oa5vy8oyC7jdypM5mKZRDl93hGh4wsUvE4=;
        b=ma9O5fXbogmpqPpeHxMnnBuHH1xMjChxOfOggB81iBysbQqqcA9LnoCgOu+6EVAl78
         HwKwRq0MRR9FQmyN8Kf9rIUFd6zTbWd1w3XpxQvT3XmWZAky5mOGvgluapxHy4nHpshd
         qnNz+7hhBrzQJ9d4If82qYEkI/wH882jptC9yCw3MKmI08E2uFOL4P3INJgXFR/o++Qt
         lf4b8oq9cA/HZRz4WzoR0ZGPmpmRGcMASL0mHbhahXz6wkTg6FNm336ontQGrmSx3Fyb
         epEXxvxU8QbBdnF3Wy549YS3jIBnx8h1haFwA8TACMf08clBgQT7Eg09uJ/NK2caV1iP
         loXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZrwaYoCn3Oa5vy8oyC7jdypM5mKZRDl93hGh4wsUvE4=;
        b=SEojSeSkuSJWUOG8wDOqvlrQZssJZQVeRiywLeDbFK7JzRZVC/NQ/ywEomCCrymKkl
         U6/hoI8bpf4Xi5s5AyfJSp6/ZpxYlvKJoyjaTyz2l/G9QpWl4gqEJgENfz3zLntsvA/1
         W1Z+ZrsQ7KWnxTl6Dgzgm2aaX0tl1ZSGVQ8GWaYEZK+l5DOQoO0/3ZHRTFIzU4Tukj0t
         VTuY8jUeNgh0s0I8xFQ6t+ebngAZgjFnjFEyRAVq0Ry10r6R9xAkwAeY0yzAUtHonBbX
         aRKAAo2x8Jc9AfyUvh+nEf+5o/cmYKJBauQHaOlUOHNI8bh/QR9EQL3F3bssh9O2pRGF
         MOaQ==
X-Gm-Message-State: APjAAAWFwSQq4Pm6i0OONqaLY3AdCVA8/GdeTsK5OTtCKpd7DeIDOpdR
        r/AVqksPRRQEwc9/zQDjHyWnUA==
X-Google-Smtp-Source: APXvYqx8RNwdivO6m7Phuwygi/omqcBRfWbF405BsbhWrUAoshgA6onLniab8rqb9hrX6bJvtqfYhw==
X-Received: by 2002:a63:f401:: with SMTP id g1mr96877140pgi.314.1564194030656;
        Fri, 26 Jul 2019 19:20:30 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id n7sm63335884pff.59.2019.07.26.19.20.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 19:20:29 -0700 (PDT)
Date:   Fri, 26 Jul 2019 19:20:27 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190727022027.GA86863@google.com>
References: <20190703040156.56953-1-walken@google.com>
 <20190703040156.56953-3-walken@google.com>
 <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
 <20190726184419.37adea1e227fc793c32427be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726184419.37adea1e227fc793c32427be@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 06:44:19PM -0700, Andrew Morton wrote:
> On Mon, 8 Jul 2019 05:24:09 -0700 Michel Lespinasse <walken@google.com> wrote:
> 
> > Syncing up with v5.2, I see that there is a new use for augmented
> > rbtrees in mm/vmalloc.c which does not compile after applying my
> > patchset.
> > 
> > It's an easy fix though:
> 
> It still doesn't build.
> 
> lib/rbtree_test.c: In function check_augmented:
> lib/rbtree_test.c:225:35: error: implicit declaration of function augment_recompute [-Werror=implicit-function-declaration]
>    WARN_ON_ONCE(node->augmented != augment_recompute(node));

grumpf, sorry about that. I thought I had rbtree_test enabled in my
build, but turned out I only had interval_tree_test :/

I would suggest the following fix, which reintroduces the code to compute
node->augmented as was previously done in augment_recompute():

----------- 8< ----------------

After introducing RB_DECLARE_CALLBACKS_MAX, we do not need the
augment_recompute function to recompute node->augmented during
rbtree rebalancing callbacks. However, this function was also
used in check_augmented() to verify that node->augmented was
correctly set, so we need to reintroduce the code for that check.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 lib/rbtree_test.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 1939419ba869..41ae3c7570d3 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -222,7 +222,20 @@ static void check_augmented(int nr_nodes)
 	check(nr_nodes);
 	for (rb = rb_first(&root.rb_root); rb; rb = rb_next(rb)) {
 		struct test_node *node = rb_entry(rb, struct test_node, rb);
-		WARN_ON_ONCE(node->augmented != augment_recompute(node));
+		u32 subtree, max = node->val;
+		if (node->rb.rb_left) {
+			subtree = rb_entry(node->rb.rb_left, struct test_node,
+					   rb)->augmented;
+			if (max < subtree)
+				max = subtree;
+		}
+		if (node->rb.rb_right) {
+			subtree = rb_entry(node->rb.rb_right, struct test_node,
+					   rb)->augmented;
+			if (max < subtree)
+				max = subtree;
+		}
+		WARN_ON_ONCE(node->augmented != max);
 	}
 }
 
-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
