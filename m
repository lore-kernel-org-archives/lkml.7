Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF3C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A20208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564191863;
	bh=aTBZ5M1seZ2gARSGojfCgMkCIsMPIkP9O8QlLyAL5ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wkNcE4CJpaKorKs2LuPVfU5xAF/oc3i2ZX+6n+1bOMOZVxnsgt+GzIRSMRAi37DUd
	 WWIuS7tiEwAtNw+bMhDobMCOvFAda22E0QDDNl2Yrh7oIL5hMkPyUQEOrFshs8SLW7
	 vgVERcUPY4b5YMKn8I6PZXUDp2eJCCRNfp/TLhfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfG0BoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 21:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfG0BoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:44:22 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31BA20659;
        Sat, 27 Jul 2019 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564191861;
        bh=aTBZ5M1seZ2gARSGojfCgMkCIsMPIkP9O8QlLyAL5ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EMACdf8LFnO0rdUoh2YJJqdAKkT1y74GYYiDezdi8ChDplEqb1rc2C9TnbSGy3r5h
         X+aNAEtjhHNOs7i6IYUfgwNY3QqNCK2FuBpF9S7a6OjlWVRWQwUu60Awq7IB+jKXsz
         CrQozuVy583/GQO0fie0uddzKSJQXol1zdM7WRUo=
Date:   Fri, 26 Jul 2019 18:44:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-Id: <20190726184419.37adea1e227fc793c32427be@linux-foundation.org>
In-Reply-To: <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
References: <20190703040156.56953-1-walken@google.com>
        <20190703040156.56953-3-walken@google.com>
        <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 05:24:09 -0700 Michel Lespinasse <walken@google.com> wrote:

> Syncing up with v5.2, I see that there is a new use for augmented
> rbtrees in mm/vmalloc.c which does not compile after applying my
> patchset.
> 
> It's an easy fix though:

It still doesn't build.

lib/rbtree_test.c: In function check_augmented:
lib/rbtree_test.c:225:35: error: implicit declaration of function augment_recompute [-Werror=implicit-function-declaration]
   WARN_ON_ONCE(node->augmented != augment_recompute(node));

I think I'll just do this:

--- a/lib/rbtree_test.c~augmented-rbtree-add-new-rb_declare_callbacks_max-macro-fix-2
+++ a/lib/rbtree_test.c
@@ -220,10 +220,6 @@ static void check_augmented(int nr_nodes
 	struct rb_node *rb;
 
 	check(nr_nodes);
-	for (rb = rb_first(&root.rb_root); rb; rb = rb_next(rb)) {
-		struct test_node *node = rb_entry(rb, struct test_node, rb);
-		WARN_ON_ONCE(node->augmented != augment_recompute(node));
-	}
 }
 
 static int __init rbtree_test_init(void)

although there may be something we can do here to restore the lost
coverage?

